Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC6B45B88F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 11:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbhKXKqR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 05:46:17 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41722 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241577AbhKXKqR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 05:46:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8CFBA1FD2F;
        Wed, 24 Nov 2021 10:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637750586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5qH2vJRimoEPVvlz5XMmKpBZ8jTT26Izpiz+YPSs0Tk=;
        b=Cyyg3gwb5k1srIn7DejZQ0ESlHeR2Ep4lAdhJets6Tw+kK4KcXoIjcKb4OvDS4yFgjB1gF
        DxmbMkZr3OMr+8iMx8ePSq8ICExc+v/Z2CiZeK+uSbsVzhIV7R/REBv+0NtYWldZY9bbqR
        8jpsFkuIyRJrxacfDPt8zcnCyZESlEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637750586;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5qH2vJRimoEPVvlz5XMmKpBZ8jTT26Izpiz+YPSs0Tk=;
        b=VNIPV+myXL4PfJWKpp1XMA9vX4rHnJH0Sidi9Fw3+5Z7rrKsjVbMANky+AnfXkmvQESWH5
        2PS1rlxE7hUKsCDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 529FD13F05;
        Wed, 24 Nov 2021 10:43:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HchyEzoXnmF0bAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 24 Nov 2021 10:43:06 +0000
Message-ID: <cbf91d44-8c8f-15b4-a093-58c04d668156@suse.cz>
Date:   Wed, 24 Nov 2021 11:43:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/8] mm/vmscan: Throttle reclaim when no progress is being
 made
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211022144651.19914-1-mgorman@techsingularity.net>
 <20211022144651.19914-4-mgorman@techsingularity.net>
 <20211124011912.GA265983@magnolia>
 <20211124103221.GD3366@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211124103221.GD3366@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/24/21 11:32, Mel Gorman wrote:
> On Tue, Nov 23, 2021 at 05:19:12PM -0800, Darrick J. Wong wrote:
>> On Fri, Oct 22, 2021 at 03:46:46PM +0100, Mel Gorman wrote:
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
>> 
>> Hi Mel,
>> 
>> Ever since Christoph broke swapfiles, I've been carrying around a little
>> fstest in my dev tree[1] that tries to exercise paging things in and out
>> of a swapfile.  Sadly I've been trapped in about three dozen customer
>> escalations for over a month, which means I haven't been able to do much
>> upstream in weeks.  Like submit this test upstream. :(
>> 
>> Now that I've finally gotten around to trying out a 5.16-rc2 build, I
>> notice that the runtime of this test has gone from ~5s to 2 hours.
>> Among other things that it does, the test sets up a cgroup with a memory
>> controller limiting the memory usage to 25MB, then runs a program that
>> tries to dirty 50MB of memory.  There's 2GB of memory in the VM, so
>> we're not running reclaim globally, but the cgroup gets throttled very
>> severely.
>> 
> 
> Ok, so this test cannot make progress until some of the cgroup pages get
> cleaned. What is the expectation for the test? Should it OOM or do you
> expect it to have spin-like behaviour until some writeback completes?
> I'm guessing you'd prefer it to spin and right now it's sleeping far
> too much.
> 
>> AFAICT the system is mostly idle, but it's difficult to tell because ps
>> and top also get stuck waiting for this cgroup for whatever reason. 
> 
> But this is surprising because I expect that ps and top are not running
> within the cgroup. Was /proc/PID/stack readable? 
> 
>> My
>> uninformed spculation is that usemem_and_swapoff takes a page fault
>> while dirtying the 50MB memory buffer, prepares to pull a page in from
>> swap, tries to evict another page to stay under the memcg limit, but
>> that decides that it's making no progress and calls
>> reclaim_throttle(..., VMSCAN_THROTTLE_NOPROGRESS).
>> 
>> The sleep is uninterruptible, so I can't even kill -9 fstests to shut it
>> down.  Eventually we either finish the test or (for the mlock part) the
>> OOM killer actually kills the process, but this takes a very long time.
>> 
> 
> The sleep can be interruptible.
> 
>> Any thoughts?  For now I can just hack around this by skipping
>> reclaim_throttle if cgroup_reclaim() == true, but that's probably not
>> the correct fix. :)
>> 
> 
> No, it wouldn't be but a possibility is throttling for only 1 jiffy if
> reclaiming within a memcg and the zone is balanced overall.
> 
> The interruptible part should just be the patch below. I need to poke at
> the cgroup limit part a bit

As the throttle timeout is short anyway, will the TASK_UNINTERRUPTIBLE vs
TASK_INTERRUPTIBLE make a difference for the (ability to kill? AFAIU
typically this inability to kill is because of a loop that doesn't check for
fatal_signal_pending().

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fb9584641ac7..07db03883062 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1068,7 +1068,7 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
>  		break;
>  	}
>  
> -	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
> +	prepare_to_wait(wqh, &wait, TASK_INTERRUPTIBLE);
>  	ret = schedule_timeout(timeout);
>  	finish_wait(wqh, &wait);
>  
> 

