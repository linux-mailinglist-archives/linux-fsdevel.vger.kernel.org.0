Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1AE6E3ED8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 07:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDQFVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 01:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjDQFU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 01:20:59 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3342F199C;
        Sun, 16 Apr 2023 22:20:58 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id g187so6834486vsc.10;
        Sun, 16 Apr 2023 22:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681708857; x=1684300857;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FWIMVeJcxCIoiBHSDkBOm+Ya1JPbRMCH/iYS8X+ff7o=;
        b=UfhBFTCGjJDtE4hG2gPAdUL/Jwn1itJg2HlqODibc9d5pA7Xz3Scu7/jrb3QU0sBxb
         RBUSjqtNxOxhCzonDGBClaiFd1f2hWakzreDe7vR4tMj7n5KMN/kxTVzTLv2avY6Rn7R
         n78yC+BcDzjHsUB3xlqW5Uo+dF7/suechbpSigvL1AzB07Dl5xKOr8UMwC2ZEvuMmLiB
         Z++ocKqIbIEwwY5h65JqVT9zNnUiFyR9puMFWfU1tJful9DFRrYHP0N0CFNurqG6vek+
         9KvBNDvOH14RcS9PO3EVrD+/PZ3aHK5KNMwSeeDLEPcJ2DgeSmMy4f740dnrsTOsrm38
         zaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681708857; x=1684300857;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWIMVeJcxCIoiBHSDkBOm+Ya1JPbRMCH/iYS8X+ff7o=;
        b=jsEZ10wAU+kllwpFbi+Jsl3hPKADvE0uJYrUqiP4FDEn//o3ZK6rkY5Yr7GxHTsynW
         VI7QJ1tQ4IzeOjOMHcahVk0Y8FvmzH7hfxDu8FWPlxhDboOJLqf7NxqF+kupnIcyTIva
         OKcerCmk6tgWKueeEyTqDb4t2xqVSn7yD+d/EFw66c5dxkJGtyIyHDHyAMwODcpxXqAi
         GOeCsWhooo5Tg5uAGx9L2GMxcg0LObigpHpGdsXfh+T2lNGXbXxiWe6iYsesCfFDaJ2X
         7O4feW/QOSl72/dPW/y+rk2p6vxTfArT9w1loebpztjE2n4a5IxAZ/9RbRBkrioK5PSY
         meJg==
X-Gm-Message-State: AAQBX9dGJcUoOpZaT04vR42U3tMSyL3zd48by/QRvsgDsWpfPZ0n9gOQ
        GcvXHV4bpX3PLapt16a8LanJl8awbAQe8FLyB3PaoZW2pRw=
X-Google-Smtp-Source: AKy350a7EtOV/FYuYDWym0qIG2vdPJ+z4uXcwiQmgQx+MJymS0N/ICHYMizAcoXHiO6UU5TsWvBfjGYzlgZs2wbhCxw=
X-Received: by 2002:a67:d915:0:b0:42f:a82e:5289 with SMTP id
 t21-20020a67d915000000b0042fa82e5289mr1339859vsj.5.1681708856979; Sun, 16 Apr
 2023 22:20:56 -0700 (PDT)
MIME-Version: 1.0
From:   Kyle Sanderson <kyle.leet@gmail.com>
Date:   Sun, 16 Apr 2023 22:20:45 -0700
Message-ID: <CACsaVZJGPux1yhrMWnq+7nt3Zz5wZ6zEo2+S2pf=4czpYLFyjg@mail.gmail.com>
Subject: btrfs induced data loss (on xfs) - 5.19.0-38-generic
To:     linux-btrfs@vger.kernel.org
Cc:     Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The single btrfs disk was at 100% utilization and a wa of 50~, reading
back at around 2MB/s. df and similar would simply freeze. Leading up
to this I removed around 2T of data from a single btrfs disk. I
managed to get most of the services shutdown and disks unmounted, but
when the system came back up I had to use xfs_repair (for the first
time in a very long time) to boot into my system. I likely should have
just pulled the power...

