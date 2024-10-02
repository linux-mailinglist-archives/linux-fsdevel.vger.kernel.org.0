Return-Path: <linux-fsdevel+bounces-30764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9EB98E2E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211FF1F2391E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2920217324;
	Wed,  2 Oct 2024 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iELSDJpT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3251C217306;
	Wed,  2 Oct 2024 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894998; cv=none; b=gR+Ljq/iA4M3QwBdrdtzYC8muTxlKz0EiYx9+SS7B6m5+CwYkJwha5dQfYfsK1XwK0j4AjHWALVELJ/Y2l1eqyaCDsujghHCMXqkFRMG8NoxlmnxsQLyeP7nekEGvkqrHF2hrVrCKMW2m14NffQ7qdHIcBBKSBWd+GgBK7QLFZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894998; c=relaxed/simple;
	bh=lWIeTtPiI+ai6qKZudnjNZrxKOAsE771WcfrcaA6eA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dueDBBefbp2qDuQaQB6nw3i3f0RFuvAd1KbdJ6AQbAhCFM4bz5LsVfYNHzpAS71d9ZNLGyYC0YQdVmt11vkwnB6sJZ5T3qaE27jWzoahd9wLtFSc5gDYUYurOnL8Gvyxm8VjHIOe49t1xSIhVRwJorHNcfX9qt/kl/fU5tB/q/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iELSDJpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85498C4CED3;
	Wed,  2 Oct 2024 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727894998;
	bh=lWIeTtPiI+ai6qKZudnjNZrxKOAsE771WcfrcaA6eA8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iELSDJpTc38MeEvbtdl0OEwL5LvjWHdrYtI745f7k+JXAdmWTmsxrHr5hKXyok1RF
	 wga5wjJHQI32nCM/7NZ2ispr34lXDRw1sUix05NzEahfxdKxQPUGT0z1p23swc0tEQ
	 olLV9uBSYc1x1qA1kB2Pys5a2icT4FVmZXY8IIZVdbmcRQq5UYHNk1lbubMxStHc6y
	 qMAt+5njhyLEDY6iONNK7Sif2lZAQILkPAlcHwbDlRNzHj3ZMx87TdfYbzGuwjkjQ6
	 o+GhIcCf8eZrv+NYVTQVwG60vX1cCiahkA2+GpRTirkguohjDff91V31QGhyzm1HZP
	 b0qRmI34RcXHw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 14:49:30 -0400
Subject: [PATCH v9 02/12] fs: add infrastructure for multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v9-2-77e2baad57ac@kernel.org>
References: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
In-Reply-To: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=13570; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lWIeTtPiI+ai6qKZudnjNZrxKOAsE771WcfrcaA6eA8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/ZXL/47kzw0EDS05DGJsTs28j/X5WO+L1olmN
 G6MLBUypBmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv2VywAKCRAADmhBGVaC
 FY8sEADAyOjzBxqMnCAy2kT/rpD8kGgBDEcNMxvkbaIDu7fqC95/2KJPMkV1cDVIuBVIPrOjUtA
 VDbJLgGkLMO466oEkCLtFdCNrY9fpL1RpOQOAk2Cg2+HQgPEVNqisV65UMz6CZD3OIOKd3qoUQy
 4vqisKxk7Z9oxi4wW6mrV4lsUJBskJgzNjaA8yHWTjsQTxLlG+UkfcY7dhvQf/o9EvTzPpBu107
 pf6F7SGEAOQHBp0IBWnJQ6MZ84PLfTxaNzR8Gne8kQgDcTs/kBtaiv9C2zuMIGsDdtqiJVeYG2n
 2fuSVtaSCjclrfjGVAQbkwNyPYgL2j4CYhrqCo8y29WXniF/j8MWRUxMfIZSw+VlkvGv3/Gxux0
 pSiFMaARqdjpOBRUTEeDHtoC1stA7Dt6X7n2yHeBiy/GCF5bXk5FIcQ57Ai+d9z66FtXCauGK51
 BMFEO/41B5L3Y4+nKhpE6rQ9MlRhwGew5Hed2C4zeDpFU06Od7yaSCsAFYszkTAwxa8ELPn5osx
 iHMIrlfs79Scv1OI7GA+bX3kg+EFFAX7UTODmG364vjLvTN6tEXJDGZJfnaCojs7Xrw69oJe+PZ
 FMqcq7AAFgY0Bfvx4OXsO37lbKUHz1WQ+0WHLlUUBYxIjay8FCHokK7i01zTXoDfOOWX/49JaKu
 43nXChnM6wpquaw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The VFS has always used coarse-grained timestamps when updating the
