Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3387A42A7B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 16:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbhJLO6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 10:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbhJLO6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:58:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02686C061570
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 07:56:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id k26so17789265pfi.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pWh/9AciCMr0ljhjPDNOgYWq6TQQIm9MhYZYP9zV/HE=;
        b=IN/XPHbfacJEAxpLEZ5ohYLAJcrL8sm8duNumi3u++bgHTlYM4+cZV0qpKUHqQqcsO
         x3Gworxc4KnKGzlfv5OKjorSncKSOI/smfHVQ6pWj2d1jyqDFROA/6TYOV42EMtzXYkZ
         4bJ+PcMIqs4L4bkzfOWapmsqYPJQLKNhWfGvt0BH4IA7V0+S85d3XLZJJjOjSG7ITZKQ
         juXkVhJO5ALo8Jbv7Iq/O6nOjXHtXk5P3ejbdrn2czQFBjaSB1gPIllQXLHzn2l79DYC
         jzQKx5eiObxn2tBko6rt3MTMiJ6DMpDcnG5U4mhoQarn8bZKuqT1KFEbLzuDcgMMcXHm
         /70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pWh/9AciCMr0ljhjPDNOgYWq6TQQIm9MhYZYP9zV/HE=;
        b=4YaxNLCaSxUHZaWfBNSrkP0h53surzyCy0gR55vubuo/8OB8piaIeZx3PUw7bOFXm+
         zGWeSOmJVt8rUSyWQPdJudTorL9RtTfMnTpjR/R8ci4yAV7kUkrUIgg8imEx5PTIp6tM
         URBNpkApvudjmXTCE0NZozy25JqSEEP8sVqNhkVwUjSgG5/a5h8E6J8V2N5CtyxEMOTW
         xE5GSKqbH3a7elFef2iC4Hd0VEEXtswnOQScQeSUSyPmXzRKHbQmltScFanAfEUTQZDf
         wQ6mjW+Md9mv40QO5f8LU77PZE+Idx2nIo/Mhh+CuFWlTXz79sYqOWmfIkBFsJF783pq
         DDog==
X-Gm-Message-State: AOAM531E49izBNQV5aQY2NpMHSios+hHuVLrm7d6dLrZjoAgq+tJD+Nw
        FyKJf3r4CYRtDDTM8lUDAS7bHw==
X-Google-Smtp-Source: ABdhPJxvDbiNrUetWzBgtlQHbAiXnQ+8B/1KNC2rKqkZm6DBdwZ8aOcaDtlmZPtVyqxoSqY4bJ/sIg==
X-Received: by 2002:a63:7d46:: with SMTP id m6mr23383732pgn.409.1634050578418;
        Tue, 12 Oct 2021 07:56:18 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id d21sm1300225pfl.135.2021.10.12.07.56.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Oct 2021 07:56:18 -0700 (PDT)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [RFC] fuse: Sync attributes when the inode is clean in writeback mode
Date:   Tue, 12 Oct 2021 22:55:58 +0800
Message-Id: <20211012145558.19137-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When writeback cache is enabled, kernel will locally maintain the
attributes, and never trusts any server side attribute changes. This
limitaion is too strict in some use cases. For example, if a file is not
actively wrote from the fuse mount in writeback mode, the writeback related
caches should be clean, and the user may expect to see the new size changed
from the server side. This commit tires to relax the limitation.

If there is no dirty page of an fuse inode, update its ctime, atime and
size even in writeback_cache mode. The page cache cleaness checking is
based on a new fuse writeback helper (fuse_file_is_writeback_locked) and a
mm/filemap helper introduced recently (detials see commit 63135aa3866d
("mm: provide filemap_range_needs_writeback() helper") ).

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 fs/fuse/dir.c    |  3 ++-
 fs/fuse/file.c   | 21 +++++++++++++++++++++
 fs/fuse/fuse_i.h |  3 ++-
 fs/fuse/inode.c  | 36 +++++++++++++++++++++++++++++++-----
 4 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 915493613a31..2ca68aaeb26a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1678,8 +1678,9 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		/* FIXME: clear I_DIRTY_SYNC? */
 	}
 
+    /* Don't update the c/mtime unconditionally when we trust_local_cmtime. */
 	fuse_change_attributes_common(inode, &outarg.attr,
-				      attr_timeout(&outarg));
+				attr_timeout(&outarg), !trust_local_cmtime);
 	oldsize = inode->i_size;
 	/* see the comment in fuse_change_attributes() */
 	if (!is_wb || is_truncate || !S_ISREG(inode->i_mode))
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index bb3321098b69..108ab5106b52 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -413,6 +413,27 @@ static struct fuse_writepage_args *fuse_find_writeback(struct fuse_inode *fi,
 	return NULL;
 }
 
