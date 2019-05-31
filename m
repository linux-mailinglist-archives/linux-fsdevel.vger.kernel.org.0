Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCC3E310D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 17:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfEaPFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 11:05:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:39034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfEaPFR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 11:05:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4236DAD9C;
        Fri, 31 May 2019 15:05:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 31 May 2019 17:05:16 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/13] epoll: call ep_add_event_to_uring() from
 ep_poll_callback()
In-Reply-To: <20190531130516.GA2606@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-8-rpenyaev@suse.de>
 <20190531095616.GD17637@hirez.programming.kicks-ass.net>
 <98971429dc36e8a2e3417af1744de2b2@suse.de>
 <20190531130516.GA2606@hirez.programming.kicks-ass.net>
Message-ID: <8dc64c770b693aeb2040cca7ec697a7a@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-05-31 15:05, Peter Zijlstra wrote:
> On Fri, May 31, 2019 at 01:22:54PM +0200, Roman Penyaev wrote:
>> On 2019-05-31 11:56, Peter Zijlstra wrote:
>> > On Thu, May 16, 2019 at 10:58:04AM +0200, Roman Penyaev wrote:
> 
>> > > +static inline bool ep_clear_public_event_bits(struct epitem *epi)
>> > > +{
>> > > +	__poll_t old, flags;
>> > > +
>> > > +	/*
>> > > +	 * Here we race with ourselves and with ep_modify(), which can
>> > > +	 * change the event bits.  In order not to override events updated
>> > > +	 * by ep_modify() we have to do cmpxchg.
>> > > +	 */
>> > > +
>> > > +	old = epi->event.events;
>> > > +	do {
>> > > +		flags = old;
>> > > +	} while ((old = cmpxchg(&epi->event.events, flags,
>> > > +				flags & EP_PRIVATE_BITS)) != flags);
>> > > +
>> > > +	return flags & ~EP_PRIVATE_BITS;
>> > > +}
>> >
>> > AFAICT epi->event.events also has normal writes to it, eg. in
>> > ep_modify(). A number of architectures cannot handle concurrent normal
>> > writes and cmpxchg() to the same variable.
>> 
>> Yes, we race with the current function and with ep_modify().  Then,
>> ep_modify()
>> should do something as the following:
>> 
>> -	epi->event.events = event->events
>> +	xchg(&epi->event.events, event->events);
>> 
>> Is that ok?
> 
> That should be correct, but at that point I think we should also always
> read the thing with READ_ONCE() to avoid load-tearing. And I suspect it
> then becomes sensible to change the type to atomic_t.

But it seems if we afraid of load tearing that should be fixed 
separately,
independently of this patchset, because epi->event.events is updated
in ep_modify() and races with ep_poll_callback(), which reads the value
in couple of places.

Probably nothing terrible will happen, because eventually event comes
or just ignored.


> atomic_set() vs atomic_cmpxchg() only carries the extra overhead on
> those 'dodgy' platforms.
> 
>> Just curious: what are these archs?
> 
> Oh, lovely stuff like parisc, sparc32 and arc-eznps. See
> arch/parisc/lib/bitops.c:__cmpxchg_*() for example :/ Those systems 
> only
> have a single truly atomic op (something from the xchg / test-and-set
> family) and the rest is fudged on top of that.

Locks, nice.

--
Roman


