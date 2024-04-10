Return-Path: <linux-fsdevel+bounces-16522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB69589E8E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 06:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5FB1C22ED8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 04:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B519468;
	Wed, 10 Apr 2024 04:31:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C9AA32
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 04:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723481; cv=none; b=bvFuNvwkQDFIeJ/MGAr5jx7K+LNk9KqVpMCAud1n5pyHr+jXwzXFvX5XRmaiLujqfJN18g5dvSfCRym3uEZotLFt2gOn8AaHwQGWRcT1WRPmwstqs4JeEgXDbON+XQB0ca9sfY4s0JWitST7Trtue6l6HReEfvy+mKYie1WqlVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723481; c=relaxed/simple;
	bh=XiTWu7OM6cQSjaR7mqjqF6mQNFpmdn30ObaklWFSHls=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y3E9WXbG94DB+lDzA+m9M7K6Tj+93rwRy+SyfcsLby89kzBJgWNPZICVYWWRsYnlg5tJ//arpVGupQYPm0eXrcrXX1bElOPFnhk5mhctv13MpsyIPaf+N45e8fXET/z+pGqv5kB20vz4T4ecjQZDPTEIFH9Ore59UPsjvo2za5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5e031e805so343961139f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 21:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712723479; x=1713328279;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Br1CErGe7qhIZ1oIK3iyp4poNkKAzNpGP+NpHq47RPw=;
        b=ek9pV+bfGEnP84a4/ljKmgrhBn74qnfueNSmlaSEca3YzQ8EvrfmtxJh0oRP1Q4EB+
         XFNB3wwGYxALqtBrCyH4KryRwgbeT0SH83XkYJnX9vgJatbHWsPsKZBRDsQ+EBKxdxOw
         hJuPkpjgipepRka73Sa8PLssoQTmUsQbAPi+C1Sv15yoQj1B1UKzjruWvMjl6guD3sBh
         oVSEM6JoFXcYuuwKUtDVaK7cb/wBL/t/8lyDQPdAJug340MOyIt1LbsNcVwSIXi1Ow1R
         ih8QBJNQR2tPnUpaJY9BLHjCcTevAu/SExQpS/vyiKxST68nsK7V2l50h/AIndDfXslp
         wDdg==
X-Forwarded-Encrypted: i=1; AJvYcCWouIw99/PvV3mnBPXB8zRwc4x6FfCa2tGNjgXRGCeu/3ISUvdVeS+PJbnL4ym9hz1hRBREgUYodMriOckIsYq6BWSchey1/VTu4mWjGg==
X-Gm-Message-State: AOJu0YxFKI5khP09FMny2S+/5vMyNn5Rw7AzH6skifIyLXSkpeve0gX2
	n/aDAATrqPawkvsoyiGBM6JesI7xpdWo6FzLQ6AJH/vqbwT1bwsJouIyP9oyGJFrM4rXxhb8fny
	SrIZ5/5BPSxHTi+rdWFPtxXV8/5bTE2Sq7UG/jrjEz4m8WxWBdlzIGqA=
X-Google-Smtp-Source: AGHT+IEtnHGgUZanktUjrkLE2KopYplvVF+a02iqPtZxQ6VlR7e0QWn5IDzae7bqnMpT2230PwT4KLGKILEsECkwrkIip2kDELWu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1543:b0:7d6:1c79:fe4c with SMTP id
 h3-20020a056602154300b007d61c79fe4cmr54006iow.0.1712723479205; Tue, 09 Apr
 2024 21:31:19 -0700 (PDT)
Date: Tue, 09 Apr 2024 21:31:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093a8ec0615b682a9@google.com>
Subject: [syzbot] [jffs2?] KASAN: slab-out-of-bounds Read in jffs2_sum_add_kvec
From: syzbot <syzbot+d7c218ea1def103f6bcd@syzkaller.appspotmail.com>
To: dwmw2@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1100ac99180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=d7c218ea1def103f6bcd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149f31f6180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f2c5a1180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7c218ea1def103f6bcd@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in jffs2_sum_add_kvec+0x99c/0x11e4 fs/jffs2/summary.c:261
Read of size 4 at addr ffff0000d8ccacbc by task jffs2_gcd_mtd0/6173

