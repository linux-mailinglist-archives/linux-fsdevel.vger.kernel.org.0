Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5500330E84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 15:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfEaNF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 09:05:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60486 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaNF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 09:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PgUhnVURh2ADsQW/SeXfrMWkdAfU9SjN4srmC8FhFMY=; b=Jddq8a64kyT4ZwUcekI8eTvi5
        aWeG4Jc6o32wfZp/PaTagIjVAwN4aBSlNRKR4WWcqP/BdXtuRLYKr+WeBTBWshF0Y+2ak4/J8ktwI
        PZVcAX34NZSkYEUg2+aAipGy77NCbKz0wsSdZrU9EBsI7u9askq7ZjWNoBkHywbDAbS2ceUyZRErZ
        KOCq9Dl04MODWwNNmetzylqgRbAXzP8ydAqvCmSBRwDnBbNRcyIfSTDhSk5QXgH10MqmgeVetXDD8
        6lxoDmMHcYP3Cnu7OhzX/kbsiO6tmU6CYFG9R4++Wyoj1VS/FU2Zj0m3Ntn0iDTsTknHE4u66M3hm
        AHiQc1nsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWhDi-0007WO-7I; Fri, 31 May 2019 13:05:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03F6420274AFF; Fri, 31 May 2019 15:05:16 +0200 (CEST)
Date:   Fri, 31 May 2019 15:05:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/13] epoll: call ep_add_event_to_uring() from
 ep_poll_callback()
Message-ID: <20190531130516.GA2606@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-8-rpenyaev@suse.de>
 <20190531095616.GD17637@hirez.programming.kicks-ass.net>
 <98971429dc36e8a2e3417af1744de2b2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98971429dc36e8a2e3417af1744de2b2@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 31, 2019 at 01:22:54PM +0200, Roman Penyaev wrote:
> On 2019-05-31 11:56, Peter Zijlstra wrote:
> > On Thu, May 16, 2019 at 10:58:04AM +0200, Roman Penyaev wrote:

> > > +static inline bool ep_clear_public_event_bits(struct epitem *epi)
> > > +{
> > > +	__poll_t old, flags;
> > > +
> > > +	/*
> > > +	 * Here we race with ourselves and with ep_modify(), which can
> > > +	 * change the event bits.  In order not to override events updated
> > > +	 * by ep_modify() we have to do cmpxchg.
> > > +	 */
> > > +
> > > +	old = epi->event.events;
> > > +	do {
> > > +		flags = old;
> > > +	} while ((old = cmpxchg(&epi->event.events, flags,
> > > +				flags & EP_PRIVATE_BITS)) != flags);
> > > +
> > > +	return flags & ~EP_PRIVATE_BITS;
> > > +}
> > 
> > AFAICT epi->event.events also has normal writes to it, eg. in
> > ep_modify(). A number of architectures cannot handle concurrent normal
> > writes and cmpxchg() to the same variable.
> 
> Yes, we race with the current function and with ep_modify().  Then,
> ep_modify()
> should do something as the following:
> 
> -	epi->event.events = event->events
> +	xchg(&epi->event.events, event->events);
> 
> Is that ok?

That should be correct, but at that point I think we should also always
read the thing with READ_ONCE() to avoid load-tearing. And I suspect it
then becomes sensible to change the type to atomic_t.

atomic_set() vs atomic_cmpxchg() only carries the extra overhead on
those 'dodgy' platforms.

> Just curious: what are these archs?

Oh, lovely stuff like parisc, sparc32 and arc-eznps. See
arch/parisc/lib/bitops.c:__cmpxchg_*() for example :/ Those systems only
have a single truly atomic op (something from the xchg / test-and-set
family) and the rest is fudged on top of that.

