Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54669DA57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 03:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfD2BjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Apr 2019 21:39:02 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60154 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfD2BjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Apr 2019 21:39:02 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3T1cRNp065575;
        Mon, 29 Apr 2019 10:38:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Mon, 29 Apr 2019 10:38:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3T1cMeq065555
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 29 Apr 2019 10:38:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in __get_super
To:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, dvyukov@google.com, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <001a113ed5540f411c0568cc8418@google.com>
 <0000000000002cd22305879b22c4@google.com>
 <20190428185109.GD23075@ZenIV.linux.org.uk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <6c7704c1-49cd-7338-e951-1c0281bc8e4b@i-love.sakura.ne.jp>
Date:   Mon, 29 Apr 2019 10:38:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428185109.GD23075@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/04/29 3:51, Al Viro wrote:
> ioctl(..., BLKRRPART) blocked on ->s_umount in __get_super().
> The trouble is, the only things holding ->s_umount appears to be
> these:

Not always true. lockdep_print_held_locks() from debug_show_all_locks() can not
report locks held by TASK_RUNNING threads. Due to enabling CONFIG_PRINTK_CALLER=y,
the output from trigger_all_cpu_backtrace() is no longer included into the report
file (i.e. premature truncation) because NMI backtrace is printed from a different
printk() context. If we check the console output, we can understand that

>> 1 lock held by syz-executor274/8083:

was doing mount(2). Since there is a possibility that that thread was looping for
many seconds enough to trigger khungtaskd warnings, we can't tell whether this is
a locking dependency problem.

