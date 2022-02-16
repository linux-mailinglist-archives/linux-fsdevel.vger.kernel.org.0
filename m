Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609194B7F3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 05:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbiBPEPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 23:15:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245531AbiBPEPi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:15:38 -0500
X-Greylist: delayed 206 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 20:15:24 PST
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE049FFF91
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
Subject: Report in ext4_buffered_write_iter()
Date:   Wed, 16 Feb 2022 13:15:13 +0900
Message-Id: <1644984918-27955-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1644984711-26423-1-git-send-email-byungchul.park@lge.com>
References: <1644984711-26423-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[    7.083356] ===================================================
[    7.083360] DEPT: Circular dependency has been detected.
[    7.083361] 5.17.0-rc1-00014-gcf3441bb2012 #2 Tainted: G        W        
[    7.083363] ---------------------------------------------------
[    7.083364] summary
[    7.083364] ---------------------------------------------------
[    7.083365] *** DEADLOCK ***
[    7.083365] 
[    7.083366] context A
[    7.083366]     [S] (unknown)(&(&journal->j_wait_commit)->dmap:0)
[    7.083368]     [W] down_write(&sb->s_type->i_mutex_key:0)
[    7.083370]     [E] event(&(&journal->j_wait_commit)->dmap:0)
[    7.083371] 
[    7.083371] context B
[    7.083372]     [S] __raw_write_lock(&journal->j_state_lock:8)
[    7.083373]     [W] wait(&(&journal->j_wait_commit)->dmap:0)
[    7.083374]     [E] write_unlock(&journal->j_state_lock:8)
[    7.083375] 
[    7.083376] context C
[    7.083377]     [S] down_write(&sb->s_type->i_mutex_key:0)
[    7.083378]     [W] __raw_read_lock(&journal->j_state_lock:8)
[    7.083379]     [E] up_write(&sb->s_type->i_mutex_key:0)
[    7.083380] 
[    7.083380] [S]: start of the event context
[    7.083381] [W]: the wait blocked
[    7.083382] [E]: the event not reachable
[    7.083382] ---------------------------------------------------
[    7.083383] context A's detail
[    7.083384] ---------------------------------------------------
[    7.083384] context A
[    7.083385]     [S] (unknown)(&(&journal->j_wait_commit)->dmap:0)
[    7.083386]     [W] down_write(&sb->s_type->i_mutex_key:0)
[    7.083387]     [E] event(&(&journal->j_wait_commit)->dmap:0)
[    7.083388] 
[    7.083388] [S] (unknown)(&(&journal->j_wait_commit)->dmap:0):
[    7.083389] (N/A)
[    7.083390] 
[    7.083391] [W] down_write(&sb->s_type->i_mutex_key:0):
[    7.083391] [<ffffffff812e39d7>] ext4_buffered_write_iter+0x37/0x100
[    7.083398] stacktrace:
[    7.083399]       down_write+0x68/0x580
[    7.083402]       ext4_buffered_write_iter+0x37/0x100
[    7.083404]       ext4_file_write_iter+0x4a/0x7f0
[    7.083406]       new_sync_write+0x100/0x190
[    7.083409]       vfs_write+0x134/0x360
[    7.083411]       ksys_write+0x4d/0xc0
[    7.083413]       do_syscall_64+0x3a/0x90
[    7.083415]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[    7.083417] 
[    7.083418] [E] event(&(&journal->j_wait_commit)->dmap:0):
[    7.083419] [<ffffffff810baa53>] __wake_up_common+0x93/0x1a0
[    7.083421] stacktrace:
[    7.083422]       dept_event+0x12b/0x1f0
[    7.083424]       __wake_up_common+0xb0/0x1a0
[    7.083426]       __wake_up_common_lock+0x65/0x90
[    7.083427]       __jbd2_log_start_commit+0x8a/0xa0
[    7.083430]       jbd2_log_start_commit+0x24/0x40
[    7.083431]       __jbd2_journal_force_commit+0x91/0xb0
[    7.083433]       jbd2_journal_force_commit_nested+0x5/0x10
[    7.083434]       ext4_should_retry_alloc+0x5b/0xb0
[    7.083436]       ext4_da_write_begin+0xf2/0x2a0
[    7.083439]       generic_perform_write+0xa6/0x1c0
[    7.083440]       ext4_buffered_write_iter+0x89/0x100
[    7.083442]       ext4_file_write_iter+0x4a/0x7f0
[    7.083444]       new_sync_write+0x100/0x190
[    7.083446]       vfs_write+0x134/0x360
[    7.083448]       ksys_write+0x4d/0xc0
[    7.083449]       do_syscall_64+0x3a/0x90
[    7.083451] ---------------------------------------------------
[    7.083452] context B's detail
[    7.083452] ---------------------------------------------------
[    7.083453] context B
[    7.083453]     [S] __raw_write_lock(&journal->j_state_lock:8)
[    7.083454]     [W] wait(&(&journal->j_wait_commit)->dmap:0)
[    7.083455]     [E] write_unlock(&journal->j_state_lock:8)
[    7.083457] 
[    7.083457] [S] __raw_write_lock(&journal->j_state_lock:8):
[    7.083458] [<ffffffff81346e9e>] kjournald2+0x7e/0x260
[    7.083460] stacktrace:
[    7.083460]       _raw_write_lock+0x6e/0x90
[    7.083462]       kjournald2+0x7e/0x260
[    7.083463]       kthread+0xe3/0x110
[    7.083466]       ret_from_fork+0x22/0x30
[    7.083469] 
[    7.083469] [W] wait(&(&journal->j_wait_commit)->dmap:0):
[    7.083470] [<ffffffff810bb017>] prepare_to_wait+0x47/0xd0
[    7.083472] stacktrace:
[    7.083473]       kjournald2+0x164/0x260
[    7.083474]       kthread+0xe3/0x110
[    7.083476]       ret_from_fork+0x22/0x30
[    7.083477] 
[    7.083478] [E] write_unlock(&journal->j_state_lock:8):
[    7.083479] [<ffffffff8134700b>] kjournald2+0x1eb/0x260
[    7.083480] stacktrace:
[    7.083481]       _raw_write_unlock+0x30/0x70
[    7.083483]       kjournald2+0x1eb/0x260
[    7.083484]       kthread+0xe3/0x110
[    7.083486]       ret_from_fork+0x22/0x30
[    7.083487] ---------------------------------------------------
[    7.083488] context C's detail
[    7.083488] ---------------------------------------------------
[    7.083489] context C
[    7.083490]     [S] down_write(&sb->s_type->i_mutex_key:0)
[    7.083491]     [W] __raw_read_lock(&journal->j_state_lock:8)
[    7.083492]     [E] up_write(&sb->s_type->i_mutex_key:0)
[    7.083493] 
[    7.083493] [S] down_write(&sb->s_type->i_mutex_key:0):
[    7.083494] [<ffffffff81228358>] do_truncate+0x58/0xa0
[    7.083496] stacktrace:
[    7.083497]       down_write+0x8a/0x580
[    7.083498]       do_truncate+0x58/0xa0
[    7.083500]       path_openat+0x646/0x9c0
[    7.083502]       do_filp_open+0xaf/0x110
[    7.083504]       do_sys_openat2+0x1ff/0x300
[    7.083505]       do_sys_open+0x51/0x60
[    7.083507]       do_syscall_64+0x3a/0x90
[    7.083509]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[    7.083511] 
[    7.083511] [W] __raw_read_lock(&journal->j_state_lock:8):
[    7.083512] [<ffffffff8133cd87>] start_this_handle+0xa7/0x5e0
[    7.083515] stacktrace:
[    7.083516]       _raw_read_lock+0x57/0xd0
[    7.083518]       start_this_handle+0xa7/0x5e0
[    7.083519]       jbd2__journal_start+0xe6/0x220
[    7.083521]       __ext4_journal_start_sb+0x11c/0x150
[    7.083523]       ext4_setattr+0x436/0x8f0
[    7.083524]       notify_change+0x352/0x4c0
[    7.083527]       do_truncate+0x6a/0xa0
[    7.083528]       path_openat+0x646/0x9c0
[    7.083530]       do_filp_open+0xaf/0x110
[    7.083531]       do_sys_openat2+0x1ff/0x300
[    7.083533]       do_sys_open+0x51/0x60
[    7.083535]       do_syscall_64+0x3a/0x90
[    7.083536]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[    7.083538] 
[    7.083539] [E] up_write(&sb->s_type->i_mutex_key:0):
[    7.083540] [<ffffffff81228381>] do_truncate+0x81/0xa0
[    7.083541] stacktrace:
[    7.083542]       up_write+0x36/0x170
[    7.083545]       do_truncate+0x81/0xa0
[    7.083547]       path_openat+0x646/0x9c0
[    7.083548]       do_filp_open+0xaf/0x110
[    7.083550]       do_sys_openat2+0x1ff/0x300
[    7.083552]       do_sys_open+0x51/0x60
[    7.083553]       do_syscall_64+0x3a/0x90
[    7.083555]       entry_SYSCALL_64_after_hwframe+0x44/0xae
[    7.083557] ---------------------------------------------------
[    7.083557] information that might be helpful
[    7.083558] ---------------------------------------------------
[    7.083559] CPU: 2 PID: 628 Comm: rs:main Q:Reg Tainted: G        W         5.17.0-rc1-00014-gcf3441bb2012 #2
[    7.083561] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[    7.083563] Call Trace:
[    7.083564]  <TASK>
[    7.083565]  dump_stack_lvl+0x44/0x57
[    7.083568]  print_circle+0x384/0x510
[    7.083570]  ? __kernel_text_address+0x9/0x30
[    7.083572]  ? print_circle+0x510/0x510
[    7.083574]  cb_check_dl+0x58/0x60
[    7.083575]  bfs+0xdc/0x1b0
[    7.083578]  add_dep+0x94/0x120
[    7.083580]  do_event.isra.22+0x284/0x300
[    7.083582]  ? __wake_up_common+0x93/0x1a0
[    7.083583]  dept_event+0x12b/0x1f0
[    7.083586]  __wake_up_common+0xb0/0x1a0
[    7.083588]  __wake_up_common_lock+0x65/0x90
[    7.083590]  __jbd2_log_start_commit+0x8a/0xa0
[    7.083591]  jbd2_log_start_commit+0x24/0x40
[    7.083593]  __jbd2_journal_force_commit+0x91/0xb0
[    7.083595]  jbd2_journal_force_commit_nested+0x5/0x10
[    7.083597]  ext4_should_retry_alloc+0x5b/0xb0
[    7.083598]  ext4_da_write_begin+0xf2/0x2a0
[    7.083601]  generic_perform_write+0xa6/0x1c0
[    7.083604]  ext4_buffered_write_iter+0x89/0x100
[    7.083606]  ext4_file_write_iter+0x4a/0x7f0
[    7.083609]  new_sync_write+0x100/0x190
[    7.083612]  vfs_write+0x134/0x360
[    7.083615]  ksys_write+0x4d/0xc0
[    7.083616]  ? trace_hardirqs_on+0x38/0xe0
[    7.083619]  do_syscall_64+0x3a/0x90
[    7.083621]  entry_SYSCALL_64_after_hwframe+0x44/0xae
