Return-Path: <linux-fsdevel+bounces-30486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF3F98BA81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A6828524B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F301C6F51;
	Tue,  1 Oct 2024 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgJN2Sog"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490C11C68AB;
	Tue,  1 Oct 2024 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780381; cv=none; b=BD+VSZHR9w6AWTe8eczeZNizztKmuwskL35W9qRkZSsAC0m61PU/Wed5q/ndkkFe8xW9nLHKmJ00AmIS+DApTcHnbENRWVrCaReZYx1B2Fj8VyFItbkq//Vwa3IVtbkdMHsL9uuC1l3TfdneXwLnj0tg+UdSYXJeo4v/nsybWxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780381; c=relaxed/simple;
	bh=UttJGln3RsYeF35AMrr2wmS/hNsiLcUiITLEJHfz5Ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eLi9io4Z11PmE48Pzx80eSTn1MxDNVBRiwnNmnnembvyBuRzKY7VzfjQ1DOBbmUIl6ljEQXYMZ1SHxvCdcUZavmNNjtqRNTv8yFxBGQn52bOjUtD4++uocHyxxaPDcTguYSmcVg6UGP/FpBo8eREJKRVojCPZ9W6O+oO26C70fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgJN2Sog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD64C4CED4;
	Tue,  1 Oct 2024 10:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727780381;
	bh=UttJGln3RsYeF35AMrr2wmS/hNsiLcUiITLEJHfz5Ms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mgJN2Sog7HIYjLMvgAVx5L/0qUoze9I2mP7px45sIleudkB6K7FWFAeil/EaLhPEH
	 VzjgdMMsdHddmMR+2f/MAtrJt6cNesnog5NsxkUof+2quHpz8CTslLSxToALMQGFM7
	 wWsQxAB1m4Gt7Pz1CZ5ZMjQY3Tm2l8zwwJdMqJRc62n4R7lgp0KU4B4AeT/10RzU2s
	 Kx6EmB21R4yxJlSlAGDm90IUtao/sJ3amEcEuIwWbcfHidX6A0yqVY1nv30yIhnD9Q
	 xQwjTeAnwm8ExdAUeLxRmp6MTDLeM0ty0u91KcDRi4H0QxGTGEbpMbuem3LnhboaGk
	 wo/PDtzezMb/Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 01 Oct 2024 06:59:05 -0400
Subject: [PATCH v8 11/12] btrfs: convert to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-mgtime-v8-11-903343d91bc3@kernel.org>
References: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
In-Reply-To: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2730; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=UttJGln3RsYeF35AMrr2wmS/hNsiLcUiITLEJHfz5Ms=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm+9X76ziqrcN8sn2M8lQjmFo39dkFvoe6mXrnn
 gNHXakHKmiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZvvV+wAKCRAADmhBGVaC
 FYgcD/9eDy7UZeUD34N6bzAuHIz+P17VcBdQftd5Y6GWHvi87dVZ6Mlr61dUDVaOWLuF2WJxMo1
 UGWKR828DQiIL2Esoqo/e2ze5VhRIMSTJWrCqQfKPNOmJiPiwt+QNM6sm/xYBBL1Ck5jGZuQFX5
 alNr6JqlME4ENtnSzrUKGrXCbq0vqrQqTo0TrtVA25wzuZ9ySJHEyIpIPTooKEqMYXfV+kMH669
 orDknC33K1dOmhupXeN6UJtP2MAl5ahASBDGLj0szE2zh0sg7d8axK5usLOT4n/k0sCX7wge2as
 uXkTL6tGJ1ZoCeHKsEumoCi/bxdiueJmdvjmdJZ2nt1FAPju/LjezACB2mSIstrOCm5zvfM/YXD
 6UbrAShHPdMj/E/uMRjsl1v4VpfN452Y3KQkKf24OAArApkzUMwBQQ6MUnbGyXtkus7jTTSr4Ju
 rpmIEMR3MKC/PfMJP0S/0ryZQMW8PmleNRy/qsDJWlSfNwcoESOQFGfq9dL3v+smtGGFMvqsFef
 IYyiHLx7Kh1zBZm70fmQq04umgfyGPM7Awpj7QzG5/R/R2qLJCdYHPdAXflFSZhq4Jz7emrGOJ5
 Fbc0Nvxk08/GvArfrACwtuv/r5qXk/aMShjA6AC0Mo+bM9nXhFC1MQorOTtBSYsFRQ0O9OvhhQs
 j0hQSnLz7Aj6sCQ==
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/btrfs/file.c  | 25 ++++---------------------
 fs/btrfs/super.c |  3 ++-
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4fb521d91b06..e5384ceb8acf 100644
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
 int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from, size_t count)
 {
 	struct file *file = iocb->ki_filp;
@@ -1170,7 +1150,10 @@ int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from, size_t count)
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
index 98fa0f382480..d423acfe11d0 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2198,7 +2198,8 @@ static struct file_system_type btrfs_fs_type = {
 	.init_fs_context	= btrfs_init_fs_context,
 	.parameters		= btrfs_fs_parameters,
 	.kill_sb		= btrfs_kill_super,
-	.fs_flags		= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA |
+				  FS_ALLOW_IDMAP | FS_MGTIME,
  };
 
 MODULE_ALIAS_FS("btrfs");

-- 
2.46.2


