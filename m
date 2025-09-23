Return-Path: <linux-fsdevel+bounces-62528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B187BB97AFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 00:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83D724E1036
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 22:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF1430DEC9;
	Tue, 23 Sep 2025 22:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln4Hc1KS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C1E27FB2A;
	Tue, 23 Sep 2025 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758665415; cv=none; b=KN0GdF+sUUZ+1jZwANuRAOnwk8Ml5lciojvPfGQQXvpW8+dDWfh4YwMUkzkAF4KO8Ag209esqV/cKqBFJ4Ss7BHTCqdmdaTGhhIFxj+RKCDVFUBkeeD547HScIOS4ZwD5moMEkZO5oBXOiwJZ3NcYYpfrKmMY3vy1aIFYRT5HIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758665415; c=relaxed/simple;
	bh=pCyd17iT+fY9ppN0VLaMy9gSDh3Pimaf0oWgJinPzPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aI+dAIaHvKDG+ADXt6i1zh350rrD2FXxl/M7rmjHsKJZwqmcmJ/X7oLMvJscIhqN+VsbRAetksf4gY8PXDaM+FDVYyYUSvXdmy1+sOM4+anRF5pErIfQI46WVORb2bQ2JZrC9g11C1ELva5Dn8KyO4HEskWVzOyGCk68wPbhcSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln4Hc1KS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADEEC4CEF5;
	Tue, 23 Sep 2025 22:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758665415;
	bh=pCyd17iT+fY9ppN0VLaMy9gSDh3Pimaf0oWgJinPzPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ln4Hc1KSj1c61nlW2O9TZgtmlhK0a+TXi04GXFIrKu8bGTWFuF+T1WVdZsQGSwoHb
	 ZCeEwLV8ZLtp6URua9L4/C9Lu7zlEiyWUGwOkVcodT15O9g/2fK79A6f8zysslgKSq
	 IPvMWwfvV8zTGvHOJdtUSZ0vnbqQT1HNyicSBvpRQ8nnyGiNMlKz4C2ZY3/k8b3xhD
	 g/LS68UvOBgGajhZu76ChdondhArdYfKOawj6E8sTCxXoeWWn+2Z0eN0glzWqOZjz2
	 0y2y97+PSoOpB5I0lhjrQ3Z8ocrbISL2JuFIor3g7PqgUmSWvjXlrVWaIF3fKkaPDN
	 ZXVcrVFaV2+mw==
Date: Tue, 23 Sep 2025 15:10:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, linux-xfs@vger.kernel.org,
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev
Subject: Re: [PATCH 01/28] fuse: implement the basic iomap mechanisms
Message-ID: <20250923221014.GI8117@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
 <175798151288.382724.14189484118371001092.stgit@frogsfrogsfrogs>
 <CAJnrk1YtGcWj_0MOxS6atL_vrUjk09MzQhFt40yf32Rq12k0qw@mail.gmail.com>
 <20250923203246.GG1587915@frogsfrogsfrogs>
 <CAJnrk1aFEASvZmKftGpvR-P-KWMDLFYzjBCj4OF=EwteWmpECw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aFEASvZmKftGpvR-P-KWMDLFYzjBCj4OF=EwteWmpECw@mail.gmail.com>

