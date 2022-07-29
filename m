Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD595856DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jul 2022 00:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbiG2W3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 18:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiG2W3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 18:29:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176188C594;
        Fri, 29 Jul 2022 15:29:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 49C942032F;
        Fri, 29 Jul 2022 22:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659133782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E0TuExryY/ekNZtJLTSiSiBco3WSZ8uX2qoTD9LZG64=;
        b=vw+AUqU0dhFqA/mKq3TNLVahGIPr/V6F3qLv4/mCxKkKJN9xnLPVOF20P/fRsrQmhP0ul2
        ES4zUoka/ZRGM4HPT5Zzth31wBl0HuEMgkEOCx5orYxhR9JFpxnE6vCOx0qdKr6d5mScek
        cjH68yNiMS3v7GByG5KPvJGcawMG9Mg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659133782;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E0TuExryY/ekNZtJLTSiSiBco3WSZ8uX2qoTD9LZG64=;
        b=qzqW9eUnqM4rRrRxeOfLkk4/OH4OfGC1C8CFUqfvR5V/7w84Z4EXYwCSM8Tl3wceW/u49j
        +c9CjV2agGrcqTBQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 43EFC2C141;
        Fri, 29 Jul 2022 22:29:40 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E1146A0666; Sat, 30 Jul 2022 00:29:39 +0200 (CEST)
Date:   Sat, 30 Jul 2022 00:29:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Khazhismel Kumykov <khazhy@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Khazhismel Kumykov <khazhy@google.com>
Subject: Re: [PATCH] writeback: check wb shutdown for bw_dwork
Message-ID: <20220729222939.p6r4qs7gfgooay3n@quack3>
References: <20220729215123.1998585-1-khazhy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729215123.1998585-1-khazhy@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 29-07-22 14:51:23, Khazhismel Kumykov wrote:
> This fixes a KASAN splat in timer interrupt after removing a device
> 
> Move wb->work_lock to be irq-safe, as complete may be called from irq
> 
> Fixes: 45a2966fd641 ("writeback: fix bandwidth estimate for spiky workload")
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

The patch looks good but I wish there are more details in the changelog
because with this terse changelog I can only guess. I suppose something
like:

writeback: avoid use after free after removing a device

When a disk is removed, bdi_unregister() gets called to stop any further
writeback and wait for the running one to complete. However while IO
completes, wb_inode_writeback_end() will schedule another delayed writeback
and by the time timer fires the bdi_writeback structure may be already
freed. Fix the problem by checking whether bdi is still alive before
scheduling new work in wb_inode_writeback_end(). Since this requires
wb->work_lock and wb_inode_writeback_end() may get called from an
interrupt, switch wb->work_lock to an irqsafe lock.

								Honza

> ---
>  fs/fs-writeback.c   | 12 ++++++------
>  mm/backing-dev.c    | 10 +++++-----
>  mm/page-writeback.c |  6 +++++-
>  3 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 05221366a16d..08a1993ab7fd 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -134,10 +134,10 @@ static bool inode_io_list_move_locked(struct inode *inode,
>  
>  static void wb_wakeup(struct bdi_writeback *wb)
>  {
> -	spin_lock_bh(&wb->work_lock);
> +	spin_lock_irq(&wb->work_lock);
>  	if (test_bit(WB_registered, &wb->state))
>  		mod_delayed_work(bdi_wq, &wb->dwork, 0);
> -	spin_unlock_bh(&wb->work_lock);
> +	spin_unlock_irq(&wb->work_lock);
>  }
>  
>  static void finish_writeback_work(struct bdi_writeback *wb,
> @@ -164,7 +164,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
>  	if (work->done)
>  		atomic_inc(&work->done->cnt);
>  
> -	spin_lock_bh(&wb->work_lock);
> +	spin_lock_irq(&wb->work_lock);
>  
>  	if (test_bit(WB_registered, &wb->state)) {
>  		list_add_tail(&work->list, &wb->work_list);
> @@ -172,7 +172,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
>  	} else
>  		finish_writeback_work(wb, work);
>  
> -	spin_unlock_bh(&wb->work_lock);
> +	spin_unlock_irq(&wb->work_lock);
>  }
>  
>  /**
> @@ -2082,13 +2082,13 @@ static struct wb_writeback_work *get_next_work_item(struct bdi_writeback *wb)
>  {
>  	struct wb_writeback_work *work = NULL;
>  
> -	spin_lock_bh(&wb->work_lock);
> +	spin_lock_irq(&wb->work_lock);
>  	if (!list_empty(&wb->work_list)) {
>  		work = list_entry(wb->work_list.next,
>  				  struct wb_writeback_work, list);
>  		list_del_init(&work->list);
>  	}
> -	spin_unlock_bh(&wb->work_lock);
> +	spin_unlock_irq(&wb->work_lock);
>  	return work;
>  }
>  
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 95550b8fa7fe..de65cb1e5f76 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -260,10 +260,10 @@ void wb_wakeup_delayed(struct bdi_writeback *wb)
>  	unsigned long timeout;
>  
>  	timeout = msecs_to_jiffies(dirty_writeback_interval * 10);
> -	spin_lock_bh(&wb->work_lock);
> +	spin_lock_irq(&wb->work_lock);
>  	if (test_bit(WB_registered, &wb->state))
>  		queue_delayed_work(bdi_wq, &wb->dwork, timeout);
> -	spin_unlock_bh(&wb->work_lock);
> +	spin_unlock_irq(&wb->work_lock);
>  }
>  
>  static void wb_update_bandwidth_workfn(struct work_struct *work)
> @@ -334,12 +334,12 @@ static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb);
>  static void wb_shutdown(struct bdi_writeback *wb)
>  {
>  	/* Make sure nobody queues further work */
> -	spin_lock_bh(&wb->work_lock);
> +	spin_lock_irq(&wb->work_lock);
>  	if (!test_and_clear_bit(WB_registered, &wb->state)) {
> -		spin_unlock_bh(&wb->work_lock);
> +		spin_unlock_irq(&wb->work_lock);
>  		return;
>  	}
> -	spin_unlock_bh(&wb->work_lock);
> +	spin_unlock_irq(&wb->work_lock);
>  
>  	cgwb_remove_from_bdi_list(wb);
>  	/*
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 55c2776ae699..3c34db15cf70 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2867,6 +2867,7 @@ static void wb_inode_writeback_start(struct bdi_writeback *wb)
>  
>  static void wb_inode_writeback_end(struct bdi_writeback *wb)
>  {
> +	unsigned long flags;
>  	atomic_dec(&wb->writeback_inodes);
>  	/*
>  	 * Make sure estimate of writeback throughput gets updated after
> @@ -2875,7 +2876,10 @@ static void wb_inode_writeback_end(struct bdi_writeback *wb)
>  	 * that if multiple inodes end writeback at a similar time, they get
>  	 * batched into one bandwidth update.
>  	 */
> -	queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_INTERVAL);
> +	spin_lock_irqsave(&wb->work_lock, flags);
> +	if (test_bit(WB_registered, &wb->state))
> +		queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_INTERVAL);
> +	spin_unlock_irqrestore(&wb->work_lock, flags);
>  }
>  
>  bool __folio_end_writeback(struct folio *folio)
> -- 
> 2.37.1.455.g008518b4e5-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
