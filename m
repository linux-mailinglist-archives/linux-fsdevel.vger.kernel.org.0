Return-Path: <linux-fsdevel+bounces-26367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE8E958915
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54196282BF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 14:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB9E4D8C6;
	Tue, 20 Aug 2024 14:21:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E6F29D19
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163691; cv=none; b=ozZ09MjaGBxQ6wLg1HJjfzFu9k65T4NYaYKUdHSABnABbG+6+ukT+bSQgPl9FTcjgxxoIhP8E3/E+deXq4v5SBLK6sKI3TLYoeZ63V+Z3JYzOY+unEyQDiyIoQnsMKaGYdTBNEXffZGvR7YR1bKJWr0Xqy1KkgFdE68K5p9tWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163691; c=relaxed/simple;
	bh=nz87iCNm/imYxmww6lrSQkmDcLF8hRPjqOR5QfSw3ZU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mTMd4EKcOO2f5EOGoKei4dYzigdIGQJ4mDR5N89iSc9dsyu+zj8mkYZ3wMl7yqDeYgRixQkTsVXUbFItQZ2EAsuZ3EnhJ0rdED8D3mT4rCFyM3wf3rTtsns1yZeRk32k56h8DrxGTutbn9qW8lZn0h+aDgkoXCtWlckg3BauMBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f87635cc1so536696939f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 07:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724163689; x=1724768489;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gs4I+WnWS003nZVnMuAmREt59BcST7kRnGotym9SD1w=;
        b=p5Y3zfeEYs7eP8dACHlOXoWb2N8dwkOPrJIcdmyZC0r00Xb5qihcjx65S5Ka6/3CGz
         JfHYNh+0FbCjCvisa8iPx5X6aDvrX6tLSktmXndkP3KWgLxEm0dKsLDS7IpArDCqYP0b
         UNELEenv80RozhjNRGdWuYQImllwyC6uOlP5KqUJ33Ex8SZB8v5KK5S1KnYJiHsQRSAb
         ksDN93QLo7u6sjd4t/p98pienwjPHocF/NuKwgFQvqonnUCV4Rtvx49q3xWJndRbH9ju
         a8r93r5KAv/rhrS7kZQsxwbHKWYjRna12nTV7jIJNoHUSAVGz1tDUCT2jenxoWf3wtCM
         6PIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfiEDSJKx/+T0I+1p5AQKyr9pdfYBHYQhiLkW97QvuAon0nmC33xRRm9ySSYJXqm0JMpJjE9XiE/I4biEZ@vger.kernel.org
X-Gm-Message-State: AOJu0YypmobnUFqMK9+hVW/oLUCwsZdi73sKzWCUA4gUQUrCojUqQlKQ
	CKtfl1MOZyZTelfqm4lYxf+IkHV6n6wxTmFSVENHNUMcZgjyjXuhc0/AT5YnYcXUkJ6Rlt1eMBC
	OQt49HSMANHF1etk0HldB9OIjbbGBa2yNb9KRI6sv5L/+I16MkUTB87M=
X-Google-Smtp-Source: AGHT+IFrQvOpoNZRpN+O2+toWf++oN6LJ1BTTXXJVdRcqhkogTFlxrGc9PligSCCsq+tnEYjJgAo9S6KB+i0kLccArQV2ALqlNzC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3410:b0:7f6:1e9c:d6f4 with SMTP id
 ca18e2360f4ac-824f271e077mr42411639f.3.1724163689422; Tue, 20 Aug 2024
 07:21:29 -0700 (PDT)
Date: Tue, 20 Aug 2024 07:21:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e2f1306201e24d7@google.com>
Subject: [syzbot] [ntfs3?] WARNING in iov_iter_revert (5)
From: syzbot <syzbot+1e5f71cac2c1db825478@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7a5aa4b3c00 Merge tag 'perf-tools-fixes-for-v6.11-2024-08..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ed77c9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92c0312151c4e32e
dashboard link: https://syzkaller.appspot.com/bug?extid=1e5f71cac2c1db825478
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1380adf3980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e4d5f3980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/64022429061b/disk-d7a5aa4b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f4aba88f7db8/vmlinux-d7a5aa4b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/120456a2d9dc/bzImage-d7a5aa4b.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/8df834fb9381/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/af3cad97858b/mount_4.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e5f71cac2c1db825478@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5875 at lib/iov_iter.c:552 iov_iter_revert+0x34d/0x390 lib/iov_iter.c:552
Modules linked in:
CPU: 0 UID: 0 PID: 5875 Comm: syz-executor332 Not tainted 6.11.0-rc3-syzkaller-00156-gd7a5aa4b3c00 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:iov_iter_revert+0x34d/0x390 lib/iov_iter.c:552
Code: 48 89 df 48 89 cd e8 f2 ee 50 fd 48 89 e9 48 89 0b 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 34 cd ec fc 90 <0f> 0b 90 eb e2 e8 29 cd ec fc eb db 44 89 e9 80 e1 07 38 c1 0f 8c
RSP: 0018:ffffc90004d0fbe0 EFLAGS: 00010293
RAX: ffffffff84a6bd2c RBX: ffffffffffffe00a RCX: ffff888023519e00
RDX: 0000000000000000 RSI: ffffffffffffe00a RDI: 000000007ffff000
RBP: 0000000000002000 R08: ffffffff84a6ba1d R09: 1ffffffff1fed4e5
R10: dffffc0000000000 R11: fffffbfff1fed4e6 R12: 1ffff920009a1fb1
R13: ffffc90004d0fd70 R14: ffffc90004d0fd70 R15: 0000000000000000
FS:  00007f1d02fd56c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000000a CR3: 0000000064990000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 generic_file_read_iter+0x2d0/0x430 mm/filemap.c:2789
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9bd/0xbc0 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1d0302c829
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1d02fd5218 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f1d030cf728 RCX: 00007f1d0302c829
RDX: 0000000000002000 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 00007f1d030cf720 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1d0309aaac
R13: 00007f1d03099fe0 R14: 0031656c69662f2e R15: 0030656c69662f2e
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