ctime and mtime after a change. This has the benefit of allowing
filesystems to optimize away a lot metadata updates, down to around 1
per jiffy, even when a file is under heavy writes.

Unfortunately, this has always been an issue when we're exporting via
NFSv3, which relies on timestamps to validate caches. A lot of changes
can happen in a jiffy, so timestamps aren't sufficient to help the
client decide when to invalidate the cache. Even with NFSv4, a lot of
exported filesystems don't properly support a change attribute and are
subject to the same problems with timestamp granularity. Other
applications have similar issues with timestamps (e.g backup
applications).

If fine-grained timestamps were always used, that would improve the
situation, but that becomes rather expensive, as the underlying
filesystem would have to log a lot more metadata updates.

What is needed is a way to only use fine-grained timestamps when they
are being actively queried. Use the (unused) top bit in
inode->i_ctime_nsec as a flag that indicates whether the current
timestamps have been queried via stat() or the like. When it's set,
allow the update to use a fine-grained timestamp iff it's necessary to
make the ctime show a different value.

If it has been queried, then first see whether the current coarse time
is later than the existing ctime. If it is, accept that value.  If it
isn't, then get a fine-grained timestamp and attempt to stamp the inode
ctime with that value. If that races with another concurrent stamp, then
abandon the update and take the new value without retrying.

Filesystems can opt into this by setting the FS_MGTIME fstype flag.
Others should be unaffected (other than being subject to the same floor
value as multigrain filesystems).

Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c         | 139 +++++++++++++++++++++++++++++++++++++++++++----------
 fs/stat.c          |  43 ++++++++++++++++-
 include/linux/fs.h |  34 ++++++++++---
 3 files changed, 181 insertions(+), 35 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 10c4619faeef..53f56f6e1ff2 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2172,19 +2172,58 @@ int file_remove_privs(struct file *file)
 }
 EXPORT_SYMBOL(file_remove_privs);
 
+/**
+ * current_time - Return FS time (possibly fine-grained)
+ * @inode: inode.
+ *
+ * Return the current time truncated to the time granularity supported by
+ * the fs, as suitable for a ctime/mtime change. If the ctime is flagged
+ * as having been QUERIED, get a fine-grained timestamp, but don't update
+ * the floor.
+ *
+ * For a multigrain inode, this is effectively an estimate of the timestamp
+ * that a file would receive. An actual update must go through
+ * inode_set_ctime_current().
+ */
+struct timespec64 current_time(struct inode *inode)
+{
+	struct timespec64 now;
+	u32 cns;
+
+	ktime_get_coarse_real_ts64_mg(&now);
+
+	if (!is_mgtime(inode))
+		goto out;
+
+	/* If nothing has queried it, then coarse time is fine */
+	cns = smp_load_acquire(&inode->i_ctime_nsec);
+	if (cns & I_CTIME_QUERIED) {
+		/*
+		 * If there is no apparent change, then get a fine-grained
+		 * timestamp.
+		 */
+		if (now.tv_nsec == (cns & ~I_CTIME_QUERIED))
+			ktime_get_real_ts64(&now);
+	}
+out:
+	return timestamp_truncate(now, inode);
+}
+EXPORT_SYMBOL(current_time);
+
 static int inode_needs_update_time(struct inode *inode)
 {
+	struct timespec64 now, ts;
 	int sync_it = 0;
-	struct timespec64 now = current_time(inode);
-	struct timespec64 ts;
 
 	/* First try to exhaust all avenues to not sync */
 	if (IS_NOCMTIME(inode))
 		return 0;
 
+	now = current_time(inode);
+
 	ts = inode_get_mtime(inode);
 	if (!timespec64_equal(&ts, &now))
-		sync_it = S_MTIME;
+		sync_it |= S_MTIME;
 
 	ts = inode_get_ctime(inode);
 	if (!timespec64_equal(&ts, &now))
@@ -2562,6 +2601,15 @@ void inode_nohighmem(struct inode *inode)
 }
 EXPORT_SYMBOL(inode_nohighmem);
 
+struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts)
+{
+	set_normalized_timespec64(&ts, ts.tv_sec, ts.tv_nsec);
+	inode->i_ctime_sec = ts.tv_sec;
+	inode->i_ctime_nsec = ts.tv_nsec;
+	return ts;
+}
+EXPORT_SYMBOL(inode_set_ctime_to_ts);
+
 /**
  * timestamp_truncate - Truncate timespec to a granularity
  * @t: Timespec
@@ -2594,36 +2642,77 @@ struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
 EXPORT_SYMBOL(timestamp_truncate);
 
 /**
- * current_time - Return FS time
- * @inode: inode.
+ * inode_set_ctime_current - set the ctime to current_time
+ * @inode: inode
  *
- * Return the current time truncated to the time granularity supported by
- * the fs.
+ * Set the inode's ctime to the current value for the inode. Returns the
+ * current value that was assigned. If this is not a multigrain inode, then we
+ * set it to the later of the coarse time and floor value.
  *
- * Note that inode and inode->sb cannot be NULL.
- * Otherwise, the function warns and returns time without truncation.
+ * If it is multigrain, then we first see if the coarse-grained timestamp is
+ * distinct from what is already there. If so, then use that. Otherwise, get a
+ * fine-grained timestamp.
+ *
+ * After that, try to swap the new value into i_ctime_nsec. Accept the
+ * resulting ctime, regardless of the outcome of the swap. If it has
+ * already been replaced, then that timestamp is later than the earlier
+ * unacceptable one, and is thus acceptable.
  */
-struct timespec64 current_time(struct inode *inode)
+struct timespec64 inode_set_ctime_current(struct inode *inode)
 {
 	struct timespec64 now;
+	u32 cns, cur;
 
-	ktime_get_coarse_real_ts64(&now);
-	return timestamp_truncate(now, inode);
-}
-EXPORT_SYMBOL(current_time);
+	ktime_get_coarse_real_ts64_mg(&now);
+	now = timestamp_truncate(now, inode);
 
-/**
- * inode_set_ctime_current - set the ctime to current_time
- * @inode: inode
- *
- * Set the inode->i_ctime to the current value for the inode. Returns
- * the current value that was assigned to i_ctime.
- */
-struct timespec64 inode_set_ctime_current(struct inode *inode)
-{
-	struct timespec64 now = current_time(inode);
+	/* Just return that if this is not a multigrain fs */
+	if (!is_mgtime(inode)) {
+		inode_set_ctime_to_ts(inode, now);
+		goto out;
+	}
 
-	inode_set_ctime_to_ts(inode, now);
+	/*
+	 * A fine-grained time is only needed if someone has queried
+	 * for timestamps, and the current coarse grained time isn't
+	 * later than what's already there.
+	 */
+	cns = smp_load_acquire(&inode->i_ctime_nsec);
+	if (cns & I_CTIME_QUERIED) {
+		struct timespec64 ctime = { .tv_sec = inode->i_ctime_sec,
+					    .tv_nsec = cns & ~I_CTIME_QUERIED };
+
+		if (timespec64_compare(&now, &ctime) <= 0) {
+			ktime_get_real_ts64_mg(&now);
+			now = timestamp_truncate(now, inode);
+		}
+	}
+
+	/* No need to cmpxchg if it's exactly the same */
+	if (cns == now.tv_nsec && inode->i_ctime_sec == now.tv_sec)
+		goto out;
+	cur = cns;
+retry:
+	/* Try to swap the nsec value into place. */
+	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, now.tv_nsec)) {
+		/* If swap occurred, then we're (mostly) done */
+		inode->i_ctime_sec = now.tv_sec;
+	} else {
+		/*
+		 * Was the change due to someone marking the old ctime QUERIED?
+		 * If so then retry the swap. This can only happen once since
+		 * the only way to clear I_CTIME_QUERIED is to stamp the inode
+		 * with a new ctime.
+		 */
+		if (!(cns & I_CTIME_QUERIED) && (cns | I_CTIME_QUERIED) == cur) {
+			cns = cur;
+			goto retry;
+		}
+		/* Otherwise, keep the existing ctime */
+		now.tv_sec = inode->i_ctime_sec;
+		now.tv_nsec = cur & ~I_CTIME_QUERIED;
+	}
+out:
 	return now;
 }
 EXPORT_SYMBOL(inode_set_ctime_current);
