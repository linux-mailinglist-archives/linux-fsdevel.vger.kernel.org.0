Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4716E6E5A15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 09:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjDRHHR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 03:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDRHHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:07:15 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B621BD8;
        Tue, 18 Apr 2023 00:07:13 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id l13so4021009uan.10;
        Tue, 18 Apr 2023 00:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681801632; x=1684393632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7ZW/gOUz1TfjQd0engsaKAOByMz9LYkFneVgfgL8vc=;
        b=kHLaeb6Xb2mntzAOoexF7TQ8JWdtS1234mUnKb/4KvlSSSGIZuRxbbAlNcYIUMsSyN
         HnaOsO0RAp6vIHGGZnBy5Y6LbG/8VF9G4hrH1aUoiPqpKDWHi9m54++FWYpkuRf9AP3j
         xyJ7PGUE2R4VEp/ggE6eSwFksQ5GA6qBp6nRrt+tQ2VMmwJytpUuVa27mnzjHx+cWLrj
         DjIE+zrTtG7p8gPsPTuDvj8P65Ej7jrhHivj+mmxc9umuXZLBcty5LlHPDknAe2TR+LE
         TF0nmRBLW4Ct5DeC367ldJvVCi3jvDJgqrTrC6Uim9LDjVHDLLk9UJsBJKyi5tiow93d
         sY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681801632; x=1684393632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7ZW/gOUz1TfjQd0engsaKAOByMz9LYkFneVgfgL8vc=;
        b=GURkJ9dNrK/hFAPSKPLK59Pkp8ijSH3N7xNQt05stY5Q95G/PrYRCEJevcAF9fUVEI
         QJdSkd0+Mjwg8wZRUb9iOtOuHQY1qRVzLvAWsmDSP1BLIeH2Ncerneeb7glPeJvBwWN/
         ryY9C5PySgT7aMSf8TfVt1bL8RmKhYdkcq/3pqvEUxN1DoS7pqHUNpOql+hurZ1ZRME4
         mf69gU7COmbeYzcEex4WubnGMxN83Hh6CiCqBWtwQKIyzDj/z8+7BR2N+B9vEvH+vnCt
         NOXpKLVlLkuri6T6P/qeob7PhEhH/CCmNxRIvz0mxvZY9qyH/NBJQtSKFzDAcaqjgfc7
         Qn3g==
X-Gm-Message-State: AAQBX9ePmUTVufLohHvg2Ndx6SXrlzPe5Mw7y6LU7KB9Xj3DW6jTIMgx
        3CznBjBA+WClSjN46HAcOuDcReF6PTzAoSwxkEI=
X-Google-Smtp-Source: AKy350ZGzlRJR3YTiilAY+jH5iJuFIKwjWeyOonJOyluEFJEEhUO94ycz0pwDuVeauMwTZmoTi8KEwhl07fJ/zys1TI=
X-Received: by 2002:a1f:e445:0:b0:43b:ead4:669e with SMTP id
 b66-20020a1fe445000000b0043bead4669emr4857690vkh.16.1681801631593; Tue, 18
 Apr 2023 00:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <CACsaVZJGPux1yhrMWnq+7nt3Zz5wZ6zEo2+S2pf=4czpYLFyjg@mail.gmail.com>
 <748833a7-290e-e028-7367-d3795466f5fd@gmx.com>
In-Reply-To: <748833a7-290e-e028-7367-d3795466f5fd@gmx.com>
From:   Kyle Sanderson <kyle.leet@gmail.com>
Date:   Tue, 18 Apr 2023 00:07:00 -0700
Message-ID: <CACsaVZKtrJ52OhjoLJWRBjT_CXw6zi_voP1mwLhQk0-wqgo2fw@mail.gmail.com>
Subject: Re: btrfs induced data loss (on xfs) - 5.19.0-38-generic
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 1:42=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
> And talking about the "100% utilization", did you mean a single CPU core
> is fully utilized by some btrfs thread?

No, iostat reporting the disk is at "100%" utilization.

> If so, it looks like qgroup is involved.
> Did you just recently deleted one or more snapshots? If so, it's almost
> certain qgroup is the cause of the 100% CPU utilization.

No, I used to run snapraid-btrfs (uses snapper) but both projects are
effectively orphaned. There's no snapshots left, but I used to run
zygo/bees also on these disks but that also has basic problems
(specifically mlock' on GBs of data when it's sitting completely idle
for hours at a time). bees was not running when this happened (or for
the duration of the uptime of the machine).

