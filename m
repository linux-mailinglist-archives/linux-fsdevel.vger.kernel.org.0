Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01FDF30E39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 14:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfEaMmd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 08:42:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfEaMmc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 08:42:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCFCF3179B6E;
        Fri, 31 May 2019 12:42:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 211B85C21A;
        Fri, 31 May 2019 12:42:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190529230954.GA3164@kroah.com>
References: <20190529230954.GA3164@kroah.com> <20190528231218.GA28384@kroah.com> <20190528162603.GA24097@kroah.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk> <4031.1559064620@warthog.procyon.org.uk> <31936.1559146000@warthog.procyon.org.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able ring buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24719.1559306541.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 31 May 2019 13:42:21 +0100
Message-ID: <24720.1559306541@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 31 May 2019 12:42:32 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> wrote:

> > kref_put() enforces a very specific destructor signature.  I know of places
> > where that doesn't work because the destructor takes more than one argument
> > (granted that this is not the case here).  So why does kref_put() exist at
> > all?  Why not kref_dec_and_test()?
>
> The destructor only takes one object pointer as you are finally freeing
> that object.  What more do you need/want to "know" at that point in
> time?

Imagine that I have an object that's on a list rooted in a namespace and that
I have a lot of these objects.  Imagine further that any time I want to put a
ref on one of these objects, it's in a context that has the namespace pinned.
I therefore don't need to store a pointer to the namespace in every object
because I can pass that in to the put function

Indeed, I can still access the namespace even after the decrement didn't
reduce the usage count to 0 - say for doing statistics.

> What would kref_dec_and_test() be needed for?

Why do you need kref_put() to take a destructor function pointer?  Why cannot
that be replaced with, say:

	static inline bool __kref_put(struct kref *k)
	{
		return refcount_dec_and_test(&k->refcount);
	}

and then one could do:

	void put_foo(struct foo_net *ns, struct foo *f)
	{
		if (__kref_put(&f->refcount)) {
			// destroy foo
		}
	}

that way the destruction code does not have to be offloaded into its own
function and you still have your pattern to look for.

For tracing purposes, I could live with something like:

	static inline
	bool __kref_put_return(struct kref *k, unsigned int *_usage)
	{
		return refcount_dec_and_test_return(&k->refcount, _usage);
	}

and then I could do:

	void put_foo(struct foo_net *ns, struct foo *f)
	{
		unsigned int u;
		bool is_zero = __kref_put_return(&f->refcount, &u);

		trace_foo_refcount(f, u);
		if (is_zero) {
			// destroy foo
		}
	}

then it could be made such that you can disable the ability of
refcount_dec_and_test_return() to pass back a useful refcount value if you
want a bit of extra speed.

Or even if refcount_dec_return() is guaranteed to return 0 if the count hits
the floor and non-zero otherwise and there's a config switch to impose a
stronger guarantee that it will return a value that's appropriately
transformed to look as if I was using atomic_dec_return().

Similarly for refcount_inc_return() - it could just return gibberish unless
the same config switch is enabled.

Question for AMD/Intel guys: I'm curious if LOCK DECL faster than LOCK XADD -1
on x86_64?

> > Why doesn't refcount_t get merged into kref, or vice versa?  Having both
> > would seem redundant.
>
> kref uses refcount_t and provides a different functionality on top of
> it.  Not all uses of a refcount in the kernel is for object lifecycle
> reference counting, as you know :)

I do?  I can't think of one offhand.  Not that I'm saying you're wrong on
that - there's an awful lot of kernel.

David
