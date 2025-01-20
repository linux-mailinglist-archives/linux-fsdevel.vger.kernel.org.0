Return-Path: <linux-fsdevel+bounces-39696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2660BA170C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 492917A1865
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F71EBA1C;
	Mon, 20 Jan 2025 16:50:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83491B87DB
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737391830; cv=none; b=fz+VgIKtgEkiPVBGX8W0DX4eewAP4jOCGGELMkbVphD+DvcAWC8wwJoWHcdmHjFgKWlmnO4dv7VfQAqXJba5lSU8XiI+axpiZOxWlRFzWgt7FevP5Z3ZkymjG++LsrgUTb4gbhqqQps0apQS70UtjW3ll2Qbl76gtlbW2yXQCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737391830; c=relaxed/simple;
	bh=al6sk+hJsGSq2aGKrsQWQtTogJJm8VbNWbgXSHRG5VM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JWopvMnW0vCfywW5X+AYRw5ED0j3FL+F4C4DIZOId0EJEp/8MK3R1Rpiz6+gWRpCIA819M8XtCwpkBEH9UnrLZ+MczFRpX22Wr4y6s864T2vmNE3clzj26nTWNGd+aDxlEaRDcyBWL1aTAP2kpnDv+IiUMuLspUxI/+sxnlEhlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ce51b2fcc6so75161305ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 08:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737391828; x=1737996628;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHf9Hnj8wyJPp/8snqbBHlbBfhoj3W2jVZ6SUD+I9Dw=;
        b=KEGUcKcUTaWm8eee1oTjiZoyhaPg6SAIri/9ha3oiui3e7pDk0/Wod2u9LG3IezQ59
         UwzWChKllj+VbBZvIqlO8FtGf4DkGPwh6YFVJE0tgriVFcL/6dmsq/Cl6raXlWVYBD89
         M/lGqC2Zf3l8h0HwVa1An+1aKS7W8vS6p3AniemKn6eVnPJ8hesdiIlm3UVIlfR1XcX0
         nbJNZrVWtGskzUOiz7NWninvxo9MN0cHG2uyD6t7qDz72HiCC6KxxCbdsVR8RQJVuuvO
         PKjckLK/0LniVA7RIUCOftnQjrmlosu0yJn0JmAVO47QaWZypTjgIMOn26drvrJVLccQ
         Z67w==
X-Forwarded-Encrypted: i=1; AJvYcCVHqG3s1lpZmup1k09U0Pg6PzyPqwK60dvnBpi0ehQ2NzTu/q9bxHU5JywfDMmGTHhozk7/kbAut3kTJAT9@vger.kernel.org
X-Gm-Message-State: AOJu0YxYO2bPionlVFme+0fStT31gnmLAN30xbdMvQWf5uiNsaceCMxz
	leXKC7JBSS++SksT4rqe66OevzJLOloLTSuYkMP/RjUIbZs+vwDLfU9CBDVjVwwRL6EFNDrcTjl
	fwTnyLdAp+FT3W/MA2mp2Md4Y1dxw1ajsLvJs6GZ1TX+MX7NHxsM4Nuc=
X-Google-Smtp-Source: AGHT+IEtkEFm9hRUFwKxU5eyKB87AdxmiKZRGyaxQypQOGfYJKtcG8zOJXb4D5aO4EZhQBzqKLSHC9asNjVzcWiU6DU0tR44G+Y8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1749:b0:3a7:5cda:2769 with SMTP id
 e9e14a558f8ab-3cf744201a4mr122070835ab.12.1737391827901; Mon, 20 Jan 2025
 08:50:27 -0800 (PST)
Date: Mon, 20 Jan 2025 08:50:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678e7ed3.050a0220.303755.007f.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in start_creating (2)
From: syzbot <syzbot+674b1c12641a6992f1d5@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    be548645527a Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11fbb1df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ad08f7f48e13abcd
dashboard link: https://syzkaller.appspot.com/bug?extid=674b1c12641a6992f1d5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/68edb33a6611/disk-be548645.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9c748ff58068/vmlinux-be548645.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6ae2859fc0e3/bzImage-be548645.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+674b1c12641a6992f1d5@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc6-syzkaller-00290-gbe548645527a #0 Not tainted
------------------------------------------------------
syz.7.2798/18466 is trying to acquire lock:
ffff8880621f6988 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
ffff8880621f6988 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: start_creating.part.0+0xb0/0x3a0 fs/debugfs/inode.c:374

