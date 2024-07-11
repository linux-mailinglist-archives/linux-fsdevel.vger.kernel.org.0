Return-Path: <linux-fsdevel+bounces-23566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 727F692E5BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 13:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD441F2139E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 11:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1AF16DEC6;
	Thu, 11 Jul 2024 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfcZxRI1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A4816DC30;
	Thu, 11 Jul 2024 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696123; cv=none; b=YjCOr/jvGFE+iGHtOPRDLf2ZCTncLgOgLCT2A6tEb5Z5benuOCTrIM0wyPaL4uneJYIbrMZfnyvT03hJlCH3W3ROItyRy7Uc0lYPydtQs5sY1GKzS/g3yQudv1KeJeBLSj13qe9C5XMUUJE8dnZE8XoPUuN6lNPSvr8IcZTr4Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696123; c=relaxed/simple;
	bh=fHx/mgJgehSKKeWi0EcYG4swNcOzJbq5fDt162sYPoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NI7a+L+PANBfeGHfE30Sh/bfjDL901v51kjyJGad3z6/yXLs5jOR9AebhrxAsJSjUXjd6o34ONZq3x3yP84vxFtDOtXtcrcLCYnY3wIrarsKr2TvkmDzdrOOU5W/8t6YQmem0rPz6g1qxnXjPfEGYXASpCPnW7wcqtxalg3VNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfcZxRI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57940C4AF0A;
	Thu, 11 Jul 2024 11:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720696123;
	bh=fHx/mgJgehSKKeWi0EcYG4swNcOzJbq5fDt162sYPoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OfcZxRI1S61fYHl8qHzhI3AAeoHxhQ+TZqus8p3/jlXgd23s/5AvLeA/iHAMNu9dX
	 2Afrdk77c8F5kg5T9PUJKYDVh1AC8OyNV7YXK7vTTl447pU3OZ+thjT7wqgaoeLjAw
	 xpoVoTBTgLt1nS8wwbbLjV4oNQY/TD3/gbbsmy21zkRUx8bSsOtRM/5LZiUaNlUMG6
	 3vHwisH4gHRWKGKfnSQa0bdXp8/EqBarQqYs0ZJTZQNsaUS40mn//uGzDipM8xMY/l
	 Bbt4qp9y8ZRuuOPEZh4mPeb5azSLL0xI5JxQyZH5FMsxhe/cQd4MvO/WnvCVj0YeeW
	 pleRtchZqlusA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jul 2024 07:08:10 -0400
Subject: [PATCH v5 6/9] xfs: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-mgtime-v5-6-37bb5b465feb@kernel.org>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
In-Reply-To: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
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
 Kent Overstreet <kent.overstreet@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
 Randy Dunlap <rdunlap@infradead.org>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2796; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fHx/mgJgehSKKeWi0EcYG4swNcOzJbq5fDt162sYPoU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmj70lX4OEuE/qxmSz5H5yszC0h3kRUmqoeXVzO
 9+ohuiXnomJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZo+9JQAKCRAADmhBGVaC
 FVKwD/4nUE2xnHwjBoFzgjJ5fD/kv/mS9yEN5YGF/355Lk7Ayx+lsUACghZYoPm2AU13LRQAg9Y
 axQhahdEmYPMVxmId6ETZe/uGV5uA55R1M5A8rVpkkElbzAXnB87ASBKfjkuIFNANnv4ZJcGklC
 9QUuH02p7d7rBLpfUBLMG3H0ikQu5DgnEqba0KSBKJ8RvQrY7PSz4GRexOb6pwC7tEA3uSl6HPA
 bCa0E7/lcuiduqPeM89Q3fnU0cD39CzvaX9DbfD0Bz9JLc07PV6MR1g+9f4Gz/q0XaRj59OuCtv
 iS8Uu4MFDT4p/B6FP2I6As1Jr2SOBIf9RUqsl0fc3Fow45eZ346ALIuwXjmy2YAZbsdTy5g/kvn
 Kgz1YkcOU6ZTaN8edZD6GrgFT9+h9L7ewVPlFGCnMMVC4TKZBvvAh2g/d9Dw8ZBs0UiDxtU4OmO
 uAEzSy9lf3IRN2K+MgipP0l89f6yft5sdpnCHAimcdGuZN/AF7vRmEoW2+rCNgN5hZZ0KLJbtWq
 dsBKD7sbQKF7fMWaFdVgLTC8JtNAg+IIWXutwkOM1w92c69GW5nXNpbmZWa1wSr9u7fG8bu9ULp
 hI2I2Iz+KyK20ocK4rZgnBgII4Xa/hM/6tDuJrv/wohXYkTwD/uySqf+M8sepMhqgIhyFoczp4W
 X6W7CoD4lWXPXlw==
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


