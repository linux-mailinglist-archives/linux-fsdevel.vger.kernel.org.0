Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC83F29F55A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgJ2TeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgJ2TeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC29C0613D2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UUhtRr4WBYAqjdtduicXSD66sp/VlkyNt6Q6brpQcm8=; b=rFY30l940WJWT4CO+yioGGTNoM
        ws4SktgudrmeT+d7Ir+H4S6qngvDUm0Ft0b1wDySRozUdw7NCqC1zynuOIRsPinG3QsyEs44+i+lD
        wmDl285in1amVWHBuU7RzcbTVuDGlsXllDoXNCku1/HTr/bybJIiR+2pPyE2sQDohyh2t9wTTtnBi
        6jhPCKssrdyTK0kqrprlymXvFYvVK5lnd05AGix2DdYq1zWJz94i7p0HrXehFTrwxXwEXGLKgG7mT
        gersukQZgWVZlhyUDYHTl4ISyxbGhy9UH5tnUd6P22cdS3REtoc4O9xftwd/1yY7pMFTmL55CNrHW
        ho0YeLOg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDgV-0007b4-Nz; Thu, 29 Oct 2020 19:34:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 01/19] XArray: Expose xas_destroy
Date:   Thu, 29 Oct 2020 19:33:47 +0000
Message-Id: <20201029193405.29125-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This proves to be useful functionality for the THP page cache.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/xarray.h | 1 +
 lib/xarray.c           | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 92c0160b3352..4d40279f49d1 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1503,6 +1503,7 @@ void *xas_find_marked(struct xa_state *, unsigned long max, xa_mark_t);
 void xas_init_marks(const struct xa_state *);
 
 bool xas_nomem(struct xa_state *, gfp_t);
+void xas_destroy(struct xa_state *);
 void xas_pause(struct xa_state *);
 
 void xas_create_range(struct xa_state *);
diff --git a/lib/xarray.c b/lib/xarray.c
index fb3a0ccebb7e..fc70e37c4c17 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -258,13 +258,14 @@ static void xa_node_free(struct xa_node *node)
 	call_rcu(&node->rcu_head, radix_tree_node_rcu_free);
 }
 
-/*
+/**
  * xas_destroy() - Free any resources allocated during the XArray operation.
  * @xas: XArray operation state.
  *
- * This function is now internal-only.
+ * Usually xas_destroy() is called by xas_nomem(), but some users want to
+ * unconditionally release any memory that was allocated.
  */
-static void xas_destroy(struct xa_state *xas)
+void xas_destroy(struct xa_state *xas)
 {
 	struct xa_node *next, *node = xas->xa_alloc;
 
-- 
2.28.0

