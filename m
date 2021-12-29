Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1202C480F77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Dec 2021 05:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhL2EC5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Dec 2021 23:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhL2EC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Dec 2021 23:02:56 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7222EC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Dec 2021 20:02:56 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id l10so17485132pgm.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Dec 2021 20:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AsJNml0Mi43WXA4Dps3/Wg4WLTxI+zQqv/Px84rY7tg=;
        b=UtnrmzosKGANkmgKkaBppNlOAjalBk7TBB3h/9r2o4ZkTeQCK+V9ZsdP9dL1IwKd7d
         fE8dUK2apLzO7GASOjfCgxKVQKYTvF03xI9SXWcpULA+h1n5YtWfU1gnBVTADuVWqBWT
         e7PlzCShsYTa4ncAEyNc6UmKO4GXjkBjA9pPzZA9jx8mOykrCDIFpiEPfn5dWZhy68Cu
         HaEaZUgKBUEvqUrsgUnMntdlkbkyE45KqHjSXW37KftiAJEW0xuwYkCIlW3Mzmd5RjEi
         S2YJxih5OJ8Z5jW90BQ2tu4zK5oOiNKvO9UWHsAMBh258AZQrnX6Hy0jITfSkSjs/HWT
         f05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AsJNml0Mi43WXA4Dps3/Wg4WLTxI+zQqv/Px84rY7tg=;
        b=hWanJnR23qkOiW4gPOEOXVNbPwQSxlZJTbEy++zY2zmy1bO+MQYyiOqjz/VE+OTR9U
         nULKrj1A93qSjAFwsVyDT4H2LV0tYFr4ZRF9mccSjS0aQJkQzEZKHOajRFPKlQoOYoRc
         N2dfuJXOw0mz630sUGJKoupSnRfT2OGPq6R60wGiMglpPg/e2iyIDkHnS0XqLQKK8/ZB
         voILY7BFfFMM0iPEORfoE2cSzLiR9yhpn9IIEeAqaxcITOywG+o/GLAPm5yll+NyRSJ9
         CmjXNUH+Q7EElspoqz5VOT6HqHrXNXrK4H+vzvHwOU7BldbGmD91+C2Gb/qy2/e01wxI
         x9AQ==
X-Gm-Message-State: AOAM531M5/2+O2omQX5NyZUl9CKNtCWO9XCLondUKuuno+uE9yzJXEmo
        qdy8cs/J0EwAXyXZm65scPNPHQ==
X-Google-Smtp-Source: ABdhPJwxxCa2e062mqM8oTiwwvos45ERhu6mbuIhyuwuqg0riEhI1o2suVpN8wQO+xmSPdjZTkBXXg==
X-Received: by 2002:a63:6c03:: with SMTP id h3mr21507425pgc.604.1640750575810;
        Tue, 28 Dec 2021 20:02:55 -0800 (PST)
Received: from localhost.localdomain ([153.254.110.100])
        by smtp.gmail.com with ESMTPSA id g6sm23693826pfj.156.2021.12.28.20.02.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Dec 2021 20:02:55 -0800 (PST)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH v2] fuse: fix deadlock between atomic O_TRUNC open() and page invalidations
