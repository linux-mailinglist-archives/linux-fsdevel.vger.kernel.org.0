Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA13C678E56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 03:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjAXCjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 21:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjAXCjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:39:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7091133451;
        Mon, 23 Jan 2023 18:39:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10338B80F9B;
        Tue, 24 Jan 2023 02:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C165BC4339E;
        Tue, 24 Jan 2023 02:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674527949;
        bh=SK5Jy+6rCKveBD5nbCJDN3evu772cvxZ/alFpEsNfhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnvbFbSFDWDHzE2IeesZJonPoGWslFMIQoVCXUXs/+1zEmkp4WgUtQAPKWSYjeTvD
         L0rwTZFZv9HX/SBML+hOoK8dKr1ynxkNTm+bPY9XTGoAhqw+MaYMQNMcQ2SrAbUcXc
         7UCgNs9YTn+tIgY1xB4jAz1VOM+XyVOjsuAcqEJJD3DysepdMyfCKcTnm1ErbcOf5d
         mhF+FOpsMQavAFFm/laz0MzjwKHS8qnwM9C7rbt38mZ+GpoIiAstQMM8dP2IsOFR2s
         ov5Ar77uiGJYG0nl46Hogc6i19uE6j8ZU4HA63pYLxAcUeRtqWBc4GK8scZqK1/UKd
         Aa8BqWBNtP/wA==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com, Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v3 02/11] Expand setup of writeback cache to all levels
Date:   Tue, 24 Jan 2023 02:38:25 +0000
Message-Id: <20230124023834.106339-3-ericvh@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230124023834.106339-1-ericvh@kernel.org>
References: <20221218232217.1713283-1-evanhensbergen@icloud.com>
 <20230124023834.106339-1-ericvh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If cache is enabled, make sure we are putting the right things
in place (mainly impacts mmap).  This also sets us up for more
cache levels.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/v9fs.c           | 2 +-
 fs/9p/vfs_addr.c       | 2 --
 fs/9p/vfs_file.c       | 7 ++++---
 fs/9p/vfs_inode.c      | 3 +--
 fs/9p/vfs_inode_dotl.c | 7 ++++---
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 3a9c4517265f..61a51b90600d 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -468,7 +468,7 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 
 #ifdef CONFIG_9P_FSCACHE
 	/* register the session for caching */
-	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
+	if (v9ses->cache == CACHE_FSCACHE) {
 		rc = v9fs_cache_session_get_cookie(v9ses, dev_name);
 		if (rc < 0)
 			goto err_clnt;
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 97599edbc300..6f46d7e4c750 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -279,8 +279,6 @@ static int v9fs_write_begin(struct file *filp, struct address_space *mapping,
 
 	p9_debug(P9_DEBUG_VFS, "filp %p, mapping %p\n", filp, mapping);
 
-	BUG_ON(!v9inode->writeback_fid);
-
 	/* Prefetch area to be written into the cache if we're caching this
 	 * file.  We need to do this before we get a lock on the page in case
 	 * there's more than one writer competing for the same cache block.
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index b740017634ef..3b6458846a0b 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -73,8 +73,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	}
 
 	mutex_lock(&v9inode->v_mutex);
-	if ((v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) &&
-	    !v9inode->writeback_fid &&
+	if ((v9ses->cache) && !v9inode->writeback_fid &&
 	    ((file->f_flags & O_ACCMODE) != O_RDONLY)) {
 		/*
 		 * clone a fid and add it to writeback_fid
@@ -92,9 +91,11 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 		v9inode->writeback_fid = (void *) writeback_fid;
 	}
 	mutex_unlock(&v9inode->v_mutex);
-	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
+#ifdef CONFIG_9P_FSCACHE
+	if (v9ses->cache == CACHE_FSCACHE)
 		fscache_use_cookie(v9fs_inode_cookie(v9inode),
 				   file->f_mode & FMODE_WRITE);
+#endif
 	v9fs_open_fid_add(inode, &fid);
 	return 0;
 out_error:
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 27a04a226d97..33e521c60e2c 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -843,8 +843,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	inode = d_inode(dentry);
 	v9inode = V9FS_I(inode);
 	mutex_lock(&v9inode->v_mutex);
-	if ((v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) &&
-	    !v9inode->writeback_fid &&
+	if ((v9ses->cache) && !v9inode->writeback_fid &&
 	    ((flags & O_ACCMODE) != O_RDONLY)) {
 		/*
 		 * clone a fid and add it to writeback_fid
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index f806b3f11649..bff37a312e64 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -316,8 +316,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 
 	v9inode = V9FS_I(inode);
 	mutex_lock(&v9inode->v_mutex);
-	if ((v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) &&
-	    !v9inode->writeback_fid &&
+	if ((v9ses->cache) && !v9inode->writeback_fid &&
 	    ((flags & O_ACCMODE) != O_RDONLY)) {
 		/*
 		 * clone a fid and add it to writeback_fid
@@ -340,9 +339,11 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	if (err)
 		goto out;
 	file->private_data = ofid;
-	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
+#ifdef CONFIG_9P_FSCACHE
+	if (v9ses->cache == CACHE_FSCACHE)
 		fscache_use_cookie(v9fs_inode_cookie(v9inode),
 				   file->f_mode & FMODE_WRITE);
+#endif
 	v9fs_open_fid_add(inode, &ofid);
 	file->f_mode |= FMODE_CREATED;
 out:
-- 
2.37.2

