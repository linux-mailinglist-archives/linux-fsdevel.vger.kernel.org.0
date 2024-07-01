Return-Path: <linux-fsdevel+bounces-22859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20DF91DC8E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A651D287D1E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F9E15534E;
	Mon,  1 Jul 2024 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUYPxMqz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F015381C;
	Mon,  1 Jul 2024 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829638; cv=none; b=hBkCYB8V6A9rZbpROCJoFku9U4+OCtHSXtohRIdSAANZmmWShSPLLqVmWB+uYp/jDmgnhQNdLoJ08RxXVpwVomiq6m8oypcSpdjyGLWSnbXGQY2AqsinA9Gppts0LIFWt+122KV1qSoN3zeSnE56LgycnvRs56dmBmshJupK3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829638; c=relaxed/simple;
	bh=k0PASpE836OQmpDiHN4nqw4lE+fzWCGQYeajWGV5+J0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ulfDhzSmBfNhPduZum/AQkb76fjdBPwONBFEUmmMDt9NYbxzAll7a5Dm1S5J5mbMXfZ2tdeO7Dvp9QiectXgiDZgHjgHc3yK0NbOs3Kfa3hXRVsBlkUvxpA06kNd05dcOmp8Ic/3gECa8aeKJZ3Py9TfII7KtXzEjm9hO1UJnkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUYPxMqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546C5C4AF0C;
	Mon,  1 Jul 2024 10:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829637;
	bh=k0PASpE836OQmpDiHN4nqw4lE+fzWCGQYeajWGV5+J0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JUYPxMqzEi5EY/MH4MdNa+TAkj71r2+HQEr1KPiTq8PBffx/aggQ04Gd90axJUd7u
	 dqZAB968NjPxqA2PF7lOTOKa2fE2meOiUiRCzECtJ6CRb+0gRfh4IImO3E9UnuCCka
	 LFQJ4s2J1vsf4ItJHE5ivQwVFeEt3ngjdtthZVIg9s867mvrQ5tZRDQHl6MuI5Wxej
	 PbMuI82k2MZgn97pXO4gOL8/3tGRu0+RGsNpygaUYm1NZ5P0alfOSgPw1d8RzhZgc6
	 KDexkxV3jBGj1byoHPa9bFt2IUo3bwvmo7ehTxtjBbVrut4HGfmyeBINKgfzjJ/3Jk
	 b/dl09l7z3dvA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jul 2024 06:26:40 -0400
Subject: [PATCH v2 04/11] fs: add infrastructure for multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-mgtime-v2-4-19d412a940d9@kernel.org>
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
In-Reply-To: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18627; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=k0PASpE836OQmpDiHN4nqw4lE+fzWCGQYeajWGV5+J0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmgoR4d+Qh9dTSmgG2/qAL/8YQ5DnZmVHz5gj5Q
 26SkJWRJ/6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZoKEeAAKCRAADmhBGVaC
 FfqDD/99AiugfkF1E1sF92oAzAg2dtjf4IFcm2brKbPuYECLlUFJh3PHAbKzqsq5S2kStxr/lH1
 ntVnl/dWHaZAfAJlbaT4W4xBfri0KBHkIBjPpUHh5/AO1OjGAiQ1MNXnc/8uBAuYC9eSjHzcgE2
 yAN4yYISP7/IGB6FqPx92XXDdHajRkatWPuJJBcqGxn4MbkyIRuwFtLBIcXnAxcXrrP54aCa50t
 +hKCBAGhHcKP6cu3r4T1Jd2MFvTmfeo05xSVZdfLZkY8d3fHH3fAvtYjQQ4P0H2fBn8Tth0+VEV
 NhjwpuLc7UZqJQhXUqZtFxeTfZCokNQUHS8adxg25lwdNcSF8qaOKfvnZ8XFH7tVmnFZNbXEqKL
 49VQV3w1HlRDMpRBNLjhzL7Dx7li/RGuBDN2dO6e9fmzCED7DndXH58brEe3DqDQc2djS0DuRvA
 P+CFUn0S1262ttk8GYySjMYi9NaEFWOwvT1JspqhL5DDxWcuUlea/U6KppjEQL1MjUeEfA5YWzj
 KWC/tRo/ex2eAoYFHoFwcZjuESQ1A2h5BdFu7OfszomkXNVOACoTwI0uLrP4E/XVEu++q5Y7/ly
 +8KnWBSWYjorqT6ent3mqij0CFnjVWILpoG3JJgcPjujzShnj9AaN0LJ99x2n9lLUzUysfUCRLX
 nMv1/GkVEEKYinA==
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
being actively queried. Now that the ctime is stored as a ktime_t, we
can sacrifice the lowest bit in the word to act as a flag marking
whether the current timestamp has been queried via stat() or the like.

