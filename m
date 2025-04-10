Return-Path: <linux-fsdevel+bounces-46226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BADC9A84CB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 21:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9F91882C8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 19:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1AF28F935;
	Thu, 10 Apr 2025 19:15:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCDE204699
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312534; cv=none; b=aAApc9iIAet5V2ycYJmjlsPgUj6P5H++yjGtRqKR7I7NelB705FDBEaNVnvHsSqZOK9A+60Q7FqmYJl5+rQDs8Ikv0ZbCAw/XOqMOK+NhK+XSV1DHG//wEPUGMXQz1Vr4PNCGbZytVRh/3Kw6sa2yIzSUVDCKSO2p9R3PEyhFL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312534; c=relaxed/simple;
	bh=74aBZ4a4VNWHvVTFPsKTue0UzsC2AKEi7fwRQlSMJqI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LhWrLr4AItkaXa0X69o+ZusfRFVVUPI57yBvjtyetk/IxC22tmETtGEYx9OarTdX1n167nIPxA2Kbnve9yomMM2g929+FQLEntTwfxi1si3akIHtZH0PesWS2mHJoH7XaSjx2OplBzpKaxt5liHLzUNtzFwjRev0NM8foiG0y0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d43b460970so24223455ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 12:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744312532; x=1744917332;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H3W/HXh4at+evJCFCR9VU7dl/bIzh/ksaAyPG3mgaJQ=;
        b=rveNy2LlewiTrLC7wT9FKyEyyhIEwLaeWCxBFbv7BcIzRkfWkkA83H9+KIt8Pk147L
         Cqa0V9qWmjRAjlTmF18RwbrIeahlALRIm8poWKpW5GH9L/mIypJuaMvmbVT6M7Vptsok
         PPMVqsHMxQVM5/S7Jg7u4QICjKRfPUuSDxKPdx2/COxLhsk955F+9A12xCF9hfKXzc6r
         +IoNBgIMM+Yara2lOanbyY5QmprWVo4ruif6Gt1qYg1ZouSlqrXa/tXKerFD/fpbj8jg
         liDt2efnAd/4fGIogs7HJZH52cogd1ZZuEbsr4i2po/rE4vCe1Rh5pfyrskOTQfkXf/O
         24Dw==
X-Forwarded-Encrypted: i=1; AJvYcCX+lLWZHIVbdprCt4X4kVll8jWWsDuKToubB04kLXxezspv0F4iXI/3tgTQ5jT7ka+sV+vBZ5Y+AFDXHmpW@vger.kernel.org
X-Gm-Message-State: AOJu0YyBprLtCr7ZeYyM0PGN+9ZtfJKun/LcshPCl9TAdBGxn8zl6TxK
	/tMx68plSbhkk5UGRUeFZYejzRcRy/JHtUUfEFHPI6U4OKkocvArWIPAXeM08yQ83+OZqYlFjjw
	HhK9l076RsIJMIIatVsIHIbMsMmH78NOAPGakwfVvG0Y22687MfwLatQ=
X-Google-Smtp-Source: AGHT+IFirUMHr5M57+X2TQvOLvce76l5z8wP3l4mZu2gp6knq0i0FJMFLwIYkwCdy/OTW9jEau/QkG5Iwp+585UrV3ta522OKJqx
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2603:b0:3d3:d067:73f8 with SMTP id
 e9e14a558f8ab-3d7ec227bacmr505285ab.11.1744312531778; Thu, 10 Apr 2025
 12:15:31 -0700 (PDT)
Date: Thu, 10 Apr 2025 12:15:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f818d3.050a0220.355867.000d.GAE@google.com>
Subject: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in generic_file_read_iter
From: syzbot <syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0af2f6be1b42 Linux 6.15-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145dc7e4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bae073f4634b7fd
dashboard link: https://syzkaller.appspot.com/bug?extid=e36cc3297bd3afd25e19
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1441eb4c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161b0c04580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f359042635eb/disk-0af2f6be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bd095707eff2/vmlinux-0af2f6be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9257d0cc2f0f/bzImage-0af2f6be.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/93de6f4d2865/mount_0.gz

The issue was bisected to:

commit b432163ebd15a0fb74051949cb61456d6c55ccbd
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Thu Jan 30 14:03:41 2025 +0000

    fs/ntfs3: Update inode->i_mapping->a_ops on compression state

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1351523f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10d1523f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1751523f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com
Fixes: b432163ebd15 ("fs/ntfs3: Update inode->i_mapping->a_ops on compression state")

loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Different NTFS sector size (4096) and media sector size (512).
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 0 P4D 0 
Oops: Oops: 0010 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 5858 Comm: syz-executor328 Not tainted 6.15.0-rc1-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90003f1f880 EFLAGS: 00010246
RAX: 1ffffffff18fac93 RBX: 0000000000000000 RCX: ffff8880312cda00
RDX: 0000000000000000 RSI: ffffc90003f1f980 RDI: ffffc90003f1f9d0
RBP: ffffffff8c7d6498 R08: ffffffff82450731 R09: 1ffff1100ee119e1
R10: dffffc0000000000 R11: 0000000000000000 R12: 1ffff920007e3f33
R13: ffffc90003f1f980 R14: dffffc0000000000 R15: ffffc90003f1f9d0
FS:  00007efd457ef6c0(0000) GS:ffff888124fc9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000034abc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 generic_file_read_iter+0x343/0x550 mm/filemap.c:2870
 copy_splice_read+0x63f/0xb50 fs/splice.c:363
 do_splice_read fs/splice.c:978 [inline]
 splice_direct_to_actor+0x4f0/0xc90 fs/splice.c:1083
 do_splice_direct_actor fs/splice.c:1201 [inline]
 do_splice_direct+0x281/0x3d0 fs/splice.c:1227
 do_sendfile+0x582/0x8c0 fs/read_write.c:1368
 __do_sys_sendfile64 fs/read_write.c:1429 [inline]
 __se_sys_sendfile64+0x17e/0x1e0 fs/read_write.c:1415
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efd4583d069
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efd457ef168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007efd458e3708 RCX: 00007efd4583d069
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007efd458e3700 R08: 00007efd457ef6c0 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 00007efd458e370c
R13: 000000000000000b R14: 00007ffdcf3e22c0 R15: 00007ffdcf3e23a8
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90003f1f880 EFLAGS: 00010246
RAX: 1ffffffff18fac93 RBX: 0000000000000000 RCX: ffff8880312cda00
RDX: 0000000000000000 RSI: ffffc90003f1f980 RDI: ffffc90003f1f9d0
RBP: ffffffff8c7d6498 R08: ffffffff82450731 R09: 1ffff1100ee119e1
R10: dffffc0000000000 R11: 0000000000000000 R12: 1ffff920007e3f33
R13: ffffc90003f1f980 R14: dffffc0000000000 R15: ffffc90003f1f9d0
FS:  00007efd457ef6c0(0000) GS:ffff888124fc9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000034abc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

