Return-Path: <linux-fsdevel+bounces-62272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AADDB8BAD9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 02:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9513AD281
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 00:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C75D1A294;
	Sat, 20 Sep 2025 00:13:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE027464
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Sep 2025 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758327217; cv=none; b=HXr8cpBceTn6a+y4SF8eonqLCXWjrQHZB0cVghnscp7uqBIfkR/p0K8yagevgS8CI+nDeFkwTIlsK0rEKYv3DH/0YhwN2vXOukA95KPTe4vmMKVyQW5vJPqyAz//yJA/9ARHdQazvczDzUMLzX1m98jX/BZgcCvHvtjKomrJU+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758327217; c=relaxed/simple;
	bh=9oer6FIxhSftD1QvS4tyhBH63lOL8najkhKV35ZC9Ag=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Fulc3DxWjgIEftcfrgP3iPkW2wFMZQZAbFIX5JHdxsTtTIv8ZVige3WQgn4o+I/ThARwo6KQr2Wm7L7tB1sRRFD6PYGCkWIs3zwTmvsuFYNDQhSo5aMuH1as6URB1eRCkPQx5tt5yNrGJeZ+XnsGaqWrTSbtfqc3qfZI7lhzgZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-423fb9b0ceaso35693285ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 17:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758327214; x=1758932014;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0KSXfD8WagrlJub7GjFFRPCZmKQD/bTAa2q7egn9kCU=;
        b=FqUO6C/NdF3psvopRLulJwjmVogCxp2AH9711qXXXpW5wc/elo/s9ADbF9uGAwFvG/
         zOLc+KZ7w9mn0XPSs8Nc3qX7y44S6x8wrhedB+NAdYLwUUxahNwKTI3LIc2oDLRkv+Ku
         urd6+pN21MZVlj/jtoAbHkceEa50Xqur+Pw2Ol8elR4pcQKLwR3hdvvB0qgBK/docv3K
         whxg3prbAodLUPz45FOVsd7cfhWQ4IyKaGqY1adHg61nnB5cwLF5Rsi3kYG8+NIcj7dn
         F5vZtXbtftSTHIevYoOdNPFy8WJZNkxu89FeBTMMqftj6cbMT7zQNQMIrCqVytQUO7pd
         u0yA==
X-Forwarded-Encrypted: i=1; AJvYcCVoWwgcXeVjZQAaZWxsh4cWwdlRuPlDkcg+JM5vpMa2z/02+CCvhYCVmzuAoTc099YukGFsh+TWavBBQVVh@vger.kernel.org
X-Gm-Message-State: AOJu0YxGsvdjiq0/SabNg03AZy8rhCudsHNXEPTuhlPmsDc2N08zDMcs
	lh2iHOeoYs2K8g+ufpxtyh3dybu0/nr+9d2PZ5v6qF+IClymCaOI2khfawnXWdQFe58nDnAEyaI
	UBNHrOJg+6tfxdEhFqSG+/kCNjNrih3rIWWtlo3JR/dVGVSZFkdnFIoOylag=
X-Google-Smtp-Source: AGHT+IEONtvsqEyT9Cy/dVpWDrwJVGJAQsAH+BirtcW0EGh8mtcHkqDGk5tj5hD9ivfUGYWOKYcwm3AYaVL/wJPdVXWCWTyCEkqY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3782:b0:412:c994:db15 with SMTP id
 e9e14a558f8ab-42481947474mr87183285ab.14.1758327214465; Fri, 19 Sep 2025
 17:13:34 -0700 (PDT)
Date: Fri, 19 Sep 2025 17:13:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cdf1ae.a00a0220.37dadf.0021.GAE@google.com>
Subject: [syzbot] [nfs?] WARNING in nsfs_fh_to_dentry
From: syzbot <syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com>
To: amir73il@gmail.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    846bd2225ec3 Add linux-next specific files for 20250919
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=144b8d04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=9eefe09bedd093f156c2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1724be42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fc2712580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c53d48022f8a/disk-846bd222.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/483534e784c8/vmlinux-846bd222.xz
kernel image: https://storage.googleapis.com/syzbot-assets/721b36eec9b3/bzImage-846bd222.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: fs/nsfs.c:493 at nsfs_fh_to_dentry+0xcc5/0xdc0 fs/nsfs.c:493, CPU#1: syz.0.17/6050
Modules linked in:
CPU: 1 UID: 0 PID: 6050 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:nsfs_fh_to_dentry+0xcc5/0xdc0 fs/nsfs.c:493
Code: 7c 24 60 e9 10 f8 ff ff e8 48 01 79 ff 90 0f 0b 90 e9 09 f6 ff ff e8 3a 01 79 ff 90 0f 0b 90 e9 81 f6 ff ff e8 2c 01 79 ff 90 <0f> 0b 90 e9 d0 f6 ff ff e8 1e 01 79 ff 45 31 ff e9 d9 f7 ff ff e8
RSP: 0018:ffffc90002f97a20 EFLAGS: 00010293
RAX: ffffffff824717f4 RBX: 00000000effffffd RCX: ffff888031990000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000effffffd
RBP: ffffc90002f97b10 R08: ffffffff8fe4db77 R09: 1ffffffff1fc9b6e
R10: dffffc0000000000 R11: fffffbfff1fc9b6f R12: 1ffff920005f2f4c
R13: ffff888028d74894 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000555569cd2500(0000) GS:ffff8881258a2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32363fff CR3: 0000000028a1e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 exportfs_decode_fh_raw+0x178/0x6e0 fs/exportfs/expfs.c:456
 do_handle_to_path+0xa4/0x1a0 fs/fhandle.c:276
 handle_to_path fs/fhandle.c:400 [inline]
 do_handle_open+0x6b4/0x8f0 fs/fhandle.c:415
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1a5d78ec29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff390c9e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 00007f1a5d9d5fa0 RCX: 00007f1a5d78ec29
RDX: 0000000000400040 RSI: 0000200000000000 RDI: 0000000000000003
RBP: 00007f1a5d811e41 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1a5d9d5fa0 R14: 00007f1a5d9d5fa0 R15: 0000000000000003
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

