Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1644B7F51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 05:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbiBPERa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 23:17:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343883AbiBPERO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:17:14 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 007E4104599
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 20:16:09 -0800 (PST)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.53 with ESMTP; 16 Feb 2022 13:16:08 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 16 Feb 2022 13:16:08 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Report 2 in ata_scsi_port_error_handler()
Date:   Wed, 16 Feb 2022 13:16:02 +0900
Message-Id: <1644984964-28300-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1644984747-26706-1-git-send-email-byungchul.park@lge.com>
References: <1644984747-26706-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[    2.051991] ===================================================
[    2.051991] DEPT: Circular dependency has been detected.
[    2.051991] 5.17.0-rc1-00014-gcf3441bb2012 #2 Tainted: G        W        
[    2.051991] ---------------------------------------------------
[    2.051991] summary
[    2.051991] ---------------------------------------------------
[    2.051991] *** DEADLOCK ***
[    2.051991] 
[    2.051991] context A
[    2.051991]     [S] (unknown)(&(&ap->eh_wait_q)->dmap:0)
[    2.051991]     [W] wait_for_completion_timeout(&wait:0)
[    2.051991]     [E] event(&(&ap->eh_wait_q)->dmap:0)
[    2.051991] 
[    2.051991] context B
[    2.051991]     [S] __raw_spin_lock_irqsave(&host->lock:0)
[    2.051991]     [W] wait(&(&ap->eh_wait_q)->dmap:0)
[    2.051991]     [E] spin_unlock(&host->lock:0)
[    2.051991] 
[    2.051991] context C
[    2.051991]     [S] (unknown)(&wait:0)
[    2.051991]     [W] __raw_spin_lock_irq(&host->lock:0)
[    2.051991]     [E] complete(&wait:0)
[    2.051991] 
[    2.051991] [S]: start of the event context
[    2.051991] [W]: the wait blocked
[    2.051991] [E]: the event not reachable
[    2.051991] ---------------------------------------------------
[    2.051991] context A's detail
[    2.051991] ---------------------------------------------------
[    2.051991] context A
[    2.051991]     [S] (unknown)(&(&ap->eh_wait_q)->dmap:0)
[    2.051991]     [W] wait_for_completion_timeout(&wait:0)
[    2.051991]     [E] event(&(&ap->eh_wait_q)->dmap:0)
[    2.051991] 
[    2.051991] [S] (unknown)(&(&ap->eh_wait_q)->dmap:0):
[    2.051991] (N/A)
[    2.051991] 
[    2.051991] [W] wait_for_completion_timeout(&wait:0):
[    2.051991] [<ffffffff817763b1>] ata_exec_internal_sg+0x401/0x690
[    2.051991] stacktrace:
[    2.051991]       wait_for_completion_timeout+0x40/0xf0
[    2.051991]       ata_exec_internal_sg+0x401/0x690
[    2.051991]       ata_exec_internal+0x4a/0x70
[    2.051991]       ata_dev_read_id+0x2ce/0x540
[    2.051991]       ata_dev_reread_id+0x33/0xc0
[    2.051991]       ata_dev_revalidate+0x41/0x190
[    2.051991]       ata_do_set_mode+0x61c/0xac0
[    2.051991]       ata_set_mode+0xfc/0x110
[    2.051991]       ata_eh_recover+0x1061/0x1360
[    2.051991]       ata_do_eh+0x3f/0xa0
[    2.051991]       ata_scsi_port_error_handler+0x432/0x740
[    2.051991]       ata_scsi_error+0x94/0xc0
[    2.051991]       scsi_error_handler+0x8d/0x3a0
[    2.051991]       kthread+0xe3/0x110
[    2.051991]       ret_from_fork+0x22/0x30
[    2.051991] 
[    2.051991] [E] event(&(&ap->eh_wait_q)->dmap:0):
[    2.051991] [<ffffffff810baa53>] __wake_up_common+0x93/0x1a0
[    2.051991] stacktrace:
[    2.051991]       dept_event+0x12b/0x1f0
[    2.051991]       __wake_up_common+0xb0/0x1a0
[    2.051991]       __wake_up_common_lock+0x65/0x90
[    2.051991]       ata_scsi_port_error_handler+0x67a/0x740
[    2.051991]       ata_scsi_error+0x94/0xc0
[    2.051991]       scsi_error_handler+0x8d/0x3a0
[    2.051991]       kthread+0xe3/0x110
[    2.051991]       ret_from_fork+0x22/0x30
[    2.051991] ---------------------------------------------------
[    2.051991] context B's detail
[    2.051991] ---------------------------------------------------
[    2.051991] context B
[    2.051991]     [S] __raw_spin_lock_irqsave(&host->lock:0)
[    2.051991]     [W] wait(&(&ap->eh_wait_q)->dmap:0)
[    2.051991]     [E] spin_unlock(&host->lock:0)
[    2.051991] 
[    2.051991] [S] __raw_spin_lock_irqsave(&host->lock:0):
[    2.051991] [<ffffffff8178047c>] ata_port_wait_eh+0x6c/0xc0
[    2.051991] stacktrace:
[    2.051991]       _raw_spin_lock_irqsave+0x82/0xa0
[    2.051991]       ata_port_wait_eh+0x6c/0xc0
[    2.051991]       ata_port_probe+0x1f/0x30
[    2.051991]       async_port_probe+0x27/0x50
[    2.051991]       async_run_entry_fn+0x21/0xa0
[    2.051991]       process_one_work+0x317/0x640
[    2.051991]       worker_thread+0x44/0x410
[    2.051991]       kthread+0xe3/0x110
[    2.051991]       ret_from_fork+0x22/0x30
[    2.051991] 
[    2.051991] [W] wait(&(&ap->eh_wait_q)->dmap:0):
[    2.051991] [<ffffffff810bb017>] prepare_to_wait+0x47/0xd0
[    2.051991] stacktrace:
[    2.051991]       ata_port_wait_eh+0x52/0xc0
[    2.051991]       ata_port_probe+0x1f/0x30
[    2.051991]       async_port_probe+0x27/0x50
[    2.051991]       async_run_entry_fn+0x21/0xa0
[    2.051991]       process_one_work+0x317/0x640
[    2.051991]       worker_thread+0x44/0x410
[    2.051991]       kthread+0xe3/0x110
[    2.051991]       ret_from_fork+0x22/0x30
[    2.051991] 
[    2.051991] [E] spin_unlock(&host->lock:0):
[    2.051991] [<ffffffff8178046e>] ata_port_wait_eh+0x5e/0xc0
[    2.051991] stacktrace:
[    2.051991]       _raw_spin_unlock_irqrestore+0x35/0x80
[    2.051991]       ata_port_wait_eh+0x5e/0xc0
[    2.051991]       ata_port_probe+0x1f/0x30
[    2.051991]       async_port_probe+0x27/0x50
[    2.051991]       async_run_entry_fn+0x21/0xa0
[    2.051991]       process_one_work+0x317/0x640
[    2.051991]       worker_thread+0x44/0x410
[    2.051991]       kthread+0xe3/0x110
[    2.051991]       ret_from_fork+0x22/0x30
[    2.051991] ---------------------------------------------------
[    2.051991] context C's detail
[    2.051991] ---------------------------------------------------
[    2.051991] context C
[    2.051991]     [S] (unknown)(&wait:0)
[    2.051991]     [W] __raw_spin_lock_irq(&host->lock:0)
[    2.051991]     [E] complete(&wait:0)
[    2.051991] 
[    2.051991] [S] (unknown)(&wait:0):
[    2.051991] (N/A)
[    2.051991] 
[    2.051991] [W] __raw_spin_lock_irq(&host->lock:0):
[    2.051991] [<ffffffff8178c51b>] ata_sff_pio_task+0x1b/0x1b0
[    2.051991] stacktrace:
[    2.051991]       _raw_spin_lock_irq+0x58/0x90
[    2.051991]       ata_sff_pio_task+0x1b/0x1b0
[    2.051991]       process_one_work+0x317/0x640
[    2.051991]       worker_thread+0x44/0x410
[    2.051991]       kthread+0xe3/0x110
[    2.051991]       ret_from_fork+0x22/0x30
[    2.051991] 
[    2.051991] [E] complete(&wait:0):
[    2.051991] [<ffffffff81780569>] ata_do_link_abort+0x99/0xd0
[    2.051991] stacktrace:
[    2.051991]       complete+0x28/0x60
[    2.051991]       ata_do_link_abort+0x99/0xd0
[    2.051991]       ata_sff_hsm_move+0xfc/0xad0
[    2.051991]       ata_sff_pio_task+0x177/0x1b0
[    2.051991]       process_one_work+0x317/0x640
[    2.051991]       worker_thread+0x44/0x410
[    2.051991]       kthread+0xe3/0x110
[    2.051991]       ret_from_fork+0x22/0x30
[    2.051991] ---------------------------------------------------
[    2.051991] information that might be helpful
[    2.051991] ---------------------------------------------------
[    2.051991] CPU: 1 PID: 53 Comm: scsi_eh_1 Tainted: G        W         5.17.0-rc1-00014-gcf3441bb2012 #2
[    2.051991] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[    2.051991] Call Trace:
[    2.051991]  <TASK>
[    2.051991]  dump_stack_lvl+0x44/0x57
[    2.051991]  print_circle+0x384/0x510
[    2.051991]  ? print_circle+0x510/0x510
[    2.051991]  cb_check_dl+0x58/0x60
[    2.051991]  bfs+0xdc/0x1b0
[    2.051991]  add_dep+0x94/0x120
[    2.051991]  do_event.isra.22+0x284/0x300
[    2.051991]  ? __wake_up_common+0x93/0x1a0
[    2.051991]  dept_event+0x12b/0x1f0
[    2.051991]  __wake_up_common+0xb0/0x1a0
[    2.051991]  __wake_up_common_lock+0x65/0x90
[    2.051991]  ata_scsi_port_error_handler+0x67a/0x740
[    2.051991]  ? trace_hardirqs_on+0x38/0xe0
[    2.051991]  ? scsi_eh_get_sense+0x150/0x150
[    2.051991]  ata_scsi_error+0x94/0xc0
[    2.051991]  scsi_error_handler+0x8d/0x3a0
[    2.051991]  ? _raw_spin_unlock_irqrestore+0x63/0x80
[    2.051991]  ? scsi_eh_get_sense+0x150/0x150
[    2.051991]  kthread+0xe3/0x110
[    2.051991]  ? kthread_complete_and_exit+0x20/0x20
[    2.051991]  ret_from_fork+0x22/0x30
[    2.051991]  </TASK>
