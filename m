Return-Path: <linux-fsdevel+bounces-23297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ECE92A65C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 17:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130F6284D1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FAA14EC41;
	Mon,  8 Jul 2024 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXc8Q6z/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B011145332;
	Mon,  8 Jul 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454041; cv=none; b=g8AsUCew7qXrs6rZaOnbkntdcL2CTws+Rb1HiUc0Muw1JQZwTcPbMr2EWmrKMw+0gV2WifS1ihIAtdCIJ0oNAP4AM2Lziq18Vu+3dtEuxV5WRwrQTHRY3alQQihusgQxsliev4n2CmmB4gITR1fFrjuQFW/Ddj5aOS7EFolSIlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454041; c=relaxed/simple;
	bh=fHx/mgJgehSKKeWi0EcYG4swNcOzJbq5fDt162sYPoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fiFt16UIKy+gBywFmf8zXi4w0Qo1TTFrX3Tdd5W9Zpzxsr6VYt2kNUQBCap5Nuwv1hd/8QLkCy+tf65pPIs/9gCsnAxLbN2LqrHY88UjHNo/mm1XbQA8UBFep5JwdkSpa6+zcSPlNlG2/rR5KGgPKcZk5/db//2jNf3Mcd9HFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXc8Q6z/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAF8C116B1;
	Mon,  8 Jul 2024 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454040;
	bh=fHx/mgJgehSKKeWi0EcYG4swNcOzJbq5fDt162sYPoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EXc8Q6z/aA2iTbREyS3/WYORlttsAC9FwB+JrPR10EM/hOgWC3OmmPTatPQ7d5ZBK
	 kUaYZpsX/6HPobJ4W/+IWz3lQRfBIhUqrC711O6DOSp//+rx8t+N6q+uwoPffBnRsY
	 0kfEB/LKf/3wlX3DOUKRz7m79YYVSaYkPbvPNQykmKrSy40XI+TvAA61vXTM7rY8l0
	 0XAtOI15t2eU02duhM8H2AD/8ivNp38watuSC449U1tQYed6ZzsmoAuOL9KDrI8sbV
	 I/4vbT3RgYKakJu5l1YLmpI8ryXYoKzVvNOmFKSMjn8T27D5hx7aAVF47h5/k83RlA
	 uAaL9ZTAMWzbQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 08 Jul 2024 11:53:39 -0400
Subject: [PATCH v4 6/9] xfs: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-mgtime-v4-6-a0f3c6fb57f3@kernel.org>
References: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
In-Reply-To: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>, 
 Christoph Hellwig <hch@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2796; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fHx/mgJgehSKKeWi0EcYG4swNcOzJbq5fDt162sYPoU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmjAuEMx+U894kzOliT8PIHuyLbuEhBDG/6A47f
 TNcoicTlx2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZowLhAAKCRAADmhBGVaC
 FW32EACrJh37KQ3iCcP1FmPHSbhmc3lsquIR/ezsNSLqPcIYhcO6b9Vji3XCEokY8WXsfjZAZS8
 R9/+Nnm6TSKeljPkYd+yPMpxp3T0jxCZkvYRyED/848A9fnnKx6OeAi4SzryA45leaHiEDRVQCX
 J9PNYkvOrJfs15fqhqL8nqcLhztTzgYMwkCn3n24dTD+XFq05JTkLQaEFCmqIdnfyZoOp5Aj9D9
 paE+DUcx3iSah3f8GTFvejGBO+Q+WDqiiyeB4sMTFdyQ4tyZqjyaDmFaF2lSPMVPiNxtIAFP0f8
 FRuiDB5CmvAuClW/3zBlLB3y8m8UWxME46t6vY/qCskxnnJDiV5wUCpEqfRzrgAfX3tBlS+WhOo
 5BvmR6xrJoVht0jwBuaK7T0zoCHWETivxG73i+V3aGxLQYgmmGIHej7twpu31xi3l1aMcgrSi8B
 SS04qjk84jJYZ6VcN5OdQBr+Ol5ERg8nMNrIroer/1TZH34Gws3pLYcLBCiuYRPm4aaGSz8f0CA
 Nl4yZxGznM04yrrOSc6UZGA3z/cjiTfbo+I2W1pHGlFogwZglJkcgrLwGcsnpSVbHAspi/ONUAk
 3dVo8oTmiJCSEQ9+rVTAHNKlHWvqEsqGr2WU1deWTKbhAptpG9VJm4ocBvFjV3t5AAfuZfiCfIe
 ABq16uwiRuXRIZw==
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/libxfs/xfs_trans_inode.c |  6 +++---
 fs/xfs/xfs_iops.c               | 10 +++-------
 fs/xfs/xfs_super.c              |  2 +-
 3 files changed, 7 insertions(+), 11 deletions(-)

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
index a00dcbc77e12..d25872f818fa 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -592,8 +592,9 @@ xfs_vn_getattr(
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
@@ -603,11 +604,6 @@ xfs_vn_getattr(
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
2.45.2


