Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF2531A82D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Feb 2021 00:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhBLXEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 18:04:37 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:35325 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231273AbhBLXEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 18:04:34 -0500
Received: from dread.disaster.area (pa49-181-52-82.pa.nsw.optusnet.com.au [49.181.52.82])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 2A31E475EB;
        Sat, 13 Feb 2021 10:03:47 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lAhTW-001rkA-Gg; Sat, 13 Feb 2021 10:03:46 +1100
Date:   Sat, 13 Feb 2021 10:03:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ian Lance Taylor <iant@golang.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Lozano <llozano@chromium.org>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
Message-ID: <20210212230346.GU4626@dread.disaster.area>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
 <YCYybUg4d3+Oij4N@kroah.com>
 <CANMq1KBuPaU5UtRR8qTgdf+J3pt-xAQq69kCVBdaYGx8F+WmFA@mail.gmail.com>
 <YCY+Ytr2J2R5Vh0+@kroah.com>
 <CAKOQZ8zPFM29DYPwbnUJEhf+a8kPSJ5E_W06JLFjn-5Fy-ZWWw@mail.gmail.com>
 <YCaipZ+iY65iSrui@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCaipZ+iY65iSrui@kroah.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=7pwokN52O8ERr2y46pWGmQ==:117 a=7pwokN52O8ERr2y46pWGmQ==:17
        a=kj9zAlcOel0A:10 a=qa6Q16uM49sA:10 a=ag1SF4gXAAAA:8 a=7-415B0cAAAA:8
        a=mfgKy8Yz_Jnml6xrhjwA:9 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 04:45:41PM +0100, Greg KH wrote:
> On Fri, Feb 12, 2021 at 07:33:57AM -0800, Ian Lance Taylor wrote:
> > On Fri, Feb 12, 2021 at 12:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > Why are people trying to use copy_file_range on simple /proc and /sys
> > > files in the first place?  They can not seek (well most can not), so
> > > that feels like a "oh look, a new syscall, let's use it everywhere!"
> > > problem that userspace should not do.
> > 
> > This may have been covered elsewhere, but it's not that people are
> > saying "let's use copy_file_range on files in /proc."  It's that the
> > Go language standard library provides an interface to operating system
> > files.  When Go code uses the standard library function io.Copy to
> > copy the contents of one open file to another open file, then on Linux
> > kernels 5.3 and greater the Go standard library will use the
> > copy_file_range system call.  That seems to be exactly what
> > copy_file_range is intended for.  Unfortunately it appears that when
> > people writing Go code open a file in /proc and use io.Copy the
> > contents to another open file, copy_file_range does nothing and
> > reports success.  There isn't anything on the copy_file_range man page
> > explaining this limitation, and there isn't any documented way to know
> > that the Go standard library should not use copy_file_range on certain
> > files.
> 
> But, is this a bug in the kernel in that the syscall being made is not
> working properly, or a bug in that Go decided to do this for all types
> of files not knowing that some types of files can not handle this?
> 
> If the kernel has always worked this way, I would say that Go is doing
> the wrong thing here.  If the kernel used to work properly, and then
> changed, then it's a regression on the kernel side.
> 
> So which is it?

Both Al Viro and myself have said "copy file range is not a generic
method for copying data between two file descriptors". It is a
targetted solution for *regular files only* on filesystems that store
persistent data and can accelerate the data copy in some way (e.g.
clone, server side offload, hardware offlead, etc). It is not
intended as a copy mechanism for copying data from one random file
descriptor to another.

The use of it as a general file copy mechanism in the Go system
library is incorrect and wrong. It is a userspace bug.  Userspace
has done the wrong thing, userspace needs to be fixed.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
