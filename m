Return-Path: <linux-fsdevel+bounces-53912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA29AF8DAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 11:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF795A6A83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 09:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F692ECE8F;
	Fri,  4 Jul 2025 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="As44Nb2v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D412EACEC;
	Fri,  4 Jul 2025 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619683; cv=none; b=ZbO/pt4vJP3jT41VSDblKWgxDCl+R3pMrYYCRkns80tuXJ7T/ueNHjJr3DOOTelQcd4IEYyvFuLkfvq54svScnPFIMv8GTiGIRXwmQpPfC7xRZ7S/z7NJW2YIf5WSqZx1+yJASoN9a6xwKqIREhajfmFHsr2nxEOmMTiSHo/Dyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619683; c=relaxed/simple;
	bh=zlipdF4MElw5DqSV73qCW0LpU5ljvro6CG+7WgIeFK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pF6vFuCIXjc4cK3OZDtL0dc6VvVMxhuyoRTxWIO1yEn37YXbSIRPlVC4/A46J6c9xrIW+z3Ihl6wc1pIdJ/dVSAvwZbWTgAi0j6k6tkwHXJ4lZaAN2kNYT+c33DoPx0hXlnR0X4vOh4TLsZBwOJpTVBB9s6hPZW9RX4jk6DwWjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=As44Nb2v; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae361e8ec32so157071366b.3;
        Fri, 04 Jul 2025 02:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751619678; x=1752224478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MemEh6ylw1bIQUnXZ+22onk9+pJncd+A+4Mgnk6+jY=;
        b=As44Nb2v1i3+FxVQGnLXn4I/vnPSHgk2EasW59J3KetxRKdbAT3iQG/osrfpxdWo8t
         FqBQdLk1dB0tihiiLgEoDBKww/BMn53Kd108L/yn/qItNskrlWicPvh2K5AyptfLyZEZ
         gyMSp9w+IIt425VL17YHVJ8/M97z5iM68V3J3+K/HZU+kxkZZWxxxoU4nMtuBgH558G8
         ms8M3K+SRecWcPgqgT7Cbkfcw37/GbtC+vOwRnSj6kYDNnA9M42AZWKceBdBq6ALhh6r
         58g7xJ9h3jmMATIJhvjpLL2AY89GNwhubIqQtUXTUXIhzBBV5gfZGI8juNQMixQNAYdd
         P3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751619678; x=1752224478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MemEh6ylw1bIQUnXZ+22onk9+pJncd+A+4Mgnk6+jY=;
        b=t8SL302Tf4EQS3RLtXw5siVIloXeFp2V4rZCwSh3fzOhXJcOiIWNFpJEF9ROgTfVsq
         P7nIJkvPmqwl5f5gZng1IFir1rmBVxLAlc6ZRGdJBO71u3jnZSH8cf/XlvuqErnx7row
         /mkJrWZAnCEyTV3Fbwnqn/AA1wCjpRFpRxAaxlwyEHgvF7pgdI0uHmyIm75vBYe3k6IV
         2mi59CMvlqlBBoDGoEc20C/ort+j7zNriX+VxC0crs+PT/oRC8AfggbLzIdW0VCDPFKt
         xZa952jg7QeWwiMLA0WvBghAYUZCUH/kd6rCXi9Td3PzihcQz+MnTz1nS8VzGCvFw4MO
         PLLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGn14ktkW1LpWeTiRITMdvXPhLP5nDEYS3Ht8ydJ61cChelqjagxr/4ZKyXSp7zJkuXsTMxhIwgXTekYrB@vger.kernel.org, AJvYcCWZeEkb3ayNWx9INi/PGpeOrjKL0UxWJiZQg2EOPpm0vW7VbUlx3NLk6rCGB+PY70iM6aUZf26jJjo=@vger.kernel.org, AJvYcCWvm3iEPEJb1aklKtojxnBaQq8LxEKmrfgYlphGgW0vuO3sBrmdWCKhNtCb8cyW2OlNh4xvT8uQlqhQ@vger.kernel.org, AJvYcCXtuUDxwFDPTpXSK2P8ZrKaKpBXxN1Q83erVHYq/qKRZlBTA2z7B6NymDI6EBnZsWiow6mp/Ll4UvJ+nwN2TA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvraxLfk2GRILtLdYv2sSD7SUfEKvCRV2ObefznrXo26Kkd1OT
	l5FHQ8hIDAtHfTcbGCxyXJmiQ4/NECpGAacnA9/oIdijsi/aI3ytRvZ3QhAexjr5a9zecWgrOlE
	Ws1wHPlOycPz1UR+xxspelFx+R+edHiw=