diff --git a/fs/stat.c b/fs/stat.c
index 89ce1be56310..dd480bf51a2a 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -26,6 +26,39 @@
 #include "internal.h"
 #include "mount.h"
 
+/**
+ * fill_mg_cmtime - Fill in the mtime and ctime and flag ctime as QUERIED
+ * @stat: where to store the resulting values
+ * @request_mask: STATX_* values requested
+ * @inode: inode from which to grab the c/mtime
+ *
+ * Given @inode, grab the ctime and mtime out if it and store the result
+ * in @stat. When fetching the value, flag it as QUERIED (if not already)
+ * so the next write will record a distinct timestamp.
+ *
+ * NB: The QUERIED flag is tracked in the ctime, but we set it there even
+ * if only the mtime was requested, as that ensures that the next mtime
+ * change will be distinct.
+ */
+void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
+{
+	atomic_t *pcn = (atomic_t *)&inode->i_ctime_nsec;
+
+	/* If neither time was requested, then don't report them */
+	if (!(request_mask & (STATX_CTIME|STATX_MTIME))) {
+		stat->result_mask &= ~(STATX_CTIME|STATX_MTIME);
+		return;
+	}
+
+	stat->mtime = inode_get_mtime(inode);
+	stat->ctime.tv_sec = inode->i_ctime_sec;
+	stat->ctime.tv_nsec = (u32)atomic_read(pcn);
+	if (!(stat->ctime.tv_nsec & I_CTIME_QUERIED))
+		stat->ctime.tv_nsec = ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn));
+	stat->ctime.tv_nsec &= ~I_CTIME_QUERIED;
+}
+EXPORT_SYMBOL(fill_mg_cmtime);
+
 /**
  * generic_fillattr - Fill in the basic attributes from the inode struct
  * @idmap:		idmap of the mount the inode was found from
@@ -58,8 +91,14 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 	stat->rdev = inode->i_rdev;
 	stat->size = i_size_read(inode);
 	stat->atime = inode_get_atime(inode);
-	stat->mtime = inode_get_mtime(inode);
-	stat->ctime = inode_get_ctime(inode);
+
+	if (is_mgtime(inode)) {
+		fill_mg_cmtime(stat, request_mask, inode);
+	} else {
+		stat->ctime = inode_get_ctime(inode);
+		stat->mtime = inode_get_mtime(inode);
+	}
+
 	stat->blksize = i_blocksize(inode);
 	stat->blocks = inode->i_blocks;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6ca11e241a24..eff688e75f2f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1613,6 +1613,17 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
 	return inode_set_mtime_to_ts(inode, ts);
 }
 
+/*
+ * Multigrain timestamps
+ *
+ * Conditionally use fine-grained ctime and mtime timestamps when there
+ * are users actively observing them via getattr. The primary use-case
+ * for this is NFS clients that use the ctime to distinguish between
+ * different states of the file, and that are often fooled by multiple
+ * operations that occur in the same coarse-grained timer tick.
+ */
+#define I_CTIME_QUERIED		((u32)BIT(31))
+
 static inline time64_t inode_get_ctime_sec(const struct inode *inode)
 {
 	return inode->i_ctime_sec;
@@ -1620,7 +1631,7 @@ static inline time64_t inode_get_ctime_sec(const struct inode *inode)
 
 static inline long inode_get_ctime_nsec(const struct inode *inode)
 {
-	return inode->i_ctime_nsec;
+	return inode->i_ctime_nsec & ~I_CTIME_QUERIED;
 }
 
 static inline struct timespec64 inode_get_ctime(const struct inode *inode)
@@ -1631,13 +1642,7 @@ static inline struct timespec64 inode_get_ctime(const struct inode *inode)
 	return ts;
 }
 
-static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inode,
-						      struct timespec64 ts)
-{
-	inode->i_ctime_sec = ts.tv_sec;
-	inode->i_ctime_nsec = ts.tv_nsec;
-	return ts;
-}
+struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts);
 
 /**
  * inode_set_ctime - set the ctime in the inode
@@ -2500,6 +2505,7 @@ struct file_system_type {
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
+#define FS_MGTIME		64	/* FS uses multigrain timestamps */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
@@ -2523,6 +2529,17 @@ struct file_system_type {
 
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
@@ -3262,6 +3279,7 @@ extern void page_put_link(void *);
 extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
+void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode);
 void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 void generic_fill_statx_atomic_writes(struct kstat *stat,

-- 
2.46.2


