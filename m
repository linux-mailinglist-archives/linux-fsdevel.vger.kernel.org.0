Return-Path: <linux-fsdevel+bounces-23696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C159314E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 14:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF0C1F22FA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 12:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3371922EA;
	Mon, 15 Jul 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtyYbWAd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AAC191F93;
	Mon, 15 Jul 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047774; cv=none; b=GBW4JkL1t4xCQuwGW1f6r5X2FS769J3BAHTuj0aTJMUtouN9JHy195eer0yIqdg3Rku6kM9LGqKapV/Nn8a6A6y29sA2/ui1/Uin3kTS7px22JcJiIPVv6HlRm3DZPg9qZYqaVwvV15Gs6SyL7B88TMkPDUUeSNFWW53+E+3bJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047774; c=relaxed/simple;
	bh=n/GBFDubJ9Ek68qv1catP2lBxJ/9I9EY6EzBmvQbZCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aS7uqzR/0NGr4/+yC6AmallkOlwN8I55vUE7AVtFJjitol0EP4INOc2Hqd6V9PnZLEchbSNDj/831cXrOZq+0spUPgfgVGz6/s2m+nivHdIY1eGbCNYOjjF6uEyxJvyGqtuDuEqY7SstjVvf7jWUWlOpfR7ThJEdVet3hM2mPBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtyYbWAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA12C4AF0C;
	Mon, 15 Jul 2024 12:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721047773;
	bh=n/GBFDubJ9Ek68qv1catP2lBxJ/9I9EY6EzBmvQbZCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZtyYbWAdVGt+M9geIi9nq1XjNNQKoMnt4VvhJB4ByJb93S22H8PaeX8D+elBcZmA8
	 impfQEW14muDzQ8mqnKoESrz8Gr10uGPLm63I+ch9I+zWCDY92DOYLcnHznRSfIEz5
	 x/nUQ7EWPdrA/coYjsXKG0S6bIk4DgwnzLIkDZiZlfyt+lexFtIlTZE+/erPHt6QaK
	 0eM3Pnc3hhcq91YNFO/cFAiRBaYJpg5tpZc+04sECOGNuL3RAY9OYACGN8vPxWKGbZ
	 poCwkG8HsUOnrBLgRdLZtcnNdU667lJj9uPt/n3SS3h0OKujpuh9GXE/MRP4ajdBjV
	 sXgXQH2/rqp0g==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 15 Jul 2024 08:48:59 -0400
Subject: [PATCH v6 8/9] btrfs: convert to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mgtime-v6-8-48e5d34bd2ba@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2632; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=n/GBFDubJ9Ek68qv1catP2lBxJ/9I9EY6EzBmvQbZCE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmlRrD197rYggBbmtQ+Pjfq0t5urOGWrOjhcCqL
 H+PDb1PlFKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZpUawwAKCRAADmhBGVaC
 FWPPD/98OrTQhimjzIjdpNE2OeuExL1hLuo1FcAxjnPSODQMEGaEHQrTD1UnX5t+mb6vf7Fkhu5
 4/Z4EkWwtnFXTrw7dWpDzmqHAMT7jYXa89Ga0TYbI2wx1q8tAuYvBzEQQ6z1E/pcmNQ1dJqOh/l
 ZDznTDp1mPTy9iE2jum19TBePEDngLxLqGiyqRE95/lJOwuaddhd4MvHdFWjSVPpdjYKE9KYope
 zyr90O9njRTaqFQlbSPHrd5XdE0NrF35opH85Yocwm/eGFHcN+SrKAMsbApMomPEaKSiFbC1RlN
 kLd4iYUx7PNDV+XvVGdTGXYbqSgsV7CL2bOxpOK+CYqU6RSKX15uZSqAnMv4Owpee3gZgAllHYU
 OHiyNZllPfZEOo72mqw3OgahIaEUKKrcWAFzvoyKbCazaMaqFP3d9XUFqOdYWn/iALgO3ZdUq8o
 VO3MyzVxCOZDjdISoPM5/cgfWc7wBJNLnudOnaQp2X6gH7vIuy3V78Q6SF7P2rezMSTgMepE/8s
 7GkW31uEiZYJcpiE+aF0V33DllQqUoca2q+Eg9he4tHp4Nm05N/SXsadR2wgzOZ63OB15CgDJBn
 ip0syOwO653BxgR8VkjvdOHXxF+Zra0Ky9CCbWqDZWf49I1BJeeYTWCNNOyFrxFjKrVYOBlYtq3
 Eh1fhvKxogJPFdw==
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


