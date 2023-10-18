Return-Path: <linux-fsdevel+bounces-685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AF17CE4D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 19:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0965281C58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0E83FE33;
	Wed, 18 Oct 2023 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSRjlWxn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52AE3FE23
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 17:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53267C433AB;
	Wed, 18 Oct 2023 17:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697650906;
	bh=UwK4Bv3ROcgihmcvu9msHTDCqtlMi8PO5kAJpB/lfoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qSRjlWxnNTwfGNV0Q8mT7NMDzc+qlSVW/LwsSsZeLwGGA+yuvWHorCuNrchwFb9iF
	 3oyQEwhmcOSX3YnhNDQKjxLGNdhHfjxGp/RF/UJRiTbFcV6fsdbOFeo7tENOSIPiNQ
	 Zzb7nN41F8bCvJOHamRpFJ+SVAHhSJWzfR+zGMNBY/YBEZZx8poAFbXMjt/EKBoB30
	 hR60uckQsneqXI7s583v+itxW27moXjS284cFZ7QgCiw1HjSUAQMLgdRJVfLiUpGPu
	 Ds5zGhz8c78Zy02SXFQoFmO8fZClbEDstAq+fFFgUMxs8yH+mp3CZ0GN7EyyMoen9w
	 LoHURLczzAP2Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 18 Oct 2023 13:41:13 -0400
Subject: [PATCH RFC 6/9] xfs: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-mgtime-v1-6-4a7a97b1f482@kernel.org>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
In-Reply-To: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, John Stultz <jstultz@google.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, 
 David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2416; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=UwK4Bv3ROcgihmcvu9msHTDCqtlMi8PO5kAJpB/lfoU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlMBjIefuyPVHvdgVpwhPPX60qe6wZ15TLHB4LG
 U8E6+7devyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZTAYyAAKCRAADmhBGVaC
 FSDQD/9RrJmco0fSAbgHolmtMmOGKyJDUH+Yax9DZo9G33gFEq3gimnaRJBR7FCRyasd67VQqQT
 hYeUH8BlluxEFXYZssDkYOl+t7b3HZmPCdyjwhVXzaAg7vbjWghBWGHQbHFFkl9wbhoOWd6gusy
 zH8QXWGoN5Wz9Sk0Q7QILoMytEya3RHTnmDLbcSEfWg9YAQSNATIZcaNaqWtLSLbEmBGqaksKVY
 hbbxyKpso/ifX23/Qgb9IMo6ODHPPbV28AbB7kQZV21RqyeEZ+k+Jonlk7aIADMIw9bsFhzOxhO
 rmyxKZvBUTql2YwcvoFAo3NRjZpQmvfzBRK6Ax6WSMF56OA7XcUqNFaEMaFxhjgAPjZpCxbZfW5
 dGjJmnna8XkCv95PUOAtgDLpFAoEJSOS7XOgQ3VSGcSNe3Vvrz0K9jrvkiZf1WyyaHNRPXvijbC
 DFZX7Pi40JztALqlqNMKTidN68pBd4uvdv5Qk2L8ESP5gf6TaGH16ah5yoj3MAIhT+stlHFT55G
 Ejzaitu1cicbPvrUTz+i6+YFWFd925Q9EZSLgg3aAka5jtRQ7am7C4ciUbSURjRoVdtQpmrfssX
 BoFbvPeT0DHZbtZwjdmxDip4mLT5dAVaobppZYIlMhcJlEBN6toFJuE67SPBL4hqePRjDXhm9uC
 B/Imrrki4dThCiw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/libxfs/xfs_trans_inode.c |  6 +++---
 fs/xfs/xfs_iops.c               | 10 +++-------
 fs/xfs/xfs_super.c              |  2 +-
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index 70e97ea6eee7..42e4e6e964d2 100644
--- a/fs/xfs/libxfs/xfs_trans_inode.c
+++ b/fs/xfs/libxfs/xfs_trans_inode.c
@@ -62,12 +62,12 @@ xfs_trans_ichgtime(
 	ASSERT(tp);
 	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
 
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
index 687eff5d9e16..8fb251cbe061 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -573,8 +573,8 @@ xfs_vn_getattr(
 	stat->gid = vfsgid_into_kgid(vfsgid);
 	stat->ino = ip->i_ino;
 	stat->atime = inode_get_atime(inode);
-	stat->mtime = inode_get_mtime(inode);
-	stat->ctime = inode_get_ctime(inode);
+	fill_mg_cmtime(stat, request_mask, inode);
+
 	stat->blocks = XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
 
 	if (xfs_has_v3inodes(mp)) {
@@ -914,12 +914,8 @@ xfs_setattr_size(
 	 * these flags set.  For all other operations the VFS set these flags
 	 * explicitly if it wants a timestamp update.
 	 */
-	if (newsize != oldsize &&
-	    !(iattr->ia_valid & (ATTR_CTIME | ATTR_MTIME))) {
-		iattr->ia_ctime = iattr->ia_mtime =
-			current_time(inode);
+	if (newsize != oldsize)
 		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME;
-	}
 
 	/*
 	 * The first thing we do is set the size to new_size permanently on
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 819a3568b28f..c8a2dae1dd65 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2033,7 +2033,7 @@ static struct file_system_type xfs_fs_type = {
 	.init_fs_context	= xfs_init_fs_context,
 	.parameters		= xfs_fs_parameters,
 	.kill_sb		= xfs_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("xfs");
 

-- 
2.41.0


