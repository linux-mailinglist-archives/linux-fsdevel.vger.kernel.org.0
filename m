Return-Path: <linux-fsdevel+bounces-63852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B60BCBCFF82
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 07:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683573B491C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 05:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB28202F70;
	Sun, 12 Oct 2025 05:45:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF143AD5A
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 05:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760247929; cv=none; b=MmqUpn0qfgif82gY4yUYVp8zqZliStcssgq0t1TOGVLMWOYMPxYMKl4EkFJXdEMANqScRVOT0xOza9VqtfPlrpE274XbF4R2P5Gv5HnvHa4+7Ku3PPz8cwa4zb+194NDGv+IdDQyKivCFPenxQnXUikHXjfGvV9fAWM31I/uztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760247929; c=relaxed/simple;
	bh=gp8LenUMte1A4A/tTEeRWcbl106OnJf3sIEYqLdI6J8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H+RRdSCy+gwQnWIiku04cK8dSWON7ruLe4YtsdXyY6w4HL3KoHBMedbz1rMF+7gf+cJ6v6qPFYoeOzaVezwQVBXOak+x2+w6xBc0chJRNMr6PA86mXMZgD/gk/0yqpAitH5RF5+/y5veXP/umRRNDdUnc7dVl6XAkR9UEqPY9Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-90f6e3cd204so1011713139f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Oct 2025 22:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760247927; x=1760852727;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kK2CnYH5zvuo9IgsxeF65PkGa9yTkiuirnHBLni/oBs=;
        b=sJUQjKO+MPQze+ftLqLwqG8zIM/RTdLI15nRkqRfZLjUjUWLE6V0EIiKWSyU1zJs4x
         /aYPwpnDVWHWudanFG1fG2CO3ILNHxatsDbymJkvskvFQ4oww5DXdC1tbDLM6Ch662DE
         tDPbkHFDG4tVjAWG2AhSSMHZVA/XTXpJCUDOCm1snpS8Zfq2iNYCvJ1+bczxlTskJWTb
         63Tqj6qc/8rF2BzfqNI38zEqB2tk7Hxtr60+Gp1/0OR8aMmWgisLbU5Rz5NyqWpF6Bo2
         c1ynkAsxeFq/NomFnp75yaqf/JRy2C1UK6JFzCAHYxSYYGKo7MkO6k9FP2QYRlfbZeCA
         UT2g==
X-Forwarded-Encrypted: i=1; AJvYcCWNPggwRWZGhpOK8QcdxvPZGG2uWWrpgBI5JXk7cp3ygn1EeuoysJ2rTV6LrkKCU65wR3fy15K9Kz1Zs0BJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwCriCKNEgph/E+i+VSKA7YL+6enUcqUiPv73dr9LOHolLUcnLS
	j03GxR+Fvlt8xI0yvSKSn5blroJ8aF8SgvQ9DAnmD5+TRoCIr66tV0ZwWxAxr9qRh62CrsmjwO8
	VjzAS1cHpy96FXh5Y0bjFanjFI1nM/PkGo6fkb8Tv8Dc07O6QJUdjak1Zym8=
X-Google-Smtp-Source: AGHT+IEKoTp+fIzhtzRDnRW+0jiB2FzyIi8xjphMzU40sggh8385cHq25Snsx5B7p8S9tdKrEiBHZICoMUvL3sY5tb8KG2gPQNV6
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b03:b0:93b:ba4a:3b67 with SMTP id
 ca18e2360f4ac-93bd199182emr2167690739f.18.1760247927182; Sat, 11 Oct 2025
 22:45:27 -0700 (PDT)
Date: Sat, 11 Oct 2025 22:45:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68eb4077.050a0220.ac43.0005.GAE@google.com>
Subject: [syzbot] [gfs2?] WARNING in chown_common
From: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>
To: brauner@kernel.org, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    98906f9d850e Merge tag 'rtc-6.18' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e10c58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2d7b4143707d3a0
dashboard link: https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ab9b34580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e10c58580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-98906f9d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d82186923244/vmlinux-98906f9d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a23e980d2d8e/bzImage-98906f9d.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/b2d6dc77aff3/mount_2.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=13e03892580000)
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/96cd0ec46a20/mount_8.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com

DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff888036665058, owner = 0x0, curr 0xffff88803e332480, list empty
WARNING: CPU: 0 PID: 5699 at kernel/locking/rwsem.c:1381 __up_write kernel/locking/rwsem.c:1380 [inline]
WARNING: CPU: 0 PID: 5699 at kernel/locking/rwsem.c:1381 up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Modules linked in:
CPU: 0 UID: 0 PID: 5699 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__up_write kernel/locking/rwsem.c:1380 [inline]
RIP: 0010:up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Code: d0 48 c7 c7 20 ff 6a 8b 48 c7 c6 40 01 6b 8b 48 8b 14 24 4c 89 f1 4d 89 e0 4c 8b 4c 24 08 41 52 e8 b3 36 e6 ff 48 83 c4 08 90 <0f> 0b 90 90 e9 6d fd ff ff 48 c7 c1 94 61 9e 8f 80 e1 07 80 c1 03
RSP: 0018:ffffc9000d4b7c30 EFLAGS: 00010296
RAX: e0ff97a6af656400 RBX: ffff888036665058 RCX: ffff88803e332480
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa650 R12: 0000000000000000
R13: ffff8880366650b0 R14: ffff888036665058 R15: 1ffff11006ccca0c
FS:  00007f2b1bd9b6c0(0000) GS:ffff88808d301000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f63d120f000 CR3: 000000004fe06000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:990 [inline]
 chown_common+0x418/0x5c0 fs/open.c:793
 do_fchownat+0x161/0x270 fs/open.c:822
 __do_sys_lchown fs/open.c:847 [inline]
 __se_sys_lchown fs/open.c:845 [inline]
 __x64_sys_lchown+0x85/0xa0 fs/open.c:845
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2b1c78eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2b1bd9b038 EFLAGS: 00000246 ORIG_RAX: 000000000000005e
RAX: ffffffffffffffda RBX: 00007f2b1c9e6360 RCX: 00007f2b1c78eec9
RDX: 000000000000ee01 RSI: 0000000000000000 RDI: 00002000000006c0
RBP: 00007f2b1c811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2b1c9e63f8 R14: 00007f2b1c9e6360 R15: 00007ffe60c7e2c8
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

