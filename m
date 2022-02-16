Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272094B7F3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 05:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343930AbiBPEPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 23:15:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343661AbiBPEPi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:15:38 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09E04100752
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 20:15:24 -0800 (PST)
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.51 with ESMTP; 16 Feb 2022 13:15:23 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.127 with ESMTP; 16 Feb 2022 13:15:23 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, willy@infradead.org,
        david@fromorbit.com, amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Report in ext4_file_write_iter()
Date:   Wed, 16 Feb 2022 13:15:15 +0900
Message-Id: <1644984918-27955-3-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1644984918-27955-1-git-send-email-byungchul.park@lge.com>
References: <1644984711-26423-1-git-send-email-byungchul.park@lge.com>
 <1644984918-27955-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[    6.881168] ===================================================
[    6.881170] DEPT: Circular dependency has been detected.
[    6.881172] 5.17.0-rc1-00014-gcf3441bb2012 #2 Tainted: G        W        
[    6.881173] ---------------------------------------------------
[    6.881174] summary
[    6.881174] ---------------------------------------------------
[    6.881175] *** DEADLOCK ***
[    6.881175] 
[    6.881176] context A
[    6.881176]     [S] (unknown)(&(&journal->j_wait_commit)->dmap:0)
[    6.881178]     [W] down_write(mapping.invalidate_lock:0)
[    6.881179]     [E] event(&(&journal->j_wait_commit)->dmap:0)
[    6.881180] 
[    6.881181] context B
[    6.881182]     [S] __raw_write_lock(&journal->j_state_lock:8)
[    6.881183]     [W] wait(&(&journal->j_wait_commit)->dmap:0)
[    6.881184]     [E] write_unlock(&journal->j_state_lock:8)
[    6.881185] 
[    6.881185] context C
[    6.881186]     [S] down_write(mapping.invalidate_lock:0)
[    6.881187]     [W] __raw_read_lock(&journal->j_state_lock:8)
[    6.881188]     [E] up_write(mapping.invalidate_lock:0)
[    6.881189] 
[    6.881190] [S]: start of the event context
[    6.881190] [W]: the wait blocked
[    6.881191] [E]: the event not reachable
[    6.881191] ---------------------------------------------------
[    6.881192] context A's detail
[    6.881193] ---------------------------------------------------
[    6.881193] context A
[    6.881194]     [S] (unknown)(&(&journal->j_wait_commit)->dmap:0)
[    6.881195]     [W] down_write(mapping.invalidate_lock:0)
[    6.881196]     [E] event(&(&journal->j_wait_commit)->dmap:0)
[    6.881197] 
[    6.881198] [S] (unknown)(&(&journal->j_wait_commit)->dmap:0):
[    6.881199] (N/A)
[    6.881199] 
[    6.881200] [W] down_write(mapping.invalidate_lock:0):
[    6.881201] [<ffffffff812f7cc3>] ext4_da_write_begin+0x183/0x2a0
[    6.881207] stacktrace:
[    6.881207]       down_write+0x68/0x580
[    6.881210]       ext4_da_write_begin+0x183/0x2a0
[    6.881213]       generic_perform_write+0xa6/0x1c0
[    6.881215]       ext4_buffered_write_iter+0x89/0x100
[    6.881219]       ext4_file_write_iter+0x4a/0x7f0
[    6.881222]       new_sync_write+0x100/0x190
[    6.881225]       vfs_write+0x134/0x360
[    6.881228]       ksys_write+0x4d/0xc0
[    6.881230]       do_syscall_64+0x3a/0x90
[    6.881233]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[    6.881236] 
[    6.881237] [E] event(&(&journal->j_wait_commit)->dmap:0):
[    6.881238] [<ffffffff810baa53>] __wake_up_common+0x93/0x1a0
[    6.881240] stacktrace:
[    6.881240]       dept_event+0x12b/0x1f0
[    6.881243]       __wake_up_common+0xb0/0x1a0
[    6.881244]       __wake_up_common_lock+0x65/0x90
[    6.881246]       __jbd2_log_start_commit+0x8a/0xa0
[    6.881248]       jbd2_log_start_commit+0x24/0x40
[    6.881250]       __jbd2_journal_force_commit+0x91/0xb0
[    6.881251]       jbd2_journal_force_commit_nested+0x5/0x10
[    6.881253]       ext4_should_retry_alloc+0x5b/0xb0
[    6.881254]       ext4_da_write_begin+0xf2/0x2a0
[    6.881256]       generic_perform_write+0xa6/0x1c0
[    6.881258]       ext4_buffered_write_iter+0x89/0x100
[    6.881260]       ext4_file_write_iter+0x4a/0x7f0
[    6.881262]       new_sync_write+0x100/0x190
[    6.881264]       vfs_write+0x134/0x360
[    6.881265]       ksys_write+0x4d/0xc0
[    6.881267]       do_syscall_64+0x3a/0x90
[    6.881268] ---------------------------------------------------
[    6.881269] context B's detail
[    6.881270] ---------------------------------------------------
[    6.881270] context B
[    6.881271]     [S] __raw_write_lock(&journal->j_state_lock:8)
[    6.881272]     [W] wait(&(&journal->j_wait_commit)->dmap:0)
[    6.881273]     [E] write_unlock(&journal->j_state_lock:8)
[    6.881274] 
[    6.881275] [S] __raw_write_lock(&journal->j_state_lock:8):
[    6.881276] [<ffffffff81346e9e>] kjournald2+0x7e/0x260
[    6.881277] stacktrace:
[    6.881278]       _raw_write_lock+0x6e/0x90
[    6.881280]       kjournald2+0x7e/0x260
[    6.881281]       kthread+0xe3/0x110
[    6.881287]       ret_from_fork+0x22/0x30
[    6.881290] 
[    6.881290] [W] wait(&(&journal->j_wait_commit)->dmap:0):
[    6.881291] [<ffffffff810bb017>] prepare_to_wait+0x47/0xd0
[    6.881293] stacktrace:
[    6.881294]       kjournald2+0x164/0x260
[    6.881295]       kthread+0xe3/0x110
[    6.881297]       ret_from_fork+0x22/0x30
[    6.881298] 
[    6.881299] [E] write_unlock(&journal->j_state_lock:8):
[    6.881300] [<ffffffff8134700b>] kjournald2+0x1eb/0x260
[    6.881301] stacktrace:
[    6.881302]       _raw_write_unlock+0x30/0x70
[    6.881304]       kjournald2+0x1eb/0x260
[    6.881305]       kthread+0xe3/0x110
[    6.881307]       ret_from_fork+0x22/0x30
[    6.881308] ---------------------------------------------------
[    6.881309] context C's detail
[    6.881309] ---------------------------------------------------
[    6.881310] context C
[    6.881311]     [S] down_write(mapping.invalidate_lock:0)
[    6.881312]     [W] __raw_read_lock(&journal->j_state_lock:8)
[    6.881313]     [E] up_write(mapping.invalidate_lock:0)
[    6.881314] 
[    6.881314] [S] down_write(mapping.invalidate_lock:0):
[    6.881315] [<ffffffff812f94db>] ext4_setattr+0x3eb/0x8f0
[    6.881317] stacktrace:
[    6.881318]       down_write+0x8a/0x580
[    6.881319]       ext4_setattr+0x3eb/0x8f0
[    6.881321]       notify_change+0x352/0x4c0
[    6.881323]       do_truncate+0x6a/0xa0
[    6.881325]       path_openat+0x646/0x9c0
[    6.881327]       do_filp_open+0xaf/0x110
[    6.881329]       do_sys_openat2+0x1ff/0x300
[    6.881330]       do_sys_open+0x51/0x60
[    6.881332]       do_syscall_64+0x3a/0x90
[    6.881333]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[    6.881335] 
[    6.881336] [W] __raw_read_lock(&journal->j_state_lock:8):
[    6.881337] [<ffffffff8133cd87>] start_this_handle+0xa7/0x5e0
[    6.881340] stacktrace:
[    6.881340]       _raw_read_lock+0x57/0xd0
[    6.881342]       start_this_handle+0xa7/0x5e0
[    6.881344]       jbd2__journal_start+0xe6/0x220
[    6.881345]       __ext4_journal_start_sb+0x11c/0x150
[    6.881347]       ext4_setattr+0x436/0x8f0
[    6.881349]       notify_change+0x352/0x4c0
[    6.881350]       do_truncate+0x6a/0xa0
[    6.881352]       path_openat+0x646/0x9c0
[    6.881353]       do_filp_open+0xaf/0x110
[    6.881355]       do_sys_openat2+0x1ff/0x300
[    6.881356]       do_sys_open+0x51/0x60
[    6.881358]       do_syscall_64+0x3a/0x90
[    6.881360]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[    6.881362] 
[    6.881362] [E] up_write(mapping.invalidate_lock:0):
[    6.881363] [<ffffffff812f982f>] ext4_setattr+0x73f/0x8f0
[    6.881365] stacktrace:
[    6.881365]       up_write+0x36/0x170
[    6.881369]       ext4_setattr+0x73f/0x8f0
[    6.881370]       notify_change+0x352/0x4c0
[    6.881372]       do_truncate+0x6a/0xa0
[    6.881373]       path_openat+0x646/0x9c0
[    6.881375]       do_filp_open+0xaf/0x110
[    6.881376]       do_sys_openat2+0x1ff/0x300
[    6.881378]       do_sys_open+0x51/0x60
[    6.881379]       do_syscall_64+0x3a/0x90
[    6.881381]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[    6.881383] ---------------------------------------------------
[    6.881383] information that might be helpful
[    6.881384] ---------------------------------------------------
[    6.881385] CPU: 2 PID: 628 Comm: rs:main Q:Reg Tainted: G        W         5.17.0-rc1-00014-gcf3441bb2012 #2
[    6.881387] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[    6.881389] Call Trace:
[    6.881390]  <TASK>
[    6.881391]  dump_stack_lvl+0x44/0x57
[    6.881394]  print_circle+0x384/0x510
[    6.881396]  ? __kernel_text_address+0x9/0x30
[    6.881398]  ? print_circle+0x510/0x510
[    6.881400]  cb_check_dl+0x58/0x60
[    6.881401]  bfs+0xdc/0x1b0
[    6.881404]  add_dep+0x94/0x120
[    6.881406]  do_event.isra.22+0x284/0x300
[    6.881408]  ? __wake_up_common+0x93/0x1a0
[    6.881409]  dept_event+0x12b/0x1f0
[    6.881411]  __wake_up_common+0xb0/0x1a0
[    6.881413]  __wake_up_common_lock+0x65/0x90
[    6.881415]  __jbd2_log_start_commit+0x8a/0xa0
[    6.881417]  jbd2_log_start_commit+0x24/0x40
[    6.881419]  __jbd2_journal_force_commit+0x91/0xb0
[    6.881421]  jbd2_journal_force_commit_nested+0x5/0x10
[    6.881422]  ext4_should_retry_alloc+0x5b/0xb0
[    6.881424]  ext4_da_write_begin+0xf2/0x2a0
[    6.881427]  generic_perform_write+0xa6/0x1c0
[    6.881429]  ext4_buffered_write_iter+0x89/0x100
[    6.881432]  ext4_file_write_iter+0x4a/0x7f0
[    6.881435]  new_sync_write+0x100/0x190
[    6.881438]  vfs_write+0x134/0x360
[    6.881441]  ksys_write+0x4d/0xc0
[    6.881442]  ? trace_hardirqs_on+0x38/0xe0
[    6.881445]  do_syscall_64+0x3a/0x90
[    6.881447]  entry_SYSCALL_64_after_hwframe+0x44/0xae