This solves the problem of being able to distinguish the timestamp
between updates, but introduces a new problem: it's now possible for a
file being changed to get a fine-grained timestamp and then a file that
was altered later to get a coarse-grained one that appears older than
the earlier fine-grained time. To remedy this, keep a global ktime_t
value that acts as a timestamp floor.

When we go to stamp a file, we first get the latter of the current floor
value and the current coarse-grained time (call this "now"). If the
current inode ctime hasn't been queried then we just attempt to stamp it
with that value using a cmpxchg() operation.

If it has been queried, then first see whether the current coarse time
appears later than what we have. If it does, then we accept that value.
If it doesn't, then we get a fine-grained time and try to swap that into
the global floor. Whether that succeeds or fails, we take the resulting
floor time and try to swap that into the ctime.

There is still one remaining problem:

All of this works as long as the realtime clock is monotonically
increasing. If the clock ever jumps backwards, then we could end up in a
situation where the floor value is "stuck" far in advance of the clock.

To remedy this, sanity check the floor value and if it's more than 6ms
(~2 jiffies) ahead of the current coarse-grained clock, disregard the
floor value, and just accept the current coarse-grained clock.

Filesystems opt into this by setting the FS_MGTIME fstype flag.  One
caveat: those that do will always present ctimes that have the lowest
bit unset, even when the on-disk ctime has it set.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c                       | 168 +++++++++++++++++++++++++++++++++------
 fs/stat.c                        |  39 ++++++++-
 include/linux/fs.h               |  30 +++++++
 include/trace/events/timestamp.h |  97 ++++++++++++++++++++++
 4 files changed, 306 insertions(+), 28 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 5d2b0dfe48c3..12790a26102c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -62,6 +62,8 @@ static unsigned int i_hash_shift __ro_after_init;
 static struct hlist_head *inode_hashtable __ro_after_init;
 static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
 