[1147997.255020] INFO: task happywriter:3425205 blocked for more than
120 seconds.
[1147997.255088]       Not tainted 5.19.0-38-generic #39~22.04.1-Ubuntu
[1147997.255114] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[1147997.255144] task:happywriter state:D stack:    0 pid:3425205
ppid:557021 flags:0x00004000
[1147997.255151] Call Trace:
[1147997.255155]  <TASK>
[1147997.255160]  __schedule+0x257/0x5d0
[1147997.255169]  ? __schedule+0x25f/0x5d0
[1147997.255173]  schedule+0x68/0x110
[1147997.255176]  rwsem_down_write_slowpath+0x2ee/0x5a0
[1147997.255180]  ? check_heap_object+0x100/0x1e0
[1147997.255185]  down_write+0x4f/0x70
[1147997.255189]  do_unlinkat+0x12b/0x2d0
[1147997.255194]  __x64_sys_unlink+0x42/0x70
[1147997.255197]  ? syscall_exit_to_user_mode+0x2a/0x50
[1147997.255201]  do_syscall_64+0x59/0x90
[1147997.255204]  ? do_syscall_64+0x69/0x90
[1147997.255207]  ? sysvec_call_function_single+0x4e/0xb0
[1147997.255211]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[1147997.255216] RIP: 0033:0x1202a57
[1147997.255220] RSP: 002b:00007fe467ffd4c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000057
[1147997.255224] RAX: ffffffffffffffda RBX: 00007fe3a4e94d28 RCX:
0000000001202a57
[1147997.255226] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
00007fe450054b60
[1147997.255228] RBP: 00007fe450054b60 R08: 0000000000000000 R09:
00000000000000e8
[1147997.255231] R10: 0000000000000001 R11: 0000000000000246 R12:
00007fe467ffd5b0
[1147997.255233] R13: 00007fe467ffd5f0 R14: 00007fe467ffd5e0 R15:
00007fe3a4e94d28
[1147997.255239]  </TASK>
[1148118.087966] INFO: task happywriter:3425205 blocked for more than
241 seconds.
[1148118.088022]       Not tainted 5.19.0-38-generic #39~22.04.1-Ubuntu
[1148118.088048] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[1148118.088077] task:happywriter state:D stack:    0 pid:3425205
ppid:557021 flags:0x00004000
[1148118.088083] Call Trace:
[1148118.088087]  <TASK>
[1148118.088093]  __schedule+0x257/0x5d0
[1148118.088101]  ? __schedule+0x25f/0x5d0
[1148118.088105]  schedule+0x68/0x110
[1148118.088108]  rwsem_down_write_slowpath+0x2ee/0x5a0
[1148118.088113]  ? check_heap_object+0x100/0x1e0
[1148118.088118]  down_write+0x4f/0x70
[1148118.088121]  do_unlinkat+0x12b/0x2d0
[1148118.088126]  __x64_sys_unlink+0x42/0x70
[1148118.088129]  ? syscall_exit_to_user_mode+0x2a/0x50
[1148118.088133]  do_syscall_64+0x59/0x90
[1148118.088136]  ? do_syscall_64+0x69/0x90
[1148118.088139]  ? sysvec_call_function_single+0x4e/0xb0
[1148118.088142]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[1148118.088148] RIP: 0033:0x1202a57
[1148118.088151] RSP: 002b:00007fe467ffd4c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000057
[1148118.088155] RAX: ffffffffffffffda RBX: 00007fe3a4e94d28 RCX:
0000000001202a57
[1148118.088158] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
00007fe450054b60
[1148118.088160] RBP: 00007fe450054b60 R08: 0000000000000000 R09:
00000000000000e8
[1148118.088162] R10: 0000000000000001 R11: 0000000000000246 R12:
00007fe467ffd5b0
[1148118.088164] R13: 00007fe467ffd5f0 R14: 00007fe467ffd5e0 R15:
00007fe3a4e94d28
[1148118.088170]  </TASK>
[1148238.912688] INFO: task kcompactd0:70 blocked for more than 120 seconds.
[1148238.912741]       Not tainted 5.19.0-38-generic #39~22.04.1-Ubuntu
[1148238.912767] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[1148238.912796] task:kcompactd0      state:D stack:    0 pid:   70
ppid:     2 flags:0x00004000
[1148238.912803] Call Trace:
[1148238.912806]  <TASK>
[1148238.912812]  __schedule+0x257/0x5d0
[1148238.912821]  schedule+0x68/0x110
[1148238.912824]  io_schedule+0x46/0x80
[1148238.912827]  folio_wait_bit_common+0x14c/0x3a0
[1148238.912833]  ? filemap_invalidate_unlock_two+0x50/0x50
[1148238.912838]  __folio_lock+0x17/0x30
[1148238.912842]  __unmap_and_move.constprop.0+0x39c/0x640
[1148238.912847]  ? free_unref_page+0xe3/0x190
[1148238.912852]  ? move_freelist_tail+0xe0/0xe0
[1148238.912855]  ? move_freelist_tail+0xe0/0xe0
[1148238.912858]  unmap_and_move+0x7d/0x4e0
[1148238.912862]  migrate_pages+0x3b8/0x770
[1148238.912867]  ? move_freelist_tail+0xe0/0xe0
[1148238.912870]  ? isolate_freepages+0x2f0/0x2f0
[1148238.912874]  compact_zone+0x2ca/0x620
[1148238.912878]  proactive_compact_node+0x8a/0xe0
[1148238.912883]  kcompactd+0x21c/0x4e0
[1148238.912886]  ? destroy_sched_domains_rcu+0x40/0x40
[1148238.912892]  ? kcompactd_do_work+0x240/0x240
[1148238.912896]  kthread+0xeb/0x120
[1148238.912900]  ? kthread_complete_and_exit+0x20/0x20
[1148238.912904]  ret_from_fork+0x1f/0x30
[1148238.912911]  </TASK>
[1148238.913163] INFO: task happywriter:3425205 blocked for more than
362 seconds.
[1148238.913195]       Not tainted 5.19.0-38-generic #39~22.04.1-Ubuntu
[1148238.913220] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[1148238.913250] task:happywriter state:D stack:    0 pid:3425205
ppid:557021 flags:0x00004000
[1148238.913254] Call Trace:
[1148238.913256]  <TASK>
[1148238.913259]  __schedule+0x257/0x5d0
[1148238.913264]  ? __schedule+0x25f/0x5d0
[1148238.913267]  schedule+0x68/0x110
[1148238.913270]  rwsem_down_write_slowpath+0x2ee/0x5a0
[1148238.913276]  ? check_heap_object+0x100/0x1e0
[1148238.913280]  down_write+0x4f/0x70
[1148238.913284]  do_unlinkat+0x12b/0x2d0
[1148238.913288]  __x64_sys_unlink+0x42/0x70
[1148238.913292]  ? syscall_exit_to_user_mode+0x2a/0x50
[1148238.913296]  do_syscall_64+0x59/0x90
[1148238.913299]  ? do_syscall_64+0x69/0x90
[1148238.913301]  ? sysvec_call_function_single+0x4e/0xb0
[1148238.913305]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[1148238.913310] RIP: 0033:0x1202a57
[1148238.913315] RSP: 002b:00007fe467ffd4c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000057
[1148238.913319] RAX: ffffffffffffffda RBX: 00007fe3a4e94d28 RCX:
0000000001202a57
[1148238.913321] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
00007fe450054b60
[1148238.913323] RBP: 00007fe450054b60 R08: 0000000000000000 R09:
00000000000000e8
[1148238.913325] R10: 0000000000000001 R11: 0000000000000246 R12:
00007fe467ffd5b0
[1148238.913328] R13: 00007fe467ffd5f0 R14: 00007fe467ffd5e0 R15:
00007fe3a4e94d28
[1148238.913333]  </TASK>
[1148238.913429] INFO: task kworker/u16:20:3402199 blocked for more
than 120 seconds.
[1148238.913459]       Not tainted 5.19.0-38-generic #39~22.04.1-Ubuntu
[1148238.913496] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[1148238.913527] task:kworker/u16:20  state:D stack:    0 pid:3402199
ppid:     2 flags:0x00004000
[1148238.913533] Workqueue: events_unbound io_ring_exit_work
[1148238.913539] Call Trace:
[1148238.913541]  <TASK>
[1148238.913544]  __schedule+0x257/0x5d0
[1148238.913548]  schedule+0x68/0x110
[1148238.913551]  schedule_timeout+0x122/0x160
[1148238.913556]  __wait_for_common+0x8f/0x190
[1148238.913559]  ? usleep_range_state+0xa0/0xa0
[1148238.913564]  wait_for_completion+0x24/0x40
[1148238.913567]  io_ring_exit_work+0x186/0x1e9
[1148238.913571]  ? io_uring_del_tctx_node+0xbf/0xbf
[1148238.913576]  process_one_work+0x21c/0x400
[1148238.913579]  worker_thread+0x50/0x3f0
[1148238.913583]  ? rescuer_thread+0x3a0/0x3a0
[1148238.913586]  kthread+0xeb/0x120
[1148238.913590]  ? kthread_complete_and_exit+0x20/0x20
[1148238.913594]  ret_from_fork+0x1f/0x30
[1148238.913600]  </TASK>
[1148238.913607] INFO: task stat:3434604 blocked for more than 120 seconds.
[1148238.913633]       Not tainted 5.19.0-38-generic #39~22.04.1-Ubuntu
[1148238.913658] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[1148238.913687] task:stat            state:D stack:    0 pid:3434604
ppid:3396625 flags:0x00004004
[1148238.913691] Call Trace:
[1148238.913693]  <TASK>
[1148238.913695]  __schedule+0x257/0x5d0
[1148238.913699]  schedule+0x68/0x110
[1148238.913703]  request_wait_answer+0x13f/0x220
[1148238.913708]  ? destroy_sched_domains_rcu+0x40/0x40
[1148238.913713]  fuse_simple_request+0x1bb/0x370
[1148238.913717]  fuse_do_getattr+0xda/0x320
[1148238.913720]  ? try_to_unlazy+0x5b/0xd0
[1148238.913726]  fuse_update_get_attr+0xb3/0xf0
[1148238.913730]  fuse_getattr+0x87/0xd0
[1148238.913733]  vfs_getattr_nosec+0xba/0x100
[1148238.913737]  vfs_statx+0xa9/0x140
[1148238.913741]  vfs_fstatat+0x59/0x80
[1148238.913744]  __do_sys_newlstat+0x38/0x80
[1148238.913750]  __x64_sys_newlstat+0x16/0x20
[1148238.913753]  do_syscall_64+0x59/0x90
[1148238.913757]  ? handle_mm_fault+0xba/0x2a0
[1148238.913761]  ? exit_to_user_mode_prepare+0xaf/0xd0
[1148238.913765]  ? irqentry_exit_to_user_mode+0x9/0x20
[1148238.913769]  ? irqentry_exit+0x43/0x50
[1148238.913772]  ? exc_page_fault+0x92/0x1b0
[1148238.913776]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[1148238.913780] RIP: 0033:0x7fa76960d6ea
[1148238.913783] RSP: 002b:00007ffe6d011878 EFLAGS: 00000246 ORIG_RAX:
0000000000000006
[1148238.913787] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
00007fa76960d6ea
[1148238.913789] RDX: 00007ffe6d011890 RSI: 00007ffe6d011890 RDI:
00007ffe6d01290b
[1148238.913791] RBP: 00007ffe6d011a70 R08: 0000000000000001 R09:
0000000000000000
[1148238.913793] R10: fffffffffffff3ce R11: 0000000000000246 R12:
0000000000000000
[1148238.913795] R13: 000055feff0d2960 R14: 00007ffe6d011a68 R15:
00007ffe6d01290b
[1148238.913800]  </TASK>
