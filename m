Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270A930AAED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 16:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBAPSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 10:18:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:49492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhBAPSf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:18:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46D07AD18;
        Mon,  1 Feb 2021 15:17:52 +0000 (UTC)
Subject: Re: [v5 PATCH 07/11] mm: vmscan: add per memcg shrinker nr_deferred
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
References: <20210127233345.339910-1-shy828301@gmail.com>
 <20210127233345.339910-8-shy828301@gmail.com>
 <6b0638ba-2513-67f5-8ef1-9e60a7d9ded6@suse.cz>
 <CAHbLzkpiDBMRRerr7iXtj40p=RVLTmWoWoOQbdkvG7Tsi4iirw@mail.gmail.com>
 <CAHbLzkrg8OYqbKevdV_6qJ5L9P-_8ui=HAgm-0o69yKLtMg8tQ@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0ce8b6e4-5abb-3edb-8423-f6c222420a89@suse.cz>
Date:   Mon, 1 Feb 2021 16:17:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHbLzkrg8OYqbKevdV_6qJ5L9P-_8ui=HAgm-0o69yKLtMg8tQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/29/21 7:04 PM, Yang Shi wrote:

>> > > @@ -209,9 +214,15 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>> > >               if (!new)
>> > >                       return -ENOMEM;
>> > >
>> > > -             /* Set all old bits, clear all new bits */
>> > > -             memset(new->map, (int)0xff, old_size);
>> > > -             memset((void *)new->map + old_size, 0, size - old_size);
>> > > +             new->map = (unsigned long *)(new + 1);
>> > > +             new->nr_deferred = (void *)new->map + m_size;
>> >
>> > This better be aligned to sizeof(atomic_long_t). Can we be sure about that?
>>
>> Good point. No, if unsigned long is 32 bit on some 64 bit machines.
> 
> I think we could just change map to "u64" and guarantee struct
> shrinker_info is aligned to 64 bit.

What about changing to order, nr_deferred before map? Then the atomics are at
the beginning of allocated area, thus aligned.
