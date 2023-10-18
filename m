Return-Path: <linux-fsdevel+bounces-683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E42427CE4D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 19:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135881C20D39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9E83FE21;
	Wed, 18 Oct 2023 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4h0E+xh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C644D3FB12
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 17:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABF6C43391;
	Wed, 18 Oct 2023 17:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697650901;
	bh=jEQ7N0OK0MX2jE1ssAAhSIOQltyOCrGAcxWFJvttHxI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d4h0E+xhad+RgIDC/LYSUsIa5OZJ5j1VZUh8b0oRqYs1DhOGl3OteEmsDq5DE6dvU
	 4jODdH3GMFjFbOdeqzYGxevfpeSYNelEI/oGfYi8x2K6pLMy8V3EXZ1hB7QP6aJU9S
	 DrxIEYOBoLxt+1DaqjAop+cCWxOYoyu0fZw7zUkI0gEjQocsdNCKrwU1uM3eYnxlDK
	 641zLCYrSN0dRbHy4sq9Biel5ccarDl1Dc/8YnpT8l0a2/E0OmT+0u2PLNfdDkg2k2
	 hp4P7RsmukdlDjpa0Jpk+rnM3W5E/PVmgXY4MBR7VJiI584Pt1HOL/R2mdMa8S5GML
	 BUotD8r6fTcRA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 18 Oct 2023 13:41:11 -0400
Subject: [PATCH RFC 4/9] fs: add infrastructure for multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-mgtime-v1-4-4a7a97b1f482@kernel.org>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
In-Reply-To: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, John Stultz <jstultz@google.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, 
 David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10393; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=jEQ7N0OK0MX2jE1ssAAhSIOQltyOCrGAcxWFJvttHxI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlMBjIl9JU6MnYsWK33IXzvvdM2nG21olQKhWVr
 9guhKbXSFmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZTAYyAAKCRAADmhBGVaC
 Fe00EADW88E+J8cw2JT7UsKSwGT9CpnCWkU+Dzs9iIt4AzRJOr48bdUPGk4Ci+js9zF2WLiSpn8
 UkapvZkI2z6IhNHLGQwx8/ZTn7wb1Y0YfjThgUw+zvTuGokLT3+U+ccgN3P4QsXmRGRfr44YvPb
 rqPyYGUuAAlqPU3m7MHwdsADhTP6QsuYNnNK1ZY0QDXVmeIhRhN+ZfLlsIczGcCbJInULdtNqpk
 LkgcxIoHrR+KqWHi3rZS3fTfhPkQJB9ATKXVRFpWvNmb8TtL+BNIR3+iMnWAnftkFnTonf/BlUo
 72UZBpjrU2Gx0zA01/N8U3pxr906ekp8OVvqk1OOJpBTuFyj4yeeyx85rasqXPJ/4P5oPgASoFO
 PcKSx5ioMrR+lJso/6OmKXP0NRkNdK7hhoA0yVMGi7ZLCprvATXv5yGbMlg7q+TOWrvT5MWJz6w
 XvrIsIGKmm5kkG38tmuHL/O5rapUOnU1upDpq5oGEcBiSiSwxq2bAbxzpuIx0sKV5JUTAXREGRO
 2ctfeFTOg5uYEDzueAYA0U2Kqk2g2dFHc/DCI9SPZdDu9V8edLa/mgjRRk0OCNU6qxaDMK9G958
 KooCxqNGtSsv1+cCNBxLI4zK210ifbeC5pkkqxVAplXfwRKG5DBkQkpWhenyKFfdsLiro1zBt/I
 oOC2cuZgMmPyzSA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The VFS always uses coarse-grained timestamps when updating the ctime
and mtime after a change. This has the benefit of allowing filesystems
to optimize away a lot metadata updates, down to around 1 per jiffy,
even when a file is under heavy writes.

Unfortunately, this has always been an issue when we're exporting via
NFSv3, which relies on timestamps to validate caches. A lot of changes
can happen in a jiffy, so timestamps aren't sufficient to help the
client decide to invalidate the cache. Even with NFSv4, a lot of
exported filesystems don't properly support a change attribute and are
subject to the same problems with timestamp granularity. Other
applications have similar issues with timestamps (e.g backup
applications).

If we were to always use fine-grained timestamps, that would improve the
situation, but that becomes rather expensive, as the underlying
filesystem would have to log a lot more metadata updates.

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

Later patches will convert individual filesystems to use the new
infrastructure.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c         | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/stat.c          | 41 ++++++++++++++++++++++++++++++--
 include/linux/fs.h | 31 +++++++++++++++++++++++-
 3 files changed, 136 insertions(+), 6 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 0612ad9c0227..83c3378053bc 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2108,10 +2108,40 @@ int file_remove_privs(struct file *file)
 }
 EXPORT_SYMBOL(file_remove_privs);
 
+/**
+ * current_mgtime - Return FS time (possibly fine-grained)
+ * @inode: inode.
+ *
+ * Return the current time truncated to the time granularity supported by
+ * the fs, as suitable for a mtime or ctime update. If the ctime is flagged
+ * as having been QUERIED, get the most current fine-grained timestamp
+ * (without advancing the coarse-grained mgtime), otherwise get the
+ * latest coarse multigrain timestamp.
+ */
+static struct timespec64 current_mgtime(struct inode *inode)
+{
+	struct timespec64 now;
+	atomic_t *pnsec = (atomic_t *)&inode->i_ctime_nsec;
+	u32 nsec = atomic_read(pnsec);
+
+	if (nsec & I_CTIME_QUERIED) {
+		ktime_get_real_ts64(&now);
+		return timestamp_truncate(now, inode);
+	}
+	return current_time(inode);
+}
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
 	struct timespec64 ts;
 
 	/* First try to exhaust all avenues to not sync */
