Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75101E080D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 09:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389100AbgEYHbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 03:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388947AbgEYHbO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 03:31:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C8022065F;
        Mon, 25 May 2020 07:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590391873;
        bh=xMXUOo0qUlfkTmmWrZzTeNI+eU0+PvvQaCHgKt8XDkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agf9JwW0RDZBYiOQLSQdTc0qCLL5zwkRyDEOOreXtPGgaUrEPwijD5pfsk9qWjneJ
         X+a1D0vI3vpN3eAMEG0hBBAyrne7sGZeHNqHfakRDalj07fIs2Wp25UfiENzRlO4ER
         Qh01qkK7REPf1xLBV4wRcGe4jvVFxegm6rdzE2dI=
Date:   Mon, 25 May 2020 09:31:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] kernfs: proposed locking and concurrency improvement
Message-ID: <20200525073111.GA261205@kroah.com>
References: <159038508228.276051.14042452586133971255.stgit@mickey.themaw.net>
 <20200525061616.GA57080@kroah.com>
 <b9e8f8171096813c76df3719719bdda87033fd78.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9e8f8171096813c76df3719719bdda87033fd78.camel@themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 25, 2020 at 03:23:35PM +0800, Ian Kent wrote:
> On Mon, 2020-05-25 at 08:16 +0200, Greg Kroah-Hartman wrote:
> > On Mon, May 25, 2020 at 01:46:59PM +0800, Ian Kent wrote:
> > > For very large systems with hundreds of CPUs and TBs of RAM booting
> > > can
> > > take a very long time.
> > > 
> > > Initial reports showed that booting a configuration of several
> > > hundred
> > > CPUs and 64TB of RAM would take more than 30 minutes and require
> > > kernel
> > > parameters of udev.children-max=1024
> > > systemd.default_timeout_start_sec=3600
> > > to prevent dropping into emergency mode.
> > > 
> > > Gathering information about what's happening during the boot is a
> > > bit
> > > challenging. But two main issues appeared to be, a large number of
> > > path
> > > lookups for non-existent files, and high lock contention in the VFS
> > > during
> > > path walks particularly in the dentry allocation code path.
> > > 
> > > The underlying cause of this was believed to be the sheer number of
> > > sysfs
> > > memory objects, 100,000+ for a 64TB memory configuration.
> > 
> > Independant of your kernfs changes, why do we really need to
> > represent
> > all of this memory with that many different "memory objects"?  What
> > is
> > that providing to userspace?
> > 
> > I remember Ben Herrenschmidt did a lot of work on some of the kernfs
> > and
> > other functions to make large-memory systems boot faster to remove
> > some
> > of the complexity in our functions, but that too did not look into
> > why
> > we needed to create so many objects in the first place.
> > 
> > Perhaps you might want to look there instead?
> 
> I presumed it was a hardware design requirement or IBM VM design
> requirement.
> 
> Perhaps Rick can find out more on that question.

Also, why do you need to create the devices _when_ you create them?  Can
you wait until after init is up and running to start populating the
device tree with them?  That way boot can be moving on and disks can be
spinning up earlier?

Also, what about just hot-adding all of that memory after init happens?

Those two options only delay the long delay, but it could allow other
things to be moving and speed up the overall boot process.

thanks,

greg k-h
