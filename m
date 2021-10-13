Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB4A42C4F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 17:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhJMPlm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 11:41:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53866 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhJMPll (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:41:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DB7442199F;
        Wed, 13 Oct 2021 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634139576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNjFlLBCp8eIniFVxC2OTUCUHJDZc+bQGW4gxrxjguU=;
        b=2mNBWlrdAdRT1IpwE9rQPOuZw6AahAK19rjBykFGnH2K1nyTFnMqyyVT6I19SNAlfLbQL9
        gav+K0NvwaPnXEdVUrZ8RWSO1ZA9K3+4NSeMQ0obfx7sq9UL276QvTnTrBHQCtgUFoRihS
        FAVNP/qetNKkny0rkaZwQBsEaEvsW9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634139576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNjFlLBCp8eIniFVxC2OTUCUHJDZc+bQGW4gxrxjguU=;
        b=KqOOnrNZJ/HPOwlOsOK0o6nRptwG4pCDO5AkIv7nwQlkaAIFWH3/TlZZMxlrHZ/kqYhBw3
        g0zeQRk8Q1UqrZBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5B4813D05;
        Wed, 13 Oct 2021 15:39:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 06aHJ7j9ZmEDfQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 13 Oct 2021 15:39:36 +0000
Message-ID: <63898e7a-0846-3105-96b5-76c89635e499@suse.cz>
Date:   Wed, 13 Oct 2021 17:39:36 +0200
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
 <20211008135332.19567-2-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 1/8] mm/vmscan: Throttle reclaim until some writeback
 completes if congested
In-Reply-To: <20211008135332.19567-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/21 15:53, Mel Gorman wrote:
> Page reclaim throttles on wait_iff_congested under the following conditions
> 
> o kswapd is encountering pages under writeback and marked for immediate
>   reclaim implying that pages are cycling through the LRU faster than
>   pages can be cleaned.
> 
> o Direct reclaim will stall if all dirty pages are backed by congested
>   inodes.
> 
> wait_iff_congested is almost completely broken with few exceptions. This
> patch adds a new node-based workqueue and tracks the number of throttled
> tasks and pages written back since throttling started. If enough pages
> belonging to the node are written back then the throttled tasks will wake
> early. If not, the throttled tasks sleeps until the timeout expires.
> 
> [neilb@suse.de: Uninterruptible sleep and simpler wakeups]
> [hdanton@sina.com: Avoid race when reclaim starts]
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Seems mostly OK, have just some doubts wrt NR_THROTTLED_WRITTEN mechanics,
that may ultimately be just a point of comments to add.

...

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1006,6 +1006,56 @@ static void handle_write_error(struct address_space *mapping,
>  	unlock_page(page);
>  }
>  
> +static void
> +reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
> +							long timeout)
> +{
> +	wait_queue_head_t *wqh = &pgdat->reclaim_wait;
> +	long ret;
> +	DEFINE_WAIT(wait);
> +
> +	/*
> +	 * Do not throttle IO workers, kthreads other than kswapd or
> +	 * workqueues. They may be required for reclaim to make
> +	 * forward progress (e.g. journalling workqueues or kthreads).
> +	 */
> +	if (!current_is_kswapd() &&
> +	    current->flags & (PF_IO_WORKER|PF_KTHREAD))
> +		return;
> +
> +	if (atomic_inc_return(&pgdat->nr_reclaim_throttled) == 1) {
> +		WRITE_ONCE(pgdat->nr_reclaim_start,
> +			node_page_state(pgdat, NR_THROTTLED_WRITTEN));
> +	}
> +
> +	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
> +	ret = schedule_timeout(timeout);
> +	finish_wait(wqh, &wait);
> +	atomic_dec(&pgdat->nr_reclaim_throttled);
> +
> +	trace_mm_vmscan_throttled(pgdat->node_id, jiffies_to_usecs(timeout),
> +				jiffies_to_usecs(timeout - ret),
> +				reason);
> +}
> +
> +/*
> + * Account for pages written if tasks are throttled waiting on dirty
> + * pages to clean. If enough pages have been cleaned since throttling
> + * started then wakeup the throttled tasks.
> + */
> +void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page,
> +							int nr_throttled)
> +{
> +	unsigned long nr_written;
> +
> +	__inc_node_page_state(page, NR_THROTTLED_WRITTEN);

Is this intentionally using the __ version that normally expects irqs to be
disabled (AFAIK they are not in this path)? I think this is rarely used cold
path so it doesn't seem worth to trade off speed for accuracy.

> +	nr_written = node_page_state(pgdat, NR_THROTTLED_WRITTEN) -
> +		READ_ONCE(pgdat->nr_reclaim_start);

Even if the inc above was safe, node_page_state() will return only the
global counter, so the value we read here will only actually increment when
some cpu's counter overflows, so it will be "bursty". Maybe it's ok, just
worth documenting?

> +
> +	if (nr_written > SWAP_CLUSTER_MAX * nr_throttled)
> +		wake_up_all(&pgdat->reclaim_wait);

Hm it seems a bit weird that the more tasks are throttled, the more we wait,
and then wake up all. Theoretically this will lead to even more
bursty/staggering herd behavior. Could be better to wake up single task each
SWAP_CLUSTER_MAX, and bump nr_reclaim_start? But maybe it's not a problem in
practice due to HZ/10 timeouts being short enough?

> +}
> +
