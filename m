Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CBF42DE87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 17:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhJNPq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 11:46:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51834 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhJNPq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:46:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B28621A86;
        Thu, 14 Oct 2021 15:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634226290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yETFwcK2C7cMJFBaCxWiKVPeEh6TcyAd0FiTesVUB/g=;
        b=TwwWH2OS7X9f3XQWQTjoJcTt3gtboI1WhZAk/6NCI3VzJPaCmWsECQuECckarHLycxvJpq
        Z1oe8CgbHh2IAgTtVzhRHmn0f1KxS/zvp8HEVeTac3bqIU7Rj58CvHntNRh+BNeA9CXHwF
        /3IjEwJmWzuqnon5to8it53gUfJ8lVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634226290;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yETFwcK2C7cMJFBaCxWiKVPeEh6TcyAd0FiTesVUB/g=;
        b=A/SGo819Ji9ZLhA7GV61ByKq6PjHEDjbT7xxWW+BictAko6eFVus07GepPeQCFB066Ia3k
        U7S0V+km70Dhs8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F48913D9F;
        Thu, 14 Oct 2021 15:44:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Kgu1EnJQaGG3IgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 14 Oct 2021 15:44:50 +0000
Message-ID: <1953635e-a97a-eff3-8019-3d012b065938@suse.cz>
Date:   Thu, 14 Oct 2021 17:44:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/8] mm/vmscan: Throttle reclaim and compaction when too
 may pages are isolated
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211008135332.19567-1-mgorman@techsingularity.net>
 <20211008135332.19567-3-mgorman@techsingularity.net>
 <5e2c8c39-29d9-61be-049f-a408f62f5acf@suse.cz>
 <20211014115632.GZ3959@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211014115632.GZ3959@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/14/21 13:56, Mel Gorman wrote:
