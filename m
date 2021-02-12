Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06F8319B56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 09:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhBLIis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 03:38:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhBLIim (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 03:38:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0037E64E56;
        Fri, 12 Feb 2021 08:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613119077;
        bh=WwD8KDyLd8nubUCGLTXumCtXSFt4j2g3yg3qsZbiPRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x1aGPghi3zHWlS5k6ZGXgagybwHjJmCu5f3Aa7ZfjEbp/LqvLM6weIsFlbfEpJavX
         ukWrwgpogba+FBpTAnuZlyI9iViyHaMa8iiKUE5KUqLxKGB4+QCs9WwVRqfBfbzAGf
         UZ2+q1Tb9pIxjovLOP5uMYx0jfEkpmaYr5PiXNAo=
Date:   Fri, 12 Feb 2021 09:37:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
Message-ID: <YCY+Ytr2J2R5Vh0+@kroah.com>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
 <YCYybUg4d3+Oij4N@kroah.com>
 <CANMq1KBuPaU5UtRR8qTgdf+J3pt-xAQq69kCVBdaYGx8F+WmFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANMq1KBuPaU5UtRR8qTgdf+J3pt-xAQq69kCVBdaYGx8F+WmFA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 04:20:17PM +0800, Nicolas Boichat wrote:
> On Fri, Feb 12, 2021 at 3:46 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Feb 12, 2021 at 12:44:00PM +0800, Nicolas Boichat wrote:
> > > Filesystems such as procfs and sysfs generate their content at
> > > runtime. This implies the file sizes do not usually match the
> > > amount of data that can be read from the file, and that seeking
> > > may not work as intended.
> > >
> > > This will be useful to disallow copy_file_range with input files
> > > from such filesystems.
> > >
> > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > ---
> > > I first thought of adding a new field to struct file_operations,
> > > but that doesn't quite scale as every single file creation
> > > operation would need to be modified.
> >
> > Even so, you missed a load of filesystems in the kernel with this patch
> > series, what makes the ones you did mark here different from the
> > "internal" filesystems that you did not?
> 
> Which ones did I miss? (apart from configfs, see the conversation on
> patch 6/6). Anyway, hopefully auditing all filesystems is an order of
> magnitude easier task, and easier to maintain in the longer run ,-)

Are you going to be the one to add this to each new filesystem that is
added to the kernel?

I see filesystems in drivers/char/mem.c and
drivers/infiniband/hw/qib/qib_fs.c and drivers/misc/ibmasm/ibmasmfs.c
and loads of other driver-specific filesystems.  Do all of those "just
work" somehow?

> > This feels wrong, why is userspace suddenly breaking?  What changed in
> > the kernel that caused this?  Procfs has been around for a _very_ long
> > time :)
> 
> Some of this is covered in the cover letter 0/6. To expand a bit:
> copy_file_range has only supported cross-filesystem copies since 5.3
> [1], before that the kernel would return EXDEV and userspace
> application would fall back to a read/write based copy. After 5.3,
> copy_file_range copies no data as it thinks the input file is empty.

So older kernels work fine with this system call on procfs, but newer
ones do not?  If so, that's a regression that should be fixed in the
original area, but should not require a new filesystem flag for every
individual one out there.  That way lies madness and constant auditing
that I do not see anyone signing up for for the next 20 years, right?

> [1] I think it makes little sense to try to use copy_file_range
> between 2 files in /proc, but technically, I think that has been
> broken since copy_file_range fallback to do_splice_direct was
> introduced (eac70053a141 ("vfs: Add vfs_copy_file_range() support for
> pagecache copies", ~4.4).

Why are people trying to use copy_file_range on simple /proc and /sys
files in the first place?  They can not seek (well most can not), so
that feels like a "oh look, a new syscall, let's use it everywhere!"
problem that userspace should not do.

thanks,

greg k-h