+/* Don't send out a ctime lower than this (modulo backward clock jumps). */
+static __cacheline_aligned_in_smp ktime_t ctime_floor;
 /*
  * Empty aops. Can be used for the cases where the user does not
  * define any of the address_space operations.
@@ -2077,19 +2079,86 @@ int file_remove_privs(struct file *file)
 }
 EXPORT_SYMBOL(file_remove_privs);
 
+/*
+ * The coarse-grained clock ticks once per jiffy (every 2ms or so). If the
+ * current floor is >6ms in the future, assume that the clock has jumped
+ * backward.
+ */
+#define CTIME_FLOOR_MAX_NS	6000000
+
+/**
+ * coarse_ctime - return the current coarse-grained time
+ * @floor: current ctime_floor value
+ *
+ * Get the coarse-grained time, and then determine whether to
+ * return it or the current floor value. Returns the later of the
+ * floor and coarse grained time, unless the floor value is too
+ * far into the future. If that happens, assume the clock has jumped
+ * backward, and that the floor should be ignored.
+ */
+static ktime_t coarse_ctime(ktime_t floor)
+{
+	ktime_t now = ktime_get_coarse_real() & ~I_CTIME_QUERIED;
+
+	/* If coarse time is already newer, return that */
+	if (ktime_before(floor, now))
+		return now;
+
+	/* Ensure floor is not _too_ far in the future */
+	if (ktime_after(floor, now + CTIME_FLOOR_MAX_NS))
+		return now;
+
+	return floor;
+}
+
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
+	ktime_t ctime, floor = smp_load_acquire(&ctime_floor);
+	ktime_t now = coarse_ctime(floor);
+	struct timespec64 now_ts = ktime_to_timespec64(now);
+
+	if (!is_mgtime(inode))
+		goto out;
+
+	/* If nothing has queried it, then coarse time is fine */
+	ctime = smp_load_acquire(&inode->__i_ctime);
+	if (ctime & I_CTIME_QUERIED) {
+		/*
+		 * If there is no apparent change, then
+		 * get a fine-grained timestamp.
+		 */
+		if ((now | I_CTIME_QUERIED) == ctime) {
+			ktime_get_real_ts64(&now_ts);
+			now_ts.tv_nsec &= ~I_CTIME_QUERIED;
+		}
+	}
+out:
+	return timestamp_truncate(now_ts, inode);
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
@@ -2485,25 +2554,6 @@ struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
 }
 EXPORT_SYMBOL(timestamp_truncate);
 
-/**
- * current_time - Return FS time
- * @inode: inode.
- *
- * Return the current time truncated to the time granularity supported by
- * the fs.
- *
- * Note that inode and inode->sb cannot be NULL.
- * Otherwise, the function warns and returns time without truncation.
- */
-struct timespec64 current_time(struct inode *inode)
-{
-	struct timespec64 now;
-
-	ktime_get_coarse_real_ts64(&now);
-	return timestamp_truncate(now, inode);
-}
-EXPORT_SYMBOL(current_time);
-
 /**
  * inode_get_ctime - fetch the current ctime from the inode
  * @inode: inode from which to fetch ctime
@@ -2518,12 +2568,18 @@ struct timespec64 inode_get_ctime(const struct inode *inode)
 {
 	ktime_t ctime = inode->__i_ctime;
 
+	if (is_mgtime(inode))
+		ctime &= ~I_CTIME_QUERIED;
 	return ktime_to_timespec64(ctime);
 }
 EXPORT_SYMBOL(inode_get_ctime);
 
 struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts)
 {
+	trace_inode_set_ctime_to_ts(inode, &ts);
+
+	if (is_mgtime(inode))
+		ts.tv_nsec &= ~I_CTIME_QUERIED;
 	inode->__i_ctime = ktime_set(ts.tv_sec, ts.tv_nsec);
 	trace_inode_set_ctime_to_ts(inode, &ts);
 	return ts;
@@ -2535,14 +2591,74 @@ EXPORT_SYMBOL(inode_set_ctime_to_ts);
  * @inode: inode
  *
  * Set the inode->i_ctime to the current value for the inode. Returns
- * the current value that was assigned to i_ctime.
+ * the current value that was assigned to i_ctime. If this is a not
+ * multigrain inode, then we just set it to whatever the coarse time is.
+ *
+ * If it is multigrain, then we first see if the coarse-grained
+ * timestamp is distinct from what we have. If so, then we'll just use
+ * that. If we have to get a fine-grained timestamp, then do so, and
+ * try to swap it into the floor. We accept the new floor value
+ * regardless of the outcome of the cmpxchg. After that, we try to
+ * swap the new value into __i_ctime. Again, we take the resulting
+ * ctime, regardless of the outcome of the swap.
  */
 struct timespec64 inode_set_ctime_current(struct inode *inode)
 {
-	struct timespec64 now = current_time(inode);
+	ktime_t ctime, now, cur, floor = smp_load_acquire(&ctime_floor);
+
+	now = coarse_ctime(floor);
 
-	inode_set_ctime_to_ts(inode, now);
-	return now;
+	/* Just return that if this is not a multigrain fs */
+	if (!is_mgtime(inode)) {
+		inode->__i_ctime = now;
+		goto out;
+	}
+
+	/*
+	 * We only need a fine-grained time if someone has queried it,
+	 * and the current coarse grained time isn't later than what's
+	 * already there.
+	 */
+	ctime = smp_load_acquire(&inode->__i_ctime);
+	if ((ctime & I_CTIME_QUERIED) && !ktime_after(now, ctime & ~I_CTIME_QUERIED)) {
+		ktime_t old;
+
+		/* Get a fine-grained time */
+		now = ktime_get_real() & ~I_CTIME_QUERIED;
+
+		/*
+		 * If the cmpxchg works, we take the new floor value. If
+		 * not, then that means that someone else changed it after we
+		 * fetched it but before we got here. That value is just
+		 * as good, so keep it.
+		 */
+		old = cmpxchg(&ctime_floor, floor, now);
+		trace_ctime_floor_update(inode, floor, now, old);
+		if (old != floor)
+			now = old;
+	}
+retry:
+	/* Try to swap the ctime into place. */
+	cur = cmpxchg(&inode->__i_ctime, ctime, now);
+	trace_ctime_inode_update(inode, ctime, now, cur);
+
+	/* If swap occurred, then we're done */
+	if (cur != ctime) {
+		/*
+		 * Was the change due to someone marking the old ctime QUERIED?
+		 * If so then retry the swap. This can only happen once since
+		 * the only way to clear I_CTIME_QUERIED is to stamp the inode
+		 * with a new ctime.
+		 */
+		if (!(ctime & I_CTIME_QUERIED) && (ctime | I_CTIME_QUERIED) == cur) {
+			ctime = cur;
+			goto retry;
+		}
+		/* Otherwise, take the new ctime */
+		now = cur & ~I_CTIME_QUERIED;
+	}
+out:
+	return timestamp_truncate(ktime_to_timespec64(now), inode);
 }
 EXPORT_SYMBOL(inode_set_ctime_current);
 
