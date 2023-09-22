Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8217AB6F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 19:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjIVRO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 13:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjIVRO4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:14:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01FF194;
        Fri, 22 Sep 2023 10:14:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA976C433C7;
        Fri, 22 Sep 2023 17:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695402890;
        bh=cUbyQ02nAM2bDvq0/ZZw9DgAYz7d/0LKnQxo6skOJKg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=JWmI052TpN/1zeBKhJEITS/FzWyMl+R8Jm+YxEHcIcSq7ru2a/hKzbFK6trpGeY4u
         zEyPHaFAY2W0ba4eG5EOHPNnXZy4fPsVEvkv2rRGYwMbTzae+8JOR9dHgO3h02c+Dd
         713ZyDVzemx/wNXW59rWlBOuKu44GvGlhzicISQpEmcaEOq1IDyDZ/3BGdE6yqpQCz
         Di4miLVrLg+G2ggUzYOirruMlXShKjk7Hv3BrvtMk3IPfl2EuRvxV+Twwa2BhPBDvo
         KP9IomE/7l2cKAPRTH1HBNFA28lqPGnnQF5IhWVva1BKv1aQhN20m2EzrtDvDmlwFV
         MMYum+HnUwSoQ==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 22 Sep 2023 13:14:40 -0400
Subject: [PATCH v8 1/5] fs: add infrastructure for multigrain timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230922-ctime-v8-1-45f0c236ede1@kernel.org>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
In-Reply-To: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10541; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cUbyQ02nAM2bDvq0/ZZw9DgAYz7d/0LKnQxo6skOJKg=;
 b=owEBbAKT/ZANAwAIAQAOaEEZVoIVAcsmYgBlDcuGMnEkF766+TKP5OeKelTU7JOsYVGshI7co
 T3NWwjqPR2JAjIEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZQ3LhgAKCRAADmhBGVaC
 FR0vD/Y8MwOWZPsG9CllTA7k4QfI+psEycaO9S7W1HfqxihNE2Czqn/TocjGzyIxsYGz8YoDmql
 sUrenu3sO4dLy1MbuFkHING6C5r+xldNxg4d8cTWLGjhbfjTK1Y6KjQMXNsBlhpBXHCFC44cmWx
 WRad6Snvx+56tRYTHDPltA407w/tQb7xEKWMNfyS46WfERd0ZFvw9LJ4nTuXZNbQxRJSMUoswRi
 b/3sP2a0Bkj23drO3C5Ck4Ts7bvlkXi85MNf5F+AU+3ZaP2MNo2WNtbO6YeqnExc6G+05mxwpKQ
 vsa0Uc2C3WWbll6ncc7SvdFxWKSv0Enhn6fSRjGA4OBp8zVMs0RqNS/QrQpCjg4dJ+on4Qps+1D
 J153sgdC/304pMyTnZeIiocM2h5UWLjWQ4P9Jwr9BZ5a1CiGAJgZ6kjMZ8aE6EXDC1VLOfa5++X
 vdKKG136dvbN/wzzntK5hj29mJUTsUu+ldp63kjnyLOJbTex76Q3kMtXJxZKLgDGbtusjLcQnci
 m34FzYb81ubU9AaiQRhxqBXMhk9jTlOyHMYLL819S9y9a82rAuymd3IcNugYRkB8q7EJ99sTxEN
 GBJQovu7GClU1JHo0QEGKCZ7vek8yEzs2+rT/5zHXbbZp/vTzmYRZiA2SbVEcKiimHZ7CBpJzqk
 NzZVyAhxOBZbU
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The VFS always uses coarse-grained timestamps when updating the ctime
and mtime after a change. This has the benefit of allowing filesystems
to optimize away a lot metadata updates, down to around 1 per jiffy,
even when a file is under heavy writes.

Unfortunately, this has always been an issue when we're exporting via
NFS, which traditionally relied on timestamps to validate caches. A lot
of changes can happen in a jiffy, and that can lead to cache-coherency
issues between hosts.

NFSv4 added a dedicated change attribute that must change value after
any change to an inode. Some filesystems (btrfs, ext4 and tmpfs) utilize
the i_version field for this, but the NFSv4 spec allows a server to
generate this value from the inode's ctime.

What we need is a way to only use fine-grained timestamps when they are
being actively queried.

POSIX generally mandates that when the the mtime changes, the ctime must
also change. The kernel always stores normalized ctime values, so only
the first 30 bits of the tv_nsec field are ever used.

Use the 31st bit of the ctime tv_nsec field to indicate that something
has queried the inode for the mtime or ctime. When this flag is set,
on the next mtime or ctime update, the kernel will fetch a fine-grained
timestamp instead of the usual coarse-grained one.

