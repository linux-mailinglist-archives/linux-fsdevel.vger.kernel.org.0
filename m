Return-Path: <linux-fsdevel+bounces-29319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA419781A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36582878D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DB41DC73A;
	Fri, 13 Sep 2024 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/lkT+t+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE71DC1BB;
	Fri, 13 Sep 2024 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235666; cv=none; b=Xvc/Oy0pfZhH9L8pmwKQFDuH7OVMPBr/z1r1/0JgKByyJKOn7ZWeSH+N9zwnsBdkkyOMg5MQxKtvAJs+qxKFTPgHscQK7o7WnPTQaMgpri4nt12gu8V5jmv3IjqtBLM6FKOu+Y1S+xjwa0S4fA9wV0Lv3lAPyvy4kwFiyAcEV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235666; c=relaxed/simple;
	bh=HfayPkjrCbrN8Ldhj6V+sbCZR5tjrl5gfJaI4pLAWN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S83Gs5jdtDm3o724pSNJzPLSLQW9HwY5GAuibk1zFsVC/a9Hhi6WSHZ8ysFPky6NWBwbJmAixOQUmfZYD5bc/MUWyjem6V3UssIznj+Kd2OzkfEE2a6TbwK8L4ZZ6d3k9S+D95MatED1dhIDiumd5fwrED4v4udJBNKvFNYRDoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/lkT+t+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B96C4CECC;
	Fri, 13 Sep 2024 13:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235666;
	bh=HfayPkjrCbrN8Ldhj6V+sbCZR5tjrl5gfJaI4pLAWN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I/lkT+t+4yb12bEOmFw4Pkxru4bU/QlkUB25IMQgWS8OzDiN5nKmH7gdLTM43GKw5
	 pb/vIQHT7xkkFLTKBlNcOTzixcAolv/AJAojDIY0LmfxhrlsPoOU5Mfai+y1gdlVl7
	 zL23hL5xpGWkLzy5QOUQDL9QOuPpS6aB0hTw2IjqyJqqb/ikYMG8M1pbmGQn5QlKnX
	 yCWKpdCnhT4fZdRn8KdPKb1s4uEV17JkOSSEPDO7x0EEjuRlMtM5sMIO12WS3hiHgd
	 8gypVEOhRXoCjm2sBqeXBQNR8Ue/2hTzI6lBlqFLk7wJymkLIl/Q+RF10d3J5UOyJQ
	 3pMwxetf5paRw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 13 Sep 2024 09:54:11 -0400
Subject: [PATCH v7 02/11] fs: add infrastructure for multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-mgtime-v7-2-92d4020e3b00@kernel.org>
References: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
In-Reply-To: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13602; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HfayPkjrCbrN8Ldhj6V+sbCZR5tjrl5gfJaI4pLAWN8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5EQIA5DvePajA0OopMSzMNSJqmrsV2NAnlbEv
 5DzfH+uG5iJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuRECAAKCRAADmhBGVaC
 FfaDD/9luwQEaJ7IZs2JGi2hx3SS42ek8CTWcUXA5bfua4KA3OTvRK3UN6dMtFhwnXcUsQKMCu2
 MLfxEF7ViqmqYWsxwbZLSppq4AX6wyvwY2ndnbaboA6AIGrw77bYoh/nZzIYc8XB/17GXiVG8vy
 RyOKx29hyo/thnKAsefFYTjl1da3qVo1fwNS0Qa0qBq/uU4hCViR9ab/+VHFxy7IEiSxMujHgn5
 YcDwqna/R6DAoXFnxE3LcFjnHYOAJdI8ylNjcbTuEXdoWYBOMZvT+i5OPHZXWxx0aTLo4dAp/m5
 eT2GpverrXTRLvrzsg7BEoCN/rpm1yicAJk+ClPZZT8yHII1n+6SFtbMCSHDSXv1J9hZrI+Hs1N
 oVH4NRWClc2OZOasGKcUcUyE2gG0UIXu/M2z0MzRo6N9DhKIbs8nqXoXDR/G2e6rV7XzDAtjx9R
 qphXvh/VsqFVKHUhc+x5JULEi9h4kfjs0HpO74ULOUee2OVdEBlGqnvmkpDWfRwN7J+Fafqb6Fh
 WAZ/GXbQP7O8f234z1tsaI/uhS0RbLun2tsN666y834+tNzeadX9FqUV6anuAD5ToZfbGt4cyv4
 W3ClJbm4DviXbQXBZSIWu6JlmgtctiBTRquZWyyYXZm+kLltxLAw7530nexisaBGSbWzVNGyMq0
 /ael7LDJdxq6z6w==
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

