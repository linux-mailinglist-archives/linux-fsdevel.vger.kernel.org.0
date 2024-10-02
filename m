Return-Path: <linux-fsdevel+bounces-30773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4A298E326
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BDA282913
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0437F216A19;
	Wed,  2 Oct 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btST0E3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC312207F0;
	Wed,  2 Oct 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895025; cv=none; b=DW+FQ5742XXd7VztmJBp/7WB91zN4kqwAGC3TE1c2ob1nEHNUMhqyg4t5wobg/MPEQR0amsjpA8OQVZ4yf8GT8bKCz21wiXS3Neam7qvSqfp7hw9aIh5n7M9OZlafxRrlo65ngXY9SgXS4m6nDuWBV9buM/bK8ySu5oHF2oQUIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895025; c=relaxed/simple;
	bh=eXOv2g+6erFOUU/IZaJxbO9vQa8NYTuiShGXQ/xSzWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FoXFt1DaUWUypHKihrhRNRNk64VXkXixJ6EF3PKira2qFji9S7G95kHBzaMG+SNlCbE8uvAAUXqiXsk1+2eVrAYx47H71608E81EkrwNsmD5GX/uxiyBhC0vKPBelQdNMGkj3oaLiZk8doroM2G8uQUgiQ1UwPmqhDGynb1NCbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btST0E3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB47C4CED3;
	Wed,  2 Oct 2024 18:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727895022;
	bh=eXOv2g+6erFOUU/IZaJxbO9vQa8NYTuiShGXQ/xSzWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=btST0E3iIz3iPli6d0XpPAZAlh8/lnqSl4ah3WBtM4T3MH8ErVcaBvT2ZWfwETiNb
	 YUSY2+5n9NSMhGVEcYZp+qG5kWLAxDb1EAixKCNENdjIyrDNtWcYV4m2AOi8SMFl8K
	 ZnuQFDpARMh3w3B3slkPCa5+dx0fqm3kiyQ/9McJskBSZEbVrZ64APa0EcDhymjEvO
	 KsMDUPNCuaWpMfYPD29GYkVgR4QskGiLsO82bSgPMYXyKXU0zGiV9ozsdsXhilO4nM
	 TVzjzTDFTCoJwDHZ4V4wRF/HPZqliH4EfLd/oQbMzYM+munWopfG4iQIN3HMAwqBLb
	 JqT5spsL0ogRQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 14:49:39 -0400
Subject: [PATCH v9 11/12] btrfs: convert to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v9-11-77e2baad57ac@kernel.org>
References: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
In-Reply-To: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
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
 h=from:subject:message-id; bh=eXOv2g+6erFOUU/IZaJxbO9vQa8NYTuiShGXQ/xSzWM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/ZXNnKUmRwB5iP9mmNcvN/pr53xiTfFvvcjUC
 +QnCEKMk1mJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv2VzQAKCRAADmhBGVaC
 FQQgEACkRH4Qq0FubBmBQFsHTewXtBTlXLGNYfrlI+kSx3fb/dOij2i7ycA8d1/UZPwNpkHi++k
 XUIS6mXDj/NQ0PlVoOy2k8ybTh0UDwVYHkBDXrFpsxRMc5ZiQp1C4c02RKiET8x76r5KMQJxAJF
 M0gS+kQEdP64e6qvSZAXIb60uNyfpQb0RV/vgoe8ZTyMC083FnyndAx4JK20ks0nKJVVFf1q5Ag
 GjJsW/qRwBI0K0/2BcdPNw/pDrjK+1cxRO6jvCa3FhieuIPtCo4HdZJrz0qaIhPocmvVG7UB9EL
 GVNc7mPk0Yml9ghjsQAFf83e9CoavPbF4to4DT7C8lS1OpwR9nAOW9g0CevmFrUPr8gs8DFmA9I
 NApVjZlKEnzB0/BbktFG0a1YHet7mfjLdc8oYAiVGj7ycClsAA6dJq4iAvCmh0ozZTgmm5z3RPn
 EVGKKh8uY++mprUufcphF/TFPLZ6GIefT9oyPyB9CuzwA2AHIMrgbHCo7SKBLv+skxmUVWWGOuc
 uV03HX6PSiTSaGPvSTDszi7aYP/T0HoMNdGQ+Pv9H02o/RT/W0NoWemRDo5TzttOUiaTVosx7/7
 AT9c434zhUstN3P4O7zU98K/VnOls+ZOd3sSblMmPfcBpMx0vgLQYDx33M8XWHDwgVP8ZulNMtI
 2nSsA/v1yvbCVfw==
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
2.46.2


