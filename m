Return-Path: <linux-fsdevel+bounces-38868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C650AA092E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 15:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E0E3A5B0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 14:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FAD20FAA7;
	Fri, 10 Jan 2025 14:05:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF77E20E02E
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517926; cv=none; b=Dx2cuzmLvEgqrJhCcrWO7NXQmmiwD9FqV44qWIFCQnG7myH1sK3q18Yb2mhq1Zl7aIEB1M79jyKxiudgeS3r8NO86s+tPU3gPj2HPJ6SbwBmQs6vCAQHhDH3R/Ly/DumdXciyKW2DxJlJKxmXBCWarRc5bc16MPrXq4BD5iBbIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517926; c=relaxed/simple;
	bh=35uKEVoLo8Zcb7jRTmWXgAqu3hbnQbNPmardpx1VNsk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KErAcZ6Vjt9Vcms5CfpENwFh3N9g3Q2wCbDbZ4yV9vg2zX/yWMV51kRXUWm7c5Vr2OHyNWJ/2qVUl0wybY+yPYgXtsTQ2cGP5KausbQd5paf1qsLBy65voAqpbZTzoDvA7JJy0Y4Uc+YXs2dga4x51jdkWoED5GZvc6yjs9eBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ac98b49e4dso17706315ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 06:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736517924; x=1737122724;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zi5lO6DHbzD+BwtBlYrxdzWaRO+blLe2xqlFyuo+9vA=;
        b=Tyqme/I4e4raXQUuH4AL1yHAFjVCt27lFtEUnQwUIRn16dIrwPdGJcNGqQjuml4K3d
         guZ23DbUEQL8dCLiMxQNlQgcS9dTNyVGHsqF/Hzzl2CyrtLE9WksTH/1t/ypj80u3fUn
         vOE9qOyU8fNkO6yZa8xhrmT0Tx98m/vVvCM0UqtauVs5SjQR0LO4NnPfTHaM3+TTv8Kw
         okfJVmCJIBqO/AthnE9klu3TrV6T375m6iJ/JKdl6ea9I0Ea1I2J/Jb+3LcFoxAQE8AW
         hI2l761FWLcWJ06MYST5zMNL2Ok+dr6m1CsqglLje/lu4gqHC9cnCefT+ZZQkSIffTMq
         +2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhSp1tG1R+zcuy+DoFqU92YS3dxXrng9zSJvwHxnGSwT58G1ZXUcExa4HR5utX2agNVvNuBaEM4UXpN3Mh@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+bLI32hdjSLNdNJRw12FkLKBNFzMatgTozUfQC8KEAQLQksp
	d/5YFFTE/l4RGVSibvmL3yOkzyZnsY3UzSRfaRGT74yZD7/yZEnN/MmVl5YEIWsEmfqOCglT3dx
	SDjkeZGlS/gsItiYOs0Ps0VTebxNmlGdMTBef32Ey8rOhSsrgE9eAFxA=
X-Google-Smtp-Source: AGHT+IFwqiwYO7/WPcU3DzKLx1EhgEN5I6qD5ncqDMwfw3b3fbLpeNR1Gs/bG1PN7McaQfThLeyBdyQ+NeX5nPo8hC7EydDk/V8/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190e:b0:3ce:5af3:79d5 with SMTP id
 e9e14a558f8ab-3ce5af44b62mr12963245ab.6.1736517923773; Fri, 10 Jan 2025
 06:05:23 -0800 (PST)
Date: Fri, 10 Jan 2025 06:05:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67812923.050a0220.216c54.0012.GAE@google.com>
Subject: [syzbot] [exfat?] KASAN: slab-use-after-free Read in __brelse
From: syzbot <syzbot+b9f95bc199a2ced7ecf4@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4099a71718b0 Merge tag 'sched-urgent-2024-12-29' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16886818580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d269ef41b9262400
dashboard link: https://syzkaller.appspot.com/bug?extid=b9f95bc199a2ced7ecf4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-4099a717.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/03bc60aa75c1/vmlinux-4099a717.xz
kernel image: https://storage.googleapis.com/syzbot-assets/266d70b8e1cb/bzImage-4099a717.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b9f95bc199a2ced7ecf4@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 256
=======================================================
WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
exfat: Deprecated parameter 'namecase'
exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0x1cbb3694, utbl_chksum : 0xe619d30d)
exFAT-fs (loop0): error, in sector 160, dentry 5 should be unused, but 0xc1
syz.0.0: attempt to access beyond end of device
loop0: rw=2049, sector=225, nr_sectors = 1 limit=0
Buffer I/O error on dev loop0, logical block 225, lost async page write
syz.0.0: attempt to access beyond end of device
loop0: rw=2049, sector=226, nr_sectors = 1 limit=0
Buffer I/O error on dev loop0, logical block 226, lost async page write
syz.0.0: attempt to access beyond end of device
loop0: rw=2049, sector=227, nr_sectors = 1 limit=0
Buffer I/O error on dev loop0, logical block 227, lost async page write
syz.0.0: attempt to access beyond end of device
loop0: rw=2049, sector=228, nr_sectors = 1 limit=0
Buffer I/O error on dev loop0, logical block 228, lost async page write
syz.0.0: attempt to access beyond end of device
loop0: rw=2049, sector=229, nr_sectors = 1 limit=0
Buffer I/O error on dev loop0, logical block 229, lost async page write
syz.0.0: attempt to access beyond end of device
loop0: rw=2049, sector=230, nr_sectors = 1 limit=0
Buffer I/O error on dev loop0, logical block 230, lost async page write
syz.0.0: attempt to access beyond end of device
loop0: rw=2049, sector=231, nr_sectors = 1 limit=0
Buffer I/O error on dev loop0, logical block 231, lost async page write
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in __brelse+0x1f/0xa0 fs/buffer.c:1225
Read of size 4 at addr ffff888043ee6148 by task syz.0.0/5315

