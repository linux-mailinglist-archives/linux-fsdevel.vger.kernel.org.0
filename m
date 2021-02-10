Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18EF31693D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 15:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhBJOhv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 09:37:51 -0500
Received: from relay.sw.ru ([185.231.240.75]:55326 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhBJOhv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RhI6NeJ9fQNo1JPboHNL4BxIltZhtUXo85xF5hWE03A=; b=y3zos7qAfBdf3c+rhZOcLTbDMs
        8qNwDjYKxRqyAFDdbAs0tjhPy4avG3Ib72BbIyhdAvkmlO3qViDQWrfUONt/4RA99n9urutXkxUVy
        EUyIzUQTduEJToXG2ogPLOWE64xvPvq4Ia+TJwwK1Ss10B/zFzNBdF/02txNHyMBlxpA=;
Received: from [192.168.15.133]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1l9qbm-0028G7-9l; Wed, 10 Feb 2021 17:36:46 +0300
Subject: Re: [v7 PATCH 09/12] mm: vmscan: use per memcg nr_deferred of
 shrinker
To:     Yang Shi <shy828301@gmail.com>, Roman Gushchin <guro@fb.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-10-shy828301@gmail.com>
 <20210210012726.GO524633@carbon.DHCP.thefacebook.com>
 <CAHbLzkoKV6_w_KBp+cajvpxG2p8jN-es03C0ktk4tLdvULJwhg@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <1d751688-12a9-a5c3-2d9a-c4b9e65c7492@virtuozzo.com>
Date:   Wed, 10 Feb 2021 17:36:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHbLzkoKV6_w_KBp+cajvpxG2p8jN-es03C0ktk4tLdvULJwhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10.02.2021 04:52, Yang Shi wrote:
> On Tue, Feb 9, 2021 at 5:27 PM Roman Gushchin <guro@fb.com> wrote:
>>
>> On Tue, Feb 09, 2021 at 09:46:43AM -0800, Yang Shi wrote:
>>> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
>>> will be used in the following cases:
>>>     1. Non memcg aware shrinkers
>>>     2. !CONFIG_MEMCG
>>>     3. memcg is disabled by boot parameter
>>>
>>> Signed-off-by: Yang Shi <shy828301@gmail.com>
>>> ---
>>>  mm/vmscan.c | 78 ++++++++++++++++++++++++++++++++++++++++++++---------
>>>  1 file changed, 66 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index d4b030a0b2a9..748aa6e90f83 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -368,6 +368,24 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
>>>       up_write(&shrinker_rwsem);
>>>  }
>>>
>>> +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
>>> +                                 struct mem_cgroup *memcg)
>>
>> "Count" is not associated with xchg() semantics in my head, but I don't know
>> what's the better version. Maybe steal or pop?
> 
> It is used to retrieve the nr_deferred value. I don't think "steal" or
> "pop" helps understand. Actually "count" is borrowed from
> count_objects() method of shrinker.

I'd also voted for another name.

xchg_nr_deferred() or steal/pop sound better for me.
