Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11BE3B53A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 19:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfIQRHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 13:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbfIQRHV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:07:21 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF5222067B;
        Tue, 17 Sep 2019 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568740040;
        bh=+ubCWqZlPU1XeGPUgnyumUqfKdtQbouqijwBVicHlxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0kFSS9ymJn81IkSf9ANdxCDtykIrw7fHnmw7PFNTDwCG0IwzfBlHvg2JDJlork8+
         3cIUDtH9Oq+Ay3alcft/3VTmVpwCn95YG16VYNZCaqwuwlhuhhLbA/DOkVt3++++8/
         EeF3p2xnDX3ssnolXC/Zw7GNL+Y6AXLogY9Kb2Mw=
Date:   Tue, 17 Sep 2019 18:07:16 +0100
From:   Will Deacon <will@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, peterz@infradead.org
Subject: Re: [RFC][PATCH] pipe: Convert ring to head/tail
Message-ID: <20190917170716.ud457wladfhhjd6h@willie-the-truck>
References: <20190915145905.hd5xkc7uzulqhtzr@willie-the-truck>
 <25289.1568379639@warthog.procyon.org.uk>
 <28447.1568728295@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28447.1568728295@warthog.procyon.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Tue, Sep 17, 2019 at 02:51:35PM +0100, David Howells wrote:
> Will Deacon <will@kernel.org> wrote:
> 
> > > +		/* Barrier: head belongs to the write side, so order reading
> > > +		 * the data after reading the head pointer.
> > > +		 */
> > > +		unsigned int head = READ_ONCE(pipe->head);
> > 
> > Hmm, I don't understand this. Since READ_ONCE() doesn't imply a barrier,
> > how are you enforcing the read-read ordering in the CPU?
> 
> It does imply a barrier: smp_read_barrier_depends().  I believe that's

I fed your incomplete sentence to https://talktotransformer.com/ :

  It does imply a barrier: smp_read_barrier_depends(). I believe that's
  correct. (I'm not a coder so I assume it just means it's a dependency. Maybe
  this works for other languages too.)

but I have a feeling that's not what you meant. I guess AI isn't quite
ready to rule the world.

> > What is the purpose of saying "This may need to insert a barrier"? Can this
> > function be overridden or something?
> 
> I mean it's arch-dependent whether READ_ONCE() inserts a barrier or not.

Ok, but why would the caller care?

> > Saying that "This inserts a barrier" feels misleading, because READ_ONCE()
> > doesn't do that.
> 
> Yes it does - on the Alpha:
> 
> [arch/alpha/include/asm/barrier.h]
> #define read_barrier_depends() __asm__ __volatile__("mb": : :"memory")
> 
> [include/asm-generic/barrier.h]
> #ifndef __smp_read_barrier_depends
> #define __smp_read_barrier_depends()	read_barrier_depends()
> #endif
> ...
> #ifndef smp_read_barrier_depends
> #define smp_read_barrier_depends()	__smp_read_barrier_depends()
> #endif
> 
> [include/linux/compiler.h]
> #define __READ_ONCE(x, check)						\
> ({									\
> 	union { typeof(x) __val; char __c[1]; } __u;			\
> 	if (check)							\
> 		__read_once_size(&(x), __u.__c, sizeof(x));		\
> 	else								\
> 		__read_once_size_nocheck(&(x), __u.__c, sizeof(x));	\
> 	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
> 	__u.__val;							\
> })
> #define READ_ONCE(x) __READ_ONCE(x, 1)
> 
> See:
> 
>     commit 76ebbe78f7390aee075a7f3768af197ded1bdfbb
>     Author: Will Deacon <will.deacon@arm.com>
>     Date:   Tue Oct 24 11:22:47 2017 +0100
>     locking/barriers: Add implicit smp_read_barrier_depends() to READ_ONCE()

Ah, that guy. I tried emailing him but he didn't reply.

Seriously though, READ_ONCE() implies a barrier on Alpha, but its portable
barrier semantics are only that it can be used to head an address
dependency, a bit like rcu_dereference(). You shouldn't be relying on the
stronger ordering provided by Alpha, and I doubt that you really are.

If I'm understanding your code correctly (big 'if'), then you have things
like this in pipe_read():


	unsigned int head = READ_ONCE(pipe->head);
	unsigned int tail = pipe->tail;
	unsigned int mask = pipe->buffers - 1;

	if (tail != head) {
		struct pipe_buffer *buf = &pipe->bufs[tail & mask];

		[...]

		written = copy_page_to_iter(buf->page, buf->offset, chars, to);


where you want to make sure you don't read from 'buf->page' until after
you've read the updated head index. Is that right? If so, then READ_ONCE()
will not give you that guarantee on architectures such as Power and Arm,
because the 'if (tail != head)' branch can be speculated and the buffer
can be read before we've got around to looking at the head index.

So I reckon you need smp_load_acquire() in this case. pipe_write() might be ok
with the control dependency because CPUs don't tend to make speculative writes
visible, but I didn't check it carefully and the compiler can do crazy stuff in
this area, so I'd be inclined to use smp_load_acquire() here too unless you
really need the last ounce of performance.

Will
