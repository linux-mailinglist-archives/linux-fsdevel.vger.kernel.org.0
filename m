Return-Path: <linux-fsdevel+bounces-22585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DBE919CC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 03:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7321F230E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 01:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8E861FCE;
	Thu, 27 Jun 2024 01:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tj/hEUIr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F25502BE;
	Thu, 27 Jun 2024 01:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719450055; cv=none; b=btgebCP367ZPEsIIaNaQcX1VV2LRs2RfsVJax5rjqTyE8gyQJKdxtpq9cQ2n2mFtK9EZ8vAjPogu+9DMPqvQK/XkFIfWo65ml93HkBYMHLe6uKGqwt/0vdWMxhTGNssNdSww7aU2sEzM8kj3wwqLUcvDZUqeZ7NyzSsT/3fRnCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719450055; c=relaxed/simple;
	bh=AsDPx0Ikfq9IqUjWUD0+xKOHhj2Nou+J4XvWGSgrXC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AJfmRI3C3RUZ7DeV54KNhCEic3D5PXzfDtBHnYTwkIB1j7pL7C+TVU3i6+orsIkB1SNp7jimHi8IsYr1g6MkSKvXIFebNOtXYsmxGgvGwp8K/jsvTgU9kRKrwWp7Ncf9uRh24WOfrRxk4NrusJ5qWe0sHaiV97YW8KDs/gSCVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tj/hEUIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB109C2BD10;
	Thu, 27 Jun 2024 01:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719450054;
	bh=AsDPx0Ikfq9IqUjWUD0+xKOHhj2Nou+J4XvWGSgrXC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tj/hEUIre2HagQVaZas9rsjLhPRUO2hyax4Y7W9EnRv12Cjx/OdmSrPL7Zttpk+xq
	 5Ba8mOxPKVAwOyDP00R84XX3ZgPCwYbUTsZNK1eDhp45m/x1q0AbjF9E60otPJmKUS
	 yb0Hj2apyXo2eO+AnolBGG7LnHDlafrI9vTLwedCknDoDe2I75koVeuL+w3DjMpKHz
	 y0JAUppCwXl6NhlcJ3nq1vc9N9Dub+1Ds4N14Adm+nQZQpCBBvaoKsKBNAFRTzf06u
	 UyJol3cTmjhqJWyHF1zdj/CbH8lcBmL2aUpQGGc47GGxPSDgiZZeL6oCUu/UB2OQyU
	 hl3ynx0u2A4wA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 26 Jun 2024 21:00:29 -0400
Subject: [PATCH 09/10] btrfs: convert to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-mgtime-v1-9-a189352d0f8f@kernel.org>
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
In-Reply-To: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
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
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2439; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AsDPx0Ikfq9IqUjWUD0+xKOHhj2Nou+J4XvWGSgrXC0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmfLmvrjqqUO8F1XQYn7/QtHzz3TvRUyNVZtAnM
 UYAmCEwGkaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZny5rwAKCRAADmhBGVaC
 FVqnD/4lHKGuZjjFq7gg39FIdC0KjRoA7ilhtV7sBg5JQMPyIWf7VpxhqDFqsp6thwF4xwHOzdX
 oWJMtPQ8TIiEEeNNNf0rRwZt2RFNR8IV5hZJ7q3IqK/63Vn2/vHVVO0i24t32dMvI9TG/vYlTUV
 gtrw93u7uKQwYD8nRgWmOHf5tQHp0Wrs7FGnmydNQqm46KAaCpjzmIVj5f0ZoKkhs9FsfX3Ni4R
 HW+auAgJL9zz73vucgy8en74RvQNC5oZsEZQukRLmmS5yUAj7Ls+LRFV59NBuk/w6EmUo++xE1o
 XtWIMX2PGsln4F8Lc2nIPzme8RgpArnXVVxJJ4IKlNMMAvgaZjrKu/JFRzcinZEQNfe7NEy/BoO
 YHK9/mIkcFqNr49cOQSdN9zJC9u2XvQFx2/MhShIUugeHnemNQQtgubesIKR/2UpWOndhhPnqII
 +f8U6wf1uslr1zeP9V4+0GDNuqUZoyDq2Z4eFtM08eDhwLrZHtfOhYl5y51XTdLmt7/3/sO3TyD
 PupvMCacRh1NlnE/Ne7bKF9zES6Vxcm82a/Q6VZPOLv2Lb/gRxoctePxinPCj90FPpgqVlxZJEH
 182F3kKrCLx38YvdJSWmD12Oisp6B13QlZi025Hx1U+BJKmg0fGsHQoVGIaY3AHSEUH+cT4TljH
 /+c1ye9qlC2quTQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

Beyond enabling the FS_MGTIME flag, this patch eliminates
update_time_for_write, which goes to great pains to avoid in-memory
stores. Just have it overwrite the timestamps unconditionally.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/btrfs/file.c  | 25 ++++---------------------
 fs/btrfs/super.c |  3 ++-
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e764ac3f22e2..89b3c200c374 100644
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