> In that case, you can disable quota for that btrfs (permanently), or use
> newer kernel which has a sysfs interface:
>
>    /sys/fs/btrfs/<UUID>/qgroups/drop_subtree_threshold

Thank you, I'll give it a go after the reboot here. I don't think I
have quotas enabled but I did look at it at one point (I remember
toggling on then off).

> If you write some value like 3 into that file, btrfs would automatically
> avoid such long CPU usage caused by large snapshot dropping.
>
> But talking about the XFS corruption, I'm not sure how btrfs can lead to
> problems in XFS...

All I/O seemed to be dead on the box.

I tried to remove the same data again and the task hung... this time I
was able to interrupt the removal and the box recovered.

[92798.210656] INFO: task sync:1282043 blocked for more than 120 seconds.
[92798.210683]       Not tainted 5.19.0-38-generic #39~22.04.1-Ubuntu
[92798.210707] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[92798.210735] task:sync            state:D stack:    0 pid:1282043
ppid:1281934 flags:0x00004002
[92798.210739] Call Trace:
[92798.210741]  <TASK>
[92798.210743]  __schedule+0x257/0x5d0
[92798.210747]  schedule+0x68/0x110
[92798.210750]  wait_current_trans+0xde/0x140 [btrfs]
[92798.210820]  ? destroy_sched_domains_rcu+0x40/0x40
[92798.210824]  start_transaction+0x34d/0x5f0 [btrfs]
[92798.210895]  btrfs_attach_transaction_barrier+0x23/0x70 [btrfs]
[92798.210966]  btrfs_sync_fs+0x4a/0x1c0 [btrfs]
[92798.211029]  ? vfs_fsync_range+0xa0/0xa0
[92798.211033]  sync_fs_one_sb+0x26/0x40
[92798.211037]  iterate_supers+0x9e/0x110
[92798.211041]  ksys_sync+0x62/0xb0
[92798.211045]  __do_sys_sync+0xe/0x20
[92798.211049]  do_syscall_64+0x59/0x90
[92798.211052]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[92798.211057] RIP: 0033:0x7fd08471babb
[92798.211059] RSP: 002b:00007ffd344545f8 EFLAGS: 00000246 ORIG_RAX:
00000000000000a2
[92798.211063] RAX: ffffffffffffffda RBX: 00007ffd344547d8 RCX: 00007fd0847=
1babb
[92798.211065] RDX: 00007fd084821101 RSI: 00007ffd344547d8 RDI: 00007fd0847=
d9e29
[92798.211067] RBP: 0000000000000001 R08: 0000000000000001 R09: 00000000000=
00000
[92798.211069] R10: 0000556ba8b21e40 R11: 0000000000000246 R12: 0000556ba8a=
cebc0
[92798.211071] R13: 0000556ba8acc19f R14: 00007fd08481942c R15: 0000556ba8a=
cc034
[92798.211075]  </TASK>

Kyle.

