Return-Path: <linux-fsdevel+bounces-29389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E46E397928B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 19:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6EA28115C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 17:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0CE1D88C2;
	Sat, 14 Sep 2024 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnsaXc9Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7111D86C0;
	Sat, 14 Sep 2024 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726333670; cv=none; b=FZnsdqrc2Wify/skLbi5btvBEGe2I7drwd5qr44KYy5M6akAgoBHxEKtRq7D1iUagM8LPTUyq5+29hC6Qz8TROa+cqIQky97lpKEFhCUfwNd2E+t1MEhwtob8FEcCxlIz031WDoj0570SX9i86ewRzbhpBOc2ayHkWaE/zhcGBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726333670; c=relaxed/simple;
	bh=gD0wNq7Gu5j1JVptVjT60GA5HV2tmuyZD0KoREfuUWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhMsg9hedwIPubjHF3dm3t+Rhjd+GvxXteoXlqZNmlz/o4x3zNCpqY1yJmxEKiAalcrbTzG2zy2t6v2pIAGpqUgEzg4bNgLIeQ39cueSrj7LQo1Ghn8J4MiDNZVNBcVsKLq8hvitfacB+EqZ+gdEosN+jrQDArXUBd7pYvPYPak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnsaXc9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64294C4CECF;
	Sat, 14 Sep 2024 17:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726333670;
	bh=gD0wNq7Gu5j1JVptVjT60GA5HV2tmuyZD0KoREfuUWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OnsaXc9Ymk3RYfHMoFlLfXvNdkNLPJT/nCCxRvBL04+CscVmYlVBuqxqN52CHdmZq
	 rS++6tGhQj3jHFzyPbPjWZz60BE3gbH55x26rwO5tlfsF/Oy6ua//id7CsKu8XobYh
	 XsyTGeKDPE9GQOa6pebLQ5hcvMqGTv743a/9EA7n6F578YF5ADhWllJWaCFs3ahd94
	 4G7wC+3BmpbRo179YYT9jFBP1j7K283dTrDdRUb8SKm+hEJdqDm9Iw7LZTIXza9b4Y
	 Hy2/y7j2vFxVnXRqpTxnXQF3KFr34hNAELx6wKUpGn5vJFSPI1OcEq4FIAOYgFVVja
	 DUQfrqF54ZGDw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 14 Sep 2024 13:07:23 -0400
Subject: [PATCH v8 10/11] btrfs: convert to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-mgtime-v8-10-5bd872330bed@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2660; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gD0wNq7Gu5j1JVptVjT60GA5HV2tmuyZD0KoREfuUWw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5cLGDFBDcopNy/21OHrXrCajnq3tvWydZqq9f
 oWLLLJG7hyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuXCxgAKCRAADmhBGVaC
 FbCsEADDSDCuLOkoBu17JJLTtSg9T7tYQSu30N5o6tKAz5hfYb3oqONtgrosynqevuMTPya4ygi
 j2u7OXW8FNsPhJbFFfD7RYKB1bha7dDz9BXy1qJep8KB06FA4/ZZKqGo9Rtfo/S564yYOmrMtD1
 LCCfM9ZMexmEjLRbE/6qQk9LKHL4RUkw/Uus8ZQw0m4pti5eQVEsZMvIyqDEKhzySyvg0Xgaqds
 k4SDLA4lRPxKpMm+kTdJ3nhEGNPL6AL8lzF0lzeT8rtq6HnV951MCwIbBPnAcGzXZH11GFmSwGh
 /r/HxQsBLNwqwXFzB+lqbp9403WElBb+E0J9Sj/6zQf7jA3CicYASW4ojXLpgxzzZGeSAfs2lkz
 RrQ8mEhezpMeVrn+HaorHAqEH7FzMvYSGJNE+Mxss0+hqBH/sJ7kja46tMW+5rzZ0SwjmNuue2W
 1WyYbsohvdObP6z6hREpQ1OO7D9VQ6QoH0lOnOWGF4re20/p1yp7uclcGu7qe6UgMDtWCpjetRo
 2DKRnag68WIlLO/hcUlJpg7HRhzU+kIB0YTG61GKnVdydjW2GQJScOLK8PxJJczGuWiesH9seJk
 hJB65WmjibjgT8/tq+g5CPdXoKRvGkyDBcSWcFPDeyO7uFLuDqqAFFH5S/OVgK9syKPrMNpx+te
 xeyJbodV8Mp6iSg==
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


