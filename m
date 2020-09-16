Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A00C26BA9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 05:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIPD1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 23:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPD11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:27:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5C7C06174A;
        Tue, 15 Sep 2020 20:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9Wcd6pyA0kW5OVn3Wwf7BVBeUFWEe52ze3rkd5TtWfQ=; b=lGnL9G0gw7JtgaO0aLEb/oKGIc
        UceWafAvIPyodM0XxP/qa42sSvmF0IwVeClsm+GJIZylgsR4QPf3nrZngzq5oFuS0eOIPpPvH6ozQ
        zvsQgdH1zWph1n1xtvHaYvunv72kxK+xDLaV/6DVd9cp7Q1MvaBlHQ//FsHaS3b5wsu0cpLulSwMU
        P2d658G5Nw0d7GSat1+EtgI8DI2kvp2EwzP2zFSU8GpVcxn8pGzJz36nrrQc14TcylZH90maJqXLJ
        9YK7LkxR3UuxCVVOY9Q/2qgqPo2sJnffhm21FUkvoDPfsmTESH11J7jjVZzmPK4wY59u/xLOCNsJM
        ooG6wzYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIO6I-0005yL-W7; Wed, 16 Sep 2020 03:27:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 1/2] fs: Add a filesystem flag for THPs
Date:   Wed, 16 Sep 2020 04:27:16 +0100
Message-Id: <20200916032717.22917-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The page cache needs to know whether the filesystem supports THPs so that
it doesn't send THPs to filesystems which can't handle them.  Dave Chinner
points out that getting from the page mapping to the filesystem type
is too many steps (mapping->host->i_sb->s_type->fs_flags) so cache that
information in the address space flags.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/inode.c              | 2 ++
 include/linux/fs.h      | 1 +
 include/linux/pagemap.h | 6 ++++++
 mm/shmem.c              | 2 +-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 13d8c0a44e23..4531358ae97b 100644
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
index f8d75e4ad9d7..f10190b22d5a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2217,6 +2217,7 @@ struct file_system_type {
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
+#define FS_THP_SUPPORT		8192	/* Remove once all fs converted */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 09738075e478..ecb03e1b3555 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -34,6 +34,7 @@ enum mapping_flags {
 	AS_EXITING	= 4, 	/* final truncate in progress */
 	/* writeback related tags are not used */
 	AS_NO_WRITEBACK_TAGS = 5,
+	AS_THP_SUPPORT = 6,	/* THPs supported */
 };
 
 /**
@@ -124,6 +125,11 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
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
index bb0ebb52fcbe..c763a340ea86 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3844,7 +3844,7 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT,
+	.fs_flags	= FS_USERNS_MOUNT | FS_THP_SUPPORT,
 };
 
 int __init shmem_init(void)
-- 
2.28.0