diff --git a/fs/stat.c b/fs/stat.c
index 6f65b3456cad..7e9bd16b553b 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -22,10 +22,39 @@
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
+#include <trace/events/timestamp.h>
 
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
+ * will ensure a distinct timestamp.
+ */
+void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
+{
+	atomic_long_t *pc = (atomic_long_t *)&inode->__i_ctime;
+
+	/* If neither time was requested, then don't report them */
+	if (!(request_mask & (STATX_CTIME|STATX_MTIME))) {
+		stat->result_mask &= ~(STATX_CTIME|STATX_MTIME);
+		return;
+	}
+
+	stat->mtime.tv_sec = inode->i_mtime_sec;
+	stat->mtime.tv_nsec = inode->i_mtime_nsec;
+	stat->ctime = ktime_to_timespec64(atomic_long_fetch_or(I_CTIME_QUERIED, pc) &
+						~I_CTIME_QUERIED);
+	trace_fill_mg_cmtime(inode, atomic_long_read(pc));
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
index 8e271c9e4a00..8601425ac249 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1608,6 +1608,23 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
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
+ *
+ * We use the least significant bit of the ktime_t to track the QUERIED
+ * flag. This means that filesystems with multigrain timestamps effectively
+ * have 2ns resolution for the ctime, even if they advertise 1ns s_time_gran.
+ */
+#define I_CTIME_QUERIED		(1LL)
+
+static inline bool is_mgtime(const struct inode *inode);
+
 struct timespec64 inode_get_ctime(const struct inode *inode);
 struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts);
 
