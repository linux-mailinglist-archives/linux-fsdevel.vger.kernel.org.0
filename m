Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131BA4B7F53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 05:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbiBPEP5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 23:15:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343786AbiBPEPj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:15:39 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9907310077F
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 20:15:25 -0800 (PST)
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.53 with ESMTP; 16 Feb 2022 13:15:24 +0900
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
Subject: Report in __mark_inode_dirty()
Date:   Wed, 16 Feb 2022 13:15:18 +0900
Message-Id: <1644984918-27955-6-git-send-email-byungchul.park@lge.com>
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

[   22.135149] ===================================================
[   22.135154] DEPT: Circular dependency has been detected.
[   22.135156] 5.17.0-rc1-00014-gcf3441bb2012 #2 Tainted: G        W        
[   22.135159] ---------------------------------------------------
[   22.135161] summary
[   22.135162] ---------------------------------------------------
[   22.135163] *** DEADLOCK ***
[   22.135163] 
[   22.135164] context A
[   22.135166]     [S] start_this_handle(jbd2_handle:0)
[   22.135169]     [W] __raw_write_lock(&journal->j_state_lock:8)
[   22.135171]     [E] up_read(jbd2_handle:0)
[   22.135174] 
[   22.135175] context B
[   22.135176]     [S] (unknown)(&(&journal->j_wait_commit)->dmap:0)
[   22.135179]     [W] start_this_handle(jbd2_handle:0)
[   22.135181]     [E] event(&(&journal->j_wait_commit)->dmap:0)
[   22.135183] 
[   22.135184] context C
[   22.135185]     [S] __raw_write_lock(&journal->j_state_lock:8)
[   22.135188]     [W] wait(&(&journal->j_wait_commit)->dmap:0)
[   22.135190]     [E] write_unlock(&journal->j_state_lock:8)
[   22.135192] 
[   22.135193] [S]: start of the event context
[   22.135194] [W]: the wait blocked
[   22.135195] [E]: the event not reachable
[   22.135197] ---------------------------------------------------
[   22.135198] context A's detail
[   22.135199] ---------------------------------------------------
[   22.135200] context A
[   22.135202]     [S] start_this_handle(jbd2_handle:0)
[   22.135204]     [W] __raw_write_lock(&journal->j_state_lock:8)
[   22.135206]     [E] up_read(jbd2_handle:0)
[   22.135208] 
[   22.135209] [S] start_this_handle(jbd2_handle:0):
[   22.135211] [<ffffffff8133cdfb>] start_this_handle+0x11b/0x5e0
[   22.135220] stacktrace:
[   22.135221]       start_this_handle+0x1d2/0x5e0
[   22.135228]       jbd2__journal_start+0xe6/0x220
[   22.135231]       __ext4_journal_start_sb+0x11c/0x150
[   22.135236]       ext4_dirty_inode+0x2f/0x70
[   22.135240]       __mark_inode_dirty+0x1ba/0x400
[   22.135244]       generic_update_time+0x99/0xc0
[   22.135248]       touch_atime+0x18c/0x1e0
[   22.135251]       filemap_read+0x27a/0x920
[   22.135255]       __kernel_read+0x12e/0x2f0
[   22.135263]       bprm_execve+0x2f0/0x6c0
[   22.135267]       do_execveat_common.isra.49+0x1b5/0x1d0
[   22.135271]       __x64_sys_execve+0x2d/0x40
[   22.135275]       do_syscall_64+0x3a/0x90
[   22.135280]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[   22.135285] 
[   22.135286] [W] __raw_write_lock(&journal->j_state_lock:8):
[   22.135288] [<ffffffff81348c59>] jbd2_log_start_commit+0x19/0x40
[   22.135293] stacktrace:
[   22.135294]       dept_wait+0x125/0x1e0
[   22.135299]       _raw_write_lock+0x4b/0x90
[   22.135303]       jbd2_log_start_commit+0x19/0x40
[   22.135306]       jbd2_journal_stop+0x104/0x310
[   22.135310]       __ext4_journal_stop+0x31/0x90
[   22.135313]       __mark_inode_dirty+0x1ba/0x400
[   22.135316]       generic_update_time+0x99/0xc0
[   22.135319]       touch_atime+0x18c/0x1e0
[   22.135323]       filemap_read+0x27a/0x920
[   22.135326]       __kernel_read+0x12e/0x2f0
[   22.135330]       bprm_execve+0x2f0/0x6c0
[   22.135334]       do_execveat_common.isra.49+0x1b5/0x1d0
[   22.135338]       __x64_sys_execve+0x2d/0x40
[   22.135342]       do_syscall_64+0x3a/0x90
[   22.135345]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[   22.135349] 
[   22.135351] [E] up_read(jbd2_handle:0):
[   22.135352] [<ffffffff8133ce34>] start_this_handle+0x154/0x5e0
[   22.135357] ---------------------------------------------------
[   22.135358] context B's detail
[   22.135359] ---------------------------------------------------
[   22.135360] context B
[   22.135362]     [S] (unknown)(&(&journal->j_wait_commit)->dmap:0)
[   22.135364]     [W] start_this_handle(jbd2_handle:0)
[   22.135366]     [E] event(&(&journal->j_wait_commit)->dmap:0)
[   22.135368] 
[   22.135369] [S] (unknown)(&(&journal->j_wait_commit)->dmap:0):
[   22.135371] (N/A)
[   22.135372] 
[   22.135373] [W] start_this_handle(jbd2_handle:0):
[   22.135375] [<ffffffff8133cdfb>] start_this_handle+0x11b/0x5e0
[   22.135379] stacktrace:
[   22.135380]       start_this_handle+0x1ad/0x5e0
[   22.135383]       jbd2__journal_start+0xe6/0x220
[   22.135387]       __ext4_journal_start_sb+0x11c/0x150
[   22.135391]       ext4_truncate+0x167/0x4b0
[   22.135394]       ext4_da_write_begin+0x19c/0x2a0
[   22.135397]       generic_perform_write+0xa6/0x1c0
[   22.135400]       ext4_buffered_write_iter+0x89/0x100
[   22.135405]       ext4_file_write_iter+0x4a/0x7f0
[   22.135409]       new_sync_write+0x100/0x190
[   22.135413]       vfs_write+0x134/0x360
[   22.135417]       ksys_write+0x4d/0xc0
[   22.135419]       do_syscall_64+0x3a/0x90
[   22.135423]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[   22.135427] 
[   22.135428] [E] event(&(&journal->j_wait_commit)->dmap:0):
[   22.135430] [<ffffffff810baa53>] __wake_up_common+0x93/0x1a0
[   22.135433] stacktrace:
[   22.135434]       dept_event+0x12b/0x1f0
[   22.135438]       __wake_up_common+0xb0/0x1a0
[   22.135440]       __wake_up_common_lock+0x65/0x90
[   22.135443]       __jbd2_log_start_commit+0x8a/0xa0
[   22.135446]       jbd2_log_start_commit+0x24/0x40
[   22.135449]       __jbd2_journal_force_commit+0x91/0xb0
[   22.135452]       jbd2_journal_force_commit_nested+0x5/0x10
[   22.135455]       ext4_should_retry_alloc+0x5b/0xb0
[   22.135459]       ext4_da_write_begin+0xf2/0x2a0
[   22.135462]       generic_perform_write+0xa6/0x1c0
[   22.135465]       ext4_buffered_write_iter+0x89/0x100
[   22.135469]       ext4_file_write_iter+0x4a/0x7f0
[   22.135473]       new_sync_write+0x100/0x190
[   22.135477]       vfs_write+0x134/0x360
[   22.135481]       ksys_write+0x4d/0xc0
[   22.135483]       do_syscall_64+0x3a/0x90
[   22.135487] ---------------------------------------------------
[   22.135488] context C's detail
[   22.135489] ---------------------------------------------------
[   22.135491] context C
[   22.135492]     [S] __raw_write_lock(&journal->j_state_lock:8)
[   22.135494]     [W] wait(&(&journal->j_wait_commit)->dmap:0)
[   22.135496]     [E] write_unlock(&journal->j_state_lock:8)
[   22.135498] 
[   22.135499] [S] __raw_write_lock(&journal->j_state_lock:8):
[   22.135501] [<ffffffff81346e9e>] kjournald2+0x7e/0x260
[   22.135505] stacktrace:
[   22.135506]       _raw_write_lock+0x6e/0x90
[   22.135510]       kjournald2+0x7e/0x260
[   22.135512]       kthread+0xe3/0x110
[   22.135517]       ret_from_fork+0x22/0x30
[   22.135520] 
[   22.135521] [W] wait(&(&journal->j_wait_commit)->dmap:0):
[   22.135523] [<ffffffff810bb017>] prepare_to_wait+0x47/0xd0
[   22.135527] stacktrace:
[   22.135528]       kjournald2+0x164/0x260
[   22.135530]       kthread+0xe3/0x110
[   22.135534]       ret_from_fork+0x22/0x30
[   22.135537] 
[   22.135538] [E] write_unlock(&journal->j_state_lock:8):
[   22.135540] [<ffffffff8134700b>] kjournald2+0x1eb/0x260
[   22.135543] stacktrace:
[   22.135545]       _raw_write_unlock+0x30/0x70
[   22.135548]       kjournald2+0x1eb/0x260
[   22.135551]       kthread+0xe3/0x110
[   22.135554]       ret_from_fork+0x22/0x30
[   22.135557] ---------------------------------------------------
[   22.135559] information that might be helpful
[   22.135560] ---------------------------------------------------
[   22.135562] CPU: 2 PID: 869 Comm: getty Tainted: G        W         5.17.0-rc1-00014-gcf3441bb2012 #2
[   22.135566] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[   22.135569] Call Trace:
[   22.135571]  <TASK>
[   22.135573]  dump_stack_lvl+0x44/0x57
[   22.135577]  print_circle+0x384/0x510
[   22.135582]  ? print_circle+0x510/0x510
[   22.135586]  cb_check_dl+0x58/0x60
[   22.135589]  bfs+0xdc/0x1b0
[   22.135593]  ? jbd2_log_start_commit+0x19/0x40
[   22.135596]  add_dep+0x94/0x120
[   22.135601]  ? jbd2_log_start_commit+0x19/0x40
[   22.135604]  add_wait+0x24e/0x410
[   22.135608]  ? check_new_class+0x44/0x190
[   22.135611]  ? jbd2_log_start_commit+0x19/0x40
[   22.135615]  dept_wait+0x125/0x1e0
[   22.135619]  _raw_write_lock+0x4b/0x90
[   22.135623]  ? jbd2_log_start_commit+0x19/0x40
[   22.135626]  jbd2_log_start_commit+0x19/0x40
[   22.135630]  jbd2_journal_stop+0x104/0x310
[   22.135635]  __ext4_journal_stop+0x31/0x90
[   22.135639]  __mark_inode_dirty+0x1ba/0x400
[   22.135643]  generic_update_time+0x99/0xc0
[   22.135647]  touch_atime+0x18c/0x1e0
[   22.135652]  filemap_read+0x27a/0x920
[   22.135658]  ? avc_has_perm+0xfa/0x1c0
[   22.135662]  ? _raw_spin_unlock_irqrestore+0x58/0x80
[   22.135666]  ? _raw_spin_unlock_irqrestore+0x58/0x80
[   22.135670]  __kernel_read+0x12e/0x2f0
[   22.135677]  bprm_execve+0x2f0/0x6c0
[   22.135683]  do_execveat_common.isra.49+0x1b5/0x1d0
[   22.135688]  __x64_sys_execve+0x2d/0x40
[   22.135693]  do_syscall_64+0x3a/0x90
[   22.135697]  entry_SYSCALL_64_after_hwframe+0x44/0xae
