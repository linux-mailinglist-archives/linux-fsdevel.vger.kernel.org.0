Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC091776C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 14:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgCCNOh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 08:14:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgCCNOh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:14:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DDB320842;
        Tue,  3 Mar 2020 13:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583241277;
        bh=U28fY8JhI6bCyYW5i7FnUHu0QsanuxLwZ73WPobV7tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eBgTn54vhuoXwc2Fijp0ZPXdIVlth72dEuoUBHuO98Tt1c3mOCJGuZPVxIGH3k7cj
         YDSguUeZHBnVrtox9b6f92pg+Di0lq1GYn5SeHgcKg3xbRTESFxU/YdG3ErowUr5e9
         QkKhS9QtYFvlPZfoFLXn/9szhCR4vjX4/wPYPRm4=
Date:   Tue, 3 Mar 2020 14:14:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
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
Message-ID: <20200303131434.GA2373427@kroah.com>
References: <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein>
 <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk>
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home>
 <20200303130347.GA2302029@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303130347.GA2302029@kroah.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 02:03:47PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 03, 2020 at 12:38:14PM +0100, Karel Zak wrote:
> > On Tue, Mar 03, 2020 at 10:26:21AM +0100, Miklos Szeredi wrote:
> > > No, I don't think this is going to be a performance issue at all, but
> > > if anything we could introduce a syscall
> > > 
> > >   ssize_t readfile(int dfd, const char *path, char *buf, size_t
> > > bufsize, int flags);
> > 
> > off-topic, but I'll buy you many many beers if you implement it ;-),
> > because open + read + close is pretty common for /sys and /proc in
> > many userspace tools; for example ps, top, lsblk, lsmem, lsns, udevd
> > etc. is all about it.
> 
> Unlimited beers for a 21-line kernel patch?  Sign me up!
> 
> Totally untested, barely compiled patch below.

Ok, that didn't even build, let me try this for real now...
