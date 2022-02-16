Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7B14B7F49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 05:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbiBPEPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 23:15:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343740AbiBPEPj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:15:39 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73BBB100772
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 20:15:25 -0800 (PST)
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.52 with ESMTP; 16 Feb 2022 13:15:24 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.127 with ESMTP; 16 Feb 2022 13:15:24 +0900
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
Subject: Report in ksys_write()
Date:   Wed, 16 Feb 2022 13:15:17 +0900
Message-Id: <1644984918-27955-5-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1644984918-27955-1-git-send-email-byungchul.park@lge.com>
References: <1644984711-26423-1-git-send-email-byungchul.park@lge.com>
 <1644984918-27955-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[    7.382619] ===================================================
[    7.382623] DEPT: Circular dependency has been detected.
[    7.382624] 5.17.0-rc1-00014-gcf3441bb2012 #2 Tainted: G        W        
[    7.382625] ---------------------------------------------------
[    7.382626] summary
[    7.382627] ---------------------------------------------------
[    7.382627] *** DEADLOCK ***
[    7.382627] 
[    7.382628] context A
[    7.382628]     [S] (unknown)(&(&journal->j_wait_commit)->dmap:0)
[    7.382630]     [W] __mutex_lock_common(&f->f_pos_lock:0)
[    7.382631]     [E] event(&(&journal->j_wait_commit)->dmap:0)
[    7.382633] 
[    7.382633] context B
[    7.382634]     [S] __raw_write_lock(&journal->j_state_lock:8)
[    7.382635]     [W] wait(&(&journal->j_wait_commit)->dmap:0)
[    7.382636]     [E] write_unlock(&journal->j_state_lock:8)
[    7.382637] 
[    7.382638] context C
[    7.382639]     [S] __mutex_lock_common(&f->f_pos_lock:0)
[    7.382640]     [W] __raw_read_lock(&journal->j_state_lock:8)
[    7.382641]     [E] mutex_unlock(&f->f_pos_lock:0)
[    7.382642] 
[    7.382642] [S]: start of the event context
[    7.382643] [W]: the wait blocked
[    7.382643] [E]: the event not reachable
[    7.382644] ---------------------------------------------------
[    7.382645] context A's detail
[    7.382645] ---------------------------------------------------
[    7.382646] context A
[    7.382647]     [S] (unknown)(&(&journal->j_wait_commit)->dmap:0)
[    7.382648]     [W] __mutex_lock_common(&f->f_pos_lock:0)
[    7.382649]     [E] event(&(&journal->j_wait_commit)->dmap:0)
[    7.382650] 
[    7.382650] [S] (unknown)(&(&journal->j_wait_commit)->dmap:0):
[    7.382651] (N/A)
[    7.382652] 
[    7.382652] [W] __mutex_lock_common(&f->f_pos_lock:0):
[    7.382653] [<ffffffff8124ff73>] __fdget_pos+0x43/0x50
[    7.382658] stacktrace:
[    7.382659]       __mutex_lock+0x52c/0x900
[    7.382662]       __fdget_pos+0x43/0x50
[    7.382663]       ksys_write+0x15/0xc0
[    7.382665]       do_syscall_64+0x3a/0x90
[    7.382668]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[    7.382670] 
[    7.382671] [E] event(&(&journal->j_wait_commit)->dmap:0):
[    7.382672] [<ffffffff810baa53>] __wake_up_common+0x93/0x1a0
[    7.382674] stacktrace:
[    7.382674]       dept_event+0x12b/0x1f0
[    7.382677]       __wake_up_common+0xb0/0x1a0
[    7.382678]       __wake_up_common_lock+0x65/0x90
[    7.382679]       __jbd2_log_start_commit+0x8a/0xa0
[    7.382682]       jbd2_log_start_commit+0x24/0x40
[    7.382683]       __jbd2_journal_force_commit+0x91/0xb0
[    7.382685]       jbd2_journal_force_commit_nested+0x5/0x10
[    7.382686]       ext4_should_retry_alloc+0x5b/0xb0
[    7.382689]       ext4_da_write_begin+0xf2/0x2a0
[    7.382691]       generic_perform_write+0xa6/0x1c0
[    7.382693]       ext4_buffered_write_iter+0x89/0x100
[    7.382695]       ext4_file_write_iter+0x4a/0x7f0
[    7.382697]       new_sync_write+0x100/0x190
[    7.382700]       vfs_write+0x134/0x360
[    7.382702]       ksys_write+0x4d/0xc0
[    7.382703]       do_syscall_64+0x3a/0x90
[    7.382705] ---------------------------------------------------
[    7.382705] context B's detail
[    7.382706] ---------------------------------------------------
[    7.382706] context B
[    7.382707]     [S] __raw_write_lock(&journal->j_state_lock:8)
[    7.382708]     [W] wait(&(&journal->j_wait_commit)->dmap:0)
[    7.382709]     [E] write_unlock(&journal->j_state_lock:8)
[    7.382710] 
[    7.382711] [S] __raw_write_lock(&journal->j_state_lock:8):
[    7.382712] [<ffffffff81346e9e>] kjournald2+0x7e/0x260
[    7.382713] stacktrace:
[    7.382714]       _raw_write_lock+0x6e/0x90
[    7.382716]       kjournald2+0x7e/0x260
[    7.382717]       kthread+0xe3/0x110
[    7.382720]       ret_from_fork+0x22/0x30
[    7.382722] 
[    7.382723] [W] wait(&(&journal->j_wait_commit)->dmap:0):
[    7.382724] [<ffffffff810bb017>] prepare_to_wait+0x47/0xd0
[    7.382725] stacktrace:
[    7.382726]       kjournald2+0x164/0x260
[    7.382727]       kthread+0xe3/0x110
[    7.382729]       ret_from_fork+0x22/0x30
[    7.382731] 
[    7.382731] [E] write_unlock(&journal->j_state_lock:8):
[    7.382732] [<ffffffff8134700b>] kjournald2+0x1eb/0x260
[    7.382734] stacktrace:
[    7.382734]       _raw_write_unlock+0x30/0x70
[    7.382736]       kjournald2+0x1eb/0x260
[    7.382737]       kthread+0xe3/0x110
[    7.382739]       ret_from_fork+0x22/0x30
[    7.382740] ---------------------------------------------------
[    7.382741] context C's detail
[    7.382742] ---------------------------------------------------
[    7.382742] context C
[    7.382743]     [S] __mutex_lock_common(&f->f_pos_lock:0)
[    7.382744]     [W] __raw_read_lock(&journal->j_state_lock:8)
[    7.382745]     [E] mutex_unlock(&f->f_pos_lock:0)
[    7.382746] 
[    7.382746] [S] __mutex_lock_common(&f->f_pos_lock:0):
[    7.382747] [<ffffffff8124ff73>] __fdget_pos+0x43/0x50
[    7.382749] stacktrace:
[    7.382750]       __mutex_lock+0x54d/0x900
[    7.382751]       __fdget_pos+0x43/0x50
[    7.382753]       ksys_write+0x15/0xc0
[    7.382754]       do_syscall_64+0x3a/0x90
[    7.382756]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[    7.382758] 
[    7.382758] [W] __raw_read_lock(&journal->j_state_lock:8):
[    7.382759] [<ffffffff8133cd87>] start_this_handle+0xa7/0x5e0
[    7.382762] stacktrace:
[    7.382763]       _raw_read_lock+0x57/0xd0
[    7.382765]       start_this_handle+0xa7/0x5e0
[    7.382766]       jbd2__journal_start+0xe6/0x220
[    7.382768]       __ext4_journal_start_sb+0x11c/0x150
[    7.382770]       ext4_dirty_inode+0x2f/0x70
[    7.382771]       __mark_inode_dirty+0x1ba/0x400
[    7.382774]       generic_update_time+0x99/0xc0
[    7.382775]       file_update_time+0x85/0xe0
[    7.382777]       ext4_buffered_write_iter+0x56/0x100
[    7.382779]       ext4_file_write_iter+0x4a/0x7f0
[    7.382781]       new_sync_write+0x100/0x190
[    7.382783]       vfs_write+0x134/0x360
[    7.382785]       ksys_write+0x4d/0xc0
[    7.382786]       do_syscall_64+0x3a/0x90
[    7.382788]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[    7.382790] 
[    7.382790] [E] mutex_unlock(&f->f_pos_lock:0):
[    7.382791] [<ffffffff8122c800>] ksys_write+0x90/0xc0
[    7.382792] stacktrace:
[    7.382793]       __mutex_unlock_slowpath+0x49/0x2a0
[    7.382795]       ksys_write+0x90/0xc0
[    7.382796]       do_syscall_64+0x3a/0x90
[    7.382797]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[    7.382799] ---------------------------------------------------
[    7.382800] information that might be helpful
[    7.382801] ---------------------------------------------------
[    7.382802] CPU: 1 PID: 628 Comm: rs:main Q:Reg Tainted: G        W         5.17.0-rc1-00014-gcf3441bb2012 #2
[    7.382804] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[    7.382805] Call Trace:
[    7.382807]  <TASK>
[    7.382808]  dump_stack_lvl+0x44/0x57
[    7.382810]  print_circle+0x384/0x510
[    7.382812]  ? unwind_get_return_address+0x16/0x30
[    7.382816]  ? print_circle+0x510/0x510
[    7.382818]  cb_check_dl+0x58/0x60
[    7.382819]  bfs+0xdc/0x1b0
[    7.382822]  add_dep+0x94/0x120
[    7.382824]  do_event.isra.22+0x284/0x300
[    7.382826]  ? __wake_up_common+0x93/0x1a0
[    7.382827]  dept_event+0x12b/0x1f0
[    7.382829]  __wake_up_common+0xb0/0x1a0
[    7.382831]  __wake_up_common_lock+0x65/0x90
[    7.382833]  __jbd2_log_start_commit+0x8a/0xa0
[    7.382835]  jbd2_log_start_commit+0x24/0x40
[    7.382837]  __jbd2_journal_force_commit+0x91/0xb0
[    7.382839]  jbd2_journal_force_commit_nested+0x5/0x10
[    7.382840]  ext4_should_retry_alloc+0x5b/0xb0
[    7.382842]  ext4_da_write_begin+0xf2/0x2a0
[    7.382845]  generic_perform_write+0xa6/0x1c0
[    7.382847]  ext4_buffered_write_iter+0x89/0x100
[    7.382850]  ext4_file_write_iter+0x4a/0x7f0
[    7.382853]  new_sync_write+0x100/0x190
[    7.382856]  vfs_write+0x134/0x360
[    7.382859]  ksys_write+0x4d/0xc0
[    7.382860]  ? trace_hardirqs_on+0x38/0xe0
[    7.382863]  do_syscall_64+0x3a/0x90
[    7.382865]  entry_SYSCALL_64_after_hwframe+0x44/0xae
