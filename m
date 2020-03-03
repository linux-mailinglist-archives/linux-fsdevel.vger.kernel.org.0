Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C83931778C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 15:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgCCOYL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 09:24:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729318AbgCCOYL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:24:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6561E2083E;
        Tue,  3 Mar 2020 14:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583245450;
        bh=zQeebs9ROb6X8Gktb/55GVuE90KUd03mb0RQ2gOkonw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B60XaKRw5kiBK054K7U+jib+5PdXf4lEksUwQNb1NWVmzdDWO4HSiDI/7vOQHjTiH
         a34CbmdY5vEOXrwr9EU5jANndisTaI+/IRthU5qTEvvz/OiRkyDIWzIkukPygjq7le
         wLSu3A281fmBNSlgWph1n9CReeXg6U+J8c36Tv9o=
Date:   Tue, 3 Mar 2020 15:24:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>,
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
        lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200303142407.GA47158@kroah.com>
References: <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk>
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home>
 <20200303130347.GA2302029@kroah.com>
 <20200303131434.GA2373427@kroah.com>
 <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
 <20200303134316.GA2509660@kroah.com>
 <20200303141030.GA2811@kroah.com>
 <CAG48ez3Z2V8J7dpO6t8nw7O2cMJ6z8vwLZXLAoKGH3OnCb-7JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3Z2V8J7dpO6t8nw7O2cMJ6z8vwLZXLAoKGH3OnCb-7JQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 03:13:26PM +0100, Jann Horn wrote:
> On Tue, Mar 3, 2020 at 3:10 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Mar 03, 2020 at 02:43:16PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Mar 03, 2020 at 02:34:42PM +0100, Miklos Szeredi wrote:
> > > > On Tue, Mar 3, 2020 at 2:14 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > > > Unlimited beers for a 21-line kernel patch?  Sign me up!
> > > > > >
> > > > > > Totally untested, barely compiled patch below.
> > > > >
> > > > > Ok, that didn't even build, let me try this for real now...
> > > >
> > > > Some comments on the interface:
> > >
> > > Ok, hey, let's do this proper :)
> >
> > Alright, how about this patch.
> >
> > Actually tested with some simple sysfs files.
> >
> > If people don't strongly object, I'll add "real" tests to it, hook it up
> > to all arches, write a manpage, and all the fun fluff a new syscall
> > deserves and submit it "for real".
> 
> Just FYI, io_uring is moving towards the same kind of thing... IIRC
> you can already use it to batch a bunch of open() calls, then batch a
> bunch of read() calls on all the new fds and close them at the same
> time. And I think they're planning to add support for doing
> open()+read()+close() all in one go, too, except that it's a bit
> complicated because passing forward the file descriptor in a generic
> way is a bit complicated.

It is complicated, I wouldn't recommend using io_ring for reading a
bunch of procfs or sysfs files, that feels like a ton of overkill with
too much setup/teardown to make it worth while.

But maybe not, will have to watch and see how it goes.

> > It feels like I'm doing something wrong in that the actuall syscall
> > logic is just so small.  Maybe I'll benchmark this thing to see if it
> > makes any real difference...
> >
> > thanks,
> >
> > greg k-h
> >
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Subject: [PATCH] readfile: implement readfile syscall
> >
> > It's a tiny syscall, meant to allow a user to do a single "open this
> > file, read into this buffer, and close the file" all in a single shot.
> >
> > Should be good for reading "tiny" files like sysfs, procfs, and other
> > "small" files.
> >
> > There is no restarting the syscall, am trying to keep it simple.  At
> > least for now.
> >
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [...]
> > +SYSCALL_DEFINE5(readfile, int, dfd, const char __user *, filename,
> > +               char __user *, buffer, size_t, bufsize, int, flags)
> > +{
> > +       int retval;
> > +       int fd;
> > +
> > +       /* Mask off all O_ flags as we only want to read from the file */
> > +       flags &= ~(VALID_OPEN_FLAGS);
> > +       flags |= O_RDONLY | O_LARGEFILE;
> > +
> > +       fd = do_sys_open(dfd, filename, flags, 0000);
> > +       if (fd <= 0)
> > +               return fd;
> > +
> > +       retval = ksys_read(fd, buffer, bufsize);
> > +
> > +       __close_fd(current->files, fd);
> > +
> > +       return retval;
> > +}
> 
> If you're gonna do something like that, wouldn't you want to also
> elide the use of the file descriptor table completely? do_sys_open()
> will have to do atomic operations in the fd table and stuff, which is
> probably moderately bad in terms of cacheline bouncing if this is used
> in a multithreaded context; and as a side effect, the fd would be
> inherited by anyone who calls fork() concurrently. You'll probably
> want to use APIs like do_filp_open() and filp_close(), or something
> like that, instead.

Ah, nice, that does make more sense.  I'll play around with that, and
benchmarking this thing later tonight.  Have to go get some stable
kernels out first...

thanks for the quick review, much appreciated.

greg k-h
