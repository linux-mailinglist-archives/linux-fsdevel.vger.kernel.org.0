Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78AD1BDEC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 15:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgD2Nhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 09:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgD2NhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:37:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106DFC09B055;
        Wed, 29 Apr 2020 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pT2PqjPu+THmksytYubIGVOFppVgVjYx+FXyGg2zfw8=; b=qs1oEvJ8FAfdZaviBHeJRqU6+f
        fXI+QmmR+ZRpvZeLHNQo8OTkqnlMeMXTUexoqrm+P3ONQpBaIr83KwhGJe6YKo2bIm3ttGsOcKsKE
        olK6QPqzd1HS0cc9EYlEoMD945qLNGWfSYzG6LoKMp4w4EWtZZBDN/MFqSiwlWjC4QzFZR5K/Nh3J
        Cy0EY3xaytBFlSNSvJt1OUgle1AdIoAG81BLkiC2TmEe7OEB8gSrG0JLDXVFvwx9i2LYpr8UAAUE9
        qfPlED1WGLP1DVOSqQmYNzBSr1wkp5dMvxbrYE8gVSQtAVjbLwXqxElI2lcWx3Mu11DWC8jiKyceH
        zxETCLkg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTmtX-0005wU-SS; Wed, 29 Apr 2020 13:36:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/25] mm: Add DEFINE_READAHEAD
Date:   Wed, 29 Apr 2020 06:36:53 -0700
Message-Id: <20200429133657.22632-22-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429133657.22632-1-willy@infradead.org>
References: <20200429133657.22632-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Allow for a more concise definition of a struct readahead_control.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 7 +++++++
 mm/readahead.c          | 6 +-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1169e2428dd7..ff5bf10829a6 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -684,6 +684,13 @@ struct readahead_control {
 	unsigned int _batch_count;
 };
 
+#define DEFINE_READAHEAD(rac, f, m, i)					\
+	struct readahead_control rac = {				\
+		.file = f,						\
+		.mapping = m,						\
+		._index = i,						\
+	}
+
 /**
  * readahead_page - Get the next page to read.
  * @rac: The current readahead request.
diff --git a/mm/readahead.c b/mm/readahead.c
index 3c9a8dd7c56c..2126a2754e22 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -179,11 +179,7 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 {
 	LIST_HEAD(page_pool);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	struct readahead_control rac = {
-		.mapping = mapping,
-		.file = file,
-		._index = index,
-	};
+	DEFINE_READAHEAD(rac, file, mapping, index);
 	unsigned long i;
 
 	/*
-- 
2.26.2

