Return-Path: <linux-fsdevel+bounces-56084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681D7B12B06
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 16:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0B33BE6CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 14:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97E2289833;
	Sat, 26 Jul 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHbAY46e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB1C28936F;
	Sat, 26 Jul 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753540333; cv=none; b=Wyodpvx0trmnTSkgltkO23Gnh7vVbgi9KextIQX+/xxqgzcVhxgqhKdMxWa/Q6kUm6wLssJblqbzTKuFUokJsW6j9AZGS3tQaU4TODfR61AemoZ3DIGs8stVKdmIk/7QR48eavTUmPPIFAbvFy/SdI2oq55iFGMJ4hl4LPYBwtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753540333; c=relaxed/simple;
	bh=NtCz+vb0FJ2RTT3UYGTBXP803cbE2/PCFHkn1707tww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A6CXd5h0ruZIMEkCI/13r+g9tUbHJlWLoljgTXDHyEK76srnN6ZS4P1aqOUV8AHz+ENX0JTHuao28nLwxJgmgnFoTL96kl6IuoGcS/DDw7BzJOSHIgJtNg1JoD4Yh1JrBQuDIfY0Pv6u9OlBzmb0ulmoPA/bHeQqr6PH2KwfvqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHbAY46e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB26C4CEED;
	Sat, 26 Jul 2025 14:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753540332;
	bh=NtCz+vb0FJ2RTT3UYGTBXP803cbE2/PCFHkn1707tww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iHbAY46eB77ibHvlOxhtGzmUE1sb1iFmTO63dvTqcMnmlJQwUzKz0BC/lQ0Z4QQdk
	 aKIQRRtMn5D7Hf+ol/ujlcfxUbdSkRMJw7bHJUOcBi7JlAlyOy348FrXwj5EQVYmMD
	 CUt/ErbZle8WvrmsP031QpxojFFrn3JgcUbCNrziVp56TphPY44XM/OYxv1h64rdsC
	 mTsl9OAKR0quCyG/C8ncrtnCxUeh8c0i71Rki+0toE4gLD24K5peRPXwt4P2hhBlVa
	 LlcWvU1zlulgGb8gGz3/m97bte57iVgf/xLfnguqo7IlqOhUe6TWmgZ+dH5gI4Xy1b
	 TLmqX4+/YEbww==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 26 Jul 2025 10:32:01 -0400
Subject: [PATCH v2 7/7] vfs: remove inode_set_ctime_deleg()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-nfsd-testing-v2-7-f45923db2fbb@kernel.org>
References: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
In-Reply-To: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5364; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NtCz+vb0FJ2RTT3UYGTBXP803cbE2/PCFHkn1707tww=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBohObfe2BC+vdrfTiozPM03vDHTOGmPGlfSvgEP
 FnJ33MaV3iJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaITm3wAKCRAADmhBGVaC
 FRlMD/9CXJXXovQtZBYhhN0mZIjmM2OgSM/Qn1wsOwJygUX2FkKQuQKm78o8x71HdKYq0YJgyBX
 vUmxutDHxFHyo/EtVIftLtmSYFSqZWNm5L9NmeSG6Rr4TDIbRCDDgBcaMqwDelSjnaNmRFMkSXp
 OW0oIjbl4MjG2u388ktJtp8Bpw9Xb6LZW8876aNBBfyxu57EAxGjE5qs8TUMj+z3xiejJtTX5uQ
 CJOMR3AzqPHRcv7uoXusmVQ3v+yuWRXgoM7PMCEXLW/xwWGm4QfFvJxB/JEHw1fdKILHNQLjelx
 5+bEJ7Y8WtNTiqQIHjaNWwIaTY2441Pic0N4Y0KzV360bec3o8fFkZl09gzEvAfwMA4Dt8SQEKo
 ULTIT56TjQnQDJffjwrDnqDy1deFe5VkdIViIGXTegxYUnzkp1G2w1TIXhrLeQl/RxEmzNbxfkc
 RRZdUsOJlFGsEIjZdHMXIjas7zOurEwkhbQx11y4z9PFDOof5P18oglPNTP2Tywp+uE9366S03m
 J70xF0FI9UWi2P6Ah0AZ6NITqr9gH2mb1efquuNHMSj9BSH9r3V9wEMFukBcXDGb8ny2MieSMcj
 wMp8fJPYhOJ6v3NQgkcX56f+j+wl7bHQtmthiUbD1Yd2YP5s0qvW07SeasopAtS3qpNmN29diOS
 cV/EMgqPxed7ulw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Now that nfsd is vetting the timestamps internally, there is no need for
