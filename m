Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30BC31A202
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 16:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhBLPqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 10:46:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231731AbhBLPqZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:46:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B96FD64E05;
        Fri, 12 Feb 2021 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613144744;
        bh=qAkxI2payHVPgy5p/M13gZv73tlbs9in+RM2Honv+/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5CDgd4p15otjppQPBw4gXd3vHvXINpW5j1xt8ElGhl7PZkQ9gJk5zFyL5sjttTWf
         eYiBwuaRStYE/XhBcsNglNC5ONtvieRJTNT3Cajj2Xlxdv4FkGUkwxBTvz4cVaOTgR
         eZd2uY2D416b44cC7Bb/QqaJ3gFkN2WEthjBqn0Y=
Date:   Fri, 12 Feb 2021 16:45:41 +0100
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
Message-ID: <YCaipZ+iY65iSrui@kroah.com>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
 <YCYybUg4d3+Oij4N@kroah.com>
 <CANMq1KBuPaU5UtRR8qTgdf+J3pt-xAQq69kCVBdaYGx8F+WmFA@mail.gmail.com>
 <YCY+Ytr2J2R5Vh0+@kroah.com>
 <CAKOQZ8zPFM29DYPwbnUJEhf+a8kPSJ5E_W06JLFjn-5Fy-ZWWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOQZ8zPFM29DYPwbnUJEhf+a8kPSJ5E_W06JLFjn-5Fy-ZWWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 07:33:57AM -0800, Ian Lance Taylor wrote:
> On Fri, Feb 12, 2021 at 12:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Why are people trying to use copy_file_range on simple /proc and /sys
> > files in the first place?  They can not seek (well most can not), so
> > that feels like a "oh look, a new syscall, let's use it everywhere!"
> > problem that userspace should not do.
> 
> This may have been covered elsewhere, but it's not that people are
> saying "let's use copy_file_range on files in /proc."  It's that the
> Go language standard library provides an interface to operating system
> files.  When Go code uses the standard library function io.Copy to
> copy the contents of one open file to another open file, then on Linux
> kernels 5.3 and greater the Go standard library will use the
> copy_file_range system call.  That seems to be exactly what
> copy_file_range is intended for.  Unfortunately it appears that when
> people writing Go code open a file in /proc and use io.Copy the
> contents to another open file, copy_file_range does nothing and
> reports success.  There isn't anything on the copy_file_range man page
> explaining this limitation, and there isn't any documented way to know
> that the Go standard library should not use copy_file_range on certain
> files.

But, is this a bug in the kernel in that the syscall being made is not
working properly, or a bug in that Go decided to do this for all types
of files not knowing that some types of files can not handle this?

If the kernel has always worked this way, I would say that Go is doing
the wrong thing here.  If the kernel used to work properly, and then
changed, then it's a regression on the kernel side.

So which is it?

> So ideally the kernel will report EOPNOTSUPP or EINVAL when using
> copy_file_range on a file in /proc or some other file system that
> fails (and, minor side note, the copy_file_range man page should
> document that it can return EOPNOTSUPP or EINVAL in some cases, which
> does already happen on at least some kernel versions using at least
> some file systems).

Documentation is good, but what the kernel does is the true "definition"
of what is going right or wrong here.

thanks,

greg k-h
