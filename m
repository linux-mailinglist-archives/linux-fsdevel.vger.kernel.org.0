Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB84205137
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 13:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbgFWLtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 07:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732463AbgFWLth (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:49:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F3CE20738;
        Tue, 23 Jun 2020 11:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592912977;
        bh=Z+R/+JWeOcHlB9H8sESNygSLJnrTzejenxw5mk++ZkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JBTDTcbZbj8dHQ7ZLZ8b/Xtak0GP7VuhuKiMxubw9q00s6g5jAit6B4RKWW5F3M8y
         B8+wB3W613qlnuR4iW7lp5yWuI7JinFkNzjpAOviiXDSGjRFCG64DSwYW9FULvtMkw
         EDba89a4XfUhlRHh1jpzAV5r1o7geBVQ+5LkLarg=
Date:   Tue, 23 Jun 2020 13:49:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Tejun Heo <tj@kernel.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
Message-ID: <20200623114906.GB1963415@kroah.com>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20200619153833.GA5749@mtj.thefacebook.com>
 <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
 <20200619222356.GA13061@mtj.duckdns.org>
 <429696e9fa0957279a7065f7d8503cb965842f58.camel@themaw.net>
 <20200622174845.GB13061@mtj.duckdns.org>
 <20200622180306.GA1917323@kroah.com>
 <2ead27912e2a852bffb1477e8720bdadb591628d.camel@themaw.net>
 <20200623060236.GA3818201@kroah.com>
 <e42b81944272dc3b70b0588948f71bc44d15762d.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42b81944272dc3b70b0588948f71bc44d15762d.camel@themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 23, 2020 at 04:01:52PM +0800, Ian Kent wrote:
> On Tue, 2020-06-23 at 08:02 +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 23, 2020 at 01:09:08PM +0800, Ian Kent wrote:
> > > On Mon, 2020-06-22 at 20:03 +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Jun 22, 2020 at 01:48:45PM -0400, Tejun Heo wrote:
> > > > > Hello, Ian.
> > > > > 
> > > > > On Sun, Jun 21, 2020 at 12:55:33PM +0800, Ian Kent wrote:
> > > > > > > > They are used for hotplugging and partitioning memory.
> > > > > > > > The
> > > > > > > > size of
> > > > > > > > the
> > > > > > > > segments (and thus the number of them) is dictated by the
> > > > > > > > underlying
> > > > > > > > hardware.
> > > > > > > 
> > > > > > > This sounds so bad. There gotta be a better interface for
> > > > > > > that,
> > > > > > > right?
> > > > > > 
> > > > > > I'm still struggling a bit to grasp what your getting at but
> > > > > > ...
> > > > > 
> > > > > I was more trying to say that the sysfs device interface with
> > > > > per-
> > > > > object
> > > > > directory isn't the right interface for this sort of usage at
> > > > > all.
> > > > > Are these
> > > > > even real hardware pieces which can be plugged in and out?
> > > > > While
> > > > > being a
> > > > > discrete piece of hardware isn't a requirement to be a device
> > > > > model
> > > > > device,
> > > > > the whole thing is designed with such use cases on mind. It
> > > > > definitely isn't
> > > > > the right design for representing six digit number of logical
> > > > > entities.
> > > > > 
> > > > > It should be obvious that representing each consecutive memory
> > > > > range with a
> > > > > separate directory entry is far from an optimal way of
> > > > > representing
> > > > > something like this. It's outright silly.
> > > > 
> > > > I agree.  And again, Ian, you are just "kicking the problem down
> > > > the
> > > > road" if we accept these patches.  Please fix this up properly so
> > > > that
> > > > this interface is correctly fixed to not do looney things like
> > > > this.
> > > 
> > > Fine, mitigating this problem isn't the end of the story, and you
> > > don't want to do accept a change to mitigate it because that could
> > > mean no further discussion on it and no further work toward solving
> > > it.
> > > 
> > > But it seems to me a "proper" solution to this will cross a number
> > > of areas so this isn't just "my" problem and, as you point out,
> > > it's
> > > likely to become increasingly problematic over time.
> > > 
> > > So what are your ideas and recommendations on how to handle hotplug
> > > memory at this granularity for this much RAM (and larger amounts)?
> > 
> > First off, this is not my platform, and not my problem, so it's funny
> > you ask me :)
> 
> Sorry, but I don't think it's funny at all.
> 
> It's not "my platform" either, I'm just the poor old sole that
> took this on because, on the face of it, it's a file system
> problem as claimed by others that looked at it and promptly
> washed their hands of it.
> 
> I don't see how asking for your advice is out of order at all.
> 
> > 
> > Anyway, as I have said before, my first guesses would be:
> > 	- increase the granularity size of the "memory chunks",
> > reducing
> > 	  the number of devices you create.
> 
> Yes, I didn't get that from your initial comments but you've said
> it a couple of times recently and I do get it now.
> 
> I'll try and find someone appropriate to consult about that and
> see where it goes.
> 
> > 	- delay creating the devices until way after booting, or do it
> > 	  on a totally different path/thread/workqueue/whatever to
> > 	  prevent delay at booting
> 
> When you first said this it sounded like a ugly workaround to me.
> But perhaps it isn't (I'm not really convinced it is TBH), so it's
> probably worth trying to follow up on too.

It's not a workaround, it lets the rest of the system come up and do
useful things while you are still discovering parts of the system that
are not up and running.  We do this all the time for lots of
drivers/devices/subsystems, why is memory any different here?

> > And then there's always:
> > 	- don't create them at all, only only do so if userspace asks
> > 	  you to.
> 
> At first glance the impression I get from this is that it's an even
> uglier work around than delaying it but it might actually the most
> sensible way to handle this, as it's been called, silliness.
> 
> We do have the inode flag S_AUTOMOUNT that will cause the dcache flag
> DCACHE_NEED_AUTOMOUNT to be set on the dentry and that will cause
> the dentry op ->d_automount() to be called on access so, from a path
> walk perspective, the dentries could just appear when needed.
> 
> The question I'd need to answer is do the kernfs nodes exist so
> ->d_automount() can discover if the node lookup is valid, and I think
> the answer might be yes (but we would need to suppress udev
> notifications for S_AUTOMOUNT nodes).
> 
> The catch will be that this is "not" mounting per-se, so anything
> I do would probably be seen as an ugly hack that subverts the VFS
> automount support.
> 
> If I could find a way to reconcile that I could probably do this.

I am not meaning to do this at the fs layer, but at the device layer.

Why not wait until someone goes "hey, I wonder what my memory layout is,
let's go ask the kernel to probe all of that."  Or some other such
"delayed initialization" method.  Don't mess with the fs for this,
that's probably the wrong layer for all of this.

thanks,

greg k-h
