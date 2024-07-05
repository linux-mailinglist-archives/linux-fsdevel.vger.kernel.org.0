Return-Path: <linux-fsdevel+bounces-23233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1AD928CC7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 19:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 131B1B25B25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 17:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF46D176AB1;
	Fri,  5 Jul 2024 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFNMlHRp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE517623D;
	Fri,  5 Jul 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198993; cv=none; b=J+M6G8BgbBCg04milMJq5m2mIPiX8jwHrfAPGD5679CYXrtlf/EY76FyhIKmzxdcwlRRLydZwe3kd9rPGzUMjNOTPAnMicLlW5aL49jIWjUVb0ZEZJaWhzlaI2UaYGbq4QHUFqa1V/JkrKTGDWiEKU4GS+c3R2p/sgJHAQ+PlAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198993; c=relaxed/simple;
	bh=fHx/mgJgehSKKeWi0EcYG4swNcOzJbq5fDt162sYPoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ArxE8odlUGiO9HWh36TXuWDPX5K46AtZinYXA3E4dE82x4wq0I6OYZKBK/Zmt5sm2rXBlJItiFiQi9eqDQK+xUvVlqhzrdQWk8Q0F5xAuWeJCKrGFza7VgtpbVs7kmAD8rwFBT4vrh+WRzZ6pYih9z+pFZKPlk3d3axXZ71nNVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFNMlHRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD89C116B1;
	Fri,  5 Jul 2024 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720198992;
	bh=fHx/mgJgehSKKeWi0EcYG4swNcOzJbq5fDt162sYPoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pFNMlHRptiCPxoVW4EOiR7WO0/zYXa89l/fPMgoNf5AcD1j0QjfFpk7GlhdsvRwIR
	 5V0uLlGmmChgtw4dhacU78NzZ8i1twVdYClzTvEBMz0xPQNGrpLuMqo3EADhzmgqyM
	 xsvvnJ++uE78MbjIYGF0TWDBmj9VtzLwUhUKIniPBDV/IQQPrbCOkHeRHfyzR4FECJ
	 XyrfqlypAWzBkUXaSIigSGZhQRlBuohxlJH3yYWjHB4/yUqOJ7+IbZ/HABim6RnL8J
	 jqKGc5+xcE7OOh+CBSmCNtZju+LvwHcbs5euvDPZxaOJk5RLEdSiWUv/sqy36PHLJG
	 r4vH5xiDFZnxg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 05 Jul 2024 13:02:40 -0400
Subject: [PATCH v3 6/9] xfs: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-mgtime-v3-6-85b2daa9b335@kernel.org>
References: <20240705-mgtime-v3-0-85b2daa9b335@kernel.org>
In-Reply-To: <20240705-mgtime-v3-0-85b2daa9b335@kernel.org>
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
 Christoph Hellwig <hch@infradead.org>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2796; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fHx/mgJgehSKKeWi0EcYG4swNcOzJbq5fDt162sYPoU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmiCc9e+P556Il0il5vHp8BAdjtXPeX1e8EOhLP
 jUf6awt9NKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZognPQAKCRAADmhBGVaC
 FWn4EACQjm4ox/0vQ42fWfEHqD9prX/Xo8BUzeI6USK/05kred47VvYUJSEcRdTLyFRqI1YZMDu
 FvBotyrGsb13AYuiDIfYy3zG+irqrknjR/TJVqXQAYLOTUjAy1xuO6q4LA3bk+FVagWda/+mZqm
 EmcQLal71uzaxW6ngdjZKmhzW+TuxollfsiibuLXPExM8txA8FdcOQPVtm/f9Z/LtcPkvDupdhP
 FtJauLfBdtkCEXTsM03y71zEGNqTcpKZ2eXs8Pon/FENIvMcs+0+2oWSZdqkDfXBUVCNj0ESYj+
 9b6r/3qoiF49U+hT2eJ8C340v+dsB+FccYmGcuRiOIxdyIIcK4v323FwKe+0uyisHVw3azzx78w
 WMN/q6SJWSmf2edEhQ13rNyxGQptQLd9ITLvZX5PAIMIURo0/dCYdIe2zW8zxsfJ/1DbzdXUbKz
 6N2a4tmjRKf2ohgQ8XMijdpPBfAcuvPluQvYfOQ0USRlErrFMEqH1/p+Og6eL883YkRKPtk18T9
 zbrETeNMx68HzXu47YvKDGhJmv0RhYPFw1e3Od4FisiFMrCZjAo/90b98KFG+4/BE+DB5Xf/r5Y
 Y/76lodMQOMwaJf5jlk5g0l6x7gpzgNg8KoX5mmXq4uPlap+0OvHF/hjQwjsnU6ij7Fy176ax0O
 TylVmfjyKXvtWUw==
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


