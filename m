Return-Path: <linux-fsdevel+bounces-30771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4FE98E315
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B93D1F23E18
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324EC21D2C5;
	Wed,  2 Oct 2024 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jm6HRedi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DB321D2A6;
	Wed,  2 Oct 2024 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895017; cv=none; b=unlwAdLKI2EyUFzQ90QRH2Q8cAu1UywA+OqGC/TanJ2CE6UJem+mpinnmME0xCztaLAk1sMe2JjwG2gXmIFwCO0ZcWLcxrJYDtKApgQUJ32uBWWyfO3pta6FhsAOzyCkkZrBuFZDlg6EwEIDphhNs5xb0KnT0m/dMvz/B9aWZ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895017; c=relaxed/simple;
	bh=5lfqUj45QnwrVOVDCUQ2LnUQUpaLf2LkOjJrAuHMoZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lpLdqVGZXQi7S0Gn3UTPmaxlQ7BXRKPCehq4CpsNHsIBODcNsJYrAaeXum5HRsVwcaRDiNQfoCO5wNa6zHkKcmFEboEQr+kLMn87lzDgwHedVGqCEW2/TwYttyzzxMl9HrJMd5727wirXrFxnXZVXvKCcCCUuleBAXA1UIQhgEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jm6HRedi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D106FC4CEC2;
	Wed,  2 Oct 2024 18:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727895017;
	bh=5lfqUj45QnwrVOVDCUQ2LnUQUpaLf2LkOjJrAuHMoZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jm6HRedi2Q60O4WQojXVg3EB5FKC6fOcQmmc4GVn15b3YoEq4PV32Ke+gosH12scW
	 ZA/OJDgT+bGZqSFB8tYv1Nu95tP9tX/WsSDsJbQHCL3AyogLZEh0zLrma9PWJ1nIrT
	 NSY2QlJUNRav/+H+Yw7d2rFEPSugIhsR45BUNMWKpWHyPNq27+y59g4q9yAdjOmXqV
	 nbJgviE1+jI7KcfVv5Cycj/JmtM2r9ahjOMRT2Bywld/m59TqSyX83HiadtrvAjTqk
	 3/uhTK/fqS0vs2ic3LAtWV7Ko7NgqqmzTB1TLgaSqJZQtVYXMpj89vOBkPP9SAAv9B
	 c8MpznLyLLWdw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 14:49:37 -0400
Subject: [PATCH v9 09/12] xfs: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v9-9-77e2baad57ac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3012; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5lfqUj45QnwrVOVDCUQ2LnUQUpaLf2LkOjJrAuHMoZ8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/ZXNFfizrIh/qPxAkXi3xFswOUBA7q6HVl//Z
 Nf0eicKVQaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv2VzQAKCRAADmhBGVaC
 FcWND/97d+O8sPWKiT3s4JXUlD36zTj4bC7iSHTr7j5GsNtEzs9iTbJWkglnCEmxZn0WgdU2etT
 qLFxnGJKGOYK0BrOmozKkvSjXv13cifuCouB7vaZLA5/A74OODCGwYqYmz8YYs5OtKPdYs23wqA
 dZkGEObXPWuK+drG8PgNLQa13hlXjJ1oBZAzRTv6bmU6PcC9cBEYJoVyCBaopcQPJw2pJAg73kL
 LuVLq/U14v14gWmxW6+NSwCpOVlGr15nQnGhqaAC3SkFTL5z/+Fh7N4VJeVD0IBRoQyyEwJJwe4
 edg7P0IoKfQJyaqUugCZ9u2f8YDAa/MZJKhjzoWGyv+QF/iyQtrn8ZHPnY5UyZ8ujoHZlFt40d0
 2VhpIHgeNYS4QKAqTHP254a4VeWnI1n6xzQi5pozOsPZEo0b20E6vpjsngvI5K/p6rgwcF3ZkAc
 W5JUGqSt/j2RHkECa6m69Imp2VoCJ4xR30/iFPJbo0gPaR7gG7PERkBYsgUJfws1QbPqf2aK91a
 l+NTBUglrCXw3hanZ70+Z2xPr6xn2djNAsDy7UG5/LnzOr7QOJEL/Zd8NUKLJuDOV4tZGw/fOPX
 O2ogtnjx7MlR0WP3SAUn8Dhr1qLqO7nLO6zypRI/QJra+c7f4hB9XH9j1JTHVkMTxb4KQYkTvL2
 eb4Hq1xvi9JVh6A==
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
2.46.2


