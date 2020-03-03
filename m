Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7156D177C09
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 17:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgCCQhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 11:37:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbgCCQhk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:37:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CCA6215A4;
        Tue,  3 Mar 2020 16:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583253459;
        bh=FhA4AlKsWQhkG5239jPG/L5X/SEVz0vTQkckZ629mRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HOe5cKdeZj3pXjYZJc7DPIkoB9zGWLNL7+2NnUcWRx9ffmsug7aZyoV7LPfLhWOoC
         r9tJFI6o/X6MQsFS6oLoPVIPKnbXxMsL4Ngwshfy+4RqnWnahiwc6QbpLA6WVXLHTN
         QgYNYzypKh9HPTjpdL9nEQm+cDk633CduZf5/X1s=
Date:   Tue, 3 Mar 2020 17:37:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jann Horn <jannh@google.com>, Miklos Szeredi <miklos@szeredi.hu>,
        Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200303163737.GA652754@kroah.com>
References: <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home>
 <20200303130347.GA2302029@kroah.com>
 <20200303131434.GA2373427@kroah.com>
 <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
 <20200303134316.GA2509660@kroah.com>
 <20200303141030.GA2811@kroah.com>
 <CAG48ez3Z2V8J7dpO6t8nw7O2cMJ6z8vwLZXLAoKGH3OnCb-7JQ@mail.gmail.com>
 <20200303142407.GA47158@kroah.com>
 <030888a2-db3e-919d-d8ef-79dcc10779f9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <030888a2-db3e-919d-d8ef-79dcc10779f9@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 08:44:43AM -0700, Jens Axboe wrote:
> On 3/3/20 7:24 AM, Greg Kroah-Hartman wrote:
> > On Tue, Mar 03, 2020 at 03:13:26PM +0100, Jann Horn wrote:
> >> On Tue, Mar 3, 2020 at 3:10 PM Greg Kroah-Hartman
> >> <gregkh@linuxfoundation.org> wrote:
> >>>
> >>> On Tue, Mar 03, 2020 at 02:43:16PM +0100, Greg Kroah-Hartman wrote:
> >>>> On Tue, Mar 03, 2020 at 02:34:42PM +0100, Miklos Szeredi wrote:
> >>>>> On Tue, Mar 3, 2020 at 2:14 PM Greg Kroah-Hartman
> >>>>> <gregkh@linuxfoundation.org> wrote:
> >>>>>
> >>>>>>> Unlimited beers for a 21-line kernel patch?  Sign me up!
> >>>>>>>
> >>>>>>> Totally untested, barely compiled patch below.
> >>>>>>
> >>>>>> Ok, that didn't even build, let me try this for real now...
> >>>>>
> >>>>> Some comments on the interface:
> >>>>
> >>>> Ok, hey, let's do this proper :)
> >>>
> >>> Alright, how about this patch.
> >>>
> >>> Actually tested with some simple sysfs files.
> >>>
> >>> If people don't strongly object, I'll add "real" tests to it, hook it up
> >>> to all arches, write a manpage, and all the fun fluff a new syscall
> >>> deserves and submit it "for real".
> >>
> >> Just FYI, io_uring is moving towards the same kind of thing... IIRC
> >> you can already use it to batch a bunch of open() calls, then batch a
> >> bunch of read() calls on all the new fds and close them at the same
> >> time. And I think they're planning to add support for doing
> >> open()+read()+close() all in one go, too, except that it's a bit
> >> complicated because passing forward the file descriptor in a generic
> >> way is a bit complicated.
> > 
> > It is complicated, I wouldn't recommend using io_ring for reading a
> > bunch of procfs or sysfs files, that feels like a ton of overkill with
> > too much setup/teardown to make it worth while.
> > 
> > But maybe not, will have to watch and see how it goes.
> 
> It really isn't, and I too thinks it makes more sense than having a
> system call just for the explicit purpose of open/read/close. As Jann
> said, you can't currently do a linked sequence of open/read/close,
> because the fd passing between them isn't done. But that will come in
> the future. If the use case is "a bunch of files", then you could
> trivially do "open bunch", "read bunch", "close bunch" in three separate
> steps.
> 
> Curious what the use case is for this that warrants a special system
> call?

All of the open/read/close cycles for sysfs and procfs files were the
one reported use case as we have lots of utilities that do that all the
time it seems (top and other monitoring tools).

thanks,

greg k-h
