Return-Path: <linux-fsdevel+bounces-54731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981FAB02676
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 23:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D81564107
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 21:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D6920A5EB;
	Fri, 11 Jul 2025 21:38:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AA618D
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752269920; cv=none; b=inkhEgbNmYOQLH8ubGK7bJ+iMyg95TcKtoQl+hYzEFv6kXC5C6T/WFNHfwmsRfrfXPNwvzfedoah/pOLhl/mzJ27D/KGbAN/6vuFoAo0HhU1Jifo+fxsEOK/Hr9QwlgrVYrBTAMDudF15Na6Q2XRuUU+b0Jwdj41q24eX8oVFq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752269920; c=relaxed/simple;
	bh=NKHKmJP3s1jx/5M71PIclKsgQ6m9AUV+tU9vuUvaTQ0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PPAoCm8HoNhIKLaJEqU6J8fWxSyeH6RVH1bO6o6mI6xNnTZdgjrEYpbEgTSECEVicQXr7np5Qbrvx/S4uexev5Q7oOjE4Mg7an7f5rTZ1xSmfwpHg8nk6WwQCCCLL96C0oHtlZ/y1MBjJADCi+PBKP5gOe2xXkRx15oItemfVhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86cf306fc68so409283039f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 14:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752269917; x=1752874717;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxDs5k3H68METE6KnOVQNHlW/uRvpg1HNaCIpjh2v68=;
        b=WCbTDEKiJT1e110iLSfg/pe7EQJ5STDzt0dqwgjQDtxuO2jsynAr/14LLgf1jYyUzA
         pZpKrGMumV0tXuLtCw9mz5JgDX0UZvT4rFx09twZOMO2Rk/RqtsIFm7QVDK1QT5RUyGs
         ZFt5KRPkVrL0Tvsq60uUyHWHCv0AnI0qnmakGblb2GBd75Cuix6KG+IDFCEOVKa0q2P8
         A/XP4mX410Jls0RGR89eTVMnbi7IlCFZT+g8aeEtkM/djwEx8SrUAl3o+HhKx/DzqTk2
         Saw11uPzy94glXuDx6pk07oBMmTd+lp1vxuFy6PuyNAwmtth9lhFz/oXJLzFNDo/DmeO
         trAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAqIchABV2rPSLWBoifBN6on1n6rZiX/25rC+5dI1c8pHIBCxcqcm/nQIi2+47+3lAGCmDiLrvdCC+s08t@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXqBLUl1FNZ0tRVEyfWqc8oYxS1RbVVGqoDZaeMJ1hnPL0JLN
	1uB/x7GOZ7XgL+szM8yrPQ2f3n0Nhbv2Yk+1QkubFlpm+RiJpmJwosnTSLyVWJziFaJsO1S+KIu
	VgMz/RSZ6mXTqsTfcZ16ll32qHt7gTwfzPYLGnYRMNroPNmPabEYxboFwPg8=
X-Google-Smtp-Source: AGHT+IFmNTOONepWpBl1umrwIDY0tjemvcJh/DcJknpI5vKQVVLsUvQXxgGbeuEfiGN5hvmRy/6gAT0kDfBUo92B4X4XYM6J+C5R
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:240c:b0:3df:3bdc:2e49 with SMTP id
 e9e14a558f8ab-3e253325542mr77423655ab.12.1752269917509; Fri, 11 Jul 2025
 14:38:37 -0700 (PDT)
Date: Fri, 11 Jul 2025 14:38:37 -0700
In-Reply-To: <67f94057.050a0220.2c5fcf.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6871845d.a00a0220.26a83e.005f.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_ext_insert_extent (2)
From: syzbot <syzbot+ad86dcdffd6785f56e03@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    40f92e79b0aa Merge tag 'block-6.16-20250710' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14314d82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd2783a0a99d4ed0
dashboard link: https://syzkaller.appspot.com/bug?extid=ad86dcdffd6785f56e03
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ce7a8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152fc68c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f33b9048bb66/disk-40f92e79.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1194a16e19e9/vmlinux-40f92e79.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bd82e554bd44/bzImage-40f92e79.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ead6dd3b0e30/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17a760f0580000)

The issue was bisected to:

