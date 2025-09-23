Return-Path: <linux-fsdevel+bounces-62527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9760CB97914
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 23:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503B42E6929
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 21:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D6B26CE17;
	Tue, 23 Sep 2025 21:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnRHDJ4N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C16265CBD
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662675; cv=none; b=aW+S22Fv5EMaMGKtxn4GQJ258rZDmcL0bEDa8QWhUaAKLPCUGO6D2XVTetE0lANG5+YzAg5iv488fqzVen1qHewtTTQRkDR4E49ukKdV/LRM46MlsO+6HsqOo8X1E5RFPIUa9ohUI5BATnpwkXSU3UAhv/hcPkMQrx8B8IjtNx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662675; c=relaxed/simple;
	bh=ZjkpPFCBCyotV9MUq/4yhCFoOmssscfCk6c7VUOepAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k84ROUv36fvAs81+ODCr6COOEs5DpzG1M7Z4ZnL+jp6R8rySFj+edU1IKr/O8igyFhuKNlpdJPK49m/IU1AXvzIBKk30lz55/ftv4B2UszZo0zdOlvGT/S2KXBnOyEDrZ1iywWPI1lknih/GZH8hV9NRQdRnQZ7/Ky0ppCMtnew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnRHDJ4N; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-854585036e8so79150285a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 14:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662672; x=1759267472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+26hvu8We2RH0lhumRvV1NkaTXlFMtaSHPfkqJZ1j9c=;
        b=bnRHDJ4Nx9beSz0JeTq7vVPr03gbvdXDbkCJaLyufMoueY5GEyHz2VVAhcnADvjgJ1
         3dWlgSOQuuEowWKRqOiEgADj7G3JhaBWWRbLKSFgAEhM9wkCh59qGTEdUvPdzfv+MRny
         qp4SpaYsF65aLhVUqh71XMs/ZwxVroLORLgx+Tqf9bUsjEN/EqQeBGX4+AV2rapB9Eeh
         ZhurkeWUFDVfeIjWaOffOfSTgzQxMDn2Yp9HkQUhEJSTnZebdPq/B0awzl84g5rQqbJm
         /NTaKggpoUbfcuQlqGbFHksRmRXXH9GALUrg9Qr0Utldj1TO7fkz0/yQcrxhdxLhaFwy
         6xcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662672; x=1759267472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+26hvu8We2RH0lhumRvV1NkaTXlFMtaSHPfkqJZ1j9c=;
        b=GMI227T0/SDFECJY+AMXItBHRzTMOdrxgNDGMveesYnCI6G5N8xp8yx981QMbMR+6e
         Vwy8Cq0/I0OF15g3aT8Go1ZesY5v/PNA7vXFTdfslPEAmmfE30Kbp5g+DMA9QVdQjA2k
         mmhtu2ydiwvVJf1k3M6kySStkFdn5v6gfN+a6oTaNPU/aXD7HWvMkL9HT5eL496XsRui
         Og2tXJ1kRg2laZlUnXjPdrNZqp9ha5jmhL3VKfZ/B3hohTUrUT1KHY42cLIVnlHVVqxM
         hNctJiaLAn1hXOe5WA8DEnLmOOEbwKsRgFqzrM0d6svJJGDjUuhoBYTSge33/KBLoJDA
         ThAA==
X-Forwarded-Encrypted: i=1; AJvYcCWhnbs9iltwQLMRoFzpgrYy3wLzqT+Fp1e9XxU8BkOop4pDQMUwVAtEClI1Yj9guq146WJoncL8/ydRqbi9@vger.kernel.org
X-Gm-Message-State: AOJu0YyADExkTx6VzrPGZM3U9Ru8B/6QLSpR9y8/gsOMFA0OXjQQyIXX
	OZw/vXoUGrp8LIEjUZ5MPbp0gNe8EqoQlvwPkBSeU+6FWPqClZ8BkTxJ+lKhGk4U5rg9mPh2yb6
	2zVYjAu/QJrNFUX27SUxxKMe1I4c95eQ=
X-Gm-Gg: ASbGncvZxDiv8zc/pMk7CLzkewnj7LGqVbBBXvjnXLeprv18tvPaSXs/q6bbnP18qe9
	xOy924gteU59z0F3IwJ31QEaqj/v7he+HUp3aUMktOiFP0Od0TlKS7Y4FTfVmNQYhK0pR5qn4z6
	aPa5NnsP6GnhlWOsKtgJHWMBR8eAATRlO2n8LFqHRARORjWLySU+VkIwnoFqKH7m5rKfrDjTOri
	YgzdJ2TDlyaxOrUvFv6VfCqeHN8ffvqUUo70+tk/RCVT2kfPMs=
