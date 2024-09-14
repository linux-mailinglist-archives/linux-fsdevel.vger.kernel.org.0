Return-Path: <linux-fsdevel+bounces-29387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F92797927D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 19:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DE91C219B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 17:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896071D6791;
	Sat, 14 Sep 2024 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWxcOHhP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91731D1317;
	Sat, 14 Sep 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726333664; cv=none; b=A9DZNQz7ESYinLOULW4tUHdMpTFJXq7ndUwHGmCzCHbEPOKW48SbTgxPXt1aGV4GUuc99pXOwoGEn/u8C1Etotd9tKteMYT4fEPcR9jO/i3AHebHndx0/5/aAc5RPy1kJbgdUx4NRmCwWeVEJaEEnVj8uqXr4hKOpnXDZ+p6nZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726333664; c=relaxed/simple;
	bh=bIaGrKHNkJGKwsIp2/9hx+nM5n7ktsZpZECPjECvfD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sp03rjI22y7EttMQJwD/R3yaCMyogdpWCWu/Rl70oZzDx1mJii+WFzWRm90KXY2PJPGxFCBmm5LmbYwJOLI7glopqIMBgQGQG/JAZXp8mmWWOiOyHMDCvezNuGiLkoe/DG84ZNN7lRp9moblEdLYTtgnVcKzYDZiy9xSJ0JAy7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWxcOHhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD957C4CECF;
	Sat, 14 Sep 2024 17:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726333664;
	bh=bIaGrKHNkJGKwsIp2/9hx+nM5n7ktsZpZECPjECvfD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WWxcOHhPNBbvQOZoVEbWbSYGiCVIBwokWxYhCZncCHYiJQcTFpwERaEcR4Wh0Xbn2
	 3xgKHnCdve6t5zipyFCFIIBbKMWVFc9FsCdvQlwXt0VN1K59PGcfWb0gtf66zVh9ku
	 4gWzO/Exl3YH/sNl8Z55iJKZqKHzfWBD/8d75G3/rPfif7e0K/HOcWPYvxm/rvB6z7
	 ynGJN/c23nHNOBswZWBCa0GrR4QQylZNz9jykfRjCvUNB3lAR92/VFZcvrBWVHvkFG
	 cgl7qUvXIQhMBLNMBiIOTqlN2+HOEptvI6n7QQwrcqDYZie6g2r0gfXk8R9Qa2FNtn
	 LNjg2zn+ZKxEQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 14 Sep 2024 13:07:21 -0400
Subject: [PATCH v8 08/11] xfs: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-mgtime-v8-8-5bd872330bed@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
In-Reply-To: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2942; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=bIaGrKHNkJGKwsIp2/9hx+nM5n7ktsZpZECPjECvfD4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5cLGuWV9a+ING+mQgmsUefPyvxOtCZHhgbDyr
 h3WPzWE+SWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuXCxgAKCRAADmhBGVaC
 Ff0ID/9dUQxrrNbqHpnaVnHsEUNWAcwDvm/Uzqz8JRH/iN4YRdGjThpIu7yEpdW72rihVUgzhdp
 MDDhOlQO5YqQqkgHr2CFKMZk6mr8pRtn85S+8NTVanoaK5CcKu+J3cM9B8uAhojNlwwLA08TIEg
 GarAOa/asTvsuyly/mkIWdl+B86IGn5U069ELYgegsSia8FaUxhSDP2aMn0ZXoP7yKsKU3iEGnY
 OKDmWJaL4kfYP5m+nQQcjCvXkSJY9Ek9EIZIErc5POHxebkpCVmS2EYzTeC7jcJsCpY0mK4euhj
 05JoZnB5tDPT+Ct7GxZMu+oFKFfHk9kOG7cpt4wbXXB0V/eTid0mZdkeFy3Q6hzrgRxg+GoIJML
 nS4LFtcRuOl/hBIkH+gAMvbPxqQMHWj5xvEiFoJGKo1X48NfNJwzOids5R/ru8ztisjIxOWUIQ8
 loAuC5LGF8DixJKgHNRS9S7Pf5fC/zOAJwTWbHc1WsnJ8jCSraBKi6yhlJaY2ky5i0OSdZJ6KAK
 tWQg7IgZtrxbNJuibvrXaOj8KBKky232I5TcB9IwV28ZFZiflP8071Ut5Gt8VEuoMan75ri60n2
 R+g/WaoBLU5fySDEGF02y91KTtNV09R9oXBtC6oLh2HAY++rt9IZ6JzLzFbgWZCMyyI8/yQJwzq
 yRfbZfa50FD1bMA==
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


