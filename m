Return-Path: <linux-fsdevel+bounces-62523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D58B97802
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 22:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19791AE0912
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 20:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999182F1FDD;
	Tue, 23 Sep 2025 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U84uTNtA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA41634BA3A;
	Tue, 23 Sep 2025 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758659568; cv=none; b=V8TCGm5KMR1Zd+qQp1UeZuJU13PZOFxlr0LL9VF0utR0EwaLnQQhLfK7YoRzmEZJ/0TYFCvWZMkiIf33TKYroSRke1LP0HO2r0wA84y4DYJoUo4ynJ1Keptk+RTDyKZtzQ3ZbR+dyx3Mhk7cfaixMMV7Us/8fw9HsT5iYxqsMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758659568; c=relaxed/simple;
	bh=cUq2cQ5+m633VRCAL01UwlejVemUBn8hd6jvhWwLlEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ma1IknS27LgPakSixRc5/9Jen/068cHI76pF0o5aJue5O7jUZDZYoDzWvor9xrOLgNkloWBRxJQdYbmBMobNh5OeU5IrMYHt7vaf5qrZfR8r6hebjVqPSv11ONuAvk1ha48kE5w2IfyaKlGgS8y7+A0KBy6S2zmldQSx415V7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U84uTNtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5F9C4CEF5;
	Tue, 23 Sep 2025 20:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758659567;
	bh=cUq2cQ5+m633VRCAL01UwlejVemUBn8hd6jvhWwLlEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U84uTNtAINGu8jQ48fBoj4ynJ47ol+fhTIqfy2jx6vzF6KSEsFw1VWlLFIe5ai4+J
	 SDnjhxmPC37asmH1KmLYw2jpvMq7AcK0vPSGy12Ws4EeJG+QnK+Ffya+efopIYVDvL
	 3RlpnrDPvBhsK0Vumc+DVP7vX8CXVRF0R/R3yWNJlm0sfYMALnXClW0dM+dAXqcDRe
	 YIKJH1Gg8ztURhmEGSrBDaW8mpik96ThfQ1RgRZgKtsoev9hXLmBrp7bED7kOmXzMG
	 u+M07RcCN6FA7DbU/Ml+vkbf3Ffy3LZNISmQxXSl51lBmd9WuPueCfZpI2fzEOnVOx
	 ZvoLyJDqrvyWw==
Date: Tue, 23 Sep 2025 13:32:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, linux-xfs@vger.kernel.org,
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev
Subject: Re: [PATCH 01/28] fuse: implement the basic iomap mechanisms
Message-ID: <20250923203246.GG1587915@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
 <175798151288.382724.14189484118371001092.stgit@frogsfrogsfrogs>
 <CAJnrk1YtGcWj_0MOxS6atL_vrUjk09MzQhFt40yf32Rq12k0qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YtGcWj_0MOxS6atL_vrUjk09MzQhFt40yf32Rq12k0qw@mail.gmail.com>

