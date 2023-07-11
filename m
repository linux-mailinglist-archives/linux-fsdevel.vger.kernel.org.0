Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B4874E5F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 06:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjGKEhr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 00:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjGKEhH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:37:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B55E56
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 21:36:41 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b8b318c5cfso38524665ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 21:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689050201; x=1691642201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnm0VPrqsxf3OoUkgFVp05JccyOYblt7LrKaUOTzwLE=;
        b=fgzEOPXUo9OtDvr33nwOel8ZSlBeOsg+Qu2lVQ9VSpIuAKLPSi9xaF71yz/Xw46zq6
         fd+boEwdUSuJRFQ51nX01zpzLQog3dcJF4xA3fNd8Ve0r0K7oddvvZuVNcMJ216x+4dl
         Ifpoy2Z923Pc1KLJnlLsiIsDCAxOuGAy89ckiwCbH31dsBe9WUEJ05BZruhZC+iT+hQI
         DQbaGuZvtmKxzD1bsVl6Sux6IbnSpIJ171qpMijqfdCxFtCV1o0y0bU0ZR4hwdF2TN4/
         AoqWH5/36qymY1EzJnrGqohEhRAtKaSYGpP8e/rhVqea1T/+k0wt0MyEpMD6rE9bjS+w
         jx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689050201; x=1691642201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnm0VPrqsxf3OoUkgFVp05JccyOYblt7LrKaUOTzwLE=;
        b=GNO59eWN6LND+6Jg43cXv6+G02BuD2kqxs7beK0Flin4DbNMogK4dHOziO1BtvvGkD
         ot70VNQ6VYRM9jZcIVV8irkCHRctMkzNuHcp56GvcRCHsI98yD47/rckoapnsydsVRIj
         V1Bgpy02I2LXG/525GZnUhwlvZ5txR0L1cuQXg2NU7hQmAvMrdtXR6BTb5rIaISBARvT
         Mjj0oHCsYFW0wr/Jgivm2zvUO/7a/6v3zVc69QPV8/yVsURTJRGBkZzHos+ofxioJ8k5
         iAfvuNzlM29x7Ugcl8cf9dF3L63zYf0EFY3V+M+xhV78GHYSJJv2fmhegatYmoGJvxtW
         lJAA==
X-Gm-Message-State: ABy/qLYDCwQacpZThnA8yE+yxo9pmBpx/rQX1TejlKt+t5C6sJbGXr4e
        QtR2M06BRs8oBmQqvaM0M4elMQ==
X-Google-Smtp-Source: APBJJlHqbvCfDD6fEridYbhlFoWzHLj42mgUUP5+LgHd5Tvc2WYKYak2Kq6wQvCwqcBdF2lEDRYEQw==
X-Received: by 2002:a17:902:eacc:b0:1b8:ae12:5610 with SMTP id p12-20020a170902eacc00b001b8ae125610mr15069821pld.7.1689050201405;
        Mon, 10 Jul 2023 21:36:41 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b001b9de67285dsm755259plb.156.2023.07.10.21.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 21:36:40 -0700 (PDT)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     me@jcix.top, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH 4/5] fuse: writeback_cache consistency enhancement (writeback_cache_v2)
Date:   Tue, 11 Jul 2023 12:34:04 +0800
Message-Id: <20230711043405.66256-5-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com>
References: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some users may want both the high performance of the writeback_cahe mode
and a little bit more consistency among FUSE mounts. Current
writeback_cache mode never updates attributes from server, so can never
see the file attributes changed by other FUSE mounts, which means
'zero-consisteny'.

This commit introduces writeback_cache_v2 mode, which allows the attributes
to be updated from server to kernel when the inode is clean and no
writeback is in-progressing. FUSE daemons can select this mode by the
FUSE_WRITEBACK_CACHE_V2 init flag.

In writeback_cache_v2 mode, the server generates official attributes.
Therefore,

    1. For the cmtime, the cmtime generated by kernel are just temporary
    values that are never flushed to server by fuse_write_inode(), and they
    could be eventually updated by the official server cmtime. The
    mtime-based revalidation of the fc->auto_inval_data mode is also
    skipped, as the kernel-generated temporary cmtime are likely not equal
    to the offical server cmtime.

    2. For the file size, we expect server updates its file size on
    FUSE_WRITEs. So we increase fi->attr_version in fuse_writepage_end() to
    check the staleness of the returning file size.

