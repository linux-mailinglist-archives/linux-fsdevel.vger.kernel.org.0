Return-Path: <linux-fsdevel+bounces-23299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6C492A66C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6E8285F09
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52791514FD;
	Mon,  8 Jul 2024 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GB5rZu5h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FEB15099A;
	Mon,  8 Jul 2024 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454047; cv=none; b=iqrM5CvcU41jqqg4m5KUHPrPvTuaG8wUH/uLGtgcjBjiuEnd3NjmmylEKELoMyfigUFJA+1tJRJTds8fzKmWFpxw3QbfHtMdXE+pAZJsQCjKnY76TsY72uJJwqM1v1EsnyZORiF7rK6WoR4JXkxWo6i1yYeY9stH/JUjznhXejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454047; c=relaxed/simple;
	bh=xTk9IFiZeoZdqPbR7bcsVc6tPLRLkOIJYDVl81q/MME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ojHhvK0r0q3pp/J9dsvt9se0qckN1vPx+gyYQ0JXNnCuvVoUnrTudCuPtBOuZ9/oCk4br8OhnW4z6J9bSC1DCFAVR0aXhvbYTir4iioVJDERqxgwBq0Gg1LKlqfhyh2A94E4DL/Xn5dHCMunVi885U/Ok49Zqhh8LR8TpW+9o80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GB5rZu5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC349C32786;
	Mon,  8 Jul 2024 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454046;
	bh=xTk9IFiZeoZdqPbR7bcsVc6tPLRLkOIJYDVl81q/MME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GB5rZu5hMI15U2ylbFQqX0YhfA8/WrZ8rZu496zGgZ1UwskaiAWieirmiSY0606Ko
	 urLNop+Q2sDgfXPdUj3B4pokqaMGp2zG/BgyDqswpThDrMg6TR8F0s3XyzG4Rhrnxt
	 gj9l8puIj8+p5UQXYSaVy3m/FS0pW4uRf1cbPf0WM/228SQ9GMeCXMXbtNKQHaEB3S
	 p5m166bxxxSjGzzp9F8ptC7hSXR0mn+kMh8kngD7wDi+o2q3CeM4hcV4onWPTe6Ir7
	 +od04Ic0bl594sgUqHvEifuuUvN4eu7LTD09AUXSBdxyTNOYX6vZpAN5stpmnakOO4
	 d0nsnczxdXYvg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 08 Jul 2024 11:53:41 -0400
Subject: [PATCH v4 8/9] btrfs: convert to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-mgtime-v4-8-a0f3c6fb57f3@kernel.org>
References: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
In-Reply-To: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
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
 Kent Overstreet <kent.overstreet@linux.dev>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2583; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xTk9IFiZeoZdqPbR7bcsVc6tPLRLkOIJYDVl81q/MME=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmjAuE92mfSh6NfDlCWQlKkv2+4U1n3snVlNA2V
 SIuSR9NXhSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZowLhAAKCRAADmhBGVaC
 FYEqD/92ncQwLqYy4hgPbZpX9lkjOfRdvTeYjwgy6RHJ5WXvt9CL15LHhKRu9iCWGuT55UOEBDX
 BxpZp2takntEWAPpNyLuEe2UKXwe8XL2b8LCGEa0Av4jG2uxZoAdY3Puhf4NH+hTXMPPDxKlPb1
 tOcJh/u1gTH+mrkLnSFyfEl4vNmLJ6Fs1yyJVTuRTraPqrLHlv1hmP0SVMu6YFCOE3VL94akxSK
 84eEUH9VmtvOH/9SHnwfo2RehVlOZaaubcI9f2Yz5x5u3rBbgT9kpvoTD4MzCUx2Hcgtkd+MTAU
 125popAe3xibLBc+r5YOn3MqbW2lS2Qr8TLoQq4LCuWOjeQjuSOSaBjmV7ti/snS8YoMuKPTsaO
 ZSgOq0MJfDIR409jaE5qswYGInM0lkM3BYy+S84yt5BfpE72bMj4IVud/q2ght+ZFnKepMaoJUb
 yDdKcmHieDoWAlojT+oEXOPecqzo4qXkZkTBl4HVQw0eKS0IMml38kJib/k2e2lxWJN5plXChKb
 0UFQrExJjjC2LAa738FQtlDlESCaVfvPXjPV/jtlFCJavsLPD6ys+/WfdgN1Qreo+w3pwtrxDwv
 9PcKml3SHYHCNXt1t9AcqlopfNjRHzLQRKk9MWxU8U3cy+KzH1MbnT/OXQB9Bai0hjLcsRKIBIA
 HwEogG0gM1mAx2A==
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


