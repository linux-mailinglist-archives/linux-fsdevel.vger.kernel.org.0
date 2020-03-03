Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E511F177790
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 14:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCCNnT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 08:43:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgCCNnT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:43:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B9920717;
        Tue,  3 Mar 2020 13:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583242998;
        bh=LsmV8M+K1WrR+kQz2BjN3GavRyic/105fmJ2fgu+v8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7D5oAe/mXB81Q5EvjErelrC7dcsVBIPlqYjg6/7QzcJLcJ3NbAvNfXd3CFPL5um0
         +/1agyp/hxBRzSbvRXJ6fahy0JKexFlR14u3ius8X6CtWTU5Lhh8Y4Ph9lig8GzK2K
         NrYTrB/5QWEVLaOOgkSyz7gGmo8JmuLbfyUY0Phs=
Date:   Tue, 3 Mar 2020 14:43:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Karel Zak <kzak@redhat.com>, David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200303134316.GA2509660@kroah.com>
References: <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk>
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home>
 <20200303130347.GA2302029@kroah.com>
 <20200303131434.GA2373427@kroah.com>
 <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 02:34:42PM +0100, Miklos Szeredi wrote:
> On Tue, Mar 3, 2020 at 2:14 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> 
> > > Unlimited beers for a 21-line kernel patch?  Sign me up!
> > >
> > > Totally untested, barely compiled patch below.
> >
> > Ok, that didn't even build, let me try this for real now...
> 
> Some comments on the interface:

Ok, hey, let's do this proper :)

> O_LARGEFILE can be unconditional, since offsets are not exposed to the caller.

Good point.

> Use the openat2 style arguments; limit the accepted flags to sane ones
> (e.g. don't let this syscall create a file).

Yeah, I just added that check to my local version:
	/* Mask off all O_ flags as we only want to read from the file */
	flags &= ~(VALID_OPEN_FLAGS);
	flags |= O_RDONLY | O_LARGEFILE;

> If buffer is too small to fit the whole file, return error.

Why?  What's wrong with just returning the bytes asked for?  If someone
only wants 5 bytes from the front of a file, it should be fine to give
that to them, right?

> Verify that the number of bytes read matches the file size, otherwise
> return error (may need to loop?).

No, we can't "match file size" as sysfs files do not really have a sane
"size".  So I don't want to loop at all here, one-shot, that's all you
get :)

Let me actually do this and try it out for real.

/me has no idea what he is getting himself into...

thanks,

greg k-h
