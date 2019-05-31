Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2091130D35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 13:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfEaLPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 07:15:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:50542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbfEaLPX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 07:15:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96E9FABE9;
        Fri, 31 May 2019 11:15:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 31 May 2019 13:15:21 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/13] epoll: introduce helpers for adding/removing
 events to uring
In-Reply-To: <20190531095607.GC17637@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-7-rpenyaev@suse.de>
 <20190531095607.GC17637@hirez.programming.kicks-ass.net>
Message-ID: <274e29d102133f3be1f309c66cb0af36@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-05-31 11:56, Peter Zijlstra wrote:
> On Thu, May 16, 2019 at 10:58:03AM +0200, Roman Penyaev wrote:
>> +static inline bool ep_add_event_to_uring(struct epitem *epi, __poll_t 
>> pollflags)
>> +{
>> +	struct eventpoll *ep = epi->ep;
>> +	struct epoll_uitem *uitem;
>> +	bool added = false;
>> +
>> +	if (WARN_ON(!pollflags))
>> +		return false;
>> +
>> +	uitem = &ep->user_header->items[epi->bit];
>> +	/*
>> +	 * Can be represented as:
>> +	 *
>> +	 *    was_ready = uitem->ready_events;
>> +	 *    uitem->ready_events &= ~EPOLLREMOVED;
>> +	 *    uitem->ready_events |= pollflags;
>> +	 *    if (!was_ready) {
>> +	 *         // create index entry
>> +	 *    }
>> +	 *
>> +	 * See the big comment inside ep_remove_user_item(), why it is
>> +	 * important to mask EPOLLREMOVED.
>> +	 */
>> +	if (!atomic_or_with_mask(&uitem->ready_events,
>> +				 pollflags, EPOLLREMOVED)) {
>> +		unsigned int i, *item_idx, index_mask;
>> +
>> +		/*
>> +		 * Item was not ready before, thus we have to insert
>> +		 * new index to the ring.
>> +		 */
>> +
>> +		index_mask = ep_max_index_nr(ep) - 1;
>> +		i = __atomic_fetch_add(&ep->user_header->tail, 1,
>> +				       __ATOMIC_ACQUIRE);
> 
> afaict __atomic_fetch_add() does not exist.

That is gcc extension.  I did not find any API just to increment
the variable atomically without using/casting to atomic.  What
is a proper way to achieve that?

> 
>> +		item_idx = &ep->user_index[i & index_mask];
>> +
>> +		/* Signal with a bit, which is > 0 */
>> +		*item_idx = epi->bit + 1;
> 
> Did you just increment the user visible tail pointer before you filled
> the data? That is, can the concurrent userspace observe the increment
> before you put credible data in its place?

No, the "data" is the "ready_events" mask, which was updated before,
using cmpxchg, atomic_or_with_mask() call.  All I need is to put an
index of just updated item to the uring.

Userspace, in its turn, gets the index from the ring and then checks
the mask.

> 
>> +
>> +		/*
>> +		 * Want index update be flushed from CPU write buffer and
>> +		 * immediately visible on userspace side to avoid long busy
>> +		 * loops.
>> +		 */
>> +		smp_wmb();
> 
> That's still complete nonsense.

Yes, true.  My confusion came from the simple test, where one thread
swaps pointers in a loop, another thread dereferences pointer and
increments a variable:

     THR#0
     -----------

     unsigned vvv1 = 0, vvv2 = 0;
     unsigned *ptr;

     ptr = &vvv1;
     thr_level2 = &vvv2;

     while (!stop) {
         unsigned *tmp = *thr_level2;
         *thr_level2 = ptr;
         barrier();               <<<< ????
         ptr = tmp;
     }

     THR#1
     -----------

     while (!stop) {
    	ptr = thr_level2;
         (*ptr)++;
     }


At the end I expect `vvv1` and `vvv2` are approximately equally
incremented.  But, without barrier() only one variable is
incremented.

Now I see that barrier() should be defined as a simple compiler
barrier as asm volatile("" ::: "memory"), and there is nothing
related with write buffer as I wrote in the comment.

So indeed garbage and can be removed.  Thanks.

--
Roman