On Fri, Sep 19, 2025 at 03:36:52PM -0700, Joanne Koong wrote:
> On Mon, Sep 15, 2025 at 5:28 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Implement functions to enable upcalling of iomap_begin and iomap_end to
> > userspace fuse servers.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_i.h          |   35 ++++
> >  fs/fuse/iomap_priv.h      |   36 ++++
> >  include/uapi/linux/fuse.h |   90 +++++++++
> >  fs/fuse/Kconfig           |   32 +++
> >  fs/fuse/Makefile          |    1
> >  fs/fuse/file_iomap.c      |  434 +++++++++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/inode.c           |    9 +
> >  7 files changed, 636 insertions(+), 1 deletion(-)
> >  create mode 100644 fs/fuse/iomap_priv.h
> >  create mode 100644 fs/fuse/file_iomap.c
> >
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 4560687d619d76..f0d408a6e12c32 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -923,6 +923,9 @@ struct fuse_conn {
> >         /* Is synchronous FUSE_INIT allowed? */
> >         unsigned int sync_init:1;
> >
> > +       /* Enable fs/iomap for file operations */
> > +       unsigned int iomap:1;
> > +
> >         /* Use io_uring for communication */
> >         unsigned int io_uring;
> >
> > @@ -1047,6 +1050,11 @@ static inline struct fuse_mount *get_fuse_mount_super(struct super_block *sb)
> >         return sb->s_fs_info;
> >  }
> >
> > +static inline const struct fuse_mount *get_fuse_mount_super_c(const struct super_block *sb)
> > +{
> > +       return sb->s_fs_info;
> > +}
> > +
> >  static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
> >  {
> >         return get_fuse_mount_super(sb)->fc;
> > @@ -1057,16 +1065,31 @@ static inline struct fuse_mount *get_fuse_mount(struct inode *inode)
> >         return get_fuse_mount_super(inode->i_sb);
> >  }
> >
> > +static inline const struct fuse_mount *get_fuse_mount_c(const struct inode *inode)
> > +{
> > +       return get_fuse_mount_super_c(inode->i_sb);
> > +}
> > +
> >  static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
> >  {
> >         return get_fuse_mount_super(inode->i_sb)->fc;
> >  }
> >
> > +static inline const struct fuse_conn *get_fuse_conn_c(const struct inode *inode)
> > +{
> > +       return get_fuse_mount_super_c(inode->i_sb)->fc;
> > +}
> > +
> >  static inline struct fuse_inode *get_fuse_inode(struct inode *inode)
> >  {
> >         return container_of(inode, struct fuse_inode, inode);
> >  }
> >
> > +static inline const struct fuse_inode *get_fuse_inode_c(const struct inode *inode)
> > +{
> > +       return container_of(inode, struct fuse_inode, inode);
> > +}
> 
> Do we need these new set of helpers? AFAICT it does two things: a)
> guarantee constness of the arg passed in b) guarantee constness of the
> pointer returned
> 
> But it seems like for a) we could get that by modifying the existing
> functions to take in a const arg, eg
> 
> -static inline struct fuse_inode *get_fuse_inode(struct inode *inode)
> +static inline struct fuse_inode *get_fuse_inode(const struct inode *inode)
>  {
>       return container_of(inode, struct fuse_inode, inode);
>  }
> 
> and for b) it seems to me like the caller enforces the constness of
> the pointer returned whether the actual function returns a const
> pointer or not,
> 
> eg
> const struct fuse_inode *fi = get_fuse_inode{_c}(inode);
> 
> Maybe I'm missing something here but it seems to me like we don't need
> these new helpers?

Heh.  I had mistakenly thought that one cannot cast a const struct
pointer to a mutable const struct pointer, but I just tried your
suggestion and it seemed to work fine.  So I guess we don't need
get_fuse_mount_c either.

Yay C, all it's doing is taking a number pointing to something that
can't be changed, subtracting from it, and thus returning a different
number.  Perhaps Rust has polluted my brain.

> > +
> > diff --git a/fs/fuse/iomap_priv.h b/fs/fuse/iomap_priv.h
> 
> btw, i think the general convention is to use "_i.h" suffixing for
> private internal files, eg fuse_i.h, fuse_dev_i.h, dev_uring_i.h

Noted, thank you.

> > new file mode 100644
> > index 00000000000000..243d92cb625095
> > --- /dev/null
> > +++ b/fs/fuse/iomap_priv.h
> > @@ -0,0 +1,36 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2025 Oracle.  All Rights Reserved.
> > + * Author: Darrick J. Wong <djwong@kernel.org>
> > + */
> > +#ifndef _FS_FUSE_IOMAP_PRIV_H
> > +#define _FS_FUSE_IOMAP_PRIV_H
> > +
> ...
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 31b80f93211b81..3634cbe602cd9c 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -235,6 +235,9 @@
> >   *
> >   *  7.44
> >   *  - add FUSE_NOTIFY_INC_EPOCH
> > + *
> > + *  7.99
> 
> Just curious, where did you get the .99 from?

Any time I go adding to a versioned ABI, I try to use high numbers (and
high bits for flags) so that it's really obvious that the new flags are
in use when I poke through crash/gdb/etc.

For permanent artifacts like an ondisk format, it's convenient to cache
fs images for fuzz testing, etc.  Using a high bit/number reduces the
chance that someone else's new feature will get merged and cause
conflicts, which force me to regenerate all cached images.

Obviously at merge time I change these values to use lower bit positions
or version numbers to fit the merge target so it doesn't completely
eliminate the caching problems.

