Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50FE917758D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 12:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgCCL5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 06:57:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39494 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgCCL5D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:57:03 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j96AO-0000th-AQ; Tue, 03 Mar 2020 11:56:52 +0000
Date:   Tue, 3 Mar 2020 12:56:51 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200303115651.j5q7bsvzu5mstgw4@wittgenstein>
References: <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk>
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303100045.zqntjjjv6npvs5zl@wittgenstein>
 <CAJfpegu_O=wQsewDWdM39dhkrEoMPG4ZBkTQOsWTgFnYmvrLeA@mail.gmail.com>
 <20200303102541.diud7za3vvjvqco4@wittgenstein>
 <CAJfpegu7CTmE8XfL-Oqp3KkjJNU5FM+VJxohFfK9dO+xnJAdYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegu7CTmE8XfL-Oqp3KkjJNU5FM+VJxohFfK9dO+xnJAdYA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 12:33:48PM +0100, Miklos Szeredi wrote:
> On Tue, Mar 3, 2020 at 11:25 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Tue, Mar 03, 2020 at 11:13:50AM +0100, Miklos Szeredi wrote:
> > > On Tue, Mar 3, 2020 at 11:00 AM Christian Brauner
> > > <christian.brauner@ubuntu.com> wrote:
> 
> > > > More magic links to beam you around sounds like a bad idea. We had a
> > > > bunch of CVEs around them in containers and they were one of the major
> > > > reasons behind us pushing for openat2(). That's why it has a
> > > > RESOLVE_NO_MAGICLINKS flag.
> > >
> > > No, that link wouldn't beam you around at all, it would end up in an
> > > internally mounted instance of a mountfs, a safe place where no
> >
> > Even if it is a magic link to a safe place it's a magic link. They
> > aren't a great solution to this problem. fsinfo() is cleaner and
> > simpler as it creates a context for a supervised mount which gives the a
> > managing application fine-grained control and makes it easily
> > extendable.
> 
> Yeah, it's a nice and clean interface in the ioctl(2) sense. Sure,
> fsinfo() is way better than ioctl(), but it at the core it's still the
> same syscall multiplexer, do everything hack.

In contrast to a generic ioctl() it's a domain-specific separate
syscall. You can't suddenly set kvm options through fsinfo() I would
hope. I find it at least debatable that a new filesystem is preferable.
And - feel free to simply dismiss the concerns I expressed - so far
there has not been a lot of excitement about this idea.

> 
> > Also, we're apparently at the point where it seems were suggesting
> > another (pseudo)filesystem to get information about filesystems.
> 
> Implementation detail.  Why would you care?

I wouldn't call this an implementation detail. That's quite a big
design choice; it's a separate fileystem. In addition, implementation
details need to be maintained.

Christian
