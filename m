Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0283100A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 16:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfEaOVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 10:21:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:58328 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbfEaOVd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 10:21:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2621AAF79;
        Fri, 31 May 2019 14:21:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 31 May 2019 16:21:30 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/13] epoll: introduce helpers for adding/removing
 events to uring
In-Reply-To: <20190531125636.GZ2606@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-7-rpenyaev@suse.de>
 <20190531095607.GC17637@hirez.programming.kicks-ass.net>
 <274e29d102133f3be1f309c66cb0af36@suse.de>
 <20190531125636.GZ2606@hirez.programming.kicks-ass.net>
Message-ID: <98e74ceeefdffc9b50fb33e597d270f7@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-05-31 14:56, Peter Zijlstra wrote:
> On Fri, May 31, 2019 at 01:15:21PM +0200, Roman Penyaev wrote:
>> On 2019-05-31 11:56, Peter Zijlstra wrote:
>> > On Thu, May 16, 2019 at 10:58:03AM +0200, Roman Penyaev wrote:
>> > > +static inline bool ep_add_event_to_uring(struct epitem *epi,
>> > > __poll_t pollflags)
>> > > +{
>> > > +	struct eventpoll *ep = epi->ep;
>> > > +	struct epoll_uitem *uitem;
>> > > +	bool added = false;
>> > > +
>> > > +	if (WARN_ON(!pollflags))
>> > > +		return false;
>> > > +
>> > > +	uitem = &ep->user_header->items[epi->bit];
>> > > +	/*
>> > > +	 * Can be represented as:
>> > > +	 *
>> > > +	 *    was_ready = uitem->ready_events;
>> > > +	 *    uitem->ready_events &= ~EPOLLREMOVED;
>> > > +	 *    uitem->ready_events |= pollflags;
>> > > +	 *    if (!was_ready) {
>> > > +	 *         // create index entry
>> > > +	 *    }
>> > > +	 *
>> > > +	 * See the big comment inside ep_remove_user_item(), why it is
>> > > +	 * important to mask EPOLLREMOVED.
>> > > +	 */
>> > > +	if (!atomic_or_with_mask(&uitem->ready_events,
>> > > +				 pollflags, EPOLLREMOVED)) {
>> > > +		unsigned int i, *item_idx, index_mask;
>> > > +
>> > > +		/*
>> > > +		 * Item was not ready before, thus we have to insert
>> > > +		 * new index to the ring.
>> > > +		 */
>> > > +
>> > > +		index_mask = ep_max_index_nr(ep) - 1;
>> > > +		i = __atomic_fetch_add(&ep->user_header->tail, 1,
>> > > +				       __ATOMIC_ACQUIRE);
>> > > +		item_idx = &ep->user_index[i & index_mask];
>> > > +
>> > > +		/* Signal with a bit, which is > 0 */
>> > > +		*item_idx = epi->bit + 1;
>> >
>> > Did you just increment the user visible tail pointer before you filled
>> > the data? That is, can the concurrent userspace observe the increment
>> > before you put credible data in its place?
>> 
>> No, the "data" is the "ready_events" mask, which was updated before,
>> using cmpxchg, atomic_or_with_mask() call.  All I need is to put an
>> index of just updated item to the uring.
>> 
>> Userspace, in its turn, gets the index from the ring and then checks
>> the mask.
> 
> But where do you write the index into the shared memory? That index
> should be written before you publish the new tail.

The ep_add_event_to_uring() is lockless, thus I can't increase tail 
after,
I need to reserve the index slot, where to write to.  I can use shadow 
tail,
which is not seen by userspace, but I have to guarantee that tail is 
updated
with shadow tail *after* all callers of ep_add_event_to_uring() are 
left.
That is possible, please see the code below, but it adds more 
complexity:

(code was tested on user side, thus has c11 atomics)

static inline void add_event__kernel(struct ring *ring, unsigned bit)
{
         unsigned i, cntr, commit_cntr, *item_idx, tail, old;

         i = __atomic_fetch_add(&ring->cntr, 1, __ATOMIC_ACQUIRE);
         item_idx = &ring->user_itemsindex[i % ring->nr];

         /* Update data */
         *item_idx = bit;

         commit_cntr = __atomic_add_fetch(&ring->commit_cntr, 1, 
__ATOMIC_RELEASE);

         tail = ring->user_header->tail;
         rmb();
         do {
                 cntr = ring->cntr;
                 if (cntr != commit_cntr)
                         /* Someone else will advance tail */
                         break;

                 old = tail;

         } while ((tail = 
__sync_val_compare_and_swap(&ring->user_header->tail, old, cntr)) != 
old);
}

Another way (current solution) is to spin on userspace side in order to 
get
index > 0 (valid index is always > 0), i.e.:

	item_idx_ptr = &index[idx & indeces_mask];

	/*
	 * Spin here till we see valid index
	 */
	while (!(idx = __atomic_load_n(item_idx_ptr, __ATOMIC_ACQUIRE)))
		;



So of course tail can be updated after, like you mentioned, but then I 
have
to introduce locks.  I want to keep it lockless on hot event path.

--
Roman