Together with FOPEN_INVAL_ATTR, a FUSE daemon is able to implement
close-to-open (CTO) consistency like NFS client implementations.

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 fs/fuse/file.c            | 25 +++++++++++++++++++++++
 fs/fuse/fuse_i.h          |  6 ++++++
 fs/fuse/inode.c           | 42 +++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/fuse.h |  9 ++++++++-
 4 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 412824a11b7b..09416caea575 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1914,6 +1914,10 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 		 */
 		fuse_send_writepage(fm, next, inarg->offset + inarg->size);
 	}
+
+	if (fc->writeback_cache_v2)
+		fi->attr_version = atomic64_inc_return(&fc->attr_version);
+
 	fi->writectr--;
 	fuse_writepage_finish(fm, wpa);
 	spin_unlock(&fi->lock);
@@ -1943,10 +1947,18 @@ static struct fuse_file *fuse_write_file_get(struct fuse_inode *fi)
 
 int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
+	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_file *ff;
 	int err;
 
+	/*
+	 * Kernel c/mtime should not be updated to the server in the
+	 * writeback_cache_v2 mode as server c/mtime are official.
+	 */
+	if (fc->writeback_cache_v2)
+		return 0;
+
 	/*
 	 * Inode is always written before the last reference is dropped and
 	 * hence this should not be reached from reclaim.
@@ -2375,11 +2387,14 @@ static int fuse_write_begin(struct file *file, struct address_space *mapping,
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
 	struct fuse_conn *fc = get_fuse_conn(file_inode(file));
+	struct fuse_inode *fi = get_fuse_inode(file_inode(file));
 	struct page *page;
 	loff_t fsize;
 	int err = -ENOMEM;
 
 	WARN_ON(!fc->writeback_cache);
+	if (fc->writeback_cache_v2)
+		mutex_lock(&fi->wb_attr_mutex);
 
 	page = grab_cache_page_write_begin(mapping, index);
 	if (!page)
@@ -2411,6 +2426,9 @@ static int fuse_write_begin(struct file *file, struct address_space *mapping,
 	unlock_page(page);
 	put_page(page);
 error:
+	if (fc->writeback_cache_v2)
+		mutex_unlock(&fi->wb_attr_mutex);
+
 	return err;
 }
 
@@ -2419,6 +2437,7 @@ static int fuse_write_end(struct file *file, struct address_space *mapping,
 		struct page *page, void *fsdata)
 {
 	struct inode *inode = page->mapping->host;
+	struct fuse_conn *fc = get_fuse_conn(inode);
 
 	/* Haven't copied anything?  Skip zeroing, size extending, dirtying. */
 	if (!copied)
