Return-Path: <linux-fsdevel+bounces-33657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ECC9BCB8B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 12:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54DD1F2450A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 11:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB0D1D31B5;
	Tue,  5 Nov 2024 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="n8NUD6SU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward202a.mail.yandex.net (forward202a.mail.yandex.net [178.154.239.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7911D358D
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Nov 2024 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805700; cv=none; b=X7ckxFV5fcJpg9y/xhwaKiyo/3GYbnGWjMVxSD6GUdFLBAYjYKIEZUOleNqiehezFo04ak3w+v5yGD1rN3YoJjaEaRTHs2jD1AUhRo6AjljbGLJNKXLyr6eZjqqoH42B890yA18zu9/qM5BXHpxl4jy1CwIzT8oZFK9VVy0EzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805700; c=relaxed/simple;
	bh=Zs6R+sbXRe9oUhxPUrnGsbevcIuQBq/PDAD+KcSX2dY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t9/lY4mTU7FNefvfxgFHDsu+Eq7cHa4Ve5+WvebyP68eBXfSoz0KrX/tDuAs9KUgowoBLJ4+QHDdmlQnjCh5g2KxkWb7K8xoD/mJOfe1kY9ops2rAUrHBGyAJIpSENJcoa9I8WJ/aNu8wTadT12/GvEMXvN4s+1xn7P+QgzMwr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=n8NUD6SU; arc=none smtp.client-ip=178.154.239.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward202a.mail.yandex.net (Yandex) with ESMTPS id AEEDC697A3
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Nov 2024 14:14:27 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2e15:0:640:bcf8:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 5F64A60DC3;
	Tue,  5 Nov 2024 14:14:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id IEe9B37qB8c0-hxYvLQYY;
	Tue, 05 Nov 2024 14:14:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1730805259; bh=VkCUlBwbHpvqxpryuAIL9yfb2eN3wHf9AAGorb+LevM=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=n8NUD6SUZ6c33eErZQZ1syfDP25jIB2JFyQAbmnjaQw/5whUbpXtN9CJmTJoLhY+I
	 xNIAioBfc7wmdNobSJrVLnmOEQ32lYnMQaQBCNsBG81IjSk2PUnP8NxfkaDO6zrTjN
	 jl2BEjNidf3E6dfq1rTmzJ8qqGfc9nKQcfoRylWo=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Tycho Andersen <tandersen@netflix.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com
Subject: [PATCH] exec: do not pass invalid pointer to kfree() from free_bprm()
Date: Tue,  5 Nov 2024 14:13:44 +0300
Message-ID: <20241105111344.2532040-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot has reported the following BUG:

kernel BUG at arch/x86/mm/physaddr.c:23!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 2 UID: 0 PID: 5869 Comm: repro Not tainted 6.12.0-rc5-next-20241101-syzkaller #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
RIP: 0010:__phys_addr+0x16a/0x170
Code: 40 a8 7a 8e 4c 89 f6 4c 89 fa e8 b1 4d aa 03 e9 45 ff ff ff e8 a7 1a 52 00 90 0f 0b e8 9f 1a 52 00 90 0f 0b e8 97 1a 52 00 90 <0f> 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90002f7fda0 EFLAGS: 00010293
RAX: ffffffff8143a369 RBX: 000000007ffffff2 RCX: ffff888106df5640
RDX: 0000000000000000 RSI: 000000007ffffff2 RDI: 000000001fffffff
RBP: 1ffff11020df6d09 R08: ffffffff8143a305 R09: 1ffffffff203a1f6
R10: dffffc0000000000 R11: fffffbfff203a1f7 R12: dffffc0000000000
R13: fffffffffffffff2 R14: 000000007ffffff2 R15: ffff88802bc12d58
FS:  00007f01bd1a7600(0000) GS:ffff888062900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff8 CR3: 0000000011f80000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ? __die_body+0x5f/0xb0
 ? die+0x9e/0xc0
 ? do_trap+0x15a/0x3a0
 ? __phys_addr+0x16a/0x170
 ? do_error_trap+0x1dc/0x2c0
 ? __phys_addr+0x16a/0x170
 ? __pfx_do_error_trap+0x10/0x10
 ? handle_invalid_op+0x34/0x40
 ? __phys_addr+0x16a/0x170
 ? exc_invalid_op+0x38/0x50
 ? asm_exc_invalid_op+0x1a/0x20
 ? __phys_addr+0x105/0x170
 ? __phys_addr+0x169/0x170
 ? __phys_addr+0x16a/0x170
 ? free_bprm+0x2b5/0x300
 kfree+0x71/0x420
 ? free_bprm+0x295/0x300
 free_bprm+0x2b5/0x300
 do_execveat_common+0x3ae/0x750
 __x64_sys_execveat+0xc4/0xe0
 do_syscall_64+0xf3/0x230
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f01bd0c36a9
Code: 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 37 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007fff034da398 EFLAGS: 00000246 ORIG_RAX: 0000000000000142
RAX: ffffffffffffffda RBX: 0000000000403e00 RCX: 00007f01bd0c36a9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 0000000000000001 R08: 0000000000001000 R09: 0000000000403e00
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff034da4b8
R13: 00007fff034da4c8 R14: 0000000000401050 R15: 00007f01bd1dca80
 </TASK>

Since 'bprm_add_fixup_comm()' may set 'bprm->argv0' to 'ERR_PTR()',
errno-lookalike invalid pointer should not be passed to 'kfree()'.

Reported-by: syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=03e1af5c332f7e0eb84b
Fixes: 7afad450c998 ("exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/exec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index ef18eb0ea5b4..df70ed8e36fe 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1496,7 +1496,8 @@ static void free_bprm(struct linux_binprm *bprm)
 	if (bprm->interp != bprm->filename)
 		kfree(bprm->interp);
 	kfree(bprm->fdpath);
-	kfree(bprm->argv0);
+	if (!IS_ERR(bprm->argv0))
+		kfree(bprm->argv0);
 	kfree(bprm);
 }
 
-- 
2.47.0


