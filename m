Return-Path: <linux-fsdevel+bounces-18971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 613D08BF2C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 01:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F04282A9F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 23:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C5612A175;
	Tue,  7 May 2024 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CzWCw4zl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C3180BF5
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123880; cv=none; b=afe+mlfhDqzJIT09bXzZeTb0pxVo2gVBY7qJF987ZeqU9t161U23Qt+/97QpduTu05It8l4SHANZJ4sbqSn57daLdpguVpkZdKM7t/PZBdLy3gKSxaPBDf+z7HtGhjtkrJ03PNBPIHwfOv7JNuGzVOfIY0e2328JHeC4xTD4i0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123880; c=relaxed/simple;
	bh=blSl364swsDcz/ERpxYIrtfmuULQVemGaeVD2pgedbw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WKy2hn6/FKtIcx2F5JhDlZdcgkNvPtSCftkAgJF1d6iokQIZeDpAONdxRPli71JMEdbUCjAKocZPz/aj6WDZ29QlCllYxH1FlyqE/vIYjnjUCs7CcmwVQMwwHOSJqMTZvTt0cuJOPfBrS2iJmtf4pbKe3pDUH/tL0Kj9N0Ps6w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CzWCw4zl; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de59d580f61so6856540276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2024 16:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715123878; x=1715728678; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=90t3eEjytmnEM4io+FHTgKxLXZqFJBWBJ/adXIPm22Q=;
        b=CzWCw4zl0Is6iW5jYXyFfkMlwxZ8o6abzYdSvd/cIb9EqAso6VHMnT83fcO4gseQWl
         K7QNMHtkT8yK/4mlNFI3ZGXvlNxHO65frLy0uA97HBa9TP47yCiMLMzRmNwv6QqqeTdf
         m1JvFwjyfS5ZGNIykmreFF27QhcQrRKkQHrAMu5UNh/8PM55nTR6ahBz8Qulx7q/NROC
         fjxH8vXfNmzb7mpecQLDyZONQDDQSNRDtpflar9OuIeoSrnWqyjs1SoJ7si/UoSNupN5
         sTW2GsWMTyiifqOtNbLHOVg2xB+iav0oufKx5repAInLa6Mo+e6NFFebNM0j7Dp/w/Q4
         5dsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715123878; x=1715728678;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90t3eEjytmnEM4io+FHTgKxLXZqFJBWBJ/adXIPm22Q=;
        b=kh4TJ61fkvA0ribn5EOt/Zn3UZzYWcFcK5ZqJ7FONMRkVnnZgQMGg4auQPWX4BEOGz
         kQ8TGtJMQJ26D2+83vqw15s2Tmk1V/3RgYNy6nWa07nkOrAAMPvwZpMiSksFv2vMgNNs
         F0D2/kbFWFiXcdJTtl92LIDdj+OGvS55aPDVvNQusGT+ZQ8q1Fng3pnLVgcNtGCLG5gD
         rpf0H94IMJKXUYneUyJKFLfphGNKRrqoo8pTg2rta7IIU8sNPSdv6aEaxxlYlUEsr/T7
         mpXl4vnaHvKCrRhpLBhfrbz160xXNioD9Cw4wNquyLe069ifq0ERTP3bPyaqyJ2ssZH7
         jK0Q==
X-Gm-Message-State: AOJu0YwwdCSCwl7wEY6tUqGfFGsyyrJ2/bB/cSBcmHoK6R2MvyOXF1y3
	xbV7YjMUajSq7CiKHJKtRxPJsb+WtdGndMffhF9QXkFMip1P8u7uZnGRPDWUY4hEBLXsvIWBPEG
	bX2xO0U2BV9ufQW2qmE0CmA==
X-Google-Smtp-Source: AGHT+IGago2GGdxQm89gh39NlH33JmwS6GqCoBfbuogGsvoaLHySBMHGg6BnHjR0lMvUAF6sj1cRWbGYVdT+02bkdg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:44:0:b0:dc2:466a:23c4 with SMTP id
 3f1490d57ef6-debb9d86d55mr321974276.4.1715123878004; Tue, 07 May 2024
 16:17:58 -0700 (PDT)
Date: Tue, 07 May 2024 23:17:57 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKS2OmYC/x2MQQqAIBAAvxJ7bkGtKPpKRKy11kJYaEgQ/T3pO
 DAzD0QOwhH64oHASaIcPoMuC5g38iujLJnBKFOrRrVoa8wOJhcnR/t+zHQxtrYxprJUUachp2d gJ/e/Hcb3/QAwM9kbZgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715123877; l=3920;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=blSl364swsDcz/ERpxYIrtfmuULQVemGaeVD2pgedbw=; b=MLjQXcFsv9K2Tt+v1PmmzhEUpm6om4s2Veu1ZlHay+lCkxT157wDH7v2E6JBghpitVFvli2u2
 JzL/WgNvUb/DEhYX8FWJxXs8D18zY52t2ZNlH6v1pNeUPgR+Vwdzxvo
X-Mailer: b4 0.12.3
Message-ID: <20240507-b4-sio-vfs_fallocate-v1-1-322f84b97ad5@google.com>
Subject: [PATCH] fs: remove accidental overflow during wraparound check
From: Justin Stitt <justinstitt@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

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
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
I wonder, though, why isn't loff_t an unsigned type? We have plently of
checks to ensure they are positive:

	if (offset < 0 || len <= 0)
		return -EINVAL;
	...
	if (((offset + len) > inode->i_sb->s_maxbytes) || ((offset + len) < 0))

... are there ABI concerns?

Here's the syzkaller reproducer:
r0 = openat(0xffffffffffffff9c, &(0x7f0000000040)='./file1\x00', 0x42, 0x0)
fallocate(r0, 0x10, 0x7fffffffffffffff, 0x2000807fffff7)

... which was used against Kees' tree here (v6.8rc2):
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=wip/v6.9-rc2/unsigned-overflow-sanitizer

... with this config:
https://gist.github.com/JustinStitt/824976568b0f228ccbcbe49f3dee9bf4
---
 fs/open.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index ee8460c83c77..d216e69d6872 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -247,6 +247,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
 	long ret;
+	loff_t sum;
 
 	if (offset < 0 || len <= 0)
 		return -EINVAL;
@@ -319,8 +320,12 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
 		return -ENODEV;
 
-	/* Check for wrap through zero too */
-	if (((offset + len) > inode->i_sb->s_maxbytes) || ((offset + len) < 0))
+	/* Check for wraparound */
+	if (check_add_overflow(offset, len, &sum))
+		return -EFBIG;
+
+	/* Now, check bounds */
+	if (sum > inode->i_sb->s_maxbytes || sum < 0)
 		return -EFBIG;
 
 	if (!file->f_op->fallocate)

---
base-commit: 0106679839f7c69632b3b9833c3268c316c0a9fc
change-id: 20240507-b4-sio-vfs_fallocate-7b5223ba3a81

Best regards,
--
Justin Stitt <justinstitt@google.com>


