Return-Path: <linux-fsdevel+bounces-63829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B2BCEE28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 03:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC88D4E5829
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 01:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A960B136349;
	Sat, 11 Oct 2025 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7Vq8n/8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74358136351
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Oct 2025 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760147045; cv=none; b=OFKjNFmaMAP+duYf782eB4UbrK8TukuN+c1Hh1MiecmXFtmaeGfobtONF8zmnWohkakq5xq1W+iEqbor+nQVdoHMO8w3C2uOLZ/KOZc6mKuwXYNKYU94TKBfBrmdyJOwVyqe/EY0cjqbFwC1s8exTdwbyKYs77UU9ZxEOxOIjPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760147045; c=relaxed/simple;
	bh=T+IdLzRTTxOQ0Z7SCLa56SnM6nhwUwKs07m9AmkVVyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgDz2QjTCz2iumSkIxbclctTN09j22MUdXTNjmItSQfFa0OXTQmZkTEGxEFkFhVSCHVH4LXUokFcNCrWsSUtL8brpHWfj8EFBk722gpcEZyBZvm0QyQke1iy/gI3P+tSunll6qD3na7pRzvBJsfkeVDvDCtvMOAutcq7EBDbkrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7Vq8n/8; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-59a8c1eb90cso1324503137.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 18:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760147042; x=1760751842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZhc66zsxEtV1w8Yg5Xh9+RLE7pB3ih7eNk7XgCUWWk=;
        b=J7Vq8n/8XeoyYAq6UM7v4iusmsqiPV3dCbTwxuZw7EXzoIcuILlPXwCC+KlCQZ5uLA
         RrPq/PfJzICjcTOM7U15uj/kqrVbmGvV+ZZ0S8BAAaSCEblz4QFq+Mo8r1cf8HUwamwf
         Pdom9uwpmo5vTEYs/90loRY1KGL1f+WJFWHv8pk5GSAgW5CLPKc7LiI2XcIFC4W5dDER
         opbcR008ve17+P/H7s2h16+MZd3iKSf+QlEnK7eP+JVRMUNBV4wEKBjbv85SocJa1UVa
         t1whWnojqaNG0oUQ9cb2TlRJ0gBoVGnt8u+/JpD31c1K6jfgRxTz9vpBTEqFvAfOEyvc
         IQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760147042; x=1760751842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZhc66zsxEtV1w8Yg5Xh9+RLE7pB3ih7eNk7XgCUWWk=;
        b=rER34F0w1q6/oeqp/cHZtnYQZbNRmihEsa34IYSokC8HhlMTSA5ypkHKSOIP1LA8Eq
         rQfSbHfERq2MTfc+Eq+b2zcRCx79Q0fBx9TuZ8Az/AW95T3eM30GjwK+sXVstd0dTjQE
         4hDQj0TICCfAiS3QyNouKn5nNsbtpECMwcb+lvh3IQal4BdwIAVEGKZyePrGduUgkPi4
         RzNA/vFo5F7VIkFtlxiJJRCO8xzJTIrxh9zHgQTA/GyA8qBsCjVzJXLRsEG/A5TRLYJ4
         wnJsEWjA6J9Hn5pexeNQsqZWgsl83JAfofuM+KYrlEPRyL9NSK8jTpyBa+qR9+e5RpK0
         LQUg==
X-Forwarded-Encrypted: i=1; AJvYcCXyb2b3kkd+hfJT/xXmI3EikImVp2oRIOm7ipvrAholLVTvF+AYyrw+W8t8pJcpO3RgH0tItpsmej0igLE0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3HheMR7/J2/HpK3/466Xo4bDpLuLY8bAUPrG4tnxRKh4Sao1B
	gCg6Qv9HzlZz0ciYlgINRPUM2t5FTtrypHPvvsbsOWlCgBUxUb+vGUHXFH27SdWCk1+uXIk3bC/
	l4l0trFuCw21qV18cM8Zwid7erLSOOag=
X-Gm-Gg: ASbGnct5ZKXBl2cecbToz2969gzfiL1UusxoXuF1//hmFQcY/OmYMu45kz3X4+Yx/AF
	dackLlwKlRVMyipuQwmPzbtmW22pDKy52jP2bRLnoE3Qm3LbfXV3ayl+LbZyTUiJ72lk1s1R0LE
	mT3ZakixpwJCDlK+YcloXfmbn2MPy4j3S228EIzo4iJ5EJ4ldx/PbX4YC8xlUQ25A1ZQBFkPGAW
	6NbUdF7iHeun37fZ70AlSIeu7hLhI2C
