Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A9131B3A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 01:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBOAjm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 19:39:42 -0500
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:35842 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229818AbhBOAjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 19:39:41 -0500
Received: from dread.disaster.area (pa49-181-52-82.pa.nsw.optusnet.com.au [49.181.52.82])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id E6AA81140442;
        Mon, 15 Feb 2021 11:38:55 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lBRuh-0053ei-3V; Mon, 15 Feb 2021 11:38:55 +1100
Date:   Mon, 15 Feb 2021 11:38:55 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ian Lance Taylor <iant@golang.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Lozano <llozano@chromium.org>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
Message-ID: <20210215003855.GY4626@dread.disaster.area>
References: <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
 <YCYybUg4d3+Oij4N@kroah.com>
 <CANMq1KBuPaU5UtRR8qTgdf+J3pt-xAQq69kCVBdaYGx8F+WmFA@mail.gmail.com>
 <YCY+Ytr2J2R5Vh0+@kroah.com>
 <CAKOQZ8zPFM29DYPwbnUJEhf+a8kPSJ5E_W06JLFjn-5Fy-ZWWw@mail.gmail.com>
 <YCaipZ+iY65iSrui@kroah.com>
 <20210212230346.GU4626@dread.disaster.area>
 <CAOyqgcX_wN2RGunDix5rSWxtp3pvSpFy2Stx-Ln4GozgSeS2LQ@mail.gmail.com>
 <20210212232726.GW4626@dread.disaster.area>
 <20210212235448.GH7187@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212235448.GH7187@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=7pwokN52O8ERr2y46pWGmQ==:117 a=7pwokN52O8ERr2y46pWGmQ==:17
        a=kj9zAlcOel0A:10 a=qa6Q16uM49sA:10 a=7-415B0cAAAA:8 a=ag1SF4gXAAAA:8
        a=Ctr0A7MYLLdSEb84NpgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
        a=Yupwre4RP9_Eg_Bd0iYG:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 03:54:48PM -0800, Darrick J. Wong wrote:
> On Sat, Feb 13, 2021 at 10:27:26AM +1100, Dave Chinner wrote:
> > On Fri, Feb 12, 2021 at 03:07:39PM -0800, Ian Lance Taylor wrote:
> > > On Fri, Feb 12, 2021 at 3:03 PM Dave Chinner <david@fromorbit.com> wrote:
> > > >
> > > > On Fri, Feb 12, 2021 at 04:45:41PM +0100, Greg KH wrote:
> > > > > On Fri, Feb 12, 2021 at 07:33:57AM -0800, Ian Lance Taylor wrote:
> > > > > > On Fri, Feb 12, 2021 at 12:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > Why are people trying to use copy_file_range on simple /proc and /sys
> > > > > > > files in the first place?  They can not seek (well most can not), so
> > > > > > > that feels like a "oh look, a new syscall, let's use it everywhere!"
> > > > > > > problem that userspace should not do.
> > > > > >
> > > > > > This may have been covered elsewhere, but it's not that people are
> > > > > > saying "let's use copy_file_range on files in /proc."  It's that the
> > > > > > Go language standard library provides an interface to operating system
> > > > > > files.  When Go code uses the standard library function io.Copy to
> > > > > > copy the contents of one open file to another open file, then on Linux
> > > > > > kernels 5.3 and greater the Go standard library will use the
> > > > > > copy_file_range system call.  That seems to be exactly what
> > > > > > copy_file_range is intended for.  Unfortunately it appears that when
> > > > > > people writing Go code open a file in /proc and use io.Copy the
> > > > > > contents to another open file, copy_file_range does nothing and
> > > > > > reports success.  There isn't anything on the copy_file_range man page
> > > > > > explaining this limitation, and there isn't any documented way to know
> > > > > > that the Go standard library should not use copy_file_range on certain
> > > > > > files.
> > > > >
> > > > > But, is this a bug in the kernel in that the syscall being made is not
> > > > > working properly, or a bug in that Go decided to do this for all types
> > > > > of files not knowing that some types of files can not handle this?
> > > > >
> > > > > If the kernel has always worked this way, I would say that Go is doing
> > > > > the wrong thing here.  If the kernel used to work properly, and then
> > > > > changed, then it's a regression on the kernel side.
> > > > >
> > > > > So which is it?
> > > >
> > > > Both Al Viro and myself have said "copy file range is not a generic
> > > > method for copying data between two file descriptors". It is a
> > > > targetted solution for *regular files only* on filesystems that store
> > > > persistent data and can accelerate the data copy in some way (e.g.
> > > > clone, server side offload, hardware offlead, etc). It is not
> > > > intended as a copy mechanism for copying data from one random file
> > > > descriptor to another.
> > > >
> > > > The use of it as a general file copy mechanism in the Go system
> > > > library is incorrect and wrong. It is a userspace bug.  Userspace
> > > > has done the wrong thing, userspace needs to be fixed.
> > > 
> > > OK, we'll take it out.
> > > 
> > > I'll just make one last plea that I think that copy_file_range could
> > > be much more useful if there were some way that a program could know
> > > whether it would work or not.
> 
> Well... we could always implement a CFR_DRYRUN flag that would run
> through all the parameter validation and return 0 just before actually
> starting any real copying logic.  But that wouldn't itself solve the
> problem that there are very old virtual filesystems in Linux that have
> zero-length regular files that behave like a pipe.
> 
> > If you can't tell from userspace that a file has data in it other
> > than by calling read() on it, then you can't use cfr on it.
> 
> I don't know how to do that, Dave. :)

If stat returns a non-zero size, then userspace knows it has at
least that much data in it, whether it be zeros or previously
written data. cfr will copy that data. The special zero length
regular pipe files fail this simple "how much data is there to copy
in this file" check...

> Frankly I'm with the Go developers on this -- one should detect c_f_r by
> calling it and if it errors out then fall back to the usual userspace
> buffer copy strategy.
> 
> That still means we need to fix the kernel WRT these weird old
> filesystems.  One of...

And that is the whole problem here, not that cfr is failing. cfr is
behaving correctly and consistently as the filesystem is telling the
kernel there is no data in the file (i.e. size = 0).

> 1. Get rid of the generic fallback completely, since splice only copies
> 64k at a time and ... yay?  I guess it at least passes generic/521 and
> generic/522 these days.

I've had a few people ask me for cfr to not fall back to a manual
copy because they only want it to do something if it can accelerate
the copy to be faster than userspace can copy the data itself. If
the filesystem can't optimise the copy in some way, they want to
know so they can do something else of their own chosing.

Hence this seems like the sane option to take here...

> 2. Keep it, but change c_f_r to require that both files have a
> ->copy_file_range implementation.  If they're the same then we'll call
> the function pointer, if not, we call the generic fallback.  This at
> least gets us back to the usual behavior which is that filesystems have
> to opt in to new functionality (== we assume they QA'd all the wunnerful
> combinations).

That doesn't address the "write failure turns into short read"
problem with the splice path...

> 3. #2, but fix the generic fallback to not suck so badly.  That sounds
> like someone (else's) 2yr project. :P

Not mine, either.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