@@ -2529,7 +2559,7 @@ struct timespec64 current_time(struct inode *inode)
 {
 	struct timespec64 now;
 
-	ktime_get_coarse_real_ts64(&now);
+	ktime_get_mg_coarse_ts64(&now);
 	return timestamp_truncate(now, inode);
 }
 EXPORT_SYMBOL(current_time);
@@ -2544,8 +2574,42 @@ EXPORT_SYMBOL(current_time);
 struct timespec64 inode_set_ctime_current(struct inode *inode)
 {
 	struct timespec64 now = current_time(inode);
+	struct timespec64 ctime;
+	bool queried;
+	int tscomp;
+
+	/* Just copy it into place if it's not multigrain */
+	if (!is_mgtime(inode)) {
+		inode_set_ctime_to_ts(inode, now);
+		return now;
+	}
+
+	ctime.tv_sec = inode_get_ctime_sec(inode);
+	ctime.tv_nsec = READ_ONCE(inode->i_ctime_nsec);
+	queried = ctime.tv_nsec & I_CTIME_QUERIED;
+
+	tscomp = timespec64_compare(&ctime, &now);
 
-	inode_set_ctime(inode, now.tv_sec, now.tv_nsec);
+	/*
+	 * We can use a coarse-grained timestamp if no one has queried for it,
+	 * or coarse time is already later than the existing ctime.
+	 */
+	if (!queried || tscomp < 0) {
+		/*
+		 * Ctime updates are usually protected by the inode_lock, but
+		 * we can still race with someone setting the QUERIED flag.
+		 * Try to swap the new nsec value into place. If it's changed
+		 * in the interim, then just go with a fine-grained timestamp.
+		 */
+		if (cmpxchg(&inode->i_ctime_nsec, ctime.tv_nsec,
+			    now.tv_nsec) != ctime.tv_nsec)
+			goto fine_grained;
+		inode->i_ctime_sec = now.tv_sec;
+		return now;
+	}
+fine_grained:
+	ktime_get_mg_fine_ts64(&now);
+	inode_set_ctime_to_ts(inode, timestamp_truncate(now, inode));
 	return now;
 }
 EXPORT_SYMBOL(inode_set_ctime_current);
diff --git a/fs/stat.c b/fs/stat.c
index 24bb0209e459..02d8857bac9f 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -26,6 +26,37 @@
 #include "internal.h"
 #include "mount.h"
 
+/**
+ * fill_mg_cmtime - Fill in the mtime and ctime and flag ctime as QUERIED
+ * @stat: where to store the resulting values
+ * @request_mask: STATX_* values requested
+ * @inode: inode from which to grab the c/mtime
+ *
+ * Given @inode, grab the ctime and mtime out if it and store the result
+ * in @stat. When fetching the value, flag it as queried so the next write
+ * will use a fine-grained timestamp.
+ */
+void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
+{
+	atomic_t *pnsec = (atomic_t *)&inode->i_ctime_nsec;
+
+	/* If neither time was requested, then don't report them */
+	if (!(request_mask & (STATX_CTIME|STATX_MTIME))) {
+		stat->result_mask &= ~(STATX_CTIME|STATX_MTIME);
+		return;
+	}
+
+	stat->mtime = inode_get_mtime(inode);
+	stat->ctime.tv_sec = inode_get_ctime_sec(inode);
+	/*
+	 * Atomically set the QUERIED flag and fetch the new value with
+	 * the flag masked off.
+	 */
+	stat->ctime.tv_nsec = atomic_fetch_or(I_CTIME_QUERIED, pnsec) &
+					~I_CTIME_QUERIED;
+}
+EXPORT_SYMBOL(fill_mg_cmtime);
+
 /**
  * generic_fillattr - Fill in the basic attributes from the inode struct
  * @idmap:		idmap of the mount the inode was found from
@@ -58,8 +89,14 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 	stat->rdev = inode->i_rdev;
 	stat->size = i_size_read(inode);
 	stat->atime = inode_get_atime(inode);
-	stat->mtime = inode_get_mtime(inode);
-	stat->ctime = inode_get_ctime(inode);
+
+	if (is_mgtime(inode)) {
+		fill_mg_cmtime(stat, request_mask, inode);
+	} else {
+		stat->mtime = inode_get_mtime(inode);
+		stat->ctime = inode_get_ctime(inode);
+	}
+
 	stat->blksize = i_blocksize(inode);
 	stat->blocks = inode->i_blocks;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 78786c1c32fd..c9823ec0da65 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1515,6 +1515,22 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
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
 static inline time64_t inode_get_atime_sec(const struct inode *inode)
 {
 	return inode->i_atime_sec;
@@ -1590,7 +1606,7 @@ static inline time64_t inode_get_ctime_sec(const struct inode *inode)
 
 static inline long inode_get_ctime_nsec(const struct inode *inode)
 {
-	return inode->i_ctime_nsec;
+	return inode->i_ctime_nsec & ~I_CTIME_QUERIED;
 }
 
 static inline struct timespec64 inode_get_ctime(const struct inode *inode)
@@ -2372,6 +2388,7 @@ struct file_system_type {
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
+#define FS_MGTIME		64	/* FS uses multigrain timestamps */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
@@ -2395,6 +2412,17 @@ struct file_system_type {
 
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
@@ -3080,6 +3108,7 @@ extern void page_put_link(void *);
 extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
+void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode);
 void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);

-- 
2.41.0