On Tue, Sep 23, 2025 at 02:24:21PM -0700, Joanne Koong wrote:
> On Tue, Sep 23, 2025 at 1:32 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Fri, Sep 19, 2025 at 03:36:52PM -0700, Joanne Koong wrote:
> > > On Mon, Sep 15, 2025 at 5:28 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > >
> > > > Implement functions to enable upcalling of iomap_begin and iomap_end to
> > > > userspace fuse servers.
> > > >
> > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > ---
> > > >  fs/fuse/fuse_i.h          |   35 ++++
> > > >  fs/fuse/iomap_priv.h      |   36 ++++
> > > >  include/uapi/linux/fuse.h |   90 +++++++++
> > > >  fs/fuse/Kconfig           |   32 +++
> > > >  fs/fuse/Makefile          |    1
> > > >  fs/fuse/file_iomap.c      |  434 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  fs/fuse/inode.c           |    9 +
> > > >  7 files changed, 636 insertions(+), 1 deletion(-)
> > > >  create mode 100644 fs/fuse/iomap_priv.h
> > > >  create mode 100644 fs/fuse/file_iomap.c
> > > >
> > > > new file mode 100644
> > > > index 00000000000000..243d92cb625095
> > > > --- /dev/null
> > > > +++ b/fs/fuse/iomap_priv.h
> > > > @@ -0,0 +1,36 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (C) 2025 Oracle.  All Rights Reserved.
> > > > + * Author: Darrick J. Wong <djwong@kernel.org>
> > > > + */
> > > > +#ifndef _FS_FUSE_IOMAP_PRIV_H
> > > > +#define _FS_FUSE_IOMAP_PRIV_H
> > > > +
> > > ...
> > > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > > index 31b80f93211b81..3634cbe602cd9c 100644
> > > > --- a/include/uapi/linux/fuse.h
> > > > +++ b/include/uapi/linux/fuse.h
> > > > @@ -235,6 +235,9 @@
> > > >   *
> > > >   *  7.44
> > > >   *  - add FUSE_NOTIFY_INC_EPOCH
> > > > + *
> > > > + *  7.99
> > >
> > > Just curious, where did you get the .99 from?
> >
> > Any time I go adding to a versioned ABI, I try to use high numbers (and
> > high bits for flags) so that it's really obvious that the new flags are
> > in use when I poke through crash/gdb/etc.
> >
> > For permanent artifacts like an ondisk format, it's convenient to cache
> > fs images for fuzz testing, etc.  Using a high bit/number reduces the
> > chance that someone else's new feature will get merged and cause
> > conflicts, which force me to regenerate all cached images.
> >
> > Obviously at merge time I change these values to use lower bit positions
> > or version numbers to fit the merge target so it doesn't completely
> > eliminate the caching problems.
> 
> Ahh okay I see, thanks for the explanation!
> 
> >
> > > > + *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
> > > >   */
> > > >
> > > >  #ifndef _LINUX_FUSE_H
> > > > @@ -270,7 +273,7 @@
> > > >  #define FUSE_KERNEL_VERSION 7
> > > > diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> > > > index 9563fa5387a241..67dfe300bf2e07 100644
> > > > --- a/fs/fuse/Kconfig
> > > > +++ b/fs/fuse/Kconfig
> > > > @@ -69,6 +69,38 @@ config FUSE_PASSTHROUGH
> > > > +config FUSE_IOMAP_DEBUG
> > > > +       bool "Debug FUSE file IO over iomap"
> > > > +       default n
> > > > +       depends on FUSE_IOMAP
> > > > +       help
> > > > +         Enable debugging assertions for the fuse iomap code paths and logging
> > > > +         of bad iomap file mapping data being sent to the kernel.
> > > > +
> > >
> > > I wonder if we should have a general FUSE_DEBUG that this would fall
> > > under instead of creating one that's iomap_debug specific
> >
> > Probably, but I was also trying to keep this as localized to iomap as
> > possible.  If Miklos would rather I extend it to all of fuse (which is
> > probably a good idea!) then I'm happy to do so.
> >
> > > >  config FUSE_IO_URING
> > > >         bool "FUSE communication over io-uring"
> > > >         default y
> > > > diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> > > > index 46041228e5be2c..27be39317701d6 100644
> > > > --- a/fs/fuse/Makefile
> > > > +++ b/fs/fuse/Makefile
> > > > @@ -18,5 +18,6 @@ fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
> > > >  fuse-$(CONFIG_FUSE_BACKING) += backing.o
> > > >  fuse-$(CONFIG_SYSCTL) += sysctl.o
> > > >  fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
> > > > +fuse-$(CONFIG_FUSE_IOMAP) += file_iomap.o
> > > >
> > > >  virtiofs-y := virtio_fs.o
> > > > diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> > > > new file mode 100644
> > > > index 00000000000000..dda757768d3ea6
> > > > --- /dev/null
> > > > +++ b/fs/fuse/file_iomap.c
> > > > @@ -0,0 +1,434 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (C) 2025 Oracle.  All Rights Reserved.
> > > > + * Author: Darrick J. Wong <djwong@kernel.org>
> > > > + */
> > > > +#include <linux/iomap.h>
> > > > +#include "fuse_i.h"
> > > > +#include "fuse_trace.h"
> > > > +#include "iomap_priv.h"
> > > > +
> > > > +/* Validate FUSE_IOMAP_TYPE_* */
> > > > +static inline bool fuse_iomap_check_type(uint16_t fuse_type)
> > > > +{
> > > > +       switch (fuse_type) {
> > > > +       case FUSE_IOMAP_TYPE_HOLE:
> > > > +       case FUSE_IOMAP_TYPE_DELALLOC:
> > > > +       case FUSE_IOMAP_TYPE_MAPPED:
> > > > +       case FUSE_IOMAP_TYPE_UNWRITTEN:
> > > > +       case FUSE_IOMAP_TYPE_INLINE:
> > > > +       case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
> > > > +               return true;
> > > > +       }
> > > > +
> > > > +       return false;
> > > > +}
> > >
> > > Maybe faster to check by using a bitmask instead?
> >
> > They're consecutive; one could #define a FUSE_IOMAP_TYPE_MAX to alias
> > PURE_OVERWRITE and collapse the whole check to:
> >
> >         return fuse_type <= FUSE_IOMAP_TYPE_MAX;
> >
> > > > +
> > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > index 1e7298b2b89b58..32f4b7c9a20a8a 100644
> > > > --- a/fs/fuse/inode.c
> > > > +++ b/fs/fuse/inode.c
> > > > @@ -1448,6 +1448,13 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
> > > >
> > > >                         if (flags & FUSE_REQUEST_TIMEOUT)
> > > >                                 timeout = arg->request_timeout;
> > > > +
> > > > +                       if ((flags & FUSE_IOMAP) && fuse_iomap_enabled()) {
> > > > +                               fc->local_fs = 1;
> > > > +                               fc->iomap = 1;
> > > > +                               printk(KERN_WARNING
> > > > + "fuse: EXPERIMENTAL iomap feature enabled.  Use at your own risk!");
> > > > +                       }
> > >
> > > pr_warn() seems to be the convention elsewhere in the fuse code
> >
> > Ah, thanks.  Do you know why fuse calls pr_warn("fuse: XXX") instead of
> > the usual sequence of
> >
> > #define pr_fmt(fmt) "fuse: " fmt
> >
> > so that "fuse: " gets included automatically?
> 
> I think it does do this, or at least that's what I see in fuse_i.h :D

Whoooops, sorry for the noise :)

--D

> Thanks,
> Joanne
> >
> > --D
> >
> > >
> > > Thanks,
> > > Joanne
> > > >                 } else {
> > > >                         ra_pages = fc->max_read / PAGE_SIZE;
> > > >                         fc->no_lock = 1;
> > > > @@ -1516,6 +1523,8 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
> > > >          */
> > > >         if (fuse_uring_enabled())
> > > >                 flags |= FUSE_OVER_IO_URING;
> > > > +       if (fuse_iomap_enabled())
> > > > +               flags |= FUSE_IOMAP;
> > > >
> > > >         ia->in.flags = flags;
> > > >         ia->in.flags2 = flags >> 32;
> > > >
> > >

