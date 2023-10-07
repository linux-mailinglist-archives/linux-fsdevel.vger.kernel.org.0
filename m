Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BAE7BC3C4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 03:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjJGBaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 21:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbjJGBaC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:30:02 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D123F101
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 18:29:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3226cc3e324so2631168f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 18:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696642196; x=1697246996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8i3Pr+kV/3K4Cavu44Q80I1TfV4YtZdhsT1AtQ26BME=;
        b=meQGnth8xmyrZMuTL7a9ri3ZDu9D+l8VRx/Aeb9jLg/LFbYFNtTDI6fzJDVk0DEOdO
         zoGIL+nA4t/RUPV04D/N2VeNuPC3RIBUV0EAoYRTBSQfydCKueIz7qU/IQt18EHypwSw
         oPn2/ZjOri9svnE+QScz5XwkGjPksHJfbzUF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696642196; x=1697246996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8i3Pr+kV/3K4Cavu44Q80I1TfV4YtZdhsT1AtQ26BME=;
        b=H8twJ5uioYHyY+Eug0g4BE8fjIfGp+DwpAWcXZvAxiB7kseeqb+DRi7TWKzh2ljOkk
         wZx8CaCSBWWxdNcrVnLjv6Q47hcubTXLCHA1pXFA3TZbHkVoUVXPBFEq41H2NALjVy5x
         id02UM53RXTiHmz2b9v01stSlsg1/DF0K/77tP6CFX//mJaLelMlJcpHgkQ0wfpM04vZ
         K3OTJwQfcfVWaE3vfvIKbKJKzCE2vvEUVkOFOLmpJiYbb8g6VLKBlXznsUDzA8mLdi2e
         haab2ljm5ZYN8ICqNg5kOdC5uU75I7bWC9qM3kssgmfWQYKV33xqD5wJmk97AtJuEYFs
         MVRg==
X-Gm-Message-State: AOJu0YxlT6M7aSN2IGcs69pBmzkGY7bMs5r2MEeeMwsWwm8pCPckDPj1
        fjsonFuoQJOpDnyCdFoO/+KV7aKBPWIVve+nfILySQ==
X-Google-Smtp-Source: AGHT+IF/ysUV7jVL6dwSYt85AkIMqE5NM4Ri35rXFS7QFUCoFT7JJfmx59prKNWzHGsvR+73oX3WH70nQ7A2v3ZhAdk=
X-Received: by 2002:a5d:4f8a:0:b0:31f:84a3:d188 with SMTP id
 d10-20020a5d4f8a000000b0031f84a3d188mr7914844wru.22.1696642196066; Fri, 06
 Oct 2023 18:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230522163710.GA11607@frogsfrogsfrogs> <20230522221000.603769-1-sarthakkukreti@chromium.org>
 <20230523012252.GF11598@frogsfrogsfrogs>