X-Gm-Gg: ASbGnctTVeH3aAKqZx/VnPAXtY/xGdFC6kQAW9eyB3wwIDx86lrl+GPyeUvfEx06rff
	/ou9JMTAuEvDgNU0/tsvVMSjM0qoLi6lD3iUlJqkrXkAhY6tPcZhJdzfOmtohkNy0c6acz18OKV
	s55IVGSZ2r//CWf2sNLPRgekP1whLdshyrSGnZPdLcvSArEm5SMXQhNg==
X-Google-Smtp-Source: AGHT+IEP+UBgCG0atCZ99F1YIy29nMs677WSnCaZy1ajvNR9Fd6059ae+qX6ZsMDabBFuAnGffBIdDZYs/phbFWKNAI=
X-Received: by 2002:a17:906:c104:b0:ade:9b52:4cc0 with SMTP id
 a640c23a62f3a-ae3fbc9eac9mr169976266b.26.1751619677073; Fri, 04 Jul 2025
 02:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-14-john@groves.net>
In-Reply-To: <20250703185032.46568-14-john@groves.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 Jul 2025 11:01:03 +0200
X-Gm-Features: Ac12FXxgaYxa7QSOeQt0_YUeAoy_UbiijMBiEgftqQGpA7Nsh21DsTPu2i9cNQo
Message-ID: <CAOQ4uxgFoEByjaJPQv_QGMzGHLx=1hZvQcYjxM_ZZi_D063HEg@mail.gmail.com>
Subject: Re: [RFC V2 13/18] famfs_fuse: Create files with famfs fmaps
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 8:51=E2=80=AFPM John Groves <John@groves.net> wrote:
>
> On completion of GET_FMAP message/response, setup the full famfs
> metadata such that it's possible to handle read/write/mmap directly to
> dax. Note that the devdax_iomap plumbing is not in yet...
>
> Update MAINTAINERS for the new files.
>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  MAINTAINERS               |   9 +
>  fs/fuse/Makefile          |   2 +-
>  fs/fuse/famfs.c           | 360 ++++++++++++++++++++++++++++++++++++++
>  fs/fuse/famfs_kfmap.h     |  63 +++++++
>  fs/fuse/file.c            |  15 +-
>  fs/fuse/fuse_i.h          |  16 +-
>  fs/fuse/inode.c           |   2 +-
>  include/uapi/linux/fuse.h |  56 ++++++
>  8 files changed, 518 insertions(+), 5 deletions(-)
>  create mode 100644 fs/fuse/famfs.c
>  create mode 100644 fs/fuse/famfs_kfmap.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c0d5232a473b..02688f27a4d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8808,6 +8808,15 @@ F:       Documentation/networking/failover.rst
>  F:     include/net/failover.h
>  F:     net/core/failover.c
>
> +FAMFS
> +M:     John Groves <jgroves@micron.com>
> +M:     John Groves <John@Groves.net>
> +L:     linux-cxl@vger.kernel.org
> +L:     linux-fsdevel@vger.kernel.org
> +S:     Supported
> +F:     fs/fuse/famfs.c
> +F:     fs/fuse/famfs_kfmap.h
> +

