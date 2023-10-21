Return-Path: <linux-fsdevel+bounces-878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EA27D1EBF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 19:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D9EB20F5E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 17:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F4C1E52B;
	Sat, 21 Oct 2023 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3720EE
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 17:55:56 +0000 (UTC)
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA35126
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 10:55:49 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1bf00f8cf77so3005228fac.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 10:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697910949; x=1698515749;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JKDp8sz1oBIHSDCcxIxblGFaeakng5Ps3VlUhQZrV+k=;
        b=i8YkEn7MSTiHzq+LTYXL4QfAIZlx/7JUxpa99OGiT1+br4rgC3d1WL575Y9Y+eJSEE
         9yxbEWnxvmJjFtOvVZbn5w9radxXPjllZc3PRz/mUzDI0lNkS1E3amZOuN3qpN/JOR1r
         nchjgyP+tGkEZLxyr8sxn5OebFnzxPrRQf96UO7wqbSFD+Je2U7aFv5BHYWTwnJmx/r/
         8njT6EC8BDPNBw3Gfdtm5G4N4J/dFLj+jQ58Z0ccCkq/TAGLs0S09lzbpPB2o3i9vDQs
         k+O8urO7RMervaij/E+avVz5FhtmyWqMVTmt2NRx9NsN324VERzczuptW/L+E1DtePk9
         NAuQ==
X-Gm-Message-State: AOJu0YzOv1v9vOOuHG/cLoAczXiyGsmIXmxkzfyBQLSMAeex3v0CKxdB
	TmKfpN852hDVEvX+LF8rY583VKVB6dJCjkk+9gG62L3p6ZI1
X-Google-Smtp-Source: AGHT+IF4Y6mLZ9AWNYpSHrPGew0VWP/q1xwn5bBg3/CoMMWrIqqGLMgcj56Q+FsaP0gRZxqH+SQ/S0MH5RSjLFChnPF8UcTjwula
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:6489:b0:1e9:8e86:e661 with SMTP id
 cz9-20020a056870648900b001e98e86e661mr2400538oab.8.1697910949097; Sat, 21 Oct
 2023 10:55:49 -0700 (PDT)
Date: Sat, 21 Oct 2023 10:55:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb386106083db243@google.com>
Subject: [syzbot] [reiserfs?] general protection fault in ext4_file_write_iter
From: syzbot <syzbot+a2f32f54c8006a00d777@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	jpoimboe@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    213f891525c2 Merge tag 'probes-fixes-v6.6-rc6' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126daea9680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20c01df4ad8f1c16
dashboard link: https://syzkaller.appspot.com/bug?extid=a2f32f54c8006a00d777
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1231cae1680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12178005680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/451be82930dd/disk-213f8915.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ced0744b1f8f/vmlinux-213f8915.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c1326b71b235/bzImage-213f8915.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/271887eb86fe/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2f32f54c8006a00d777@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc00400000c5: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000200000628-0x000000020000062f]
CPU: 0 PID: 5032 Comm: syz-executor165 Not tainted 6.6.0-rc6-syzkaller-00029-g213f891525c2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
==================================================================
BUG: KASAN: out-of-bounds in console_flush_all+0xf23/0xfb0 kernel/printk/printk.c:2976
Read of size 8 at addr ffffc9000349ef10 by task syz-executor165/5032

CPU: 0 PID: 5032 Comm: syz-executor165 Not tainted 6.6.0-rc6-syzkaller-00029-g213f891525c2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 console_flush_all+0xf23/0xfb0 kernel/printk/printk.c:2976
 console_unlock+0x10c/0x260 kernel/printk/printk.c:3035
 vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2307
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2332
 dump_stack_print_info+0x12e/0x150 lib/dump_stack.c:66
 show_regs+0x1a/0xa0 arch/x86/kernel/dumpstack.c:469
 __die_body arch/x86/kernel/dumpstack.c:420 [inline]
 die_addr+0x4f/0xd0 arch/x86/kernel/dumpstack.c:460
 __exc_general_protection arch/x86/kernel/traps.c:697 [inline]
 exc_general_protection+0x154/0x230 arch/x86/kernel/traps.c:642
 asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:564
