Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B951316E4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 19:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhBJSQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 13:16:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:50028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233648AbhBJSPb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:15:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21398AD6A;
        Wed, 10 Feb 2021 18:14:50 +0000 (UTC)
Subject: Re: [v7 PATCH 04/12] mm: vmscan: remove memcg_shrinker_map_size
To:     Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>
Cc:     ktkhai@virtuozzo.com, shakeelb@google.com, david@fromorbit.com,
        hannes@cmpxchg.org, mhocko@suse.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-5-shy828301@gmail.com>
 <20210209204314.GG524633@carbon.DHCP.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d27223a8-0a00-b670-da5b-205d4c16a2e4@suse.cz>
Date:   Wed, 10 Feb 2021 19:14:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209204314.GG524633@carbon.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/21 9:43 PM, Roman Gushchin wrote:
> On Tue, Feb 09, 2021 at 09:46:38AM -0800, Yang Shi wrote:
>> Both memcg_shrinker_map_size and shrinker_nr_max is maintained, but actually the
>> map size can be calculated via shrinker_nr_max, so it seems unnecessary to keep both.
>> Remove memcg_shrinker_map_size since shrinker_nr_max is also used by iterating the
>> bit map.
>> 
>> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

>> ---
>>  mm/vmscan.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>> 
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index e4ddaaaeffe2..641077b09e5d 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -185,8 +185,10 @@ static LIST_HEAD(shrinker_list);
>>  static DECLARE_RWSEM(shrinker_rwsem);
>>  
>>  #ifdef CONFIG_MEMCG
>> +static int shrinker_nr_max;
>>  
>> -static int memcg_shrinker_map_size;
>> +#define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
>> +	(DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
> 
> How about something like this?
> 
> static inline int shrinker_map_size(int nr_items)
> {
> 	return DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long);
> }
> 
> I think it look less cryptic.

Yeah that looks nicer so I'm fine with that potential change.

> The rest of the patch looks good to me.
> 
> Thanks!
> 

