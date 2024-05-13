Return-Path: <linux-fsdevel+bounces-19388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AAC8C4675
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 19:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4753B21307
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C352C69D;
	Mon, 13 May 2024 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJ67mDu2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548D124B2A
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622635; cv=none; b=Q3iWBfpdHnrxhuaSxR+6zzxgYxqBY9eC0dLI3qioqh22D4jxH9fx9BlBiM/0oxOKNOTsQEhAoiZlHgHQc7zp28sa/xdIicUkWdAx9fnPD5qQrS7RgTjcBzDEhEG4mD8dsCC2Xtpdn+IfMNkBTEm3TgiTacR3gk26GzEQ+zH/WaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622635; c=relaxed/simple;
	bh=CkWV6BI6pB19qRh2l/tD81uJGerHWKsptqUyLWE4ZSs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Awc+Nubw+V5sK78c9O3ceXE45r89dsDjvJ06UqsKUfZsYu23GSf0RajROZaLjiPRJm90jwJx+Vzt7HnWzmb1gqIpgdRsd05xoypjXF3UUQkuzHlr5zIXu1tmEYjH8dpv5W8hCUCfKxHzB/cgR6HhPX/AhS1YmpjV6Vyzaz4j3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CJ67mDu2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de604ccb373so7658116276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715622631; x=1716227431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GydCGd/+JJ6CmtiwKdDK/+LMhNIkbo+G+AlL2WnOnIo=;
        b=CJ67mDu2FEEbHx8Pd8/KXPC6JOEnFYZSEWNrUTCMpOwBHa+aI4GWmNfTXTcCTt4c2+
         jyiOPUm8VROgw+0F0S+6E7aTHzRgJg/7c3QTcktplQTnWgjofytSFGc4LaF81DaAJ5Io
         Zkef7RK0Jw+RMO6uN+tS8nfu3FDwOEUUuVOkwPzFJFedb4EHRMoMcdCKDw0CrFJN8X9K
         6Ggd2VR+vZZFtHNCvyNtm/3FqMEqz5+jZ6OMYsu4QgZhbDtID+qZKmvU+ieFLEaG3d2J
         vhb7efLg6BQylmk8IPq4DDjUQdOlRV//Uz2WK+nf2ui9fNdBYAr/vfy3V4ZacQfgz+dc
         v9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715622631; x=1716227431;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GydCGd/+JJ6CmtiwKdDK/+LMhNIkbo+G+AlL2WnOnIo=;
        b=dTkpkxifk3IPlofNy24GB/THoKfBhxjhgKMGjHURXQWbXLnS3ZrP3e3ODpiiAvP1jL
         ZRn4X1DVcpxwwnVcK6td/fLvrYg7mRW+xca48lQtcEFHEOZC82y88vowatwPFNmP3UOX
         39peI4ETtS2O8SaNTOEnnsoKOdKmkZq47+nvd4LdtDN4C3ZZIk0818sAOj1yUYg4LXjd
         0FZjEi8DjJMqX57OtFB5i9HfB5lhhuD0FFT7RgWHJZQtlJYbtjaZXjI32oTmgLd3pbTb
         DtqXYsE300ANycvc9dWBK1ngpNLK0AE8IC8YwxDSj4pokYfPwgLzlr9tKKOJad6SYgxQ
         jMjA==
X-Gm-Message-State: AOJu0YxsVPCsdLb0oyRLCvIeUme5YOHoQyBW7cRrL4D9w00KB0hRx1gP
	xijjZSVX/0ZvnH3kAsQdqPglULT9FmqxwTko7Ao/HASsx4mVosVeZoTq3xkBZr7o8Iev+zwsUPH
	EwyJ7w2ol2NadfsYOfI22hw==
X-Google-Smtp-Source: AGHT+IH4o0V1PT7B0QIXUskKpo4VzIQ1a06kKnU6elsU559DTS+Pna5InxhhAGymLEnliGrWo2+jzRQfH5DNflrfYQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1026:b0:dee:6147:7e26 with
 SMTP id 3f1490d57ef6-dee6bf164abmr531190276.11.1715622631413; Mon, 13 May
 2024 10:50:31 -0700 (PDT)
Date: Mon, 13 May 2024 17:50:30 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOVSQmYC/4WNUQqDMBBEryL73S1mjcT2q/coUhLdaMCakkhok
 dy9qRfo5xtm3uwQOTiOcK12CJxcdH4tQKcKhlmvE6MbCwPVJOu2Vmgklg4mGx9WL4sf9MaoTEv
 UGN3oTkCZvgJb9z60977w7OLmw+d4SeKX/hEmgQIbIttJc1F6bG+T99PC58E/oc85fwFTKLYmu QAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715622630; l=3843;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=CkWV6BI6pB19qRh2l/tD81uJGerHWKsptqUyLWE4ZSs=; b=mNrfhs0/3ITeH/kBQ/vw1Stjlb+h1///iiZ8tKZCfRXm39h8a4mOs9jc+AE1Xk4uHJiInitje
 p7X/R7A/nn1Bf98PIqJ7PZNOWtTGhtzf87FUPxdrSvNMb1SEtvvD7P0
X-Mailer: b4 0.12.3
Message-ID: <20240513-b4-sio-vfs_fallocate-v2-1-db415872fb16@google.com>
Subject: [PATCH v2] fs: remove accidental overflow during wraparound check
From: Justin Stitt <justinstitt@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- drop the sum < 0 check (thanks Jan)
- carry along Kees' RB tag
- Link to v1: https://lore.kernel.org/r/20240507-b4-sio-vfs_fallocate-v1-1-322f84b97ad5@google.com
---
Here's the syzkaller reproducer:
r0 = openat(0xffffffffffffff9c, &(0x7f0000000040)='./file1\x00', 0x42, 0x0)
fallocate(r0, 0x10, 0x7fffffffffffffff, 0x2000807fffff7)

... which was used against Kees' tree here (v6.8rc2):
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=wip/v6.9-rc2/unsigned-overflow-sanitizer

... with this config:
https://gist.github.com/JustinStitt/824976568b0f228ccbcbe49f3dee9bf4
---
 fs/open.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index ee8460c83c77..23849d487479 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -247,6 +247,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
 	long ret;
+	loff_t sum;
 
 	if (offset < 0 || len <= 0)
 		return -EINVAL;
@@ -319,8 +320,11 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
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

---
base-commit: 0106679839f7c69632b3b9833c3268c316c0a9fc
change-id: 20240507-b4-sio-vfs_fallocate-7b5223ba3a81

Best regards,
--
Justin Stitt <justinstitt@google.com>


