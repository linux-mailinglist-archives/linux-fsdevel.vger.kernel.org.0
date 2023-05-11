Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86AF6FFB00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 22:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbjEKUDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 16:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238811AbjEKUDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 16:03:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1903C8A72
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 13:03:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50db91640d3so5984776a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 13:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683835414; x=1686427414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8xH7zGQzzRbqK6D4Oqhm3xKHhC25ViGnrUjwC/gsSw=;
        b=MW5xkfBKg7R27pQpq6VOVNVFJBGddm5iGtOfa0k1cfyLC9VX049iC1rmEI6Fl/GVrk
         7KKp7M8jRu3u4zh+yk6X15HS11ERm6dMK4kr50yDNyZFYvNqTYalyzCbsc1AAdQimZEp
         nSfhnGrqTLLb7MBOSSUVZ5FhH2Rqs6nIRmhZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683835414; x=1686427414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8xH7zGQzzRbqK6D4Oqhm3xKHhC25ViGnrUjwC/gsSw=;
        b=Zcd69++7q58esiqWk6qjyTUs6FTsDm6PpXAZM2kOOjnYo5N3WcbC9l+JJVDBhnxXuQ
         rkPd038v6epKi0BA107+ntS/7Z619bw1Nwn+ZWTAjJ1CUbPVm8kqQwJklEnugULdnynj
         5+AGnbxMAWfFDJKmNyNbkR8X2kb/nxNRzg30S1uLBdq1pEuq3/E9OQcYdWHanMzqgkEF
         JoTatWgUjWk5no8Glu6yTWZ5KMBX8ikvsm8Q6SdZ8OMc8goHBcTT6BB46yiz+IjQx5/S
         bEotU8v64EoivuI+bVcp5g1YxRhac9pU/QZnLqMin/8fwW7JHPpN6Ux/r45M31jT+QRR
         pjOA==
X-Gm-Message-State: AC+VfDw++BDVVT/13Bk72Z89Jj2vE89tztNOOePCtU2dNoCP5ShvbLOY
        p4WxAzlzb9t1pXW5gvIPcU2UwGMk9DLPRQbI3F1kuQ==
X-Google-Smtp-Source: ACHHUZ79IojXfbkX6DfE2MLOr1tErOiC5hf30sNWjiHWJExQyVXKxDUaQO3ACK/0ZNMxUV3252rL9e3+SLQj4skO4N0=
X-Received: by 2002:a17:907:9694:b0:969:ba95:a3a0 with SMTP id
 hd20-20020a170907969400b00969ba95a3a0mr12334138ejc.23.1683835414423; Thu, 11
 May 2023 13:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org> <20230506062909.74601-5-sarthakkukreti@chromium.org>
 <ZFp7ykxGFUbPG1ON@redhat.com>
In-Reply-To: <ZFp7ykxGFUbPG1ON@redhat.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 11 May 2023 13:03:23 -0700
Message-ID: <CAG9=OMOMrFcy6UdL8-3wZGwOr1nqLm1bpvL+G1g2dvBhJWU2Kw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] dm-thin: Add REQ_OP_PROVISION support
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
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

