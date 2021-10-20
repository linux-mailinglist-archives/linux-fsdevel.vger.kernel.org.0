Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E0E434FE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 18:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhJTQPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 12:15:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36420 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhJTQPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:15:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B6D431FD33;
        Wed, 20 Oct 2021 16:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634746377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vLul4D/8yAMLAlxlyHQL8FOE6rchzc+UwwIZVRpSnwM=;
        b=CgrCDhGr32kV69NWuBVEAWhjRo2bgD130IHXbNd3Qoow5s3ALzV97WRiBjpUvbV1RLPreR
        nqDpPMQD5LgDsmZmZbtRrNR4ekrGRcnRw/7WwCVWS/9yKTFre5fnIAjWvKrSv+ruy7sai7
        HcUnRRfuwR3j7YmOxuoADoT8ukwcLkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634746377;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vLul4D/8yAMLAlxlyHQL8FOE6rchzc+UwwIZVRpSnwM=;
        b=A47yFVqw6k0Cfj4SEX1EbCfcVjgQCpe3Vh4YCf7olrOz6Z38PH9ZeWd+SoYrRfdoeBZ1ot
        3ZKhuTSV+fBZDQBg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id AAEFAA3B84;
        Wed, 20 Oct 2021 16:12:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EDEC11F2C7D; Wed, 20 Oct 2021 18:12:54 +0200 (CEST)
Date:   Wed, 20 Oct 2021 18:12:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/fs-writeback.c: add a preemption point to
 move_expired_inodes
Message-ID: <20211020161254.GC16460@quack2.suse.cz>
References: <20210928173404.10794-1-wenyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928173404.10794-1-wenyang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 29-09-21 01:34:04, Wen Yang wrote:
> We encountered an unrecovered_softlockup issue on !PREEMPT
> kernel config with 4.9 based kernel.
> 
> PID: 185895  TASK: ffff880455dac280  CPU: 8   COMMAND: "kworker/u449:39"
>  #0 [ffff883f7e803c08] machine_kexec at ffffffff81061578
>  #1 [ffff883f7e803c68] __crash_kexec at ffffffff81127c19
>  #2 [ffff883f7e803d30] panic at ffffffff811b2255
>  #3 [ffff883f7e803db8] unrecovered_softlockup_detect at ffffffff811b2d57
>  #4 [ffff883f7e803ee0] watchdog_timer_fn at ffffffff8115827e
>  #5 [ffff883f7e803f18] __hrtimer_run_queues at ffffffff811085e3
>  #6 [ffff883f7e803f70] hrtimer_interrupt at ffffffff81108d8a
>  #7 [ffff883f7e803fc0] local_apic_timer_interrupt at ffffffff810580f8
>  #8 [ffff883f7e803fd8] smp_apic_timer_interrupt at ffffffff81745405
>  #9 [ffff883f7e803ff0] apic_timer_interrupt at ffffffff81743b90
>  --- <IRQ stack> ---
>  #10 [ffffc90086a93b88] apic_timer_interrupt at ffffffff81743b90
>     [exception RIP: __list_del_entry+44]
>     RIP: ffffffff813be22c  RSP: ffffc90086a93c30  RFLAGS: 00000202
>     RAX: ffff88522b8f8418  RBX: ffff88522b8f8418  RCX: dead000000000200
>     RDX: ffff8816fab00e68  RSI: ffffc90086a93c60  RDI: ffff8816fab01af8
>     RBP: ffffc90086a93c30   R8: ffff8816fab01af8   R9: 0000000100400018
>     R10: ffff885ae5ed8280  R11: 0000000000000000  R12: ffff8816fab01af8
>     R13: ffffc90086a93c60  R14: ffffc90086a93d08  R15: ffff883f631d2000
>     ORIG_RAX: ffffffffffffff10  CS: 0010  SS: 0000
>  #11 [ffffc90086a93c38] move_expired_inodes at ffffffff8127c74c
>  #12 [ffffc90086a93ca8] queue_io at ffffffff8127cde6
>  #13 [ffffc90086a93cd8] wb_writeback at ffffffff8128121f
>  #14 [ffffc90086a93d80] wb_workfn at ffffffff812819f4
>  #15 [ffffc90086a93e18] process_one_work at ffffffff810a5dc9
>  #16 [ffffc90086a93e60] worker_thread at ffffffff810a60ae
>  #17 [ffffc90086a93ec0] kthread at ffffffff810ac696
>  #18 [ffffc90086a93f50] ret_from_fork at ffffffff81741dd9
> 
> crash> set
>     PID: 185895
> COMMAND: "kworker/u449:39"
>    TASK: ffff880455dac280  [THREAD_INFO: ffff880455dac280]
>     CPU: 8
>   STATE: TASK_RUNNING (PANIC)
> 
> It has been running continuously for 53.052, as follows:
> crash> ps -m | grep 185895
> [  0 00:00:53.052] [RU]  PID: 185895  TASK: ffff880455dac280  CPU: 8
> COMMAND: "kworker/u449:39"
> 
> And the TIF_NEED_RESCHED flag has been set, as follows:
> crash> struct thread_info -x ffff880455dac280
> struct thread_info {
>   flags = 0x88,
>   status = 0x0
> }
> 
> Let's just add cond_resched() within move_expired_inodes()'s list-moving loop in
> order to avoid the watchdog splats.
> 
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/fs-writeback.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 06d04a7..1546121 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1404,6 +1404,7 @@ static int move_expired_inodes(struct list_head *delaying_queue,
>  		if (sb && sb != inode->i_sb)
>  			do_sb_sort = 1;
>  		sb = inode->i_sb;
> +		cond_resched();

Thanks for the patch but you certainly cannot do this since we are holding
wb->list_lock during the whole move_expired_inodes() duration. It is not
trivial to implement safe dropping of the lock in move_expired_inodes() (or
queue_io() for that matter). How many inodes were there on b_dirty, b_io,
b_more_io, and tmp lists and from how many superblocks?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