Filesytems can opt into this behavior by setting the FS_MGTIME flag in
the fstype. Filesystems that don't set this flag will continue to use
coarse-grained timestamps.

Note that there is one problem with this scheme. A file with a
coarse-grained timestamp that is modified after a different file with a
fine grained one can appear to have been modified before.

Thus, these timestamps are not suitable for presentation to userland
as-is as it could confuse some programs that depend on strict ordering
via timestamps. For some use cases however (constructing change
cookies), they should be fine.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c         | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/fs.h |  63 +++++++++++++++++++++++++++++++--
 2 files changed, 160 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 84bc3c76e5cc..f3d68e4b8df7 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -168,6 +168,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_fop = &no_open_fops;
 	inode->i_ino = 0;
 	inode->__i_nlink = 1;
+	inode->__i_ctime.tv_sec = 0;
+	inode->__i_ctime.tv_nsec = 0;
 	inode->i_opflags = 0;
 	if (sb->s_xattr)
 		inode->i_opflags |= IOP_XATTR;
@@ -2102,10 +2104,52 @@ int file_remove_privs(struct file *file)
 }
 EXPORT_SYMBOL(file_remove_privs);
 
+/**
+ * current_mgtime - Return FS time (possibly fine-grained)
+ * @inode: inode.
+ *
+ * Return the current time truncated to the time granularity supported by
+ * the fs, as suitable for a ctime/mtime change. If the ctime is flagged
+ * as having been QUERIED, get a fine-grained timestamp.
+ */
+struct timespec64 current_mgtime(struct inode *inode)
+{
+	struct timespec64 now, ctime;
+	atomic_long_t *pnsec = (atomic_long_t *)&inode->__i_ctime.tv_nsec;
+	long nsec = atomic_long_read(pnsec);
+
+	if (nsec & I_CTIME_QUERIED) {
+		ktime_get_real_ts64(&now);
+		return timestamp_truncate(now, inode);
+	}
+
+	ktime_get_coarse_real_ts64(&now);
+	now = timestamp_truncate(now, inode);
+
+	/*
+	 * If we've recently fetched a fine-grained timestamp
+	 * then the coarse-grained one may still be earlier than the
+	 * existing ctime. Just keep the existing value if so.
+	 */
+	ctime = inode_get_ctime(inode);
+	if (timespec64_compare(&ctime, &now) > 0)
+		now = ctime;
+
+	return now;
+}
+EXPORT_SYMBOL(current_mgtime);
+
+static struct timespec64 current_ctime(struct inode *inode)
+{
+	if (is_mgtime(inode))
+		return current_mgtime(inode);
+	return current_time(inode);
+}
+
 static int inode_needs_update_time(struct inode *inode)
 {
 	int sync_it = 0;
-	struct timespec64 now = current_time(inode);
+	struct timespec64 now = current_ctime(inode);
 	struct timespec64 ctime;
 
 	/* First try to exhaust all avenues to not sync */
@@ -2527,6 +2571,13 @@ struct timespec64 current_time(struct inode *inode)
 }
 EXPORT_SYMBOL(current_time);
 
+/*
+ * Coarse timer ticks happen (roughly) every jiffy. If we see a coarse time
+ * more than 2 jiffies earlier than the current ctime, then we need to
+ * update it. This is the max delta allowed (in ns).
+ */
+#define COARSE_TIME_MAX_DELTA (2 / HZ * NSEC_PER_SEC)
+
 /**
  * inode_set_ctime_current - set the ctime to current_time
  * @inode: inode
@@ -2536,9 +2587,54 @@ EXPORT_SYMBOL(current_time);
  */
 struct timespec64 inode_set_ctime_current(struct inode *inode)
 {
-	struct timespec64 now = current_time(inode);
+	struct timespec64 now;
+	struct timespec64 ctime;
+
+	ctime.tv_nsec = READ_ONCE(inode->__i_ctime.tv_nsec);
+	if (!(ctime.tv_nsec & I_CTIME_QUERIED)) {
+		now = current_time(inode);
+
+		/* Just copy it into place if it's not multigrain */
+		if (!is_mgtime(inode)) {
+			inode_set_ctime_to_ts(inode, now);
+			return now;
+		}
 
-	inode_set_ctime(inode, now.tv_sec, now.tv_nsec);
+		/*
+		 * If we've recently updated with a fine-grained timestamp,
+		 * then the coarse-grained one may still be earlier than the
+		 * existing ctime. Just keep the existing value if so.
+		 */
+		ctime.tv_sec = inode->__i_ctime.tv_sec;
+		if (timespec64_compare(&ctime, &now) > 0) {
+			struct timespec64	limit = now;
+
+			/*
+			 * If the current coarse-grained clock is earlier than
+			 * it should be, then that's an indication that there
+			 * may have been a backward clock jump, and that the
+			 * update should not be skipped.
+			 */
+			timespec64_add_ns(&limit, COARSE_TIME_MAX_DELTA);
+			if (timespec64_compare(&ctime, &limit) < 0)
+				return ctime;
+		}
+
+		/*
+		 * Ctime updates are usually protected by the inode_lock, but
+		 * we can still race with someone setting the QUERIED flag.
+		 * Try to swap the new nsec value into place. If it's changed
+		 * in the interim, then just go with a fine-grained timestamp.
+		 */
+		if (cmpxchg(&inode->__i_ctime.tv_nsec, ctime.tv_nsec,
+			    now.tv_nsec) != ctime.tv_nsec)
+			goto fine_grained;
+		inode->__i_ctime.tv_sec = now.tv_sec;
+		return now;
+	}
+fine_grained:
+	ktime_get_real_ts64(&now);
+	inode_set_ctime_to_ts(inode, timestamp_truncate(now, inode));
 	return now;
 }
 EXPORT_SYMBOL(inode_set_ctime_current);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b528f063e8ff..91239a4c1a65 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1508,18 +1508,65 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
 	       kgid_has_mapping(fs_userns, kgid);
 }
 
