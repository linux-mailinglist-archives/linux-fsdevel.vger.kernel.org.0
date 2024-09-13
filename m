Return-Path: <linux-fsdevel+bounces-29327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126C49781E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83942838C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7CA1E2016;
	Fri, 13 Sep 2024 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV9h2BHP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCC11DC06D;
	Fri, 13 Sep 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235688; cv=none; b=DOnytK5ysqoFEwxwr9Dhcx1FvrSgSiptx8wwkqOJ5eqEBJIBrHjHlawkzTm2W6U9SEKXFfTw7iwayu4sTKnJkXXK5D5z3q6+OMTL6so1BIiLctOUMEN/ia5QwDqY7Sm5KQhov0wpp/ZxGSrqxN/0ubZeUwONi5ZQoSaw41fbPWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235688; c=relaxed/simple;
	bh=gD0wNq7Gu5j1JVptVjT60GA5HV2tmuyZD0KoREfuUWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Puk1hMEAqBLsY1ub2o/NwuMDcdly8K350WoT57nJUns4T06/1QHqb12qqON8WmCxmWADcRu8r1FkgiotQN4n0WAJaX1aB54erxi4/aSGRtzF45j01OwZY+l5Z0MuNgjqtT/Jcqs+AT4uP1fYosVFATDprzJ6nuM+RH0ozjb86Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV9h2BHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67F4C4CEC7;
	Fri, 13 Sep 2024 13:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235688;
	bh=gD0wNq7Gu5j1JVptVjT60GA5HV2tmuyZD0KoREfuUWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YV9h2BHPgRdlUgYO3F/CqZJt1Rc/2kCQcYi69lZ21K5cNlZZts+4iWAGlgUUTCoEv
	 X3ewd9YOJGoyXgtot3C5RATvBsQMfiA8U+bY2D6M2qE5IoSDEUqnPRlFkIweuqZ/PJ
	 p6edHrAfSGy/gWeiV1jyM678J00iCIu4ZfkPezDpqy0iiN2Y20rrMZjWUPBOMvfi3J
	 oxtD9Cx7nCkicldPZdtC1GDNSYPk/YV+IUiN4kOYKZZobWqVk+lY4XWOfNMmqYQ8HG
	 R/xFCBfIim+nQ8u8mt/T2s/WQQ4BpIahixAaZEp/mKbF/Bzyg95VsbaGRUQtmGcW4S
	 FB+JjuV+ZVzvQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 13 Sep 2024 09:54:19 -0400
Subject: [PATCH v7 10/11] btrfs: convert to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-mgtime-v7-10-92d4020e3b00@kernel.org>
References: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
In-Reply-To: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2660; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gD0wNq7Gu5j1JVptVjT60GA5HV2tmuyZD0KoREfuUWw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5EQJki37/yNYFfRJD0xfVng3Rl9sd2OKealIZ
 wgN8YU7mDSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuRECQAKCRAADmhBGVaC
 FfCyEADHfVc2KbEBjV91v6AyHwyXWTddhIFLhoAxtZI3VehsvHLino/KQ15ml1Ehn1umOKyoJHb
 gY+BrYSpB2tTAaHIhBIdR0SJFSGZ/uJ3rD+KMcLIoLZB9GynRVKT8WLFf5/QAkuXYemXgVi7Mvk
 M0PyfSTPIUSkm1nEz6R7/fy7xv1zeYiX7AaW9y5JKwarbS0IA2/GEIfyyKiW3QhG0ynu60JX/lZ
 ECCXJWF1GG/7Rb4DBGb8UUMYNaxZ8aguK5eNDBG0NSsxUQg8zrTFKbg8HJ9ZAZ3bbYqLcRwJJ1E
 Db2ReX2fFW/iP5bZCikSTb2hxmA4/RGdDHSdURzG0r6Al5UbP2D7SuoUtztPW7AUq4WDKGQfXgZ
 F/E9+m02g7WPTNyM31BsAqkjWVBAX6MQpLU1mKyB6s++j0DFdPwo2OWwSnhR9HIqUxiyhDkZ0V/
 ulmMZN+bjwIpUQ09rEzRmzL+1464X4wNk788Qosy+eceKV3wZKDgKSX14nVFiyWdbKQohlkRNPK
 Q+awpe8E+yDMrIFOtc/HIdvUKgq1zAkMF7IV1lfYMCAmp1bcsnLSQQOWKjWM9Kr6IywPztPFerL
 kZRpfsYr5QYY7quhuja5CbrvHJER8N666wveTyecwDl1wcChHfX8HQD+6wrpNoqO/5lffPcR5q7
 hpIwg4Kem0wxJ5g==
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
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/btrfs/file.c  | 25 ++++---------------------
 fs/btrfs/super.c |  3 ++-
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2aeb8116549c..1656ad7498b8 100644
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
2.46.0


