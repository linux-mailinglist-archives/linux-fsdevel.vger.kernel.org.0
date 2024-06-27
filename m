Return-Path: <linux-fsdevel+bounces-22583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C33919CB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 03:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC0F2868C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 01:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D2F47773;
	Thu, 27 Jun 2024 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfzWTGRJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92F45BF3;
	Thu, 27 Jun 2024 01:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719450050; cv=none; b=qrw+dWRps3Hmlfd7v7qE5Fh1GAt4ZuhdyvPYbW/RnQcecjKixF8UgnkJVMC+kfXK1WeXy0OtHdbdRTtpFpAX0tjsQHI8+xv5dgcEZTg8LdF8yyK/Iar7jOWYJIwzbEwdiZuknUAbGnRySY3EQCXDrs9rfPmn1UVKc8wIlBcJ1j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719450050; c=relaxed/simple;
	bh=3rezV2gQwo9fH4xuVx823NKSfsCiMN8Xp4bd4oV0yb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aBZ/EOsgwVqCmE3jC9ryTmBJhXwocHN5+1YAleDZw21mW379siOXZXOmF86ZFIC1L147X77ZoiM5kTf+MgSaiA9gAqSa3Fu0Rm40hvQbtepJNl86C30yhPmRRZtdALxxDlCXFHhkTO25/ijWLrUlYBOH2Bb2t0lKqP/e2HuHFF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfzWTGRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F05C4AF0F;
	Thu, 27 Jun 2024 01:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719450050;
	bh=3rezV2gQwo9fH4xuVx823NKSfsCiMN8Xp4bd4oV0yb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EfzWTGRJrOxCHnENJtqkTnFlbrYiNVm3Dtx+RYkf+tPkSUBOWalH+ZJXKWd6RDU3W
	 YbIMpRqootIbyjiSHsXYL4WHyI58VPZgs/rn5wnyd1pNU9Yj9MdEFMFVGSPa0vMIpw
	 erwoqImb0BeLarz0pB1AysZlCkhfHAUmFQvLQiRhTDyqGzMtBV1Voalxm4tbLh9gGV
	 y73R4UwcKJMH6klQe0euDWaZU8vbA2cJ7K37Obxew60jD/3Klcu0JLP27DhEYmMHbJ
	 aP1zaQMbakES7jdHpXa9HBN/Kou4lPJhjdrSc1beOux17fNM6L8ekNdL02W9V2oOOH
	 jW5FYGG+kqj9Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 26 Jun 2024 21:00:27 -0400
Subject: [PATCH 07/10] xfs: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-mgtime-v1-7-a189352d0f8f@kernel.org>
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
In-Reply-To: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
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
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2415; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3rezV2gQwo9fH4xuVx823NKSfsCiMN8Xp4bd4oV0yb0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmfLmvW5qoH8Bt7MTLdRrQHNrS4Yp96iCkYHnk8
 FyVEve6YHyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZny5rwAKCRAADmhBGVaC
 FaFmD/wOagd7+4hFoYYtjpsB5K282B4LYANFzcPFXtXXPlrjjs7Ut0fwhI9WnYgAUHQekuPeK+A
 zDPV0MjYGwTZEDSr5BQGrKKaxff/X/gRbvNZIGsXSb54XtHH1+DEOPktNYObH43KjUfh83Yj3z1
 y+tHn7ZbOu77J4lV2A32MWXQU5+uoLrqOlaYs+9vxFD18XxYQB+eidU8SFupTRIf9va4/KpRud3
 X3FubvF7WzxgFVT4I6tht9+07MuaPmMxFULyqz/ptHe+kIEaCPBcs+zPIZFdc/m6hbz0VnFo1RB
 t5Jv2kgTnFF3pATlt6f4ioOWKct8PJT+2RitCv9Oxysxi60hmwsc1edesy5GJDZIKkyzDJnios4
 vDqLZOvcsR1LwsJh7+1bizC/9FkuOX2Ssv6Kg8CM8wskPkw3HsnD8enqQseE1orfuygkYtW4vBj
 rpsLXWrbOMfT5DnGZGTkrEWl9Yc5j0hS7oJrujxu8WQ1o8qPMwnVMGvo9NRBzBI50ZpdI3iyFg2
 EO+wgd0QFeW9Xwq8k5J/7TUExgdVXaWtMJwtFC5Kf49BfF8iUjfycWKG/8Er65r6TDQo1uWSBnr
 xAdLH+DVUkj8CT3cBfRstYF1uecD1uiUAMU9tjRxn+8uUMcmbLeCsEf4q2HTdAwwLRt+U26Zq4m
 QlSvFJ3+h/BDd1w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

Also, anytime the mtime changes, the ctime must also change, and those
are now the only two options for xfs_trans_ichgtime. Have that function
unconditionally bump the ctime, and ASSERT that XFS_ICHGTIME_CHG is
always set.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/libxfs/xfs_trans_inode.c | 6 +++---
 fs/xfs/xfs_iops.c               | 6 ++++--
 fs/xfs/xfs_super.c              | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index 69fc5b981352..1f3639bbf5f0 100644
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
 	if (flags & XFS_ICHGTIME_CREATE)
 		ip->i_crtime = tv;
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ff222827e550..ed6e6d9507df 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -590,10 +590,12 @@ xfs_vn_getattr(
 	stat->gid = vfsgid_into_kgid(vfsgid);
 	stat->ino = ip->i_ino;
 	stat->atime = inode_get_atime(inode);
-	stat->mtime = inode_get_mtime(inode);
-	stat->ctime = inode_get_ctime(inode);
+
+	fill_mg_cmtime(stat, request_mask, inode);
+
 	stat->blocks = XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
 
+
 	if (xfs_has_v3inodes(mp)) {
 		if (request_mask & STATX_BTIME) {
 			stat->result_mask |= STATX_BTIME;
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
2.45.2


