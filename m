Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F16B7B5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbfISN7J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 09:59:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729629AbfISN7J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:59:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92F337FDF5;
        Thu, 19 Sep 2019 13:59:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-72.rdu2.redhat.com [10.10.125.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9A6C5D6B2;
        Thu, 19 Sep 2019 13:59:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wj85tOp8WjcUp6gwstp4Cg2WT=p209S=fOzpWAgqqQPKg@mail.gmail.com>
References: <CAHk-=wj85tOp8WjcUp6gwstp4Cg2WT=p209S=fOzpWAgqqQPKg@mail.gmail.com> <20190915145905.hd5xkc7uzulqhtzr@willie-the-truck> <25289.1568379639@warthog.procyon.org.uk> <28447.1568728295@warthog.procyon.org.uk> <20190917170716.ud457wladfhhjd6h@willie-the-truck> <15228.1568821380@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Do we need to correct barriering in circular-buffers.rst?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5384.1568901546.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 19 Sep 2019 14:59:06 +0100
Message-ID: <5385.1568901546@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 19 Sep 2019 13:59:08 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > It mandates using smp_store_release() to update buffer->head in the producer
> > and buffer->tail in the consumer - but these need pairing with memory barriers
> > used when reading buffer->head and buffer->tail on the other side.
>
> No, the rule with smp_store_release() should be that it's paired with
> "smp_load_acquire()".

Yes.

> No other barriers needed.

See below.

> If you do that
>
>    thread #1            thread #2
>
>    ... add data to queue ..
>    smp_store_release(x)
>
>                         smp_load_acquire(x)
>                         ... read data from queue ..
> ...
> But yes, store_release(x) should always pair with the load_acquire(x),
> and the guarantee is that if the load_acquire reads the value that the
> store_release stored, then all subsequent reads in thread #2 will see
> all preceding writes in thread #1.

I agree with this bit, but it's only half the picture.

> then you should need no other barriers.

But I don't agree with this.  You're missing half the barriers.  There should
be *four* barriers.  The document mandates only 3 barriers, and uses
READ_ONCE() where the fourth should be, i.e.:

   thread #1            thread #2

                        smp_load_acquire(head)
                        ... read data from queue ..
                        smp_store_release(tail)

   READ_ONCE(tail)
   ... add data to queue ..
   smp_store_release(head)

but I think that READ_ONCE() should instead be smp_load_acquire() so that the
read of the data is ordered before it gets overwritten by the writer, ordering
with respect to accesses on tail (it now implies smp_read_barrier_depends()
which I think is sufficient).

Another way of looking at it is that smp_store_release(tail) needs pairing
with something, so it should be:

   thread #1            thread #2

                        smp_load_acquire(head)
                        ... read data from queue ..
                        smp_store_release(tail)

   smp_load_acquire(tail)
   ... add data to queue ..
   smp_store_release(head)

Take your example, reorder the threads and add the missing indices accesses:

   thread #1            thread #2

                        smp_load_acquire(x)
                        ... read data from queue ..
			tail++

   read tail;
   ... add data to queue ..
   smp_store_release(x)

Is there anything to stop the cpus doing out-of-order loads/stores such that
the data read in thread 2 doesn't come after the update of tail?  If that can
happen, the data being written by thread 1 may be being read by thread 2 when
in fact, it shouldn't see it yet, e.g.:

				LOAD head
				ACQUIRE_BARRIER
				LOAD tail
	LOAD head		STORE tail++
	LOAD tail
	STORE data[head]
				LOAD data[tail]
	RELEASE_BARRIER
	STORE head++

I would really like Paul and Will to check me on this.

-~-

> HOWEVER.
>
> I think this is all entirely pointless wrt the pipe buffer use. You
> don't have a simple queue. You have multiple writers, and you have
> multiple readers. As a result, you need real locking.

Yes, and I don't deny that.  Between readers and readers you do; between
writers and writers you do.  But barriers are about the coupling between the
active reader and the active writer - and even with locking, you *still* need
the barriers, it's just that there are barriers implicit in the locking
primitives - so they're there, just hidden.

> So don't do the barriers. If you do the barriers, you're almost
> certainly doing something buggy. You don't have the simple "consumer
> -> producer" thing. Or rather, you don't _only_ have that thing.

I think what you're thinking of still has a problem.  Could you give a simple
'trace' of what it is you're thinking of, particularly in the reader, so that
I can see.

I think that the following points need to be considered:

 (1) Accessing the ring requires *four* barriers, two read-side and two
     write-side.

 (2) pipe_lock() and pipe_unlock() currently provide the barrier and the code
     places them very wide so that they encompass the index access, the data
     access and the index update, and order them with respect to pipe->mutex:

	pipe_lock(); // barrier #1
	... get curbuf and nbufs...
	... write data ...
	... nbufs++ ...
	pipe_unlock(); // barrier #2

				pipe_lock(); // barrier #3
				... get curbuf and nbufs...
				... read data ...
				... curbuf++; nbufs--; ...
				pipe_unlock(); // barrier #4

     The barriers pair up #2->#3 and #4->#1.

 (3) Multiple readers are serialised against each other by pipe_lock(), and
     will continue to be so.

 (4) Multiple userspace writers are serialised against each other by
     pipe_lock(), and will continue to be so.

 (5) Readers and userspace writers are serialised against each other by
     pipe_lock().  This could be changed at some point in the future.

 (6) pipe_lock() and pipe_unlock() cannot be used by post_notification() as it
     needs to be able to insert a message from softirq context or with a
     spinlock held.

 (7) It might be possible to use pipe->wait's spinlock to guard access to the
     ring indices since we might be taking that lock anyway to poke the other
     side.

 (8) We don't want to call copy_page_to/from_iter() with spinlock held.

As we discussed at Plumbers, we could use pipe->wait's spinlock in the
from-userspace writer to do something like:

	pipe_lock();
	...
	spin_lock_irq(&pipe->wait->lock); // barrier #1
	... get indices...
	... advance index ...
	spin_unlock_irq(&pipe->wait->lock);
	... write data ...
	pipe_unlock(); // barrier #2

ie. allocate the slot inside the spinlock, then write it whilst holding off
the reader with the pipe lock.  Yes, that would work as pipe_unlock() acts as
the closing barrier.  But this doesn't work for post_notification().  That
would have to do:

	spin_lock_irq(&pipe->wait->lock); // barrier #1
	... get indices...
	... write data ...
	... advance index ...
	spin_unlock_irq(&pipe->wait->lock); // barrier #2

which is fine, even if it occurs within the from-userspace writer as the
latter is holding the pipe lock.  However, consider the reader.  If you're
thinking of:

	pipe_lock(); // barrier #3?
	...
	... get indices...
	... read data ...
	spin_lock_irq(&pipe->wait->lock);
	... advance index ...
	spin_unlock_irq(&pipe->wait->lock); // barrier #4
	pipe_unlock();

that works against the from-userspace writer, but barrier #3 is in the wrong
place against post_notification().  We could do this:

	pipe_lock();
	...
	spin_lock_irq(&pipe->wait->lock); // barrier #3
	... get indices...
	... read data ...
	... advance index ...
	spin_unlock_irq(&pipe->wait->lock); // barrier #4
	pipe_unlock();

which does indeed protect the reader against post_notification(), but it means
that the data copy happens with the lock held.  An alternative could be:

	pipe_lock();
	...
	spin_lock_irq(&pipe->wait->lock); // barrier #3
	... get indices...
	spin_unlock_irq(&pipe->wait->lock);
	... read data ...
	spin_lock_irq(&pipe->wait->lock);
	... advance index ...
	spin_unlock_irq(&pipe->wait->lock); // barrier #4
	pipe_unlock();

but that would take the spinlock twice.

There shouldn't need to be *any* common lock between the reader and the
writer[*] - not even pipe_lock() or pipe->wait, both of which could be split.

 [*] Apart from the minor fact that, currently, the writer can violate normal
     ring-buffer semantics and go back and continue filling something it's
     already committed.

David
