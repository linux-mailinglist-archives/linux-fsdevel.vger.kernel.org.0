Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3207031A2BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 17:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhBLQbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 11:31:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231175AbhBLQ3e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:29:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 491A064E79;
        Fri, 12 Feb 2021 16:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613147332;
        bh=HcsDS6mK0dG0cq9UXuHaCkpq0Hiag5dWMSDBV6jX+fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BKjEIsD0X86TF2KC4H104I1s9B5fYADy3zGRP/pcFLHhYDNI0IvNQzzcc0sAqES1L
         sCJjsBdI34UGEyhpECUgisxlHMZo6UkgofcV+AFaenVxCJjN6U2U/BBXxDRWhTpGcv
         C4EbRwLlvMx/T3EBrpHOc/ToISs9WjSIOnmUlX8E=
Date:   Fri, 12 Feb 2021 17:28:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ian Lance Taylor <iant@golang.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Lozano <llozano@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
Message-ID: <YCaswkcgM2NMxiMh@kroah.com>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
 <YCYybUg4d3+Oij4N@kroah.com>
 <CANMq1KBuPaU5UtRR8qTgdf+J3pt-xAQq69kCVBdaYGx8F+WmFA@mail.gmail.com>
 <YCY+Ytr2J2R5Vh0+@kroah.com>
 <CAKOQZ8zPFM29DYPwbnUJEhf+a8kPSJ5E_W06JLFjn-5Fy-ZWWw@mail.gmail.com>
 <YCaipZ+iY65iSrui@kroah.com>
 <CAOyqgcVTYhozM-mwc400qt+fabmUuBQTsjqbcA03xDooYXXcMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOyqgcVTYhozM-mwc400qt+fabmUuBQTsjqbcA03xDooYXXcMA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 07:59:04AM -0800, Ian Lance Taylor wrote:
> On Fri, Feb 12, 2021 at 7:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Feb 12, 2021 at 07:33:57AM -0800, Ian Lance Taylor wrote:
> > > On Fri, Feb 12, 2021 at 12:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > Why are people trying to use copy_file_range on simple /proc and /sys
> > > > files in the first place?  They can not seek (well most can not), so
> > > > that feels like a "oh look, a new syscall, let's use it everywhere!"
> > > > problem that userspace should not do.
> > >
> > > This may have been covered elsewhere, but it's not that people are
> > > saying "let's use copy_file_range on files in /proc."  It's that the
> > > Go language standard library provides an interface to operating system
> > > files.  When Go code uses the standard library function io.Copy to
> > > copy the contents of one open file to another open file, then on Linux
> > > kernels 5.3 and greater the Go standard library will use the
> > > copy_file_range system call.  That seems to be exactly what
> > > copy_file_range is intended for.  Unfortunately it appears that when
> > > people writing Go code open a file in /proc and use io.Copy the
> > > contents to another open file, copy_file_range does nothing and
> > > reports success.  There isn't anything on the copy_file_range man page
> > > explaining this limitation, and there isn't any documented way to know
> > > that the Go standard library should not use copy_file_range on certain
> > > files.
> >
> > But, is this a bug in the kernel in that the syscall being made is not
> > working properly, or a bug in that Go decided to do this for all types
> > of files not knowing that some types of files can not handle this?
> >
> > If the kernel has always worked this way, I would say that Go is doing
> > the wrong thing here.  If the kernel used to work properly, and then
> > changed, then it's a regression on the kernel side.
> >
> > So which is it?
> 
> I don't work on the kernel, so I can't tell you which it is.  You will
> have to decide.

As you have the userspace code, it should be easier for you to test this
on an older kernel.  I don't have your userspace code...

> From my perspective, as a kernel user rather than a kernel developer,
> a system call that silently fails for certain files and that provides
> no way to determine either 1) ahead of time that the system call will
> fail, or 2) after the call that the system call did fail, is a useless
> system call.

Great, then don't use copy_file_range() yet as it seems like it fits
that category at the moment :)

> I can never use that system call, because I don't know
> whether or not it will work.  So as a kernel user I would say that you
> should fix the system call to report failure, or document some way to
> know whether the system call will fail, or you should remove the
> system call.  But I'm not a kernel developer, I don't have all the
> information, and it's obviously your call.

That's up to the authors of that syscall, I don't know what they
intended this to be used for.  It feels like you are using this in a
very generic "all file i/o works for this" way, while that is not what
the authors of the syscall intended it for, as is evident by the
failures that older kernels would report for you.

> I'll note that to the best of my knowledge this failure started
> happening with the 5.3 kernel, as before 5.3 the problematic calls
> would report a failure (EXDEV).  Since 5.3 isn't all that old I
> personally wouldn't say that the kernel "has always worked this way."
> But I may be mistaken about this.

Testing would be good, as regressions are more serious than "it would be
nice if it would work like this instead!" type of issues.

thanks,

greg k-h
