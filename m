Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355E56ED102
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 17:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjDXPLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 11:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjDXPLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:11:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6071BC;
        Mon, 24 Apr 2023 08:11:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C88D625E4;
        Mon, 24 Apr 2023 15:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4925C4339E;
        Mon, 24 Apr 2023 15:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682349070;
        bh=k2M9LEh7K33YqmYAvjSmt43fwT9vNRnPkHEMYoESVrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WbwjTOXj6j4Z7IqqgUcwKWBEe7se7BityaoL5n8kCONOQFyyhdJLFsCkPnH/4aCll
         8/v9P24+5T7yNJ85v7xY76DVsj1hZHjqtHagJ54P0ND4HN7kzhiZxUm64vTQJxZD/V
         8O09xaRNauYkJvyCoQ8FEpxFFM3Rx6RAb0sEYgHCLu0Nj+oYHLIkXnbWaGOyH17Hz6
         7ZCtWBvUgA6xS/vKAzS2qN6p4ir+qsMBRuqBgR01PmNrG/6BDpG3S9FzCfjdw8+hns
         +hJ8yDWXQnKXnkwver8+8m70uhn7KtYkdoFZiRmb+f6CZZfZ/i+ymETygYCQmTe0fS
         QHGW1lNmMZzTA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/3] fs: add infrastructure for multigrain inode i_m/ctime
Date:   Mon, 24 Apr 2023 11:11:02 -0400
Message-Id: <20230424151104.175456-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424151104.175456-1-jlayton@kernel.org>
References: <20230424151104.175456-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
filesystems to optimize away a lot metaupdates, to around once per
jiffy, even when a file is under heavy writes.

Unfortunately, this has always been an issue when we're exporting via
NFSv3, which relies on timestamps to validate caches. Even with NFSv4, a
lot of exported filesystems don't properly support a change attribute
and are subject to the same problems with timestamp granularity. Other
applications have similar issues (e.g backup applications).

Switching to always using fine-grained timestamps would improve the
situation for NFS, but that becomes rather expensive, as the underlying
filesystem will have to log a lot more metadata updates.

What we need is a way to only use fine-grained timestamps when they are
being actively queried:

Whenever the mtime changes, the ctime must also change since we're
changing the metadata. When a superblock has a s_time_gran >1, we can
use the lowest-order bit of the inode->i_ctime as a flag to indicate
that the value has been queried. Then on the next write, we'll fetch a
fine-grained timestamp instead of the usual coarse-grained one.

We could enable this for any filesystem that has a s_time_gran >1, but
for now, this patch adds a new SB_MULTIGRAIN_TS flag to allow filesystems
to opt-in to this behavior.

It then adds a new current_ctime function that acts like the
current_time helper, but will conditionally grab fine-grained timestamps
when the flag is set in the current ctime. Also, there is a new
generic_fill_multigrain_cmtime for grabbing the c/mtime out of the inode
and atomically marking the ctime as queried.

