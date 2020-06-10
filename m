Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98A41F5CDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgFJURa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730528AbgFJUNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C5DC08C5C8;
        Wed, 10 Jun 2020 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PUB7gfbS6ya/Oo2I8iRDMBuQXcmwMzHEvRek9lLjtrk=; b=LkO1X8I4f9ucjNuiIzDwWeYSWv
        tcZiSpsQMP6v0AfubRtN5yEuKdqJfX+vAeUQkz6WQ3IEqXIuuPtOHqkaudY9BnFJnxy8HhlafpghG
        5gJcWMvLnrf84utweVaf3uut8m6rt9uhCww3CZPUMMBONYuglZ83iCxeOWKrVOouWFTP20af0MAGj
        DWS6kbuW89rGv93C9UpLVDw4yPjF2cF8BtvP38cQiBJhJ/NktrV8Bw4oyjy4xwvR7OKwMVLfSH4sJ
        2qc+GO3Qp3GelzcO3dBjUrnBWZScZfR1TxX21ZmLZHJQ4WXZDw0ucQR0j+xSd3yC9quB1AZVD4854
        EXhPakMQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76Z-0003UJ-PQ; Wed, 10 Jun 2020 20:13:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/51] fs: Add a filesystem flag for THPs
Date:   Wed, 10 Jun 2020 13:13:08 -0700
Message-Id: <20200610201345.13273-15-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The page cache needs to know whether the filesystem supports THPs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/inode.c              | 2 ++
 include/linux/fs.h      | 1 +
 include/linux/pagemap.h | 6 ++++++
 mm/shmem.c              | 2 +-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 72c4c347afb7..9d78c37b00b8 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -181,6 +181,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	mapping->a_ops = &empty_aops;
 	mapping->host = inode;
 	mapping->flags = 0;
+	if (sb->s_type->fs_flags & FS_THP_SUPPORT)
+		__set_bit(AS_THP_SUPPORT, &mapping->flags);
 	mapping->wb_err = 0;
 	atomic_set(&mapping->i_mmap_writable, 0);
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 19ef6c88c152..ac411a08f83c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2241,6 +2241,7 @@ struct file_system_type {
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
+#define FS_THP_SUPPORT		8192	/* Remove once all fs converted */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 484a36185bb5..8a45b572bcf1 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -29,6 +29,7 @@ enum mapping_flags {
 	AS_EXITING	= 4, 	/* final truncate in progress */
 	/* writeback related tags are not used */
 	AS_NO_WRITEBACK_TAGS = 5,
+	AS_THP_SUPPORT = 6,	/* THPs supported */
 };
 
 /**
@@ -119,6 +120,11 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 	m->gfp_mask = mask;
 }
 
+static inline bool mapping_thp_support(struct address_space *mapping)
+{
+	return test_bit(AS_THP_SUPPORT, &mapping->flags);
+}
+
 void release_pages(struct page **pages, int nr);
 
 /*
diff --git a/mm/shmem.c b/mm/shmem.c
index a0dbe62f8042..a05d129a45e9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3854,7 +3854,7 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT,
+	.fs_flags	= FS_USERNS_MOUNT | FS_THP_SUPPORT,
 };
 
 int __init shmem_init(void)
-- 
2.26.2

