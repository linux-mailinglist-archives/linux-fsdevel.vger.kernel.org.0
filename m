Return-Path: <linux-fsdevel+bounces-23568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD9F92E5D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 13:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD7E1C21DEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 11:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7178F16EB76;
	Thu, 11 Jul 2024 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIYSBlDz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0F16EB55;
	Thu, 11 Jul 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696129; cv=none; b=ALV7g7f6j8XqQXUKW7ocdZ8A0MkBpLEVKALxwWbsz6hwebYaKj+DyHMtMB+QViwfZMe5NU1DR7KzPclxkrh9ODlMlLycj4U0tdntc3KIoDgRT8X8lHlSsVqIF2evKbLdJ5gs0UmeXynFTsoiGVGK48gBwH2j4Nm7dReZ+qaQQWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696129; c=relaxed/simple;
	bh=xTk9IFiZeoZdqPbR7bcsVc6tPLRLkOIJYDVl81q/MME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FxRFtMk8ed1/0xAXL/clLth7/xwQ7ONgzvLeOK/5Uv+ehpLJSyI/F+vD9f/h0BGLOYC2idNXlQnYvmHAoYL1vu2fvHiz72xWbAVJr5pbAInDNCMydfQl0cUKfA7R1OgbddwOaOhXJY6rZRUY8hl/BQvlRdjhdBmIaZ1LnDZ3vmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIYSBlDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690D2C4AF0A;
	Thu, 11 Jul 2024 11:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720696129;
	bh=xTk9IFiZeoZdqPbR7bcsVc6tPLRLkOIJYDVl81q/MME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PIYSBlDzi3izlhhsIih/pyOcBS1LMKHlSVybt8iwDKMCT/KuB+uwW5ZH/4UDnvHt2
	 iQmqRu9FPZfscB4x1O8ANDwsFpStacAQn1MZcv3WRPTRtaX73PHMYQyQFGyYQGHiSD
	 uVU0KS+6pKts00oAL3Oad3Sdrxu58b4u/W8mOZNypM4ig/boWOPsrXhK79SRxP+ror
	 Vi0p96D0J6Xep6j+EXS9SFWrtblFyvbZV6WHVx8Rvyoiqw9M0WX/4w55T4qbJ/Ghkc
	 ufKRaU4Ci/y52xxGlR2i1JJsMXG0lQDkq+SsEElni0wujfCUS4LA2B8yXhSG4Ifr2+
	 70sfbdd2Cqs1Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jul 2024 07:08:12 -0400
Subject: [PATCH v5 8/9] btrfs: convert to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-mgtime-v5-8-37bb5b465feb@kernel.org>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
In-Reply-To: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
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
 Randy Dunlap <rdunlap@infradead.org>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2583; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xTk9IFiZeoZdqPbR7bcsVc6tPLRLkOIJYDVl81q/MME=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmj70lhNewWHh61CO1bt11704SMJNMRrO6Etw2W
 30QskLPOVmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZo+9JQAKCRAADmhBGVaC
 FWr4D/9/BKDDLNpeTxoxJKR9NnOB0Mj4UHHvSvM5FydPU9wm1TtZNljZG5FdmhRnlVA/EU3EXzh
 jf/KKNDLSi/SkxpUOyQcE/LCWROpGNQa8YBQVBIrykpJkAuUaTSB/x3HeDxG1iNhLnyZOP6wmv7
 CKV77Ru+Ii2wwDEoVcJ5lK/s9p0eidSnOxpZhJLK+yjjY5n64i+NVh/Is5z0+bCWVJC/Wkm1RH+
 tNa1TaLjw+meKTwcACY4E5sbvvFtJJAboc11Ga/shYG8MEikSL+PEnLXpy5qovDMn0a+o2f0Ym7
 k64mPNcEDEbQA+pq0VFMER0k2zzjogtxHfVDP8CPHs44giEoqX+5QRMSB4qlvElDZJeYfOfNkCL
 h6CgItnEYUOg7obynfz1AKOmd5WeuEpHoH32KDvJGcr8u+wNqFW2bjON7JpfxXdiNQg67aOX3i7
 cqM2H4I2b+Owt1/0khoFpTec36REaIYLbwYzuJl9I7knlouHgymKaeJNYKdKPQUrPgBa6h9PzRd
 r8gQtiz/H1OwqeSyKf7WhIqGVAa/TI7+AkAH4tyAEzG3AUdzNctz4o5MbhhGkRzOGJSTa3wkQiH
 iZ1RyliJcivTulNvI+EYYJoflW+3qIliMy3wtk5seaDzPMrlZJO7+uQTJBw7YAlp1Y8S9F7YbXU
 acGupOaNKLqwSnw==
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


