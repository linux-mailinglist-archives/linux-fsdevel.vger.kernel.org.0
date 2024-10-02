Return-Path: <linux-fsdevel+bounces-30791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA7498E50F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47FC1C2304B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E265D21C194;
	Wed,  2 Oct 2024 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pErORCLF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3576D21C173;
	Wed,  2 Oct 2024 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904465; cv=none; b=EwOBMlLlvmlE/lt8g3k5m3YpPbamaZLTs76wxZ/Btw9iqpyb+Mmejk9BvpwgldiMojCXMe/QZn+dEtdO+0+4fWxZ95AY3YY5bDadbt+EnmrtG1fgKE8kxi3v1Hu9a4Zp8miucFQqHwntc3Rj+dqnACQ6exACp4qbU47y5R8bBsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904465; c=relaxed/simple;
	bh=GgXDPuj4VTCO+KYXw1W6wA5jmJ8SPd2bLeg/94OOtzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BYgExNlE4Twqy6SCpR+bMxG3Jl81dJWthkekw/sfQSzd65Hz+Ep6+DvQ3xuj629MjBMZZ3D7qFSSysC8TF7Z8yYEya16/xtUx5yhm8gnnEWN3ONKV27VxfIopJ0gLLAQwCTalJMspVoITunsJ7Fd13yjcBtBfc0xNEUGR6XRd4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pErORCLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C01C4CED8;
	Wed,  2 Oct 2024 21:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904465;
	bh=GgXDPuj4VTCO+KYXw1W6wA5jmJ8SPd2bLeg/94OOtzA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pErORCLFbUMtYV6Xg0Q8FSs6oa64pfK8QQ0Y2/53GcZECSBeypOEHAXcefZC1c2Tq
	 nK/M2DGCQG1niK1yXv0WLJLWOr27L/5eLGvZfj6wegF9JGGH3AhxnV5eb9iH3Na9Ep
	 CczJA9ddfxZ72S9kSmFSXcrlzuLes8ZZfp6aov8cqZu1YCkvACsPRLk5LFhVmIPDOa
	 zNbRpMPaHvIm8fNV7gqc0l+mYtzLf4NLo2qaQvjXfMFsIDN4CyZ3MijISmLPCPNomW
	 yrhuvZmXB7WYmqsl/t401/RJz34nyupB8rsbUKUjfJ6QidHDhDlmG0Wh1f1S+Wr0kT
	 wqNcdegxY9Wlw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 17:27:20 -0400
Subject: [PATCH v10 05/12] fs: handle delegated timestamps in
 setattr_copy_mgtime
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v10-5-d1c4717f5284@kernel.org>
References: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
In-Reply-To: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6385; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GgXDPuj4VTCO+KYXw1W6wA5jmJ8SPd2bLeg/94OOtzA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/bq/8ejyIg0PRylRvcQV6hmgwmnKDZHwiP42g
 ghVwS8PaLKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv26vwAKCRAADmhBGVaC
 FUs6EACFaoAMIiWmAxm2JDOYSGBGqYx7XgULFJuHkZorvtP2QGTa3sFuMu0UtasSpV7DnjmXAp/
 58p6rdY498tiod4Ll7n9AwjwsBnmb2P2aPP3L1wpOZV+tK1hk+BnJ7XfM4/P3Yi4Bbut6GpQl8U
 x8jnTYyJFrknCniKjxi+mI91aXA67q5KEqqI8W+ZAr4E8C2Ai3/cD+24VbybY41A52VgelzA5EG
 Ap3liaASdiktai/bt5qbndIJJ2qvjFyn3QcW4Tz0LTSoHZFEY2MRJSO/6Unnl3bsZByuCsgNzCW
 hgi8TX/79pDgk+WdlH6cN7JN1pNFCNC6u8hyp8H+pbBYmHQ2sgy2vTR+2fKcKKtCls6CuTBkCE8
 Lw3Ok0r66ptJdcW4waC3luYXt1KfZc1JpJ/Uw0iMc+jhYjhM8G9GDqFxgudGT60UrBhGkF6juES
 hrhkkqG/rpPnqv6AmU4Z5DtKHp8wR0nrZeiQUu5H0RqZ/MdrgEH+qhEEM0OKOfkbmNrXYtwuTmo
 54WkyE0sLh/y23R41nuZPVgLSJul2Mzx1B3o4zRyc4pX0QiWdPI9CWYp+0ZPwp8fmXkMb+8aVKO
 qIysDBYjA+SkV0rOsDDA7fXhNsMH40A1UN0npUBje6zvkZFqTM4n/myilmcSEbsnFyU46LlFfRC
 8/zxtdFjBqxLvrg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

An update to the inode ctime typically requires the latest clock
value possible. The exception to this rule is when there is a nfsd write
delegation and the server is proxying timestamps from the client.

When nfsd gets a CB_GETATTR response, update the timestamp value in the
inode to the values that the client is tracking. The client doesn't send
a ctime value (since that's always determined by the exported
filesystem), but it can send a mtime value. In the case where it does,
update the ctime to a value commensurate with that instead of the
current time.

If ATTR_DELEG is set, then use ia_ctime value instead of setting the
timestamp to the current time.

With the addition of delegated timestamps, the server may receive a
request to update only the atime, which doesn't involve a ctime update.
Trust the ATTR_CTIME flag in the update and only update the ctime when
it's set.

Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c          | 28 +++++++++++++--------
 fs/inode.c         | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 3 files changed, 93 insertions(+), 10 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 0309c2bd8afa04bc43db6ff207f8a58d9f6a617d..c614b954bda5244cc20ee82a98a8e68845f23bd7 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -286,16 +286,20 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
 	unsigned int ia_valid = attr->ia_valid;
 	struct timespec64 now;
 