X-Google-Smtp-Source: AGHT+IE7mG3LNkxY+CyodDwm/x4ptJOMQVJ+H4EmrH8p/RVIObpZc3vVfG1SaOV6rlrj3vGwgT1jiZxnhaAD3dJIuBQ=
X-Received: by 2002:a05:6102:6cf:b0:524:b344:748d with SMTP id
 ada2fe7eead31-5d5e23474fcmr5780092137.17.1760147041875; Fri, 10 Oct 2025
 18:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011013312.20698-1-changfengnan@bytedance.com> <CALWNXx-gGbAFCNywLZZUNmenTHQGFuapvNe-7irRGnRFJuNUcA@mail.gmail.com>
In-Reply-To: <CALWNXx-gGbAFCNywLZZUNmenTHQGFuapvNe-7irRGnRFJuNUcA@mail.gmail.com>
From: fengnan chang <fengnanchang@gmail.com>
Date: Sat, 11 Oct 2025 09:43:51 +0800
X-Gm-Features: AS18NWCBO3jy7FdLyGcQVogGXlatyQB1qaqtXtY1KzxOp2alt1gh71U3rIH7rWo
Message-ID: <CALWNXx_Lt1CLTaxh+xcd24_nTp-DOaOezUkQ=Vv_Snq3vx2MuA@mail.gmail.com>
Subject: Re: [PATCH] block: enable per-cpu bio cache by default
To: Fengnan Chang <changfengnan@bytedance.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	asml.silence@gmail.com, willy@infradead.org, djwong@kernel.org, 
	hch@infradead.org, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cc more maillist

