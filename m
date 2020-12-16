Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9FD2DC65D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgLPSZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLPSZe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:25:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF63C0611D0;
        Wed, 16 Dec 2020 10:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Lh+37Y8KyiuvFgoCDHyQ0aCP7Y2/TwBl9WkEXxWh7z0=; b=Ilr6dYVaMQHYp6TmRn0m8bculR
        MXAy/gURQmO9Z2ei/x9TToif4rnD8rjQsJsc5NlmSL2FuJfMTNKyEXd0u52i5abydJW3G3jVTG611
        lEspxhuOLqlA6ilLL5dP5vN8QvuY8p8jDSFUuEeSjB4ky3SO6e2pD1syvj4nPqIyCC6xFPKr+Dt3m
        WxRIqD+48BoOE3XmJGVBZiX13zyJzlCBGolugz7lxz1aTBVJzifuM/vMqgdxwl5wzALX3QxAX3aOh
        loxiRc1uf9R6MjBwRPIjeFlykcKnPW4A5W9pKRxqAezFvut9bZGg6NZdAGHqmKsQ3kBLhS12gAtHo
        JSQ1+7nw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSg-00078B-Do; Wed, 16 Dec 2020 18:23:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/25] mm: Rename THP_SUPPORT to MULTI_PAGE_FOLIOS
Date:   Wed, 16 Dec 2020 18:23:27 +0000
Message-Id: <20201216182335.27227-18-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Using THPs was confusing everyone.  Switch to the new name of folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/inode.c              |  4 ++--
 include/linux/fs.h      |  2 +-
 include/linux/pagemap.h | 14 +++++++-------
 mm/shmem.c              |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index cb008acf0efd..2c79282803e7 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -180,8 +180,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	mapping->a_ops = &empty_aops;
 	mapping->host = inode;
 	mapping->flags = 0;
-	if (sb->s_type->fs_flags & FS_THP_SUPPORT)
-		__set_bit(AS_THP_SUPPORT, &mapping->flags);
+	if (sb->s_type->fs_flags & FS_MULTI_PAGE_FOLIOS)
+		__set_bit(AS_MULTI_PAGE_FOLIOS, &mapping->flags);
 	mapping->wb_err = 0;
 	atomic_set(&mapping->i_mmap_writable, 0);
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ad4cf1bae586..08f9a8a524f2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2231,7 +2231,7 @@ struct file_system_type {
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
-#define FS_THP_SUPPORT		8192	/* Remove once all fs converted */
+#define FS_MULTI_PAGE_FOLIOS	8192	/* Remove once all fs converted */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 88a66b65d1ed..630a0a589073 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -29,7 +29,7 @@ enum mapping_flags {
 	AS_EXITING	= 4, 	/* final truncate in progress */
 	/* writeback related tags are not used */
 	AS_NO_WRITEBACK_TAGS = 5,
-	AS_THP_SUPPORT = 6,	/* THPs supported */
+	AS_MULTI_PAGE_FOLIOS = 6,
 };
 
 /**
@@ -121,9 +121,9 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 	m->gfp_mask = mask;
 }
 
-static inline bool mapping_thp_support(struct address_space *mapping)
+static inline bool mapping_multi_page_folios(struct address_space *mapping)
 {
-	return test_bit(AS_THP_SUPPORT, &mapping->flags);
+	return test_bit(AS_MULTI_PAGE_FOLIOS, &mapping->flags);
 }
 
 static inline int filemap_nr_thps(struct address_space *mapping)
@@ -138,20 +138,20 @@ static inline int filemap_nr_thps(struct address_space *mapping)
 static inline void filemap_nr_thps_inc(struct address_space *mapping)
 {
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
-	if (!mapping_thp_support(mapping))
+	if (!mapping_multi_page_folios(mapping))
 		atomic_inc(&mapping->nr_thps);
 #else
-	WARN_ON_ONCE(1);
+	WARN_ON_ONCE(!mapping_multi_page_folios(mapping));
 #endif
 }
 
 static inline void filemap_nr_thps_dec(struct address_space *mapping)
 {
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
-	if (!mapping_thp_support(mapping))
+	if (!mapping_multi_page_folios(mapping))
 		atomic_dec(&mapping->nr_thps);
 #else
-	WARN_ON_ONCE(1);
+	WARN_ON_ONCE(!mapping_multi_page_folios(mapping));
 #endif
 }
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 53d84d2c9fe5..192b7b5a7852 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3910,7 +3910,7 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT | FS_THP_SUPPORT,
+	.fs_flags	= FS_USERNS_MOUNT | FS_MULTI_PAGE_FOLIOS,
 };
 
 int __init shmem_init(void)
-- 
2.29.2

