Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A418047EC0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 07:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351566AbhLXGXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 01:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351554AbhLXGXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:23:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F8DC06175E;
        Thu, 23 Dec 2021 22:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1ZA6SbMtIHpmSD0II079fJIJ8zd661EOD54iGaKR13c=; b=nfoKrj8qAYckW193hrhVZo4674
        9t5WMiw29Yd6EfitSJSdem40ZKZWiaV5q2CEXPw1HHBAfnfeE2uTQVD8gUn4AWMN486HAb1sTNvM/
        uyFnUg0gneXMJfiWDvmwmFWBtHmjXYuAX8pBluqJ2xzJksC+AkyYBwSQcrKhnAZ9yX3jH7SkjARLs
        kx2QOY2TCUS8RuWeLbYXoDOo/QgElzWBvMCbxB5ZSz2EFzvkkyd9nfhOYHQ6Tg0d6gbfUTCFLc7wm
        BM+20rz5nzM3Hsb4vxMjKBIQRslyr/OZTe2Gf5sOJcCkMyxUl9ARVrAtfPKyWlc5IscuIe2eW7xBp
        va6bhs3g==;
Received: from p4fdb0b85.dip0.t-ipconnect.de ([79.219.11.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0dys-00Dn24-QW; Fri, 24 Dec 2021 06:23:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 06/13] frontswap: simplify frontswap_init
Date:   Fri, 24 Dec 2021 07:22:39 +0100
Message-Id: <20211224062246.1258487-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224062246.1258487-1-hch@lst.de>
References: <20211224062246.1258487-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just use IS_ENABLED() and remove the __frontswap_init indirection.
Also remove the unused export.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/frontswap.h | 9 +--------
 mm/frontswap.c            | 3 +--
 mm/swapfile.c             | 3 ++-
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/linux/frontswap.h b/include/linux/frontswap.h
index 5205c2977b208..73d7beb44f2b7 100644
--- a/include/linux/frontswap.h
+++ b/include/linux/frontswap.h
@@ -26,7 +26,7 @@ struct frontswap_ops {
 extern void frontswap_register_ops(struct frontswap_ops *ops);
 
 extern bool __frontswap_test(struct swap_info_struct *, pgoff_t);
-extern void __frontswap_init(unsigned type, unsigned long *map);
+extern void frontswap_init(unsigned type, unsigned long *map);
 extern int __frontswap_store(struct page *page);
 extern int __frontswap_load(struct page *page);
 extern void __frontswap_invalidate_page(unsigned, pgoff_t);
@@ -107,11 +107,4 @@ static inline void frontswap_invalidate_area(unsigned type)
 		__frontswap_invalidate_area(type);
 }
 
-static inline void frontswap_init(unsigned type, unsigned long *map)
-{
-#ifdef CONFIG_FRONTSWAP
-	__frontswap_init(type, map);
-#endif
-}
-
 #endif /* _LINUX_FRONTSWAP_H */
diff --git a/mm/frontswap.c b/mm/frontswap.c
index af8f68d0e5cc0..132d6ad6d70b7 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -156,7 +156,7 @@ EXPORT_SYMBOL(frontswap_register_ops);
 /*
  * Called when a swap device is swapon'd.
  */
-void __frontswap_init(unsigned type, unsigned long *map)
+void frontswap_init(unsigned type, unsigned long *map)
 {
 	struct swap_info_struct *sis = swap_info[type];
 	struct frontswap_ops *ops;
@@ -179,7 +179,6 @@ void __frontswap_init(unsigned type, unsigned long *map)
 	for_each_frontswap_ops(ops)
 		ops->init(type);
 }
-EXPORT_SYMBOL(__frontswap_init);
 
 bool __frontswap_test(struct swap_info_struct *sis,
 				pgoff_t offset)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index caa9f81a0d15f..df5930ccd93dd 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2463,7 +2463,8 @@ static void enable_swap_info(struct swap_info_struct *p, int prio,
 				struct swap_cluster_info *cluster_info,
 				unsigned long *frontswap_map)
 {
-	frontswap_init(p->type, frontswap_map);
+	if (IS_ENABLED(CONFIG_FRONTSWAP))
+		frontswap_init(p->type, frontswap_map);
 	spin_lock(&swap_lock);
 	spin_lock(&p->lock);
 	setup_swap_info(p, prio, swap_map, cluster_info);
-- 
2.30.2

