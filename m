Return-Path: <linux-fsdevel+bounces-19230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871318C1BCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 02:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8A4282D5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 00:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C5EF9D6;
	Fri, 10 May 2024 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SrRg8syR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9EC5C99
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 00:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715301354; cv=none; b=Bzhv/ys4Eerum4H9xiQVXZL4ESxBvNCRx88GmwhqRtTKCIiB4gaJlaa+XghacTir5WpOsAqoIqsEf+ZuARBPbmh5wSvi2RR/+t6qrjg08xtMmJpNuN0mJ7U479vK1vyb5sMegisrkxivUXZ5zeck5uQCPCO3vQ267SZp3EunBNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715301354; c=relaxed/simple;
	bh=A6Ud7RP+XPGEndCXwu0iH4gOduKG/AYC7ysUshGfKZQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ss0bxEtNroGsI0zjGLmda2T1++vt4CQGHe2zRtXU2euHj8JyH/d7asNU9OqhWg8w84Vca4sCVBvL63lqtL3lusaW0kBnvFw1p4ji5K4eMsH5WsMYWEAH/uAKYX/8XidT4wXOkDS6t/3oHRhQLf3cmQIZohA0LmB9uRP8rWzEU1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SrRg8syR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6204c4f4240so22117587b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 17:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715301352; x=1715906152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JRIoam0j1M49iTn2E355v3TI8UxS6k39m0Um4TZVhLw=;
        b=SrRg8syRlktl/jJWW6gSttTzqFhpXWkgxsodKFtHHNjx6wQ8ryw6UookH19/m/9IwQ
         /qTrxKOLKPozU3ac38JA545YZCXBfBgfzzeeZiJsHNfB6nitQoR4UKEhrw1X3RXLWN+2
         8iQ9STeO45nkWiuMTKwX9OYuR0foxQuGdwfG4+Xq+CMABYjr66NeYTmAkMILB6W4NTtA
         yIxuypOe96dzpAna5lZ0F0VbmIaPzwJOg9HZy4Yji1bYO7VHXLfXKE9mN3orpdn8c9Zu
         JEO1wVsAxsqAKbYbsYUD8tIt8QXDyLtn1DONCpXqa9VYj/lnJIJx9IDtrefpk6X+EWxc
         BeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715301352; x=1715906152;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JRIoam0j1M49iTn2E355v3TI8UxS6k39m0Um4TZVhLw=;
        b=CvzsRdyVOA7mQ12pMHwrn6ma2zf0DpNNxVGNU1QBAyRPMSZmxeZeCkv5DvmCXJTkBf
         MwSmIpj58EPDblGrYNzNBdJaunR1EE8o+XqmnBWz1JiKyy04oZq76wzzCh9goI59VyYc
         LJNaH/pa8Zifild+jc2WLSegugRvp+vbABWoeuC18FDwZFxbX63YnPLZOqPmxFyRLD5W
         BUeBtom1cGrPi1mgA+lcYz/J2T6rX6kt5hlxSibUvWaNZpXaov09ufBmjZipokeyhGY2
         MaWof9ipZRgF8Z9kAd77RpI6Au2kL4dmBUQyPMY0jTcxvI8/Iv7NENa2hPiuYovMdcAM
         ousA==
X-Gm-Message-State: AOJu0YxFhbUWSFViqCClfujJKiRmBDXaYi4laweK6wPwxxS5ecOz+5Is
	jFZLvNqzfeYUuc2IFmd9P/31HUiI66nhHtwfwy5ZGu9p0QC8wK/VdW9f+6SKazYm+J+saSslF6E
	sjbmgFuQo7EiH0d7pbHvD/A==
X-Google-Smtp-Source: AGHT+IHJL8hsG0mvnXN9NTELNsYrQvpZSdlZUdc+4IRp10nXSK7S/+o1UQOBYkTXbb92FFrUo0i8behfYeZs/OhBkw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:4d88:b0:61a:d161:ff8a with
 SMTP id 00721157ae682-622aff477f3mr3037367b3.1.1715301352393; Thu, 09 May
 2024 17:35:52 -0700 (PDT)