@@ -2442,6 +2461,12 @@ static int fuse_write_end(struct file *file, struct address_space *mapping,
 	unlock_page(page);
 	put_page(page);
 
+	if (fc->writeback_cache_v2) {
+		struct fuse_inode *fi = get_fuse_inode(inode);
+
+		mutex_unlock(&fi->wb_attr_mutex);
+	}
+
 	return copied;
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9b7fc7d3c7f1..200be199eb93 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -155,6 +155,9 @@ struct fuse_inode {
 	 */
 	struct fuse_inode_dax *dax;
 #endif
+
+	/** Lock for serializing size updates in writeback_cache_v2 mode */
+	struct mutex wb_attr_mutex;
 };
 
 /** FUSE inode state bits */
@@ -656,6 +659,9 @@ struct fuse_conn {
 	/* show legacy mount options */
 	unsigned int legacy_opts_show:1;
 
+	/* Improved writeback cache policy */
+	unsigned writeback_cache_v2:1;
+
 	/*
 	 * fs kills suid/sgid/cap on write/chown/trunc. suid is killed on
 	 * write/trunc only if caller did not have CAP_FSETID.  sgid is killed
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3e0b1fb1db17..958f8534a585 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -84,6 +84,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->orig_ino = 0;
 	fi->state = 0;
 	mutex_init(&fi->mutex);
+	mutex_init(&fi->wb_attr_mutex);
 	spin_lock_init(&fi->lock);
 	fi->forget = fuse_alloc_forget();
 	if (!fi->forget)
@@ -246,14 +247,36 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	u32 cache_mask;
 	loff_t oldsize;
 	struct timespec64 old_mtime;
+	bool try_wb_update = false;
+
+	if (fc->writeback_cache_v2 && S_ISREG(inode->i_mode)) {
+		mutex_lock(&fi->wb_attr_mutex);
+		try_wb_update = true;
+	}
 
 	spin_lock(&fi->lock);
 	/*
 	 * In case of writeback_cache enabled, writes update mtime, ctime and
 	 * may update i_size.  In these cases trust the cached value in the
 	 * inode.
+	 *
+	 * In writeback_cache_v2 mode, if all the following conditions are met,
+	 * then we allow the attributes to be refreshed:
+	 *
+	 * - inode is not in the process of being written (I_SYNC)
+	 * - inode has no dirty pages (I_DIRTY_PAGES)
+	 * - inode data-related attributes are clean (I_DIRTY_DATASYNC)
+	 * - inode does not have any page writeback in progress
+	 *
+	 * Note: checking PAGECACHE_TAG_WRITEBACK is not sufficient in fuse,
+	 * since inode can appear to have no PageWriteback pages, yet still have
+	 * outstanding write request.
 	 */
 	cache_mask = fuse_get_cache_mask(inode);
+	if (try_wb_update && !(inode->i_state & (I_DIRTY_PAGES | I_SYNC |
+	    I_DIRTY_DATASYNC)) && RB_EMPTY_ROOT(&fi->writepages))
+		cache_mask &= ~(STATX_MTIME | STATX_CTIME | STATX_SIZE);
+
 	if (cache_mask & STATX_SIZE)
 		attr->size = i_size_read(inode);
 
@@ -269,6 +292,8 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	if ((attr_version != 0 && fi->attr_version > attr_version) ||
 	    test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)) {
 		spin_unlock(&fi->lock);
+		if (try_wb_update)
+			mutex_unlock(&fi->wb_attr_mutex);
 		return;
 	}
 
@@ -292,7 +317,13 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 			truncate_pagecache(inode, attr->size);
 			if (!fc->explicit_inval_data)
 				inval = true;
-		} else if (fc->auto_inval_data) {
+		} else if (!fc->writeback_cache_v2 && fc->auto_inval_data) {
+			/*
+			 * When fc->writeback_cache_v2 is set, the old_mtime
+			 * can be generated by kernel and must not equal to
+			 * new_mtime generated by server. So skip in such
+			 * case.
+			 */
 			struct timespec64 new_mtime = {
 				.tv_sec = attr->mtime,
 				.tv_nsec = attr->mtimensec,
@@ -312,6 +343,9 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_dontcache(inode, attr->flags);
+
+	if (try_wb_update)
+		mutex_unlock(&fi->wb_attr_mutex);
 }
 
 static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
@@ -1179,6 +1213,10 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->async_dio = 1;
 			if (flags & FUSE_WRITEBACK_CACHE)
 				fc->writeback_cache = 1;
+			if (flags & FUSE_WRITEBACK_CACHE_V2) {
+				fc->writeback_cache = 1;
+				fc->writeback_cache_v2 = 1;
+			}
 			if (flags & FUSE_PARALLEL_DIROPS)
 				fc->parallel_dirops = 1;
 			if (flags & FUSE_HANDLE_KILLPRIV)
@@ -1262,7 +1300,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
-		FUSE_HAS_EXPIRE_ONLY;
+		FUSE_HAS_EXPIRE_ONLY | FUSE_WRITEBACK_CACHE_V2;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1a24c11637a4..850a3c0f87fb 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -207,6 +207,9 @@
  *  - add FUSE_EXT_GROUPS
  *  - add FUSE_CREATE_SUPP_GROUP
  *  - add FUSE_HAS_EXPIRE_ONLY
+ *
+ *  7.39
+ *  - add FUSE_WRITEBACK_CACHE_V2 init flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -242,7 +245,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 38
+#define FUSE_KERNEL_MINOR_VERSION 39
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -373,6 +376,9 @@ struct fuse_file_lock {
  * FUSE_CREATE_SUPP_GROUP: add supplementary group info to create, mkdir,
  *			symlink and mknod (single group that matches parent)
  * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
+ * FUSE_WRITEBACK_CACHE_V2:
+ *			allow time/size to be refreshed if no pending write
+ *			c/mtime not updated from kernel to server
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -411,6 +417,7 @@ struct fuse_file_lock {
 #define FUSE_HAS_INODE_DAX	(1ULL << 33)
 #define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
 #define FUSE_HAS_EXPIRE_ONLY	(1ULL << 35)
+#define FUSE_WRITEBACK_CACHE_V2	(1ULL << 36)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.20.1

