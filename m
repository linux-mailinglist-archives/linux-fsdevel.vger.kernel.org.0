Return-Path: <linux-fsdevel+bounces-24371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0134993E20C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 02:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC4C1F2147A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 00:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A593147C74;
	Sun, 28 Jul 2024 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZyoEj3d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB899208DA;
	Sun, 28 Jul 2024 00:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127744; cv=none; b=Oa5+opERdubGgO2hNOKP5TMcnuFUstZvSIPKUToFZ0XpmymV5ay9atnTx2ii8l6GAkMrXctF2g+G9prBqa8Y81IYwEp+MtnBUsmMdlUP2AZ8xBY+NLA7+h9aws+f4r3hYCL+lzwG2nWKWLBBYvavFMv/jJLzEsTp4pm0aLrdK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127744; c=relaxed/simple;
	bh=qlls8nadydMQdAhtVXES5HNSi8rNjEtYZjtPgyS4Ebo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GAaU9EGq8BlLO0uopcUB94SVQxX/tlipcO/++OtXLZ1q9GjN7knjZrfeVELBCNSewYGCWKX8vFRXsN3LxOywLQClDb4uWCfF4bIZyo2TW44v/lHM6J4eQB+TEC7GVj2LdMjsBVr8zTlj51YssGMZNsxoHj32JZ+sNI5A+7QcSFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZyoEj3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AADC32781;
	Sun, 28 Jul 2024 00:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127744;
	bh=qlls8nadydMQdAhtVXES5HNSi8rNjEtYZjtPgyS4Ebo=;
	h=From:To:Cc:Subject:Date:From;
	b=IZyoEj3drJ6HrtU2I9bZ9HfP+3KB/y4tY/iqUemA9kUw8Zce0fWGPYubOksPZ+NGl
	 QOOSfgvxevi94Jj/MYCTVwaPJqnJdBAHyXTNffq4nr4TIbNX1fwuMS1JviD2jYiFGz
	 baD7ajGTDqk5zAuCcZlJhW3od320Nf69ly1yhDFIY6xcUV9Z5ZU18YZoEhm7g3yO7L
	 +irzIvX/cYnHGEYJpOsmRPIs98mGIvayab2ncP9Ugyq40B8Y5NxDSB75/56PQMP/28
	 c4/+1BdPvmA4c51XPeer4GjdvXTKPR081T9yqFkdrSMgz2P5XyLEtaMUvcGT7uvlhR
	 FU1RZpXL4H2Ig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	nathan@kernel.org,
	linux-fsdevel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 1/6] fs: remove accidental overflow during wraparound check
Date: Sat, 27 Jul 2024 20:48:54 -0400
Message-ID: <20240728004901.1704470-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Justin Stitt <justinstitt@google.com>

[ Upstream commit 23cc6ef6fd453b13502caae23130844e7d6ed0fe ]

Running syzkaller with the newly enabled signed integer overflow
sanitizer produces this report:

[  195.401651] ------------[ cut here ]------------
[  195.404808] UBSAN: signed-integer-overflow in ../fs/open.c:321:15
[  195.408739] 9223372036854775807 + 562984447377399 cannot be represented in type 'loff_t' (aka 'long long')
[  195.414683] CPU: 1 PID: 703 Comm: syz-executor.0 Not tainted 6.8.0-rc2-00039-g14de58dbe653-dirty #11
[  195.420138] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  195.425804] Call Trace:
[  195.427360]  <TASK>
[  195.428791]  dump_stack_lvl+0x93/0xd0
[  195.431150]  handle_overflow+0x171/0x1b0
[  195.433640]  vfs_fallocate+0x459/0x4f0
...
[  195.490053] ------------[ cut here ]------------
[  195.493146] UBSAN: signed-integer-overflow in ../fs/open.c:321:61
[  195.497030] 9223372036854775807 + 562984447377399 cannot be represented in type 'loff_t' (aka 'long long)
[  195.502940] CPU: 1 PID: 703 Comm: syz-executor.0 Not tainted 6.8.0-rc2-00039-g14de58dbe653-dirty #11
[  195.508395] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  195.514075] Call Trace:
[  195.515636]  <TASK>
[  195.517000]  dump_stack_lvl+0x93/0xd0
[  195.519255]  handle_overflow+0x171/0x1b0
[  195.521677]  vfs_fallocate+0x4cb/0x4f0
[  195.524033]  __x64_sys_fallocate+0xb2/0xf0

Historically, the signed integer overflow sanitizer did not work in the
kernel due to its interaction with `-fwrapv` but this has since been
changed [1] in the newest version of Clang. It was re-enabled in the
kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
sanitizer").

Let's use the check_add_overflow helper to first verify the addition
stays within the bounds of its type (long long); then we can use that
sum for the following check.

Link: https://github.com/llvm/llvm-project/pull/82432 [1]
Closes: https://github.com/KSPP/linux/issues/356
Cc: linux-hardening@vger.kernel.org
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
Link: https://lore.kernel.org/r/20240513-b4-sio-vfs_fallocate-v2-1-db415872fb16@google.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/open.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 694110929519c..be3eb6126d6da 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -230,6 +230,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
 	long ret;
+	loff_t sum;
 
 	if (offset < 0 || len <= 0)
 		return -EINVAL;
@@ -298,8 +299,11 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
 		return -ENODEV;
 
-	/* Check for wrap through zero too */
-	if (((offset + len) > inode->i_sb->s_maxbytes) || ((offset + len) < 0))
+	/* Check for wraparound */
+	if (check_add_overflow(offset, len, &sum))
+		return -EFBIG;
+
+	if (sum > inode->i_sb->s_maxbytes)
 		return -EFBIG;
 
 	if (!file->f_op->fallocate)
-- 
2.43.0