+struct timespec64 current_mgtime(struct inode *inode);
 struct timespec64 current_time(struct inode *inode);
 struct timespec64 inode_set_ctime_current(struct inode *inode);
 
+/*
+ * Multigrain timestamps
+ *
+ * Conditionally use fine-grained ctime and mtime timestamps when there
+ * are users actively observing them via getattr. The primary use-case
+ * for this is NFS clients that use the ctime to distinguish between
+ * different states of the file, and that are often fooled by multiple
+ * operations that occur in the same coarse-grained timer tick.
+ *
+ * The kernel always keeps normalized struct timespec64 values in the ctime,
+ * which means that only the first 30 bits of the value are used. Use the
+ * 31st bit of the ctime's tv_nsec field as a flag to indicate that the value
+ * has been queried since it was last updated.
+ */
+#define I_CTIME_QUERIED		(1L<<30)
+
 /**
  * inode_get_ctime - fetch the current ctime from the inode
  * @inode: inode from which to fetch ctime
  *
- * Grab the current ctime from the inode and return it.
+ * Grab the current ctime from the inode, mask off the I_CTIME_QUERIED
+ * flag and return it. This is mostly intended for use by internal consumers
+ * of the ctime that aren't concerned with ensuring a fine-grained update on
+ * the next change (e.g. when preparing to store the value in the backing store
+ * for later retrieval).
+ *
+ * This is safe to call regardless of whether the underlying filesystem
+ * is using multigrain timestamps.
  */
 static inline struct timespec64 inode_get_ctime(const struct inode *inode)
 {
-	return inode->__i_ctime;
+	struct timespec64 ctime;
+
+	ctime.tv_sec = inode->__i_ctime.tv_sec;
+	ctime.tv_nsec = inode->__i_ctime.tv_nsec & ~I_CTIME_QUERIED;
+
+	return ctime;
+}
+
+/**
+ * inode_query_ctime - fetch the current ctime from inode and flag it
+ * @inode: inode from which to fetch and flag
+ *
+ * Grab the current ctime from the inode, mask off the I_CTIME_QUERIED
+ * flag and return it. This version also marks the inode as needing a fine
+ * grained timestamp update in the future.
+ */
+static inline struct timespec64 inode_query_ctime(const struct inode *inode)
+{
+	struct timespec64 ctime;
+	atomic_long_t *pnsec = (atomic_long_t *)&inode->__i_ctime.tv_nsec;
+
+	ctime.tv_sec = inode->__i_ctime.tv_sec;
+	ctime.tv_nsec = atomic_long_fetch_or(I_CTIME_QUERIED, pnsec) & ~I_CTIME_QUERIED;
+	return ctime;
 }
 
 /**
@@ -2305,6 +2352,7 @@ struct file_system_type {
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
+#define FS_MGTIME		64	/* FS uses multigrain timestamps */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
@@ -2328,6 +2376,17 @@ struct file_system_type {
 
 #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
 
+/**
+ * is_mgtime: is this inode using multigrain timestamps
+ * @inode: inode to test for multigrain timestamps
+ *
+ * Return true if the inode uses multigrain timestamps, false otherwise.
+ */
+static inline bool is_mgtime(const struct inode *inode)
+{
+	return inode->i_sb->s_type->fs_flags & FS_MGTIME;
+}
+
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int));

-- 
2.41.0