but task is already holding lock:
ffffffff8de395c8 (relay_channels_mutex){+.+.}-{4:4}, at: relay_open+0x324/0xa20 kernel/relay.c:515

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (relay_channels_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       relay_prepare_cpu+0x2c/0x300 kernel/relay.c:438
       cpuhp_invoke_callback+0x3d0/0xa10 kernel/cpu.c:194
       __cpuhp_invoke_callback_range+0x101/0x200 kernel/cpu.c:965
       cpuhp_invoke_callback_range kernel/cpu.c:989 [inline]
       cpuhp_up_callbacks kernel/cpu.c:1020 [inline]
       _cpu_up+0x3fd/0x910 kernel/cpu.c:1690
       cpu_up+0x1dc/0x240 kernel/cpu.c:1722
       cpuhp_bringup_mask+0xdc/0x210 kernel/cpu.c:1788
       cpuhp_bringup_cpus_parallel kernel/cpu.c:1878 [inline]
       bringup_nonboot_cpus+0x176/0x1c0 kernel/cpu.c:1892
       smp_init+0x34/0x160 kernel/smp.c:1009
       kernel_init_freeable+0x3ad/0x8b0 init/main.c:1569
       kernel_init+0x1c/0x2b0 init/main.c:1466
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (cpu_hotplug_lock){++++}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       cpus_read_lock+0x42/0x160 kernel/cpu.c:490
       acomp_ctx_get_cpu mm/zswap.c:886 [inline]
       zswap_compress mm/zswap.c:908 [inline]
       zswap_store_page mm/zswap.c:1439 [inline]
       zswap_store+0x8f8/0x25f0 mm/zswap.c:1546
       swap_writepage+0x3b6/0x1120 mm/page_io.c:279
       shmem_writepage+0xf7b/0x1490 mm/shmem.c:1579
       pageout+0x3b2/0xaa0 mm/vmscan.c:696
       shrink_folio_list+0x3025/0x42d0 mm/vmscan.c:1374
       evict_folios+0x6e3/0x19c0 mm/vmscan.c:4600
       try_to_shrink_lruvec+0x61e/0xa80 mm/vmscan.c:4796
       lru_gen_shrink_lruvec mm/vmscan.c:4945 [inline]
       shrink_lruvec+0x313/0x2ba0 mm/vmscan.c:5700
       shrink_node_memcgs mm/vmscan.c:5936 [inline]
       shrink_node mm/vmscan.c:5977 [inline]
       shrink_node+0x105e/0x3f20 mm/vmscan.c:5955
       shrink_zones mm/vmscan.c:6222 [inline]
       do_try_to_free_pages+0x35f/0x1a30 mm/vmscan.c:6284
       try_to_free_mem_cgroup_pages+0x31a/0x7a0 mm/vmscan.c:6616
       try_charge_memcg+0x356/0xaf0 mm/memcontrol.c:2238
       obj_cgroup_charge_pages mm/memcontrol.c:2646 [inline]
       obj_cgroup_charge+0x179/0x4d0 mm/memcontrol.c:2937
       __memcg_slab_post_alloc_hook+0x1b6/0x9b0 mm/memcontrol.c:2998
       memcg_slab_post_alloc_hook mm/slub.c:2152 [inline]
       slab_post_alloc_hook mm/slub.c:4129 [inline]
       slab_alloc_node mm/slub.c:4168 [inline]
       kmem_cache_alloc_lru_noprof+0x30d/0x3b0 mm/slub.c:4187
       alloc_inode+0xbf/0x230 fs/inode.c:338
       new_inode_pseudo fs/inode.c:1174 [inline]
       new_inode+0x22/0x210 fs/inode.c:1193
       debugfs_get_inode fs/debugfs/inode.c:72 [inline]
       __debugfs_create_file+0x11a/0x660 fs/debugfs/inode.c:433
       debugfs_create_file_full+0x6d/0xa0 fs/debugfs/inode.c:462
       kvm_create_vm_debugfs virt/kvm/kvm_main.c:1056 [inline]
       kvm_create_vm virt/kvm/kvm_main.c:1193 [inline]
       kvm_dev_ioctl_create_vm virt/kvm/kvm_main.c:5353 [inline]
       kvm_dev_ioctl+0x16b7/0x1aa0 virt/kvm/kvm_main.c:5395
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sb->s_type->i_mutex_key#3){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       down_write+0x93/0x200 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:818 [inline]
       start_creating.part.0+0xb0/0x3a0 fs/debugfs/inode.c:374
       start_creating fs/debugfs/inode.c:351 [inline]
       __debugfs_create_file+0xa5/0x660 fs/debugfs/inode.c:423
       debugfs_create_file_full+0x6d/0xa0 fs/debugfs/inode.c:462
       relay_create_buf_file+0xf0/0x170 kernel/relay.c:360
       relay_open_buf.part.0+0x760/0xb90 kernel/relay.c:389
       relay_open_buf kernel/relay.c:536 [inline]
       relay_open+0x5e2/0xa20 kernel/relay.c:517
       do_blk_trace_setup+0x4b4/0xac0 kernel/trace/blktrace.c:590
       __blk_trace_setup+0xd8/0x180 kernel/trace/blktrace.c:630
       blk_trace_setup+0x47/0x70 kernel/trace/blktrace.c:648
       sg_ioctl_common drivers/scsi/sg.c:1114 [inline]
       sg_ioctl+0x7a3/0x26b0 drivers/scsi/sg.c:1156
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &sb->s_type->i_mutex_key#3 --> cpu_hotplug_lock --> relay_channels_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(relay_channels_mutex);
                               lock(cpu_hotplug_lock);
                               lock(relay_channels_mutex);
  lock(&sb->s_type->i_mutex_key#3);

 *** DEADLOCK ***

2 locks held by syz.7.2798/18466:
 #0: ffff8881433b1ca8 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x33/0x70 kernel/trace/blktrace.c:647
 #1: ffffffff8de395c8 (relay_channels_mutex){+.+.}-{4:4}, at: relay_open+0x324/0xa20 kernel/relay.c:515

stack backtrace:
CPU: 1 UID: 0 PID: 18466 Comm: syz.7.2798 Not tainted 6.13.0-rc6-syzkaller-00290-gbe548645527a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x41c/0x610 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 down_write+0x93/0x200 kernel/locking/rwsem.c:1577
 inode_lock include/linux/fs.h:818 [inline]
 start_creating.part.0+0xb0/0x3a0 fs/debugfs/inode.c:374
 start_creating fs/debugfs/inode.c:351 [inline]
 __debugfs_create_file+0xa5/0x660 fs/debugfs/inode.c:423
 debugfs_create_file_full+0x6d/0xa0 fs/debugfs/inode.c:462
 relay_create_buf_file+0xf0/0x170 kernel/relay.c:360
 relay_open_buf.part.0+0x760/0xb90 kernel/relay.c:389
 relay_open_buf kernel/relay.c:536 [inline]
 relay_open+0x5e2/0xa20 kernel/relay.c:517
 do_blk_trace_setup+0x4b4/0xac0 kernel/trace/blktrace.c:590
 __blk_trace_setup+0xd8/0x180 kernel/trace/blktrace.c:630
 blk_trace_setup+0x47/0x70 kernel/trace/blktrace.c:648
 sg_ioctl_common drivers/scsi/sg.c:1114 [inline]
 sg_ioctl+0x7a3/0x26b0 drivers/scsi/sg.c:1156
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f596cf85d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f596de83038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f596d176080 RCX: 00007f596cf85d29
RDX: 0000000000000038 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f596d001b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f596d176080 R15: 00007ffc52cefc58
 </TASK>


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