Date:   Wed, 29 Dec 2021 12:02:39 +0800
Message-Id: <20211229040239.66075-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fuse_finish_open() will be called with FUSE_NOWRITE set in case of atomic
O_TRUNC open(), so commit 76224355db75 ("fuse: truncate pagecache on
atomic_o_trunc") replaced invalidate_inode_pages2() by truncate_pagecache()
in such a case to avoid the A-A deadlock. However, we found another A-B-B-A
deadlock related to the case above, which will cause the xfstests
generic/464 testcase hung in our virtio-fs test environment.

For example, consider two processes concurrently open one same file, one
with O_TRUNC and another without O_TRUNC. The deadlock case is described
below, if open(O_TRUNC) is already set_nowrite(acquired A), and is trying
to lock a page (acquiring B), open() could have held the page lock
(acquired B), and waiting on the page writeback (acquiring A). This would
lead to deadlocks.

open(O_TRUNC)
----------------------------------------------------------------
fuse_open_common
  inode_lock            [C acquire]
  fuse_set_nowrite      [A acquire]

  fuse_finish_open
    truncate_pagecache
      lock_page         [B acquire]
      truncate_inode_page
      unlock_page       [B release]

  fuse_release_nowrite  [A release]
  inode_unlock          [C release]
----------------------------------------------------------------

open()
----------------------------------------------------------------
fuse_open_common
  fuse_finish_open
    invalidate_inode_pages2
      lock_page         [B acquire]
	fuse_launder_page
	  fuse_wait_on_page_writeback [A acquire & release]
      unlock_page       [B release]
----------------------------------------------------------------

Besides this case, all calls of invalidate_inode_pages2() and
invalidate_inode_pages2_range() in fuse code also can deadlock with
open(O_TRUNC). This commit tries to fix it by adding a new lock,
atomic_o_trunc, to protect the areas with the A-B-B-A deadlock risk.

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 fs/fuse/dax.c    |  4 ++--
 fs/fuse/dir.c    |  2 +-
 fs/fuse/file.c   | 28 ++++++++++++++++++++++++++--
 fs/fuse/fuse_i.h |  7 +++++++
 fs/fuse/inode.c  |  7 ++++---
 5 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 182b24a14804..e5203d61698c 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -878,11 +878,11 @@ static int dmap_writeback_invalidate(struct inode *inode,
 		return ret;
 	}
 
-	ret = invalidate_inode_pages2_range(inode->i_mapping,
+	ret = fuse_invalidate_inode_pages_range(inode,
 					    start_pos >> PAGE_SHIFT,
 					    end_pos >> PAGE_SHIFT);
 	if (ret)
-		pr_debug("fuse: invalidate_inode_pages2_range() failed err=%d\n",
+		pr_debug("fuse: fuse_invalidate_inode_pages_range() failed err=%d\n",
 			 ret);
 
 	return ret;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 656e921f3506..d6d5dcd3cf1e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1778,7 +1778,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	if ((is_truncate || !is_wb) &&
 	    S_ISREG(inode->i_mode) && oldsize != outarg.attr.size) {
 		truncate_pagecache(inode, outarg.attr.size);
-		invalidate_inode_pages2(mapping);
+		fuse_invalidate_inode_pages(inode);
 	}
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 829094451774..1dde21bad53c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -124,6 +124,28 @@ static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
 	}
 }
 
+int fuse_invalidate_inode_pages_range(struct inode *inode, pgoff_t start,
+					pgoff_t end)
+{
+	int ret;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	bool may_truncate = fc->atomic_o_trunc &&
+			    (fc->writeback_cache || FUSE_IS_DAX(inode));
+
+	if (may_truncate)
+		mutex_lock(&get_fuse_inode(inode)->atomic_trunc_mutex);
+	ret = invalidate_inode_pages2_range(inode->i_mapping, start, end);
+	if (may_truncate)
+		mutex_unlock(&get_fuse_inode(inode)->atomic_trunc_mutex);
+
+	return ret;
+}
+
+int fuse_invalidate_inode_pages(struct inode *inode)
+{
+	return fuse_invalidate_inode_pages_range(inode, 0, -1);
+}
+
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 				 unsigned int open_flags, bool isdir)
 {
@@ -214,7 +236,7 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 		file_update_time(file);
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 	} else if (!(ff->open_flags & FOPEN_KEEP_CACHE)) {
-		invalidate_inode_pages2(inode->i_mapping);
+		fuse_invalidate_inode_pages(inode);
 	}
 
 	if ((file->f_mode & FMODE_WRITE) && fc->writeback_cache)
@@ -241,6 +263,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 
 	if (is_wb_truncate || dax_truncate) {
 		inode_lock(inode);
+		mutex_lock(&get_fuse_inode(inode)->atomic_trunc_mutex);
 		fuse_set_nowrite(inode);
 	}
 
@@ -261,6 +284,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 
 	if (is_wb_truncate | dax_truncate) {
 		fuse_release_nowrite(inode);
+		mutex_unlock(&get_fuse_inode(inode)->atomic_trunc_mutex);
 		inode_unlock(inode);
 	}
 
@@ -2408,7 +2432,7 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 		if (vma->vm_flags & VM_MAYSHARE)
 			return -ENODEV;
 
-		invalidate_inode_pages2(file->f_mapping);
+		fuse_invalidate_inode_pages(file_inode(file));
 
 		return generic_file_mmap(file, vma);
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e8e59fbdefeb..ea293d0347a0 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -149,6 +149,9 @@ struct fuse_inode {
 	/** Lock to protect write related fields */
 	spinlock_t lock;
 
+	/** Lock for serializing page invalidation and atomic_o_trunc open */
+	struct mutex atomic_trunc_mutex;
+
 #ifdef CONFIG_FUSE_DAX
 	/*
 	 * Dax specific inode data
@@ -1315,4 +1318,8 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
+int fuse_invalidate_inode_pages(struct inode *inode);
+int fuse_invalidate_inode_pages_range(struct inode *inode,
+				      pgoff_t start, pgoff_t end);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ee846ce371d8..997c620f25df 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -86,6 +86,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->state = 0;
 	mutex_init(&fi->mutex);
 	spin_lock_init(&fi->lock);
+	mutex_init(&fi->atomic_trunc_mutex);
 	fi->forget = fuse_alloc_forget();
 	if (!fi->forget)
 		goto out_free;
@@ -107,6 +108,7 @@ static void fuse_free_inode(struct inode *inode)
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	mutex_destroy(&fi->mutex);
+	mutex_destroy(&fi->atomic_trunc_mutex);
 	kfree(fi->forget);
 #ifdef CONFIG_FUSE_DAX
 	kfree(fi->dax);
@@ -299,7 +301,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		}
 
 		if (inval)
-			invalidate_inode_pages2(inode->i_mapping);
+			fuse_invalidate_inode_pages(inode);
 	}
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
@@ -448,8 +450,7 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 			pg_end = -1;
 		else
 			pg_end = (offset + len - 1) >> PAGE_SHIFT;
-		invalidate_inode_pages2_range(inode->i_mapping,
-					      pg_start, pg_end);
+		fuse_invalidate_inode_pages_range(inode, pg_start, pg_end);
 	}
 	iput(inode);
 	return 0;
-- 
2.20.1

