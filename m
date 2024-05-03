Return-Path: <linux-fsdevel+bounces-18642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7003F8BADE2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 15:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EB21C22AF8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 13:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8888B154421;
	Fri,  3 May 2024 13:40:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA673153BCC
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743636; cv=none; b=lU4PeBZ6PWpTCS25GzNGqJzi7IkCHNPap6yybthGIE5JP9IZB+PYb7JTT1Ve5zXtn7K+Xq/cVJtKjj0X3RKj+dJ4nz0Jg64oX+JgzVxQrbIZ9e4Y/y/VxNfyl43gaRTTjzCZsKFTGK4hojAA78lawJLSWgmvlQ4sFPPcN1mEZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743636; c=relaxed/simple;
	bh=np4KX/dQO/jILjhh5P5s5rwj9Il7+4Lnx3P23KtV/EY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o+sj+osCqrqUagzSyu3iJO8k8dDFWW4QtgkrSPVR7BC3g+g2CIDar9Kv7FWrk2QQ7EuR+lAKqRyqXuB5LiAPEqom7BD4zytHF9MnZIELbX+FRaQ5p7lV1/AzLN+kTc73V0uSKhDwejPrY00hKN3cK2C5Gof/Fdvb1NnG4NmdFo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da41c44e78so969190939f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 06:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714743634; x=1715348434;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hrBI8RJiDyViM5gs3peU14/2k5AZb/mtjpSoFWNKvCQ=;
        b=TJmC2t/c3LsYKpES9gyd8E2sHQN+Hyx9Wa6g/3wcKDFFyk9yvpv7oV89RS0MEaD6ir
         60gdf9bLT8eZeaDLemHF+flrLJ9Rf7y5ujnKiopVo114cHB5IVrt1ULOYQ1q2PXoYAB1
         WWK/X619mDWRWJX+EyzTa/iCs0XPnfDRn1kBdW9lJYfBciYDDxwjtkdVb/ct3WOpPToH
         oBMWKN8h1VEih2LvGNnUPTR/3rz8wFKqIgdR0DIx8zPt2nJTezGTk63y2lzRYyLIPCRV
         tfEeJabQHrUMVv00VUExiVHVrW3nxx9EkI6tpV8kA1YnFpp/Bgq18D5yfEznLr3Bxv6a
         JUvA==
X-Forwarded-Encrypted: i=1; AJvYcCXEFk5o4YbtDHXFNp+x0DNq34paFF4Cjwr7eaJCKoakb3n76KCOllXp5BZnGjVargFb2hjv/9fibXzVmVCdS1DvV8E9WmbGpmWXgYkg2g==
X-Gm-Message-State: AOJu0Yz1ST+S4OkHoz+HjI/x1yiES5mw8eEfU66YqaEB+k4MCU8joO2g
	i+FZfH/HnXvcs7+V3b9mL6ABAkmlYBb8AcubtWDx0Fm924lnDq6JGBvqAD54G5Ilj/UXXCQCFXY
	GxqRRGTYSivW/9HLgrKsSBQCgX8gZ2p40AuKcJQoqBr9Fw+3OimNowjo=
X-Google-Smtp-Source: AGHT+IHLiPRuKvp1YPAZuP8DRx6hN3I7YDbeFST4/QEJYaCw4Jl0HdtdMkRvFt+ffhZTv5NWicEuTFyXspeRO/9/4mcHJcLnJ8vj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188e:b0:36c:5f85:6979 with SMTP id
 o14-20020a056e02188e00b0036c5f856979mr125430ilu.0.1714743633939; Fri, 03 May
 2024 06:40:33 -0700 (PDT)
Date: Fri, 03 May 2024 06:40:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e9eb506178cdd71@google.com>
Subject: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in extAlloc (2)
From: syzbot <syzbot+13e8cd4926977f8337b6@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9221b2819b8a Add linux-next specific files for 20240503
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14631754980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ab537f51a6a0d98
dashboard link: https://syzkaller.appspot.com/bug?extid=13e8cd4926977f8337b6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15123b1f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b7da2f180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e67dbdc3c37/disk-9221b281.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ade618fa19f8/vmlinux-9221b281.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df12e5073c97/bzImage-9221b281.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/41dea5c977c2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+13e8cd4926977f8337b6@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/jfs/jfs_extent.c:319:16
shift exponent 108 is too large for 64-bit type 's64' (aka 'long long')
CPU: 0 PID: 5090 Comm: syz-executor421 Not tainted 6.9.0-rc6-next-20240503-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 extBalloc fs/jfs/jfs_extent.c:319 [inline]
 extAlloc+0xe5c/0x1010 fs/jfs/jfs_extent.c:122
 jfs_get_block+0x41b/0xe60 fs/jfs/inode.c:248
 __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2128
 __block_write_begin fs/buffer.c:2177 [inline]
 block_write_begin+0x9b/0x1e0 fs/buffer.c:2236
 jfs_write_begin+0x31/0x70 fs/jfs/inode.c:299
 generic_perform_write+0x322/0x640 mm/filemap.c:4016
 generic_file_write_iter+0xaf/0x310 mm/filemap.c:4137
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4d15f6f639
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3dae85f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fff3dae87c8 RCX: 00007f4d15f6f639
RDX: 00000000fffffef2 RSI: 0000000020000240 RDI: 0000000000000004
RBP: 00007f4d15fe8610 R08: 0000000000000000 R09: 00007fff3dae87c8
R10: 0000000000006162 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff3dae87b8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
---[ end trace ]---


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

