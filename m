Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AD26F59B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 16:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjECOUv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 10:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjECOUq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 10:20:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10AD59F7;
        Wed,  3 May 2023 07:20:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6437B60C1D;
        Wed,  3 May 2023 14:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5776C4339E;
        Wed,  3 May 2023 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683123642;
        bh=3UhHnEBFmzggd66EHCSR/HFYQPwD0NkdxmzvsSVox9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BS14IkgupMeG+ptsv3WuDhmBryGg5P5Wc6o4NKo/Pj8hFA6ZypaslMWN2UkpLImQ/
         1DZlRxwGNrgn7lioQ5Avt/HxZ0tfqPu5KXseZ+E3jnV8YHhSs9+DEua/d90HeLhFUj
         sRsmkorIrhtlsbRJ1xY/OrGFQJr4SHY70Yj21xxUpravytRTe1sGVgt+gkeFQy68Ok
         FwuIU12JTmicj7JGf0awKhy3j/LMBBDf6Gli2hj/zeDfpPHAQ0/p567z11zcdf3nhg
         lKwzUjxwHnTmfK2i1pPrYRkY/qdl3FLsp7C0EWdHDzK/bzaDYU7VXMHhT1c3xM4pnl
         4e5Xcq6I5cnyg==
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
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/6] fs: add infrastructure for multigrain inode i_m/ctime
Date:   Wed,  3 May 2023 10:20:32 -0400
Message-Id: <20230503142037.153531-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230503142037.153531-1-jlayton@kernel.org>
References: <20230503142037.153531-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Use the 31st bit of the tv_nsec field to indicate that something has
queried the inode for the i_mtime or i_ctime. When this flag is set, on
the next timestamp update, the kernel can fetch a fine-grained timestamp
instead of the usual coarse-grained one.

This patch adds the infrastructure this scheme. Filesytems can opt
into it by setting the FS_MULTIGRAIN_TS flag in the fstype.

Later patches will convert individual filesystems over to use it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c         | 52 ++++++++++++++++++++++++++++++++++++---
 fs/stat.c          | 32 ++++++++++++++++++++++++
 include/linux/fs.h | 61 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 141 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4558dc2f1355..7f6189961d6a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2030,6 +2030,7 @@ EXPORT_SYMBOL(file_remove_privs);
 static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
 {
 	int sync_it = 0;
+	struct timespec64 ctime;
 
 	/* First try to exhaust all avenues to not sync */
 	if (IS_NOCMTIME(inode))
@@ -2038,7 +2039,8 @@ static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
 	if (!timespec64_equal(&inode->i_mtime, now))
 		sync_it = S_MTIME;
 
-	if (!timespec64_equal(&inode->i_ctime, now))
+	ctime = ctime_peek(inode);
+	if (!timespec64_equal(&ctime, now))
 		sync_it |= S_CTIME;
 
 	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
@@ -2062,6 +2064,50 @@ static int __file_update_time(struct file *file, struct timespec64 *now,
 	return ret;
 }
 
+/**
+ * current_ctime - Return FS time (possibly fine-grained)
+ * @inode: inode.
+ *
+ * Return the current time truncated to the time granularity supported by
+ * the fs, as suitable for a ctime/mtime change.
+ *
+ * For a multigrain timestamp, if the ctime is flagged as having been
+ * QUERIED, get a fine-grained timestamp.
+ */
+struct timespec64 current_ctime(struct inode *inode)
+{
+	bool multigrain = is_multigrain_ts(inode);
+	struct timespec64 now;
+	long nsec = 0;
+
+	if (multigrain) {
+		atomic_long_t *pnsec = (atomic_long_t *)&inode->i_ctime.tv_nsec;
+
+		nsec = atomic_long_fetch_andnot(I_CTIME_QUERIED, pnsec);
+	}
+
+	if (nsec & I_CTIME_QUERIED) {
+		ktime_get_real_ts64(&now);
+	} else {
+		ktime_get_coarse_real_ts64(&now);
+
+		if (multigrain) {
+			/*
+			 * If we've recently fetched a fine-grained timestamp
+			 * then the coarse-grained one may be earlier than the
+			 * existing one. Just keep the existing ctime if so.
+			 */
+			struct timespec64 ctime = ctime_peek(inode);
+
+			if (timespec64_compare(&ctime, &now) > 0)
+				now = ctime;
+		}
+	}
+
+	return timestamp_truncate(now, inode);
+}
+EXPORT_SYMBOL(current_ctime);
+
 /**
  * file_update_time - update mtime and ctime time
  * @file: file accessed
@@ -2080,7 +2126,7 @@ int file_update_time(struct file *file)
 {
 	int ret;
 	struct inode *inode = file_inode(file);
-	struct timespec64 now = current_time(inode);
+	struct timespec64 now = current_ctime(inode);
 
 	ret = inode_needs_update_time(inode, &now);
 	if (ret <= 0)
@@ -2109,7 +2155,7 @@ static int file_modified_flags(struct file *file, int flags)
 {
 	int ret;
 	struct inode *inode = file_inode(file);
-	struct timespec64 now = current_time(inode);
+	struct timespec64 now = current_ctime(inode);
 
 	/*
 	 * Clear the security bits if the process is not being run by root.
diff --git a/fs/stat.c b/fs/stat.c
index 7c238da22ef0..11a7e277f53e 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -26,6 +26,38 @@
 #include "internal.h"
 #include "mount.h"
 
+/**
+ * generic_fill_multigrain_cmtime - Fill in the mtime and ctime and flag ctime as QUERIED
+ * @request_mask: STATX_* values requested
+ * @inode: inode from which to grab the c/mtime
+ * @stat: where to store the resulting values
+ *
+ * Given @inode, grab the ctime and mtime out if it and store the result
+ * in @stat. When fetching the value, flag it as queried so the next write
+ * will use a fine-grained timestamp.
+ */
+void generic_fill_multigrain_cmtime(u32 request_mask,struct inode *inode,
+					struct kstat *stat)
+{
+	atomic_long_t *pnsec = (atomic_long_t *)&inode->i_ctime.tv_nsec;
+
+	/* If neither time was requested, then just don't report it */
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
+EXPORT_SYMBOL(generic_fill_multigrain_cmtime);
+
 /**
  * generic_fillattr - Fill in the basic attributes from the inode struct
  * @idmap:	idmap of the mount the inode was found from
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..d12d4a302d9d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1457,7 +1457,8 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
 	       kgid_has_mapping(fs_userns, kgid);
 }
 
-extern struct timespec64 current_time(struct inode *inode);
+struct timespec64 current_time(struct inode *inode);
+struct timespec64 current_ctime(struct inode *inode);
 
 /*
  * Snapshotting support.
@@ -2195,6 +2196,7 @@ struct file_system_type {
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
+#define FS_MULTIGRAIN_TS	64	/* Filesystem uses multigrain timestamps */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
@@ -2218,6 +2220,61 @@ struct file_system_type {
 
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
@@ -2838,6 +2895,8 @@ extern void page_put_link(void *);
 extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
+void generic_fill_multigrain_cmtime(u32 request_mask, struct inode *inode,
+					struct kstat *stat);
 void generic_fillattr(struct mnt_idmap *, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
-- 
2.40.1