@@ -2477,6 +2494,7 @@ struct file_system_type {
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
+#define FS_MGTIME		64	/* FS uses multigrain timestamps */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
@@ -2500,6 +2518,17 @@ struct file_system_type {
 
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
@@ -3234,6 +3263,7 @@ extern void page_put_link(void *);
 extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
+void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode);
 void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
diff --git a/include/trace/events/timestamp.h b/include/trace/events/timestamp.h
index 35ff875d3800..1f71738aa38c 100644
--- a/include/trace/events/timestamp.h
+++ b/include/trace/events/timestamp.h
@@ -8,6 +8,78 @@
 #include <linux/tracepoint.h>
 #include <linux/fs.h>
 
+TRACE_EVENT(ctime_floor_update,
+	TP_PROTO(struct inode *inode,
+		 ktime_t old,
+		 ktime_t new,
+		 ktime_t cur),
+
+	TP_ARGS(inode, old, new, cur),
+
+	TP_STRUCT__entry(
+		__field(dev_t,				dev)
+		__field(ino_t,				ino)
+		__field(ktime_t,			old)
+		__field(ktime_t,			new)
+		__field(ktime_t,			cur)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->old		= old;
+		__entry->new		= new;
+		__entry->cur		= cur;
+	),
+
+	TP_printk("ino=%d:%d:%lu old=%llu.%lu new=%llu.%lu cur=%llu.%lu swp=%c",
+		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
+		ktime_to_timespec64(__entry->old).tv_sec,
+		ktime_to_timespec64(__entry->old).tv_nsec,
+		ktime_to_timespec64(__entry->new).tv_sec,
+		ktime_to_timespec64(__entry->new).tv_nsec,
+		ktime_to_timespec64(__entry->cur).tv_sec,
+		ktime_to_timespec64(__entry->cur).tv_nsec,
+		(__entry->old == __entry->cur) ? 'Y' : 'N'
+	)
+);
+
+TRACE_EVENT(ctime_inode_update,
+	TP_PROTO(struct inode *inode,
+		 ktime_t old,
+		 ktime_t new,
+		 ktime_t cur),
+
+	TP_ARGS(inode, old, new, cur),
+
+	TP_STRUCT__entry(
+		__field(dev_t,				dev)
+		__field(ino_t,				ino)
+		__field(ktime_t,			old)
+		__field(ktime_t,			new)
+		__field(ktime_t,			cur)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->old		= old;
+		__entry->new		= new;
+		__entry->cur		= cur;
+	),
+
+	TP_printk("ino=%d:%d:%ld old=%llu.%ld new=%llu.%ld cur=%llu.%ld swp=%c",
+		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
+		ktime_to_timespec64(__entry->old).tv_sec,
+		ktime_to_timespec64(__entry->old).tv_nsec,
+		ktime_to_timespec64(__entry->new).tv_sec,
+		ktime_to_timespec64(__entry->new).tv_nsec,
+		ktime_to_timespec64(__entry->cur).tv_sec,
+		ktime_to_timespec64(__entry->cur).tv_nsec,
+		(__entry->old == __entry->cur ? 'Y' : 'N')
+	)
+);
+
 TRACE_EVENT(inode_needs_update_time,
 	TP_PROTO(struct inode *inode,
 		 struct timespec64 *now,
@@ -70,6 +142,31 @@ TRACE_EVENT(inode_set_ctime_to_ts,
 		__entry->ts_sec, __entry->ts_nsec
 	)
 );
+
+TRACE_EVENT(fill_mg_cmtime,
+	TP_PROTO(struct inode *inode,
+		 ktime_t ctime),
+
+	TP_ARGS(inode, ctime),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			dev)
+		__field(ino_t,			ino)
+		__field(ktime_t,		ctime)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->ctime		= ctime;
+	),
+
+	TP_printk("ino=%d:%d:%ld ctime=%llu.%lu",
+		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
+		ktime_to_timespec64(__entry->ctime).tv_sec,
+		ktime_to_timespec64(__entry->ctime).tv_nsec
+	)
+);
 #endif /* _TRACE_TIMESTAMP_H */
 
 /* This part must be outside protection */

-- 
2.45.2


