Return-Path: <linux-fsdevel+bounces-19220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37338C1874
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 23:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3347B1F22834
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 21:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A235E12838D;
	Thu,  9 May 2024 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QK3JNBrc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9867182871
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715290508; cv=none; b=nwtXepgFMYBrT+qqEW/zyWbXpc03jS+JulIDJoPayDSXy4QGChwl3p4iYkbGFErXAFUCUToo1VOjr2GhopMFAXDK9Mx7z1WWbd6uAZeRPrS4VLFvoplzkw/TSxBBWWFVLMCCTOKap4IW95+bmfTFrwKClVlFEUkbOon2Mpa4Rqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715290508; c=relaxed/simple;
	bh=uv7v4MLGPmkr51z3KG/Rh+hiMOP4ZZ4Gh3YiVTDYvFA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lleVO0NhsG5Tnry9IXQXDAlmYRxqhJja5mkKdxZ1+3u5H2ARKUZTiVCLp0PmD/x3PQ3rarGt2EkB7KeiZ415zM5rfcpzNGIdikwPLRWP51Z6IPzcwOA5WuhFvGnPEe5LE0llO+AfYNmXs2v9qXRiePZ4l2NWJv5SUOwClXxawpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QK3JNBrc; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7de9c6b7a36so146513739f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715290505; x=1715895305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ImQHVo+vcC5MB5qhHl7DBcXB3jiIy8A/c5k1YsEXD8=;
        b=QK3JNBrcSu/NcL1suArpqCa8gQtQNQR+tgaNL2KSrFscI6VSuhIQ/ttF8JTLC9UC7h
         A4OIguVzNL/J/qmy5Pjpgq/z7D5XYY82LpOff8nfvYGR2kUkXnYu0vlrgOFa62/2989A
         RZQkyHGVM4GdVr1bTwsywHUiM7sSwzf1SEEFVVfWOqaQhZzAIZmG21fjMQ7ROlCZLy2s
         9eIvAZrwKAS+gKyUpPx0nmV/eUY9Iihn2wsHfjAmp+jJs1QR5+kkULhbJS+fFFfl8vWo
         3+H6cbDX8paWaVIjS0Km+1wlirsvoJI6km313R5hfufBi8/dlBJk/P8ze1MveVy05uiK
         wHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715290505; x=1715895305;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ImQHVo+vcC5MB5qhHl7DBcXB3jiIy8A/c5k1YsEXD8=;
        b=FpKAQ60MksXG4NQTnowGyi+31Swm6SQwRWUEgZB9cBUjimkwdYoDXSpN6mNCgcN8q5
         qT8La1jPcoWbeNOk+JQHUQX8yK2qFs15CJKVrosskBUXV+PNdzZz4/q+oH5QM+3Y1bk0
         ZIHj1t4eNuL2VeNJO5S4EEaczFdw2EWKvfmMadiRvIG4by/weWjzjYKF2WgkMsiIC7KN
         QoIZBCzLvDPTveceicHcRZ48hI+TrIbDxTmPbhIWBk5JAMVcKOLBQ58r9VUCY7PxIuAk
         4eWK8Ki3AKsNv9QFyV6cF+IrFv2G4B5IlCytEgak0mksGjXm+5Wc64Dn7JwSUF/xtOxY
         75yQ==
X-Gm-Message-State: AOJu0YyRPQTKSOei7PSm6ulWIPy7rBJG9CKVttcMb1jKmx07wCg7x/Qz
	+pzZLFp8g8S1p9BAFAIZ292vyabbRtbx8vYV3zTy/3FTqlddfSN5TJUG+hX5UphAvBnkYDcd0gh
	Nn9S8HkrBHYSfXNQGjo/NJg==
X-Google-Smtp-Source: AGHT+IEiRdYq8Wex8h99nh5WydPpX7Vq4lpKhEWtZ+gSr9d2J4XqXwoNHRMO2CMehVVFUu1nF4aO/lTCJhlUg5Bhmg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a92:d583:0:b0:36c:4844:2836 with SMTP
 id e9e14a558f8ab-36cc13899e6mr147835ab.0.1715290504877; Thu, 09 May 2024
 14:35:04 -0700 (PDT)
