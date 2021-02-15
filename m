Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D246031B5E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 09:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhBOIbR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 03:31:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhBOIbQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 03:31:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0352764E00;
        Mon, 15 Feb 2021 08:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613377833;
        bh=M1yH8f5Vs5aiYy2Yl7CcI59gqMuFSQzURbN1sbR9EFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n2g8aeRfVutEPCdSWe2sBMVt70VVxonbwr0AX2NE3r6QQTdGzBsz8/uDq9qUqhTY0
         vdxcxg4GgNDoYH55WVZEE/eoH9Sz4CeAOe8JdprmC7maF2QkbGFNdXTkpFs5wxc6LU
         RSDbTZVX9UQmi3LGEmK2mZBWhJi7ADWIo4KLetEc=
Date:   Mon, 15 Feb 2021 09:30:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Ian Lance Taylor <iant@golang.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Lozano <llozano@chromium.org>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
Message-ID: <YCoxJBlc0XrNjVPF@kroah.com>
References: <YCY+Ytr2J2R5Vh0+@kroah.com>
 <CAKOQZ8zPFM29DYPwbnUJEhf+a8kPSJ5E_W06JLFjn-5Fy-ZWWw@mail.gmail.com>
 <YCaipZ+iY65iSrui@kroah.com>
 <20210212230346.GU4626@dread.disaster.area>
 <CAOyqgcX_wN2RGunDix5rSWxtp3pvSpFy2Stx-Ln4GozgSeS2LQ@mail.gmail.com>
 <20210212232726.GW4626@dread.disaster.area>
 <20210212235448.GH7187@magnolia>
 <20210215003855.GY4626@dread.disaster.area>
 <CAOyqgcX6HrbPU39nznmRMXJXtMWA0giYNRsio1jt1p5OU1jvOA@mail.gmail.com>
 <CANMq1KDv-brWeKOTt3aUUi_1SOXSpEFo5pS5A6mpRT8k-O88nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANMq1KDv-brWeKOTt3aUUi_1SOXSpEFo5pS5A6mpRT8k-O88nA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:25:36AM +0800, Nicolas Boichat wrote:
> On Mon, Feb 15, 2021 at 9:12 AM Ian Lance Taylor <iant@golang.org> wrote:
> >
> > On Sun, Feb 14, 2021 at 4:38 PM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Fri, Feb 12, 2021 at 03:54:48PM -0800, Darrick J. Wong wrote:
> > > > On Sat, Feb 13, 2021 at 10:27:26AM +1100, Dave Chinner wrote:
> > > >
> > > > > If you can't tell from userspace that a file has data in it other
> > > > > than by calling read() on it, then you can't use cfr on it.
> > > >
> > > > I don't know how to do that, Dave. :)
> > >
> > > If stat returns a non-zero size, then userspace knows it has at
> > > least that much data in it, whether it be zeros or previously
> > > written data. cfr will copy that data. The special zero length
> > > regular pipe files fail this simple "how much data is there to copy
> > > in this file" check...
> >
> > This suggests that if the Go standard library sees that
> > copy_file_range reads zero bytes, we should assume that it failed, and
> > should use the fallback path as though copy_file_range returned
> > EOPNOTSUPP or EINVAL.  This will cause an extra system call for an
> > empty file, but as long as copy_file_range does not return an error
> > for cases that it does not support we are going to need an extra
> > system call anyhow.
> >
> > Does that seem like a possible mitigation?  That is, are there cases
> > where copy_file_range will fail to do a correct copy, and will return
> > success, and will not return zero?
> 
> I'm a bit worried about the sysfs files that report a 4096 bytes file
> size, for 2 reasons:
>  - I'm not sure if the content _can_ actually be longer (I couldn't
> find a counterexample)

There are quite a few, look for binary sysfs files that are pipes from
hardware/firmware resources to userspace.  /sys/firmware/efi/efivars/
has a number of them if you want to play around with it.

thanks,

greg k-h
