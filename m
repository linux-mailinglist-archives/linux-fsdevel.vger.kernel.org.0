Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFF65B6752
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 17:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbfIRPnE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 11:43:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfIRPnE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:43:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F509300DA78;
        Wed, 18 Sep 2019 15:43:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-72.rdu2.redhat.com [10.10.125.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 579C160C5D;
        Wed, 18 Sep 2019 15:43:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190917170716.ud457wladfhhjd6h@willie-the-truck>
References: <20190917170716.ud457wladfhhjd6h@willie-the-truck> <20190915145905.hd5xkc7uzulqhtzr@willie-the-truck> <25289.1568379639@warthog.procyon.org.uk> <28447.1568728295@warthog.procyon.org.uk>
To:     Will Deacon <will@kernel.org>
Cc:     dhowells@redhat.com, paulmck@linux.ibm.com, mark.rutland@arm.com,
        torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, peterz@infradead.org
Subject: Do we need to correct barriering in circular-buffers.rst?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15227.1568821380.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 18 Sep 2019 16:43:00 +0100
Message-ID: <15228.1568821380@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 18 Sep 2019 15:43:04 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Will Deacon <will@kernel.org> wrote:

> If I'm understanding your code correctly (big 'if'), then you have things
> like this in pipe_read():
> 
> 
> 	unsigned int head = READ_ONCE(pipe->head);
> 	unsigned int tail = pipe->tail;
> 	unsigned int mask = pipe->buffers - 1;
> 
> 	if (tail != head) {
> 		struct pipe_buffer *buf = &pipe->bufs[tail & mask];
> 
> 		[...]
> 
> 		written = copy_page_to_iter(buf->page, buf->offset, chars, to);
> 
> 
> where you want to make sure you don't read from 'buf->page' until after
> you've read the updated head index. Is that right? If so, then READ_ONCE()
> will not give you that guarantee on architectures such as Power and Arm,
> because the 'if (tail != head)' branch can be speculated and the buffer
> can be read before we've got around to looking at the head index.
> 
> So I reckon you need smp_load_acquire() in this case. pipe_write() might be
> ok with the control dependency because CPUs don't tend to make speculative
> writes visible, but I didn't check it carefully and the compiler can do
> crazy stuff in this area, so I'd be inclined to use smp_load_acquire() here
> too unless you really need the last ounce of performance.

Yeah, I probably do.

Documentation/core-api/circular-buffers.rst might be wrong, then, I think.

It mandates using smp_store_release() to update buffer->head in the producer
and buffer->tail in the consumer - but these need pairing with memory barriers
used when reading buffer->head and buffer->tail on the other side.  Currently,
for the producer we have:

	spin_lock(&producer_lock);

	unsigned long head = buffer->head;
	/* The spin_unlock() and next spin_lock() provide needed ordering. */
	unsigned long tail = READ_ONCE(buffer->tail);

	if (CIRC_SPACE(head, tail, buffer->size) >= 1) {
		/* insert one item into the buffer */
		struct item *item = buffer[head];

		produce_item(item);

		smp_store_release(buffer->head,
				  (head + 1) & (buffer->size - 1));

		/* wake_up() will make sure that the head is committed before
		 * waking anyone up */
		wake_up(consumer);
	}

	spin_unlock(&producer_lock);

I think the ordering comment about spin_unlock and spin_lock is wrong.  There's
no requirement to have a spinlock on either side - and in any case, both sides
could be inside their respective locked sections when accessing the buffer.
The READ_ONCE() would theoretically provide the smp_read_barrier_depends() to
pair with the smp_store_release() in the consumer.  Maybe I should change this
to:

	spin_lock(&producer_lock);

	/* Barrier paired with consumer-side store-release on tail */
	unsigned long tail = smp_load_acquire(buffer->tail);
	unsigned long head = buffer->head;

	if (CIRC_SPACE(head, tail, buffer->size) >= 1) {
		/* insert one item into the buffer */
		struct item *item = buffer[head];

		produce_item(item);

		smp_store_release(buffer->head,
				  (head + 1) & (buffer->size - 1));

		/* wake_up() will make sure that the head is committed before
		 * waking anyone up */
		wake_up(consumer);
	}

	spin_unlock(&producer_lock);

The consumer is currently:

	spin_lock(&consumer_lock);

	/* Read index before reading contents at that index. */
	unsigned long head = smp_load_acquire(buffer->head);
	unsigned long tail = buffer->tail;

	if (CIRC_CNT(head, tail, buffer->size) >= 1) {

		/* extract one item from the buffer */
		struct item *item = buffer[tail];

		consume_item(item);

		/* Finish reading descriptor before incrementing tail. */
		smp_store_release(buffer->tail,
				  (tail + 1) & (buffer->size - 1));
	}

	spin_unlock(&consumer_lock);

which I think is okay.

And yes, I note that this does use smp_load_acquire(buffer->head) in the
consumer - which I should also be doing.

David