RIP: 0010:EXT4_SB fs/ext4/ext4.h:1746 [inline]
RIP: 0010:ext4_forced_shutdown fs/ext4/ext4.h:2231 [inline]
RIP: 0010:ext4_file_write_iter+0x103/0x1860 fs/ext4/file.c:707
Code: 48 c1 ea 03 80 3c 02 00 0f 85 5e 15 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5d 28 48 8d bb 28 06 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 2e 15 00 00 4c 8b a3 28 06 00 00 be 08 00 00 00
RSP: 0000:ffffc9000349f270 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000200000001 RCX: 0000000000000000
RDX: 00000000400000c5 RSI: ffffffff822ede7a RDI: 0000000200000629
RBP: ffff88807365d830 R08: 0000000000000005 R09: 0000000000000007
R10: 0000000000000004 R11: ffffffff8a601206 R12: ffffc9000349f5c8
R13: ffffc9000349f3f0 R14: 0000000000000002 R15: ffff8880267ae2d0
 __kernel_write_iter+0x261/0x7e0 fs/read_write.c:517
 __kernel_write+0xf6/0x140 fs/read_write.c:537
 __dump_emit fs/coredump.c:813 [inline]
 dump_emit+0x21d/0x330 fs/coredump.c:850
 elf_core_dump+0x2082/0x3900 fs/binfmt_elf.c:2094
 do_coredump+0x2c96/0x3fc0 fs/coredump.c:764
 get_signal+0x2434/0x2790 kernel/signal.c:2878
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:309
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7f1369fb0833
Code: 00 00 00 02 00 00 00 48 00 04 00 00 00 00 00 01 00 00 00 02 00 00 00 48 00 04 00 00 00 00 00 01 00 00 00 02 00 00 00 48 00 04 <00> 00 00 00 00 01 00 00 00 02 00 00 00 48 00 04 00 00 00 00 00 01
RSP: 002b:00007fffac036608 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 00007fffac036690 RCX: 00007f1369fb0833
RDX: 00007fffac036620 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000065 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000f4240
R13: 0000000000018c01 R14: 00007fffac036664 R15: 00007fffac036680
 </TASK>

The buggy address belongs to stack of task syz-executor165/5032

The buggy address belongs to the virtual mapping at
 [ffffc90003498000, ffffc900034a1000) created by:
 kernel_clone+0xfd/0x920 kernel/fork.c:2909

The buggy address belongs to the physical page:
page:ffffea0001fbfac0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7efeb
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 4993, tgid 4993 (dhcpcd-run-hook), ts 88329486010, free_ts 72453205616
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2297
 vm_area_alloc_pages mm/vmalloc.c:3063 [inline]
 __vmalloc_area_node mm/vmalloc.c:3139 [inline]
 __vmalloc_node_range+0xa6e/0x1540 mm/vmalloc.c:3320
 alloc_thread_stack_node kernel/fork.c:309 [inline]
 dup_task_struct kernel/fork.c:1118 [inline]
 copy_process+0x13e3/0x73f0 kernel/fork.c:2327
 kernel_clone+0xfd/0x920 kernel/fork.c:2909
 __do_sys_clone+0xba/0x100 kernel/fork.c:3052
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 slab_destroy mm/slab.c:1608 [inline]
 slabs_destroy+0x85/0xc0 mm/slab.c:1628
 cache_flusharray mm/slab.c:3341 [inline]
 ___cache_free+0x2b7/0x420 mm/slab.c:3404
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x4c/0x1b0 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slab.c:3237 [inline]
 __kmem_cache_alloc_node+0x163/0x470 mm/slab.c:3521
 __do_kmalloc_node mm/slab_common.c:1022 [inline]
 __kmalloc+0x4f/0x100 mm/slab_common.c:1036
 kmalloc include/linux/slab.h:603 [inline]
 tomoyo_add_entry security/tomoyo/common.c:2023 [inline]
 tomoyo_supervisor+0xcdb/0xea0 security/tomoyo/common.c:2095
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission security/tomoyo/file.c:587 [inline]
 tomoyo_path_permission+0x270/0x3b0 security/tomoyo/file.c:573
 tomoyo_path_perm+0x35a/0x450 security/tomoyo/file.c:838
 security_inode_getattr+0xf1/0x150 security/security.c:2153
 vfs_getattr fs/stat.c:169 [inline]
 vfs_fstat+0x4f/0xc0 fs/stat.c:194
 vfs_fstatat+0x130/0x140 fs/stat.c:291
 __do_sys_newfstatat+0x98/0x110 fs/stat.c:459

Memory state around the buggy address:
 ffffc9000349ee00: 48 00 04 00 00 00 00 00 01 00 00 00 02 00 00 00
 ffffc9000349ee80: 48 00 04 00 00 00 00 00 01 00 00 00 02 00 00 00
>ffffc9000349ef00: 48 00 04 00 00 00 00 00 01 00 00 00 02 00 00 00
                         ^
 ffffc9000349ef80: 48 00 04 00 00 00 00 00 01 00 00 00 02 00 00 00
 ffffc9000349f000: 48 00 04 00 00 00 00 00 01 00 00 00 02 00 00 00
==================================================================
----------------
Code disassembly (best guess):
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 5e 15 00 00    	jne    0x156c
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df
  18:	48 8b 5d 28          	mov    0x28(%rbp),%rbx
  1c:	48 8d bb 28 06 00 00 	lea    0x628(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 2e 15 00 00    	jne    0x1562
  34:	4c 8b a3 28 06 00 00 	mov    0x628(%rbx),%r12
  3b:	be 08 00 00 00       	mov    $0x8,%esi


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

