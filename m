Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F7A319289
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 19:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhBKSxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 13:53:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:57182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhBKSxD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:53:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F3B9AE3D;
        Thu, 11 Feb 2021 18:52:21 +0000 (UTC)
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-13-shy828301@gmail.com>
 <acd1915c-306b-08a8-9e0f-b06c1e09fb4c@suse.cz>
 <CAHbLzkpF9+NUp2yUf_yKHHngKXGDya4Mj3ZTc-2rm3yFNw_==A@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [v7 PATCH 12/12] mm: vmscan: shrink deferred objects proportional
 to priority
Message-ID: <a56fa0f1-3ac6-49f1-31c1-8bfec961d04e@suse.cz>
Date:   Thu, 11 Feb 2021 19:52:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkpF9+NUp2yUf_yKHHngKXGDya4Mj3ZTc-2rm3yFNw_==A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/11/21 6:29 PM, Yang Shi wrote:
> On Thu, Feb 11, 2021 at 5:10 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>> >       trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
>> >                                  freeable, delta, total_scan, priority);
>> > @@ -737,10 +708,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>> >               cond_resched();
>> >       }
>> >
>> > -     if (next_deferred >= scanned)
>> > -             next_deferred -= scanned;
>> > -     else
>> > -             next_deferred = 0;
>> > +     next_deferred = max_t(long, (nr - scanned), 0) + total_scan;
>>
>> And here's the bias I think. Suppose we scanned 0 due to e.g. GFP_NOFS. We count
>> as newly deferred both the "delta" part of total_scan, which is fine, but also
>> the "nr >> priority" part, where we failed to our share of the "reduce
>> nr_deferred" work, but I don't think it means we should also increase
>> nr_deferred by that amount of failed work.
> 
> Here "nr" is the saved deferred work since the last scan, "scanned" is
> the scanned work in this round, total_scan is the *unscanned" work
> which is actually "total_scan - scanned" (total_scan is decreased by
> scanned in each loop). So, the logic is "decrease any scanned work
> from deferred then add newly unscanned work to deferred". IIUC this is
> what "deferred" means even before this patch.

Hm I thought the logic was "increase by any new work (delta) that wasn't done,
decrease by old deferred work that was done now". My examples with scanned = 0
and scanned = total_work (total_work before subtracting scanned from it) should
demonstrate that the logic is different with your patch.

>> OTOH if we succeed and scan exactly the whole goal, we are subtracting from
>> nr_deferred both the "nr >> priority" part, which is correct, but also delta,
>> which was new work, not deferred one, so that's incorrect IMHO as well.
> 
> I don't think so. The deferred comes from new work, why not dec new
> work from deferred?
> 
> And, the old code did:
> 
> if (next_deferred >= scanned)
>                 next_deferred -= scanned;
>         else
>                 next_deferred = 0;
> 
> IIUC, it also decreases the new work (the scanned includes both last
> deferred and new delata).

Yes, but in the old code, next_deferred starts as

nr = count_nr_deferred()...
total_scan = nr;
delta = ... // something based on freeable
total_scan += delta;
next_deferred = total_scan; // in the common case total_scan >= 0

... and that's "total_scan" before "scanned" is subtracted from it, so it
includes the new_work ("delta"), so then it's OK to do "next_deferred -= scanned";

I still think your formula is (unintentionally) changing the logic. You can also
look at it from different angle, it's effectively (without the max_t() part) "nr
- scanned + total_scan" where total_scan is actually "total_scan - scanned" as
you point your yourself. So "scanned" is subtracted twice? That can't be correct...

>> So the calculation should probably be something like this?
>>
>>         next_deferred = max_t(long, nr + delta - scanned, 0);
>>
>> Thanks,
>> Vlastimil
>>
>> > +     next_deferred = min(next_deferred, (2 * freeable));
>> > +
>> >       /*
>> >        * move the unused scan count back into the shrinker in a
>> >        * manner that handles concurrent updates.
>> >
>>
> 