If we were to always use fine-grained timestamps, that would improve the
situation, but that becomes rather expensive, as the underlying
filesystem would have to log a lot more metadata updates.

What we need is a way to only use fine-grained timestamps when they are
being actively queried. Use the (unused) top bit in inode->i_ctime_nsec
as a flag that indicates whether the current timestamps have been
queried via stat() or the like. When it's set, we allow the kernel to
use a fine-grained timestamp iff it's necessary to make the ctime show
a different value.

This solves the problem of being able to distinguish the timestamp
between updates, but introduces a new problem: it's now possible for a
file being changed to get a fine-grained timestamp. A file that is
altered just a bit later can then get a coarse-grained one that appears
older than the earlier fine-grained time. This violates timestamp
ordering guarantees.

To remedy this, keep a global monotonic atomic64_t value that acts as a
timestamp floor.  When we go to stamp a file, we first get the latter of
the current floor value and the current coarse-grained time. If the
inode ctime hasn't been queried then we just attempt to stamp it with
that value.

If it has been queried, then first see whether the current coarse time
is later than the existing ctime. If it is, then we accept that value.
If it isn't, then we get a fine-grained timestamp.

Filesystems can opt into this by setting the FS_MGTIME fstype flag.
Others should be unaffected (other than being subject to the same floor
value as multigrain filesystems).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c         | 132 +++++++++++++++++++++++++++++++++++++++++++----------
 fs/stat.c          |  39 +++++++++++++++-
 include/linux/fs.h |  34 ++++++++++----
 3 files changed, 170 insertions(+), 35 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 10c4619faeef..8ab36779066e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2172,19 +2172,53 @@ int file_remove_privs(struct file *file)
 }
 EXPORT_SYMBOL(file_remove_privs);
 
+/**
+ * current_time - Return FS time (possibly fine-grained)
+ * @inode: inode.
+ *
+ * Return the current time truncated to the time granularity supported by
+ * the fs, as suitable for a ctime/mtime change. If the ctime is flagged
+ * as having been QUERIED, get a fine-grained timestamp.
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
+		 * If there is no apparent change, then
+		 * get a fine-grained timestamp.
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
@@ -2562,6 +2596,15 @@ void inode_nohighmem(struct inode *inode)
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
@@ -2594,36 +2637,75 @@ struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
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
+ * distinct from what we have. If so, then we'll just use that. If we have to
+ * get a fine-grained timestamp, then do so, and try to swap it into the floor.
+ * We accept the new floor value regardless of the outcome of the cmpxchg.
+ * After that, we try to swap the new value into i_ctime_nsec. Again, we take
+ * the resulting ctime, regardless of the outcome of the swap.
  */
-struct timespec64 current_time(struct inode *inode)
+struct timespec64 inode_set_ctime_current(struct inode *inode)
 {
 	struct timespec64 now;
+	u32 cns, cur;
+	u64 cookie;
 
-	ktime_get_coarse_real_ts64(&now);
-	return timestamp_truncate(now, inode);
-}
-EXPORT_SYMBOL(current_time);
+	cookie = ktime_get_coarse_real_ts64_mg(&now);
 
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
+		now = timestamp_truncate(now, inode);
+		inode_set_ctime_to_ts(inode, now);
+		goto out;
+	}
 
-	inode_set_ctime_to_ts(inode, now);
+	/*
+	 * We only need a fine-grained time if someone has queried it,
+	 * and the current coarse grained time isn't later than what's
+	 * already there.
+	 */
+	cns = smp_load_acquire(&inode->i_ctime_nsec);
+	if (cns & I_CTIME_QUERIED) {
+		struct timespec64 ctime = { .tv_sec = inode->i_ctime_sec,
+					    .tv_nsec = cns & ~I_CTIME_QUERIED };
+
+		if (timespec64_compare(&now, &ctime) <= 0)
+			ktime_get_real_ts64_mg(&now, cookie);
+	}
+	now = timestamp_truncate(now, inode);
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
index 89ce1be56310..a449626fd460 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -26,6 +26,35 @@
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
@@ -58,8 +87,14 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
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
2.46.0