> > + *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
> >   */
> >
> >  #ifndef _LINUX_FUSE_H
> > @@ -270,7 +273,7 @@
> >  #define FUSE_KERNEL_VERSION 7
> > diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> > index 9563fa5387a241..67dfe300bf2e07 100644
> > --- a/fs/fuse/Kconfig
> > +++ b/fs/fuse/Kconfig
> > @@ -69,6 +69,38 @@ config FUSE_PASSTHROUGH
> > +config FUSE_IOMAP_DEBUG
> > +       bool "Debug FUSE file IO over iomap"
> > +       default n
> > +       depends on FUSE_IOMAP
> > +       help
> > +         Enable debugging assertions for the fuse iomap code paths and logging
> > +         of bad iomap file mapping data being sent to the kernel.
> > +
> 
> I wonder if we should have a general FUSE_DEBUG that this would fall
> under instead of creating one that's iomap_debug specific

Probably, but I was also trying to keep this as localized to iomap as
possible.  If Miklos would rather I extend it to all of fuse (which is
probably a good idea!) then I'm happy to do so.

> >  config FUSE_IO_URING
> >         bool "FUSE communication over io-uring"
> >         default y
> > diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> > index 46041228e5be2c..27be39317701d6 100644
> > --- a/fs/fuse/Makefile
> > +++ b/fs/fuse/Makefile
> > @@ -18,5 +18,6 @@ fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
> >  fuse-$(CONFIG_FUSE_BACKING) += backing.o
> >  fuse-$(CONFIG_SYSCTL) += sysctl.o
> >  fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
> > +fuse-$(CONFIG_FUSE_IOMAP) += file_iomap.o
> >
> >  virtiofs-y := virtio_fs.o
> > diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> > new file mode 100644
> > index 00000000000000..dda757768d3ea6
> > --- /dev/null
> > +++ b/fs/fuse/file_iomap.c
> > @@ -0,0 +1,434 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2025 Oracle.  All Rights Reserved.
> > + * Author: Darrick J. Wong <djwong@kernel.org>
> > + */
> > +#include <linux/iomap.h>
> > +#include "fuse_i.h"
> > +#include "fuse_trace.h"
> > +#include "iomap_priv.h"
> > +
> > +/* Validate FUSE_IOMAP_TYPE_* */
> > +static inline bool fuse_iomap_check_type(uint16_t fuse_type)
> > +{
> > +       switch (fuse_type) {
> > +       case FUSE_IOMAP_TYPE_HOLE:
> > +       case FUSE_IOMAP_TYPE_DELALLOC:
> > +       case FUSE_IOMAP_TYPE_MAPPED:
> > +       case FUSE_IOMAP_TYPE_UNWRITTEN:
> > +       case FUSE_IOMAP_TYPE_INLINE:
> > +       case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
> > +               return true;
> > +       }
> > +
> > +       return false;
> > +}
> 
> Maybe faster to check by using a bitmask instead?

They're consecutive; one could #define a FUSE_IOMAP_TYPE_MAX to alias
PURE_OVERWRITE and collapse the whole check to:

	return fuse_type <= FUSE_IOMAP_TYPE_MAX;

> > +
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 1e7298b2b89b58..32f4b7c9a20a8a 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1448,6 +1448,13 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
> >
> >                         if (flags & FUSE_REQUEST_TIMEOUT)
> >                                 timeout = arg->request_timeout;
> > +
> > +                       if ((flags & FUSE_IOMAP) && fuse_iomap_enabled()) {
> > +                               fc->local_fs = 1;
> > +                               fc->iomap = 1;
> > +                               printk(KERN_WARNING
> > + "fuse: EXPERIMENTAL iomap feature enabled.  Use at your own risk!");
> > +                       }
> 
> pr_warn() seems to be the convention elsewhere in the fuse code

Ah, thanks.  Do you know why fuse calls pr_warn("fuse: XXX") instead of
the usual sequence of

#define pr_fmt(fmt) "fuse: " fmt

so that "fuse: " gets included automatically?

--D

> 
> Thanks,
> Joanne
> >                 } else {
> >                         ra_pages = fc->max_read / PAGE_SIZE;
> >                         fc->no_lock = 1;
> > @@ -1516,6 +1523,8 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
> >          */
> >         if (fuse_uring_enabled())
> >                 flags |= FUSE_OVER_IO_URING;
> > +       if (fuse_iomap_enabled())
> > +               flags |= FUSE_IOMAP;
> >
> >         ia->in.flags = flags;
> >         ia->in.flags2 = flags >> 32;
> >
> 

