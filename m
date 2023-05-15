Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DA9704016
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 23:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244742AbjEOVzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 17:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjEOVzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 17:55:20 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17BCA275
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 14:55:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so24309651a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684187716; x=1686779716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBufFDPCgb8FzjQLH8nY1KMCUfOc5xDHFgBLnp3EL70=;
        b=ULrctO43Pao4De+rNpLZXSKMgCwdoSmaAzqAZbXtO4HwOkwBcZjzSJ0AjyQQnujE/0
         cj8scQpJ6mh7xFwrQRMi36tpIY1J87rDw4kapB6wgFjd/NZAyW86G9COEuRjOP7aW+VV
         dyNV8LR0UBTa/hhyGyoZGWpxwK1dbGidfvG10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684187716; x=1686779716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBufFDPCgb8FzjQLH8nY1KMCUfOc5xDHFgBLnp3EL70=;
        b=g4ixsuGMZ8/DYwc0prwOIedmMnaBS6R6YWYmqD0oVdzrk9Rxm5W9LtPb9q4vHvjqRM
         6MPgU8yjLyGxCefq7O1NJ4WKcC/L6MxfFSXodaRVsexDQm/jm2WGdkl3Mms983MoZRVJ
         BNy4iR2prL8yLxKAZVf40zkS7IOY1AO/NShv27PNoTTJ8wHSQ1ehpdMwJshKbo3g31rl
         hXbwOIgBk5Hy0ug2cX/IVf2wkmro1ht9XTNhkLmUX6Qs8G8vqbKOvQmggtYIFLNRPoGw
         ookxThBKaIYFRRYGwQkcm5oFZaqk8PvlI/RgBADuTcBfzHvbh+o6XvhjSprvSV0lFnoT
         3uUg==
X-Gm-Message-State: AC+VfDwcDcjcVL1wlPCXsi1/G8V8g2O7Sip8q2ZkvfciC5RZSUJJATDj
        mIXJFXCak2TprEPYjjTr0QdlQc55TLMRrpXpL6Ko7Q==
X-Google-Smtp-Source: ACHHUZ463PeFDmXcfMVew3EXs0kR201Z/7XoYxMODWyV+My+VRnmSJ8zQgzHBJ/GhsgwhmuCIrNB6QdfsiuJTHf3bk0=
X-Received: by 2002:a17:907:9482:b0:968:4d51:800b with SMTP id
 dm2-20020a170907948200b009684d51800bmr25417043ejc.1.1684187716125; Mon, 15
 May 2023 14:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org> <20230506062909.74601-3-sarthakkukreti@chromium.org>
 <20230512183729.GE858791@frogsfrogsfrogs>
