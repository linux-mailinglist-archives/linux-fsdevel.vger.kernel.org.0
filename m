Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A4C708021
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 13:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjERLsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 07:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjERLrz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 07:47:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05768C1;
        Thu, 18 May 2023 04:47:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 893C964EC3;
        Thu, 18 May 2023 11:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E063C433D2;
        Thu, 18 May 2023 11:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684410472;
        bh=234xn7dTn/EH18jsQndb3M4XMiFAfMq97F1cqMWOU2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kf4/fSAguVGEyctc98BenJkqq4M/xPbp9CIvuOaByIVai7GitVP0VjzNWKHsEnGUR
         wxJkYgQLmRkGLegr0jV3peRlQO0qoZrcyK7ExFIdxNVPXL6mjOYgVr1qmJKU7dyr4u
         hV9emFVZylRUjXqgQ6ERA+zD8hiKxJHM5K7u5lf0tUMBCyFAeu/7L2/nG9AEPI7VtD
         W/gNEoLsGWiGFf+zdGbrnmvjD+/7zBPehpp8u9ItRYpC0kD0btUoaimIkwAgWU/vCC
         XqWNbWfNu1nQmjHulzwT1eAAOyqAX3s0uUHt3AVlJDO+3YQw7VL9luECvvZBVqS43Z
         SXN8Auw3Sbx8w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v4 2/9] fs: add infrastructure for multigrain inode i_m/ctime
Date:   Thu, 18 May 2023 07:47:35 -0400
Message-Id: <20230518114742.128950-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518114742.128950-1-jlayton@kernel.org>
References: <20230518114742.128950-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The VFS always uses coarse-grained timestamp updates for filling out the
ctime and mtime after a change. This has the benefit of allowing
filesystems to optimize away a lot metadata updates, down to around 1
per jiffy, even when a file is under heavy writes.

Unfortunately, this has always been an issue when we're exporting via
NFSv3, which relies on timestamps to validate caches. Even with NFSv4, a
lot of exported filesystems don't properly support a change attribute
and are subject to the same problems with timestamp granularity. Other
applications have similar issues (e.g backup applications).

Switching to always using fine-grained timestamps would improve the
situation, but that becomes rather expensive, as the underlying
filesystem will have to log a lot more metadata updates.

What we need is a way to only use fine-grained timestamps when they are
being actively queried.

The kernel always stores normalized ctime values, so only the first 30
bits of the tv_nsec field are ever used. Whenever the mtime changes, the
ctime must also change.

Use the 31st bit of the ctime tv_nsec field to indicate that something
has queried the inode for the i_mtime or i_ctime. When this flag is set,
on the next timestamp update, the kernel can fetch a fine-grained
timestamp instead of the usual coarse-grained one.

This patch adds the infrastructure this scheme. Filesytems can opt
into it by setting the FS_MULTIGRAIN_TS flag in the fstype.

Later patches will convert individual filesystems over to use it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c         | 48 ++++++++++++++++++++++++++++-----
 fs/stat.c          | 41 ++++++++++++++++++++++++++--
 include/linux/fs.h | 66 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 145 insertions(+), 10 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 577799b7855f..24769e08fbaa 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2029,6 +2029,7 @@ EXPORT_SYMBOL(file_remove_privs);
 static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
 {
 	int sync_it = 0;
+	struct timespec64 ctime;
 
 	/* First try to exhaust all avenues to not sync */
 	if (IS_NOCMTIME(inode))
@@ -2037,7 +2038,8 @@ static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
 	if (!timespec64_equal(&inode->i_mtime, now))
 		sync_it = S_MTIME;
 
-	if (!timespec64_equal(&inode->i_ctime, now))
+	ctime = ctime_peek(inode);
+	if (!timespec64_equal(&ctime, now))
 		sync_it |= S_CTIME;
 
 	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
@@ -2431,6 +2433,40 @@ struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
 }
 EXPORT_SYMBOL(timestamp_truncate);
 
