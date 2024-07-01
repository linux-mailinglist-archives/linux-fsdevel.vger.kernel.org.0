Return-Path: <linux-fsdevel+bounces-22864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CCA91DCAF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351791F235B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290B915ADA5;
	Mon,  1 Jul 2024 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcqTr9O6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E61615A871;
	Mon,  1 Jul 2024 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829649; cv=none; b=K/7JLu0jzjO+xBfAKYkhEPShH+oOi4p6GyVAKCNwscLCXfXhvMgCP+iU/vMAXYpgAQIHy1ThMETLhrdaSohGmzNTJrUztbCWZtqFHLq3xx6qX5IpZ7MtuXno9DdKs5xZ+7vh1seMoltJXQOcCR1k8ZFZc3YC7ZCmuM7ArjGCC3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829649; c=relaxed/simple;
	bh=g6LPjexoZumsLrWQmoQEww6pUVCduYJaKswCWiwjKIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rp1jioYsyw15DE7Lo3l9rLMaDnWW8nYHPP6Ke0XwvJtm0p/On/KEcwfe8ebf5ZRVLHY1t2l+A1SDQ5N7PZrWvofa8edg2rnG4b5RNt6G3HPn5pbazoN5Zo79sm24hg1QMZdM9ZNZnGPPbCyaEBucCj0SrodoJBM5hJjS9aRNlsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcqTr9O6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE85CC4AF11;
	Mon,  1 Jul 2024 10:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829649;
	bh=g6LPjexoZumsLrWQmoQEww6pUVCduYJaKswCWiwjKIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LcqTr9O6d73yjRPzUOQt3rFcYTBLQZMcbUK8iYcP0QWHG/g9apYIn6p+aPj98OQdG
	 rNXNotsR7h9h6k8c1SI4yOe5w0A0j+DDcUNf2hjfMX0rD6+VnFCDs/XMqHp5IOXSwY
	 MiM+/js9xsFoC9dOVgDc5Y76poHyippIMejuCSnh6YSg00N4x13bd8/Od3DQeIicxR
	 7F2g+c0OuLfAim7geGIXUUjXgw1MibgvZONgzODpNaUvIefre84JqgqeoPJoZ3Mq1E
	 T6hpFcS96P98iish5/M1eh2SynsIcqr00bNy745ZsMcZyzX57sj2rtNbsM4zP7SGO3
	 /RjdT8MeQ9q2Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jul 2024 06:26:45 -0400
Subject: [PATCH v2 09/11] btrfs: convert to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-mgtime-v2-9-19d412a940d9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2439; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=g6LPjexoZumsLrWQmoQEww6pUVCduYJaKswCWiwjKIg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmgoR5peVlEh/9fCIgBmWdUayZz1OsZCQEyAymb
 qH/Z9hlOVmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZoKEeQAKCRAADmhBGVaC
 FZICD/9SQ9g5VLi8qohQ4mJbihBrn0jgzZ/fl6AyCHsI1a+lsfbbpF7BFpvr29WWehMrohSp1dS
 qEuFGmBwGI/Sm/T+rIO8cqXV9AQlIDd3ePLCO/XWOjPN0CGPLvhGF4ywT1j9MQ+HJn0zUp+kyL0
 4GOEv5aXE3X4GZCnxcSG/kDucEjIf5oajhC3l0Kwh+/7QjT783shrSn1OCK57izMhMaqGMrunrV
 icbjNokBR8s6eM9NlX5IecTBDuPwIG9OBc/15k2tyDsiSj6gISY4GHtI9QL5XQzvEZEe+dejQyR
 XoV63JJZkCKSJVOKE9+alHFA8EIDroXQt70LTLuWnzB9ROfaOIku11h0/C5Pd6zFVgsEPQS22ay
 N9NXud7se+TdCm2czPGP+WeSNF4YH0AoDB4ihXIPcob180XPVfNI5s/dOsCBBOel4ym1IvUyEZd
 9a2IZOzRMZt29IiEB2VEK8BEVVF2DVBFvS2Ve9EhgrhkHT1LZoHI37sdn2Jt3BPf1TTTFqobHHH
 EVDpkOTsHyU4PZBc0cBaG7iU7+xU+HPx5xi+mrpJSQtpJNXN84yEVgFP8ctA3tG6XTQHcSJbpLS
 2mT2UwJiFyz0LRQkvrrhS6vR/wCODRLMTTFjNIE3zDMrAy1Tn5vWkcaky13cdpTs+uCjtGEnHsm
 sX/vCHXB2Caf2CQ==
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