Later patches will convert filesystems over to this new scheme.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c         | 57 +++++++++++++++++++++++++++++++++++++++---
 fs/stat.c          | 24 ++++++++++++++++++
 include/linux/fs.h | 62 ++++++++++++++++++++++++++++++++--------------
 3 files changed, 121 insertions(+), 22 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4558dc2f1355..4bd11bdb46d4 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2030,6 +2030,7 @@ EXPORT_SYMBOL(file_remove_privs);
 static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
 {
 	int sync_it = 0;
+	struct timespec64 ctime = inode->i_ctime;
 
 	/* First try to exhaust all avenues to not sync */
 	if (IS_NOCMTIME(inode))
@@ -2038,7 +2039,9 @@ static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
 	if (!timespec64_equal(&inode->i_mtime, now))
 		sync_it = S_MTIME;
 
-	if (!timespec64_equal(&inode->i_ctime, now))
+	if (is_multigrain_ts(inode))
+		ctime.tv_nsec &= ~I_CTIME_QUERIED;
+	if (!timespec64_equal(&ctime, now))
 		sync_it |= S_CTIME;
 
 	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
@@ -2062,6 +2065,50 @@ static int __file_update_time(struct file *file, struct timespec64 *now,
 	return ret;
 }
 
+/**
+ * current_ctime - Return FS time (possibly high-res)
+ * @inode: inode.
+ *
+ * Return the current time truncated to the time granularity supported by
+ * the fs, as suitable for a ctime/mtime change.
+ *
+ * For a multigrain timestamp, if the timestamp is flagged as having been
+ * QUERIED, then get a fine-grained timestamp.
+ */
+struct timespec64 current_ctime(struct inode *inode)
+{
+	struct timespec64 now;
+	long nsec = 0;
+	bool multigrain = is_multigrain_ts(inode);
+
+	if (multigrain) {
+		atomic_long_t *pnsec = (atomic_long_t *)&inode->i_ctime.tv_nsec;
+
+		nsec = atomic_long_fetch_and(~I_CTIME_QUERIED, pnsec);
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
+			struct timespec64 ctime = inode->i_ctime;
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
@@ -2080,7 +2127,7 @@ int file_update_time(struct file *file)
 {
 	int ret;
 	struct inode *inode = file_inode(file);
-	struct timespec64 now = current_time(inode);
+	struct timespec64 now = current_ctime(inode);
 
 	ret = inode_needs_update_time(inode, &now);
 	if (ret <= 0)
@@ -2109,7 +2156,7 @@ static int file_modified_flags(struct file *file, int flags)
 {
 	int ret;
 	struct inode *inode = file_inode(file);
-	struct timespec64 now = current_time(inode);
+	struct timespec64 now = current_ctime(inode);
 
 	/*
 	 * Clear the security bits if the process is not being run by root.
@@ -2419,9 +2466,11 @@ struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
 	if (unlikely(t.tv_sec == sb->s_time_max || t.tv_sec == sb->s_time_min))
 		t.tv_nsec = 0;
 
-	/* Avoid division in the common cases 1 ns and 1 s. */
+	/* Avoid division in the common cases 1 ns, 2 ns and 1 s. */
 	if (gran == 1)
 		; /* nothing */
+	else if (gran == 2)
+		t.tv_nsec &= ~1L;
 	else if (gran == NSEC_PER_SEC)
 		t.tv_nsec = 0;
 	else if (gran > 1 && gran < NSEC_PER_SEC)
diff --git a/fs/stat.c b/fs/stat.c
index 7c238da22ef0..67b56daf9663 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -26,6 +26,30 @@
 #include "internal.h"
 #include "mount.h"
 
+/**
+ * generic_fill_multigrain_cmtime - Fill in the mtime and ctime and flag ctime as QUERIED
+ * @inode: inode from which to grab the c/mtime
+ * @stat: where to store the resulting values
+ *
+ * Given @inode, grab the ctime and mtime out if it and store the result
+ * in @stat. When fetching the value, flag it as queried so the next write
+ * will use a fine-grained timestamp.
+ */
+void generic_fill_multigrain_cmtime(struct inode *inode, struct kstat *stat)
+{
+	atomic_long_t *pnsec = (atomic_long_t *)&inode->i_ctime.tv_nsec;
+
+	stat->mtime = inode->i_mtime;
+	stat->ctime.tv_sec = inode->i_ctime.tv_sec;
+	/*
+	 * Atomically set the QUERIED flag and fetch the new value with
+	 * the flag masked off.
+	 */
+	stat->ctime.tv_nsec = atomic_long_fetch_or(I_CTIME_QUERIED, pnsec)
+					& ~I_CTIME_QUERIED;
+}
+EXPORT_SYMBOL(generic_fill_multigrain_cmtime);
+
 /**
  * generic_fillattr - Fill in the basic attributes from the inode struct
  * @idmap:	idmap of the mount the inode was found from
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..e6dd3ce051ef 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1059,21 +1059,22 @@ extern int send_sigurg(struct fown_struct *fown);
  * sb->s_flags.  Note that these mirror the equivalent MS_* flags where
  * represented in both.
  */
-#define SB_RDONLY	 1	/* Mount read-only */
-#define SB_NOSUID	 2	/* Ignore suid and sgid bits */
-#define SB_NODEV	 4	/* Disallow access to device special files */
-#define SB_NOEXEC	 8	/* Disallow program execution */
-#define SB_SYNCHRONOUS	16	/* Writes are synced at once */
-#define SB_MANDLOCK	64	/* Allow mandatory locks on an FS */
-#define SB_DIRSYNC	128	/* Directory modifications are synchronous */
-#define SB_NOATIME	1024	/* Do not update access times. */
-#define SB_NODIRATIME	2048	/* Do not update directory access times */
-#define SB_SILENT	32768
-#define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
-#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
-#define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
-#define SB_I_VERSION	(1<<23) /* Update inode I_version field */
-#define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
+#define SB_RDONLY		(1<<0)	/* Mount read-only */
+#define SB_NOSUID		(1<<1)	/* Ignore suid and sgid bits */
+#define SB_NODEV		(1<<2)	/* Disallow access to device special files */
+#define SB_NOEXEC		(1<<3)	/* Disallow program execution */
+#define SB_SYNCHRONOUS		(1<<4)	/* Writes are synced at once */
+#define SB_MANDLOCK		(1<<6)	/* Allow mandatory locks on an FS */
+#define SB_DIRSYNC		(1<<7)	/* Directory modifications are synchronous */
+#define SB_NOATIME		(1<<10)	/* Do not update access times. */
+#define SB_NODIRATIME		(1<<11)	/* Do not update directory access times */
+#define SB_SILENT		(1<<15)
+#define SB_POSIXACL		(1<<16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT		(1<<17)	/* Use blk-crypto for encrypted files */
+#define SB_KERNMOUNT		(1<<22) /* this is a kern_mount call */
+#define SB_I_VERSION		(1<<23) /* Update inode I_version field */
+#define SB_MULTIGRAIN_TS	(1<<24) /* Use multigrain c/mtimes */
+#define SB_LAZYTIME		(1<<25) /* Update the on-disk [acm]times lazily */
 
 /* These sb flags are internal to the kernel */
 #define SB_SUBMOUNT     (1<<26)
@@ -1457,7 +1458,8 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
 	       kgid_has_mapping(fs_userns, kgid);
 }
 
-extern struct timespec64 current_time(struct inode *inode);
+struct timespec64 current_time(struct inode *inode);
+struct timespec64 current_ctime(struct inode *inode);
 
 /*
  * Snapshotting support.
@@ -2171,8 +2173,31 @@ enum file_time_flags {
 	S_VERSION = 8,
 };
 
-extern bool atime_needs_update(const struct path *, struct inode *);
-extern void touch_atime(const struct path *);
+/*
+ * Multigrain timestamps
+ *
+ * Conditionally use fine-grained ctime and mtime timestamps
+ *
+ * When s_time_gran is >1, and SB_MULTIGRAIN_TS is set, use the lowest-order bit
+ * in the tv_nsec field as a flag to indicate that the value was recently queried
+ * and that the next update should use a fine-grained timestamp.
+ */
+#define I_CTIME_QUERIED 1L
+
+static inline bool is_multigrain_ts(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+
+	/*
+	 * Warn if someone sets SB_MULTIGRAIN_TS, but doesn't turn down the ts
+	 * granularity.
+	 */
+	return (sb->s_flags & SB_MULTIGRAIN_TS) &&
+		!WARN_ON_ONCE(sb->s_time_gran == 1);
+}
+
+bool atime_needs_update(const struct path *, struct inode *);
+void touch_atime(const struct path *);
 int inode_update_time(struct inode *inode, struct timespec64 *time, int flags);
 
 static inline void file_accessed(struct file *file)
@@ -2838,6 +2863,7 @@ extern void page_put_link(void *);
 extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
+void generic_fill_multigrain_cmtime(struct inode *inode, struct kstat *stat);
 void generic_fillattr(struct mnt_idmap *, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
-- 
2.40.0

