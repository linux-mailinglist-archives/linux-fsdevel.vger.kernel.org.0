Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D33B20510F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 13:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbgFWLqH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 07:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732245AbgFWLqG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:46:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EED8F20738;
        Tue, 23 Jun 2020 11:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592912764;
        bh=R7MCjDwyamDi4l1mY1bk+bL/Ui+tbtxXFKeti4Och2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePei7KpEcR6+FbLQ70rwVaQOUg0Zxw9EM/M+DMoGqe/NIUAW/nF5RIQ0/4TA79/To
         hCmP4PsERF34CcSiHfL+upeBoeOQVEH8mgjMnAZSw46vkXYbrYvBhZs4OzLpMVm3wG
         t9AxUCXBE2Cg0YhfRYTwgjfGsZv5nPZ1KH8tgVA4=
Date:   Tue, 23 Jun 2020 13:45:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rick Lindsley <ricklind@linux.vnet.ibm.com>
Cc:     Ian Kent <raven@themaw.net>, Tejun Heo <tj@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
Message-ID: <20200623114558.GA1963415@kroah.com>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20200619153833.GA5749@mtj.thefacebook.com>
 <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
 <20200619222356.GA13061@mtj.duckdns.org>
 <429696e9fa0957279a7065f7d8503cb965842f58.camel@themaw.net>
 <20200622174845.GB13061@mtj.duckdns.org>
 <20200622180306.GA1917323@kroah.com>
 <2ead27912e2a852bffb1477e8720bdadb591628d.camel@themaw.net>
 <20200623060236.GA3818201@kroah.com>
 <74fb24d0-2b61-27f8-c44e-abd159e57469@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74fb24d0-2b61-27f8-c44e-abd159e57469@linux.vnet.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:33:48AM -0700, Rick Lindsley wrote:
> On 6/22/20 11:02 PM, Greg Kroah-Hartman wrote:
> 
> > First off, this is not my platform, and not my problem, so it's funny
> > you ask me :)
> 
> Weeeelll, not your platform perhaps but MAINTAINERS does list you
> first and Tejun second as maintainers for kernfs.  So in that sense,
> any patches would need to go thru you.  So, your opinions do matter.

Sure, but "help, I'm abusing your code interface, so fix your code
interface and not my caller code" really isn't the best mantra :)

> > Anyway, as I have said before, my first guesses would be:
> > 	- increase the granularity size of the "memory chunks", reducing
> > 	  the number of devices you create.
> 
> This would mean finding every utility that relies on this behavior.
> That may be possible, although not easy, for distro or platform
> software, but it's hard to guess what user-related utilities may have
> been created by other consumers of those distros or that platform.  In
> any case, removing an interface without warning is a hanging offense
> in many Linux circles.

I agree, so find out who uses it!  You can search all debian tools
easily.  You can ask any closed-source setup tools that are on your
platforms if they use it.  You can "break it and see if anyone notices",
which is what we do all the time.

The "hanging offence" is "I'm breaking this even if you are using it!".

> > 	- delay creating the devices until way after booting, or do it
> > 	  on a totally different path/thread/workqueue/whatever to
> > 	  prevent delay at booting
> 
> This has been considered, but it again requires a full list of utilities relying on this interface and determining which of them may want to run before the devices are "loaded" at boot time.  It may be few, or even zero, but it would be a much more disruptive change in the boot process than what we are suggesting.

Is that really the case?  I strongly suggest you all do some research
here.

Oh, and wrap your email lines please...

> > And then there's always:
> > 	- don't create them at all, only only do so if userspace asks
> > 	  you to.
> 
> If they are done in parallel on demand, you'll see the same problem (load average of 1000+, contention in the same spot.)  You obviously won't hold up the boot, of course, but your utility and anything else running on the machine will take an unexpected pause ... for somewhere between 30 and 90 minutes.  Seems equally unfriendly.

I agree, but it shouldn't be shutting down the whole box, other stuff
should run just fine, right?  Is this platform really that "weak" that
it can't handle this happening in a single thread/cpu?

> A variant of this, which does have a positive effect, is to observe that coldplug during initramfs does seem to load up the memory device tree without incident.  We do a second coldplug after we switch roots and this is the one that runs into timer issues.  I have asked "those that should know" why there is a second coldplug.  I can guess but would prefer to know to avoid that screaming option.  If that second coldplug is unnecessary for the kernfs memory interfaces to work correctly, then that is an alternate, and perhaps even better solution.  (It wouldn't change the fact that kernfs was not built for speed and this problem remains below the surface to trip up another.)
> 
> However, nobody I've found can say that is safe, and I'm not fond of the 'see who screams' test solution.
> 
> > You all have the userspace tools/users for this interface and know it
> > best to know what will work for them.  If you don't, then hey, let's
> > just delete the whole thing and see who screams :)
> 
> I guess I'm puzzled by why everyone seems offended by suggesting we change a mutex to a rw semaphore.  In a vacuum, sure, but we have before and after numbers.  Wouldn't the same cavalier logic apply?  Why not change it and see who screams?

I am offended as a number of years ago this same user of kernfs/sysfs
did a lot of work to reduce the number of contentions in kernfs for this
same reason.  After that work was done, "all was good".  Now this comes
along again, blaming kernfs/sysfs, not the caller.

Memory is only going to get bigger over time, you might want to fix it
this way and then run away.  But we have to maintain this for the next
20+ years, and you are not solving the root-problem here.  It will come
back again, right?

> I haven't heard any criticism of the patch itself - I'm hearing criticism of the problem.  This problem is not specific to memory devices.  As we get larger systems,  we'll see it elsewhere. We do already see a mild form of this when fibre finds 1000-2000 fibre disks and goes to add them in parallel.  Small memory chunks introduces the problem at a level two orders of magnitude bigger, but eventually other devices will be subject to it too.  Why not address this now?

1-2k devices are easy to handle, we handle 30k scsi devices today with
no problem at all, and have for 15+ years.  We are "lucky" there that
the hardware is slower than kernfs/sysfs so that we are not the
bottleneck at all.

> 'Doctor, it hurts when I do this'
> 'Then don't do that'
> 
> Funny as a joke.  Less funny as a review comment.

Treat the system as a whole please, don't go for a short-term fix that
we all know is not solving the real problem here.

thanks,

greg k-h
