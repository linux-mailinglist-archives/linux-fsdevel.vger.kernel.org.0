Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B05217372A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 13:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgB1M1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 07:27:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgB1M1R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:27:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1632D246A3;
        Fri, 28 Feb 2020 12:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582892834;
        bh=m93yM93vQbcHMkGCkK/OGG8kf11IbeXU6ORroxAAGzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1qkwABoJTSe5SmM+7+hNubXHM41yKugx1YRFHDmMnoOK5YYsRXnCmI+7Quf+GWlwi
         Bsu0HcZJviHZoYaZPpZHFb/vRkds/rPDV/VIY8AovPBUoT3uvbuxw3yFlFhMyyAs6G
         ZzL4KOs+fv5qzsr28SX0dPrQDm2L4JnAnSNwmRAM=
Date:   Fri, 28 Feb 2020 13:27:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ian Kent <raven@themaw.net>, Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200228122712.GA3013026@kroah.com>
References: <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
 <1582644535.3361.8.camel@HansenPartnership.com>
 <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
 <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net>
 <CAJfpegtRoXnPm5_sMYPL2L6FCZU52Tn8wk7NcW-dm4_2x=dD3Q@mail.gmail.com>
 <3e656465c427487e4ea14151b77d391d52cd6bad.camel@themaw.net>
 <CAJfpegu5xLcR=QbAOnUrL49QTem6X6ok7nPU+kLFnNHdPXSh1A@mail.gmail.com>
 <20200227151421.3u74ijhqt6ekbiss@ws.net.home>
 <ba2b44cc1382c62be3ac896a5476c8e1dc7c0230.camel@themaw.net>
 <CAJfpeguXPmw+PfZJFOscGLm0oe7dUQY4CYXazx9=x020Fbe86A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguXPmw+PfZJFOscGLm0oe7dUQY4CYXazx9=x020Fbe86A@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 09:35:17AM +0100, Miklos Szeredi wrote:
> On Fri, Feb 28, 2020 at 1:43 AM Ian Kent <raven@themaw.net> wrote:
> 
> > > I'm not sure about sysfs/, you need somehow resolve namespaces, order
> > > of the mount entries (which one is the last one), etc. IMHO translate
> > > mountpoint path to sysfs/ path will be complicated.
> >
> > I wonder about that too, after all sysfs contains a tree of nodes
> > from which the view is created unlike proc which translates kernel
> > information directly based on what the process should see.
> >
> > We'll need to wait a bit and see what Miklos has in mind for mount
> > table enumeration and nothing has been said about name spaces yet.
> 
> Adding Greg for sysfs knowledge.
> 
> As far as I understand the sysfs model is, basically:
> 
>   - list of devices sorted by class and address
>   - with each class having a given set of attributes

Close enough :)

> Superblocks and mounts could get enumerated by a unique identifier.
> mnt_id seems to be good for mounts, s_dev may or may not be good for
> superblock, but  s_id (as introduced in this patchset) could be used
> instead.

So what would the sysfs tree look like with this?

> As for namespaces, that's "just" an access control issue, AFAICS.
> For example a task with a non-initial mount namespace should not have
> access to attributes of mounts outside of its namespace.  Checking
> access to superblock attributes would be similar: scan the list of
> mounts and only allow access if at least one mount would get access.

sysfs does handle namespaces, look at how networking does this.  But,
it's not exactly the simplest thing to do so, so be careful with that as
this is going to be essential for this type of work.

thanks,

greg k-h