----------------------------------------
[ 1107.252933][ T1041] NMI backtrace for cpu 0
[ 1107.257402][ T1041] CPU: 0 PID: 1041 Comm: khungtaskd Not tainted 5.1.0-rc6+ #89
[ 1107.264960][ T1041] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[ 1107.275380][ T1041] Call Trace:
[ 1107.278691][ T1041]  dump_stack+0x172/0x1f0
[ 1107.283216][ T1041]  nmi_cpu_backtrace.cold+0x63/0xa4
[ 1107.288469][ T1041]  ? lapic_can_unplug_cpu.cold+0x38/0x38
[ 1107.294155][ T1041]  nmi_trigger_cpumask_backtrace+0x1be/0x236
[ 1107.300256][ T1041]  arch_trigger_cpumask_backtrace+0x14/0x20
[ 1107.306174][ T1041]  watchdog+0x9b7/0xec0
[ 1107.310362][ T1041]  kthread+0x357/0x430
[ 1107.314446][ T1041]  ? reset_hung_task_detector+0x30/0x30
[ 1107.320016][ T1041]  ? kthread_cancel_delayed_work_sync+0x20/0x20
[ 1107.326280][ T1041]  ret_from_fork+0x3a/0x50
[ 1107.331403][ T1041] Sending NMI from CPU 0 to CPUs 1:
[ 1107.337617][    C1] NMI backtrace for cpu 1
[ 1107.337625][    C1] CPU: 1 PID: 8083 Comm: syz-executor274 Not tainted 5.1.0-rc6+ #89
[ 1107.337631][    C1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[ 1107.337636][    C1] RIP: 0010:debug_lockdep_rcu_enabled.part.0+0xb/0x60
[ 1107.337648][    C1] Code: 5b 5d c3 e8 67 71 e5 ff 0f 1f 80 00 00 00 00 55 48 89 e5 e8 37 ff ff ff 5d c3 0f 1f 44 00 00 48 b8 00 00 00 00 00 fc ff df 55 <48> 89 e5 53 65 48 8b 1c 25 00 ee 01 00 48 8d bb 7c 08 00 00 48 89
[ 1107.337652][    C1] RSP: 0018:ffff8880a85274c8 EFLAGS: 00000202
[ 1107.337661][    C1] RAX: dffffc0000000000 RBX: ffff8880a85275d8 RCX: 1ffffffff12bcd63
[ 1107.337666][    C1] RDX: 0000000000000000 RSI: ffffffff870d8f3c RDI: ffff8880a85275e0
[ 1107.337672][    C1] RBP: ffff8880a85274d8 R08: ffff888081e68540 R09: ffffed1015d25bc8
[ 1107.337677][    C1] R10: ffffed1015d25bc7 R11: ffff8880ae92de3b R12: 0000000000000000
[ 1107.337683][    C1] R13: ffff8880a694d640 R14: ffff88809541b942 R15: 0000000000000006
[ 1107.337689][    C1] FS:  0000000000e0b880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
[ 1107.337693][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1107.337699][    C1] CR2: ffffffffff600400 CR3: 0000000092d6f000 CR4: 00000000001406e0
[ 1107.337704][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1107.337710][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1107.337713][    C1] Call Trace:
[ 1107.337717][    C1]  ? debug_lockdep_rcu_enabled+0x71/0xa0
[ 1107.337721][    C1]  xas_descend+0xbf/0x370
[ 1107.337724][    C1]  xas_load+0xef/0x150
[ 1107.337728][    C1]  find_get_entry+0x13d/0x880
[ 1107.337733][    C1]  ? find_get_entries_tag+0xc10/0xc10
[ 1107.337736][    C1]  ? mark_held_locks+0xa4/0xf0
[ 1107.337741][    C1]  ? pagecache_get_page+0x1a8/0x740
[ 1107.337745][    C1]  pagecache_get_page+0x4c/0x740
[ 1107.337749][    C1]  __getblk_gfp+0x27e/0x970
[ 1107.337752][    C1]  __bread_gfp+0x2f/0x300
[ 1107.337756][    C1]  udf_tread+0xf1/0x140
[ 1107.337760][    C1]  udf_read_tagged+0x50/0x530
[ 1107.337764][    C1]  udf_check_anchor_block+0x1ef/0x680
[ 1107.337768][    C1]  ? blkpg_ioctl+0xa90/0xa90
[ 1107.337772][    C1]  ? udf_process_sequence+0x35d0/0x35d0
[ 1107.337776][    C1]  ? submit_bio+0xba/0x480
[ 1107.337780][    C1]  udf_scan_anchors+0x3f4/0x680
[ 1107.337784][    C1]  ? udf_check_anchor_block+0x680/0x680
[ 1107.337789][    C1]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[ 1107.337793][    C1]  ? udf_get_last_session+0x120/0x120
[ 1107.337797][    C1]  udf_load_vrs+0x67f/0xc80
[ 1107.337801][    C1]  ? udf_scan_anchors+0x680/0x680
[ 1107.337805][    C1]  ? udf_bread+0x260/0x260
[ 1107.337809][    C1]  ? lockdep_init_map+0x1be/0x6d0
[ 1107.337813][    C1]  udf_fill_super+0x7d8/0x16d1
[ 1107.337817][    C1]  ? udf_load_vrs+0xc80/0xc80
[ 1107.337820][    C1]  ? vsprintf+0x40/0x40
[ 1107.337824][    C1]  ? set_blocksize+0x2bf/0x340
[ 1107.337829][    C1]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[ 1107.337833][    C1]  mount_bdev+0x307/0x3c0
[ 1107.337837][    C1]  ? udf_load_vrs+0xc80/0xc80
[ 1107.337840][    C1]  udf_mount+0x35/0x40
[ 1107.337844][    C1]  ? udf_get_pblock_meta25+0x3a0/0x3a0
[ 1107.337848][    C1]  legacy_get_tree+0xf2/0x200
[ 1107.337853][    C1]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[ 1107.337857][    C1]  vfs_get_tree+0x123/0x450
[ 1107.337860][    C1]  do_mount+0x1436/0x2c40
[ 1107.337864][    C1]  ? copy_mount_string+0x40/0x40
[ 1107.337868][    C1]  ? _copy_from_user+0xdd/0x150
[ 1107.337873][    C1]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[ 1107.337877][    C1]  ? copy_mount_options+0x280/0x3a0
[ 1107.337881][    C1]  ksys_mount+0xdb/0x150
[ 1107.337885][    C1]  __x64_sys_mount+0xbe/0x150
[ 1107.337889][    C1]  do_syscall_64+0x103/0x610
[ 1107.337893][    C1]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1107.337897][    C1] RIP: 0033:0x441a49
[ 1107.337909][    C1] Code: ad 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
[ 1107.337913][    C1] RSP: 002b:00007ffcabed5048 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[ 1107.337923][    C1] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441a49
[ 1107.337929][    C1] RDX: 0000000020000140 RSI: 0000000020000080 RDI: 0000000020000000
[ 1107.337934][    C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 1107.337940][    C1] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[ 1107.337946][    C1] R13: 00000000004026e0 R14: 0000000000000000 R15: 0000000000000000
[ 1107.339387][ T1041] Kernel panic - not syncing: hung_task: blocked tasks
[ 1107.787589][ T1041] CPU: 0 PID: 1041 Comm: khungtaskd Not tainted 5.1.0-rc6+ #89
[ 1107.795319][ T1041] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[ 1107.806082][ T1041] Call Trace:
[ 1107.809403][ T1041]  dump_stack+0x172/0x1f0
[ 1107.813776][ T1041]  panic+0x2cb/0x65c
[ 1107.817695][ T1041]  ? __warn_printk+0xf3/0xf3
[ 1107.822391][ T1041]  ? lapic_can_unplug_cpu.cold+0x38/0x38
[ 1107.828236][ T1041]  ? ___preempt_schedule+0x16/0x18
[ 1107.833386][ T1041]  ? nmi_trigger_cpumask_backtrace+0x19e/0x236
[ 1107.839739][ T1041]  ? nmi_trigger_cpumask_backtrace+0x1fa/0x236
[ 1107.846024][ T1041]  ? nmi_trigger_cpumask_backtrace+0x204/0x236
[ 1107.852196][ T1041]  ? nmi_trigger_cpumask_backtrace+0x19e/0x236
[ 1107.858482][ T1041]  watchdog+0x9c8/0xec0
[ 1107.862858][ T1041]  kthread+0x357/0x430
[ 1107.866943][ T1041]  ? reset_hung_task_detector+0x30/0x30
[ 1107.872522][ T1041]  ? kthread_cancel_delayed_work_sync+0x20/0x20
[ 1107.878799][ T1041]  ret_from_fork+0x3a/0x50
[ 1107.884924][ T1041] Kernel Offset: disabled
[ 1107.889301][ T1041] Rebooting in 86400 seconds..
----------------------------------------

I don't know whether "it is not safe to print locks held by TASK_RUNNING threads"
remains true. But since a thread's state can change at any moment, there is no
guarantee that only locks held by !TASK_RUNNING threads will be printed by
debug_show_all_locks(), I guess that allow printing all locks at their own risk
using some kernel config is fine...

Also, we could replace trigger_all_cpu_backtrace() with a new function which scans
all threads and dumps threads with ->on_cpu == 1 so that the output comes from
the same printk() context.
