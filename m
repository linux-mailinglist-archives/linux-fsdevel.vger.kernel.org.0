Return-Path: <linux-fsdevel+bounces-11836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB0285797F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 10:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C131F24ECB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 09:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D457F1C288;
	Fri, 16 Feb 2024 09:54:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765D81BF27
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077273; cv=none; b=K7hIc0TRtLV+fZDpgfxNRPCQeWAJ6coYw6aHAT6rCiadHjmSaRcv48Sxz2bV/CROos6TEuTdv73c0SRDhhWkiJIi7LCA5lsVOqGuskNjYpOKmj1QfLFGE/Rltf6TUC1HKzPOuodzfiehOpRLljnAj5C4kgeXX2mmVHXsrstnHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077273; c=relaxed/simple;
	bh=cypQJfZF+YtN5CAouGhTasr02apRL8MggF+4hYI1Tg4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MZtncR7s9jGqrTg/8WZKkCl5qevIgfZwGyaWcsn9U/hYY140GjR+/IGwFPHYQQVo8AFq5+YM7YpCuEQdsv6N5VUcnjRge4Zpf1QSYA5RgMymXWk8JzgP3HxLmiz3WJmSeoE4sFT1eT5zkGilmbkz7dPs9LBk9z0DOO+l4FJ4+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bfe777fe22so129516939f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 01:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708077270; x=1708682070;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cea30lTF2ZmYnQ/V27+tscvJ5hcf6E9js6ZkcIDubIo=;
        b=DrwfSfz3rlGc1Z9vCupzPB911DdmTrGfEJebaSUcpo8ESk4HJWIDoOa5wBU3xwK9oP
         q7cvctXwZrjJ8wDCPkLh5ImR3xtDNTwIw0Kgp2vvObL0NQrr6AQrJXEWlFYPz+CTkxtP
         NSxF4+vM8xoa3b4hh3iPBrFkDzWzwVtJfCGXkYPcJVGryiJDs8Cje9++whpd80WxDVWG
         Wa4ZK/bejiLpmhFPvfsLSLQJjvTjvsOIKHJRNEtQQqTDirzCZSYJdl9Ny2UodlxPoSPx
         fGNDUP/K2lNv+ya6mlnrnKzBsmjJz85oesL03dHQOnVj+c7mJWlsrI112mc3G5i6YzOf
         WpsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6iwE45uvdctz8id65/jXZ+fU9EnbRw0KYO8czF8R7HTr6NS+BPS9AaCbNobPaaPawl7RCPH1J56b9KNiUH+00mTqfxEOuEpYaB8omsA==
X-Gm-Message-State: AOJu0YzYGy1gxdgVEUQrLvmy+kR6FUGA0h2cXCEELoQmnihWsGg1J0PO
	6nrMhkEQAXW8Vs85/OQPVNtl2lb86P009nmn2VjwZ+cWBSb2LBU0N3IhMt0V1JmwoNCxjku6LGj
	8Et3RGpstX7vux/My0gapografhQvSamZjwH70hCHjeCuRnX2fGHZDzQ=
X-Google-Smtp-Source: AGHT+IHz1hrydZMsbNJiumpAX5k6IgtMsH1EHN9/Vx0geWMu2EI3sJw6KvOxb8S9xqeyRTffYTliCZgyFO4qp89Z5JELChJAU18J
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa2:b0:363:7b86:21bd with SMTP id
 l2-20020a056e021aa200b003637b8621bdmr318533ilv.4.1708077270741; Fri, 16 Feb
 2024 01:54:30 -0800 (PST)
Date: Fri, 16 Feb 2024 01:54:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8bafb06117cba33@google.com>
Subject: [syzbot] [overlayfs?] KASAN: slab-use-after-free Read in ovl_dentry_update_reval
From: syzbot <syzbot+316db8a1191938280eb6@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4f5e5092fdbf Merge tag 'net-6.8-rc5' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1143fa78180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb86c5ad8597e08a
dashboard link: https://syzkaller.appspot.com/bug?extid=316db8a1191938280eb6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-4f5e5092.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f8b1959c3264/vmlinux-4f5e5092.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4dd38747bfa8/bzImage-4f5e5092.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+316db8a1191938280eb6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ovl_dentry_remote fs/overlayfs/util.c:162 [inline]
BUG: KASAN: slab-use-after-free in ovl_dentry_update_reval+0xd2/0xf0 fs/overlayfs/util.c:167
Read of size 4 at addr ffff888028839b90 by task syz-executor.1/16906

