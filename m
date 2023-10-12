Return-Path: <linux-fsdevel+bounces-150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3947C62B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 04:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6EAC282731
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 02:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442CF7FC;
	Thu, 12 Oct 2023 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D420F7E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 02:25:52 +0000 (UTC)
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64596B8
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 19:25:50 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3aec0675519so678307b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 19:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697077549; x=1697682349;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FonEK2Cc8Fum2v2IQrVQ7j+RtZpE/wmPQ+M4vkmMyAo=;
        b=hlsJ4lJURxR4L8n1MKGBDgvNjPw28Xm1+v7hK9y/onPD1Ywbf1KvWxOlUaVH7rvCUB
         nNw7TceYm8NwUZpU6lzrSkCVPMZ/MxFyNK1kHsQCOhgrGb9hb+Gg6CMSPkwnlKjVMKYO
         GtURk+B4SIZ+vvv+9tonYR/h4oLoN4EW8xhjHQHgY5Y9iXNidGNee9ijiZMhuiz3opmg
         S33i8q90jEarsEuYfwcJL0rd21mZBucV/a5H6tzXJicET+Dkur7rPhPyEDUK9sDVofra
         oYPHtSLI6xobLgv4grgVYoQ3EqouwViDdYeiWrPFW7oI4jhcoe6sedqmN42DoWrEYMFs
         Y7cg==
X-Gm-Message-State: AOJu0YxCwW/QlP65dTIVRBWtCDS5/icPvfoM1D5GpaXycmM1n5/vkHdA
	3qOugJJMDM52dI9kAlKNxkPCNBxDGhHiVjG0IbXwLxTGI1+0
X-Google-Smtp-Source: AGHT+IHmbATJqeEQ+PXig62KlRk11d8zQ7z1uRoC6eIktHGCvx53R5rBGRl5RdfD24eXQfQcgfYUF7Zh8Vzvseweo/cWHzo2eY1m
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1786:b0:3a7:3737:60fd with SMTP id
 bg6-20020a056808178600b003a7373760fdmr12087647oib.7.1697077549557; Wed, 11
 Oct 2023 19:25:49 -0700 (PDT)
Date: Wed, 11 Oct 2023 19:25:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f6b6e06077ba8fa@google.com>
Subject: [syzbot] [ext4?] KASAN: wild-memory-access Read in read_block_bitmap
From: syzbot <syzbot+47f3372b693d7f62b8ae@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    19af4a4ed414 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=137ade41680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80eedef55cd21fa4
dashboard link: https://syzkaller.appspot.com/bug?extid=47f3372b693d7f62b8ae
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1035f9ce680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132439c9680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/702d996331e0/disk-19af4a4e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a48ce0aeb32/vmlinux-19af4a4e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/332eb4a803d2/Image-19af4a4e.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9ab1853e4248/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47f3372b693d7f62b8ae@syzkaller.appspotmail.com

EXT2-fs (loop0): error: ext2_free_branches: Read failure, inode=16, block=1669132791
EXT2-fs (loop0): error: ext2_free_branches: Read failure, inode=16, block=262144
==================================================================
BUG: KASAN: wild-memory-access in generic_test_bit include/asm-generic/bitops/generic-non-atomic.h:128 [inline]
BUG: KASAN: wild-memory-access in test_bit_le include/asm-generic/bitops/le.h:21 [inline]
BUG: KASAN: wild-memory-access in ext2_valid_block_bitmap fs/ext2/balloc.c:86 [inline]
BUG: KASAN: wild-memory-access in read_block_bitmap+0x338/0x628 fs/ext2/balloc.c:153
Read of size 8 at addr 1fff00018751cff8 by task syz-executor221/6316

CPU: 1 PID: 6316 Comm: syz-executor221 Not tainted 6.6.0-rc4-syzkaller-g19af4a4ed414 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_report+0xe4/0x514 mm/kasan/report.c:478
 kasan_report+0xd8/0x138 mm/kasan/report.c:588
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 generic_test_bit include/asm-generic/bitops/generic-non-atomic.h:128 [inline]
 test_bit_le include/asm-generic/bitops/le.h:21 [inline]
 ext2_valid_block_bitmap fs/ext2/balloc.c:86 [inline]
 read_block_bitmap+0x338/0x628 fs/ext2/balloc.c:153
 ext2_free_blocks+0x284/0x998 fs/ext2/balloc.c:514
 ext2_free_data fs/ext2/inode.c:1102 [inline]
 ext2_free_branches+0x2f4/0x3c4 fs/ext2/inode.c:1159
 ext2_free_branches+0x180/0x3c4 fs/ext2/inode.c:1150
 ext2_free_branches+0x180/0x3c4 fs/ext2/inode.c:1150
 __ext2_truncate_blocks+0x9a8/0xd00 fs/ext2/inode.c:1233
 ext2_setsize fs/ext2/inode.c:1291 [inline]
 ext2_setattr+0x774/0xa44 fs/ext2/inode.c:1661
 notify_change+0x9d4/0xc8c fs/attr.c:499
 do_truncate+0x1c0/0x28c fs/open.c:66
 handle_truncate fs/namei.c:3298 [inline]
 do_open fs/namei.c:3643 [inline]
 path_openat+0x2130/0x27f8 fs/namei.c:3796
 do_filp_open+0x1bc/0x3cc fs/namei.c:3823
 do_sys_openat2+0x124/0x1b8 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1448
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
==================================================================
EXT2-fs (loop0): error: ext2_valid_block_bitmap: Invalid block bitmap - block_group = 0, block = 0
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks in system zones - Block = 3, count = 3
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 983269, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 589827, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 2185560079, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 18346, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks in system zones - Block = 2, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 33261, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: bit already cleared for block 100
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1669132791, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1669132791, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: bit already cleared for block 64
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 65536, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 268435456, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1803188595, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1701604449, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 2054779762, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1819042155, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 7565925, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1937768448, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1634433657, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1919249516, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1803188595, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1701604449, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 2054779762, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1819042155, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 2037609061, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1818323834, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 3133565699, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 327680, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 150994944, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 2683928664, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 2683928664, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 2683928664, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1669132791, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 2683928664, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 3925999616, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 3409668, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: bit already cleared for block 40
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1635017060, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1936876908, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1634433657, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1919249516, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1803188595, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1701604449, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 2054779762, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1819042155, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 2037609061, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1818323834, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1936876908, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: bit already cleared for block 9
EXT2-fs (loop0): error: ext2_free_blocks: bit already cleared for block 13
EXT2-fs (loop0): error: ext2_free_blocks: bit already cleared for block 32
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 163928, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 2683895808, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 1669132790, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks not in datazone - block = 131072, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks in system zones - Block = 5, count = 1
EXT2-fs (loop0): error: ext2_free_blocks: Freeing blocks in system zones - Block = 5, count = 1
EXT2-fs (loop0): error: ext2_free_branches: Read failure, inode=16, block=16777216


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

