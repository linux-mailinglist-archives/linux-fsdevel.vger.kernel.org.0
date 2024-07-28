Return-Path: <linux-fsdevel+bounces-24373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51F393E223
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 02:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A4E1C211BB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 00:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14FB188CD7;
	Sun, 28 Jul 2024 00:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5NK79yU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D432187879;
	Sun, 28 Jul 2024 00:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127763; cv=none; b=UptUtEPyHUAxriVmeVy27pR6iubDtdEjQPt7vtCXR6QtwBchmFgMUef6luEYc15Cvmb4+WTKYtCAO4gTH+jaB8jADI63BYNQLT0dfnH2gVxafdGcGcPHYaLEy/NPzWQyurzTYWhBhsOykzLAC1BX3xdiPINlLEywbLj9qoJuOkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127763; c=relaxed/simple;
	bh=bC1HUsuDKnfZNef5VXvzE3rY8BeJKC1c+JenZbn8EYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d0dsh8UdlKOQHDP3yut0KxRWCnQp0pcYDtC2cp8Ar5u0FARAIdPPCgDthvDIyQHTkaQky++ekHHeMZLCKnyKn1OngryS5LnVPrP6FQkuawUqC7UOh8Wm9ScdQq2Z/O1Ufe5UH/eN6bteqE4Q1zr4VCoQFhzR6N9ojSeD5zhU1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5NK79yU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FFBC32781;
	Sun, 28 Jul 2024 00:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127762;
	bh=bC1HUsuDKnfZNef5VXvzE3rY8BeJKC1c+JenZbn8EYc=;
	h=From:To:Cc:Subject:Date:From;
	b=j5NK79yU17BCkJtCCASL74F9XdumeLyfTqtAYFl//S/jCGqwhP+VKz0WjgcpKmXlY
	 PJ6O9KvUm/2oBo623PYd0Bzd//GTkUsm9CvoRg8PflomBOgexFCiJqkJeNw6H0oqC3
	 bkZJ94sEcEucwSMLzrTCALeKIeWwACJI05v8Wptllv7rlw55OCJ3r7WgjfSRku3RQG
	 0I1ImJNKBEUSINCQucwStu5c5ayxwbVfECEdMvnbgu+YEnXcFnDziqz5XGp5hCGPar
	 jDpjvxTZq+FxEED6acm3rZ61Nc4KUEwu/z8KPZiI5m/XsJgfLb5/mvrocUbDH4hlR2
	 AtEUmOCw0fuiw==
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
Subject: [PATCH AUTOSEL 4.19 1/3] fs: remove accidental overflow during wraparound check
Date: Sat, 27 Jul 2024 20:49:17 -0400
Message-ID: <20240728004919.1705708-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
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
index 7763a1a10f592..2751cb70f2dc1 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -229,6 +229,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
 	long ret;
+	loff_t sum;
 
 	if (offset < 0 || len <= 0)
 		return -EINVAL;
@@ -297,8 +298,11 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
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