In-Reply-To: <20230523012252.GF11598@frogsfrogsfrogs>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Fri, 6 Oct 2023 18:29:44 -0700
Message-ID: <CAG9=OMMSyU0i7EQ-ZVLg3=_89MnoBOKcB_C=0r3aywwpyZS9zA@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] loop: Add support for provision requests
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 6:22=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, May 22, 2023 at 03:09:55PM -0700, Sarthak Kukreti wrote:
> > On Mon, May 22, 2023 at 9:37=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > If someone calls fallocate(UNSHARE_RANGE) on a loop bdev, shouldn't
> > > there be a way to pass that through to the fallocate call to the back=
ing
> > > file?
> > >
> > > --D
> > >
> >
> > Yeah, I think we could add a REQ_UNSHARE bit (similar to REQ_NOUNMAP) t=
o pass down the intent to the backing file (and possibly beyond...).
> >
> > I took a stab at implementing it as a follow up patch so that there's
> > less review churn on the current series. If it looks good, I can add
> > it to the end of the series (or incorporate this into the existing
> > block and loop patches):
>
> It looks like a reasonable addition to the end of the series, assuming
> that filling holes in thinp devices is cheap but unsharing snapshot
> blocks is not.
>
> > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > Date: Mon, 22 May 2023 14:18:15 -0700
> > Subject: [PATCH] block: Pass unshare intent via REQ_OP_PROVISION
> >
> > Allow REQ_OP_PROVISION to pass in an extra REQ_UNSHARE bit to
> > annotate unshare requests to underlying layers. Layers that support
> > FALLOC_FL_UNSHARE will be able to use this as an indicator of which
> > fallocate() mode to use.
>
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  block/blk-lib.c           |  6 +++++-
> >  block/fops.c              |  6 +++++-
> >  drivers/block/loop.c      | 35 +++++++++++++++++++++++++++++------
> >  include/linux/blk_types.h |  3 +++
> >  include/linux/blkdev.h    |  3 ++-
> >  5 files changed, 44 insertions(+), 9 deletions(-)
> >
> > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > index 3cff5fb654f5..bea6f5a700b3 100644
> > --- a/block/blk-lib.c
> > +++ b/block/blk-lib.c
> > @@ -350,6 +350,7 @@ EXPORT_SYMBOL(blkdev_issue_secure_erase);
> >   * @sector:  start sector
> >   * @nr_sects:        number of sectors to provision
> >   * @gfp_mask:        memory allocation flags (for bio_alloc)
> > + * @flags:   controls detailed behavior
> >   *
> >   * Description:
> >   *  Issues a provision request to the block device for the range of se=
ctors.
> > @@ -357,7 +358,7 @@ EXPORT_SYMBOL(blkdev_issue_secure_erase);
> >   *  underlying storage pool to allocate space for this block range.
> >   */
> >  int blkdev_issue_provision(struct block_device *bdev, sector_t sector,
> > -             sector_t nr_sects, gfp_t gfp)
> > +             sector_t nr_sects, gfp_t gfp, unsigned flags)
> >  {
> >       sector_t bs_mask =3D (bdev_logical_block_size(bdev) >> 9) - 1;
> >       unsigned int max_sectors =3D bdev_max_provision_sectors(bdev);
> > @@ -380,6 +381,9 @@ int blkdev_issue_provision(struct block_device *bde=
v, sector_t sector,
> >               bio->bi_iter.bi_sector =3D sector;
> >               bio->bi_iter.bi_size =3D req_sects << SECTOR_SHIFT;
> >
> > +             if (flags & BLKDEV_UNSHARE_RANGE)
>
> This is a provisioning flag, shouldn't this be ...
> BLKDEV_PROVISION_UNSHARE or something?
>
Done in v8, thanks!

> > +                     bio->bi_opf |=3D REQ_UNSHARE;
> > +
> >               sector +=3D req_sects;
> >               nr_sects -=3D req_sects;
> >               if (!nr_sects) {
> > diff --git a/block/fops.c b/block/fops.c
> > index be2e41f160bf..6848756f0557 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -659,7 +659,11 @@ static long blkdev_fallocate(struct file *file, in=
t mode, loff_t start,
> >       case FALLOC_FL_KEEP_SIZE:
> >       case FALLOC_FL_UNSHARE_RANGE | FALLOC_FL_KEEP_SIZE:
> >               error =3D blkdev_issue_provision(bdev, start >> SECTOR_SH=
IFT,
> > -                                            len >> SECTOR_SHIFT, GFP_K=
ERNEL);
> > +                                            len >> SECTOR_SHIFT, GFP_K=
ERNEL,
> > +                                            (mode &
> > +                                             FALLOC_FL_UNSHARE_RANGE) =
?
> > +                                                    BLKDEV_UNSHARE_RAN=
GE :
> > +                                                    0);
>
> You might want to do something about the six level indent here;
> Linus hates that.
>
Thanks for pointing it out, I switched it up a bit in v8 but it still
looks a bit weird to me.

Best
Sarthak

> --D
>
> >               break;
> >       case FALLOC_FL_ZERO_RANGE:
> >       case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 7fe1a6629754..c844b145d666 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -306,6 +306,30 @@ static int lo_read_simple(struct loop_device *lo, =
struct request *rq,
> >       return 0;
> >  }
> >
> > +static bool validate_fallocate_mode(struct loop_device *lo, int mode)
> > +{
> > +     bool ret =3D true;
> > +
> > +     switch (mode) {
> > +     case FALLOC_FL_PUNCH_HOLE:
> > +     case FALLOC_FL_ZERO_RANGE:
> > +             if (!bdev_max_discard_sectors(lo->lo_device))
> > +                     ret =3D false;
> > +             break;
> > +     case 0:
> > +     case FALLOC_FL_UNSHARE_RANGE:
> > +             if (!bdev_max_provision_sectors(lo->lo_device))
> > +                     ret =3D false;
> > +             break;
> > +
> > +     default:
> > +             ret =3D false;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +
> >  static int lo_fallocate(struct loop_device *lo, struct request *rq, lo=
ff_t pos,
> >                       int mode)
> >  {
> > @@ -316,11 +340,7 @@ static int lo_fallocate(struct loop_device *lo, st=
ruct request *rq, loff_t pos,
> >       struct file *file =3D lo->lo_backing_file;
> >       int ret;
> >
> > -     if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE) &&
> > -         !bdev_max_discard_sectors(lo->lo_device))
> > -             return -EOPNOTSUPP;
> > -
> > -     if (mode =3D=3D 0 && !bdev_max_provision_sectors(lo->lo_device))
> > +     if (!validate_fallocate_mode(lo, mode))
> >               return -EOPNOTSUPP;
> >
> >       mode |=3D FALLOC_FL_KEEP_SIZE;
> > @@ -493,7 +513,10 @@ static int do_req_filebacked(struct loop_device *l=
o, struct request *rq)
> >       case REQ_OP_DISCARD:
> >               return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
> >       case REQ_OP_PROVISION:
> > -             return lo_fallocate(lo, rq, pos, 0);
> > +             return lo_fallocate(lo, rq, pos,
> > +                                 (rq->cmd_flags & REQ_UNSHARE) ?
> > +                                         FALLOC_FL_UNSHARE_RANGE :
> > +                                         0);
> >       case REQ_OP_WRITE:
> >               if (cmd->use_aio)
> >                       return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > index b7bb0226fdee..1a536fd897cb 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -423,6 +423,8 @@ enum req_flag_bits {
> >        */
> >       /* for REQ_OP_WRITE_ZEROES: */
> >       __REQ_NOUNMAP,          /* do not free blocks when zeroing */
> > +     /* for REQ_OP_PROVISION: */
> > +     __REQ_UNSHARE,          /* unshare blocks */
> >
> >       __REQ_NR_BITS,          /* stops here */
> >  };
> > @@ -451,6 +453,7 @@ enum req_flag_bits {
> >  #define REQ_FS_PRIVATE       (__force blk_opf_t)(1ULL << __REQ_FS_PRIV=
ATE)
> >
> >  #define REQ_NOUNMAP  (__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
> > +#define REQ_UNSHARE  (__force blk_opf_t)(1ULL << __REQ_UNSHARE)
> >
> >  #define REQ_FAILFAST_MASK \
> >       (REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 462ce586d46f..60c09b0d3fc9 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -1049,10 +1049,11 @@ int blkdev_issue_secure_erase(struct block_devi=
ce *bdev, sector_t sector,
> >               sector_t nr_sects, gfp_t gfp);
> >
> >  extern int blkdev_issue_provision(struct block_device *bdev, sector_t =
sector,
> > -             sector_t nr_sects, gfp_t gfp_mask);
> > +             sector_t nr_sects, gfp_t gfp_mask, unsigned int flags);
> >
> >  #define BLKDEV_ZERO_NOUNMAP  (1 << 0)  /* do not free blocks */
> >  #define BLKDEV_ZERO_NOFALLBACK       (1 << 1)  /* don't write explicit=
 zeroes */
> > +#define BLKDEV_UNSHARE_RANGE (1 << 2)  /* unshare range on provision *=
/
> >
> >  extern int __blkdev_issue_zeroout(struct block_device *bdev, sector_t =
sector,
> >               sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
> > --
> > 2.39.2
> >
