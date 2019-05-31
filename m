Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A845B31270
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfEaQdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 12:33:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34174 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfEaQdV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 12:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KV0jjAa5lUPCjWIg0Oa5mDgaofJfRMrPmuwua04KAn8=; b=CC3+ByM0wwBCFhXK6eduay6nx
        n8flDWadU4FWbC+r4dmlcdWyt2bqdVJ1RtMrKL8I/Y7yHXk85GlXCacwxu+jHc71i6Er59HfnNdJH
        Il+MX1qVMsis7S0ZmMK4I4Z+kbhJadskUrG19lD6bSHKyE6eHhaRPJLVF1QOEHrQxx5dZZ9sLh4nG
        2BUwMch14n4MbxSHz//hIewFmnKmmwEkFOWUYnGo4U4AEPmQUspc5OAjM5pPl/LUBZsnazk/lFeJS
        rEDN7oh95LxqLH3wD9nOls0bokD9yOwIoYr4NKz2YTctuop4znaws7UTRreJbkFRPWLa+CvvYBTVN
        5+sQn6+zA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWkSw-0001dM-T3; Fri, 31 May 2019 16:33:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0FC89201CF1CB; Fri, 31 May 2019 18:33:12 +0200 (CEST)
Date:   Fri, 31 May 2019 18:33:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     azat@libevent.org, rpenyaev@suse.de, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/13] epoll: support pollable epoll from userspace
Message-ID: <20190531163312.GW2650@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516085810.31077-1-rpenyaev@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 10:57:57AM +0200, Roman Penyaev wrote:
> When new event comes for some epoll item kernel does the following:
> 
>  struct epoll_uitem *uitem;
> 
>  /* Each item has a bit (index in user items array), discussed later */
>  uitem = user_header->items[epi->bit];
> 
>  if (!atomic_fetch_or(uitem->ready_events, pollflags)) {
>      i = atomic_add(&ep->user_header->tail, 1);

So this is where you increment tail

> 
>      item_idx = &user_index[i & index_mask];
> 
>      /* Signal with a bit, user spins on index expecting value > 0 */
>      *item_idx = idx + 1;

IUC, this is where you write the idx into shared memory, which is
_after_ tail has already been incremented.

>  }
> 
> Important thing here is that ring can't infinitely grow and corrupt other
> elements, because kernel always checks that item was marked as ready, so
> userspace has to clear ready_events field.
> 
> On userside events the following code should be used in order to consume
> events:
> 
>  tail = READ_ONCE(header->tail);
>  for (i = 0; header->head != tail; header->head++) {
>      item_idx_ptr = &index[idx & indeces_mask];
> 
>      /*
>       * Spin here till we see valid index
>       */
>      while (!(idx = __atomic_load_n(item_idx_ptr, __ATOMIC_ACQUIRE)))
>          ;

Which you then try and fix up by busy waiting for @idx to become !0 ?!

Why not write the idx first, then increment the ->tail, such that when
we see ->tail, we already know idx must be correct?

> 
>      item = &header->items[idx - 1];
> 
>      /*
>       * Mark index as invalid, that is for userspace only, kernel does not care
>       * and will refill this pointer only when observes that event is cleared,
>       * which happens below.
>       */
>      *item_idx_ptr = 0;

That avoids this store too.

> 
>      /*
>       * Fetch data first, if event is cleared by the kernel we drop the data
>       * returning false.
>       */
>      event->data = item->event.data;
>      event->events = __atomic_exchange_n(&item->ready_events, 0,
>                          __ATOMIC_RELEASE);
> 
>  }

Aside from that, you have to READ/WRITE_ONCE() on ->head, to avoid
load/store tearing.


That would give something like:

kernel:

	slot = atomic_fetch_inc(&ep->slot);
	item_idx = &user_index[slot & idx_mask];
	WRITE_ONCE(*item_idx, idx);
	smp_store_release(&ep->user_header->tail, slot);

userspace:

	tail = smp_load_acquire(&header->tail);
	for (head = READ_ONCE(header->head); head != tail; head++) {
		idx = READ_ONCE(index[head & idx_mask]);
		itemp = &header->items[idx];

		...
	}
	smp_store_release(&header->head, head);