In-Reply-To: <20230512183729.GE858791@frogsfrogsfrogs>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Mon, 15 May 2023 14:55:05 -0700
Message-ID: <CAG9=OMPpNOrkwN07bdPS61Rg+osu72Ge_RLZJoPLRsAEAqNhFA@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] block: Introduce provisioning primitives
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 12, 2023 at 11:37=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Fri, May 05, 2023 at 11:29:06PM -0700, Sarthak Kukreti wrote:
> > Introduce block request REQ_OP_PROVISION. The intent of this request
> > is to request underlying storage to preallocate disk space for the give=
n
> > block range. Block devices that support this capability will export
> > a provision limit within their request queues.
> >
> > This patch also adds the capability to call fallocate() in mode 0
> > on block devices, which will send REQ_OP_PROVISION to the block
> > device for the specified range,
> >
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  block/blk-core.c          |  5 ++++
> >  block/blk-lib.c           | 53 +++++++++++++++++++++++++++++++++++++++
> >  block/blk-merge.c         | 18 +++++++++++++
> >  block/blk-settings.c      | 19 ++++++++++++++
> >  block/blk-sysfs.c         |  9 +++++++
> >  block/bounce.c            |  1 +
> >  block/fops.c              | 10 +++++++-
> >  include/linux/bio.h       |  6 +++--
> >  include/linux/blk_types.h |  5 +++-
> >  include/linux/blkdev.h    | 16 ++++++++++++
> >  10 files changed, 138 insertions(+), 4 deletions(-)
> >
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 42926e6cb83c..4a2342ba3a8b 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -123,6 +123,7 @@ static const char *const blk_op_name[] =3D {
> >       REQ_OP_NAME(WRITE_ZEROES),
> >       REQ_OP_NAME(DRV_IN),
> >       REQ_OP_NAME(DRV_OUT),
> > +     REQ_OP_NAME(PROVISION)
> >  };
> >  #undef REQ_OP_NAME
> >
> > @@ -798,6 +799,10 @@ void submit_bio_noacct(struct bio *bio)
> >               if (!q->limits.max_write_zeroes_sectors)
> >                       goto not_supported;
> >               break;
> > +     case REQ_OP_PROVISION:
> > +             if (!q->limits.max_provision_sectors)
> > +                     goto not_supported;
> > +             break;
> >       default:
> >               break;
> >       }
> > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > index e59c3069e835..647b6451660b 100644
> > --- a/block/blk-lib.c
> > +++ b/block/blk-lib.c
> > @@ -343,3 +343,56 @@ int blkdev_issue_secure_erase(struct block_device =
*bdev, sector_t sector,
> >       return ret;
> >  }
> >  EXPORT_SYMBOL(blkdev_issue_secure_erase);
> > +
> > +/**
> > + * blkdev_issue_provision - provision a block range
> > + * @bdev:    blockdev to write
> > + * @sector:  start sector
> > + * @nr_sects:        number of sectors to provision
> > + * @gfp_mask:        memory allocation flags (for bio_alloc)
> > + *
> > + * Description:
> > + *  Issues a provision request to the block device for the range of se=
ctors.
> > + *  For thinly provisioned block devices, this acts as a signal for th=
e
> > + *  underlying storage pool to allocate space for this block range.
> > + */
> > +int blkdev_issue_provision(struct block_device *bdev, sector_t sector,
> > +             sector_t nr_sects, gfp_t gfp)
> > +{
> > +     sector_t bs_mask =3D (bdev_logical_block_size(bdev) >> 9) - 1;
> > +     unsigned int max_sectors =3D bdev_max_provision_sectors(bdev);
> > +     struct bio *bio =3D NULL;
> > +     struct blk_plug plug;
> > +     int ret =3D 0;
> > +
> > +     if (max_sectors =3D=3D 0)
> > +             return -EOPNOTSUPP;
> > +     if ((sector | nr_sects) & bs_mask)
> > +             return -EINVAL;
> > +     if (bdev_read_only(bdev))
> > +             return -EPERM;
> > +
> > +     blk_start_plug(&plug);
> > +     for (;;) {
> > +             unsigned int req_sects =3D min_t(sector_t, nr_sects, max_=
sectors);
> > +
> > +             bio =3D blk_next_bio(bio, bdev, 0, REQ_OP_PROVISION, gfp)=
;
> > +             bio->bi_iter.bi_sector =3D sector;
> > +             bio->bi_iter.bi_size =3D req_sects << SECTOR_SHIFT;
> > +
> > +             sector +=3D req_sects;
> > +             nr_sects -=3D req_sects;
> > +             if (!nr_sects) {
> > +                     ret =3D submit_bio_wait(bio);
> > +                     if (ret =3D=3D -EOPNOTSUPP)
> > +                             ret =3D 0;
>
> Why do we convert EOPNOTSUPP to success here?  If the device suddenly
> forgets how to provision space, wouldn't we want to pass that up to the
> caller?
>
> (I'm not sure when this would happen -- perhaps the bdev has the general
> provisioning capability but not for the specific range requested?)
>
Ah good catch, I initially wired it up to be less noisy in the kernel
logs but left it behind accidentally. The error should definitely be
passed through: one case where this can happen is if the device-mapper
table comprises several underlying targets but only a few of them
support provision. I'll fix this in v7.

Best
Sarthak

> The rest of the patch looks ok to me.
>
> --D
>
> > +                     bio_put(bio);
> > +                     break;
> > +             }
> > +             cond_resched();
> > +     }
> > +     blk_finish_plug(&plug);
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL(blkdev_issue_provision);
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index 6460abdb2426..a3ffebb97a1d 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -158,6 +158,21 @@ static struct bio *bio_split_write_zeroes(struct b=
io *bio,
> >       return bio_split(bio, lim->max_write_zeroes_sectors, GFP_NOIO, bs=
);
> >  }
> >
> > +static struct bio *bio_split_provision(struct bio *bio,
> > +                                     const struct queue_limits *lim,
> > +                                     unsigned int *nsegs, struct bio_s=
et *bs)
> > +{
> > +     *nsegs =3D 0;
> > +
> > +     if (!lim->max_provision_sectors)
> > +             return NULL;
> > +
> > +     if (bio_sectors(bio) <=3D lim->max_provision_sectors)
> > +             return NULL;
> > +
> > +     return bio_split(bio, lim->max_provision_sectors, GFP_NOIO, bs);
> > +}
> > +
> >  /*
> >   * Return the maximum number of sectors from the start of a bio that m=
ay be
> >   * submitted as a single request to a block device. If enough sectors =
remain,
> > @@ -366,6 +381,9 @@ struct bio *__bio_split_to_limits(struct bio *bio,
> >       case REQ_OP_WRITE_ZEROES:
> >               split =3D bio_split_write_zeroes(bio, lim, nr_segs, bs);
> >               break;
> > +     case REQ_OP_PROVISION:
> > +             split =3D bio_split_provision(bio, lim, nr_segs, bs);
> > +             break;
> >       default:
> >               split =3D bio_split_rw(bio, lim, nr_segs, bs,
> >                               get_max_io_size(bio, lim) << SECTOR_SHIFT=
);
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index 896b4654ab00..d303e6614c36 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -59,6 +59,7 @@ void blk_set_default_limits(struct queue_limits *lim)
> >       lim->zoned =3D BLK_ZONED_NONE;
> >       lim->zone_write_granularity =3D 0;
> >       lim->dma_alignment =3D 511;
> > +     lim->max_provision_sectors =3D 0;
> >  }
> >
> >  /**
> > @@ -82,6 +83,7 @@ void blk_set_stacking_limits(struct queue_limits *lim=
)
> >       lim->max_dev_sectors =3D UINT_MAX;
> >       lim->max_write_zeroes_sectors =3D UINT_MAX;
> >       lim->max_zone_append_sectors =3D UINT_MAX;
> > +     lim->max_provision_sectors =3D UINT_MAX;
> >  }
> >  EXPORT_SYMBOL(blk_set_stacking_limits);
> >
> > @@ -208,6 +210,20 @@ void blk_queue_max_write_zeroes_sectors(struct req=
uest_queue *q,
> >  }
> >  EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
> >
> > +/**
> > + * blk_queue_max_provision_sectors - set max sectors for a single prov=
ision
> > + *
> > + * @q:  the request queue for the device
> > + * @max_provision_sectors: maximum number of sectors to provision per =
command
> > + **/
> > +
> > +void blk_queue_max_provision_sectors(struct request_queue *q,
> > +             unsigned int max_provision_sectors)
> > +{
> > +     q->limits.max_provision_sectors =3D max_provision_sectors;
> > +}
> > +EXPORT_SYMBOL(blk_queue_max_provision_sectors);
> > +
> >  /**
> >   * blk_queue_max_zone_append_sectors - set max sectors for a single zo=
ne append
> >   * @q:  the request queue for the device
> > @@ -578,6 +594,9 @@ int blk_stack_limits(struct queue_limits *t, struct=
 queue_limits *b,
> >       t->max_segment_size =3D min_not_zero(t->max_segment_size,
> >                                          b->max_segment_size);
> >
> > +     t->max_provision_sectors =3D min_not_zero(t->max_provision_sector=
s,
> > +                                             b->max_provision_sectors)=
;
> > +
> >       t->misaligned |=3D b->misaligned;
> >
> >       alignment =3D queue_limit_alignment_offset(b, start);
> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > index f1fce1c7fa44..0a3165211c66 100644
> > --- a/block/blk-sysfs.c
> > +++ b/block/blk-sysfs.c
> > @@ -213,6 +213,13 @@ static ssize_t queue_discard_zeroes_data_show(stru=
ct request_queue *q, char *pag
> >       return queue_var_show(0, page);
> >  }
> >
> > +static ssize_t queue_provision_max_show(struct request_queue *q,
> > +             char *page)
> > +{
> > +     return sprintf(page, "%llu\n",
> > +             (unsigned long long)q->limits.max_provision_sectors << 9)=
;
> > +}
> > +
> >  static ssize_t queue_write_same_max_show(struct request_queue *q, char=
 *page)
> >  {
> >       return queue_var_show(0, page);
> > @@ -604,6 +611,7 @@ QUEUE_RO_ENTRY(queue_discard_max_hw, "discard_max_h=
w_bytes");
> >  QUEUE_RW_ENTRY(queue_discard_max, "discard_max_bytes");
> >  QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
> >
> > +QUEUE_RO_ENTRY(queue_provision_max, "provision_max_bytes");
> >  QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
> >  QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
> >  QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
> > @@ -661,6 +669,7 @@ static struct attribute *queue_attrs[] =3D {
> >       &queue_discard_max_entry.attr,
> >       &queue_discard_max_hw_entry.attr,
> >       &queue_discard_zeroes_data_entry.attr,
> > +     &queue_provision_max_entry.attr,
> >       &queue_write_same_max_entry.attr,
> >       &queue_write_zeroes_max_entry.attr,
> >       &queue_zone_append_max_entry.attr,
> > diff --git a/block/bounce.c b/block/bounce.c
> > index 7cfcb242f9a1..ab9d8723ae64 100644
> > --- a/block/bounce.c
> > +++ b/block/bounce.c
> > @@ -176,6 +176,7 @@ static struct bio *bounce_clone_bio(struct bio *bio=
_src)
> >       case REQ_OP_DISCARD:
> >       case REQ_OP_SECURE_ERASE:
> >       case REQ_OP_WRITE_ZEROES:
> > +     case REQ_OP_PROVISION:
> >               break;
> >       default:
> >               bio_for_each_segment(bv, bio_src, iter)
> > diff --git a/block/fops.c b/block/fops.c
> > index 4c70fdc546e7..be2e41f160bf 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -613,7 +613,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb,=
 struct iov_iter *to)
> >
> >  #define      BLKDEV_FALLOC_FL_SUPPORTED                               =
       \
> >               (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |           \
> > -              FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
> > +              FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE |       \
> > +              FALLOC_FL_UNSHARE_RANGE)
> >
> >  static long blkdev_fallocate(struct file *file, int mode, loff_t start=
,
> >                            loff_t len)
> > @@ -653,6 +654,13 @@ static long blkdev_fallocate(struct file *file, in=
t mode, loff_t start,
> >        * de-allocate mode calls to fallocate().
> >        */
> >       switch (mode) {
> > +     case 0:
> > +     case FALLOC_FL_UNSHARE_RANGE:
> > +     case FALLOC_FL_KEEP_SIZE:
> > +     case FALLOC_FL_UNSHARE_RANGE | FALLOC_FL_KEEP_SIZE:
> > +             error =3D blkdev_issue_provision(bdev, start >> SECTOR_SH=
IFT,
> > +                                            len >> SECTOR_SHIFT, GFP_K=
ERNEL);
> > +             break;
> >       case FALLOC_FL_ZERO_RANGE:
> >       case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
> >               error =3D truncate_bdev_range(bdev, file->f_mode, start, =
end);
> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index d766be7152e1..9820b3b039f2 100644
> > --- a/include/linux/bio.h
> > +++ b/include/linux/bio.h
> > @@ -57,7 +57,8 @@ static inline bool bio_has_data(struct bio *bio)
> >           bio->bi_iter.bi_size &&
> >           bio_op(bio) !=3D REQ_OP_DISCARD &&
> >           bio_op(bio) !=3D REQ_OP_SECURE_ERASE &&
> > -         bio_op(bio) !=3D REQ_OP_WRITE_ZEROES)
> > +         bio_op(bio) !=3D REQ_OP_WRITE_ZEROES &&
> > +         bio_op(bio) !=3D REQ_OP_PROVISION)
> >               return true;
> >
> >       return false;
> > @@ -67,7 +68,8 @@ static inline bool bio_no_advance_iter(const struct b=
io *bio)
> >  {
> >       return bio_op(bio) =3D=3D REQ_OP_DISCARD ||
> >              bio_op(bio) =3D=3D REQ_OP_SECURE_ERASE ||
> > -            bio_op(bio) =3D=3D REQ_OP_WRITE_ZEROES;
> > +            bio_op(bio) =3D=3D REQ_OP_WRITE_ZEROES ||
> > +            bio_op(bio) =3D=3D REQ_OP_PROVISION;
> >  }
> >
> >  static inline void *bio_data(struct bio *bio)
> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > index 99be590f952f..27bdf88f541c 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -385,7 +385,10 @@ enum req_op {
> >       REQ_OP_DRV_IN           =3D (__force blk_opf_t)34,
> >       REQ_OP_DRV_OUT          =3D (__force blk_opf_t)35,
> >
> > -     REQ_OP_LAST             =3D (__force blk_opf_t)36,
> > +     /* request device to provision block */
> > +     REQ_OP_PROVISION        =3D (__force blk_opf_t)37,
> > +
> > +     REQ_OP_LAST             =3D (__force blk_opf_t)38,
> >  };
> >
> >  enum req_flag_bits {
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 941304f17492..239e2f418b6e 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -303,6 +303,7 @@ struct queue_limits {
> >       unsigned int            discard_granularity;
> >       unsigned int            discard_alignment;
> >       unsigned int            zone_write_granularity;
> > +     unsigned int            max_provision_sectors;
> >
> >       unsigned short          max_segments;
> >       unsigned short          max_integrity_segments;
> > @@ -921,6 +922,8 @@ extern void blk_queue_max_discard_sectors(struct re=
quest_queue *q,
> >               unsigned int max_discard_sectors);
> >  extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q=
,
> >               unsigned int max_write_same_sectors);
> > +extern void blk_queue_max_provision_sectors(struct request_queue *q,
> > +             unsigned int max_provision_sectors);
> >  extern void blk_queue_logical_block_size(struct request_queue *, unsig=
ned int);
> >  extern void blk_queue_max_zone_append_sectors(struct request_queue *q,
> >               unsigned int max_zone_append_sectors);
> > @@ -1060,6 +1063,9 @@ int __blkdev_issue_discard(struct block_device *b=
dev, sector_t sector,
> >  int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sect=
or,
> >               sector_t nr_sects, gfp_t gfp);
> >
> > +extern int blkdev_issue_provision(struct block_device *bdev, sector_t =
sector,
> > +             sector_t nr_sects, gfp_t gfp_mask);
> > +
> >  #define BLKDEV_ZERO_NOUNMAP  (1 << 0)  /* do not free blocks */
> >  #define BLKDEV_ZERO_NOFALLBACK       (1 << 1)  /* don't write explicit=
 zeroes */
> >
> > @@ -1139,6 +1145,11 @@ static inline unsigned short queue_max_discard_s=
egments(const struct request_que
> >       return q->limits.max_discard_segments;
> >  }
> >
> > +static inline unsigned short queue_max_provision_sectors(const struct =
request_queue *q)
> > +{
> > +     return q->limits.max_provision_sectors;
> > +}
> > +
> >  static inline unsigned int queue_max_segment_size(const struct request=
_queue *q)
> >  {
> >       return q->limits.max_segment_size;
> > @@ -1281,6 +1292,11 @@ static inline bool bdev_nowait(struct block_devi=
ce *bdev)
> >       return test_bit(QUEUE_FLAG_NOWAIT, &bdev_get_queue(bdev)->queue_f=
lags);
> >  }
> >
> > +static inline unsigned int bdev_max_provision_sectors(struct block_dev=
ice *bdev)
> > +{
> > +     return bdev_get_queue(bdev)->limits.max_provision_sectors;
> > +}
> > +
> >  static inline enum blk_zoned_model bdev_zoned_model(struct block_devic=
e *bdev)
> >  {
> >       return blk_queue_zoned_model(bdev_get_queue(bdev));
> > --
> > 2.40.1.521.gf1e218fcd8-goog
> >
