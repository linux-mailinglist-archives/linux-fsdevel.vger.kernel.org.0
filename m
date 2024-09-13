Return-Path: <linux-fsdevel+bounces-29325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6499781D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91331C20621
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093D91E0B9C;
	Fri, 13 Sep 2024 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Guyg9oT+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4CF1E0B78;
	Fri, 13 Sep 2024 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235683; cv=none; b=qYHTYuZz72k9v+C/zIZT/KCuVTA1USHLNTewuMhV/h8Qrs4/JziOKyJEERLCfud57R9bH7eEiQv3w+8WV0RUhuqteaZAfm5Wyf9G0prIvUdhggYxU/KtZ+OlqxkL/47eQTjr3TViBKT2oEi8pZmfLjA2FCQyh9ljJKo2M0D7uss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235683; c=relaxed/simple;
	bh=bIaGrKHNkJGKwsIp2/9hx+nM5n7ktsZpZECPjECvfD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G9cjPfa7pXb68bFnOyyEQD+zzm8izXwJv4HlM8q1yrz9i7Oe26vYHIhSQGjkdm2+2Yi9KNFpnsHZ/1tvTwWzCeR66hUwUNumtKuLp3+VTJ1eGiw/f5GtHtR3v/pONqr9hiJDtvbrWERclp4ee7zxczcy9SrgMuM0xuXsiGOZl1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Guyg9oT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8D3C4CECE;
	Fri, 13 Sep 2024 13:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235682;
	bh=bIaGrKHNkJGKwsIp2/9hx+nM5n7ktsZpZECPjECvfD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Guyg9oT+NWYbjSrZdRkxccMwDJyyHviLQGBLIj6YRh1eSeYcj5XRoEBPD7kVxR8ZN
	 GyKoNcrB7fZelDhspiG6fdw1NIHAh7Re3miRGHxszHzcBVQP0bPYmKCNAPMnpJqXJP
	 fPsIg2O9jLiYclcDOv/EOPX1bOertHlhi2ReZdPLRBUxHSlL0IhJACB6QMV11/59bd
	 4kjxU5edIebTsYnGfzFc52HaSqqqvT80UDf9XBc6/lqzqJdO7hZs+k2SIAU1EjKEdj
	 SMGOddLaCCiD/ousbygLJCpd7bPcnrZjwP+bGRqKUG79rg6y/+2nqMqzrYe7ZyeZ0r
	 nCd0ta10pN5FA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 13 Sep 2024 09:54:17 -0400
Subject: [PATCH v7 08/11] xfs: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-mgtime-v7-8-92d4020e3b00@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2942; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=bIaGrKHNkJGKwsIp2/9hx+nM5n7ktsZpZECPjECvfD4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5EQJhpcPCTpuesPObcfS93aBbr6jli76FoBN4
 +jNilKD6nGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuRECQAKCRAADmhBGVaC
 FSiRD/9bpuRwwKxqNOXbJWyZS6BnOCIPYZl0DiHb+px0bvNOxAA5lV17DfkdTVRGj4cdiG6hbi3
 bC1wnn994yj4E32dOkwARqFjXzPmPlpBz0WoCR2SNcHHL+h4MySabeo7A7qqL3cuGzu0bFVRVnE
 7dZCwqhvcnKxar/hIzkq0yAXuzqiew/VLCussXTC9PXNj+oCyAbFmgJipL01U/M1vcOICzApCu4
 1EOa0rXnVhR38691CU9nxtf4p+JoxxAYmRVi/lkQKApUceYDJQYg+nt5/Fni+oUL9wid2EPcJ1J
 Hp6aDFYxn+7hVzAtpzM/8E9+h5SzbDaLihsNeZMCJZ/meVGkbeQiMJc6zzeQoc66TCscfCfv/Qo
 Lfcjh0ow2eXeiAIE15FbpYp1GAicEL6VPBSysPi/1Jb8ylPr8GfHorN33d/xs5UMrtmjeV//viW
 ezh7rm3eHTernvy+of89bdQS2IsW6UzbWnFyDuOiVnlC9a/SPzx5qg/XyTzTDveCNUbFpHz0uQ6
 EwLKOpZXD6btK89GykcHWpM8yNAimeIHZ/fOx3hFfhSs/PS6uvIdFu4R/pKTQ3wg+B/lGE9r3rU
 Y5+36ESqCpmzO9xeAll4MeQgsBxsIaXYzZYPN3pi+sKPwFlZf1ttfriEIfWxJxS0ttxGj3FjgoV
 uUfDd4iYB+/XKNg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

Also, anytime the mtime changes, the ctime must also change, and those
are now the only two options for xfs_trans_ichgtime. Have that function
unconditionally bump the ctime, and ASSERT that XFS_ICHGTIME_CHG is
always set.

Finally, stop setting STATX_CHANGE_COOKIE in getattr, since the ctime
should give us better semantics now.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/libxfs/xfs_trans_inode.c |  6 +++---
 fs/xfs/xfs_iops.c               | 10 +++-------
 fs/xfs/xfs_super.c              |  2 +-
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index 3c40f37e82c7..c962ad64b0c1 100644
--- a/fs/xfs/libxfs/xfs_trans_inode.c
+++ b/fs/xfs/libxfs/xfs_trans_inode.c
@@ -62,12 +62,12 @@ xfs_trans_ichgtime(
 	ASSERT(tp);
 	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 
-	tv = current_time(inode);
+	/* If the mtime changes, then ctime must also change */
+	ASSERT(flags & XFS_ICHGTIME_CHG);
 
+	tv = inode_set_ctime_current(inode);
 	if (flags & XFS_ICHGTIME_MOD)
 		inode_set_mtime_to_ts(inode, tv);
-	if (flags & XFS_ICHGTIME_CHG)
-		inode_set_ctime_to_ts(inode, tv);
 	if (flags & XFS_ICHGTIME_ACCESS)
 		inode_set_atime_to_ts(inode, tv);
 	if (flags & XFS_ICHGTIME_CREATE)
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 1cdc8034f54d..a1c4a350a6db 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -597,8 +597,9 @@ xfs_vn_getattr(
 	stat->gid = vfsgid_into_kgid(vfsgid);
 	stat->ino = ip->i_ino;
 	stat->atime = inode_get_atime(inode);
-	stat->mtime = inode_get_mtime(inode);
-	stat->ctime = inode_get_ctime(inode);
+
+	fill_mg_cmtime(stat, request_mask, inode);
+
 	stat->blocks = XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
 
 	if (xfs_has_v3inodes(mp)) {
@@ -608,11 +609,6 @@ xfs_vn_getattr(
 		}
 	}
 
-	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
-		stat->change_cookie = inode_query_iversion(inode);
-		stat->result_mask |= STATX_CHANGE_COOKIE;
-	}
-
 	/*
 	 * Note: If you add another clause to set an attribute flag, please
 	 * update attributes_mask below.
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 27e9f749c4c7..210481b03fdb 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2052,7 +2052,7 @@ static struct file_system_type xfs_fs_type = {
 	.init_fs_context	= xfs_init_fs_context,
 	.parameters		= xfs_fs_parameters,
 	.kill_sb		= xfs_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("xfs");
 

-- 
2.46.0


