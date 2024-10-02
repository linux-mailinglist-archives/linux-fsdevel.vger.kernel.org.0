Return-Path: <linux-fsdevel+bounces-30797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778B298E53A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B381F20F5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C2E2225AF;
	Wed,  2 Oct 2024 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfzEwwKw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE19217908;
	Wed,  2 Oct 2024 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904482; cv=none; b=nIQARWfsdZP3EiN7ytURebtBqAncvkQK0uPBcPCzq3DjPJJck023C9RzY1JERib3QEu+kkkrd3WipGBAFKB13WNjNrUIa0PZMropJ88OQ7D4+EurUGbGdYR40KQM1qa7AcfRdvaczbWv1zqVrmIhiGDapRdM4cUp6JnpY2UREeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904482; c=relaxed/simple;
	bh=zObmtftqo+OaaHLBavfM0NkNtNo0uG0b222Sa7Qmh1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bnnDMQlY4WWNKPNCJq04BnEzOhNQQX40fjSXzFTigFSqsdelbQ8aLayvbUmjVmTLSyQ7WSekHla76QjanYjiVolJG8mZJW3o/13ey0q6ZghoaVvTJJnocqiNMJyULDfKYf4CmN65fSaIupAdP6LW5ytWH4TUbMYQDm370knG9bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfzEwwKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166D1C4CEDE;
	Wed,  2 Oct 2024 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904481;
	bh=zObmtftqo+OaaHLBavfM0NkNtNo0uG0b222Sa7Qmh1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gfzEwwKwlXuv/icWZdNJWvW+FUy1Vf/0lRfHCezZJdLWd0bObWLG0v+pUO5SPBiLc
	 sdSKXhrmmr7gR7EG/kMlBwBOIXDFpEUY1Q5UnAq0VpOtOMYAK/HuPc2D4OPjxAG28z
	 wX/lhPGtRunaig0jh6Zkqwu0w7i0F86Tdp4KkfnTk2SejE6O+R93qb58TgPsiqWeYO
	 4cRuZunzYUopQWD7qcAnyzodtqqFqRj3H1Lr00OGp4ASB/P7SjZpWKYcoFHEDC3k+9
	 DSkuNUfOrYYmTrchTlnoIigRhbdJizzR0WJ2zW6WwSQ7jNNLL1jDQ9z50Wyi2OvURn
	 fBlphFgrhKdLg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 17:27:26 -0400
Subject: [PATCH v10 11/12] btrfs: convert to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v10-11-d1c4717f5284@kernel.org>
References: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
In-Reply-To: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2842; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=zObmtftqo+OaaHLBavfM0NkNtNo0uG0b222Sa7Qmh1I=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/brAIkH4ZhSMoZFwZdDHij4mmUSui26ZshlEx
 x57+iG3EBGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv26wAAKCRAADmhBGVaC
 FZD6D/9Sk5MXNcAbxZylsBMFOovUPgZGtFA1V7FLElPi8cEY7bFvXXBEGek1fgh/mw0fw+rRbXb
 oQFZRU2UfV6ph1kYWVPicQNpEenaSUhXiOXeXIwuelUAe+90WG0JpGTnnTafXP8n+UcVYlkKDiK
 /mMe1hk0JgbyzqOg5Y9B6BymtY2UqRP9IWF7jCUswdY5ZaiIitOJ/Zj/OTbBECAf7iWWahXA3Fz
 ruvOwvTybJlrz6JA4fJH1SeI+6rRl/7R/0/SsmczCVpNWOwDJYqckWGX3iI9zjxRoaxctha6TQ+
 xAp3b9jijuSBtQ6buORLmDHGJw9REll+c4DNtfZFRHriVBEvcsunWRnHasihG90eKOjU14SL9MC
 1ZvySYOHnxGz8tns2wmWZWeRihy1XziiKNCmiRBHl7fyT8EAyQRBuFrLeSMukQtA9aALZqhe1lc
 zncx27VXeFwy6QXLRi9wyrhs9eKl9nDEw6c4P+31Qh9y6+S9EuVcWcrYTkTeFbkzDAlARXsRyrY
 PEVG5lg2NNHpKq6HoZ7OStLMuQUkfKvb4MjwAoZXtq+pp6pFT9u8CuPukYWWfM3eYLrp1L5gVLI
 IZgF/zLShS/XqVzCis+igDAtyWwVPGSgO3wwlQNWQozooZ2dLNaDCj9PeNhDU1CwuRYofGX5t57
 qWW84x0PuUmo0Ng==
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
index 2aeb8116549ca970432042a315f29d9e7fa00980..1656ad7498b8161ec94a2752b0ab7cb723fada1c 100644
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
index 98fa0f382480a2a51420d586b1e2a2fa6c58d025..d423acfe11d0d1702ff1e17a87d11d65d3ce8cdb 100644
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