CPU: 0 PID: 16906 Comm: syz-executor.1 Not tainted 6.8.0-rc4-syzkaller-00180-g4f5e5092fdbf #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 ovl_dentry_remote fs/overlayfs/util.c:162 [inline]
 ovl_dentry_update_reval+0xd2/0xf0 fs/overlayfs/util.c:167
 ovl_link_up fs/overlayfs/copy_up.c:610 [inline]
 ovl_copy_up_one+0x20fa/0x3490 fs/overlayfs/copy_up.c:1170
 ovl_copy_up_flags+0x18d/0x200 fs/overlayfs/copy_up.c:1223
 ovl_nlink_start+0x372/0x450 fs/overlayfs/util.c:1153
 ovl_do_remove+0x171/0xde0 fs/overlayfs/dir.c:893
 vfs_unlink+0x2fb/0x910 fs/namei.c:4334
 do_unlinkat+0x5c0/0x750 fs/namei.c:4398
 __do_sys_unlink fs/namei.c:4446 [inline]
 __se_sys_unlink fs/namei.c:4444 [inline]
 __ia32_sys_unlink+0xc7/0x110 fs/namei.c:4444
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x7c/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x33/0x80 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x7c/0x86
RIP: 0023:0xf7341579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5f3b5ac EFLAGS: 00000292 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 16906:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:314 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc_lru+0x140/0x700 mm/slub.c:3879
 __d_alloc+0x35/0x8c0 fs/dcache.c:1624
 d_alloc+0x4a/0x1e0 fs/dcache.c:1704
 d_alloc_parallel+0xe9/0x12c0 fs/dcache.c:2462
 __lookup_slow+0x194/0x460 fs/namei.c:1678
 lookup_one+0x185/0x1c0 fs/namei.c:2785
 ovl_lookup_upper fs/overlayfs/overlayfs.h:401 [inline]
 ovl_link_up fs/overlayfs/copy_up.c:599 [inline]
 ovl_copy_up_one+0x104e/0x3490 fs/overlayfs/copy_up.c:1170
 ovl_copy_up_flags+0x18d/0x200 fs/overlayfs/copy_up.c:1223
 ovl_nlink_start+0x372/0x450 fs/overlayfs/util.c:1153
 ovl_do_remove+0x171/0xde0 fs/overlayfs/dir.c:893
 vfs_unlink+0x2fb/0x910 fs/namei.c:4334
 do_unlinkat+0x5c0/0x750 fs/namei.c:4398
 __do_sys_unlink fs/namei.c:4446 [inline]
 __se_sys_unlink fs/namei.c:4444 [inline]
 __ia32_sys_unlink+0xc7/0x110 fs/namei.c:4444
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x7c/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x33/0x80 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x7c/0x86

Freed by task 109:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
 poison_slab_object mm/kasan/common.c:241 [inline]
 __kasan_slab_free+0x121/0x1c0 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kmem_cache_free+0x129/0x360 mm/slub.c:4363
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0x819/0x1680 kernel/rcu/tree.c:2465
 __do_softirq+0x21c/0x8e7 kernel/softirq.c:553

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0x110 mm/kasan/generic.c:586
 __call_rcu_common.constprop.0+0x9a/0x7c0 kernel/rcu/tree.c:2715
 dentry_free+0xc2/0x160 fs/dcache.c:376
 __dentry_kill+0x498/0x600 fs/dcache.c:622
 shrink_kill fs/dcache.c:1048 [inline]
 shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
 prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
 super_cache_scan+0x32a/0x550 fs/super.c:221
 do_shrink_slab+0x426/0x1120 mm/shrinker.c:435
 shrink_slab_memcg mm/shrinker.c:548 [inline]
 shrink_slab+0xa87/0x1310 mm/shrinker.c:626
 shrink_one+0x493/0x7b0 mm/vmscan.c:4767
 shrink_many mm/vmscan.c:4828 [inline]
 lru_gen_shrink_node mm/vmscan.c:4929 [inline]
 shrink_node+0x21d0/0x3790 mm/vmscan.c:5888
 kswapd_shrink_node mm/vmscan.c:6693 [inline]
 balance_pgdat+0x9d2/0x1a90 mm/vmscan.c:6883
 kswapd+0x5be/0xc00 mm/vmscan.c:7143
 kthread+0x2c6/0x3b0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff888028839b90
 which belongs to the cache dentry of size 312
The buggy address is located 0 bytes inside of
 freed 312-byte region [ffff888028839b90, ffff888028839cc8)

The buggy address belongs to the physical page:
page:ffffea0000a20e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28838
head:ffffea0000a20e00 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888020749431
ksm flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff8880162cf400 ffffea0000a28d00 dead000000000003
raw: 0000000000000000 0000000080140014 00000001ffffffff ffff888020749431
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE), pid 4679, tgid 4679 (udevd), ts 34753908780, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3311
 __alloc_pages+0x22f/0x2440 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2190 [inline]
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2407
 ___slab_alloc+0x4b0/0x1780 mm/slub.c:3540
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3625
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 kmem_cache_alloc_lru+0x37b/0x700 mm/slub.c:3879
 __d_alloc+0x35/0x8c0 fs/dcache.c:1624
 d_alloc+0x4a/0x1e0 fs/dcache.c:1704
 lookup_one_qstr_excl+0xcb/0x190 fs/namei.c:1604
 do_renameat2+0x5ae/0xdc0 fs/namei.c:4986
 __do_sys_rename fs/namei.c:5083 [inline]
 __se_sys_rename fs/namei.c:5081 [inline]
 __x64_sys_rename+0x81/0xa0 fs/namei.c:5081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888028839a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888028839b00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff888028839b80: fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888028839c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888028839c80: fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

