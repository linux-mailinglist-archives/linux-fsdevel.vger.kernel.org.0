Return-Path: <linux-fsdevel+bounces-29321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C329781B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740FE285605
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DEF1DEFCF;
	Fri, 13 Sep 2024 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fl8X3cLS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97EB1DCB2B;
	Fri, 13 Sep 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235672; cv=none; b=qEyMt1y02OpvMuNxTrHA6WbxzYmlHULfEVKg/AbYh0+9e5wrIGAT7vULqbv7fKTJmUuQc2/D1HSfWqC4vCOmFXz1N991UGn7oh3ITc7U875HxwabmNNBbXkl5jsaTOqVvX9uQgmwaS0kSx9754wV3XPP9K+kekGITcJCPP8Y5oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235672; c=relaxed/simple;
	bh=hdc3HuXN78tnJke+lsjFRc8MIpdoXqfI1aIZo2Ph9do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMmntjWaBWq4bhuBR4AGzbQsDws4u1notiTmqxyi0yQX/s6tD8mQ+vad4dcdompq8EfwvUeN+ifb6ZAiGo6d2H8XZlPuoaLuS/d2GjFywlizk70tfj4zwkNrP6XsF3imUbCyu0S4tWsWT28ECcoxWRSohViPmNK1UR3G/VAP9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fl8X3cLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44623C4CED0;
	Fri, 13 Sep 2024 13:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235671;
	bh=hdc3HuXN78tnJke+lsjFRc8MIpdoXqfI1aIZo2Ph9do=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fl8X3cLSHojZIjmkmSYV4n4Y0MHgS2lGCRsEJknPf7WD1GMgEqaV67ufmNO5d2WUe
	 49XX5BJCMJJPdQdd/+/K0lkypJS229K2gE/55/J3DaoogPv0is7FMexHVQSMGR2W1j
	 Vdrwmh0kYrFZOeyTFYJcVT8R6/XN9q1qODVb3SvTGDjDpJ/8ojpwL/u61Tu5NvSy95
	 nV7FUWW+5YI3dMDjIIfBOrSAamp42O2lT/fv34w1kXigWtrcLpRO1fi3xh6WXCZhC5
	 kJQ9wRKjcqXz1hReqjy9TiDj+w46N8W4b8wGlVxcsoETWKwF4lopHIbb6SPYyxEAWI
	 WRhZXKraQkpsw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 13 Sep 2024 09:54:13 -0400
Subject: [PATCH v7 04/11] fs: handle delegated timestamps in
 setattr_copy_mgtime
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-mgtime-v7-4-92d4020e3b00@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6206; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hdc3HuXN78tnJke+lsjFRc8MIpdoXqfI1aIZo2Ph9do=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5EQI05miWpOV+IKasjIrj/f2h92GkcTZGaHOX
 i7zmXV5tiCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuRECAAKCRAADmhBGVaC
 FawzD/0QM/rrrncZr9goBf5Fodvc0nyXf5LKp7ptAeNyS9j27/HdizuJeqJN85pMsI6Z+d7O0ZB
 yJtdOR5rB/LlzyQO2tyXlaGp1w9niFn45ega3Y3e3a5jBVJVSCnQfvrBEeuzNILZjt7LLBwUS86
 JB40F60UHoHTsiglLUa0/NPxitwDK/RJSDNLwySzK5dfrO3xO0zOyESEvAIx43QMJw3BwkvbOPh
 QTDhu6GVvb0HfFXv9EbRGoiDK9h2oCyk+FVKf3DJNQezu+QIBHGTH7TJ3VaO6rdESdIXTq6S8eU
 eJS7QDt/VRB46z+xHYc8HozzWOrSg9rI5b65RU9GraAhX76JKl8KdUt6J2rt/M/zHuuWh5gVMi5
 yAktGJy//n2pDhUgslejA0WBSRfeydc+LET6il1YWu4dBUMzn8L2RdtnvU171pbHggj2eInPkY4
 EoBw4Ii07JxOm3v7sMAdGeNDXQL855ydZjyfaMLmIqbes+U/3PQp5fehiCA3v/9Qez7BJmRsID6
 OdSTBy0gE61fj0imPRmKgZBTrepnfUSwY+O8G4HOGGmD0YwPgDfOJb2fuSwwqgxxh4SWeEib5JY
 udf6qVdd0u+unM4YE3oGKxf4qwHSGO7R6emJKLlLQ6qgVHCReeXNOtpC6Y5OULwrMsJe+TbzRHh
 npI0J3yTRNm5ndw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When updating the ctime on an inode for a SETATTR with a multigrain
filesystem, we usually want to take the latest time we can get for the
ctime. The exception to this rule is when there is a nfsd write
delegation and the server is proxying timestamps from the client.

When nfsd gets a CB_GETATTR response, we want to update the timestamp
value in the inode to the values that the client is tracking. The client
doesn't send a ctime value (since that's always determined by the
exported filesystem), but it can send a mtime value. In the case where
it does, then we may need to update the ctime to a value commensurate
with that instead of the current time.

If ATTR_DELEG is set, then use ia_ctime value instead of setting the
timestamp to the current time.

With the addition of delegated timestamps we can also receive a request
to update only the atime, but we may not need to set the ctime. Trust
the ATTR_CTIME flag in the update and only update the ctime when it's
set.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c          | 28 +++++++++++++--------
 fs/inode.c         | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 3 files changed, 92 insertions(+), 10 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 3bcbc45708a3..392eb62aa609 100644
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
index 8ab36779066e..260a8a1c1096 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2710,6 +2710,78 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
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
+ * inode attributes, including the mtime. When updating the mtime we may
+ * need to update the ctime to a value at least equal to that.
+ *
+ * This can race with concurrent updates to the inode, in which
+ * case we just don't do the update.
+ *
+ * Note that this works even when multigrain timestamps are not enabled,
+ * so use it in either case.
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
+	 * we raced with an update due to a write or similar activity. That
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
+	 * Was the change due to someone marking the old ctime QUERIED?
+	 * If so then retry the swap. This can only happen once since
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
index eff688e75f2f..ea7ed437d2b1 100644
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
2.46.0