CPU: 1 PID: 6173 Comm: jffs2_gcd_mtd0 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x178/0x518 mm/kasan/report.c:488
 kasan_report+0xd8/0x138 mm/kasan/report.c:601
 __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
 jffs2_sum_add_kvec+0x99c/0x11e4 fs/jffs2/summary.c:261
 jffs2_flash_direct_writev+0xa8/0xe8 fs/jffs2/writev.c:22
 jffs2_flash_writev+0x13c/0x11ac fs/jffs2/wbuf.c:805
 jffs2_write_dnode+0x3cc/0xb80 fs/jffs2/write.c:109
 jffs2_garbage_collect_metadata fs/jffs2/gc.c:834 [inline]
 jffs2_garbage_collect_live+0x1098/0x3640 fs/jffs2/gc.c:529
 jffs2_garbage_collect_pass+0x1470/0x1a50 fs/jffs2/gc.c:464
 jffs2_garbage_collect_thread+0x414/0x48c fs/jffs2/background.c:155
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Allocated by task 6162:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:575
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3981 [inline]
 __kmalloc+0x2bc/0x5d4 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 jffs2_do_mount_fs+0x120/0x1d00 fs/jffs2/build.c:387
 jffs2_do_fill_super+0x480/0x9f8 fs/jffs2/fs.c:573
 jffs2_fill_super+0x248/0x280 fs/jffs2/super.c:289
 mtd_get_sb+0x174/0x398 drivers/mtd/mtdsuper.c:57
 mtd_get_sb_by_nr+0x94/0xb0 drivers/mtd/mtdsuper.c:88
 get_tree_mtd+0x4e4/0x680 drivers/mtd/mtdsuper.c:141
 jffs2_get_tree+0x28/0x38 fs/jffs2/super.c:294
 vfs_get_tree+0x90/0x288 fs/super.c:1779
 do_new_mount+0x278/0x900 fs/namespace.c:3352
 path_mount+0x590/0xe04 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3875
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

The buggy address belongs to the object at ffff0000d8cca000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 956 bytes to the right of
 allocated 2304-byte region [ffff0000d8cca000, ffff0000d8cca900)

The buggy address belongs to the physical page:
page:00000000c4bc55ea refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x118cc8
head:00000000c4bc55ea order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x5ffc00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000840 ffff0000c0002140 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000d8ccab80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000d8ccac00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff0000d8ccac80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                        ^
 ffff0000d8ccad00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000d8ccad80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
jffs2: Write of 68 bytes at 0x0002d034 failed. returned -22, retlen 0
jffs2: Not marking the space at 0x0002d034 as dirty because the flash driver returned retlen zero
jffs2: error: (6173) __jffs2_dbg_acct_sanity_check_nolock: eeep, space accounting for block at 0x00000000 is screwed.
jffs2: error: (6173) __jffs2_dbg_acct_sanity_check_nolock: free 0x000000 + dirty 0x000000 + used 0x000000 + wasted 0x000000 + unchecked 0x000000 != total 0x001000.
------------[ cut here ]------------
kernel BUG at fs/jffs2/debug.c:38!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 6173 Comm: jffs2_gcd_mtd0 Tainted: G    B              6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __jffs2_dbg_acct_sanity_check_nolock+0x57c/0x76c fs/jffs2/debug.c:35
lr : __jffs2_dbg_acct_sanity_check_nolock+0x57c/0x76c fs/jffs2/debug.c:35
sp : ffff800097947440
x29: ffff8000979474b0 x28: ffff0000d8ccaccc x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: ffff0000d8f68180
x23: 0000000000000000 x22: 0000000000000000 x21: ffff0000d8ccacc4
x20: dfff800000000000 x19: 000000000000181d x18: 1fffe00036804396
x17: 0000000000000000 x16: ffff80008aca6b80 x15: 0000000000000001
x14: 1ffff00012f28da8 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000002 x10: 0000000000ff0100 x9 : a157a05fb2900e00
x8 : a157a05fb2900e00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800097946d58 x4 : ffff80008ed822c0 x3 : ffff80008036f0d8
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 00000000000000a3
Call trace:
 __jffs2_dbg_acct_sanity_check_nolock+0x57c/0x76c fs/jffs2/debug.c:35
 __jffs2_dbg_acct_sanity_check+0x38/0x54 fs/jffs2/debug.c:56
 jffs2_write_dnode+0x4ec/0xb80 fs/jffs2/write.c:137
 jffs2_garbage_collect_metadata fs/jffs2/gc.c:834 [inline]
 jffs2_garbage_collect_live+0x1098/0x3640 fs/jffs2/gc.c:529
 jffs2_garbage_collect_pass+0x1470/0x1a50 fs/jffs2/gc.c:464
 jffs2_garbage_collect_thread+0x414/0x48c fs/jffs2/background.c:155
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Code: 2a1703e6 2a1603e7 b90003e8 959b3174 (d4210000) 
---[ end trace 0000000000000000 ]---


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