Date: Thu, 09 May 2024 21:34:58 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIFBPWYC/x2M0QpAQBAAf0X7bGtdh/gVScct9gXtCXX5d5fHq
 ZmJEFiFA7RZBOVLguxbgiLPYFrdtjCKTwyGjKWSGhwtJgeVnR9ulZORrCtqb6kyxJC6Q3mW539 2/ft+srErTWMAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715290503; l=3178;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=uv7v4MLGPmkr51z3KG/Rh+hiMOP4ZZ4Gh3YiVTDYvFA=; b=moZCMobUhHuu5mlPuDlnNyf1lyGJPFFtu9MPpPL6JANzBLFDu+rnxPw5+YcK4vY3CvBZCb8No
 IgZlxxdOpElBUyRvDC0EZAHJ7C5+t0Jtsl5u7iJZKAXlCc4UzjVKcU4
X-Mailer: b4 0.12.3
Message-ID: <20240509-b4-sio-read_write-v1-1-06bec2022697@google.com>
Subject: [PATCH] fs: fix unintentional arithmetic wraparound in offset calculation
From: Justin Stitt <justinstitt@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

When running syzkaller with the newly reintroduced signed integer
overflow sanitizer we encounter this report:

[   67.991989] ------------[ cut here ]------------
[   67.995501] UBSAN: signed-integer-overflow in ../fs/read_write.c:91:10
[   68.000067] 9223372036854775807 + 4096 cannot be represented in type 'loff_t' (aka 'long long')
[   68.006266] CPU: 4 PID: 10851 Comm: syz-executor.5 Not tainted 6.8.0-rc2-00035-gb3ef86b5a957 #1
[   68.012353] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   68.018983] Call Trace:
[   68.020803]  <TASK>
[   68.022540]  dump_stack_lvl+0x93/0xd0
[   68.025222]  handle_overflow+0x171/0x1b0
[   68.028053]  generic_file_llseek_size+0x35b/0x380
...

Historically, the signed integer overflow sanitizer did not work in the
kernel due to its interaction with `-fwrapv` but this has since been
changed [1] in the newest version of Clang. It was re-enabled in the
kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
sanitizer").

Since @offset is later limited by @maxsize, we can proactively safeguard
against exceeding that value and also dodge some accidental overflow
(which may cause bad file access):

	loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize)
	{
		if (offset < 0 && !unsigned_offsets(file))
			return -EINVAL;
		if (offset > maxsize)
			return -EINVAL;
		...

Link: https://github.com/llvm/llvm-project/pull/82432 [1]
Closes: https://github.com/KSPP/linux/issues/358
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Here's the syzkaller reproducer:
| # {Threaded:false Repeat:false RepeatTimes:0 Procs:1 Slowdown:1 Sandbox:
| # SandboxArg:0 Leak:false NetInjection:false NetDevices:false
| # NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN:false
| # DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false
| # IEEE802154:false Sysctl:false Swap:false UseTmpDir:false
| # HandleSegv:false Repro:false Trace:false LegacyOptions:{Collide:false
| # Fault:false FaultCall:0 FaultNth:0}}
| r0 = openat$sysfs(0xffffffffffffff9c, &(0x7f0000000000)='/sys/kernel/address_bits', 0x0, 0x98)
| lseek(r0, 0x7fffffffffffffff, 0x2)

... which was used against Kees' tree here (v6.8rc2):
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=wip/v6.9-rc2/unsigned-overflow-sanitizer

... with this config:
https://gist.github.com/JustinStitt/824976568b0f228ccbcbe49f3dee9bf4
---
 fs/read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index d4c036e82b6c..10c3eaa5ef55 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -88,7 +88,7 @@ generic_file_llseek_size(struct file *file, loff_t offset, int whence,
 {
 	switch (whence) {
 	case SEEK_END:
-		offset += eof;
+		offset = min_t(loff_t, offset, maxsize - eof) + eof;
 		break;
 	case SEEK_CUR:
 		/*

---
base-commit: 0106679839f7c69632b3b9833c3268c316c0a9fc
change-id: 20240509-b4-sio-read_write-04a17d40620e

Best regards,
--
Justin Stitt <justinstitt@google.com>