commit 665575cff098b696995ddaddf4646a4099941f5e
Author: Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri Feb 28 20:37:22 2025 +0000

    filemap: move prefaulting out of hot write path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1434a3d4580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1634a3d4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1234a3d4580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad86dcdffd6785f56e03@syzkaller.appspotmail.com
Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")

------------[ cut here ]------------
kernel BUG at fs/ext4/extents.c:2153!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 5856 Comm: syz-executor355 Not tainted 6.16.0-rc5-syzkaller-00193-g40f92e79b0aa #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:ext4_ext_insert_extent+0x4ab7/0x4af0 fs/ext4/extents.c:2153
Code: 89 d9 80 e1 07 fe c1 38 c1 0f 8c a6 e7 ff ff 48 89 df e8 3c 95 b6 ff e9 99 e7 ff ff e8 a2 3d 55 ff 90 0f 0b e8 9a 3d 55 ff 90 <0f> 0b e8 92 3d 55 ff 90 0f 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc9000437ec60 EFLAGS: 00010293
RAX: ffffffff826af7b6 RBX: 000000000000001d RCX: ffff88802dd18000
RDX: 0000000000000000 RSI: 000000000000001d RDI: 000000000000001d
RBP: ffffc9000437ee10 R08: ffff8880738b3ae7 R09: 1ffff1100e71675c
R10: dffffc0000000000 R11: ffffed100e71675d R12: 000000000000001d
R13: dffffc0000000000 R14: ffff8880721f643c R15: ffff888027204700
FS:  00007fa4a23966c0(0000) GS:ffff888125d4f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f42dc5c1000 CR3: 000000003299c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_ext_map_blocks+0x1792/0x6ac0 fs/ext4/extents.c:4404
 ext4_map_create_blocks fs/ext4/inode.c:609 [inline]
 ext4_map_blocks+0x931/0x18d0 fs/ext4/inode.c:813
 _ext4_get_block+0x200/0x4c0 fs/ext4/inode.c:892
 ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:925
 ext4_block_write_begin+0x6f8/0x14b0 fs/ext4/inode.c:1178
 ext4_write_begin+0xa4f/0x1680 fs/ext4/ext4_jbd2.h:-1
 ext4_da_write_begin+0x449/0xd20 fs/ext4/inode.c:3057
 generic_perform_write+0x2c4/0x910 mm/filemap.c:4112
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_dio_write_iter fs/ext4/file.c:613 [inline]
 ext4_file_write_iter+0x182a/0x1bc0 fs/ext4/file.c:721
 do_iter_readv_writev+0x56b/0x7f0 fs/read_write.c:-1
 vfs_writev+0x31a/0x960 fs/read_write.c:1057
 do_pwritev fs/read_write.c:1153 [inline]
 __do_sys_pwritev2 fs/read_write.c:1211 [inline]
 __se_sys_pwritev2+0x179/0x290 fs/read_write.c:1202
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa4a23e16f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa4a2396208 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007fa4a2468648 RCX: 00007fa4a23e16f9
RDX: 0000000000000001 RSI: 00002000000001c0 RDI: 0000000000000007
RBP: 00007fa4a2468640 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000e7b R11: 0000000000000246 R12: 00007fa4a2435620
R13: 0000200000000140 R14: 00002000000001c0 R15: 0000200000000080
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_ext_insert_extent+0x4ab7/0x4af0 fs/ext4/extents.c:2153
Code: 89 d9 80 e1 07 fe c1 38 c1 0f 8c a6 e7 ff ff 48 89 df e8 3c 95 b6 ff e9 99 e7 ff ff e8 a2 3d 55 ff 90 0f 0b e8 9a 3d 55 ff 90 <0f> 0b e8 92 3d 55 ff 90 0f 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc9000437ec60 EFLAGS: 00010293

RAX: ffffffff826af7b6 RBX: 000000000000001d RCX: ffff88802dd18000
RDX: 0000000000000000 RSI: 000000000000001d RDI: 000000000000001d
RBP: ffffc9000437ee10 R08: ffff8880738b3ae7 R09: 1ffff1100e71675c
R10: dffffc0000000000 R11: ffffed100e71675d R12: 000000000000001d
R13: dffffc0000000000 R14: ffff8880721f643c R15: ffff888027204700
FS:  00007fa4a23966c0(0000) GS:ffff888125d4f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff12275000 CR3: 000000003299c000 CR4: 00000000003526f0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

