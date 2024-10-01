Return-Path: <linux-fsdevel+bounces-30484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC9798BA71
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9B528495F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562561C5793;
	Tue,  1 Oct 2024 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBF7R15b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2CA1BF7E8;
	Tue,  1 Oct 2024 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780375; cv=none; b=XIKf+bMKTBh55HTLJtkf4WbW6lg6+yu3JhHKDjby8hXhKztbV0FlWPo7qmu695PyUCmNK+3W0ACzfoBQxlWiIF8z5BJPo+9gohjYfqNwSIWkpoiV6WG/lW8D4UhHyaBz3nwtH2tiV/G2sMAyetwgspYF8EIkyyhJGWT77AWpLEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780375; c=relaxed/simple;
	bh=m2lMTjAgLXYxRt3GuKTCEjdRkZam4zPki2ETeaDm/ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DzXwvhop4YW5LCCwwC3OBPjpr0gsH65MLx+V2psYI04mWnYBZDz21QbSRG5OpxM4a9rQmqDXtNMrKnQRKmLt8Bf6V/P1QFE3dHZd1/14kqRURfbldL4pmSGBqDZEQOzV8C8cnX51zR3oEYOcqUh5NwcGN7YWExfIucY1CQlwidM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBF7R15b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF78AC4CED1;
	Tue,  1 Oct 2024 10:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727780375;
	bh=m2lMTjAgLXYxRt3GuKTCEjdRkZam4zPki2ETeaDm/ao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OBF7R15b9rIqKG+pvtE6rj6OdW0IgTIhklVWXvyfUcsAXEMiM+5A8qs8rYSkp6MC8
	 WzVD1hANjS7mrm4m9IIzd7x0nU4N+ZQ0oTnkeZzxiWtA7aZ0Q2zGiCcWu7rNV4TDvv
	 vY5EZhnCloVawAC3X0cUHyBeCgMoFAJvdg83/nwaFXGrYvxuDVPp5j/1KFrwxAPUmc
	 nw9YRak3vLrzUcqSw/dL8+Rfg2LfFMeBxk61HLuWD0RUW/74imBhdVzQxLTxVPfZ86
	 A8ckKa4UPYviPwNPHQ2pP0W7sF7oCdsCZsB4gHDbafgswTs3QldFrlY9qPIW5r5+PD
	 AiNA2CAE8nGow==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 01 Oct 2024 06:59:03 -0400
Subject: [PATCH v8 09/12] xfs: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-mgtime-v8-9-903343d91bc3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3012; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=m2lMTjAgLXYxRt3GuKTCEjdRkZam4zPki2ETeaDm/ao=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm+9X7GLL7kNWVIqPbkvgTfkIdHSTFGll+0bhu5
 4aE3jIwHdiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZvvV+wAKCRAADmhBGVaC
 FaInEACrL+q8404CLEi/39DzITks0kx3KFB40IxDLDYM7C53Oow0+1Ouq7o4SsV4HwHWj9/+gUk
 VPV50u0AiO/cfPNEGjdD94ahfvh7mWZitnVrIoEjaxeRFWMnJdt9boNh7PSwMvSgbsQxKwDitEA
 xQc6nANNzxjz+taw7eMsTn41hLmZ2CYkEgr66NyNh0H4sRGPh/9SbYeuGshQJ5r9jHcXxEGBoEc
 j1IuRH4zy++45mvBxNn73FDMnWTFcjdkmmp+RFJsvdDNv/wdPVIDBQ8vQvwHUwSG0M1/y/s3z5j
 t9hpYhjJ7hVbCWtjI6xliIjp20ftnaNG2gjVzfU1vQZZmjYypYiwSNpuavnnMOmyqumq3Lqk0Lp
 b/ucLYQc/TjkkS4Rp7RVFxq1FE6nP9df9YQ0+itMOwTRnLnz7U6qGL5jI9uQkb/GeGbURVaH0kX
 rKd01G645FLE8KuX19ir4hMW8hqMjaNux6D664rxNlVaqH0O5806S8ntjhRcm4K5a5qCtDSHAsz
 59gKIxPSNxFFFRxbX/ua1Djl68hWL9viBhwV0HF/k8kwxGKSPeNdYcKfDQi/E/MnjFPPRU6gh0e
 RU50fMUFq7x5jUN/T4sFPyVEyDtxRONRQCMUIPkD1/6dEiU3Ybt4li3Fb9gN0c255JmbZOohyj1
 5L1Zb+qBAeoVzdw==
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
index ee79cf161312..b5d0c5c157e7 100644
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
index fbb3a1594c0d..fda75db739b1 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2063,7 +2063,7 @@ static struct file_system_type xfs_fs_type = {
 	.init_fs_context	= xfs_init_fs_context,
 	.parameters		= xfs_fs_parameters,
 	.kill_sb		= xfs_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("xfs");
 

-- 
2.46.2