On Tue, May 9, 2023 at 9:58=E2=80=AFAM Mike Snitzer <snitzer@kernel.org> wr=
ote:
>
> On Sat, May 06 2023 at  2:29P -0400,
> Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
>
> > dm-thinpool uses the provision request to provision
> > blocks for a dm-thin device. dm-thinpool currently does not
> > pass through REQ_OP_PROVISION to underlying devices.
> >
> > For shared blocks, provision requests will break sharing and copy the
> > contents of the entire block. Additionally, if 'skip_block_zeroing'
> > is not set, dm-thin will opt to zero out the entire range as a part
> > of provisioning.
> >
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  drivers/md/dm-thin.c | 70 +++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 66 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> > index 2b13c949bd72..3f94f53ac956 100644
> > --- a/drivers/md/dm-thin.c
> > +++ b/drivers/md/dm-thin.c
> > @@ -274,6 +274,7 @@ struct pool {
> >
> >       process_bio_fn process_bio;
> >       process_bio_fn process_discard;
> > +     process_bio_fn process_provision;
> >
> >       process_cell_fn process_cell;
> >       process_cell_fn process_discard_cell;
> > @@ -913,7 +914,8 @@ static void __inc_remap_and_issue_cell(void *contex=
t,
> >       struct bio *bio;
> >
> >       while ((bio =3D bio_list_pop(&cell->bios))) {
> > -             if (op_is_flush(bio->bi_opf) || bio_op(bio) =3D=3D REQ_OP=
_DISCARD)
> > +             if (op_is_flush(bio->bi_opf) || bio_op(bio) =3D=3D REQ_OP=
_DISCARD ||
> > +                 bio_op(bio) =3D=3D REQ_OP_PROVISION)
> >                       bio_list_add(&info->defer_bios, bio);
> >               else {
> >                       inc_all_io_entry(info->tc->pool, bio);
> > @@ -1245,8 +1247,8 @@ static int io_overlaps_block(struct pool *pool, s=
truct bio *bio)
> >
> >  static int io_overwrites_block(struct pool *pool, struct bio *bio)
> >  {
> > -     return (bio_data_dir(bio) =3D=3D WRITE) &&
> > -             io_overlaps_block(pool, bio);
> > +     return (bio_data_dir(bio) =3D=3D WRITE) && io_overlaps_block(pool=
, bio) &&
> > +            bio_op(bio) !=3D REQ_OP_PROVISION;
> >  }
> >
> >  static void save_and_set_endio(struct bio *bio, bio_end_io_t **save,
> > @@ -1953,6 +1955,51 @@ static void provision_block(struct thin_c *tc, s=
truct bio *bio, dm_block_t block
> >       }
> >  }
> >
> > +static void process_provision_bio(struct thin_c *tc, struct bio *bio)
> > +{
> > +     int r;
> > +     struct pool *pool =3D tc->pool;
> > +     dm_block_t block =3D get_bio_block(tc, bio);
> > +     struct dm_bio_prison_cell *cell;
> > +     struct dm_cell_key key;
> > +     struct dm_thin_lookup_result lookup_result;
> > +
> > +     /*
> > +      * If cell is already occupied, then the block is already
> > +      * being provisioned so we have nothing further to do here.
> > +      */
> > +     build_virtual_key(tc->td, block, &key);
> > +     if (bio_detain(pool, &key, bio, &cell))
> > +             return;
> > +
> > +     if (tc->requeue_mode) {
> > +             cell_requeue(pool, cell);
> > +             return;
> > +     }
> > +
> > +     r =3D dm_thin_find_block(tc->td, block, 1, &lookup_result);
> > +     switch (r) {
> > +     case 0:
> > +             if (lookup_result.shared) {
> > +                     process_shared_bio(tc, bio, block, &lookup_result=
, cell);
> > +             } else {
> > +                     bio_endio(bio);
> > +                     cell_defer_no_holder(tc, cell);
> > +             }
> > +             break;
> > +     case -ENODATA:
> > +             provision_block(tc, bio, block, cell);
> > +             break;
> > +
> > +     default:
> > +             DMERR_LIMIT("%s: dm_thin_find_block() failed: error =3D %=
d",
> > +                         __func__, r);
> > +             cell_defer_no_holder(tc, cell);
> > +             bio_io_error(bio);
> > +             break;
> > +     }
> > +}
> > +
> >  static void process_cell(struct thin_c *tc, struct dm_bio_prison_cell =
*cell)
> >  {
> >       int r;
> > @@ -2228,6 +2275,8 @@ static void process_thin_deferred_bios(struct thi=
n_c *tc)
> >
> >               if (bio_op(bio) =3D=3D REQ_OP_DISCARD)
> >                       pool->process_discard(tc, bio);
> > +             else if (bio_op(bio) =3D=3D REQ_OP_PROVISION)
> > +                     pool->process_provision(tc, bio);
> >               else
> >                       pool->process_bio(tc, bio);
> >
> > @@ -2579,6 +2628,7 @@ static void set_pool_mode(struct pool *pool, enum=
 pool_mode new_mode)
> >               dm_pool_metadata_read_only(pool->pmd);
> >               pool->process_bio =3D process_bio_fail;
> >               pool->process_discard =3D process_bio_fail;
> > +             pool->process_provision =3D process_bio_fail;
> >               pool->process_cell =3D process_cell_fail;
> >               pool->process_discard_cell =3D process_cell_fail;
> >               pool->process_prepared_mapping =3D process_prepared_mappi=
ng_fail;
> > @@ -2592,6 +2642,7 @@ static void set_pool_mode(struct pool *pool, enum=
 pool_mode new_mode)
> >               dm_pool_metadata_read_only(pool->pmd);
> >               pool->process_bio =3D process_bio_read_only;
> >               pool->process_discard =3D process_bio_success;
> > +             pool->process_provision =3D process_bio_fail;
> >               pool->process_cell =3D process_cell_read_only;
> >               pool->process_discard_cell =3D process_cell_success;
> >               pool->process_prepared_mapping =3D process_prepared_mappi=
ng_fail;
> > @@ -2612,6 +2663,7 @@ static void set_pool_mode(struct pool *pool, enum=
 pool_mode new_mode)
> >               pool->out_of_data_space =3D true;
> >               pool->process_bio =3D process_bio_read_only;
> >               pool->process_discard =3D process_discard_bio;
> > +             pool->process_provision =3D process_bio_fail;
> >               pool->process_cell =3D process_cell_read_only;
> >               pool->process_prepared_mapping =3D process_prepared_mappi=
ng;
> >               set_discard_callbacks(pool);
> > @@ -2628,6 +2680,7 @@ static void set_pool_mode(struct pool *pool, enum=
 pool_mode new_mode)
> >               dm_pool_metadata_read_write(pool->pmd);
> >               pool->process_bio =3D process_bio;
> >               pool->process_discard =3D process_discard_bio;
> > +             pool->process_provision =3D process_provision_bio;
> >               pool->process_cell =3D process_cell;
> >               pool->process_prepared_mapping =3D process_prepared_mappi=
ng;
> >               set_discard_callbacks(pool);
> > @@ -2749,7 +2802,8 @@ static int thin_bio_map(struct dm_target *ti, str=
uct bio *bio)
> >               return DM_MAPIO_SUBMITTED;
> >       }
> >
> > -     if (op_is_flush(bio->bi_opf) || bio_op(bio) =3D=3D REQ_OP_DISCARD=
) {
> > +     if (op_is_flush(bio->bi_opf) || bio_op(bio) =3D=3D REQ_OP_DISCARD=
 ||
> > +         bio_op(bio) =3D=3D REQ_OP_PROVISION) {
> >               thin_defer_bio_with_throttle(tc, bio);
> >               return DM_MAPIO_SUBMITTED;
> >       }
> > @@ -3396,6 +3450,9 @@ static int pool_ctr(struct dm_target *ti, unsigne=
d int argc, char **argv)
> >       pt->adjusted_pf =3D pt->requested_pf =3D pf;
> >       ti->num_flush_bios =3D 1;
> >       ti->limit_swap_bios =3D true;
> > +     ti->num_provision_bios =3D 1;
> > +     ti->provision_supported =3D true;
> > +     ti->max_provision_granularity =3D true;
> >
> >       /*
> >        * Only need to enable discards if the pool should pass
> > @@ -4114,6 +4171,8 @@ static void pool_io_hints(struct dm_target *ti, s=
truct queue_limits *limits)
> >        * The pool uses the same discard limits as the underlying data
> >        * device.  DM core has already set this up.
> >        */
> > +
> > +     limits->max_provision_sectors =3D pool->sectors_per_block;
> >  }
> >
> >  static struct target_type pool_target =3D {
> > @@ -4288,6 +4347,9 @@ static int thin_ctr(struct dm_target *ti, unsigne=
d int argc, char **argv)
> >               ti->max_discard_granularity =3D true;
> >       }
> >
> > +     ti->num_provision_bios =3D 1;
> > +     ti->provision_supported =3D true;
> > +
>
> We need this in thin_ctr: ti->max_provision_granularity =3D true;
>
> More needed in the thin target than thin-pool; otherwise provision bio
> issued to thin devices won't be split appropriately.  But I do think
> its fine to set in both thin_ctr and pool_ctr.
>
> Otherwise, looks good.
>
Thanks! I'll add it to the next iteration (in addition to any other
feedback that's added to v6).

Given that this series covers multiple subsystems, would there be a
preferred way of queueing this for merge?

Best
Sarthak

> Thanks,
> Mike
