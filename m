Return-Path: <linux-fsdevel+bounces-38291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 852AE9FED3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 07:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D7A1882E25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 06:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0136D17995E;
	Tue, 31 Dec 2024 06:22:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168051442F3
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735626152; cv=none; b=kUiMVcul1r4t3gLMdjTO8MAGaiX+dDz3GNh0UJMLv8D+yp9xh2YDUgb2j7TX20AmEQOqFJ5ju+AF0t/EZHf55IaD5fWovdfr0k+8u9pbklJXHtbPmvSLpBJuUtlVYqLhqJ99WvIhLChwCIRaRwsZK19/cPDWziOZy3LdnrdoVZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735626152; c=relaxed/simple;
	bh=U/hfupTXj3C9N+6c4EYruTcmH4G/ZRwdrHdQTUKjl6I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ceqcc85hSI8ijysBGVW+jAW/SiCvvLVRGVovsWPTmGIwG6+xteJIS7MRB9OTNcTyQmBAzh64iknMCCQjMnhHZt2ugLruFtccD7SbSCYCECJ4030Tf8pkEHO9EqDknwC+PBrWyEFXsdQ6OdQ3nvce/Sn95RN2HsXIS/LgSXTotl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-844d5c7d664so814874939f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 22:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735626150; x=1736230950;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pRZQnfCKlwvTlQKnYCeJ2VQUNTYPFqhMMtOjTHUK/nk=;
        b=OoxgOz2O4hSV/98tZMPJ23IPDFRFPbhX0f9UHIsWRXdDAh8HAbUWB2o6z19s6UdXR4
         VNrAtIoEvVns1KVSZ/iJaI77gaWgvuxEnB9VeR3QjyAaBn+GnD0ofEvLY+InlROzKLHg
         a5XywbxB83kmJHK3WTRjGECEqPNioauPA1hzwJJ7sqd6Jt1Dkbcz+Ejw+NkD6kAG8OLF
         hJ1462fmkAzdNBiqQ6Zc4QnUh+SpkdweyCHsJJJOCwW+46lXsyMkwopfNova4wnQ8pKr
         ndUToo87fIZ5k3HugfpPaX3MNGaBlElowPytWI0U9pkx4PtA8/dShH+jiWZOb1Zyrfkk
         KTyw==
X-Forwarded-Encrypted: i=1; AJvYcCVK48usxJJZLjkRFpmHZS0IGvPZqTj9wtBKUqOKRHSzrzGzJ0RFHKww8D2MtxwdT9Ie892ydtjQL8exMxX2@vger.kernel.org
X-Gm-Message-State: AOJu0YwhMKf7nSgtuYSjYbRNoGSNq/WwHhADJghbwJK3hAzzQ2CAFcoU
	e7QseVgmJJV1EriTlfN+vwpjzzSIC61nHch4w3Em0majtMhJsM5Z4j1rCSCkneaw/VfoEi3pdXL
	ia+r2MHejPJt7i2Ob50nJGjYWfCz8NOZqCmBeHFV7472jpIQ3E1JLuvw=
X-Google-Smtp-Source: AGHT+IGRWFcW83BQyK+3heZ5/umcgQmy76aNkPtvqsW2TpUY1L51HSixC214yQS1peCzUxYEtNXTdX8JavYLwU0ueAvXX8QAJ44N
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2d:b0:3a0:c820:c5f0 with SMTP id
 e9e14a558f8ab-3c2d5b27450mr277231715ab.24.1735626150232; Mon, 30 Dec 2024
 22:22:30 -0800 (PST)
Date: Mon, 30 Dec 2024 22:22:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67738da6.050a0220.2f3838.04d8.GAE@google.com>
Subject: [syzbot] [squashfs?] WARNING in do_open_execat (3)
From: syzbot <syzbot+a6bec34b1270dec555f4@syzkaller.appspotmail.com>
To: brauner@kernel.org, ebiederm@xmission.com, jack@suse.cz, kees@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, phillip@squashfs.org.uk, 
	squashfs-devel@lists.sourceforge.net, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d6ef8b40d075 Merge tag 'sound-6.13-rc5' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1460c2c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d269ef41b9262400
dashboard link: https://syzkaller.appspot.com/bug?extid=a6bec34b1270dec555f4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152792f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12053adf980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-d6ef8b40.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/38a9784dd46d/vmlinux-d6ef8b40.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8d1728b3051d/bzImage-d6ef8b40.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7dec22cf3b31/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6bec34b1270dec555f4@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5309 at fs/exec.c:911 do_open_execat+0x376/0x480 fs/exec.c:911
Modules linked in:
CPU: 0 UID: 0 PID: 5309 Comm: syz-executor209 Not tainted 6.13.0-rc4-syzkaller-00054-gd6ef8b40d075 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:do_open_execat+0x376/0x480 fs/exec.c:911
Code: 74 3e 49 81 ff 01 f0 ff ff 73 35 e8 74 af 86 ff 4c 89 ff e8 cc 89 fe ff eb 2b e8 65 af 86 ff e9 05 fe ff ff e8 5b af 86 ff 90 <0f> 0b 90 eb c7 e8 50 af 86 ff 48 c7 c3 e6 ff ff ff 4d 85 ff 75 c2
RSP: 0018:ffffc9000d007d00 EFLAGS: 00010293
RAX: ffffffff8218c4d5 RBX: 000000000000e000 RCX: ffff88801cfba440
RDX: 0000000000000000 RSI: 000000000000e000 RDI: 0000000000008000
RBP: ffffc9000d007dc8 R08: ffffffff8218c336 R09: 0000000000000000
R10: ffffc9000d007b60 R11: fffff52001a00f6e R12: ffffc9000d007d40
R13: 1ffff92001a00fa4 R14: ffff8880475a4578 R15: ffff88803fa8e000
FS:  0000555571145380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff7c8c00000 CR3: 0000000043846000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 alloc_bprm+0x28/0xa30 fs/exec.c:1505
 do_execveat_common+0x18c/0x6f0 fs/exec.c:1900
 do_execveat fs/exec.c:2034 [inline]
 __do_sys_execveat fs/exec.c:2108 [inline]
 __se_sys_execveat fs/exec.c:2102 [inline]
 __x64_sys_execveat+0xc4/0xe0 fs/exec.c:2102
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff7d11e1639
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff49e02ef8 EFLAGS: 00000246 ORIG_RAX: 0000000000000142
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007ff7d11e1639
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 00000000ffffff9c
RBP: 00007ff7d1254610 R08: 0000000000001000 R09: 00007fff49e030c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff49e030b8 R14: 0000000000000001 R15: 0000000000000001
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

