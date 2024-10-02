Return-Path: <linux-fsdevel+bounces-30795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 900B798E52B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093101F2124D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316BD22168F;
	Wed,  2 Oct 2024 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXWl4i2t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3822080F;
	Wed,  2 Oct 2024 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904476; cv=none; b=JzL26qBLm0kt18iTokvi1pRE67SY75XdCkp1Q0o7aILhjsFhMg5ZfAueu9dQlu9ysNdrOJe1KvC23hi1jmEef2eLTxr/fHC5xFs4UbjfmYQrZ5d/qhvVDGZxks5i/ShGcq9P9nN9nvKx4w1jR7+oEvDUGkkjOTOg1E82E8ZXW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904476; c=relaxed/simple;
	bh=9HLO3XpJ6HpHWAPYsUm3tCO/nrjDoz9ag2++QNPQia4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RsYSSR33790YWUAJathr50UUxnydwwAX/mEO+IDco/TICYB1ZA1nDZO7q2E8ch1UDg0FPK/4OUQcBu14Vvqt3xLl/LRZXZnRnJGuuFzEKoCskfpgOp/DRz5d1AD07KnwcP3BuZxlvJpb8pEdLntsqRcqg7/cEoNWmb4Ty+unwDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXWl4i2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914A9C4CEE1;
	Wed,  2 Oct 2024 21:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904476;
	bh=9HLO3XpJ6HpHWAPYsUm3tCO/nrjDoz9ag2++QNPQia4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uXWl4i2tOgGIMLmuU2mUUroSOWL29/JUAjRh0jzUJWdMog/Qki/kBoa/LFSdc2CUU
	 pbqa6d6QQFcznz/kcCHUnfBl+25eDBB/bQYt/vvfh8OZEglDW3g8h5YdVUtCjUJk7b
	 UfrPAvDtVdFWByOtLKzs+YcAcV75KOpKC8mHwHCuEW4JgLL7C+I/NtrpeJleBPEiz5
	 tR6gVzMvmjn5B2Iz5vobADmFD3VOCf+5OLU0HnF8a2ppRPEpGzBJqgqgBs1vpr/i/h
	 xH5/4CE0eT8F0g38OYLaDbrwU3mpOZ+7mD6rmrfrTEeZSTGIi2IjWjnuNmmcOsesiL
	 oPkUk4nFRh92A==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 17:27:24 -0400
Subject: [PATCH v10 09/12] xfs: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v10-9-d1c4717f5284@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3180; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9HLO3XpJ6HpHWAPYsUm3tCO/nrjDoz9ag2++QNPQia4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/brAZIqVIJKeyaxoHylxGxKgRPgUJZI1VhJRj
 ZnV5Y921g6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv26wAAKCRAADmhBGVaC
 FUffEACv5L7rnY+EMR497bJG5/8S/s1wJUfmdxaoCDG+LnQbH78d++nzXjCVGoIfX/y7IJQDIfn
 gM0wlLMYm/efC/7UmR9O/T9jiLQgBrRtaYaPLRcn3puzRSl5C8bOeZ0l3/jOe+501U/1OnL556c
 FyiMZQsOWor4MSyzHHPbU1rY7gk549eNccvj+67f3WpNM6Zn9CHM7dUv3QxvweREeQo3FRm0+jN
 CV6uf/GSmzRs8LBhKUpsiqMSBi1unsyQTPnOZBDWdo79OU8tsyUq0vWEOxYGMunxNJNyX/lfjNC
 hXAZAgp1zWvKl/M1z2GlAIq6y2iez2Vi7H6zrizbo8maTFOf/4wb+de4PNAPQoYK/BjVGiPcSpz
 uRhGofidblAaoZQ8LjepNkc6jtOKrOMd4qzluTWZ3TFu6JMP2hbkupUV/0i4NiRpOzHFUPxIHcT
 tM+QAnh8ULcL9xo1NVhsl0FZ/l9s55MnO3A/QoR/FMr3JiT/d6j2t3Adtn4FVTk8VxZjJMldfdw
 IWbxlJEjfMlYoSmyYGh514J3VI0jNyFV1sAi5fJaZBzZRDVToqGzcd6wQa7KavYEMC2FjZwhfuB
 TNkWp8Rnabq2rXR4Wq7krJUS3NYKYM1WY6gRph1rGxF1TfhvTaOucrIB1uPPyWY9Y3fdv6EPg0N
 rjHopf6H5bbG1NQ==
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
Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/libxfs/xfs_trans_inode.c |  6 +++---
 fs/xfs/xfs_iops.c               | 10 +++-------
 fs/xfs/xfs_super.c              |  2 +-
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index 3c40f37e82c73cf871bb252553331b60c6b1973b..c962ad64b0c10058c1e2eecf664fbc67ec7302f2 100644
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
index 1cdc8034f54d93f4a40ab3e3e4f91c6c9dfed7ec..a1c4a350a6dbfd19028ccecdfdb271879f769ccb 100644
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
index 27e9f749c4c7fc75c3385aba2e02ac9fc5d1719d..210481b03fdb48fd50e9a7a109d8bcee0e7e3a29 100644
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
2.46.2


