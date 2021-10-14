Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139AA42D484
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 10:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhJNIIi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 04:08:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49420 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhJNIIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 04:08:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0EB9C21A76;
        Thu, 14 Oct 2021 08:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634198786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pu1BNJzoEuzb7mo16H8AVGb75lgjeaqs/coShQXeKw0=;
        b=JS+6WW+McvGEZ9tbfCRPDlCuSUM1QKQ/77I9SX9BKZ5cxF9HbuVikvnLe4gy9zhDX0BQMQ
        RQb1nCCM+5xTTykXaTx/eQasXt7j97fl7lslsq4taqe7QYnbG+cpoVo8a4aKDjqTWc4L4o
        IzwHJo+8t6jgQDxNI8BqrAtRYLaH1rE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634198786;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pu1BNJzoEuzb7mo16H8AVGb75lgjeaqs/coShQXeKw0=;
        b=dKik4kpyXpSwkzS8FoFeF70i9oSVkq64fEmS59andQKj4Lq+EcffuNNPZX3WhE1xM7rv71
        xGTy/stKlaC03DBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D00F213A1F;
        Thu, 14 Oct 2021 08:06:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yRUOMgHlZ2E0LwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 14 Oct 2021 08:06:25 +0000
Message-ID: <5e2c8c39-29d9-61be-049f-a408f62f5acf@suse.cz>
Date:   Thu, 14 Oct 2021 10:06:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     NeilBrown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
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
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/8] mm/vmscan: Throttle reclaim and compaction when too
 may pages are isolated
In-Reply-To: <20211008135332.19567-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/21 15:53, Mel Gorman wrote:
> Page reclaim throttles on congestion if too many parallel reclaim instances
> have isolated too many pages. This makes no sense, excessive parallelisation
> has nothing to do with writeback or congestion.
> 
> This patch creates an additional workqueue to sleep on when too many
> pages are isolated. The throttled tasks are woken when the number
> of isolated pages is reduced or a timeout occurs. There may be
> some false positive wakeups for GFP_NOIO/GFP_NOFS callers but
> the tasks will throttle again if necessary.
> 
> [shy828301@gmail.com: Wake up from compaction context]
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

...

> diff --git a/mm/internal.h b/mm/internal.h
> index 90764d646e02..06d0c376efcd 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -45,6 +45,15 @@ static inline void acct_reclaim_writeback(struct page *page)
>  		__acct_reclaim_writeback(pgdat, page, nr_throttled);
>  }
>  
> +static inline void wake_throttle_isolated(pg_data_t *pgdat)
> +{
> +	wait_queue_head_t *wqh;
> +
> +	wqh = &pgdat->reclaim_wait[VMSCAN_THROTTLE_ISOLATED];
> +	if (waitqueue_active(wqh))
> +		wake_up_all(wqh);

Again, would it be better to wake up just one task to prevent possible
thundering herd? We can assume that that task will call too_many_isolated()
eventually to wake up the next one? Although it seems strange that
too_many_isolated() is the place where we detect the situation for wake up.
Simpler than to hook into NR_ISOLATED decrementing I guess.

> +}
> +
>  vm_fault_t do_swap_page(struct vm_fault *vmf);
>  
>  void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
...
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1006,11 +1006,10 @@ static void handle_write_error(struct address_space *mapping,
>  	unlock_page(page);
>  }
>  
> -static void
> -reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
> +void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
>  							long timeout)
>  {
> -	wait_queue_head_t *wqh = &pgdat->reclaim_wait;
> +	wait_queue_head_t *wqh = &pgdat->reclaim_wait[reason];

It seems weird that later in this function we increase nr_reclaim_throttled
without distinguishing the reason, so effectively throttling for isolated
pages will trigger acct_reclaim_writeback() doing the NR_THROTTLED_WRITTEN
counting, although it's not related at all? Maybe either have separate
nr_reclaim_throttled counters per vmscan_throttle_state (if counter of
isolated is useful, I haven't seen the rest of series yet), or count only
VMSCAN_THROTTLE_WRITEBACK tasks?

>  	long ret;
>  	DEFINE_WAIT(wait);
>  
> @@ -1053,7 +1052,7 @@ void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page,
>  		READ_ONCE(pgdat->nr_reclaim_start);
>  
>  	if (nr_written > SWAP_CLUSTER_MAX * nr_throttled)
> -		wake_up_all(&pgdat->reclaim_wait);
> +		wake_up_all(&pgdat->reclaim_wait[VMSCAN_THROTTLE_WRITEBACK]);
>  }
>  
>  /* possible outcome of pageout() */

