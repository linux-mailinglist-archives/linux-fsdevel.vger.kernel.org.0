Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 234FA177C5C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 17:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgCCQvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 11:51:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbgCCQvE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:51:04 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE9BD20863;
        Tue,  3 Mar 2020 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583254263;
        bh=E3YuWjLi8CFv4x/taRFjxRmhZUj1cjoEOp26VkTIAyY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ORgqnXKIIEGgZy1ibtF5cMGTJyuUVhpIxPaEn3wqU8aYFM6+1nlyrIhBASiTFP9FV
         /CQutSWJRviqXOma/n/u0FrItRn/7y1nE0YH3RmBqo4De9orTUI+1zOBRCDfleN8Rt
         9ycN6AnOVqNusARwJZFie6zPPu6CbIoMxmVwfjaw=
Message-ID: <acb1753c78a019fb0d54ba29077cef144047f70f.camel@kernel.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications
 [ver #17]
From:   Jeff Layton <jlayton@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>
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
        lkml <linux-kernel@vger.kernel.org>
Date:   Tue, 03 Mar 2020 11:51:00 -0500
In-Reply-To: <030888a2-db3e-919d-d8ef-79dcc10779f9@kernel.dk>
References: <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
         <1509948.1583226773@warthog.procyon.org.uk>
         <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
         <20200303113814.rsqhljkch6tgorpu@ws.net.home>
         <20200303130347.GA2302029@kroah.com> <20200303131434.GA2373427@kroah.com>
         <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
         <20200303134316.GA2509660@kroah.com> <20200303141030.GA2811@kroah.com>
         <CAG48ez3Z2V8J7dpO6t8nw7O2cMJ6z8vwLZXLAoKGH3OnCb-7JQ@mail.gmail.com>
         <20200303142407.GA47158@kroah.com>
         <030888a2-db3e-919d-d8ef-79dcc10779f9@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-03-03 at 08:44 -0700, Jens Axboe wrote:
> On 3/3/20 7:24 AM, Greg Kroah-Hartman wrote:
> > On Tue, Mar 03, 2020 at 03:13:26PM +0100, Jann Horn wrote:
> > > On Tue, Mar 3, 2020 at 3:10 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > On Tue, Mar 03, 2020 at 02:43:16PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Tue, Mar 03, 2020 at 02:34:42PM +0100, Miklos Szeredi wrote:
> > > > > > On Tue, Mar 3, 2020 at 2:14 PM Greg Kroah-Hartman
> > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > 
> > > > > > > > Unlimited beers for a 21-line kernel patch?  Sign me up!
> > > > > > > > 
> > > > > > > > Totally untested, barely compiled patch below.
> > > > > > > 
> > > > > > > Ok, that didn't even build, let me try this for real now...
> > > > > > 
> > > > > > Some comments on the interface:
> > > > > 
> > > > > Ok, hey, let's do this proper :)
> > > > 
> > > > Alright, how about this patch.
> > > > 
> > > > Actually tested with some simple sysfs files.
> > > > 
> > > > If people don't strongly object, I'll add "real" tests to it, hook it up
> > > > to all arches, write a manpage, and all the fun fluff a new syscall
> > > > deserves and submit it "for real".
> > > 
> > > Just FYI, io_uring is moving towards the same kind of thing... IIRC
> > > you can already use it to batch a bunch of open() calls, then batch a
> > > bunch of read() calls on all the new fds and close them at the same
> > > time. And I think they're planning to add support for doing
> > > open()+read()+close() all in one go, too, except that it's a bit
> > > complicated because passing forward the file descriptor in a generic
> > > way is a bit complicated.
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
> 

Agreed. I'd really rather see something more general-purpose than the
proposed readfile(). At least with NFS and SMB, you can compound
together fairly arbitrary sorts of operations, and it'd be nice to be
able to pattern calls into the kernel for those sorts of uses.

So, NFSv4 has the concept of a current_stateid that is maintained by the
server. So basically you can do all this (e.g.) in a single compound:

open <some filehandle get a stateid>
write <using that stateid>
close <same stateid>

It'd be nice to be able to do something similar with io_uring. Make it
so that when you do an open, you set the "current fd" inside the
kernel's context, and then be able to issue io_uring requests that
specify a magic "fd" value that use it.

That would be a really useful pattern.
-- 
Jeff Layton <jlayton@kernel.org>

