Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA5942DE78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 17:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhJNPpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 11:45:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57910 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhJNPo5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:44:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E10611FD3A;
        Thu, 14 Oct 2021 15:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634226171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktvk9Ng1I81Xzk6EWOKY2R4gf521naRNNhK9jlq78Og=;
        b=hbO4M27Gw5GtTGToMZRejX83TiFC517xGyW6eRIvtJacZVTwUDfzrdh3o/jT0zJQufLqbY
        ObRdI2NxsPhZGV5TC6cCM+MWyXdWvodiP5ZRV7X58VA7LuvBk1kbx2lh0HpPc5csS2zJNI
        ntYPI0TnDo6QNjHVEZ1B/nPaH8z5iwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634226171;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktvk9Ng1I81Xzk6EWOKY2R4gf521naRNNhK9jlq78Og=;
        b=a+IgH67l4t2igdJtPHMZecMvUVtlXnin1RqH1L4d7v9/mEce56VdFkA1XVTsWMFkMHAlqg
        bzOvSxTSmk3jvrBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A21A713D9F;
        Thu, 14 Oct 2021 15:42:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ox/xJvtPaGHRIQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 14 Oct 2021 15:42:51 +0000
Message-ID: <66e8e0cc-1abb-a283-1e0d-068124a84790@suse.cz>
Date:   Thu, 14 Oct 2021 17:42:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/8] mm/vmscan: Throttle reclaim until some writeback
 completes if congested
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
 <20211008135332.19567-2-mgorman@techsingularity.net>
 <63898e7a-0846-3105-96b5-76c89635e499@suse.cz>
 <20211014104744.GY3959@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211014104744.GY3959@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/14/21 12:47, Mel Gorman wrote:
> Thanks Vlastimil
> 
> On Wed, Oct 13, 2021 at 05:39:36PM +0200, Vlastimil Babka wrote:
>> > +/*
>> > + * Account for pages written if tasks are throttled waiting on dirty
>> > + * pages to clean. If enough pages have been cleaned since throttling
>> > + * started then wakeup the throttled tasks.
>> > + */
>> > +void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page,
>> > +							int nr_throttled)
>> > +{
>> > +	unsigned long nr_written;
>> > +
>> > +	__inc_node_page_state(page, NR_THROTTLED_WRITTEN);
>> 
>> Is this intentionally using the __ version that normally expects irqs to be
>> disabled (AFAIK they are not in this path)? I think this is rarely used cold
>> path so it doesn't seem worth to trade off speed for accuracy.
>> 
> 
> It was intentional because IRQs can be disabled and if it's race-prone,
> it's not overly problematic but you're right, better to be safe.  I changed
> it to the safe type as it's mostly free on x86, arm64 and s390 and for
> other architectures, this is a slow path.

Great, thanks.

>> > +	nr_written = node_page_state(pgdat, NR_THROTTLED_WRITTEN) -
>> > +		READ_ONCE(pgdat->nr_reclaim_start);
>> 
>> Even if the inc above was safe, node_page_state() will return only the
>> global counter, so the value we read here will only actually increment when
>> some cpu's counter overflows, so it will be "bursty". Maybe it's ok, just
>> worth documenting?
>> 
> 
> I didn't think the penalty of doing an accurate read while writeback
> throttled is worth it. I'll add a comment.
> 
>> > +
>> > +	if (nr_written > SWAP_CLUSTER_MAX * nr_throttled)
>> > +		wake_up_all(&pgdat->reclaim_wait);
>> 
>> Hm it seems a bit weird that the more tasks are throttled, the more we wait,
>> and then wake up all. Theoretically this will lead to even more
>> bursty/staggering herd behavior. Could be better to wake up single task each
>> SWAP_CLUSTER_MAX, and bump nr_reclaim_start? But maybe it's not a problem in
>> practice due to HZ/10 timeouts being short enough?
>> 
> 
> Yes, the more tasks are throttled the longer tasks wait because tasks are
> allocating faster than writeback can complete so I wanted to reduce the
> allocation pressure. I considered waking one task at a time but there is
> no prioritisation of tasks on the waitqueue and it's not clear that the
> additional complexity is justified. With inaccurate counters, a light
> allocator could get throttled for the full timeout unnecessarily.
> 
> Even if we were to wake one task at a time, I would prefer it was done
> as a potential optimisation on top.

Fair enough.

> Diff on top based on review feedback;

Thanks, with that you can add

Acked-by: Vlastimil Babka <vbabka@suse.cz>

to the updated version

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bcd22e53795f..735b1f2b5d9e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1048,7 +1048,15 @@ void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page,
>  {
>  	unsigned long nr_written;
>  
> -	__inc_node_page_state(page, NR_THROTTLED_WRITTEN);
> +	inc_node_page_state(page, NR_THROTTLED_WRITTEN);
> +
> +	/*
> +	 * This is an inaccurate read as the per-cpu deltas may not
> +	 * be synchronised. However, given that the system is
> +	 * writeback throttled, it is not worth taking the penalty
> +	 * of getting an accurate count. At worst, the throttle
> +	 * timeout guarantees forward progress.
> +	 */
>  	nr_written = node_page_state(pgdat, NR_THROTTLED_WRITTEN) -
>  		READ_ONCE(pgdat->nr_reclaim_start);
> 