I suggest to follow the pattern of MAINTAINERS sub entries
FILESYSTEMS [EXPORTFS]
FILESYSTEMS [IOMAP]

and call this sub entry
FUSE [FAMFS]

to order it following FUSE entry

Thanks,
Amir.

>  FANOTIFY
>  M:     Jan Kara <jack@suse.cz>
>  R:     Amir Goldstein <amir73il@gmail.com>
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index 3f0f312a31c1..65a12975d734 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -16,5 +16,5 @@ fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
>  fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o
>  fuse-$(CONFIG_SYSCTL) +=3D sysctl.o
>  fuse-$(CONFIG_FUSE_IO_URING) +=3D dev_uring.o
> -
> +fuse-$(CONFIG_FUSE_FAMFS_DAX) +=3D famfs.o
>  virtiofs-y :=3D virtio_fs.o
> diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> new file mode 100644
> index 000000000000..41c4d92f1451
> --- /dev/null
> +++ b/fs/fuse/famfs.c
> @@ -0,0 +1,360 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * famfs - dax file system for shared fabric-attached memory
> + *
> + * Copyright 2023-2025 Micron Technology, Inc.
> + *
> + * This file system, originally based on ramfs the dax support from xfs,
> + * is intended to allow multiple host systems to mount a common file sys=
tem
> + * view of dax files that map to shared memory.
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/dax.h>
> +#include <linux/iomap.h>
> +#include <linux/path.h>
> +#include <linux/namei.h>
> +#include <linux/string.h>
> +
> +#include "famfs_kfmap.h"
> +#include "fuse_i.h"
> +
> +
> +void
> +__famfs_meta_free(void *famfs_meta)
> +{
> +       struct famfs_file_meta *fmap =3D famfs_meta;
> +
> +       if (!fmap)
> +               return;
> +
> +       if (fmap) {
> +               switch (fmap->fm_extent_type) {
> +               case SIMPLE_DAX_EXTENT:
> +                       kfree(fmap->se);
> +                       break;
> +               case INTERLEAVED_EXTENT:
> +                       if (fmap->ie)
> +                               kfree(fmap->ie->ie_strips);
> +
> +                       kfree(fmap->ie);
> +                       break;
> +               default:
> +                       pr_err("%s: invalid fmap type\n", __func__);
> +                       break;
> +               }
> +       }
> +       kfree(fmap);
> +}
> +
> +static int
> +famfs_check_ext_alignment(struct famfs_meta_simple_ext *se)
> +{
> +       int errs =3D 0;
> +
> +       if (se->dev_index !=3D 0)
> +               errs++;
> +
> +       /* TODO: pass in alignment so we can support the other page sizes=
 */
> +       if (!IS_ALIGNED(se->ext_offset, PMD_SIZE))
> +               errs++;
> +
> +       if (!IS_ALIGNED(se->ext_len, PMD_SIZE))
> +               errs++;
> +
> +       return errs;
> +}
> +
> +/**
> + * famfs_fuse_meta_alloc() - Allocate famfs file metadata
> + * @metap:       Pointer to an mcache_map_meta pointer
> + * @ext_count:  The number of extents needed
> + *
> + * Returns: 0=3Dsuccess
> + *          -errno=3Dfailure
> + */
> +static int
> +famfs_fuse_meta_alloc(
> +       void *fmap_buf,
> +       size_t fmap_buf_size,
> +       struct famfs_file_meta **metap)
> +{
> +       struct famfs_file_meta *meta =3D NULL;
> +       struct fuse_famfs_fmap_header *fmh;
> +       size_t extent_total =3D 0;
> +       size_t next_offset =3D 0;
> +       int errs =3D 0;
> +       int i, j;
> +       int rc;
> +
> +       fmh =3D (struct fuse_famfs_fmap_header *)fmap_buf;
> +
> +       /* Move past fmh in fmap_buf */
> +       next_offset +=3D sizeof(*fmh);
> +       if (next_offset > fmap_buf_size) {
> +               pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
> +                      __func__, __LINE__, next_offset, fmap_buf_size);
> +               return -EINVAL;
> +       }
> +
> +       if (fmh->nextents < 1) {
> +               pr_err("%s: nextents %d < 1\n", __func__, fmh->nextents);
> +               return -EINVAL;
> +       }
> +
> +       if (fmh->nextents > FUSE_FAMFS_MAX_EXTENTS) {
> +               pr_err("%s: nextents %d > max (%d) 1\n",
> +                      __func__, fmh->nextents, FUSE_FAMFS_MAX_EXTENTS);
> +               return -E2BIG;
> +       }
> +
> +       meta =3D kzalloc(sizeof(*meta), GFP_KERNEL);
> +       if (!meta)
> +               return -ENOMEM;
> +
> +       meta->error =3D false;
> +       meta->file_type =3D fmh->file_type;
> +       meta->file_size =3D fmh->file_size;
> +       meta->fm_extent_type =3D fmh->ext_type;
> +
> +       switch (fmh->ext_type) {
> +       case FUSE_FAMFS_EXT_SIMPLE: {
> +               struct fuse_famfs_simple_ext *se_in;
> +
> +               se_in =3D (struct fuse_famfs_simple_ext *)(fmap_buf + nex=
t_offset);
> +
> +               /* Move past simple extents */
> +               next_offset +=3D fmh->nextents * sizeof(*se_in);
> +               if (next_offset > fmap_buf_size) {
> +                       pr_err("%s:%d: fmap_buf underflow offset/size %ld=
/%ld\n",
> +                              __func__, __LINE__, next_offset, fmap_buf_=
size);
> +                       rc =3D -EINVAL;
> +                       goto errout;
> +               }
> +
> +               meta->fm_nextents =3D fmh->nextents;
> +
> +               meta->se =3D kcalloc(meta->fm_nextents, sizeof(*(meta->se=
)),
> +                                  GFP_KERNEL);
> +               if (!meta->se) {
> +                       rc =3D -ENOMEM;
> +                       goto errout;
> +               }
> +
> +               if ((meta->fm_nextents > FUSE_FAMFS_MAX_EXTENTS) ||
> +                   (meta->fm_nextents < 1)) {
> +                       rc =3D -EINVAL;
> +                       goto errout;
> +               }
> +
> +               for (i =3D 0; i < fmh->nextents; i++) {
> +                       meta->se[i].dev_index  =3D se_in[i].se_devindex;
> +                       meta->se[i].ext_offset =3D se_in[i].se_offset;
> +                       meta->se[i].ext_len    =3D se_in[i].se_len;
> +
> +                       /* Record bitmap of referenced daxdev indices */
> +                       meta->dev_bitmap |=3D (1 << meta->se[i].dev_index=
);
> +
> +                       errs +=3D famfs_check_ext_alignment(&meta->se[i])=
;
> +
> +                       extent_total +=3D meta->se[i].ext_len;
> +               }
> +               break;
> +       }
> +
> +       case FUSE_FAMFS_EXT_INTERLEAVE: {
> +               s64 size_remainder =3D meta->file_size;
> +               struct fuse_famfs_iext *ie_in;
> +               int niext =3D fmh->nextents;
> +
> +               meta->fm_niext =3D niext;
> +
> +               /* Allocate interleaved extent */
> +               meta->ie =3D kcalloc(niext, sizeof(*(meta->ie)), GFP_KERN=
EL);
> +               if (!meta->ie) {
> +                       rc =3D -ENOMEM;
> +                       goto errout;
> +               }
> +
> +               /*
> +                * Each interleaved extent has a simple extent list of st=
rips.
> +                * Outer loop is over separate interleaved extents
> +                */
> +               for (i =3D 0; i < niext; i++) {
> +                       u64 nstrips;
> +                       struct fuse_famfs_simple_ext *sie_in;
> +
> +                       /* ie_in =3D one interleaved extent in fmap_buf *=
/
> +                       ie_in =3D (struct fuse_famfs_iext *)
> +                               (fmap_buf + next_offset);
> +
> +                       /* Move past one interleaved extent header in fma=
p_buf */
> +                       next_offset +=3D sizeof(*ie_in);
> +                       if (next_offset > fmap_buf_size) {
> +                               pr_err("%s:%d: fmap_buf underflow offset/=
size %ld/%ld\n",
> +                                      __func__, __LINE__, next_offset,
> +                                      fmap_buf_size);
> +                               rc =3D -EINVAL;
> +                               goto errout;
> +                       }
> +
> +                       nstrips =3D ie_in->ie_nstrips;
> +                       meta->ie[i].fie_chunk_size =3D ie_in->ie_chunk_si=
ze;
> +                       meta->ie[i].fie_nstrips    =3D ie_in->ie_nstrips;
> +                       meta->ie[i].fie_nbytes     =3D ie_in->ie_nbytes;
> +
> +                       if (!meta->ie[i].fie_nbytes) {
> +                               pr_err("%s: zero-length interleave!\n",
> +                                      __func__);
> +                               rc =3D -EINVAL;
> +                               goto errout;
> +                       }
> +
> +                       /* sie_in =3D the strip extents in fmap_buf */
> +                       sie_in =3D (struct fuse_famfs_simple_ext *)
> +                               (fmap_buf + next_offset);
> +
> +                       /* Move past strip extents in fmap_buf */
> +                       next_offset +=3D nstrips * sizeof(*sie_in);
> +                       if (next_offset > fmap_buf_size) {
> +                               pr_err("%s:%d: fmap_buf underflow offset/=
size %ld/%ld\n",
> +                                      __func__, __LINE__, next_offset,
> +                                      fmap_buf_size);
> +                               rc =3D -EINVAL;
> +                               goto errout;
> +                       }
> +
> +                       if ((nstrips > FUSE_FAMFS_MAX_STRIPS) || (nstrips=
 < 1)) {
> +                               pr_err("%s: invalid nstrips=3D%lld (max=
=3D%d)\n",
> +                                      __func__, nstrips,
> +                                      FUSE_FAMFS_MAX_STRIPS);
> +                               errs++;
> +                       }
> +
> +                       /* Allocate strip extent array */
> +                       meta->ie[i].ie_strips =3D kcalloc(ie_in->ie_nstri=
ps,
> +                                       sizeof(meta->ie[i].ie_strips[0]),
> +                                                       GFP_KERNEL);
> +                       if (!meta->ie[i].ie_strips) {
> +                               rc =3D -ENOMEM;
> +                               goto errout;
> +                       }
> +
> +                       /* Inner loop is over strips */
> +                       for (j =3D 0; j < nstrips; j++) {
> +                               struct famfs_meta_simple_ext *strips_out;
> +                               u64 devindex =3D sie_in[j].se_devindex;
> +                               u64 offset   =3D sie_in[j].se_offset;
> +                               u64 len      =3D sie_in[j].se_len;
> +
> +                               strips_out =3D meta->ie[i].ie_strips;
> +                               strips_out[j].dev_index  =3D devindex;
> +                               strips_out[j].ext_offset =3D offset;
> +                               strips_out[j].ext_len    =3D len;
> +
> +                               /* Record bitmap of referenced daxdev ind=
ices */
> +                               meta->dev_bitmap |=3D (1 << devindex);
> +
> +                               extent_total +=3D len;
> +                               errs +=3D famfs_check_ext_alignment(&stri=
ps_out[j]);
> +                               size_remainder -=3D len;
> +                       }
> +               }
> +
> +               if (size_remainder > 0) {
> +                       /* Sum of interleaved extent sizes is less than f=
ile size! */
> +                       pr_err("%s: size_remainder %lld (0x%llx)\n",
> +                              __func__, size_remainder, size_remainder);
> +                       rc =3D -EINVAL;
> +                       goto errout;
> +               }
> +               break;
> +       }
> +
> +       default:
> +               pr_err("%s: invalid ext_type %d\n", __func__, fmh->ext_ty=
pe);
> +               rc =3D -EINVAL;
> +               goto errout;
> +       }
> +
> +       if (errs > 0) {
> +               pr_err("%s: %d alignment errors found\n", __func__, errs)=
;
> +               rc =3D -EINVAL;
> +               goto errout;
> +       }
> +
> +       /* More sanity checks */
> +       if (extent_total < meta->file_size) {
> +               pr_err("%s: file size %ld larger than map size %ld\n",
> +                      __func__, meta->file_size, extent_total);
> +               rc =3D -EINVAL;
> +               goto errout;
> +       }
> +
> +       *metap =3D meta;
> +
> +       return 0;
> +errout:
> +       __famfs_meta_free(meta);
> +       return rc;
> +}
> +
> +/**
> + * famfs_file_init_dax() - init famfs dax file metadata
> + *
> + * @fm:        fuse_mount
> + * @inode:     the inode
> + * @fmap_buf:  fmap response message
> + * @fmap_size: Size of the fmap message
> + *
> + * Initialize famfs metadata for a file, based on the contents of the GE=
T_FMAP
> + * response
> + *
> + * Return: 0=3Dsuccess
> + *          -errno=3Dfailure
> + */
> +int
> +famfs_file_init_dax(
> +       struct fuse_mount *fm,
> +       struct inode *inode,
> +       void *fmap_buf,
> +       size_t fmap_size)
> +{
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       struct famfs_file_meta *meta =3D NULL;
> +       int rc;
> +
> +       if (fi->famfs_meta) {
> +               pr_notice("%s: i_no=3D%ld fmap_size=3D%ld ALREADY INITIAL=
IZED\n",
> +                         __func__,
> +                         inode->i_ino, fmap_size);
> +               return -EEXIST;
> +       }
> +
> +       rc =3D famfs_fuse_meta_alloc(fmap_buf, fmap_size, &meta);
> +       if (rc)
> +               goto errout;
> +
> +       /* Publish the famfs metadata on fi->famfs_meta */
> +       inode_lock(inode);
> +       if (fi->famfs_meta) {
> +               rc =3D -EEXIST; /* file already has famfs metadata */
> +       } else {
> +               if (famfs_meta_set(fi, meta) !=3D NULL) {
> +                       pr_err("%s: file already had metadata\n", __func_=
_);
> +                       rc =3D -EALREADY;
> +                       goto errout;
> +               }
> +               i_size_write(inode, meta->file_size);
> +               inode->i_flags |=3D S_DAX;
> +       }
> +       inode_unlock(inode);
> +
> + errout:
> +       if (rc)
> +               __famfs_meta_free(meta);
> +
> +       return rc;
> +}
> +
> diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
> new file mode 100644
> index 000000000000..ce785d76719c
> --- /dev/null
> +++ b/fs/fuse/famfs_kfmap.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * famfs - dax file system for shared fabric-attached memory
> + *
> + * Copyright 2023-2025 Micron Technology, Inc.
> + */
> +#ifndef FAMFS_KFMAP_H
> +#define FAMFS_KFMAP_H
> +
> +/*
> + * These structures are the in-memory metadata format for famfs files. M=
etadata
> + * retrieved via the GET_FMAP response is converted to this format for u=
se in
> + * resolving file mapping faults.
> + */
> +
> +enum famfs_file_type {
> +       FAMFS_REG,
> +       FAMFS_SUPERBLOCK,
> +       FAMFS_LOG,
> +};
> +
> +/* We anticipate the possiblity of supporting additional types of extent=
s */
> +enum famfs_extent_type {
> +       SIMPLE_DAX_EXTENT,
> +       INTERLEAVED_EXTENT,
> +       INVALID_EXTENT_TYPE,
> +};
> +
> +struct famfs_meta_simple_ext {
> +       u64 dev_index;
> +       u64 ext_offset;
> +       u64 ext_len;
> +};
> +
> +struct famfs_meta_interleaved_ext {
> +       u64 fie_nstrips;
> +       u64 fie_chunk_size;
> +       u64 fie_nbytes;
> +       struct famfs_meta_simple_ext *ie_strips;
> +};
> +
> +/*
> + * Each famfs dax file has this hanging from its fuse_inode->famfs_meta
> + */
> +struct famfs_file_meta {
> +       bool                   error;
> +       enum famfs_file_type   file_type;
> +       size_t                 file_size;
> +       enum famfs_extent_type fm_extent_type;
> +       u64 dev_bitmap; /* bitmap of referenced daxdevs by index */
> +       union { /* This will make code a bit more readable */
> +               struct {
> +                       size_t         fm_nextents;
> +                       struct famfs_meta_simple_ext  *se;
> +               };
> +               struct {
> +                       size_t         fm_niext;
> +                       struct famfs_meta_interleaved_ext *ie;
> +               };
> +       };
> +};
> +
> +#endif /* FAMFS_KFMAP_H */
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 8616fb0a6d61..5d205eadb48f 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -237,6 +237,7 @@ static void fuse_truncate_update_attr(struct inode *i=
node, struct file *file)
>  static int
>  fuse_get_fmap(struct fuse_mount *fm, struct inode *inode, u64 nodeid)
>  {
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
>         struct fuse_get_fmap_in inarg =3D { 0 };
>         size_t fmap_bufsize =3D FMAP_BUFSIZE;
>         ssize_t fmap_size;
> @@ -246,6 +247,10 @@ fuse_get_fmap(struct fuse_mount *fm, struct inode *i=
node, u64 nodeid)
>
>         FUSE_ARGS(args);
>
> +       /* Don't retrieve if we already have the famfs metadata */
> +       if (fi->famfs_meta)
> +               return 0;
> +
>         fmap_buf =3D kcalloc(1, FMAP_BUFSIZE, GFP_KERNEL);
>         if (!fmap_buf)
>                 return -EIO;
> @@ -285,6 +290,13 @@ fuse_get_fmap(struct fuse_mount *fm, struct inode *i=
node, u64 nodeid)
>                  */
>                 fmap_bufsize =3D *((uint32_t *)fmap_buf);
>
> +               if (fmap_bufsize < fmap_msg_min_size()
> +                   || fmap_bufsize > FAMFS_FMAP_MAX) {
> +                       pr_err("%s: fmap_size=3D%ld out of range\n",
> +                              __func__, fmap_bufsize);
> +                       return -EIO;
> +               }
> +
>                 --retries;
>                 kfree(fmap_buf);
>                 fmap_buf =3D kcalloc(1, fmap_bufsize, GFP_KERNEL);
> @@ -294,7 +306,8 @@ fuse_get_fmap(struct fuse_mount *fm, struct inode *in=
ode, u64 nodeid)
>                 goto retry_once;
>         }
>
> -       /* Will call famfs_file_init_dax() when that gets added */
> +       /* Convert fmap into in-memory format and hang from inode */
> +       famfs_file_init_dax(fm, inode, fmap_buf, fmap_size);
>
>         kfree(fmap_buf);
>         return 0;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index e01d6e5c6e93..fb6095655403 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1560,11 +1560,18 @@ extern void fuse_sysctl_unregister(void);
>  #endif /* CONFIG_SYSCTL */
>
>  /* famfs.c */
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +int famfs_file_init_dax(struct fuse_mount *fm,
> +                            struct inode *inode, void *fmap_buf,
> +                            size_t fmap_size);
> +void __famfs_meta_free(void *map);
> +#endif
> +
>  static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
>                                                        void *meta)
>  {
>  #if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> -       return xchg(&fi->famfs_meta, meta);
> +       return cmpxchg(&fi->famfs_meta, NULL, meta);
>  #else
>         return NULL;
>  #endif
> @@ -1572,7 +1579,12 @@ static inline struct fuse_backing *famfs_meta_set(=
struct fuse_inode *fi,
>
>  static inline void famfs_meta_free(struct fuse_inode *fi)
>  {
> -       /* Stub wil be connected in a subsequent commit */
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +       if (fi->famfs_meta !=3D NULL) {
> +               __famfs_meta_free(fi->famfs_meta);
> +               famfs_meta_set(fi, NULL);
> +       }
> +#endif
>  }
>
>  static inline int fuse_file_famfs(struct fuse_inode *fi)
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index b071d16f7d04..1682755abf30 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -118,7 +118,7 @@ static struct inode *fuse_alloc_inode(struct super_bl=
ock *sb)
>                 fuse_inode_backing_set(fi, NULL);
>
>         if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> -               famfs_meta_set(fi, NULL);
> +               fi->famfs_meta =3D NULL; /* XXX new inodes currently not =
zeroed; why not? */
>
>         return &fi->inode;
>
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index dff5aa62543e..ecaaa62910f0 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -231,6 +231,13 @@
>   *    - enum fuse_uring_cmd
>   *  7.43
>   *    - Add FUSE_DAX_FMAP capability - ability to handle in-kernel fsdax=
 maps
> + *    - Add the following structures for the GET_FMAP message reply comp=
onents:
> + *      - struct fuse_famfs_simple_ext
> + *      - struct fuse_famfs_iext
> + *      - struct fuse_famfs_fmap_header
> + *    - Add the following enumerated types
> + *      - enum fuse_famfs_file_type
> + *      - enum famfs_ext_type
>   */
>
>  #ifndef _LINUX_FUSE_H
> @@ -1300,6 +1307,55 @@ struct fuse_uring_cmd_req {
>
>  /* Famfs fmap message components */
>
> +#define FAMFS_FMAP_VERSION 1
> +
>  #define FAMFS_FMAP_MAX 32768 /* Largest supported fmap message */
> +#define FUSE_FAMFS_MAX_EXTENTS 32
> +#define FUSE_FAMFS_MAX_STRIPS 32
> +
> +enum fuse_famfs_file_type {
> +       FUSE_FAMFS_FILE_REG,
> +       FUSE_FAMFS_FILE_SUPERBLOCK,
> +       FUSE_FAMFS_FILE_LOG,
> +};
> +
> +enum famfs_ext_type {
> +       FUSE_FAMFS_EXT_SIMPLE =3D 0,
> +       FUSE_FAMFS_EXT_INTERLEAVE =3D 1,
> +};
> +
> +struct fuse_famfs_simple_ext {
> +       uint32_t se_devindex;
> +       uint32_t reserved;
> +       uint64_t se_offset;
> +       uint64_t se_len;
> +};
> +
> +struct fuse_famfs_iext { /* Interleaved extent */
> +       uint32_t ie_nstrips;
> +       uint32_t ie_chunk_size;
> +       uint64_t ie_nbytes; /* Total bytes for this interleaved_ext;
> +                            * sum of strips may be more
> +                            */
> +       uint64_t reserved;
> +};
> +
> +struct fuse_famfs_fmap_header {
> +       uint8_t file_type; /* enum famfs_file_type */
> +       uint8_t reserved;
> +       uint16_t fmap_version;
> +       uint32_t ext_type; /* enum famfs_log_ext_type */
> +       uint32_t nextents;
> +       uint32_t reserved0;
> +       uint64_t file_size;
> +       uint64_t reserved1;
> +};
> +
> +static inline int32_t fmap_msg_min_size(void)
> +{
> +       /* Smallest fmap message is a header plus one simple extent */
> +       return (sizeof(struct fuse_famfs_fmap_header)
> +               + sizeof(struct fuse_famfs_simple_ext));
> +}
>
>  #endif /* _LINUX_FUSE_H */
> --
> 2.49.0
>

