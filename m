Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C683831A87D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Feb 2021 00:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhBLXzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 18:55:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhBLXza (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 18:55:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F4E864E25;
        Fri, 12 Feb 2021 23:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613174089;
        bh=/OvqjRmaBoFigF88nuGOnn8jZUAKHCUoPALIy3wKaE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FNcUUbm3NiiNAzM1st/UIKjwfMmXXIIrFHJRZwV4hTGBgdQIOvlQWHRfEwKpvZ2p+
         RinxLoyCUKISZ2pU/lLkqmlRsyV+uFf7oJYeJKq2SpLDpoPtySvUXSz8QM+5PwIG1V
         JC0h1x2EUMc7NaFUG8dpVB3kpuyAJB1Y1Np9m4CXa8M4o2L9KIIrPRvpLCd10uIdga
         V3EefdYP9daNMHdpnbeGbsV/SwHhKO7PpKeJ/ex+NWQqdQl6IizE3DtPQ6xCbK4gMD
         FKk5b0p5E3Cj4AA6hWD8xdoSXZ0nlr+66cJVVP8TOCcoPOkfZvXJVqd4JvwWYrc5G7
         3iKoBfhuQYung==
Date:   Fri, 12 Feb 2021 15:54:48 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ian Lance Taylor <iant@golang.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Lozano <llozano@chromium.org>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
Message-ID: <20210212235448.GH7187@magnolia>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
 <YCYybUg4d3+Oij4N@kroah.com>
 <CANMq1KBuPaU5UtRR8qTgdf+J3pt-xAQq69kCVBdaYGx8F+WmFA@mail.gmail.com>
 <YCY+Ytr2J2R5Vh0+@kroah.com>
 <CAKOQZ8zPFM29DYPwbnUJEhf+a8kPSJ5E_W06JLFjn-5Fy-ZWWw@mail.gmail.com>
 <YCaipZ+iY65iSrui@kroah.com>
 <20210212230346.GU4626@dread.disaster.area>
 <CAOyqgcX_wN2RGunDix5rSWxtp3pvSpFy2Stx-Ln4GozgSeS2LQ@mail.gmail.com>
 <20210212232726.GW4626@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212232726.GW4626@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 13, 2021 at 10:27:26AM +1100, Dave Chinner wrote:
> On Fri, Feb 12, 2021 at 03:07:39PM -0800, Ian Lance Taylor wrote:
> > On Fri, Feb 12, 2021 at 3:03 PM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Fri, Feb 12, 2021 at 04:45:41PM +0100, Greg KH wrote:
> > > > On Fri, Feb 12, 2021 at 07:33:57AM -0800, Ian Lance Taylor wrote:
> > > > > On Fri, Feb 12, 2021 at 12:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > Why are people trying to use copy_file_range on simple /proc and /sys
> > > > > > files in the first place?  They can not seek (well most can not), so
> > > > > > that feels like a "oh look, a new syscall, let's use it everywhere!"
> > > > > > problem that userspace should not do.
> > > > >
> > > > > This may have been covered elsewhere, but it's not that people are
> > > > > saying "let's use copy_file_range on files in /proc."  It's that the
> > > > > Go language standard library provides an interface to operating system
> > > > > files.  When Go code uses the standard library function io.Copy to
> > > > > copy the contents of one open file to another open file, then on Linux
> > > > > kernels 5.3 and greater the Go standard library will use the
> > > > > copy_file_range system call.  That seems to be exactly what
> > > > > copy_file_range is intended for.  Unfortunately it appears that when
> > > > > people writing Go code open a file in /proc and use io.Copy the
> > > > > contents to another open file, copy_file_range does nothing and
> > > > > reports success.  There isn't anything on the copy_file_range man page
> > > > > explaining this limitation, and there isn't any documented way to know
> > > > > that the Go standard library should not use copy_file_range on certain
> > > > > files.
> > > >
> > > > But, is this a bug in the kernel in that the syscall being made is not
> > > > working properly, or a bug in that Go decided to do this for all types
> > > > of files not knowing that some types of files can not handle this?
> > > >
> > > > If the kernel has always worked this way, I would say that Go is doing
> > > > the wrong thing here.  If the kernel used to work properly, and then
> > > > changed, then it's a regression on the kernel side.
> > > >
> > > > So which is it?
> > >
> > > Both Al Viro and myself have said "copy file range is not a generic
> > > method for copying data between two file descriptors". It is a
> > > targetted solution for *regular files only* on filesystems that store
> > > persistent data and can accelerate the data copy in some way (e.g.
> > > clone, server side offload, hardware offlead, etc). It is not
> > > intended as a copy mechanism for copying data from one random file
> > > descriptor to another.
> > >
> > > The use of it as a general file copy mechanism in the Go system
> > > library is incorrect and wrong. It is a userspace bug.  Userspace
> > > has done the wrong thing, userspace needs to be fixed.
> > 
> > OK, we'll take it out.
> > 
> > I'll just make one last plea that I think that copy_file_range could
> > be much more useful if there were some way that a program could know
> > whether it would work or not.

Well... we could always implement a CFR_DRYRUN flag that would run
through all the parameter validation and return 0 just before actually
starting any real copying logic.  But that wouldn't itself solve the
problem that there are very old virtual filesystems in Linux that have
zero-length regular files that behave like a pipe.

> If you can't tell from userspace that a file has data in it other
> than by calling read() on it, then you can't use cfr on it.

I don't know how to do that, Dave. :)

Frankly I'm with the Go developers on this -- one should detect c_f_r by
calling it and if it errors out then fall back to the usual userspace
buffer copy strategy.

That still means we need to fix the kernel WRT these weird old
filesystems.  One of...

1. Get rid of the generic fallback completely, since splice only copies
64k at a time and ... yay?  I guess it at least passes generic/521 and
generic/522 these days.

2. Keep it, but change c_f_r to require that both files have a
->copy_file_range implementation.  If they're the same then we'll call
the function pointer, if not, we call the generic fallback.  This at
least gets us back to the usual behavior which is that filesystems have
to opt in to new functionality (== we assume they QA'd all the wunnerful
combinations).

3. #2, but fix the generic fallback to not suck so badly.  That sounds
like someone (else's) 2yr project. :P

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
