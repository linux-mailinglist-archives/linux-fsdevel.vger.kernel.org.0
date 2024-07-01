Return-Path: <linux-fsdevel+bounces-22862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D526191DCA3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E3F28936D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02B8158DC1;
	Mon,  1 Jul 2024 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoIm8fOx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A6158D8E;
	Mon,  1 Jul 2024 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829645; cv=none; b=NBBf2Xgyeyl1+whOjHFhtbFlpMvxluH0gx91lV5xJIQZW7+YnnOat71HrmazYDEtNu6T5LhMnvlEQUM+/35wPNOo7hK40gwQEeRaYBgctNFH3lerE1DYQtgDSmRGx32BArm5oR/9QiQfeZnblzTRPgkhkMSqNjApsBJXz60t9E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829645; c=relaxed/simple;
	bh=3rezV2gQwo9fH4xuVx823NKSfsCiMN8Xp4bd4oV0yb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=boLiIued1FRM2p7/PTo0iGfkIeM/DR2erYZH/K1cQ9FFPySVKxXov0XmDwCyj5ZgMlOedtDVvCZ9rQICTbezGZHGfulHsb/sLUD8FiFx+dnny6kbgXHLkHLx83+WsavJ8Q7kcn4taR//Gohj1TtgWRitl2hIU3DXDMPDqAi42Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoIm8fOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52682C4AF0F;
	Mon,  1 Jul 2024 10:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829644;
	bh=3rezV2gQwo9fH4xuVx823NKSfsCiMN8Xp4bd4oV0yb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hoIm8fOxvgPzmo513dFHVds836zgUfxrxsfezK27z2Kntr3Ccg5rPlRJS/pcuTFaQ
	 G7nswzIu1YimZVBpLt7tQ5R6wV/HnPx6uLZf2soZ9CDKUEiM1HbqumyTLOAtAhGSRs
	 dAzFAeU98Qt38QvyoEzTu/NUkjoaSl8SMygT6pZqJFR3L1IXv5HQ2CPufxSzjXBgK4
	 y+fhw2lAgFR8p1dCadTicB4AiZjS+CB1XRhJmPjezrEVQzpECRnkbNrXvLSLiaWrTA
	 +NkFzxvPw1OLI07XYsbox0HFVMI4AW4yn/F3tEhNy5CEavJdxRJGiMM+3aQGUlhlSp
	 6PPMnfpqL+M8Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jul 2024 06:26:43 -0400
Subject: [PATCH v2 07/11] xfs: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-mgtime-v2-7-19d412a940d9@kernel.org>
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
In-Reply-To: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
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
Cc: Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2415; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3rezV2gQwo9fH4xuVx823NKSfsCiMN8Xp4bd4oV0yb0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmgoR5cLVAd2Hpbh4iHcyU1JIMfk9nPcm3mtCez
 brvBsNENdSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZoKEeQAKCRAADmhBGVaC
 FVuvEACzNm2qzQAUpqWzHATLlmoRJtc4IZ3mD7e7Bpup8hkgbhrDAgwtnQCYG0W5P2FN/cXmVsw
 zLsXXNiPYrqBbATGE2FHsw2iBydcNbvaPxYDojlywTrFteA37WCi+soABdZFVqKaOrVaBOPUnA5
 0npisxHrgjo9W63WFyx5QLiSpgFeyM17enz9GcvZneZ/HCWhuMXzSYX3PzHd6/FItgPPkKtNR9F
 sfVySvNN7gK0odlL+SqL5MZxRTwuj1YttI5LFVFKHuw2ZBiK3bTEJyjMP02m1+5k1+CbyK0zp0r
 3RQ23HKGay9iepHvC2vmOw6KQ5RnjOmQbD+GDcMk/MRdqHlaA0alZzkRXWavm3tY9XhiFdYYsHr
 4h40PaUS88k65gTxfRuFtWa5Jb6EAbqbc8+9K6QqRQSb+NO0NLYId1Ve9d9bJgX90gIGLPgaA6j
 0xo5VWm1MWykp8P3s5K7wpq7N24n1FSfiQRV9UcuxEJnMUSzYXCUVUV5iV6U0IAUk0guo4ZG6R9
 Zjt5n2+lNT/NTiPXdBt7ur8Vkv/7xEPcvxYMrFzGIWnytjQymhLP8/CEynyegdHuYsHNPmE1GrQ
 0Cg/YRge7xgE1ii5QZT7ZYm/ReayNUa/gZpM2Sk9TAWeLP+hK8GmiNIVrO7vRiEEbwbZW1sCWqs
 ddQnOafv9nKh8dA==
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


