Return-Path: <linux-fsdevel+bounces-10530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7E284C037
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 23:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658ED1F25561
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 22:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCAA1C697;
	Tue,  6 Feb 2024 22:48:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614281C2A6
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707259709; cv=none; b=afTrY1Lc8zxhgRcwzOxHitG0Y+rps3DrpysTWOA8d90jOP/grztXx1XMZfYAYOY0Ge8bTRcpBVXquISq2Mt3tDou4YXrlNL0uorAsFPVeTJadp3CPW+lBKrU7gcAT8tz7/W3Sl9tZtZAyu1VZsCDkChDeDa1j2t1BGkxANrLL6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707259709; c=relaxed/simple;
	bh=rNAMPe5ysg1hOnVaPKBxZU77ts9sCzWaCLQe4nw99bA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JKpVaWJCPKDiYM70cNBT2Vm3u1fNYQ0Q6wHDk9qrRsnlppAAtokEpbTyST+qmTeRTund1GBXww7G/7JHqD+j7bbD3nzIlQppLzKfQYAhbmzY22YJmKffqeTMp8RW9uSakhV98bypBmmLO/9wCEZSU4D4GihT0t7o+lOXUhlP8p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363d169c770so11985ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 14:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707259706; x=1707864506;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNianPq1xttNpLqtUWxiE4EiNjNbunMQeFA2+po6bog=;
        b=pKVZDlrt93UpfVw80JsD5GgZ5dpR2TVy76PuB4tRcupUSG4lwYmIPbcf+pCGvHAdbv
         43L5vxLUv4zCiynq240OoGinuoq+95wp9R31t3CCgwXE09FCu1RYxxgf5verABYTRQs5
         4AhnSJ3h5j1QrS6pXuDKFJc4WQ7EqLPc2qcqKxPDejYk353xsfrqxv5c6nRBV6Gc4Hrx
         Qj91IbtN7LxCQbAiABcTozXYGZw88vSMKdbuLry6xMzW0urWXexXUJPZdhsbCS5+h0Qm
         Xpr4ir2W5l89uRGvrm2T8Z837SPZQgGgO10g8weroG6vGWAlwGpqF5q49OMiUqXMdxC8
         K+KA==
X-Gm-Message-State: AOJu0YyWCGCzDrzbyffg668eSP4X0Ech3bbC+vI1fFYg+LEjHG8LJJMw
	XXuUubKWJzYHrpDzTqXeGiKA5Ve+2tjA4o4T4IbtMoLpB3m/zxdrdKqPEM8K+o4xfGUzCAihzTg
	MBbs3zIA/owkiS0nEjeN93k4WixhUxzwVGL1KP6nU/OtPtFUasQG4SKM=
X-Google-Smtp-Source: AGHT+IFBTkPlwzwOJF60XP0Q/6bjSMVhyJDlBF7lFjj1qGtaNlPKSjev/w6n6NgzKwaqTp+7Zuc/2l7Cc84czaEM85KqcHuf4dM8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1805:b0:363:c3d9:c10 with SMTP id
 a5-20020a056e02180500b00363c3d90c10mr278284ilv.0.1707259706614; Tue, 06 Feb
 2024 14:48:26 -0800 (PST)
Date: Tue, 06 Feb 2024 14:48:26 -0800
In-Reply-To: <000000000000ac258b061062ad8d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a2bbb0610be608e@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data_end (2)
From: syzbot <syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    99bd3cb0d12e Merge tag 'bcachefs-2024-02-05' of https://ev..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b32118180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89a5d896b14c4565
dashboard link: https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cffe18180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e0d68fe80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/73aa72bd3577/disk-99bd3cb0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c6bf1614995/vmlinux-99bd3cb0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7df252d11788/bzImage-99bd3cb0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/584587b5a4f4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:235!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5172 Comm: syz-executor299 Not tainted 6.8.0-rc3-syzkaller-00005-g99bd3cb0d12e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:ext4_write_inline_data fs/ext4/inline.c:235 [inline]
RIP: 0010:ext4_write_inline_data_end+0xea1/0x1020 fs/ext4/inline.c:773
Code: 31 ff e8 92 d9 44 ff 48 89 d8 48 25 ff 0f 00 00 74 70 e8 a2 d4 44 ff e9 12 f8 ff ff e8 98 d4 44 ff 90 0f 0b e8 90 d4 44 ff 90 <0f> 0b 48 8b 5c 24 18 48 89 df be 08 00 00 00 e8 bb a4 a3 ff 48 c1
RSP: 0018:ffffc90004957300 EFLAGS: 00010293
RAX: ffffffff824e91a0 RBX: 0000000000000042 RCX: ffff888029e48000
RDX: 0000000000000000 RSI: 0000000000000042 RDI: 0000000000000043
RBP: ffffc90004957428 R08: ffffffff824e86f9 R09: 1ffff11005ffe070
R10: dffffc0000000000 R11: ffffed1005ffe071 R12: ffff888067134e6a
R13: 0000000000000042 R14: 0000000000000043 R15: 0000000000000001
FS:  00007f92340b76c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9234096d58 CR3: 000000007218c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 generic_perform_write+0x424/0x640 mm/filemap.c:3941
 ext4_buffered_write_iter+0xc6/0x350 fs/ext4/file.c:299
 ext4_file_write_iter+0x1dc/0x19c0
 call_write_iter include/linux/fs.h:2085 [inline]
 iter_file_splice_write+0xbd6/0x14e0 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11e/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x58d/0xc80 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x28c/0x3e0 fs/splice.c:1233
 do_sendfile+0x56d/0xdc0 fs/read_write.c:1295
 __do_sys_sendfile64 fs/read_write.c:1362 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f9234102a39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 1b 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f92340b7218 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f9234183708 RCX: 00007f9234102a39
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007f9234183700 R08: 0000000000000000 R09: 0000000000000000
R10: 000080001d00c0d0 R11: 0000000000000246 R12: 00007f923414f6e0
R13: 00007f923414f180 R14: 0031656c69662f2e R15: 8088e3ad122bc192
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_write_inline_data fs/ext4/inline.c:235 [inline]
RIP: 0010:ext4_write_inline_data_end+0xea1/0x1020 fs/ext4/inline.c:773
Code: 31 ff e8 92 d9 44 ff 48 89 d8 48 25 ff 0f 00 00 74 70 e8 a2 d4 44 ff e9 12 f8 ff ff e8 98 d4 44 ff 90 0f 0b e8 90 d4 44 ff 90 <0f> 0b 48 8b 5c 24 18 48 89 df be 08 00 00 00 e8 bb a4 a3 ff 48 c1
RSP: 0018:ffffc90004957300 EFLAGS: 00010293
RAX: ffffffff824e91a0 RBX: 0000000000000042 RCX: ffff888029e48000
RDX: 0000000000000000 RSI: 0000000000000042 RDI: 0000000000000043
RBP: ffffc90004957428 R08: ffffffff824e86f9 R09: 1ffff11005ffe070
R10: dffffc0000000000 R11: ffffed1005ffe071 R12: ffff888067134e6a
R13: 0000000000000042 R14: 0000000000000043 R15: 0000000000000001
FS:  00007f92340b76c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f92340b8000 CR3: 000000007218c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

