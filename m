Return-Path: <linux-fsdevel+bounces-41426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19186A2F56D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CBA97A1AAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1672C255E2F;
	Mon, 10 Feb 2025 17:37:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEAB4690
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209047; cv=none; b=gVSdfYuQ7Y3hVRu4rfDmE2bBeOl4pE3x5rjt+Ny1oi7DNR/5U+AJD1AgjNgeX7TjkV7q9TNkXN4lsK6Q+2WPy6y+bYsVyKVQMJhMmC6nGzAVHAXnrw/yaiUHYWTvrCkv47O1f7zeI0TQqdHFWR6FJgGUGJBkDtNLXQDKGDBfUIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209047; c=relaxed/simple;
	bh=EZToKP83bY++M1VJibKB1vrHZqLfrQaDGx2+eX1tpZc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=a5U98Wqth+ZwCgQMscsEVZWuTTD4ZSvEaDaXNfJ7bY+bM8SChjd/e1g3pNfTfJzkK1gOr5sZo68ZuD943CH1PeI/r6T9uporpzoBnXLy4TgcaDNLVHIv9OLbRLH0encYWnWPE3Ii+dmSXgw3wXQXoEP8eIcT4MPYhyTbME2krT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-8552ddb83e3so188801839f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 09:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209045; x=1739813845;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrFPlL95YK8qLTiydeaVc1oNNjyzOtj3yWZSUg2CbXQ=;
        b=fRUN7Rq0GpWA4n2OSAlQt54ynCoV7L1HQdZTaLJTIB34uiEGsPcHfoJut8t2X6DVnA
         Swa2OhFYsM5b7m/YkqQvglt637E05FHutZg1BImqDM0JtXWApQEtovwAJzJSQvx4+YR0
         ap4Mz+RBjuQ2VyxUkn2UW5NaHs4o341GASEBOUCVFwS6TbMYDsiQuORazRn6e8MlYptv
         noAxiv7mHtTR6sWFFrhm3bONn1FjLTKPm6MHmlYpkJWJbNDRk+kkqs5qg0RH7DZAuYy2
         CKEGbOdgdFYi3hx5da0iKuQHtR1A7oo1grH/LPtL9drnAzcy5JoF6hNaDDmslPKgxWpn
         YvNg==
X-Forwarded-Encrypted: i=1; AJvYcCU71fvSnRnugpQe20wy1iRsfKTtIqK3UVxNI0ss0GU7okTPizwfPq34i4HV+pYjTjZZZd8fj/u9xx+EAKR4@vger.kernel.org
X-Gm-Message-State: AOJu0YwcZPzmzpVsdcApgYhCylkJxtnFS3IQyTTTAwxgjxYOpxUprFJ1
	ZzVDa/iOVsu7AVqjbb8CuXGyzwCKtbml7Q2km7XPWlanfVdwKkYbkL+7AT1clSWdoX+W6gm5klm
	udPbiQLwqfd5aIgfAjZ4mLF2JCYbziFzlyrhDVuerA58tdATTRdxqdrA=
X-Google-Smtp-Source: AGHT+IHgVJnIvh3tKPHNfBf22Xct4NEZ2Kc5lS8+vDl4WNTnxXmjbrpdMY3AWNV+GTK4gdtsQvOksW4r7SZU/XO3pcmchh9dRZ2b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d91:b0:3cf:b365:dcf8 with SMTP id
 e9e14a558f8ab-3d13df546a1mr145443075ab.21.1739209045206; Mon, 10 Feb 2025
 09:37:25 -0800 (PST)
Date: Mon, 10 Feb 2025 09:37:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67aa3955.050a0220.110943.0031.GAE@google.com>
Subject: [syzbot] [fs?] WARNING: refcount bug in io_submit_one
From: syzbot <syzbot+fbb8bdfedfaab15a3895@syzkaller.appspotmail.com>
To: bcrl@kvack.org, brauner@kernel.org, jack@suse.cz, linux-aio@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69b54314c975 Merge tag 'kbuild-fixes-v6.14' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1508bb18580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7ddf49cf33ba213
dashboard link: https://syzkaller.appspot.com/bug?extid=fbb8bdfedfaab15a3895
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168cd1b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134698e4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-69b54314.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d0a58d1d655/vmlinux-69b54314.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b99949b40299/bzImage-69b54314.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbb8bdfedfaab15a3895@syzkaller.appspotmail.com

netfs: Couldn't get user pages (rc=-14)
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 3 PID: 6084 at lib/refcount.c:28 refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 3 UID: 0 PID: 6084 Comm: syz-executor338 Not tainted 6.14.0-rc1-syzkaller-00276-g69b54314c975 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 78 71 f5 fc 84 db 0f 85 66 ff ff ff e8 cb 76 f5 fc c6 05 e5 68 86 0b 01 90 48 c7 c7 00 fb d2 8b e8 97 b2 b5 fc 90 <0f> 0b 90 90 e9 43 ff ff ff e8 a8 76 f5 fc 0f b6 1d c0 68 86 0b 31
RSP: 0018:ffffc9000435fc68 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817a1159
RDX: ffff888030b44880 RSI: ffffffff817a1166 RDI: 0000000000000001
RBP: ffff888031bf8488 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88802cd8f700 R14: ffff888031bf83c0 R15: ffff888031bf8478
FS:  00005555830ae380(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f51c9f3f000 CR3: 0000000028d22000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:275 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 refcount_dec_and_test include/linux/refcount.h:325 [inline]
 iocb_put fs/aio.c:1208 [inline]
 io_submit_one+0x103f/0x1da0 fs/aio.c:2055
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit fs/aio.c:2081 [inline]
 __x64_sys_io_submit+0x1b2/0x340 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f51c9f80ee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfc54a368 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00004000000004c0 RCX: 00007f51c9f80ee9
RDX: 00004000000002c0 RSI: 0000000000000001 RDI: 00007f51c9f3f000
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdfc54a380
R13: 00007ffdfc54a3a0 R14: 000000000000bf9c R15: 00007ffdfc54a37c
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

