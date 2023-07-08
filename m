Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D28F74BD5D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jul 2023 13:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGHLaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jul 2023 07:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGHLaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jul 2023 07:30:04 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49E21FC7
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Jul 2023 04:30:00 -0700 (PDT)
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 368BTx5B058388;
        Sat, 8 Jul 2023 20:29:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Sat, 08 Jul 2023 20:29:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 368BTwkW058384
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 8 Jul 2023 20:29:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8bacb159-6512-b2d0-d015-a9c4f141df8b@I-love.SAKURA.ne.jp>
Date:   Sat, 8 Jul 2023 20:29:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [syzbot] [tomoyo?] [hfs?] general protection fault in
 tomoyo_check_acl (3)
Content-Language: en-US
To:     syzbot <syzbot+28aaddd5a3221d7fd709@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <000000000000fcfb4a05ffe48213@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000fcfb4a05ffe48213@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is not a bug in TOMOYO, for booting with security=none results in crashing at other locations.

This might be a bug in HFS's error handling. But since there are several bugs
which have been added as "mm" in the last few days, let's change this as "mm".

#syz set subsystems: mm

----------------------------------------
[  234.106763][ T8646] loop0: detected capacity change from 0 to 64
[  234.111147][ T8646] hfs: unable to locate alternate MDB
[  234.113523][ T8646] hfs: continuing without an alternate MDB
[  234.185677][ T8650] loop0: detected capacity change from 0 to 64
[  234.192285][ T8650] hfs: unable to locate alternate MDB
[  234.195221][ T8650] hfs: continuing without an alternate MDB
[  234.206630][ T4935] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  234.210973][ T4935] #PF: supervisor instruction fetch in kernel mode
[  234.213694][ T4935] #PF: error_code(0x0010) - not-present page
[  234.216259][ T4935] PGD 0 P4D 0 
[  234.219992][ T4935] Oops: 0010 [#1] PREEMPT SMP KASAN
[  234.225781][ T4935] CPU: 1 PID: 4935 Comm: systemd-journal Not tainted 6.4.0-syzkaller-10173-ga901a3568fd2 #0
[  234.234045][ T4935] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  234.237508][ T4935] RIP: 0010:0x0
[  234.240448][ T4935] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  234.243743][ T4935] RSP: 0018:ffffc9000471fde0 EFLAGS: 00010246
[  234.246828][ T4935] RAX: 1ffff92000459c06 RBX: ffff888021c07800 RCX: 0000000000000000
[  234.249926][ T4935] RDX: ffff88802a853900 RSI: ffffc900022ce048 RDI: ffffc9000471fe30
[  234.252897][ T4935] RBP: ffffc900022ce000 R08: 0000000000000004 R09: 000000007fff0000
[  234.255863][ T4935] R10: 000000007fff0000 R11: 0000000000000000 R12: 000000007fff0000
[  234.258860][ T4935] R13: dffffc0000000000 R14: 000000007fff0000 R15: ffffc9000471fe30
[  234.261902][ T4935] FS:  00007f9c84a5b900(0000) GS:ffff88821bc00000(0000) knlGS:0000000000000000
[  234.265635][ T4935] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  234.268956][ T4935] CR2: ffffffffffffffd6 CR3: 000000002a8f8000 CR4: 00000000000106e0
[  234.272004][ T4935] Call Trace:
[  234.274294][ T4935]  <TASK>
[  234.276945][ T4935]  ? __die+0x1f/0x60
[  234.280174][ T4935]  ? page_fault_oops+0x34f/0xa50
[  234.282836][ T4935]  ? dump_pagetable+0x500/0x500
[  234.285246][ T4935]  ? devkmsg_read+0x106/0x530
[  234.287796][ T4935]  ? do_user_addr_fault+0x79b/0x1360
[  234.290288][ T4935]  ? irqentry_enter+0x2c/0x50
[  234.293222][ T4935]  ? rcu_is_watching+0x12/0xb0
[  234.295599][ T4935]  ? exc_page_fault+0x98/0x170
[  234.297975][ T4935]  ? asm_exc_page_fault+0x26/0x30
[  234.300538][ T4935]  __seccomp_filter+0x23b/0x1080
[  234.303088][ T4935]  ? seccomp_notify_ioctl+0xea0/0xea0
[  234.305529][ T4935]  ? ksys_read+0x19a/0x250
[  234.309842][ T4935]  __secure_computing+0x24a/0x3e0
[  234.312177][ T4935]  syscall_trace_enter.constprop.0+0x90/0x1e0
[  234.314842][ T4935]  do_syscall_64+0x1a/0xb0
[  234.317109][ T4935]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  234.319502][ T4935] RIP: 0033:0x7f9c84d14764
[  234.321705][ T4935] Code: 24 20 eb 8f 66 90 44 89 54 24 0c e8 26 c3 f7 ff 44 8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 68 c3 f7 ff 8b 44
[  234.327901][ T4935] RSP: 002b:00007ffc7cc7c060 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
[  234.330801][ T4935] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f9c84d14764
[  234.333655][ T4935] RDX: 0000000000080802 RSI: 000055e36b136590 RDI: 00000000ffffff9c
[  234.336513][ T4935] RBP: 000055e36b136590 R08: 0000000000000000 R09: 6436356564616238
[  234.339340][ T4935] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000080802
[  234.342184][ T4935] R13: 00000000ffffffff R14: 000055e36b117940 R15: 00000000fffffffa
[  234.345046][ T4935]  </TASK>
[  234.347155][ T4935] Modules linked in:
[  234.349709][ T4935] CR2: 0000000000000000
[  234.352014][ T4935] ---[ end trace 0000000000000000 ]---
[  234.354409][ T4935] RIP: 0010:0x0
[  234.356534][ T4935] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  234.359337][ T4935] RSP: 0018:ffffc9000471fde0 EFLAGS: 00010246
[  234.361877][ T4935] RAX: 1ffff92000459c06 RBX: ffff888021c07800 RCX: 0000000000000000
[  234.364713][ T4935] RDX: ffff88802a853900 RSI: ffffc900022ce048 RDI: ffffc9000471fe30
[  234.367539][ T4935] RBP: ffffc900022ce000 R08: 0000000000000004 R09: 000000007fff0000
[  234.370393][ T4935] R10: 000000007fff0000 R11: 0000000000000000 R12: 000000007fff0000
[  234.373153][ T4935] R13: dffffc0000000000 R14: 000000007fff0000 R15: ffffc9000471fe30
[  234.375973][ T4935] FS:  00007f9c84a5b900(0000) GS:ffff88821bc00000(0000) knlGS:0000000000000000
[  234.378954][ T4935] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  234.381510][ T4935] CR2: ffffffffffffffd6 CR3: 000000002a8f8000 CR4: 00000000000106e0
[  234.384294][ T4935] Kernel panic - not syncing: Fatal exception
[  234.409390][ T4935] Kernel Offset: disabled
[  234.411337][ T4935] Rebooting in 10 seconds..
----------------------------------------