this function. If ATTR_DELEG is set, then skip the multigrain update and
set what was requested.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c          | 19 +++-----------
 fs/inode.c         | 73 ------------------------------------------------------
 include/linux/fs.h |  2 --
 3 files changed, 4 insertions(+), 90 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index f0dabd2985989d283a931536a5fc53eda366b373..e75f06b760015640bafd596457cd14c746c7e272 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -287,14 +287,7 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
 	struct timespec64 now;
 
 	if (ia_valid & ATTR_CTIME) {
-		/*
-		 * In the case of an update for a write delegation, we must respect
-		 * the value in ia_ctime and not use the current time.
-		 */
-		if (ia_valid & ATTR_DELEG)
-			now = inode_set_ctime_deleg(inode, attr->ia_ctime);
-		else
-			now = inode_set_ctime_current(inode);
+		now = inode_set_ctime_current(inode);
 	} else {
 		/* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be either. */
 		WARN_ON_ONCE(ia_valid & ATTR_MTIME);
@@ -352,19 +345,15 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 		inode->i_mode = mode;
 	}
 
-	if (is_mgtime(inode))
+	if (!(ia_valid & ATTR_DELEG) && is_mgtime(inode))
 		return setattr_copy_mgtime(inode, attr);
 
 	if (ia_valid & ATTR_ATIME)
 		inode_set_atime_to_ts(inode, attr->ia_atime);
 	if (ia_valid & ATTR_MTIME)
 		inode_set_mtime_to_ts(inode, attr->ia_mtime);
-	if (ia_valid & ATTR_CTIME) {
-		if (ia_valid & ATTR_DELEG)
-			inode_set_ctime_deleg(inode, attr->ia_ctime);
-		else
-			inode_set_ctime_to_ts(inode, attr->ia_ctime);
-	}
+	if (ia_valid & ATTR_CTIME)
+		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 }
 EXPORT_SYMBOL(setattr_copy);
 
diff --git a/fs/inode.c b/fs/inode.c
index 99318b157a9a13b3dd8dad0f5f90951f08ef64de..f45054fe48b8a0339e60fd2aa17daaad5a7957e7 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2783,79 +2783,6 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 }
 EXPORT_SYMBOL(inode_set_ctime_current);
 
-/**
- * inode_set_ctime_deleg - try to update the ctime on a delegated inode
- * @inode: inode to update
- * @update: timespec64 to set the ctime
- *
- * Attempt to atomically update the ctime on behalf of a delegation holder.
- *
- * The nfs server can call back the holder of a delegation to get updated
- * inode attributes, including the mtime. When updating the mtime, update
- * the ctime to a value at least equal to that.
- *
- * This can race with concurrent updates to the inode, in which
- * case the update is skipped.
- *
- * Note that this works even when multigrain timestamps are not enabled,
- * so it is used in either case.
- */
-struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 update)
-{
-	struct timespec64 now, cur_ts;
-	u32 cur, old;
-
-	/* pairs with try_cmpxchg below */
-	cur = smp_load_acquire(&inode->i_ctime_nsec);
-	cur_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
-	cur_ts.tv_sec = inode->i_ctime_sec;
-
-	/* If the update is older than the existing value, skip it. */
-	if (timespec64_compare(&update, &cur_ts) <= 0)
-		return cur_ts;
-
-	ktime_get_coarse_real_ts64_mg(&now);
-
-	/* Clamp the update to "now" if it's in the future */
-	if (timespec64_compare(&update, &now) > 0)
-		update = now;
-
-	update = timestamp_truncate(update, inode);
-
-	/* No need to update if the values are already the same */
-	if (timespec64_equal(&update, &cur_ts))
-		return cur_ts;
-
-	/*
-	 * Try to swap the nsec value into place. If it fails, that means
-	 * it raced with an update due to a write or similar activity. That
-	 * stamp takes precedence, so just skip the update.
-	 */
-retry:
-	old = cur;
-	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, update.tv_nsec)) {
-		inode->i_ctime_sec = update.tv_sec;
-		mgtime_counter_inc(mg_ctime_swaps);
-		return update;
-	}
-
-	/*
-	 * Was the change due to another task marking the old ctime QUERIED?
-	 *
-	 * If so, then retry the swap. This can only happen once since
-	 * the only way to clear I_CTIME_QUERIED is to stamp the inode
-	 * with a new ctime.
-	 */
-	if (!(old & I_CTIME_QUERIED) && (cur == (old | I_CTIME_QUERIED)))
-		goto retry;
-
-	/* Otherwise, it was a new timestamp. */
-	cur_ts.tv_sec = inode->i_ctime_sec;
-	cur_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
-	return cur_ts;
-}
-EXPORT_SYMBOL(inode_set_ctime_deleg);
-
 /**
  * in_group_or_capable - check whether caller is CAP_FSETID privileged
  * @idmap:	idmap of the mount @inode was found from
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f18f45e88545c39716b917b1378fb7248367b41d..08f2d813dd40b5dd4fe07d9636e94252915d6235 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1657,8 +1657,6 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
 
 struct timespec64 current_time(struct inode *inode);
 struct timespec64 inode_set_ctime_current(struct inode *inode);
-struct timespec64 inode_set_ctime_deleg(struct inode *inode,
-					struct timespec64 update);
 
 static inline time64_t inode_get_atime_sec(const struct inode *inode)
 {

-- 
2.50.1


