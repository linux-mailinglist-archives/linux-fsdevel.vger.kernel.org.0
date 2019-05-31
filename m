Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09F4D314F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 20:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfEaSuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 14:50:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:48200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbfEaSup (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 14:50:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7375AAD3B;
        Fri, 31 May 2019 18:50:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 31 May 2019 20:50:44 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/13] epoll: support pollable epoll from userspace
In-Reply-To: <20190531163312.GW2650@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190531163312.GW2650@hirez.programming.kicks-ass.net>
Message-ID: <327c990a4418b3d9c5c94787a37350bb@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-05-31 18:33, Peter Zijlstra wrote:
> On Thu, May 16, 2019 at 10:57:57AM +0200, Roman Penyaev wrote:
>> When new event comes for some epoll item kernel does the following:
>> 
>>  struct epoll_uitem *uitem;
>> 
>>  /* Each item has a bit (index in user items array), discussed later 
>> */
>>  uitem = user_header->items[epi->bit];
>> 
>>  if (!atomic_fetch_or(uitem->ready_events, pollflags)) {
>>      i = atomic_add(&ep->user_header->tail, 1);
> 
> So this is where you increment tail
> 
>> 
>>      item_idx = &user_index[i & index_mask];
>> 
>>      /* Signal with a bit, user spins on index expecting value > 0 */
>>      *item_idx = idx + 1;
> 
> IUC, this is where you write the idx into shared memory, which is
> _after_ tail has already been incremented.
> 
>>  }
>> 
>> Important thing here is that ring can't infinitely grow and corrupt 
>> other
>> elements, because kernel always checks that item was marked as ready, 
>> so
>> userspace has to clear ready_events field.
>> 
>> On userside events the following code should be used in order to 
>> consume
>> events:
>> 
>>  tail = READ_ONCE(header->tail);
>>  for (i = 0; header->head != tail; header->head++) {
>>      item_idx_ptr = &index[idx & indeces_mask];
>> 
>>      /*
>>       * Spin here till we see valid index
>>       */
>>      while (!(idx = __atomic_load_n(item_idx_ptr, __ATOMIC_ACQUIRE)))
>>          ;
> 
> Which you then try and fix up by busy waiting for @idx to become !0 ?!
> 
> Why not write the idx first, then increment the ->tail, such that when
> we see ->tail, we already know idx must be correct?
> 
>> 
>>      item = &header->items[idx - 1];
>> 
>>      /*
>>       * Mark index as invalid, that is for userspace only, kernel does 
>> not care
>>       * and will refill this pointer only when observes that event is 
>> cleared,
>>       * which happens below.
>>       */
>>      *item_idx_ptr = 0;
> 
> That avoids this store too.
> 
>> 
>>      /*
>>       * Fetch data first, if event is cleared by the kernel we drop 
>> the data
>>       * returning false.
>>       */
>>      event->data = item->event.data;
>>      event->events = __atomic_exchange_n(&item->ready_events, 0,
>>                          __ATOMIC_RELEASE);
>> 
>>  }
> 
> Aside from that, you have to READ/WRITE_ONCE() on ->head, to avoid
> load/store tearing.

Yes, clear. Thanks.

> 
> 
> That would give something like:
> 
> kernel:
> 
> 	slot = atomic_fetch_inc(&ep->slot);
> 	item_idx = &user_index[slot & idx_mask];
> 	WRITE_ONCE(*item_idx, idx);
> 	smp_store_release(&ep->user_header->tail, slot);

This can't be called from many cpus,  tail can be overwritten with "old"
value.  That what I try to solve.

--
Roman