----------------------------------------
[  125.755870][ T7323] loop0: detected capacity change from 0 to 64
[  125.763129][ T7323] hfs: unable to locate alternate MDB
[  125.765786][ T7323] hfs: continuing without an alternate MDB
[  125.833083][ T7333] loop0: detected capacity change from 0 to 64
[  125.835374][ T6048] I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 2
[  125.871486][ T7333] hfs: unable to locate alternate MDB
[  125.873910][ T7333] hfs: continuing without an alternate MDB
[  125.994779][ T6048] BUG: unable to handle page fault for address: 000000000000e643
[  126.001710][ T6048] #PF: supervisor read access in kernel mode
[  126.007733][ T6048] #PF: error_code(0x0000) - not-present page
[  126.013851][ T6048] PGD 0 P4D 0 
[  126.018475][ T6048] Oops: 0000 [#1] PREEMPT SMP KASAN
[  126.024193][ T6048] CPU: 1 PID: 6048 Comm: systemd-udevd Not tainted 6.4.0-syzkaller-10173-ga901a3568fd2 #0
[  126.032504][ T6048] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  126.040438][ T6048] RIP: 0010:kmem_cache_alloc+0x100/0x380
[  126.046359][ T6048] Code: 8b 78 08 48 83 78 10 00 4c 8b 00 0f 84 65 02 00 00 4d 85 c0 0f 84 5c 02 00 00 41 8b 44 24 28 48 8d 4f 08 48 89 fa 4d 8b 0c 24 <49> 8b 1c 00 4c 89 c0 65 49 0f c7 09 0f 1f 00 48 31 d7 4c 31 c0 48
[  126.063278][ T6048] RSP: 0018:ffffc90006a9fb70 EFLAGS: 00010206
[  126.069728][ T6048] RAX: 0000000000000010 RBX: 0000000000002120 RCX: 000000000003b3b9
[  126.077511][ T6048] RDX: 000000000003b3b1 RSI: 0000000000000028 RDI: 000000000003b3b1
[  126.085452][ T6048] RBP: ffffc90006a9fbb8 R08: 000000000000e633 R09: 00000000000412c0
[  126.093072][ T6048] R10: ffff888136fd0000 R11: 0000000000096001 R12: ffff888012850640
[  126.100428][ T6048] R13: 0000000000000000 R14: ffffffff841a9bd4 R15: 0000000000000000
[  126.107889][ T6048] FS:  00007fabf50418c0(0000) GS:ffff88821bc00000(0000) knlGS:0000000000000000
[  126.115942][ T6048] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  126.122614][ T6048] CR2: 000000000000e643 CR3: 0000000127adc000 CR4: 00000000000106e0
[  126.130102][ T6048] Call Trace:
[  126.134869][ T6048]  <TASK>
[  126.139431][ T6048]  ? __die+0x1f/0x60
[  126.141928][ T6048]  ? page_fault_oops+0x34f/0xa50
[  126.144282][ T6048]  ? lock_downgrade+0x690/0x690
[  126.146601][ T6048]  ? dump_pagetable+0x500/0x500
[  126.148916][ T6048]  ? search_extable+0x83/0xb0
[  126.152042][ T6048]  ? is_prefetch.constprop.0+0xb7/0x540
[  126.157957][ T6048]  ? trim_init_extable+0x3d0/0x3d0
[  126.163586][ T6048]  ? bpf_ksym_find+0x125/0x1b0
[  126.168983][ T6048]  ? pgtable_bad+0x90/0x90
[  126.174138][ T6048]  ? search_bpf_extables+0x1cc/0x320
[  126.179798][ T6048]  ? kmem_cache_alloc+0x100/0x380
[  126.185227][ T6048]  ? fixup_exception+0x119/0xce0
[  126.190594][ T6048]  ? kernelmode_fixup_or_oops+0x23f/0x2b0
[  126.194383][ T6048]  ? __bad_area_nosemaphore+0x3a4/0x6c0
[  126.197145][ T6048]  ? lock_mm_and_find_vma+0xc1/0x770
[  126.199781][ T6048]  ? do_user_addr_fault+0x71a/0x1360
[  126.202447][ T6048]  ? irqentry_enter+0x2c/0x50
[  126.204949][ T6048]  ? rcu_is_watching+0x12/0xb0
[  126.207448][ T6048]  ? exc_page_fault+0x98/0x170
[  126.209975][ T6048]  ? asm_exc_page_fault+0x26/0x30
[  126.212509][ T6048]  ? fill_pool+0x264/0x5c0
[  126.214898][ T6048]  ? kmem_cache_alloc+0x100/0x380
[  126.217405][ T6048]  fill_pool+0x264/0x5c0
[  126.219799][ T6048]  ? __list_del_entry_valid+0x1b0/0x1b0
[  126.222373][ T6048]  ? rcu_is_watching+0x12/0xb0
[  126.224759][ T6048]  ? trace_irq_enable.constprop.0+0xd0/0x100
[  126.227405][ T6048]  debug_object_activate+0x12d/0x4f0
[  126.229901][ T6048]  ? debug_object_activate+0xf7/0x4f0
[  126.232428][ T6048]  ? debug_object_free+0x360/0x360
[  126.234873][ T6048]  ? rcu_is_watching+0x12/0xb0
[  126.238746][ T6048]  ? percpu_counter_add_batch+0x170/0x1e0
[  126.241715][ T6048]  ? flush_delayed_fput+0x80/0x80
[  126.244212][ T6048]  __call_rcu_common.constprop.0+0x2c/0x7e0
[  126.247228][ T6048]  task_work_run+0x16f/0x270
[  126.249497][ T6048]  ? task_work_cancel+0x30/0x30
[  126.251839][ T6048]  exit_to_user_mode_prepare+0x210/0x240
[  126.254215][ T6048]  syscall_exit_to_user_mode+0x1d/0x50
[  126.256519][ T6048]  do_syscall_64+0x46/0xb0
[  126.258584][ T6048]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  126.260923][ T6048] RIP: 0033:0x7fabf4f19a1b
[  126.263012][ T6048] Code: c3 66 0f 1f 44 00 00 48 8b 15 11 f4 0f 00 f7 d8 64 89 02 b8 ff ff ff ff eb bc 0f 1f 44 00 00 f3 0f 1e fa b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 e1 f3 0f 00 f7 d8
[  126.269249][ T6048] RSP: 002b:00007ffd1ca9f738 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
[  126.272207][ T6048] RAX: 0000000000000000 RBX: 000055d3bfa52a20 RCX: 00007fabf4f19a1b
[  126.274995][ T6048] RDX: 00007fabf5015a00 RSI: 00000000fbada418 RDI: 000000000000000f
[  126.277924][ T6048] RBP: 0000000000000000 R08: 000000000000000f R09: 00000000ffffffff
[  126.280700][ T6048] R10: 697265733d6b746e R11: 0000000000000202 R12: 00007fabf5016600
[  126.283502][ T6048] R13: 0000000000000488 R14: 00007ffd1ca9f850 R15: 000055d3bf88e661
[  126.286286][ T6048]  </TASK>
[  126.288159][ T6048] Modules linked in:
[  126.290139][ T6048] CR2: 000000000000e643
[  126.295034][ T6048] ---[ end trace 0000000000000000 ]---
[  126.312680][ T6048] RIP: 0010:kmem_cache_alloc+0x100/0x380
[  126.319586][ T6048] Code: 8b 78 08 48 83 78 10 00 4c 8b 00 0f 84 65 02 00 00 4d 85 c0 0f 84 5c 02 00 00 41 8b 44 24 28 48 8d 4f 08 48 89 fa 4d 8b 0c 24 <49> 8b 1c 00 4c 89 c0 65 49 0f c7 09 0f 1f 00 48 31 d7 4c 31 c0 48
[  126.327476][ T6048] RSP: 0018:ffffc90006a9fb70 EFLAGS: 00010206
[  126.330071][ T6048] RAX: 0000000000000010 RBX: 0000000000002120 RCX: 000000000003b3b9
[  126.333340][ T6048] RDX: 000000000003b3b1 RSI: 0000000000000028 RDI: 000000000003b3b1
[  126.340879][ T6048] RBP: ffffc90006a9fbb8 R08: 000000000000e633 R09: 00000000000412c0
[  126.345096][ T6048] R10: ffff888136fd0000 R11: 0000000000096001 R12: ffff888012850640
[  126.356848][ T6048] R13: 0000000000000000 R14: ffffffff841a9bd4 R15: 0000000000000000
[  126.360369][ T6048] FS:  00007fabf50418c0(0000) GS:ffff88821bc00000(0000) knlGS:0000000000000000
[  126.365189][ T6048] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  126.368749][ T6048] CR2: 000000000000e643 CR3: 0000000127adc000 CR4: 00000000000106e0
[  126.372736][ T6048] Kernel panic - not syncing: Fatal exception
[  126.395942][ T6048] Kernel Offset: disabled
[  126.397927][ T6048] Rebooting in 10 seconds..
----------------------------------------