X-Google-Smtp-Source: AGHT+IGMJngRusN//KdbrvlRHCzkZoxjho7j0S+JygJem/75uKqbl3Gdv85MOWqE/JXhjWxyHmDLHyCvuIoakgrmRJI=
X-Received: by 2002:ac8:5cce:0:b0:4d2:db77:a652 with SMTP id
 d75a77b69052e-4d367081824mr53678251cf.8.1758662672119; Tue, 23 Sep 2025
 14:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
 <175798151288.382724.14189484118371001092.stgit@frogsfrogsfrogs>
 <CAJnrk1YtGcWj_0MOxS6atL_vrUjk09MzQhFt40yf32Rq12k0qw@mail.gmail.com> <20250923203246.GG1587915@frogsfrogsfrogs>
In-Reply-To: <20250923203246.GG1587915@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 23 Sep 2025 14:24:21 -0700
X-Gm-Features: AS18NWCOe8f2VczfsY7-nbsft2Ax_si7WnTGz2Dl49ThMKBuNYfXtr8jJCgDTXg
Message-ID: <CAJnrk1aFEASvZmKftGpvR-P-KWMDLFYzjBCj4OF=EwteWmpECw@mail.gmail.com>
Subject: Re: [PATCH 01/28] fuse: implement the basic iomap mechanisms
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, linux-xfs@vger.kernel.org, 
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 1:32=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Sep 19, 2025 at 03:36:52PM -0700, Joanne Koong wrote:
> > On Mon, Sep 15, 2025 at 5:28=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Implement functions to enable upcalling of iomap_begin and iomap_end =
to
> > > userspace fuse servers.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  fs/fuse/fuse_i.h          |   35 ++++
> > >  fs/fuse/iomap_priv.h      |   36 ++++
> > >  include/uapi/linux/fuse.h |   90 +++++++++
> > >  fs/fuse/Kconfig           |   32 +++
> > >  fs/fuse/Makefile          |    1
> > >  fs/fuse/file_iomap.c      |  434 +++++++++++++++++++++++++++++++++++=
++++++++++
> > >  fs/fuse/inode.c           |    9 +
> > >  7 files changed, 636 insertions(+), 1 deletion(-)
> > >  create mode 100644 fs/fuse/iomap_priv.h
> > >  create mode 100644 fs/fuse/file_iomap.c
> > >
> > > new file mode 100644
> > > index 00000000000000..243d92cb625095
> > > --- /dev/null
> > > +++ b/fs/fuse/iomap_priv.h
> > > @@ -0,0 +1,36 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2025 Oracle.  All Rights Reserved.
> > > + * Author: Darrick J. Wong <djwong@kernel.org>
> > > + */
> > > +#ifndef _FS_FUSE_IOMAP_PRIV_H
> > > +#define _FS_FUSE_IOMAP_PRIV_H
> > > +
> > ...
> > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > index 31b80f93211b81..3634cbe602cd9c 100644
> > > --- a/include/uapi/linux/fuse.h
> > > +++ b/include/uapi/linux/fuse.h
> > > @@ -235,6 +235,9 @@
> > >   *
> > >   *  7.44
> > >   *  - add FUSE_NOTIFY_INC_EPOCH
> > > + *
> > > + *  7.99
> >
> > Just curious, where did you get the .99 from?
>
> Any time I go adding to a versioned ABI, I try to use high numbers (and
> high bits for flags) so that it's really obvious that the new flags are
> in use when I poke through crash/gdb/etc.
>
> For permanent artifacts like an ondisk format, it's convenient to cache
> fs images for fuzz testing, etc.  Using a high bit/number reduces the
> chance that someone else's new feature will get merged and cause
> conflicts, which force me to regenerate all cached images.
>
> Obviously at merge time I change these values to use lower bit positions
> or version numbers to fit the merge target so it doesn't completely
> eliminate the caching problems.

Ahh okay I see, thanks for the explanation!

