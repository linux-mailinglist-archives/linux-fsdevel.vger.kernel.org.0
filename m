Return-Path: <linux-fsdevel+bounces-30477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DB498BA3F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435D3283E31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201671BFE0C;
	Tue,  1 Oct 2024 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKj3yhF+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC051BE875;
	Tue,  1 Oct 2024 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780356; cv=none; b=oxps1EuSxZ6Qh8n5cMXO06kGijHmuGvkveFhAvHuDHDvWLkHpQgxXOLckySDnPrb/6u+Szbr/l/1cUKDcO78JnugGCrNqiah73q8GBqyaqqMUjLLzGUt4FX1SUG1wJeZVnYTsjdMzf3MSZIeJlZ6C4HSKkKwWohpxnreZFMinbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780356; c=relaxed/simple;
	bh=aZAy0l7/4k2LGVLomi5Ve4y/LL6QUr6Sx2B+lukvqM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jHfZ6aEmW6g5RJcY28KoTUMsSWa/LpRa8qZAMRyVNqaBypX0TLMPN9py62N2+dGiuFV33zLEz4/OcnYoswJ1zANtpVhWQ00xCOq/YsGv6UesS1p0VSFopTprYHZTOPzaqS+jmpUXKljFPw93FzX4E/RwV+hXkJrSHx3ueTJL+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKj3yhF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCE5C4CED2;
	Tue,  1 Oct 2024 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727780356;
	bh=aZAy0l7/4k2LGVLomi5Ve4y/LL6QUr6Sx2B+lukvqM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RKj3yhF+oyStx9Ni6wvM47DBmMhesTGtSCcVZdAfTR4yHvS0WANQ3nvJpFYGtLuhE
	 8CTbi5m0FG5JDzr6TH+WHBA87ZeoNTTbCpdM276nOUd/nyewrZqFz42lu2WwJU7myQ
	 yocbQsn859y/ddxiV1KGzbca9l+PW9WxNG15zleyD+i2DYRfLODpBXMxVxxWXnEBzO
	 pEPRO9f+Y6NHr2MTh028YXXoS1+bFDYVbocP0/8x5kGDbe55/50Aa2PPptcQmptjno
	 m/1eK26LozQyaAgmrbp4I06xI/IShYV+wcnvmxH5K+Rdr9UIvD26hxRx5n4DoA/jf9
	 7Khcg74ufAZSg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 01 Oct 2024 06:58:56 -0400
Subject: [PATCH v8 02/12] fs: add infrastructure for multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-mgtime-v8-2-903343d91bc3@kernel.org>
References: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
In-Reply-To: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13860; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aZAy0l7/4k2LGVLomi5Ve4y/LL6QUr6Sx2B+lukvqM0=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGb71fmhaxnBnt3uu+eWAn3QZ18UG7uIL1EaKhEmH/OooHjaT
 okCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJm+9X5AAoJEAAOaEEZVoIVSf8QAM+g
 MP18mwnri8/J0NBz/aWBjcV49FmVxqQWT1SKFUxkr+SiCkdR95yiZrA6HxJKjmG33TwqtYE1xxy
 jE5MmASJRwNH6eYdcVLzA0HCE+8E8NOQxC7oftNAnRUGVoXbKGK917J3R7CWKt3m9HH2hKMhpvN
 eW5V0+jP46fcviUwwmn/Hsbqd1ZkfKRsxNXLF8oj9wzYaKQPqLshJOrJXZdnQ8vfsnrj1DCMTtL
 aDl8K3fIrKV4iuwX87XGp+MuIk30uG7aP/F8n79JcjuW/iHCQXhzKbXGxR0kQGCWKVRerRgry7o
 RBoX25Sp5bSmIyssXym+CCp3veoq9SNx1l6Pv4EjdpvXr8jwESXNwE7eTrbQxhpPbXJ7P22ZvrF
 pSY6FpesmwMvkBYuq9SO1ke0GlgGfhtGUYy12PBhsO4wQWGcLHII9K+4EQeuPxDf6BxrgsXsOYj
 t38h1Ag63T5oSCVrEUCntMTTwCdf2dXv05RKGNyOMAxdsoydC4H8+/YLoBI6zVwvbT1qXUBzg2F
 nUrepXFfsDgWtVXvjGIAhVvOz4Zhfq9F9Q+taMn7ECNfVAGnFdBF5e74PZVg137ChVusDy4SXfN
 IdcZiZpHU36/BrIij7yRtN+XpQhbFUhdhPHRC6nz3idRe6Y2lCsqTPVpqyy+tFA9mBlSl/QNjTL
 pIj6H
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

Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c         | 137 +++++++++++++++++++++++++++++++++++++++++++----------
 fs/stat.c          |  39 ++++++++++++++-
 include/linux/fs.h |  34 +++++++++----
 3 files changed, 175 insertions(+), 35 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 471ae4a31549..4ec1e71e9a9d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2209,19 +2209,58 @@ int file_remove_privs(struct file *file)
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
@@ -2598,6 +2637,15 @@ void inode_nohighmem(struct inode *inode)
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
@@ -2630,36 +2678,75 @@ struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
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
+	 * We only need a fine-grained time if someone has queried it,
+	 * and the current coarse grained time isn't later than what's
+	 * already there.
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
index 41e598376d7e..381926fb405f 100644
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
index e3c603d01337..23908bad166c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1653,6 +1653,17 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
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
@@ -1660,7 +1671,7 @@ static inline time64_t inode_get_ctime_sec(const struct inode *inode)
 
 static inline long inode_get_ctime_nsec(const struct inode *inode)
 {
-	return inode->i_ctime_nsec;
+	return inode->i_ctime_nsec & ~I_CTIME_QUERIED;
 }
 
 static inline struct timespec64 inode_get_ctime(const struct inode *inode)
@@ -1671,13 +1682,7 @@ static inline struct timespec64 inode_get_ctime(const struct inode *inode)
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
@@ -2542,6 +2547,7 @@ struct file_system_type {
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
+#define FS_MGTIME		64	/* FS uses multigrain timestamps */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
@@ -2565,6 +2571,17 @@ struct file_system_type {
 
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
@@ -3321,6 +3338,7 @@ extern void page_put_link(void *);
 extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
+void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode);
 void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 void generic_fill_statx_atomic_writes(struct kstat *stat,

-- 
2.46.2


