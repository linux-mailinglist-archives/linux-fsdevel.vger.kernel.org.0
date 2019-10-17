Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31858DAA97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 12:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409138AbfJQKxY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 06:53:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391322AbfJQKxY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:53:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFFC78553F;
        Thu, 17 Oct 2019 10:53:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70158600C4;
        Thu, 17 Oct 2019 10:53:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <b8799179-d389-8005-4f6d-845febc3bb23@rasmusvillemoes.dk>
References: <b8799179-d389-8005-4f6d-845febc3bb23@rasmusvillemoes.dk> <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk> <157117609543.15019.17103851546424902507.stgit@warthog.procyon.org.uk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/21] pipe: Use head and tail pointers for the ring, not cursor and length
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8693.1571309599.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 17 Oct 2019 11:53:19 +0100
Message-ID: <8694.1571309599@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 17 Oct 2019 10:53:24 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> >  (6) The number of free slots in the ring is "(tail + pipe->ring_size) -
> >      head".
> 
> Seems an odd way of writing pipe->ring_size - (head - tail) ; i.e.
> obviously #free slots is #size minus #occupancy.

Perhaps so.  The way I was looking at it is the window into which things can
be written is tail...tail+ring_size; the number of free slots is the distance
from head to the end of the window.

Anyway, I now have a helper that does it your way.

> >  (7) The ring is full if "head >= (tail + pipe->ring_size)", which can also
> >      be written as "head - tail >= pipe->ring_size".
> >
> 
> No it cannot, it _must_ be written in the latter form.

Ah, you're right.  I have a helper now for that too.

> head-tail == pipe_size or head-tail >= pipe_size

In general, I'd prefer ">=" just in case tail gets in front of head.

Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> > Also split pipe->buffers into pipe->ring_size (which indicates the size of
> > the ring) and pipe->max_usage (which restricts the amount of ring that
> > write() is allowed to fill).  This allows for a pipe that is both writable
> > by the kernel notification facility and by userspace, allowing plenty of
> > ring space for notifications to be added whilst preventing userspace from
> > being able to use up too much buffer space.
> 
> That seems like something that should be added in a separate patch -
> adding ->max_usage and switching appropriate users of ->ring_size over,
> so it's more clear where you're using one or the other.

Okay.

> > +		ibuf = &pipe->bufs[tail];
> 
> I don't see where tail gets masked between tail = pipe->tail;

Yeah - I missed that one.

> In any case, how about seeding head and tail with something like 1<<20 when
> creating the pipe so bugs like that are hit more quickly.

That's sounds like a good idea.

> > +			while (tail < head) {
> > +				count += pipe->bufs[tail & mask].len;
> > +				tail++;
> >  			}
> 
> This is broken if head has wrapped but tail has not. It has to be "while
> (head - tail)" or perhaps just "while (tail != head)" or something along
> those lines.

Yeah...  It's just too easy to overlook this and use ordinary comparisons.
I've switched to "while (tail != head)".

> > +	mask = pipe->ring_size - 1;
> > +	head = pipe->head & mask;
> > +	tail = pipe->tail & mask;
> > +	n = pipe->head - pipe->tail;
> 
> I think it's confusing to "premask" head and tail here. Can you either
> drop that (pipe_set_size should hardly be a hot path?), or perhaps call
> them something else to avoid a future reader seeing an unmasked
> bufs[head] and thinking that's a bug?

I've made it now do the masking right before doing the memcpy calls and used
different variable names for it:

	if (n > 0) {
		unsigned int h = head & mask;
		unsigned int t = tail & mask;
		if (h > t) {
			memcpy(bufs, &pipe->bufs + t,
			       n * sizeof(struct pipe_buffer));
		} else {
			unsigned int tsize = pipe->ring_size - t;
			if (h > 0)
				memcpy(bufs + tsize, pipe->bufs,
				       h * sizeof(struct pipe_buffer));
			memcpy(bufs, pipe->bufs + t,
			       tsize * sizeof(struct pipe_buffer));
		}

> > -	data_start(i, &idx, start);
> > -	/* some of this one + all after this one */
> > -	npages = ((i->pipe->curbuf - idx - 1) & (i->pipe->buffers - 1)) + 1;
> > -	capacity = min(npages,maxpages) * PAGE_SIZE - *start;
> > +	data_start(i, &i_head, start);
> > +	p_tail = i->pipe->tail;
> > +	/* Amount of free space: some of this one + all after this one */
> > +	npages = (p_tail + i->pipe->ring_size) - i_head;
> 
> Hm, it's not clear that this is equivalent to the old computation. Since
> it seems repeated in a few places, could it be factored to a little
> helper (before this patch) and the "some of this one + all after this
> one" comment perhaps expanded to explain what is going on?

Yeah...  It's a bit weird, even before my changes.

However, looking at it again, it seems data_start() does the appropriate
calculations.  If there's space in the current head buffer, it returns the
offset to that and the head of that buffer, otherwise it advances the head
pointer and sets the offset to 0.

So I think the comment may actually be retrospective - referring to the state
that data_start() has given us, rather than talking about the next bit of
code.

I also wonder if pipe_get_pages_alloc() is broken.  It doesn't check to see
whether the buffer is full at the point it calls data_start().  However,
data_start() doesn't check either and, without this patch, will simply advance
and mask off the ring index - which may wrap.

The maths in the unpatched version is pretty icky and I'm not convinced it's
correct.

David