> On Thu, Oct 14, 2021 at 10:06:25AM +0200, Vlastimil Babka wrote:
>> On 10/8/21 15:53, Mel Gorman wrote:
>> > Page reclaim throttles on congestion if too many parallel reclaim instances
>> > have isolated too many pages. This makes no sense, excessive parallelisation
>> > has nothing to do with writeback or congestion.
>> > 
>> > This patch creates an additional workqueue to sleep on when too many
>> > pages are isolated. The throttled tasks are woken when the number
>> > of isolated pages is reduced or a timeout occurs. There may be
>> > some false positive wakeups for GFP_NOIO/GFP_NOFS callers but
>> > the tasks will throttle again if necessary.
>> > 
>> > [shy828301@gmail.com: Wake up from compaction context]
>> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>> 
>> ...
>> 
>> > diff --git a/mm/internal.h b/mm/internal.h
>> > index 90764d646e02..06d0c376efcd 100644
>> > --- a/mm/internal.h
>> > +++ b/mm/internal.h
>> > @@ -45,6 +45,15 @@ static inline void acct_reclaim_writeback(struct page *page)
>> >  		__acct_reclaim_writeback(pgdat, page, nr_throttled);
>> >  }
>> >  
>> > +static inline void wake_throttle_isolated(pg_data_t *pgdat)
>> > +{
>> > +	wait_queue_head_t *wqh;
>> > +
>> > +	wqh = &pgdat->reclaim_wait[VMSCAN_THROTTLE_ISOLATED];
>> > +	if (waitqueue_active(wqh))
>> > +		wake_up_all(wqh);
>> 
>> Again, would it be better to wake up just one task to prevent possible
>> thundering herd? We can assume that that task will call too_many_isolated()
>> eventually to wake up the next one?
> 
> Same problem as the writeback throttling, there is no prioritsation of
> light vs heavy allocators.
> 
>> Although it seems strange that
>> too_many_isolated() is the place where we detect the situation for wake up.
>> Simpler than to hook into NR_ISOLATED decrementing I guess.
>> 
> 
> Simplier but more costly. Every decrement would have to check
> too_many_isolated(). I think the cost of that is too high given that the
> VMSCAN_THROTTLE_ISOLATED is relatively hard to trigger and the minority
> of throttling events.

Agreed.

>> > +}
>> > +
>> >  vm_fault_t do_swap_page(struct vm_fault *vmf);
>> >  
>> >  void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
>> ...
>> > --- a/mm/vmscan.c
>> > +++ b/mm/vmscan.c
>> > @@ -1006,11 +1006,10 @@ static void handle_write_error(struct address_space *mapping,
>> >  	unlock_page(page);
>> >  }
>> >  
>> > -static void
>> > -reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
>> > +void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
>> >  							long timeout)
>> >  {
>> > -	wait_queue_head_t *wqh = &pgdat->reclaim_wait;
>> > +	wait_queue_head_t *wqh = &pgdat->reclaim_wait[reason];
>> 
>> It seems weird that later in this function we increase nr_reclaim_throttled
>> without distinguishing the reason, so effectively throttling for isolated
>> pages will trigger acct_reclaim_writeback() doing the NR_THROTTLED_WRITTEN
>> counting, although it's not related at all? Maybe either have separate
>> nr_reclaim_throttled counters per vmscan_throttle_state (if counter of
>> isolated is useful, I haven't seen the rest of series yet), or count only
>> VMSCAN_THROTTLE_WRITEBACK tasks?
>> 
> 
> Very good point, it would be more appropriate to only count the
> writeback reason.
> 
> Diff on top is below. It'll cause minor conflicts later in the series.

Looks good, for the updated version:

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index ca65d6a64bdd..58a25d42c31c 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -849,7 +849,7 @@ typedef struct pglist_data {
>  	wait_queue_head_t kswapd_wait;
>  	wait_queue_head_t pfmemalloc_wait;
>  	wait_queue_head_t reclaim_wait[NR_VMSCAN_THROTTLE];
> -	atomic_t nr_reclaim_throttled;	/* nr of throtted tasks */
> +	atomic_t nr_writeback_throttled;/* nr of writeback-throttled tasks */
>  	unsigned long nr_reclaim_start;	/* nr pages written while throttled
>  					 * when throttling started. */
>  	struct task_struct *kswapd;	/* Protected by
> diff --git a/mm/internal.h b/mm/internal.h
> index 06d0c376efcd..3461a1055975 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -39,7 +39,7 @@ void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page,
>  static inline void acct_reclaim_writeback(struct page *page)
>  {
>  	pg_data_t *pgdat = page_pgdat(page);
> -	int nr_throttled = atomic_read(&pgdat->nr_reclaim_throttled);
> +	int nr_throttled = atomic_read(&pgdat->nr_writeback_throttled);
>  
>  	if (nr_throttled)
>  		__acct_reclaim_writeback(pgdat, page, nr_throttled);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 6e198bbbd86a..29434d4fc1c7 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1011,6 +1011,7 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
>  {
>  	wait_queue_head_t *wqh = &pgdat->reclaim_wait[reason];
>  	long ret;
> +	bool acct_writeback = (reason == VMSCAN_THROTTLE_WRITEBACK);
>  	DEFINE_WAIT(wait);
>  
>  	/*
> @@ -1022,7 +1023,8 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
>  	    current->flags & (PF_IO_WORKER|PF_KTHREAD))
>  		return;
>  
> -	if (atomic_inc_return(&pgdat->nr_reclaim_throttled) == 1) {
> +	if (acct_writeback &&
> +	    atomic_inc_return(&pgdat->nr_writeback_throttled) == 1) {
>  		WRITE_ONCE(pgdat->nr_reclaim_start,
>  			node_page_state(pgdat, NR_THROTTLED_WRITTEN));
>  	}
> @@ -1030,7 +1032,9 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
>  	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
>  	ret = schedule_timeout(timeout);
>  	finish_wait(wqh, &wait);
> -	atomic_dec(&pgdat->nr_reclaim_throttled);
> +
> +	if (acct_writeback)
> +		atomic_dec(&pgdat->nr_writeback_throttled);
>  
>  	trace_mm_vmscan_throttled(pgdat->node_id, jiffies_to_usecs(timeout),
>  				jiffies_to_usecs(timeout - ret),
> @@ -4349,7 +4353,7 @@ static int kswapd(void *p)
>  
>  	WRITE_ONCE(pgdat->kswapd_order, 0);
>  	WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
> -	atomic_set(&pgdat->nr_reclaim_throttled, 0);
> +	atomic_set(&pgdat->nr_writeback_throttled, 0);
>  	for ( ; ; ) {
>  		bool ret;
>  
> 

