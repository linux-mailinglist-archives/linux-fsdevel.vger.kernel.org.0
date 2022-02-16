Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D044B7F44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 05:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343711AbiBPEPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 23:15:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbiBPEPj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:15:39 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FD39100767
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 20:15:24 -0800 (PST)
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
Subject: Report in ext4_sync_file()
Date:   Wed, 16 Feb 2022 13:15:16 +0900
Message-Id: <1644984918-27955-4-git-send-email-byungchul.park@lge.com>
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

[    7.072624] ===================================================
[    7.072630] DEPT: Circular dependency has been detected.
[    7.072631] 5.17.0-rc1-00014-gcf3441bb2012 #2 Tainted: G        W        
[    7.072635] ---------------------------------------------------
[    7.072636] summary
[    7.072636] ---------------------------------------------------
[    7.072637] *** DEADLOCK ***
[    7.072637] 
[    7.072638] context A
[    7.072640]     [S] (unknown)(&(&journal->j_wait_commit)->dmap:0)
[    7.072643]     [W] folio_wait_bit_common(pgwriteback:0)
[    7.072644]     [E] event(&(&journal->j_wait_commit)->dmap:0)
[    7.072646] 
[    7.072647] context B
[    7.072647]     [S] __raw_write_lock(&journal->j_state_lock:8)
[    7.072649]     [W] wait(&(&journal->j_wait_commit)->dmap:0)
[    7.072654]     [E] write_unlock(&journal->j_state_lock:8)
[    7.072656] 
[    7.072657] context C
[    7.072658]     [S] (unknown)(pgwriteback:0)
[    7.072659]     [W] __raw_read_lock(&journal->j_state_lock:8)
[    7.072661]     [E] folio_wake_bit(pgwriteback:0)
[    7.072663] 
[    7.072663] [S]: start of the event context
[    7.072664] [W]: the wait blocked
[    7.072665] [E]: the event not reachable
[    7.072666] ---------------------------------------------------
[    7.072667] context A's detail
[    7.072668] ---------------------------------------------------
[    7.072669] context A
[    7.072670]     [S] (unknown)(&(&journal->j_wait_commit)->dmap:0)
[    7.072672]     [W] folio_wait_bit_common(pgwriteback:0)
[    7.072674]     [E] event(&(&journal->j_wait_commit)->dmap:0)
[    7.072675] 
[    7.072676] [S] (unknown)(&(&journal->j_wait_commit)->dmap:0):
[    7.072678] (N/A)
[    7.072679] 
[    7.072680] [W] folio_wait_bit_common(pgwriteback:0):
[    7.072681] [<ffffffff811ae2e2>] folio_wait_writeback+0x52/0xb0
[    7.072688] stacktrace:
[    7.072689]       folio_wait_bit+0x1ea/0x2a0
[    7.072692]       folio_wait_writeback+0x52/0xb0
[    7.072695]       __filemap_fdatawait_range+0x6d/0xc0
[    7.072701]       file_write_and_wait_range+0x90/0xc0
[    7.072703]       ext4_sync_file+0x1b5/0x410
[    7.072708]       do_fsync+0x33/0x60
[    7.072712]       __x64_sys_fsync+0xb/0x10
[    7.072715]       do_syscall_64+0x3a/0x90
[    7.072719]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[    7.072723] 
[    7.072724] [E] event(&(&journal->j_wait_commit)->dmap:0):
[    7.072725] [<ffffffff810baa53>] __wake_up_common+0x93/0x1a0
[    7.072728] stacktrace:
[    7.072729]       dept_event+0x12b/0x1f0
[    7.072733]       __wake_up_common+0xb0/0x1a0
[    7.072735]       __wake_up_common_lock+0x65/0x90
[    7.072737]       __jbd2_log_start_commit+0x8a/0xa0
[    7.072740]       jbd2_log_start_commit+0x24/0x40
[    7.072742]       jbd2_complete_transaction+0x79/0x90
[    7.072745]       ext4_fc_commit+0x329/0x940
[    7.072748]       ext4_sync_file+0x29f/0x410
[    7.072751]       do_fsync+0x33/0x60
[    7.072754]       __x64_sys_fsync+0xb/0x10
[    7.072757]       do_syscall_64+0x3a/0x90
[    7.072759]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[    7.072762] ---------------------------------------------------
[    7.072763] context B's detail
[    7.072764] ---------------------------------------------------
[    7.072765] context B
[    7.072766]     [S] __raw_write_lock(&journal->j_state_lock:8)
[    7.072768]     [W] wait(&(&journal->j_wait_commit)->dmap:0)
[    7.072769]     [E] write_unlock(&journal->j_state_lock:8)
[    7.072771] 
[    7.072772] [S] __raw_write_lock(&journal->j_state_lock:8):
[    7.072773] [<ffffffff81346e9e>] kjournald2+0x7e/0x260
[    7.072776] stacktrace:
[    7.072777]       _raw_write_lock+0x6e/0x90
[    7.072779]       kjournald2+0x7e/0x260
[    7.072781]       kthread+0xe3/0x110
[    7.072785]       ret_from_fork+0x22/0x30
[    7.072789] 
[    7.072789] [W] wait(&(&journal->j_wait_commit)->dmap:0):
[    7.072791] [<ffffffff810bb017>] prepare_to_wait+0x47/0xd0
[    7.072794] stacktrace:
[    7.072795]       kjournald2+0x164/0x260
[    7.072797]       kthread+0xe3/0x110
[    7.072800]       ret_from_fork+0x22/0x30
[    7.072802] 
[    7.072802] [E] write_unlock(&journal->j_state_lock:8):
[    7.072804] [<ffffffff8134700b>] kjournald2+0x1eb/0x260
[    7.072806] stacktrace:
[    7.072807]       _raw_write_unlock+0x30/0x70
[    7.072810]       kjournald2+0x1eb/0x260
[    7.072812]       kthread+0xe3/0x110
[    7.072814]       ret_from_fork+0x22/0x30
[    7.072816] ---------------------------------------------------
[    7.072817] context C's detail
[    7.072818] ---------------------------------------------------
[    7.072819] context C
[    7.072820]     [S] (unknown)(pgwriteback:0)
[    7.072822]     [W] __raw_read_lock(&journal->j_state_lock:8)
[    7.072823]     [E] folio_wake_bit(pgwriteback:0)
[    7.072825] 
[    7.072825] [S] (unknown)(pgwriteback:0):
[    7.072827] (N/A)
[    7.072828] 
[    7.072828] [W] __raw_read_lock(&journal->j_state_lock:8):
[    7.072830] [<ffffffff8133cd87>] start_this_handle+0xa7/0x5e0
[    7.072834] stacktrace:
[    7.072834]       _raw_read_lock+0x57/0xd0
[    7.072837]       start_this_handle+0xa7/0x5e0
[    7.072839]       jbd2_journal_start_reserved+0x4d/0x170
[    7.072842]       __ext4_journal_start_reserved+0x87/0x160
[    7.072845]       ext4_convert_unwritten_io_end_vec+0x26/0xb0
[    7.072848]       ext4_end_io_rsv_work+0xef/0x140
[    7.072850]       process_one_work+0x317/0x640
[    7.072852]       worker_thread+0x44/0x410
[    7.072854]       kthread+0xe3/0x110
[    7.072857]       ret_from_fork+0x22/0x30
[    7.072859] 
[    7.072860] [E] folio_wake_bit(pgwriteback:0):
[    7.072862] [<ffffffff811a30f2>] folio_end_writeback+0x32/0x80
[    7.072865] stacktrace:
[    7.072866]       folio_wake_bit+0x15e/0x170
[    7.072868]       folio_end_writeback+0x32/0x80
[    7.072870]       ext4_finish_bio+0x15a/0x200
[    7.072872]       ext4_release_io_end+0x41/0xe0
[    7.072874]       ext4_end_io_rsv_work+0xaf/0x140
[    7.072876]       process_one_work+0x317/0x640
[    7.072878]       worker_thread+0x44/0x410
[    7.072880]       kthread+0xe3/0x110
[    7.072883]       ret_from_fork+0x22/0x30
[    7.072885] ---------------------------------------------------
[    7.072886] information that might be helpful
[    7.072887] ---------------------------------------------------
[    7.072889] CPU: 1 PID: 620 Comm: cupsd Tainted: G        W         5.17.0-rc1-00014-gcf3441bb2012 #2
[    7.072893] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[    7.072894] Call Trace:
[    7.072896]  <TASK>
[    7.072898]  dump_stack_lvl+0x44/0x57
[    7.072902]  print_circle+0x384/0x510
[    7.072905]  ? print_circle+0x510/0x510
[    7.072908]  cb_check_dl+0x58/0x60
[    7.072936]  bfs+0xdc/0x1b0
[    7.072940]  add_dep+0x94/0x120
[    7.072944]  do_event.isra.22+0x284/0x300
[    7.072947]  ? __wake_up_common+0x93/0x1a0
[    7.072949]  dept_event+0x12b/0x1f0
[    7.072953]  __wake_up_common+0xb0/0x1a0
[    7.072956]  __wake_up_common_lock+0x65/0x90
[    7.072960]  __jbd2_log_start_commit+0x8a/0xa0
[    7.072963]  jbd2_log_start_commit+0x24/0x40
[    7.072966]  jbd2_complete_transaction+0x79/0x90
[    7.072969]  ext4_fc_commit+0x329/0x940
[    7.072972]  ? to_pool+0x6d/0xb0
[    7.072975]  ? pop_ecxt+0x104/0x110
[    7.072982]  ? dept_ecxt_exit+0xc0/0x140
[    7.072986]  ? _raw_read_unlock+0x4f/0x70
[    7.072989]  ext4_sync_file+0x29f/0x410
[    7.072994]  do_fsync+0x33/0x60
[    7.072997]  __x64_sys_fsync+0xb/0x10
[    7.073000]  do_syscall_64+0x3a/0x90
[    7.073003]  entry_SYSCALL_64_after_hwframe+0x44/0xae