+/**
+ * current_mg_time - Return FS time (possibly fine-grained)
+ * @inode: inode.
+ *
+ * Return the current time truncated to the time granularity supported by
+ * the fs, as suitable for a ctime/mtime change. If the ctime is flagged
+ * as having been QUERIED, get a fine-grained timestamp.
+ */
+static struct timespec64 current_mg_time(struct inode *inode)
+{
+	struct timespec64 now;
+	atomic_long_t *pnsec = (atomic_long_t *)&inode->i_ctime.tv_nsec;
+	long nsec = atomic_long_fetch_andnot(I_CTIME_QUERIED, pnsec);
+
+	if (nsec & I_CTIME_QUERIED) {
+		ktime_get_real_ts64(&now);
+	} else {
+		struct timespec64 ctime;
+
+		ktime_get_coarse_real_ts64(&now);
+
+		/*
+		 * If we've recently fetched a fine-grained timestamp
+		 * then the coarse-grained one may still be earlier than the
+		 * existing one. Just keep the existing ctime if so.
+		 */
+		ctime = ctime_peek(inode);
+		if (timespec64_compare(&ctime, &now) > 0)
+			now = ctime;
+	}
+
+	return now;
+}
+
 /**
  * current_time - Return FS time
  * @inode: inode.
@@ -2445,12 +2481,10 @@ struct timespec64 current_time(struct inode *inode)
 {
 	struct timespec64 now;
 
-	ktime_get_coarse_real_ts64(&now);
-
-	if (unlikely(!inode->i_sb)) {
-		WARN(1, "current_time() called with uninitialized super_block in the inode");
-		return now;
-	}
+	if (is_multigrain_ts(inode))
+		now = current_mg_time(inode);
+	else
+		ktime_get_coarse_real_ts64(&now);
 
 	return timestamp_truncate(now, inode);
 }
diff --git a/fs/stat.c b/fs/stat.c
index 9b513a142a56..74d8283cc5c6 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -26,6 +26,38 @@
 #include "internal.h"
 #include "mount.h"
 
+/**
+ * fill_multigrain_cmtime - Fill in the mtime and ctime and flag ctime as QUERIED
+ * @request_mask: STATX_* values requested
+ * @inode: inode from which to grab the c/mtime
+ * @stat: where to store the resulting values
+ *
+ * Given @inode, grab the ctime and mtime out if it and store the result
+ * in @stat. When fetching the value, flag it as queried so the next write
+ * will use a fine-grained timestamp.
+ */
+void fill_multigrain_cmtime(u32 request_mask, struct inode *inode,
+			    struct kstat *stat)
+{
+	atomic_long_t *pnsec = (atomic_long_t *)&inode->i_ctime.tv_nsec;
+
+	/* If neither time was requested, then don't report them */
+	if (!(request_mask & (STATX_CTIME|STATX_MTIME))) {
+		stat->result_mask &= ~(STATX_CTIME|STATX_MTIME);
+		return;
+	}
+
+	stat->mtime = inode->i_mtime;
+	stat->ctime.tv_sec = inode->i_ctime.tv_sec;
+	/*
+	 * Atomically set the QUERIED flag and fetch the new value with
+	 * the flag masked off.
+	 */
+	stat->ctime.tv_nsec = atomic_long_fetch_or(I_CTIME_QUERIED, pnsec) &
+					~I_CTIME_QUERIED;
+}
+EXPORT_SYMBOL(fill_multigrain_cmtime);
+
 /**
  * generic_fillattr - Fill in the basic attributes from the inode struct
  * @idmap:	idmap of the mount the inode was found from
@@ -58,11 +90,16 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 	stat->rdev = inode->i_rdev;
 	stat->size = i_size_read(inode);
 	stat->atime = inode->i_atime;
-	stat->mtime = inode->i_mtime;
-	stat->ctime = inode->i_ctime;
 	stat->blksize = i_blocksize(inode);
 	stat->blocks = inode->i_blocks;
 
+	if (is_multigrain_ts(inode)) {
+		fill_multigrain_cmtime(request_mask, inode, stat);
+	} else {
+		stat->mtime = inode->i_mtime;
+		stat->ctime = inode->i_ctime;
+	}
+
 	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
 		stat->result_mask |= STATX_CHANGE_COOKIE;
 		stat->change_cookie = inode_query_iversion(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d5896f90093a..1f670cf1edbd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1474,7 +1474,7 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
 	       kgid_has_mapping(fs_userns, kgid);
 }
 
-extern struct timespec64 current_time(struct inode *inode);
+struct timespec64 current_time(struct inode *inode);
 
 /*
  * Snapshotting support.
@@ -2212,6 +2212,7 @@ struct file_system_type {
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
+#define FS_MULTIGRAIN_TS	64	/* Filesystem uses multigrain timestamps */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
@@ -2235,6 +2236,67 @@ struct file_system_type {
 
 #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
 
+/*
+ * Multigrain timestamps
+ *
+ * Conditionally use fine-grained ctime and mtime timestamps when there
+ * are users actively observing them via getattr. The primary use-case
+ * for this is NFS clients that use the ctime to distinguish between
+ * different states of the file, and that are often fooled by multiple
+ * operations that occur in the same coarse-grained timer tick.
+ */
+static inline bool is_multigrain_ts(const struct inode *inode)
+{
+	return inode->i_sb->s_type->fs_flags & FS_MULTIGRAIN_TS;
+}
+
+/*
+ * The kernel always keeps normalized struct timespec64 values in the ctime,
+ * which means that only the first 30 bits of the value are used. Use the
+ * 31st bit of the ctime's tv_nsec field as a flag to indicate that the value
+ * has been queried since it was last updated.
+ */
+#define I_CTIME_QUERIED		(1L<<30)
+
+/**
+ * ctime_nsec_peek - peek at (but don't query) the ctime tv_nsec field
+ * @inode: inode to fetch the ctime from
+ *
+ * Grab the current ctime tv_nsec field from the inode, mask off the
+ * I_CTIME_QUERIED flag and return it. This is mostly intended for use by
+ * internal consumers of the ctime that aren't concerned with ensuring a
+ * fine-grained update on the next change (e.g. when preparing to store
+ * the value in the backing store for later retrieval).
+ *
+ * This is safe to call regardless of whether the underlying filesystem
+ * is using multigrain timestamps.
+ */
+static inline long ctime_nsec_peek(const struct inode *inode)
+{
+	return inode->i_ctime.tv_nsec &~ I_CTIME_QUERIED;
+}
+
+/**
+ * ctime_peek - peek at (but don't query) the ctime
+ * @inode: inode to fetch the ctime from
+ *
+ * Grab the current ctime from the inode, sans I_CTIME_QUERIED flag. For
+ * use by internal consumers that don't require a fine-grained update on
+ * the next change.
+ *
+ * This is safe to call regardless of whether the underlying filesystem
+ * is using multigrain timestamps.
+ */
+static inline struct timespec64 ctime_peek(const struct inode *inode)
+{
+	struct timespec64 ctime;
+
+	ctime.tv_sec = inode->i_ctime.tv_sec;
+	ctime.tv_nsec = ctime_nsec_peek(inode);
+
+	return ctime;
+}
+
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int));
@@ -2857,6 +2919,8 @@ extern void page_put_link(void *);
 extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
+void fill_multigrain_cmtime(u32 request_mask, struct inode *inode,
+			    struct kstat *stat);
 void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
-- 
2.40.1

