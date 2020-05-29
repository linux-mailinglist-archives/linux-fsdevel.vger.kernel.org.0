Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E631E7366
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407078AbgE2DEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391602AbgE2C6b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CBCC08C5C7;
        Thu, 28 May 2020 19:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZCjaR6lz6Pllejoy8LzjdLNrtLD4RmCM/+nd+osKuQ0=; b=qfKtrO7bWwW1u9DotggmrDl8lM
        FNbH8XE27C0tTkHSZcxuQ6ODJjfjsHw+y6jORkwWFyEy3I2rtfQxL1T09Y6/1q+8Ao8bgbWKX/qdE
        EPyvk/9tphBnbz6zT7jQH8t+Op/G3ZTiT1TyqquioB0teHSqqMLDLD+oYtjT9zbzXHtmybHSdOqKg
        RHkW8xFODQOEE9UPcigK2Xg4NM4rKmm7vNEOqxsotT8RQh+/eu9G6TNW+3r31YCZ1FQ3OGQh9rFML
        kyiivwhFFE23LRlkx82LNCDRWavZskBv5A4Qoy5K3GBmwVXaoZSkVE6ifJ31h0vPyMvvT4hD5vJRH
        Ikz7F9Zg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE2-0008QH-RJ; Fri, 29 May 2020 02:58:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/39] fs: Add a filesystem flag for large pages
Date:   Thu, 28 May 2020 19:57:52 -0700
Message-Id: <20200529025824.32296-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The page cache needs to know whether the filesystem supports pages >
PAGE_SIZE.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/inode.c              | 2 ++
 include/linux/fs.h      | 1 +
 include/linux/pagemap.h | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 93d9252a00ab..a92947d63098 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -181,6 +181,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	mapping->a_ops = &empty_aops;
 	mapping->host = inode;
 	mapping->flags = 0;
+	if (sb->s_type->fs_flags & FS_LARGE_PAGES)
+		__set_bit(AS_LARGE_PAGES, &mapping->flags);
 	mapping->wb_err = 0;
 	atomic_set(&mapping->i_mmap_writable, 0);
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 55c743925c40..777783c8760b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2241,6 +2241,7 @@ struct file_system_type {
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
+#define FS_LARGE_PAGES		8192	/* Remove once all fs converted */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 36bfc9d855bb..ea869a7fda7a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -29,6 +29,7 @@ enum mapping_flags {
 	AS_EXITING	= 4, 	/* final truncate in progress */
 	/* writeback related tags are not used */
 	AS_NO_WRITEBACK_TAGS = 5,
+	AS_LARGE_PAGES = 6,	/* large pages supported */
 };
 
 /**
@@ -116,6 +117,11 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 	m->gfp_mask = mask;
 }
 
+static inline bool mapping_large_pages(struct address_space *mapping)
+{
+	return test_bit(AS_LARGE_PAGES, &mapping->flags);
+}
+
 void release_pages(struct page **pages, int nr);
 
 /*
-- 
2.26.2