-	/*
-	 * If the ctime isn't being updated then nothing else should be
-	 * either.
-	 */
-	if (!(ia_valid & ATTR_CTIME)) {
-		WARN_ON_ONCE(ia_valid & (ATTR_ATIME|ATTR_MTIME));
-		return;
+	if (ia_valid & ATTR_CTIME) {
+		/*
+		 * In the case of an update for a write delegation, we must respect
+		 * the value in ia_ctime and not use the current time.
+		 */
+		if (ia_valid & ATTR_DELEG)
+			now = inode_set_ctime_deleg(inode, attr->ia_ctime);
+		else
+			now = inode_set_ctime_current(inode);
+	} else {
+		/* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be either. */
+		WARN_ON_ONCE(ia_valid & ATTR_MTIME);
 	}
 
-	now = inode_set_ctime_current(inode);
 	if (ia_valid & ATTR_ATIME_SET)
 		inode_set_atime_to_ts(inode, attr->ia_atime);
 	else if (ia_valid & ATTR_ATIME)
@@ -354,8 +358,12 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 		inode_set_atime_to_ts(inode, attr->ia_atime);
 	if (ia_valid & ATTR_MTIME)
 		inode_set_mtime_to_ts(inode, attr->ia_mtime);
-	if (ia_valid & ATTR_CTIME)
-		inode_set_ctime_to_ts(inode, attr->ia_ctime);
+	if (ia_valid & ATTR_CTIME) {
+		if (ia_valid & ATTR_DELEG)
+			inode_set_ctime_deleg(inode, attr->ia_ctime);
+		else
+			inode_set_ctime_to_ts(inode, attr->ia_ctime);
+	}
 }
 EXPORT_SYMBOL(setattr_copy);
 
diff --git a/fs/inode.c b/fs/inode.c
index 53f56f6e1ff26e718080211880924f37cf0e5b3c..7d1ede60e549683502911f3bb3a3a079768e449b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2717,6 +2717,79 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 }
 EXPORT_SYMBOL(inode_set_ctime_current);
 
+/**
+ * inode_set_ctime_deleg - try to update the ctime on a delegated inode
+ * @inode: inode to update
+ * @update: timespec64 to set the ctime
+ *
+ * Attempt to atomically update the ctime on behalf of a delegation holder.
+ *
+ * The nfs server can call back the holder of a delegation to get updated
+ * inode attributes, including the mtime. When updating the mtime, update
+ * the ctime to a value at least equal to that.
+ *
+ * This can race with concurrent updates to the inode, in which
+ * case the update is skipped.
+ *
+ * Note that this works even when multigrain timestamps are not enabled,
+ * so it is used in either case.
+ */
+struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 update)
+{
+	struct timespec64 now, cur_ts;
+	u32 cur, old;
+
+	/* pairs with try_cmpxchg below */
+	cur = smp_load_acquire(&inode->i_ctime_nsec);
+	cur_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
+	cur_ts.tv_sec = inode->i_ctime_sec;
+
+	/* If the update is older than the existing value, skip it. */
+	if (timespec64_compare(&update, &cur_ts) <= 0)
+		return cur_ts;
+
+	ktime_get_coarse_real_ts64_mg(&now);
+
+	/* Clamp the update to "now" if it's in the future */
+	if (timespec64_compare(&update, &now) > 0)
+		update = now;
+
+	update = timestamp_truncate(update, inode);
+
+	/* No need to update if the values are already the same */
+	if (timespec64_equal(&update, &cur_ts))
+		return cur_ts;
+
+	/*
+	 * Try to swap the nsec value into place. If it fails, that means
+	 * it raced with an update due to a write or similar activity. That
+	 * stamp takes precedence, so just skip the update.
+	 */
+retry:
+	old = cur;
+	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, update.tv_nsec)) {
+		inode->i_ctime_sec = update.tv_sec;
+		mgtime_counter_inc(mg_ctime_swaps);
+		return update;
+	}
+
+	/*
+	 * Was the change due to another task marking the old ctime QUERIED?
+	 *
+	 * If so, then retry the swap. This can only happen once since
+	 * the only way to clear I_CTIME_QUERIED is to stamp the inode
+	 * with a new ctime.
+	 */
+	if (!(old & I_CTIME_QUERIED) && (cur == (old | I_CTIME_QUERIED)))
+		goto retry;
+
+	/* Otherwise, it was a new timestamp. */
+	cur_ts.tv_sec = inode->i_ctime_sec;
+	cur_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
+	return cur_ts;
+}
+EXPORT_SYMBOL(inode_set_ctime_deleg);
+
 /**
  * in_group_or_capable - check whether caller is CAP_FSETID privileged
  * @idmap:	idmap of the mount @inode was found from
diff --git a/include/linux/fs.h b/include/linux/fs.h
index eff688e75f2f29f1c44dca96370ee230f8c21db4..ea7ed437d2b165debf680507aa450b2662fd5839 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1544,6 +1544,8 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
 
 struct timespec64 current_time(struct inode *inode);
 struct timespec64 inode_set_ctime_current(struct inode *inode);
+struct timespec64 inode_set_ctime_deleg(struct inode *inode,
+					struct timespec64 update);
 
 static inline time64_t inode_get_atime_sec(const struct inode *inode)
 {

-- 
2.46.2


