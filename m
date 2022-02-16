Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7064B7F37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 05:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343797AbiBPEPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 23:15:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbiBPEPi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:15:38 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D295DFFFAF
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 20:15:24 -0800 (PST)
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.52 with ESMTP; 16 Feb 2022 13:15:23 +0900
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
Subject: Report in ext4_da_write_begin()
Date:   Wed, 16 Feb 2022 13:15:14 +0900
Message-Id: <1644984918-27955-2-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1644984918-27955-1-git-send-email-byungchul.park@lge.com>
References: <1644984711-26423-1-git-send-email-byungchul.park@lge.com>
 <1644984918-27955-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[    6.881473] ===================================================
[    6.881474] DEPT: Circular dependency has been detected.
[    6.881475] 5.17.0-rc1-00014-gcf3441bb2012 #2 Tainted: G        W        
[    6.881476] ---------------------------------------------------
[    6.881476] summary
[    6.881477] ---------------------------------------------------
[    6.881478] *** DEADLOCK ***
[    6.881478] 
[    6.881478] context A
[    6.881479]     [S] (unknown)(&(&journal->j_wait_commit)->dmap:0)
[    6.881480]     [W] __raw_read_lock(&journal->j_state_lock:8)
[    6.881481]     [E] event(&(&journal->j_wait_commit)->dmap:0)
[    6.881482] 
[    6.881483] context B
[    6.881483]     [S] __raw_write_lock(&journal->j_state_lock:8)
[    6.881484]     [W] wait(&(&journal->j_wait_commit)->dmap:0)
[    6.881485]     [E] write_unlock(&journal->j_state_lock:8)
[    6.881486] 
[    6.881487] [S]: start of the event context
[    6.881487] [W]: the wait blocked
[    6.881488] [E]: the event not reachable
[    6.881489] ---------------------------------------------------
[    6.881489] context A's detail
[    6.881490] ---------------------------------------------------
[    6.881490] context A
[    6.881491]     [S] (unknown)(&(&journal->j_wait_commit)->dmap:0)
[    6.881492]     [W] __raw_read_lock(&journal->j_state_lock:8)
[    6.881493]     [E] event(&(&journal->j_wait_commit)->dmap:0)
[    6.881494] 
[    6.881495] [S] (unknown)(&(&journal->j_wait_commit)->dmap:0):
[    6.881496] (N/A)
[    6.881496] 
[    6.881497] [W] __raw_read_lock(&journal->j_state_lock:8):
[    6.881498] [<ffffffff8133cd87>] start_this_handle+0xa7/0x5e0
[    6.881500] stacktrace:
[    6.881500]       _raw_read_lock+0x57/0xd0
[    6.881502]       start_this_handle+0xa7/0x5e0
[    6.881504]       jbd2__journal_start+0xe6/0x220
[    6.881506]       __ext4_journal_start_sb+0x11c/0x150
[    6.881508]       ext4_truncate+0x167/0x4b0
[    6.881509]       ext4_da_write_begin+0x19c/0x2a0
[    6.881511]       generic_perform_write+0xa6/0x1c0
[    6.881512]       ext4_buffered_write_iter+0x89/0x100
[    6.881515]       ext4_file_write_iter+0x4a/0x7f0
[    6.881516]       new_sync_write+0x100/0x190
[    6.881518]       vfs_write+0x134/0x360
[    6.881521]       ksys_write+0x4d/0xc0
[    6.881522]       do_syscall_64+0x3a/0x90
[    6.881523]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[    6.881525] 
[    6.881526] [E] event(&(&journal->j_wait_commit)->dmap:0):
[    6.881527] [<ffffffff810baa53>] __wake_up_common+0x93/0x1a0
[    6.881529] stacktrace:
[    6.881529]       dept_event+0x12b/0x1f0
[    6.881531]       __wake_up_common+0xb0/0x1a0
[    6.881532]       __wake_up_common_lock+0x65/0x90
[    6.881533]       __jbd2_log_start_commit+0x8a/0xa0
[    6.881535]       jbd2_log_start_commit+0x24/0x40
[    6.881536]       __jbd2_journal_force_commit+0x91/0xb0
[    6.881538]       jbd2_journal_force_commit_nested+0x5/0x10
[    6.881540]       ext4_should_retry_alloc+0x5b/0xb0
[    6.881541]       ext4_da_write_begin+0xf2/0x2a0
[    6.881543]       generic_perform_write+0xa6/0x1c0
[    6.881544]       ext4_buffered_write_iter+0x89/0x100
[    6.881546]       ext4_file_write_iter+0x4a/0x7f0
[    6.881548]       new_sync_write+0x100/0x190
[    6.881550]       vfs_write+0x134/0x360
[    6.881552]       ksys_write+0x4d/0xc0
[    6.881553]       do_syscall_64+0x3a/0x90
[    6.881555] ---------------------------------------------------
[    6.881556] context B's detail
[    6.881556] ---------------------------------------------------
[    6.881557] context B
[    6.881558]     [S] __raw_write_lock(&journal->j_state_lock:8)
[    6.881559]     [W] wait(&(&journal->j_wait_commit)->dmap:0)
[    6.881560]     [E] write_unlock(&journal->j_state_lock:8)
[    6.881561] 
[    6.881561] [S] __raw_write_lock(&journal->j_state_lock:8):
[    6.881562] [<ffffffff81346e9e>] kjournald2+0x7e/0x260
[    6.881564] stacktrace:
[    6.881564]       _raw_write_lock+0x6e/0x90
[    6.881566]       kjournald2+0x7e/0x260
[    6.881567]       kthread+0xe3/0x110
[    6.881569]       ret_from_fork+0x22/0x30
[    6.881571] 
[    6.881572] [W] wait(&(&journal->j_wait_commit)->dmap:0):
[    6.881573] [<ffffffff810bb017>] prepare_to_wait+0x47/0xd0
[    6.881574] stacktrace:
[    6.881575]       kjournald2+0x164/0x260
[    6.881576]       kthread+0xe3/0x110
[    6.881578]       ret_from_fork+0x22/0x30
[    6.881579] 
[    6.881580] [E] write_unlock(&journal->j_state_lock:8):
[    6.881581] [<ffffffff8134700b>] kjournald2+0x1eb/0x260
[    6.881582] stacktrace:
[    6.881583]       _raw_write_unlock+0x30/0x70
[    6.881585]       kjournald2+0x1eb/0x260
[    6.881586]       kthread+0xe3/0x110
[    6.881588]       ret_from_fork+0x22/0x30
[    6.881589] ---------------------------------------------------
[    6.881590] information that might be helpful
[    6.881590] ---------------------------------------------------
[    6.881591] CPU: 2 PID: 628 Comm: rs:main Q:Reg Tainted: G        W         5.17.0-rc1-00014-gcf3441bb2012 #2
[    6.881593] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[    6.881594] Call Trace:
[    6.881595]  <TASK>
[    6.881596]  dump_stack_lvl+0x44/0x57
[    6.881597]  print_circle+0x384/0x510
[    6.881599]  ? __kernel_text_address+0x9/0x30
[    6.881601]  ? print_circle+0x510/0x510
[    6.881603]  cb_check_dl+0x58/0x60
[    6.881605]  bfs+0xdc/0x1b0
[    6.881607]  add_dep+0x94/0x120
[    6.881609]  do_event.isra.22+0x284/0x300
[    6.881611]  ? __wake_up_common+0x93/0x1a0
[    6.881612]  dept_event+0x12b/0x1f0
[    6.881615]  __wake_up_common+0xb0/0x1a0
[    6.881617]  __wake_up_common_lock+0x65/0x90
[    6.881619]  __jbd2_log_start_commit+0x8a/0xa0
[    6.881621]  jbd2_log_start_commit+0x24/0x40
[    6.881622]  __jbd2_journal_force_commit+0x91/0xb0
[    6.881624]  jbd2_journal_force_commit_nested+0x5/0x10
[    6.881626]  ext4_should_retry_alloc+0x5b/0xb0
[    6.881628]  ext4_da_write_begin+0xf2/0x2a0
[    6.881630]  generic_perform_write+0xa6/0x1c0
[    6.881633]  ext4_buffered_write_iter+0x89/0x100
[    6.881636]  ext4_file_write_iter+0x4a/0x7f0
[    6.881638]  new_sync_write+0x100/0x190
[    6.881642]  vfs_write+0x134/0x360
[    6.881644]  ksys_write+0x4d/0xc0
[    6.881645]  ? trace_hardirqs_on+0x38/0xe0
[    6.881648]  do_syscall_64+0x3a/0x90
[    6.881650]  entry_SYSCALL_64_after_hwframe+0x44/0xae
