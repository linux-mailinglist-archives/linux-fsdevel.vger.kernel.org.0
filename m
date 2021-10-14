Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B26A42DE89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 17:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhJNPrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 11:47:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58268 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhJNPrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:47:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3CAA41FD3A;
        Thu, 14 Oct 2021 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634226318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xlba8fQlLTV+uf/QFNHdvELwK8agBCfU4HJu/918Gg8=;
        b=PUmxe7JODhvk617rHZJOz6J0mOpqx82GVdbwTSvLRDl2C9tHOK3ag1uG8ee9W5Sgn4HlwO
        D5Aj1we+h8PYc1Ce46L/fOjYBZfBDzld/geTplXqV7DdNgP2uwQdbpZhDTdNcp8ECT0TXJ
        JHI+QNX6MznhQ0FYu+LOI2ObSEUKfKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634226318;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xlba8fQlLTV+uf/QFNHdvELwK8agBCfU4HJu/918Gg8=;
        b=lKB5WgO9+rvi5JqCXTvPW2zGQWlbRr9VQQKOzZpEHUsht0Bd9cR60mMgCn9WjItADyRJ96
        oGqbSC29tT69nHDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DE0A13D9F;
        Thu, 14 Oct 2021 15:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PFOvAo5QaGEXIwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 14 Oct 2021 15:45:18 +0000
Message-ID: <8420753a-1ae0-17ed-f486-c4ae42b040e0@suse.cz>
Date:   Thu, 14 Oct 2021 17:45:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/8] mm/vmscan: Throttle reclaim when no progress is being
 made
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
 <20211008135332.19567-4-mgorman@techsingularity.net>
 <63336163-e709-65de-6d53-8764facd3924@suse.cz>
 <20211014130312.GA3959@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211014130312.GA3959@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/14/21 15:03, Mel Gorman wrote:
> On Thu, Oct 14, 2021 at 02:31:17PM +0200, Vlastimil Babka wrote:
>> On 10/8/21 15:53, Mel Gorman wrote:
>> > Memcg reclaim throttles on congestion if no reclaim progress is made.
>> > This makes little sense, it might be due to writeback or a host of
>> > other factors.
>> > 
>> > For !memcg reclaim, it's messy. Direct reclaim primarily is throttled
>> > in the page allocator if it is failing to make progress. Kswapd
>> > throttles if too many pages are under writeback and marked for
>> > immediate reclaim.
>> > 
>> > This patch explicitly throttles if reclaim is failing to make progress.
>> > 
>> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>> ...
>> > @@ -3769,6 +3797,16 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>> >  	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
>> >  	set_task_reclaim_state(current, NULL);
>> >  
>> > +	if (!nr_reclaimed) {
>> > +		struct zoneref *z;
>> > +		pg_data_t *pgdat;
>> > +
>> > +		z = first_zones_zonelist(zonelist, sc.reclaim_idx, sc.nodemask);
>> > +		pgdat = zonelist_zone(z)->zone_pgdat;
>> > +
>> > +		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS, HZ/10);
>> > +	}
>> 
>> Is this necessary? AFAICS here we just returned from:
>> 
>> do_try_to_free_pages()
>>   shrink_zones()
>>    for_each_zone()...
>>      consider_reclaim_throttle()
>> 
>> Which already throttles when needed and using the appropriate pgdat, while
>> here we have to somewhat awkwardly assume the preferred one.
>> 
> 
> Yes, you're right, consider_reclaim_throttle not only throttles on the
> appropriate pgdat but takes priority into account.
> 
> Well spotted!

So with that part removed
Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

