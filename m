Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3DD23342F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 16:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgG3OU3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 10:20:29 -0400
Received: from relay.sw.ru ([185.231.240.75]:36104 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729278AbgG3OU2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:20:28 -0400
Received: from [192.168.15.64]
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k19Pl-0004HY-BC; Thu, 30 Jul 2020 17:20:09 +0300
Subject: Re: [PATCH 09/23] ns: Introduce ns_idr to be able to iterate all
 allocated namespaces in the system
To:     Matthew Wilcox <willy@infradead.org>
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <159611040870.535980.13460189038999722608.stgit@localhost.localdomain>
 <20200730122319.GC23808@casper.infradead.org>
 <485c01e6-a4ee-5076-878e-6303e6d8d5f3@virtuozzo.com>
 <20200730135640.GE23808@casper.infradead.org>
 <1e41ae9d-9c3d-1c4a-d49e-b7f660ce99f7@virtuozzo.com>
 <20200730141537.GF23808@casper.infradead.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <544847e2-4771-9344-e840-5f394fa3df8a@virtuozzo.com>
Date:   Thu, 30 Jul 2020 17:20:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730141537.GF23808@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30.07.2020 17:15, Matthew Wilcox wrote:
> On Thu, Jul 30, 2020 at 05:12:09PM +0300, Kirill Tkhai wrote:
>> On 30.07.2020 16:56, Matthew Wilcox wrote:
>>> On Thu, Jul 30, 2020 at 04:32:22PM +0300, Kirill Tkhai wrote:
>>>> On 30.07.2020 15:23, Matthew Wilcox wrote:
>>>>> xa_erase_irqsave();
>>>>
>>>> static inline void *xa_erase_irqsave(struct xarray *xa, unsigned long index)
>>>> {
>>>> 	unsigned long flags;
>>>>         void *entry;
>>>>
>>>>         xa_lock_irqsave(xa, flags);
>>>>         entry = __xa_erase(xa, index);
>>>>         xa_unlock_irqrestore(xa, flags);
>>>>
>>>>         return entry;
>>>> }
>>>
>>> was there a question here?
>>
>> No, I just I will add this in separate patch.
> 
> Ah, yes.  Thanks!
> 
>>>>>> +struct ns_common *ns_get_next(unsigned int *id)
>>>>>> +{
>>>>>> +	struct ns_common *ns;
>>>>>> +
>>>>>> +	if (*id < PROC_NS_MIN_INO - 1)
>>>>>> +		*id = PROC_NS_MIN_INO - 1;
>>>>>> +
>>>>>> +	*id += 1;
>>>>>> +	*id -= PROC_NS_MIN_INO;
>>>>>> +
>>>>>> +	rcu_read_lock();
>>>>>> +	do {
>>>>>> +		ns = idr_get_next(&ns_idr, id);
>>>>>> +		if (!ns)
>>>>>> +			break;
>>>>>
>>>>> xa_find_after();
>>>>>
>>>>> You'll want a temporary unsigned long to work with ...
>>>>>
>>>>>> +		if (!refcount_inc_not_zero(&ns->count)) {
>>>>>> +			ns = NULL;
>>>>>> +			*id += 1;
>>>>>
>>>>> you won't need this increment.
>>>>
>>>> Why? I don't see a way xarray allows to avoid this.
>>>
>>> It's embedded in xa_find_after().
>>  
>> How is it embedded to check ns->count that it knows nothing?
> 
> I meant you won't need to increment '*id'.  The refcount is, of course,
> your business.

Ok, this brings comfort to me, because first time I thought xarray is a
big brother, which knows everything about my counters :)
