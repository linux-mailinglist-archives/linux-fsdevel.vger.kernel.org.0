Return-Path: <linux-fsdevel+bounces-23694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A33799314D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 14:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2215F1F236C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 12:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0690A190058;
	Mon, 15 Jul 2024 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsgBtdWJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E3E18FC9E;
	Mon, 15 Jul 2024 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047768; cv=none; b=FHI4XRxNMcN9xAslfsgs3GpNDytVCX1P7q85Im5fRbalB0PczFmsN5U/WTeVZkJ/rEy9IsILX6xQflo+b7SRaZ+n0J+BOzOjtMOVv03rxigtHS1pn168TO8prwJG+fgxk3unYD40/kk5rHRn6Hm7Aqmt3hUfXKsZKTVrG24xR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047768; c=relaxed/simple;
	bh=Za4x1Iy/d7H0eflkTicTt1UaefhIWQ90YwrfG99Zd/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i6f77OuX5ffSm9LNBYuiz9MfySgHOOy4OxJWITiiSZm/1F/d2tJ2yMGufgPWzn4TdJhU+WyJc2xWUswdIKvuiDTFu90wsCcow+ArX7+UgwVHkxEy/xxhSwWhmWH2C2k0Ho5IlPnjkVA3CDYkyC7FUTX0s7e8EgVuFjmGbIEcguY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsgBtdWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D220C4AF0C;
	Mon, 15 Jul 2024 12:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721047768;
	bh=Za4x1Iy/d7H0eflkTicTt1UaefhIWQ90YwrfG99Zd/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MsgBtdWJCSqIckHd8N/sLkK2H3UIksWen4AFqt0e1Vqov1QXoqSeqhnEyiEBfk0KI
	 zj0dYtnefpLl+FmWTb6ufRTO1eLgUOQTtZsF3BZ2+dtqqeUn0cEVv3TvDGMR7c6Sem
	 ZNRa6hMxaIqS/T0hzOUpgdNgTHHbIWxGSrfEgbTQOFeTgCDhc9xcUkD0aYgu1yu8e8
	 Qy2ZLRQn9sHe2ibmplFUdcKXFpNVMxxBTark2MPod1F/4YMoyURrYbO3xf/7YBGTRZ
	 lZBi7Hg2xzw2XFivw95Cxm3vfGotZmDsB291SEKV/5Plyr5C8JMBdUihn6s8uWXqEi
	 SNVMxc/c4ocbQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 15 Jul 2024 08:48:57 -0400
Subject: [PATCH v6 6/9] xfs: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mgtime-v6-6-48e5d34bd2ba@kernel.org>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
In-Reply-To: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
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
 Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2845; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Za4x1Iy/d7H0eflkTicTt1UaefhIWQ90YwrfG99Zd/s=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmlRrDU4nWQP3Re9QBLBdg/iDcdaRe20/HAbh5B
 Sh/ulM1S0yJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZpUawwAKCRAADmhBGVaC
 FZu2EAC2wyQqv9ZanaKX0NuqQvQl2qcPF6diqtykkUObkhXK0jRkoEC+iEJPmSWECO54qgYrEMf
 aVXeh4ZR7BDbS3icu8iCATQzL7ICRAOfLPkM3ZFag4JsScuSM4JKijVGPIGAfR7zG6913stH+Pk
 aFE1lCE+eOyTUpo6XxYvMk2Oer15sWj8b5ZL2HO3Pwg3uofMhramJ9jxwAElIkoHuVA9JKxrLam
 Bp6j3uDOGbdZxecYvRzCD0Iprz9ZCVQblK4MEyISVe5XzHyNlWlmkKoRODyhnfV3pz5j6bvW/61
 96K62l0sABrGRf+4lw4K2xekAP+pB9jgeup/7knviQJye8w68hj1kcwKSX6ckZkxS4CzZwTROQm
 1VOBCYWGI4cbJ+V/ILEQTzNqkS67R5BCc9XRXgElutxcMXOMBtU8yQoQUs6z9HC5SQldvs/Bcgs
 IwvYbzhFvmyynv3B0vX1Q9mV9OkAdYHbfH27HtzXCqfPxfCpFwrWiTZTy9wKbYC36tgVy9nGH6S
 PNInEiAel+lNAF5n697sbRIQfTDDMbTjkB6sAjUQQTNzVPCPr/OL6Fnhzl50Ju8H+Ihzs9u8Ehf
 lTfaqd9QL5Z2kzDmkUkCXLkf1P+oDoD99tlMutYBCdj3NC7p8r6eZUrtoUa3pwVj+YyDWbe5R8y
 0wRft36HqyrPZyA==
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