>
> > > + *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file op=
erations
> > >   */
> > >
> > >  #ifndef _LINUX_FUSE_H
> > > @@ -270,7 +273,7 @@
> > >  #define FUSE_KERNEL_VERSION 7
> > > diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> > > index 9563fa5387a241..67dfe300bf2e07 100644
> > > --- a/fs/fuse/Kconfig
> > > +++ b/fs/fuse/Kconfig
> > > @@ -69,6 +69,38 @@ config FUSE_PASSTHROUGH
> > > +config FUSE_IOMAP_DEBUG
> > > +       bool "Debug FUSE file IO over iomap"
> > > +       default n
> > > +       depends on FUSE_IOMAP
> > > +       help
> > > +         Enable debugging assertions for the fuse iomap code paths a=
nd logging
> > > +         of bad iomap file mapping data being sent to the kernel.
> > > +
> >
> > I wonder if we should have a general FUSE_DEBUG that this would fall
> > under instead of creating one that's iomap_debug specific
>
> Probably, but I was also trying to keep this as localized to iomap as
> possible.  If Miklos would rather I extend it to all of fuse (which is
> probably a good idea!) then I'm happy to do so.
>
> > >  config FUSE_IO_URING
> > >         bool "FUSE communication over io-uring"
> > >         default y
> > > diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> > > index 46041228e5be2c..27be39317701d6 100644
> > > --- a/fs/fuse/Makefile
> > > +++ b/fs/fuse/Makefile
> > > @@ -18,5 +18,6 @@ fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o
> > >  fuse-$(CONFIG_FUSE_BACKING) +=3D backing.o
> > >  fuse-$(CONFIG_SYSCTL) +=3D sysctl.o
> > >  fuse-$(CONFIG_FUSE_IO_URING) +=3D dev_uring.o
> > > +fuse-$(CONFIG_FUSE_IOMAP) +=3D file_iomap.o
> > >
> > >  virtiofs-y :=3D virtio_fs.o
> > > diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> > > new file mode 100644
> > > index 00000000000000..dda757768d3ea6
> > > --- /dev/null
> > > +++ b/fs/fuse/file_iomap.c
> > > @@ -0,0 +1,434 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2025 Oracle.  All Rights Reserved.
> > > + * Author: Darrick J. Wong <djwong@kernel.org>
> > > + */
> > > +#include <linux/iomap.h>
> > > +#include "fuse_i.h"
> > > +#include "fuse_trace.h"
> > > +#include "iomap_priv.h"
> > > +
> > > +/* Validate FUSE_IOMAP_TYPE_* */
> > > +static inline bool fuse_iomap_check_type(uint16_t fuse_type)
> > > +{
> > > +       switch (fuse_type) {
> > > +       case FUSE_IOMAP_TYPE_HOLE:
> > > +       case FUSE_IOMAP_TYPE_DELALLOC:
> > > +       case FUSE_IOMAP_TYPE_MAPPED:
> > > +       case FUSE_IOMAP_TYPE_UNWRITTEN:
> > > +       case FUSE_IOMAP_TYPE_INLINE:
> > > +       case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
> > > +               return true;
> > > +       }
> > > +
> > > +       return false;
> > > +}
> >
> > Maybe faster to check by using a bitmask instead?
>
> They're consecutive; one could #define a FUSE_IOMAP_TYPE_MAX to alias
> PURE_OVERWRITE and collapse the whole check to:
>
>         return fuse_type <=3D FUSE_IOMAP_TYPE_MAX;
>
> > > +
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index 1e7298b2b89b58..32f4b7c9a20a8a 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -1448,6 +1448,13 @@ static void process_init_reply(struct fuse_mou=
nt *fm, struct fuse_args *args,
> > >
> > >                         if (flags & FUSE_REQUEST_TIMEOUT)
> > >                                 timeout =3D arg->request_timeout;
> > > +
> > > +                       if ((flags & FUSE_IOMAP) && fuse_iomap_enable=
d()) {
> > > +                               fc->local_fs =3D 1;
> > > +                               fc->iomap =3D 1;
> > > +                               printk(KERN_WARNING
> > > + "fuse: EXPERIMENTAL iomap feature enabled.  Use at your own risk!")=
;
> > > +                       }
> >
> > pr_warn() seems to be the convention elsewhere in the fuse code
>
> Ah, thanks.  Do you know why fuse calls pr_warn("fuse: XXX") instead of
> the usual sequence of
>
> #define pr_fmt(fmt) "fuse: " fmt
>
> so that "fuse: " gets included automatically?

I think it does do this, or at least that's what I see in fuse_i.h :D

Thanks,
Joanne
>
> --D
>
> >
> > Thanks,
> > Joanne
> > >                 } else {
> > >                         ra_pages =3D fc->max_read / PAGE_SIZE;
> > >                         fc->no_lock =3D 1;
> > > @@ -1516,6 +1523,8 @@ static struct fuse_init_args *fuse_new_init(str=
uct fuse_mount *fm)
> > >          */
> > >         if (fuse_uring_enabled())
> > >                 flags |=3D FUSE_OVER_IO_URING;
> > > +       if (fuse_iomap_enabled())
> > > +               flags |=3D FUSE_IOMAP;
> > >
> > >         ia->in.flags =3D flags;
> > >         ia->in.flags2 =3D flags >> 32;
> > >
> >