+/*
+ * Check if any page of this file is under writeback.
+ *
+ * The fuse_inode lock should be held by the caller.
+ */
+bool fuse_file_is_writeback_locked(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	pgoff_t idx_from = 0;
+	pgoff_t idx_to = 0;
+	size_t fuse_inode_size = i_size_read(inode);
+	bool found;
+
+	if (fuse_inode_size > 0)
+		idx_to = (fuse_inode_size - 1) >> PAGE_SHIFT;
+
+	found = fuse_find_writeback(fi, idx_from, idx_to);
+
+	return found;
+}
+
 /*
  * Check if any page in a range is under writeback
  *
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 0b2673a58cf5..0429f39de36a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1031,7 +1031,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 			    u64 attr_valid, u64 attr_version);
 
 void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
-				   u64 attr_valid);
+				   u64 attr_valid, bool update_cmtime);
 
 /**
  * Initialize the client device
@@ -1286,5 +1286,6 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 				 unsigned int open_flags, bool isdir);
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
+bool fuse_file_is_writeback_locked(struct inode *inode);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8068c666e1e6..371478f29425 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -23,6 +23,7 @@
 #include <linux/exportfs.h>
 #include <linux/posix_acl.h>
 #include <linux/pid_namespace.h>
+#include <linux/fs.h>
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 MODULE_DESCRIPTION("Filesystem in Userspace");
@@ -164,7 +165,7 @@ static ino_t fuse_squash_ino(u64 ino64)
 }
 
 void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
-				   u64 attr_valid)
+				   u64 attr_valid, bool update_cmtime)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
@@ -183,8 +184,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	inode->i_blocks  = attr->blocks;
 	inode->i_atime.tv_sec   = attr->atime;
 	inode->i_atime.tv_nsec  = attr->atimensec;
-	/* mtime from server may be stale due to local buffered write */
-	if (!fc->writeback_cache || !S_ISREG(inode->i_mode)) {
+	if (update_cmtime) {
 		inode->i_mtime.tv_sec   = attr->mtime;
 		inode->i_mtime.tv_nsec  = attr->mtimensec;
 		inode->i_ctime.tv_sec   = attr->ctime;
@@ -226,8 +226,22 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	bool is_wb = fc->writeback_cache;
 	loff_t oldsize;
 	struct timespec64 old_mtime;
+	bool is_dirty = false;
 
 	spin_lock(&fi->lock);
+
+	/*
+	 * is_dirty will be true if:
+	 *   1. Writeback cache is enabled,
+	 *   2. the file is a regular one, and
+	 *   3. at least one dirty page in the inode mapping, or at least
+	 *      one fuse writeback page is in-flight.
+	 */
+	is_dirty = is_wb && S_ISREG(inode->i_mode) &&
+		    (filemap_range_needs_writeback(inode->i_mapping, 0,
+		    i_size_read(inode) - 1) ||
+		    fuse_file_is_writeback_locked(inode));
+
 	if ((attr_version != 0 && fi->attr_version > attr_version) ||
 	    test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)) {
 		spin_unlock(&fi->lock);
@@ -235,7 +249,11 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	}
 
 	old_mtime = inode->i_mtime;
-	fuse_change_attributes_common(inode, attr, attr_valid);
+	/*
+	 * mtime from server may be stale due to local buffered write, so
+	 * don't update c/mtime when is_dirty is true.
+	 */
+	fuse_change_attributes_common(inode, attr, attr_valid, !is_dirty);
 
 	oldsize = inode->i_size;
 	/*
@@ -243,8 +261,16 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	 * extend local i_size without keeping userspace server in sync. So,
 	 * attr->size coming from server can be stale. We cannot trust it.
 	 */
-	if (!is_wb || !S_ISREG(inode->i_mode))
+	if (!is_dirty) {
 		i_size_write(inode, attr->size);
+		/*
+		 * If writeback cache is enabled, the truncated_pagecache should
+		 * be executed with fi->lock held, in case of racing with write
+		 * operations.
+		 */
+		if (is_wb && S_ISREG(inode->i_mode) && (oldsize != attr->size))
+			truncate_pagecache(inode, attr->size);
+	}
 	spin_unlock(&fi->lock);
 
 	if (!is_wb && S_ISREG(inode->i_mode)) {
-- 
2.20.1

