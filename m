Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B018177A55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 16:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgCCPXz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 10:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgCCPXz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:23:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0139920838;
        Tue,  3 Mar 2020 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583249034;
        bh=rXosf6kAT/BKH/ayoMI3Rw2EtxgONhJJd03j7j6pgpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FHC/y79N8pKO5oiRvYDv1RXt1CxGsCRToCzID7d7P+PdeFim6vx5Oo9IEcrECLjKk
         fJF5s06rM9Rh1/OVXsSTwnIOP2IxeFg0So1FduEqMEUjDRY3Ht1wXdJDZ8uZ88JVtT
         ke/ORH7JT2Ud8ipqAFDiV3fhJTTuhD0ySE/MEniA=
Date:   Tue, 3 Mar 2020 16:23:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
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
Message-ID: <20200303152352.GA221026@kroah.com>
References: <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk>
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home>
 <20200303130347.GA2302029@kroah.com>
 <20200303131434.GA2373427@kroah.com>
 <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
 <20200303142351.vtc2ldqltev5jo4h@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303142351.vtc2ldqltev5jo4h@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 03:23:51PM +0100, Christian Brauner wrote:
> On Tue, Mar 03, 2020 at 02:34:42PM +0100, Miklos Szeredi wrote:
> > On Tue, Mar 3, 2020 at 2:14 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > 
> > > > Unlimited beers for a 21-line kernel patch?  Sign me up!
> > > >
> > > > Totally untested, barely compiled patch below.
> > >
> > > Ok, that didn't even build, let me try this for real now...
> > 
> > Some comments on the interface:
> > 
> > O_LARGEFILE can be unconditional, since offsets are not exposed to the caller.
> > 
> > Use the openat2 style arguments; limit the accepted flags to sane ones
> > (e.g. don't let this syscall create a file).
> 
> If we think this is worth it, might even good to either have it support
> struct open_how or have it accept two flag arguments. We sure want
> openat2()s RESOLVE_* flags in there.

If you look at the patch I posted in this thread, I think it properly
supports open_how and RESOLVE_* flags.  But remember it's opening a file
that is already present, in RO mode, no creation allowed, so most of the
open_how interactions are limited.

thanks,

greg k-h