CPU: 0 UID: 0 PID: 5315 Comm: syz.0.0 Not tainted 6.13.0-rc4-syzkaller-00110-g4099a71718b0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 __brelse+0x1f/0xa0 fs/buffer.c:1225
 brelse include/linux/buffer_head.h:324 [inline]
 exfat_put_dentry_set+0x182/0x2b0 fs/exfat/dir.c:553
 exfat_add_entry+0x6ff/0xaa0 fs/exfat/namei.c:505
 exfat_mkdir+0x1c7/0x580 fs/exfat/namei.c:858
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4311
 do_mkdirat+0x264/0x3a0 fs/namei.c:4334
 __do_sys_mkdirat fs/namei.c:4349 [inline]
 __se_sys_mkdirat fs/namei.c:4347 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4347
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fabf4785d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fabf55f0038 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007fabf4975fa0 RCX: 00007fabf4785d29
RDX: 0000000000000000 RSI: 0000000020000080 RDI: ffffffffffffff9c
RBP: 00007fabf4801b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fabf4975fa0 R15: 00007ffd77baaa48
 </TASK>

Allocated by task 5315:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4175
 alloc_buffer_head+0x2a/0x290 fs/buffer.c:3015
 folio_alloc_buffers+0x31f/0x640 fs/buffer.c:924
 grow_dev_folio fs/buffer.c:1064 [inline]
 grow_buffers fs/buffer.c:1105 [inline]
 __getblk_slow fs/buffer.c:1131 [inline]
 bdev_getblk+0x2af/0x670 fs/buffer.c:1431
 __breadahead+0x2b/0x240 fs/buffer.c:1440
 sb_breadahead include/linux/buffer_head.h:358 [inline]
 exfat_dir_readahead fs/exfat/dir.c:647 [inline]
 exfat_get_dentry+0x464/0x730 fs/exfat/dir.c:670
 exfat_create_upcase_table+0x242/0xf60 fs/exfat/nls.c:758
 __exfat_fill_super fs/exfat/super.c:628 [inline]
 exfat_fill_super+0x1196/0x2920 fs/exfat/super.c:678
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5317:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kmem_cache_free+0x195/0x410 mm/slub.c:4715
 free_buffer_head+0x54/0x240 fs/buffer.c:3031
 try_to_free_buffers+0x2fa/0x3b0 fs/buffer.c:2972
 mapping_evict_folio+0x242/0x300 mm/truncate.c:258
 mapping_try_invalidate+0x24a/0x550 mm/truncate.c:482
 loop_set_status+0x1ab/0x8f0 drivers/block/loop.c:1263
 lo_ioctl+0xcbc/0x1f50
 blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888043ee60e8
 which belongs to the cache buffer_head of size 168
The buggy address is located 96 bytes inside of
 freed 168-byte region [ffff888043ee60e8, ffff888043ee6190)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x43ee6
memcg:ffff888033d8ad01
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801c2e6dc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000110011 00000001f5000000 ffff888033d8ad01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Reclaimable, gfp_mask 0x52810(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_RECLAIMABLE), pid 5315, tgid 5314 (syz.0.0), ts 69151654138, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2269
 alloc_slab_page+0x6a/0x110 mm/slub.c:2423
 allocate_slab+0x5a/0x2b0 mm/slub.c:2589
 new_slab mm/slub.c:2642 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3830
 __slab_alloc+0x58/0xa0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 kmem_cache_alloc_noprof+0x268/0x380 mm/slub.c:4175
 alloc_buffer_head+0x2a/0x290 fs/buffer.c:3015
 folio_alloc_buffers+0x31f/0x640 fs/buffer.c:924
 grow_dev_folio fs/buffer.c:1064 [inline]
 grow_buffers fs/buffer.c:1105 [inline]
 __getblk_slow fs/buffer.c:1131 [inline]
 bdev_getblk+0x2af/0x670 fs/buffer.c:1431
 __breadahead+0x2b/0x240 fs/buffer.c:1440
 sb_breadahead include/linux/buffer_head.h:358 [inline]
 exfat_dir_readahead fs/exfat/dir.c:647 [inline]
 exfat_get_dentry+0x464/0x730 fs/exfat/dir.c:670
 exfat_create_upcase_table+0x242/0xf60 fs/exfat/nls.c:758
 __exfat_fill_super fs/exfat/super.c:628 [inline]
 exfat_fill_super+0x1196/0x2920 fs/exfat/super.c:678
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888043ee6000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888043ee6080: fb fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb
>ffff888043ee6100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff888043ee6180: fb fb fc fc fc fc fc fc fc fc fa fb fb fb fb fb
 ffff888043ee6200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

