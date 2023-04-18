Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A27F6E6F36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 00:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjDRWNh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 18:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjDRWN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:13:27 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A0D72A9
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 15:13:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94a342f7c4cso706357066b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 15:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681855996; x=1684447996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4OoVgdT/JlPTUOnnCefJPrx31VmWBmg4aQ12vOZz6M=;
        b=VkQ5BIVsAXz8qHPqE1AbuokqcbbwIl019gwdrrvhI6RBdb9tqky4QNBDqa3aZeXugA
         +bEXjiLfvYEU9oxVFYmKuIqNANetO2Xc/hXAsFKPBVHK/w9TYhg4fQ0+2Xlw30OJ/7dy
         xAgKsO3NyV3Exdxh9y8Qh6gW7aKQ3gBsAOm1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681855996; x=1684447996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4OoVgdT/JlPTUOnnCefJPrx31VmWBmg4aQ12vOZz6M=;
        b=QvjTXY3D5RhRkTNvjPyUmIY+Eus5OKvLKRA1jkBnMeWY/xQIz0xW4s2uXyOKn5tQ9+
         5Bvk9mmL/lVKr1tDDAYkp6qX4VOaGM0PpRo7kFHD9kk36W5hnc+r85yeizq99SZ3cZrz
         A2toGxS8/OjQkjRBBnwD9KO82+WfnvtlJLcGqnIzcxZg/z3CSi3RdMCofTcougGsikDS
         SQTsozHjKsy4hZ4vIFS6tXOc4Ooro11H04qm76LSC1zYbqKT0+8YkpI+4mGDnLS3Plwf
         lqWemdAXi8TVQEPafSbLbJNwi250JFctKOLTr1YRvBetDT6I2CtHCCiaTd6PjUqWK0Jz
         CwfA==
X-Gm-Message-State: AAQBX9e7m9iWa2JAcf8A42yCjmF/mfAWX8K/QzdmpYg6hb2osI5SMizG
        I49VA6a1C6wCBbvs29bj3cHhY/oX20FaFI9ZyXdW+UrKWzabxbly
X-Google-Smtp-Source: AKy350Y3bvX3JFwVJANUTwkv3nMR2zJzD8QH+3bT9woan5yhK8iPldbNIWULJmdbNY5X/QXA1kt+tT6oy+VLe4ukAzM=
X-Received: by 2002:aa7:c405:0:b0:4fa:6767:817b with SMTP id
 j5-20020aa7c405000000b004fa6767817bmr3543467edq.41.1681855996087; Tue, 18 Apr
 2023 15:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221229071647.437095-1-sarthakkukreti@chromium.org>
 <20230414000219.92640-1-sarthakkukreti@chromium.org> <20230414000219.92640-2-sarthakkukreti@chromium.org>
 <ZD2DcvyHdNmkdwr1@bfoster>
In-Reply-To: <ZD2DcvyHdNmkdwr1@bfoster>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Tue, 18 Apr 2023 15:13:05 -0700
Message-ID: <CAG9=OMO0Wdo_k_jDzL95FdrtuQHjzgX2asKN21GYcpEcpkknfA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] block: Introduce provisioning primitives
To:     Brian Foster <bfoster@redhat.com>
Cc:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 10:33=E2=80=AFAM Brian Foster <bfoster@redhat.com> =
wrote:
>
> On Thu, Apr 13, 2023 at 05:02:17PM -0700, Sarthak Kukreti wrote:
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
> >  block/blk-sysfs.c         |  8 ++++++
> >  block/bounce.c            |  1 +
> >  block/fops.c              | 14 ++++++++---
> >  include/linux/bio.h       |  6 +++--
> >  include/linux/blk_types.h |  5 +++-
> >  include/linux/blkdev.h    | 16 ++++++++++++
> >  10 files changed, 138 insertions(+), 7 deletions(-)
> >
> ...
> > diff --git a/block/fops.c b/block/fops.c
> > index d2e6be4e3d1c..f82da2fb8af0 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -625,7 +625,7 @@ static long blkdev_fallocate(struct file *file, int=
 mode, loff_t start,
> >       int error;
> >
> >       /* Fail if we don't recognize the flags. */
> > -     if (mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
> > +     if (mode !=3D 0 && mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
> >               return -EOPNOTSUPP;
> >
> >       /* Don't go off the end of the device. */
> > @@ -649,11 +649,17 @@ static long blkdev_fallocate(struct file *file, i=
nt mode, loff_t start,
> >       filemap_invalidate_lock(inode->i_mapping);
> >
> >       /* Invalidate the page cache, including dirty pages. */
> > -     error =3D truncate_bdev_range(bdev, file->f_mode, start, end);
> > -     if (error)
> > -             goto fail;
> > +     if (mode !=3D 0) {
> > +             error =3D truncate_bdev_range(bdev, file->f_mode, start, =
end);
> > +             if (error)
> > +                     goto fail;
> > +     }
> >
> >       switch (mode) {
> > +     case 0:
> > +             error =3D blkdev_issue_provision(bdev, start >> SECTOR_SH=
IFT,
> > +                                            len >> SECTOR_SHIFT, GFP_K=
ERNEL);
> > +             break;
>
> I would think we'd want to support any combination of
> FALLOC_FL_KEEP_SIZE and FALLOC_FL_UNSHARE_RANGE..? All of the other
> commands support the former modifier, for one. It also looks like if
> somebody attempts to invoke with mode =3D=3D FALLOC_FL_KEEP_SIZE, even wi=
th
> the current upstream code that would perform the bdev truncate before
> returning -EOPNOTSUPP. That seems like a bit of an unfortunate side
> effect to me.
>
Added a separate flag set to decide whether we should truncate or not.

> WRT to unshare, if the PROVISION request is always going to imply an
> unshare (which seems reasonable to me), there's probably no reason to
> -EOPNOTSUPP if a caller explicitly passes UNSHARE_RANGE.
>
Added handling in v4.

Thanks!

Sarthak

> Brian
>
> >       case FALLOC_FL_ZERO_RANGE:
> >       case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
> >               error =3D blkdev_issue_zeroout(bdev, start >> SECTOR_SHIF=
T,
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
> > 2.40.0.634.g4ca3ef3211-goog
> >
>