On Sat, Oct 11, 2025 at 9:36=E2=80=AFAM fengnan chang <fengnanchang@gmail.c=
om> wrote:
>
> The attachment is result of fio test ext4/xfs with
> libaio/sync/io_uring on null_blk and
>  nvme.
>
> On Sat, Oct 11, 2025 at 9:33=E2=80=AFAM Fengnan Chang
> <changfengnan@bytedance.com> wrote:
> >
> > Per cpu bio cache was only used in the io_uring + raw block device,
> > after commit 12e4e8c7ab59 ("io_uring/rw: enable bio caches for IRQ
> > rw"),  bio_put is safe for task and irq context, bio_alloc_bioset is
> > safe for task context and no one calls in irq context, so we can enable
> > per cpu bio cache by default.
> >
> > Benchmarked with t/io_uring and ext4+nvme:
> > taskset -c 6 /root/fio/t/io_uring  -p0 -d128 -b4096 -s1 -c1 -F1 -B1 -R1
> > -X1 -n1 -P1  /mnt/testfile
> > base IOPS is 562K, patch IOPS is 574K. The CPU usage of bio_alloc_biose=
t
> > decrease from 1.42% to 1.22%.
> >
> > The worst case is allocate bio in CPU A but free in CPU B, still use
> > t/io_uring and ext4+nvme:
> > base IOPS is 648K, patch IOPS is 647K.
> >
> > Also use fio test ext4/xfs with libaio/sync/io_uring on null_blk and
> > nvme, no obvious performance regression.
> >
> > Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
> > ---
> >  block/bio.c        | 26 ++++++++++++--------------
> >  block/blk-map.c    |  4 ++++
> >  block/fops.c       |  4 ----
> >  include/linux/fs.h |  3 ---
> >  io_uring/rw.c      |  1 -
> >  5 files changed, 16 insertions(+), 22 deletions(-)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index 3b371a5da159..16b20c10cab7 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -513,20 +513,18 @@ struct bio *bio_alloc_bioset(struct block_device =
*bdev, unsigned short nr_vecs,
> >         if (WARN_ON_ONCE(!mempool_initialized(&bs->bvec_pool) && nr_vec=
s > 0))
> >                 return NULL;
> >
> > -       if (opf & REQ_ALLOC_CACHE) {
> > -               if (bs->cache && nr_vecs <=3D BIO_INLINE_VECS) {
> > -                       bio =3D bio_alloc_percpu_cache(bdev, nr_vecs, o=
pf,
> > -                                                    gfp_mask, bs);
> > -                       if (bio)
> > -                               return bio;
> > -                       /*
> > -                        * No cached bio available, bio returned below =
marked with
> > -                        * REQ_ALLOC_CACHE to particpate in per-cpu all=
oc cache.
> > -                        */
> > -               } else {
> > -                       opf &=3D ~REQ_ALLOC_CACHE;
> > -               }
> > -       }
> > +       opf |=3D REQ_ALLOC_CACHE;
> > +       if (bs->cache && nr_vecs <=3D BIO_INLINE_VECS) {
> > +               bio =3D bio_alloc_percpu_cache(bdev, nr_vecs, opf,
> > +                                            gfp_mask, bs);
> > +               if (bio)
> > +                       return bio;
> > +               /*
> > +                * No cached bio available, bio returned below marked w=
ith
> > +                * REQ_ALLOC_CACHE to participate in per-cpu alloc cach=
e.
> > +                */
> > +       } else
> > +               opf &=3D ~REQ_ALLOC_CACHE;
> >
> >         /*
> >          * submit_bio_noacct() converts recursion to iteration; this me=
ans if
> > diff --git a/block/blk-map.c b/block/blk-map.c
> > index 23e5d5ebe59e..570a7ca6edd1 100644
> > --- a/block/blk-map.c
> > +++ b/block/blk-map.c
> > @@ -255,6 +255,10 @@ static struct bio *blk_rq_map_bio_alloc(struct req=
uest *rq,
> >  {
> >         struct bio *bio;
> >
> > +       /*
> > +        * Even REQ_ALLOC_CACHE is enabled by default, we still need th=
is to
> > +        * mark bio is allocated by bio_alloc_bioset.
> > +        */
> >         if (rq->cmd_flags & REQ_ALLOC_CACHE && (nr_vecs <=3D BIO_INLINE=
_VECS)) {
> >                 bio =3D bio_alloc_bioset(NULL, nr_vecs, rq->cmd_flags, =
gfp_mask,
> >                                         &fs_bio_set);
> > diff --git a/block/fops.c b/block/fops.c
> > index ddbc69c0922b..090562a91b4c 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -177,8 +177,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *ioc=
b, struct iov_iter *iter,
> >         loff_t pos =3D iocb->ki_pos;
> >         int ret =3D 0;
> >
> > -       if (iocb->ki_flags & IOCB_ALLOC_CACHE)
> > -               opf |=3D REQ_ALLOC_CACHE;
> >         bio =3D bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
> >                                &blkdev_dio_pool);
> >         dio =3D container_of(bio, struct blkdev_dio, bio);
> > @@ -326,8 +324,6 @@ static ssize_t __blkdev_direct_IO_async(struct kioc=
b *iocb,
> >         loff_t pos =3D iocb->ki_pos;
> >         int ret =3D 0;
> >
> > -       if (iocb->ki_flags & IOCB_ALLOC_CACHE)
> > -               opf |=3D REQ_ALLOC_CACHE;
> >         bio =3D bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
> >                                &blkdev_dio_pool);
> >         dio =3D container_of(bio, struct blkdev_dio, bio);
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 601d036a6c78..18ec41732186 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -365,8 +365,6 @@ struct readahead_control;
> >  /* iocb->ki_waitq is valid */
> >  #define IOCB_WAITQ             (1 << 19)
> >  #define IOCB_NOIO              (1 << 20)
> > -/* can use bio alloc cache */
> > -#define IOCB_ALLOC_CACHE       (1 << 21)
> >  /*
> >   * IOCB_DIO_CALLER_COMP can be set by the iocb owner, to indicate that=
 the
> >   * iocb completion can be passed back to the owner for execution from =
a safe
> > @@ -399,7 +397,6 @@ struct readahead_control;
> >         { IOCB_WRITE,           "WRITE" }, \
> >         { IOCB_WAITQ,           "WAITQ" }, \
> >         { IOCB_NOIO,            "NOIO" }, \
> > -       { IOCB_ALLOC_CACHE,     "ALLOC_CACHE" }, \
> >         { IOCB_DIO_CALLER_COMP, "CALLER_COMP" }, \
> >         { IOCB_AIO_RW,          "AIO_RW" }, \
> >         { IOCB_HAS_METADATA,    "AIO_HAS_METADATA" }
> > diff --git a/io_uring/rw.c b/io_uring/rw.c
> > index af5a54b5db12..fa7655ab9097 100644
> > --- a/io_uring/rw.c
> > +++ b/io_uring/rw.c
> > @@ -856,7 +856,6 @@ static int io_rw_init_file(struct io_kiocb *req, fm=
ode_t mode, int rw_type)
> >         ret =3D kiocb_set_rw_flags(kiocb, rw->flags, rw_type);
> >         if (unlikely(ret))
> >                 return ret;
> > -       kiocb->ki_flags |=3D IOCB_ALLOC_CACHE;
> >
> >         /*
> >          * If the file is marked O_NONBLOCK, still allow retry for it i=
f it
> > --
> > 2.39.5 (Apple Git-154)
> >
> >