----------------------------------------
[  100.152101][ T6110] loop0: detected capacity change from 0 to 64
[  100.156271][ T6110] hfs: unable to locate alternate MDB
[  100.158789][ T6110] hfs: continuing without an alternate MDB
[  100.185413][ T6114] loop0: detected capacity change from 0 to 64
[  100.190998][    C2] general protection fault, probably for non-canonical address 0xdffffc0000001cc6: 0000 [#1] PREEMPT SMP KASAN
[  100.191250][ T6114] hfs: unable to locate alternate MDB
[  100.193238][    C2] KASAN: probably user-memory-access in range [0x000000000000e630-0x000000000000e637]
[  100.194949][ T6114] hfs: continuing without an alternate MDB
[  100.195887][    C2] CPU: 2 PID: 28 Comm: ksoftirqd/2 Not tainted 6.4.0-syzkaller-10173-ga901a3568fd2 #0
[  100.195898][    C2] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  100.195902][    C2] RIP: 0010:percpu_ref_get_many+0x4c/0x160
[  100.195925][    C2] Code: c7 c7 00 27 9a 8c e8 63 56 87 ff e8 9e 14 3f 08 5a 85 c0 0f 85 c2 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 fc 00 00 00 48 8b 03 a8 03 74 79 48 8d 7b 08 48
[  100.195933][    C2] RSP: 0018:ffffc90000a97c68 EFLAGS: 00010006
[  100.195943][    C2] RAX: dffffc0000000000 RBX: 000000000000e633 RCX: 0000000000000000
[  100.195948][    C2] RDX: 0000000000001cc6 RSI: 0000000000000101 RDI: ffffffff8c372a10
[  100.226755][    C2] RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff1d5366a
[  100.229870][    C2] R10: ffffffff8ea9b357 R11: 0000000000096001 R12: 000000000000e633
[  100.233023][    C2] R13: 0000000000000a08 R14: 0000000000000200 R15: ffff8880b9ab7fe0
[  100.236115][    C2] FS:  0000000000000000(0000) GS:ffff8880b9a80000(0000) knlGS:0000000000000000
[  100.239378][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  100.242587][    C2] CR2: 00007f4e04607c00 CR3: 000000012e4b0000 CR4: 00000000000106e0
[  100.246644][    C2] Call Trace:
[  100.249782][    C2]  <TASK>
[  100.252805][    C2]  ? die_addr+0x3c/0xa0
[  100.256072][    C2]  ? exc_general_protection+0x129/0x230
[  100.259643][    C2]  ? asm_exc_general_protection+0x26/0x30
[  100.265209][    C2]  ? percpu_ref_get_many+0x4c/0x160
[  100.270491][    C2]  ? mem_cgroup_move_task+0x170/0x170
[  100.273179][    C2]  refill_obj_stock+0x1a7/0x700
[  100.275719][    C2]  ? i_callback+0x43/0x70
[  100.278172][    C2]  kmem_cache_free+0x3b7/0x490
[  100.280699][    C2]  ? kmem_cache_free+0xf0/0x490
[  100.283254][    C2]  ? ext4_quota_read+0x330/0x330
[  100.285768][    C2]  i_callback+0x43/0x70
[  100.288218][    C2]  rcu_core+0x802/0x1c10
[  100.290606][    C2]  ? rcu_report_dead+0x610/0x610
[  100.293114][    C2]  ? io_schedule_timeout+0x150/0x150
[  100.295648][    C2]  __do_softirq+0x1d4/0x905
[  100.298053][    C2]  ? trace_event_raw_event_irq_handler_entry+0x260/0x260
[  100.300878][    C2]  run_ksoftirqd+0x31/0x60
[  100.303313][    C2]  smpboot_thread_fn+0x659/0x9e0
[  100.305793][    C2]  ? sort_range+0x30/0x30
[  100.308182][    C2]  kthread+0x344/0x440
[  100.310599][    C2]  ? kthread_complete_and_exit+0x40/0x40
[  100.313341][    C2]  ret_from_fork+0x1f/0x30
[  100.315866][    C2]  </TASK>
[  100.318085][    C2] Modules linked in:
[  100.320455][    C2] ---[ end trace 0000000000000000 ]---
[  100.323091][    C2] RIP: 0010:percpu_ref_get_many+0x4c/0x160
[  100.326060][    C2] Code: c7 c7 00 27 9a 8c e8 63 56 87 ff e8 9e 14 3f 08 5a 85 c0 0f 85 c2 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 fc 00 00 00 48 8b 03 a8 03 74 79 48 8d 7b 08 48
[  100.332943][    C2] RSP: 0018:ffffc90000a97c68 EFLAGS: 00010006
[  100.336057][    C2] RAX: dffffc0000000000 RBX: 000000000000e633 RCX: 0000000000000000
[  100.339290][    C2] RDX: 0000000000001cc6 RSI: 0000000000000101 RDI: ffffffff8c372a10
[  100.342422][    C2] RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff1d5366a
[  100.345565][    C2] R10: ffffffff8ea9b357 R11: 0000000000096001 R12: 000000000000e633
[  100.349021][    C2] R13: 0000000000000a08 R14: 0000000000000200 R15: ffff8880b9ab7fe0
[  100.352138][    C2] FS:  0000000000000000(0000) GS:ffff8880b9a80000(0000) knlGS:0000000000000000
[  100.355370][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  100.358108][    C2] CR2: 00007f4e04607c00 CR3: 000000012e4b0000 CR4: 00000000000106e0
[  100.361108][    C2] Kernel panic - not syncing: Fatal exception in interrupt
[  100.386146][    C2] Kernel Offset: disabled
[  100.388071][    C2] Rebooting in 10 seconds..
----------------------------------------

