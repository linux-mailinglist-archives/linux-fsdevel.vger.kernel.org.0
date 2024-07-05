Return-Path: <linux-fsdevel+bounces-23235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0056F928CD5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 19:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3274F1C2134B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F303D179203;
	Fri,  5 Jul 2024 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIWijJEX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC92178382;
	Fri,  5 Jul 2024 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198998; cv=none; b=V50JW4G010SN6lgfr3NJztE6ZDPujNuEMFHXEfIAVN6tLGOYvtkTHcvEpxYsp8Ia0++1L+Z0sgFeYQCHmrVwJbps3SnltTD7NN0ae3CKGiOGAVM0IAwWAfYfxry1PW5PZTMUSQ6Ihp5VN1inoQBl4yUq89CUaNFCTkeTB42iv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198998; c=relaxed/simple;
	bh=xTk9IFiZeoZdqPbR7bcsVc6tPLRLkOIJYDVl81q/MME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rlwya8vXkpU2wPKqcKVNeZMvN5z7AneCrRx/ftZd/jqg3VpRtRG2S8blbfmy7ymALrAh9FBxh4155T+m4seORfnLOyR4IaznPR+vVKe4QsOfIMc1XhRrC7otMmwdhGxYW46SHeUXj9eJZ25Zzc4IWHXTqO+E1n2R9FLqW+dhenc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIWijJEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4208C4AF0C;
	Fri,  5 Jul 2024 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720198998;
	bh=xTk9IFiZeoZdqPbR7bcsVc6tPLRLkOIJYDVl81q/MME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QIWijJEXIlt9Fzjqu0/oHnvwFuJ2XenRfKa2ibEcmz/gfkePuJ28kk0schgfhbNNV
	 bzeyvITyCAeZ4Frg9k7fKKgCKgxo6eyVfVjzqDS21h142buI5F0QAm8aYVNdye4fuD
	 Pld9qED4V6fAh0MLvH50sJ69JOuyzeeQ/zT3YfyxH+eUe/+fNLP/oiK1VMI4+VKNgy
	 Is1DSUdyjI/XKSosEZsvRUs4r06Q1oIYc8WH79i5AodWduOBksgI/GQLD09ksNhgNk
	 1/emMNC3vRsOxgPhdJyGSRDZVwYWuHNmQX4CqullxwRCJ8t/xeGmTRl1DWB/NdI/ad
	 iFzvu7RHMG0tg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 05 Jul 2024 13:02:42 -0400
Subject: [PATCH v3 8/9] btrfs: convert to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-mgtime-v3-8-85b2daa9b335@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2583; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xTk9IFiZeoZdqPbR7bcsVc6tPLRLkOIJYDVl81q/MME=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmiCc9ppo8g7YDcKxR/HjaWHlTOUSO1fFuG2RWe
 rzanvFK2BiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZognPQAKCRAADmhBGVaC
 FXjAD/9SLGHb9It2EGmGcwPeKpz3kwVgydgjCzH9vbqWOlCCrNmmKEuFVdjDeDAteD8frwEH/oF
 QaCpT6sFLL1YujnB0dXSUN3gadh5CvnJ2UqqkeHfbtRBC3MSiT227r/ouwiQuQ/Wl7CBqDkpYPD
 5O3iCg2thusEQzq/SnDL5YJvqEcVT69C1Z6ieDecyWde4cQw/Zknu8IFBH9Wm2UltSah4L2hMFG
 75zBSOlzAO/8fg4MetXPWYPXePRSYN3wM+Ml/+fTkEc3eFtWONe8tESuNAX37Ufl40+ogdAY4H5
 joJynG2YsCi7wlYtHH+m31T+dauR7iny72PNZQDClsV/t/5GCDDjT6p6y6RZ5kuyXPXxsdG4aaO
 u6sFQSqKWByK2f1KI8hhx54DxjXKWi74TVtWEc1MHi+cHp/t1PmHBOQJi4erhjaRHN4T8ri8Gy3
 VRooo9gMRkLP1Onmbvj7K6aB08Cs2dUkRJBpZTWGB1YFKji2sZeLA7DGEpEUfUyi/fWOHrS1WQ2
 4VCA4Hnhgd0pOIsyj88N3dcfPvU9Jg7PieGdT7X4mSEoONnb4l6VfoJYbEQY4NnucRbDvFJKH6V
 UafPnPFxUCooR4tvZua/vbEvbKr0T80kAFAVgZCKCgJFJS1NR6owJ458/BeoZW41C9mhWfWKP4c
 PZJJJzXMnFGdWEw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

Beyond enabling the FS_MGTIME flag, this patch eliminates
update_time_for_write, which goes to great pains to avoid in-memory
stores. Just have it overwrite the timestamps unconditionally.

Note that this also drops the IS_I_VERSION check and unconditionally
bumps the change attribute, since SB_I_VERSION is always set on btrfs.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/btrfs/file.c  | 25 ++++---------------------
 fs/btrfs/super.c |  3 ++-
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d90138683a0a..409628c0c3cc 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1120,26 +1120,6 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
 	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
 }
 
-static void update_time_for_write(struct inode *inode)
-{
-	struct timespec64 now, ts;
-
-	if (IS_NOCMTIME(inode))
-		return;
-
-	now = current_time(inode);
-	ts = inode_get_mtime(inode);
-	if (!timespec64_equal(&ts, &now))
-		inode_set_mtime_to_ts(inode, now);
-
-	ts = inode_get_ctime(inode);
-	if (!timespec64_equal(&ts, &now))
-		inode_set_ctime_to_ts(inode, now);
-
-	if (IS_I_VERSION(inode))
-		inode_inc_iversion(inode);
-}
-
 static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 			     size_t count)
 {
@@ -1171,7 +1151,10 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 	 * need to start yet another transaction to update the inode as we will
 	 * update the inode when we finish writing whatever data we write.
 	 */
-	update_time_for_write(inode);
+	if (!IS_NOCMTIME(inode)) {
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+		inode_inc_iversion(inode);
+	}
 
 	start_pos = round_down(pos, fs_info->sectorsize);
 	oldsize = i_size_read(inode);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f05cce7c8b8d..1cd50293b98d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2173,7 +2173,8 @@ static struct file_system_type btrfs_fs_type = {
 	.init_fs_context	= btrfs_init_fs_context,
 	.parameters		= btrfs_fs_parameters,
 	.kill_sb		= btrfs_kill_super,
-	.fs_flags		= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA |
+				  FS_ALLOW_IDMAP | FS_MGTIME,
  };
 
 MODULE_ALIAS_FS("btrfs");

-- 
2.45.2


