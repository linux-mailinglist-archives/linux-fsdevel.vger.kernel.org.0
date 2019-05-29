Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF452E8CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 01:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfE2XJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 19:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfE2XJ4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 19:09:56 -0400
Received: from localhost (unknown [207.225.69.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 247012431F;
        Wed, 29 May 2019 23:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559171395;
        bh=RYgrpGQlV6JhNVFewZg8lfQgvdy68HtrQSwL8rOWAVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vcn5pbNeMnyZtaY1Dky6rkxgROL4EN3gp+VJHTsLmtdV8lXVVCMY6PxcElXWfeVdm
         GDbcBiViw66eGS7+ROANo46uH4/K5+D5UqUAz8o2Y0fGnvRRRP33XAiFMGfedITQfR
         3uouPh+qo2WDtYIkx6bhGj6rXy+RyVJi2DmKYZV0=
Date:   Wed, 29 May 2019 16:09:54 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able
 ring buffer
Message-ID: <20190529230954.GA3164@kroah.com>
References: <20190528231218.GA28384@kroah.com>
 <20190528162603.GA24097@kroah.com>
 <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk>
 <4031.1559064620@warthog.procyon.org.uk>
 <31936.1559146000@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31936.1559146000@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 05:06:40PM +0100, David Howells wrote:
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > > kref_put() could potentially add an unnecessary extra stack frame and would
> > > seem to be best avoided, though an optimising compiler ought to be able to
> > > inline if it can.
> > 
> > If kref_put() is on your fast path, you have worse problems (kfree isn't
> > fast, right?)
> > 
> > Anyway, it's an inline function, how can it add an extra stack frame?
> 
> The call to the function pointer.  Hopefully the compiler will optimise that
> away for an inlineable function.

The function pointer only gets called for the last "put", and then kfree
will be called so you should not have to worry about speed/stack frames
at that point in time.

> > > Are you now on the convert all refcounts to krefs path?
> > 
> > "now"?  Remember, I wrote kref all those years ago,
> 
> Yes - and I thought it wasn't a good idea at the time.  But this is the first
> time you've mentioned it to me, let alone pushed to change to it, that I
> recall.

I bring up using a kref any time I see a usage that could use it as it
makes it easier for people to understand and "know" you are doing your
reference counting for your object "correctly".  It's an abstraction
that is used to make it easier for us developers to understand.
Otherwise you have to hand-roll the same logic here.  Yes, refcounts
have made it easier to do it in your own (which was their goal), but you
still don't have to do it "on your own".

Anyway, I'll not push the issue here, if you want to stick to a
refcount_t, that's enough for now.  We can worry about changing this
later after you have debugged all the corner conditions :)

> > everyone should use
> > it.  It saves us having to audit the same pattern over and over again.
> > And, even nicer, it uses a refcount now, and as you are trying to
> > reference count an object, it is exactly what this was written for.
> > 
> > So yes, I do think it should be used here, unless it is deemed to not
> > fit the pattern/usage model.
> 
> kref_put() enforces a very specific destructor signature.  I know of places
> where that doesn't work because the destructor takes more than one argument
> (granted that this is not the case here).  So why does kref_put() exist at
> all?  Why not kref_dec_and_test()?

The destructor only takes one object pointer as you are finally freeing
that object.  What more do you need/want to "know" at that point in
time?

What would kref_dec_and_test() be needed for?

> Why doesn't refcount_t get merged into kref, or vice versa?  Having both would
> seem redundant.

kref uses refcount_t and provides a different functionality on top of
it.  Not all uses of a refcount in the kernel is for object lifecycle
reference counting, as you know :)

> Mind you, I've been gradually reverting atomic_t-to-refcount_t conversions
> because it seems I'm not allowed refcount_inc/dec_return() and I want to get
> at the point refcount for tracing purposes.

That's not good, we should address that independently as you are loosing
functionality/protection when doing that.

thanks,

greg k-h