Date: Fri, 10 May 2024 00:35:51 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOZrPWYC/x2MQQqAMAzAviI9W5izOvQr4mHTqgVRWUEE2d8dH
 gNJXlCOwgp98ULkW1TOI0NVFjBt/lgZZc4M1lgyjekwEGYHdwmLYus6cpbIk68hJ1fkRZ5/N4w pfa+vRBFeAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715301351; l=3359;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=A6Ud7RP+XPGEndCXwu0iH4gOduKG/AYC7ysUshGfKZQ=; b=Qz81LOMknGCFGBFXpjp8tTJXGsQ9A8sScMtbF2qSupAvT3AI53qskUBYHBt1xTlul7o8nliAo
 /rHuR0QAfQhDLKW/2/JBfllQFsn9fZ92VgMllO/zxN3OF004iyse9Hh
X-Mailer: b4 0.12.3
Message-ID: <20240510-b4-sio-libfs-v1-1-e747affb1da7@google.com>
Subject: [PATCH] libfs: fix accidental overflow in offset calculation
From: Justin Stitt <justinstitt@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Running syzkaller with the newly reintroduced signed integer overflow
sanitizer gives this report:

[ 6008.464680] UBSAN: signed-integer-overflow in ../fs/libfs.c:149:11
[ 6008.468664] 9223372036854775807 + 16387 cannot be represented in type 'loff_t' (aka 'long long')
[ 6008.474167] CPU: 1 PID: 1214 Comm: syz-executor.0 Not tainted 6.8.0-rc2-00041-gec7cb1052e44-dirty #15
[ 6008.479662] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 6008.485276] Call Trace:
[ 6008.486819]  <TASK>
[ 6008.488258]  dump_stack_lvl+0x93/0xd0
[ 6008.490535]  handle_overflow+0x171/0x1b0
[ 6008.492957]  dcache_dir_lseek+0x3bf/0x3d0
...

Use the check_add_overflow() helper to gracefully check for
unintentional overflow causing wraparound in our offset calculations.

Link: https://github.com/llvm/llvm-project/pull/82432 [1]
Closes: https://github.com/KSPP/linux/issues/359
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---

Historically, the signed integer overflow sanitizer did not work in the
kernel due to its interaction with `-fwrapv` but this has since been
changed [1] in the newest version of Clang. It was re-enabled in the
kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
sanitizer").

Here's the syzkaller reproducer:

| # {Threaded:false Repeat:false RepeatTimes:0 Procs:1 Slowdown:1 Sandbox:
| # SandboxArg:0 Leak:false NetInjection:false NetDevices:false
| # NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN:false
| # DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false
| # IEEE802154:false Sysctl:false Swap:false UseTmpDir:false
| # HandleSegv:false Repro:false Trace:false LegacyOptions:{Collide:false
| # Fault:false FaultCall:0 FaultNth:0}}
| r0 = openat$sysfs(0xffffffffffffff9c, &(0x7f0000000000)='/sys/kernel/tracing', 0x0, 0x0)
| lseek(r0, 0x4003, 0x0)
| lseek(r0, 0x7fffffffffffffff, 0x1)

... which was used against Kees' tree here (v6.8rc2):
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=wip/v6.9-rc2/unsigned-overflow-sanitizer

... with this config:
https://gist.github.com/JustinStitt/824976568b0f228ccbcbe49f3dee9bf4
---
 fs/libfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 3a6f2cb364f8..3fdc1aaddd45 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -147,7 +147,9 @@ loff_t dcache_dir_lseek(struct file *file, loff_t offset, int whence)
 	struct dentry *dentry = file->f_path.dentry;
 	switch (whence) {
 		case 1:
-			offset += file->f_pos;
+			/* cannot represent offset with loff_t */
+			if (check_add_overflow(offset, file->f_pos, &offset))
+				return -EOVERFLOW;
 			fallthrough;
 		case 0:
 			if (offset >= 0)
@@ -422,7 +424,9 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 {
 	switch (whence) {
 	case SEEK_CUR:
-		offset += file->f_pos;
+		/* cannot represent offset with loff_t */
+		if (check_add_overflow(offset, file->f_pos, &offset))
+			return -EOVERFLOW;
 		fallthrough;
 	case SEEK_SET:
 		if (offset >= 0)

---
base-commit: 0106679839f7c69632b3b9833c3268c316c0a9fc
change-id: 20240509-b4-sio-libfs-67947244a4a3

Best regards,
--
Justin Stitt <justinstitt@google.com>