On Mon, Apr 17, 2023 at 1:42=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> On 2023/4/17 13:20, Kyle Sanderson wrote:
> > The single btrfs disk was at 100% utilization and a wa of 50~, reading
> > back at around 2MB/s. df and similar would simply freeze. Leading up
> > to this I removed around 2T of data from a single btrfs disk. I
> > managed to get most of the services shutdown and disks unmounted, but
> > when the system came back up I had to use xfs_repair (for the first
> > time in a very long time) to boot into my system. I likely should have
> > just pulled the power...
>
> I didn't see any obvious btrfs related work involved in the call trace.
> Thus I believe it's not really hanging in a waiting status.
>
> And talking about the "100% utilization", did you mean a single CPU core
> is fully utilized by some btrfs thread?
>
> If so, it looks like qgroup is involved.
> Did you just recently deleted one or more snapshots? If so, it's almost
> certain qgroup is the cause of the 100% CPU utilization.
>
> In that case, you can disable quota for that btrfs (permanently), or use
> newer kernel which has a sysfs interface:
>
>    /sys/fs/btrfs/<UUID>/qgroups/drop_subtree_threshold
>
> If you write some value like 3 into that file, btrfs would automatically
> avoid such long CPU usage caused by large snapshot dropping.
>
> But talking about the XFS corruption, I'm not sure how btrfs can lead to
> problems in XFS...
>
> Thanks,
> Qu
> >
> > [1147997.255020] INFO: task happywriter:3425205 blocked for more than
> > 120 seconds.
> > [1147997.255088]       Not tainted 5.19.0-38-generic #39~22.04.1-Ubuntu
> > [1147997.255114] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [1147997.255144] task:happywriter state:D stack:    0 pid:3425205
> > ppid:557021 flags:0x00004000
> > [1147997.255151] Call Trace:
> > [1147997.255155]  <TASK>
> > [1147997.255160]  __schedule+0x257/0x5d0
> > [1147997.255169]  ? __schedule+0x25f/0x5d0
> > [1147997.255173]  schedule+0x68/0x110
> > [1147997.255176]  rwsem_down_write_slowpath+0x2ee/0x5a0
> > [1147997.255180]  ? check_heap_object+0x100/0x1e0
> > [1147997.255185]  down_write+0x4f/0x70
> > [1147997.255189]  do_unlinkat+0x12b/0x2d0
> > [1147997.255194]  __x64_sys_unlink+0x42/0x70
> > [1147997.255197]  ? syscall_exit_to_user_mode+0x2a/0x50
> > [1147997.255201]  do_syscall_64+0x59/0x90
> > [1147997.255204]  ? do_syscall_64+0x69/0x90
> > [1147997.255207]  ? sysvec_call_function_single+0x4e/0xb0
> > [1147997.255211]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [1147997.255216] RIP: 0033:0x1202a57
> > [1147997.255220] RSP: 002b:00007fe467ffd4c8 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000057
> > [1147997.255224] RAX: ffffffffffffffda RBX: 00007fe3a4e94d28 RCX:
> > 0000000001202a57
> > [1147997.255226] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> > 00007fe450054b60
> > [1147997.255228] RBP: 00007fe450054b60 R08: 0000000000000000 R09:
> > 00000000000000e8
> > [1147997.255231] R10: 0000000000000001 R11: 0000000000000246 R12:
> > 00007fe467ffd5b0
> > [1147997.255233] R13: 00007fe467ffd5f0 R14: 00007fe467ffd5e0 R15:
> > 00007fe3a4e94d28
> > [1147997.255239]  </TASK>
> > [1148118.087966] INFO: task happywriter:3425205 blocked for more than
> > 241 seconds.
> > [1148118.088022]       Not tainted 5.19.0-38-generic #39~22.04.1-Ubuntu
> > [1148118.088048] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [1148118.088077] task:happywriter state:D stack:    0 pid:3425205
> > ppid:557021 flags:0x00004000
> > [1148118.088083] Call Trace:
> > [1148118.088087]  <TASK>
> > [1148118.088093]  __schedule+0x257/0x5d0
> > [1148118.088101]  ? __schedule+0x25f/0x5d0
> > [1148118.088105]  schedule+0x68/0x110
> > [1148118.088108]  rwsem_down_write_slowpath+0x2ee/0x5a0
> > [1148118.088113]  ? check_heap_object+0x100/0x1e0
> > [1148118.088118]  down_write+0x4f/0x70
> > [1148118.088121]  do_unlinkat+0x12b/0x2d0
> > [1148118.088126]  __x64_sys_unlink+0x42/0x70
> > [1148118.088129]  ? syscall_exit_to_user_mode+0x2a/0x50
> > [1148118.088133]  do_syscall_64+0x59/0x90
> > [1148118.088136]  ? do_syscall_64+0x69/0x90
> > [1148118.088139]  ? sysvec_call_function_single+0x4e/0xb0
> > [1148118.088142]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [1148118.088148] RIP: 0033:0x1202a57
> > [1148118.088151] RSP: 002b:00007fe467ffd4c8 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000057
> > [1148118.088155] RAX: ffffffffffffffda RBX: 00007fe3a4e94d28 RCX:
> > 0000000001202a57
> > [1148118.088158] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> > 00007fe450054b60
> > [1148118.088160] RBP: 00007fe450054b60 R08: 0000000000000000 R09:
> > 00000000000000e8
> > [1148118.088162] R10: 0000000000000001 R11: 0000000000000246 R12:
> > 00007fe467ffd5b0
> > [1148118.088164] R13: 00007fe467ffd5f0 R14: 00007fe467ffd5e0 R15:
> > 00007fe3a4e94d28
> > [1148118.088170]  </TASK>
> > [1148238.912688] INFO: task kcompactd0:70 blocked for more than 120 sec=
onds.
> > [1148238.912741]       Not tainted 5.19.0-38-generic #39~22.04.1-Ubuntu
> > [1148238.912767] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [1148238.912796] task:kcompactd0      state:D stack:    0 pid:   70
> > ppid:     2 flags:0x00004000
> > [1148238.912803] Call Trace:
> > [1148238.912806]  <TASK>
> > [1148238.912812]  __schedule+0x257/0x5d0
> > [1148238.912821]  schedule+0x68/0x110
> > [1148238.912824]  io_schedule+0x46/0x80
> > [1148238.912827]  folio_wait_bit_common+0x14c/0x3a0
> > [1148238.912833]  ? filemap_invalidate_unlock_two+0x50/0x50
> > [1148238.912838]  __folio_lock+0x17/0x30
> > [1148238.912842]  __unmap_and_move.constprop.0+0x39c/0x640
> > [1148238.912847]  ? free_unref_page+0xe3/0x190
> > [1148238.912852]  ? move_freelist_tail+0xe0/0xe0
> > [1148238.912855]  ? move_freelist_tail+0xe0/0xe0
> > [1148238.912858]  unmap_and_move+0x7d/0x4e0
> > [1148238.912862]  migrate_pages+0x3b8/0x770
> > [1148238.912867]  ? move_freelist_tail+0xe0/0xe0
> > [1148238.912870]  ? isolate_freepages+0x2f0/0x2f0
> > [1148238.912874]  compact_zone+0x2ca/0x620
> > [1148238.912878]  proactive_compact_node+0x8a/0xe0
> > [1148238.912883]  kcompactd+0x21c/0x4e0
> > [1148238.912886]  ? destroy_sched_domains_rcu+0x40/0x40
> > [1148238.912892]  ? kcompactd_do_work+0x240/0x240
> > [1148238.912896]  kthread+0xeb/0x120
> > [1148238.912900]  ? kthread_complete_and_exit+0x20/0x20
> > [1148238.912904]  ret_from_fork+0x1f/0x30
> > [1148238.912911]  </TASK>
> > [1148238.913163] INFO: task happywriter:3425205 blocked for more than
> > 362 seconds.
> > [1148238.913195]       Not tainted 5.19.0-38-generic #39~22.04.1-Ubuntu
> > [1148238.913220] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [1148238.913250] task:happywriter state:D stack:    0 pid:3425205
> > ppid:557021 flags:0x00004000
> > [1148238.913254] Call Trace:
> > [1148238.913256]  <TASK>
> > [1148238.913259]  __schedule+0x257/0x5d0
> > [1148238.913264]  ? __schedule+0x25f/0x5d0
> > [1148238.913267]  schedule+0x68/0x110
> > [1148238.913270]  rwsem_down_write_slowpath+0x2ee/0x5a0
> > [1148238.913276]  ? check_heap_object+0x100/0x1e0
> > [1148238.913280]  down_write+0x4f/0x70
> > [1148238.913284]  do_unlinkat+0x12b/0x2d0
> > [1148238.913288]  __x64_sys_unlink+0x42/0x70
> > [1148238.913292]  ? syscall_exit_to_user_mode+0x2a/0x50
> > [1148238.913296]  do_syscall_64+0x59/0x90
> > [1148238.913299]  ? do_syscall_64+0x69/0x90
> > [1148238.913301]  ? sysvec_call_function_single+0x4e/0xb0
> > [1148238.913305]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [1148238.913310] RIP: 0033:0x1202a57
> > [1148238.913315] RSP: 002b:00007fe467ffd4c8 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000057
> > [1148238.913319] RAX: ffffffffffffffda RBX: 00007fe3a4e94d28 RCX:
> > 0000000001202a57
> > [1148238.913321] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> > 00007fe450054b60
> > [1148238.913323] RBP: 00007fe450054b60 R08: 0000000000000000 R09:
> > 00000000000000e8
> > [1148238.913325] R10: 0000000000000001 R11: 0000000000000246 R12:
> > 00007fe467ffd5b0
> > [1148238.913328] R13: 00007fe467ffd5f0 R14: 00007fe467ffd5e0 R15:
> > 00007fe3a4e94d28
> > [1148238.913333]  </TASK>
> > [1148238.913429] INFO: task kworker/u16:20:3402199 blocked for more
> > than 120 seconds.
> > [1148238.913459]       Not tainted 5.19.0-38-generic #39~22.04.1-Ubuntu
> > [1148238.913496] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [1148238.913527] task:kworker/u16:20  state:D stack:    0 pid:3402199
> > ppid:     2 flags:0x00004000
> > [1148238.913533] Workqueue: events_unbound io_ring_exit_work
> > [1148238.913539] Call Trace:
> > [1148238.913541]  <TASK>
> > [1148238.913544]  __schedule+0x257/0x5d0
> > [1148238.913548]  schedule+0x68/0x110
> > [1148238.913551]  schedule_timeout+0x122/0x160
> > [1148238.913556]  __wait_for_common+0x8f/0x190
> > [1148238.913559]  ? usleep_range_state+0xa0/0xa0
> > [1148238.913564]  wait_for_completion+0x24/0x40
> > [1148238.913567]  io_ring_exit_work+0x186/0x1e9
> > [1148238.913571]  ? io_uring_del_tctx_node+0xbf/0xbf
> > [1148238.913576]  process_one_work+0x21c/0x400
> > [1148238.913579]  worker_thread+0x50/0x3f0
> > [1148238.913583]  ? rescuer_thread+0x3a0/0x3a0
> > [1148238.913586]  kthread+0xeb/0x120
> > [1148238.913590]  ? kthread_complete_and_exit+0x20/0x20
> > [1148238.913594]  ret_from_fork+0x1f/0x30
> > [1148238.913600]  </TASK>
> > [1148238.913607] INFO: task stat:3434604 blocked for more than 120 seco=
nds.
> > [1148238.913633]       Not tainted 5.19.0-38-generic #39~22.04.1-Ubuntu
> > [1148238.913658] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [1148238.913687] task:stat            state:D stack:    0 pid:3434604
> > ppid:3396625 flags:0x00004004
> > [1148238.913691] Call Trace:
> > [1148238.913693]  <TASK>
> > [1148238.913695]  __schedule+0x257/0x5d0
> > [1148238.913699]  schedule+0x68/0x110
> > [1148238.913703]  request_wait_answer+0x13f/0x220
> > [1148238.913708]  ? destroy_sched_domains_rcu+0x40/0x40
> > [1148238.913713]  fuse_simple_request+0x1bb/0x370
> > [1148238.913717]  fuse_do_getattr+0xda/0x320
> > [1148238.913720]  ? try_to_unlazy+0x5b/0xd0
> > [1148238.913726]  fuse_update_get_attr+0xb3/0xf0
> > [1148238.913730]  fuse_getattr+0x87/0xd0
> > [1148238.913733]  vfs_getattr_nosec+0xba/0x100
> > [1148238.913737]  vfs_statx+0xa9/0x140
> > [1148238.913741]  vfs_fstatat+0x59/0x80
> > [1148238.913744]  __do_sys_newlstat+0x38/0x80
> > [1148238.913750]  __x64_sys_newlstat+0x16/0x20
> > [1148238.913753]  do_syscall_64+0x59/0x90
> > [1148238.913757]  ? handle_mm_fault+0xba/0x2a0
> > [1148238.913761]  ? exit_to_user_mode_prepare+0xaf/0xd0
> > [1148238.913765]  ? irqentry_exit_to_user_mode+0x9/0x20
> > [1148238.913769]  ? irqentry_exit+0x43/0x50
> > [1148238.913772]  ? exc_page_fault+0x92/0x1b0
> > [1148238.913776]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [1148238.913780] RIP: 0033:0x7fa76960d6ea
> > [1148238.913783] RSP: 002b:00007ffe6d011878 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000006
> > [1148238.913787] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
> > 00007fa76960d6ea
> > [1148238.913789] RDX: 00007ffe6d011890 RSI: 00007ffe6d011890 RDI:
> > 00007ffe6d01290b
> > [1148238.913791] RBP: 00007ffe6d011a70 R08: 0000000000000001 R09:
> > 0000000000000000
> > [1148238.913793] R10: fffffffffffff3ce R11: 0000000000000246 R12:
> > 0000000000000000
> > [1148238.913795] R13: 000055feff0d2960 R14: 00007ffe6d011a68 R15:
> > 00007ffe6d01290b
> > [1148238.913800]  </TASK>
