Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683C046CC80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbhLHE3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244196AbhLHE0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C234C0698D7
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=p/v1MPFlGwVbfYsmas4PVpJ8hDUuzrJOYjz6XpsPNfA=; b=j7XgVYa7JGB4uUrwY82lww50++
        TWoEOzfjKih0daSh1t7pMCCAUT/KcnbdGe+cnlRMSYn2STHxsGZp8bDjnIjcEZccXHJ33ScGqHw3u
        MdZaS9mX5iOTWIqBuniEOCq03InAsBNLXHwNBmfuHj/mJyg7sad76LC821iIBepHApiXRW1r/ABxa
        Q3Xv5A25X4Yw9idApTa2hQ3JFqEhD2p5g3RTV/9nRLXJW9KSVJ1sdiRfkH2f94ceM5NVBYmvlD4Ky
        j48uBakB1VsJvk6TNSxk1BDBSgIZTDPiSBDm1R9zD/OKnouredPIKGwfHhEQ3+3AV7YtHDYclSeKl
        lgqgVJLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU8-0084eW-MM; Wed, 08 Dec 2021 04:23:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 47/48] XArray: Add xas_advance()
Date:   Wed,  8 Dec 2021 04:22:55 +0000
Message-Id: <20211208042256.1923824-48-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new helper function to help iterate over multi-index entries.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/xarray.h | 18 ++++++++++++++++++
 lib/xarray.c           |  6 +++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index a91e3d90df8a..d6d5da6ed735 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1580,6 +1580,24 @@ static inline void xas_set(struct xa_state *xas, unsigned long index)
 	xas->xa_node = XAS_RESTART;
 }
 
+/**
+ * xas_advance() - Skip over sibling entries.
+ * @xas: XArray operation state.
+ * @index: Index of last sibling entry.
+ *
+ * Move the operation state to refer to the last sibling entry.
+ * This is useful for loops that normally want to see sibling
+ * entries but sometimes want to skip them.  Use xas_set() if you
+ * want to move to an index which is not part of this entry.
+ */
+static inline void xas_advance(struct xa_state *xas, unsigned long index)
+{
+	unsigned char shift = xas_is_node(xas) ? xas->xa_node->shift : 0;
+
+	xas->xa_index = index;
+	xas->xa_offset = (index >> shift) & XA_CHUNK_MASK;
+}
+
 /**
  * xas_set_order() - Set up XArray operation state for a multislot entry.
  * @xas: XArray operation state.
diff --git a/lib/xarray.c b/lib/xarray.c
index f5d8f54907b4..6f47f6375808 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -157,7 +157,7 @@ static void xas_move_index(struct xa_state *xas, unsigned long offset)
 	xas->xa_index += offset << shift;
 }
 
-static void xas_advance(struct xa_state *xas)
+static void xas_next_offset(struct xa_state *xas)
 {
 	xas->xa_offset++;
 	xas_move_index(xas, xas->xa_offset);
@@ -1250,7 +1250,7 @@ void *xas_find(struct xa_state *xas, unsigned long max)
 		xas->xa_offset = ((xas->xa_index - 1) & XA_CHUNK_MASK) + 1;
 	}
 
-	xas_advance(xas);
+	xas_next_offset(xas);
 
 	while (xas->xa_node && (xas->xa_index <= max)) {
 		if (unlikely(xas->xa_offset == XA_CHUNK_SIZE)) {
@@ -1268,7 +1268,7 @@ void *xas_find(struct xa_state *xas, unsigned long max)
 		if (entry && !xa_is_sibling(entry))
 			return entry;
 
-		xas_advance(xas);
+		xas_next_offset(xas);
 	}
 
 	if (!xas->xa_node)
-- 
2.33.0

