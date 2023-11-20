Return-Path: <linux-fsdevel+bounces-3191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498A87F0D23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 09:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB641C210D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 08:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E247DDD0;
	Mon, 20 Nov 2023 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD09C5
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 00:05:23 -0800 (PST)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1cf5d3203fdso8197735ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 00:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700467523; x=1701072323;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFFgTieMhzmpzC7zBMFZD5JT3T1t57L3DBASoDQrHkU=;
        b=qQKhu4NVGqxNpQS1tEtFsIDpx/mvHDGeoPcNoys/X8xj1IumoN7WI56Q5SKAqHrwY7
         eoF7KdPmUT3IuIAuxc4o6eNk/SBYi2sUmuT3uNbYkV1rIqBFWLo4+Xwr82JXQxzGvwRg
         vKfKhmCvN/8LCaZYawm+Dx3ugDth0v4ZPQMbvL7q7fdvtixxXa3NGg1IvuodfHbn7507
         muOtFumPSaaRCKMrFETrs+gMP/sqzsIQS6rTs4NvbYbzeozagddZ80Hzf8Z1P9ZEhw4p
         Ky1vcTEFQmz+r/ziFDInlfV/nrwTn66wBig9ChOTOTM1Lh+p5pz2kNg5Fb0y6fD4OWiq
         s7lw==
X-Gm-Message-State: AOJu0YweMa19LQ7KW6Z1itXkbMmWcGCJK0r+Gbxc3iXAu/szQ85S7sgn
	s2gq3Ena4LPU+tkCH+SKyX3rXl3ctdYco2kpjqNBa/hL+w9n
X-Google-Smtp-Source: AGHT+IGirTJ0JjBDHQiqHuy3NgK5Ew2xOfMaek3wJqfnN0aPD81r0i9kd/HnPDFnWeXVKVOQrpon4LK8ARMLLDfHbKx/d30hi7Mf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:11c3:b0:1cf:6467:b2ed with SMTP id
 q3-20020a17090311c300b001cf6467b2edmr231475plh.12.1700467522985; Mon, 20 Nov
 2023 00:05:22 -0800 (PST)
Date: Mon, 20 Nov 2023 00:05:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8e4a3060a90f205@google.com>
Subject: [syzbot] [btrfs?] memory leak in __btrfs_add_free_space
From: syzbot <syzbot+349f1f9eb382f477ce50@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c42d9eeef8e5 Merge tag 'hardening-v6.7-rc2' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d5cc04e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e71d284dd6560ca8
dashboard link: https://syzkaller.appspot.com/bug?extid=349f1f9eb382f477ce50
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112a3b0f680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/026cc0fc446f/disk-c42d9eee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c4b4d6d092c1/vmlinux-c42d9eee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1865f885e9d6/bzImage-c42d9eee.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/513e1afbe9d7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+349f1f9eb382f477ce50@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888123c87618 (size 104):
  comm "syz-executor.6", pid 10287, jiffies 4294957667 (age 18.250s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81630c48>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81630c48>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81630c48>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81630c48>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81630c48>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81630c48>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff8212c5a9>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff8212c5a9>] __btrfs_add_free_space+0x69/0x780 fs/btrfs/free-space-cache.c:2636
    [<ffffffff8212ce5a>] do_trimming+0x19a/0x2d0 fs/btrfs/free-space-cache.c:3687
    [<ffffffff8212d334>] trim_no_bitmap+0x3a4/0x650 fs/btrfs/free-space-cache.c:3797
    [<ffffffff8212fc9c>] btrfs_trim_block_group+0xbc/0x1a0 fs/btrfs/free-space-cache.c:4037
    [<ffffffff8208cbd2>] btrfs_trim_fs+0x1c2/0x6b0 fs/btrfs/extent-tree.c:6297
    [<ffffffff82108c53>] btrfs_ioctl_fitrim+0x1d3/0x270 fs/btrfs/ioctl.c:535
    [<ffffffff82112fd0>] btrfs_ioctl+0x2200/0x33e0 fs/btrfs/ioctl.c:4573
    [<ffffffff816be4d2>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff816be4d2>] __do_sys_ioctl fs/ioctl.c:871 [inline]
    [<ffffffff816be4d2>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816be4d2>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:857
    [<ffffffff84b6ad8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6ad8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b



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

