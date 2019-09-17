Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA581B4FAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 15:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfIQNvm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 09:51:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfIQNvi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:51:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3987951EE6;
        Tue, 17 Sep 2019 13:51:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-72.rdu2.redhat.com [10.10.125.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AE825D6B2;
        Tue, 17 Sep 2019 13:51:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190915145905.hd5xkc7uzulqhtzr@willie-the-truck>
References: <20190915145905.hd5xkc7uzulqhtzr@willie-the-truck> <25289.1568379639@warthog.procyon.org.uk>
To:     Will Deacon <will@kernel.org>
Cc:     dhowells@redhat.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        peterz@infradead.org
Subject: Re: [RFC][PATCH] pipe: Convert ring to head/tail
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28446.1568728295.1@warthog.procyon.org.uk>
Date:   Tue, 17 Sep 2019 14:51:35 +0100
Message-ID: <28447.1568728295@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 17 Sep 2019 13:51:38 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Will Deacon <will@kernel.org> wrote:

> > +		/* Barrier: head belongs to the write side, so order reading
> > +		 * the data after reading the head pointer.
> > +		 */
> > +		unsigned int head = READ_ONCE(pipe->head);
> 
> Hmm, I don't understand this. Since READ_ONCE() doesn't imply a barrier,
> how are you enforcing the read-read ordering in the CPU?

It does imply a barrier: smp_read_barrier_depends().  I believe that's

> What is the purpose of saying "This may need to insert a barrier"? Can this
> function be overridden or something?

I mean it's arch-dependent whether READ_ONCE() inserts a barrier or not.

> Saying that "This inserts a barrier" feels misleading, because READ_ONCE()
> doesn't do that.

Yes it does - on the Alpha:

[arch/alpha/include/asm/barrier.h]
#define read_barrier_depends() __asm__ __volatile__("mb": : :"memory")

[include/asm-generic/barrier.h]
#ifndef __smp_read_barrier_depends
#define __smp_read_barrier_depends()	read_barrier_depends()
#endif
...
#ifndef smp_read_barrier_depends
#define smp_read_barrier_depends()	__smp_read_barrier_depends()
#endif

[include/linux/compiler.h]
#define __READ_ONCE(x, check)						\
({									\
	union { typeof(x) __val; char __c[1]; } __u;			\
	if (check)							\
		__read_once_size(&(x), __u.__c, sizeof(x));		\
	else								\
		__read_once_size_nocheck(&(x), __u.__c, sizeof(x));	\
	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
	__u.__val;							\
})
#define READ_ONCE(x) __READ_ONCE(x, 1)

See:

    commit 76ebbe78f7390aee075a7f3768af197ded1bdfbb
    Author: Will Deacon <will.deacon@arm.com>
    Date:   Tue Oct 24 11:22:47 2017 +0100
    locking/barriers: Add implicit smp_read_barrier_depends() to READ_ONCE()

David
