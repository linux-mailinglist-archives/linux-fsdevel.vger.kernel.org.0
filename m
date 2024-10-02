Return-Path: <linux-fsdevel+bounces-30766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB8F98E344
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7E51F23466
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 19:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7095D217903;
	Wed,  2 Oct 2024 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m29kn21o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC242217914;
	Wed,  2 Oct 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895003; cv=none; b=fxMuQ12YsP+uUKHe0CxWVzcSmTzFOugM6wooCMP1LYr2vOx2YA5du1AKfQYPPvMPNdjxCkEYtE3CQXgA3ZML9ZXbmbPDC1rvP6yo+Uz2E67WA5WLaF/3JSKXrTi1CbNkBQpkYAJXtOlgqJ/DpNa9Gop2eFP87Kr+M0KY0monSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895003; c=relaxed/simple;
	bh=607LRAQ5lYI/rYHwJWudAw3VqFTtnPId8/VXkMTcyVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qxwJEn6L26SnDqI50EfDJoZMo92/qQsB4SMSdICEh1jYme2yR6k8gUE8srYisy5aE/seDTUENlsau2Zxpa0OZQGNZJ1WV+JsYmHO4mvMos5GASYezoIRh12ut2DgreI+1BuPDo3S747HTl+hLFeiT/r1JCGb4zMy9zczIdkQqHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m29kn21o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F247C4CED6;
	Wed,  2 Oct 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727895003;
	bh=607LRAQ5lYI/rYHwJWudAw3VqFTtnPId8/VXkMTcyVI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m29kn21oThOWn8FA3lIOxu891/RPN4jgBUyw5AcmTnYQW3nxAervpGlIeLy3HbIcv
	 JFgHvNsfXUryLA6XYI9KgtNURXTbcYLjIxf6QiqValFyd36gG4pXxJJon+0/ZWLhDb
	 cB+au0L/oDT2l10Nf0T1LV2RX5mCJhaLiBbZGNcrKOlXfLRTz53NBq2CIwq8BCh/zF
	 AG3ySqlcVwUCQcyqUivBA/Zm1gLSLGw5RfwpH1doHBf6Nk2MWEhb0PcrV5MwKD7f1F
	 XWF1vbWNym0+i8+ZAinFzZlOpVmLnpoxkSDBFp7IS3ykdXbn1De9CGkb/0DONHW4w9
	 IZaD+B9dT2LYQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 14:49:32 -0400
Subject: [PATCH v9 04/12] fs: handle delegated timestamps in
 setattr_copy_mgtime
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v9-4-77e2baad57ac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6217; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=607LRAQ5lYI/rYHwJWudAw3VqFTtnPId8/VXkMTcyVI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/ZXM5rS0bxHUPi1uZgMZGm2lnd37dfflL6NJB
 yztoxeouX6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv2VzAAKCRAADmhBGVaC
 FYkzD/9PTpFx52ZO8A+U0V3o8KkeLeBWD+hZ1Sx6vNZvIFxjnqkOsTXC4Y4vSpq75YZLAUcZfmj
 z6YQNmZaJWgVPZnO8Md9u62OezZuDjmnZZ7+9Xqwyc8+/fMpu7AiLwv9F3LW8qZ0QuEwFZmpdLG
 l9wo9XpuoLGcAOunDit8Pi7nS45zJ3yeEwLtdUGwTGY8ue3SnNVNDKsMyAjKkCiLXUgaL6qDE9A
 FMGf3pyRHNhYbkOJQK9Gi41M+47BttNnuYCVLA5ZbPibqbFovLKbvfbP7EQZjRfELrIDhVU8B2B
 ycIFDvYCfjUmaBNl0BOv21FeHfWOApYJWntTioRONDy3Yh5/oaJqYdpeSXxIZFoNtG1G1mWNjk7
 mBETrDuITMf9g3Yr6+Xf3KKdb19q6Uw/SVcFK/Fqm2FrvVZSpjxaGc8UJ4TGEufO/1It62fQPu2
 YFyelm7XMplEeuGXEuDcOxDXFMr/TgjmEpiOxNblirKPjxV8soK4A9gx6bR4MgBA+33CWaqeo2/
 J6WnYTgFCLgL14H8wKWzVmOcYJl6tXCD07d4GRYA+cijQTkL5VPVlPTPjgQucVnzVxRsRYfXquL
 xP6iHiQWaJzD1OhEXOLzVrnoh1cr/p5xu2HPKSw5GCLdQqUTnH5603gpWXAPXtFAWkYyOSTb1NJ
 Mb24SKJzynhFlhA==
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
index 0309c2bd8afa..c614b954bda5 100644
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
index 53f56f6e1ff2..7d1ede60e549 100644
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
2.46.2


