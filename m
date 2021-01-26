Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8935B3046B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 19:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390095AbhAZRV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 12:21:29 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:42048 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730808AbhAZHuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:50:52 -0500
Received: from dread.disaster.area (pa49-180-243-77.pa.nsw.optusnet.com.au [49.180.243.77])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 05DF38278DE;
        Tue, 26 Jan 2021 18:49:57 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l4J6q-002Wuh-24; Tue, 26 Jan 2021 18:49:56 +1100
Date:   Tue, 26 Jan 2021 18:49:56 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Luis Lozano <llozano@chromium.org>, iant@google.com
Subject: Re: [BUG] copy_file_range with sysfs file as input
Message-ID: <20210126074956.GF4626@dread.disaster.area>
References: <CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com>
 <20210126013414.GE4626@dread.disaster.area>
 <CANMq1KAgD_98607w308h3QSGaiRTkyVThmWmUuExxqh3r+tZsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANMq1KAgD_98607w308h3QSGaiRTkyVThmWmUuExxqh3r+tZsA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=juxvdbeFDU67v5YkIhU0sw==:117 a=juxvdbeFDU67v5YkIhU0sw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8 a=GcyzOjIWAAAA:8
        a=J2zK9Hhgt6MEY7-RQMQA:9 a=CjuIK1q_8ugA:10 a=2fKfcJrRRacA:10
        a=biEYGPWJfzWAr4FL6Ov7:22 a=hQL3dl6oAZ8NdCsdz28n:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 11:50:50AM +0800, Nicolas Boichat wrote:
> On Tue, Jan 26, 2021 at 9:34 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Jan 25, 2021 at 03:54:31PM +0800, Nicolas Boichat wrote:
> > > Hi copy_file_range experts,
> > >
> > > We hit this interesting issue when upgrading Go compiler from 1.13 to
> > > 1.15 [1]. Basically we use Go's `io.Copy` to copy the content of
> > > `/sys/kernel/debug/tracing/trace` to a temporary file.
> > >
> > > Under the hood, Go now uses `copy_file_range` syscall to optimize the
> > > copy operation. However, that fails to copy any content when the input
> > > file is from sysfs/tracefs, with an apparent size of 0 (but there is
> > > still content when you `cat` it, of course).
> > >
> > > A repro case is available in comment7 (adapted from the man page),
> > > also copied below [2].
> > >
> > > Output looks like this (on kernels 5.4.89 (chromeos), 5.7.17 and
> > > 5.10.3 (chromeos))
> > > $ ./copyfrom /sys/kernel/debug/tracing/trace x
> > > 0 bytes copied
> >
> > That's basically telling you that copy_file_range() was unable to
> > copy anything. The man page says:
> >
> > RETURN VALUE
> >        Upon  successful  completion,  copy_file_range() will return
> >        the number of bytes copied between files.  This could be less
> >        than the length originally requested.  If the file offset
> >        of fd_in is at or past the end of file, no bytes are copied,
> >        and copy_file_range() returns zero.
> >
> > THe man page explains it perfectly.
> 
> I'm not that confident the explanation is perfect ,-)
> 
> How does one define "EOF"? The read manpage
> (https://man7.org/linux/man-pages/man2/read.2.html) defines it as a
> zero return value.

And so does copy_file_range(). That's the -API definition-, it does
not define the kernel implementation of how to decide when the file
is at EOF.

> I don't think using the inode file size is
> standard.

It is the standard VFS filesystem definition of EOF.

Indeed:

copy_file_range()
  vfs_copy_file_range()
    generic_copy_file_checks()
    .....

        /* Shorten the copy to EOF */
        size_in = i_size_read(inode_in);
        if (pos_in >= size_in)
                count = 0;
        else
                count = min(count, size_in - (uint64_t)pos_in);

That inode size check for EOF is -exactly- what is triggering here,
and a copy of zero length returns 0 bytes having done nothing.

The page cache read path does similar things in
generic_file_buffered_read() to avoid truncate races exposing
stale/bad data to userspace:


                /*
                 * i_size must be checked after we know the pages are Uptodate.
                 *
                 * Checking i_size after the check allows us to calculate
                 * the correct value for "nr", which means the zero-filled
                 * part of the page is not copied back to userspace (unless
                 * another truncate extends the file - this is desired though).
                 */
                isize = i_size_read(inode);
                if (unlikely(iocb->ki_pos >= isize))
                        goto put_pages;

> > 'cat' "works" in this situation because it doesn't check the file
> > size and just attempts to read unconditionally from the file. Hence
> > it happily returns non-existent stale data from busted filesystem
> > implementations that allow data to be read from beyond EOF...
> 
> `cp` also works, so does `dd` and basically any other file operation.

They do not use a syscall interface that can offload work to
filesystems, low level block layer software, hardware and/or remote
systems. copy_file_range() is restricted to regular files and does
complex stuff that read() and friends will never do, so we have
strictly enforced rules to prevent people from playing fast and
loose and silently corrupting user data with it....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
