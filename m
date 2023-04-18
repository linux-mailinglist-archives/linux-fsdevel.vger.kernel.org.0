Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46596E6F3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 00:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjDRWOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 18:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjDRWN5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:13:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AAB658E
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 15:13:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50677365fd1so3619911a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681856027; x=1684448027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SZagL8fjvW++KTHbtjCcalqgyo1ggkLMR7r8mqWGmc=;
        b=GHnJau2ldV4meQNzSKJbEEyiqAU97dfxjMjCNX8qE1fy801VaNcAMpB4aEe7h8kG/H
         5Yl/QobB9nu4TTPYABjjLhG5r4Bp+5sTFAPPnrvd6T58mtFXs18Nv85pm+7UdCilaStI
         hrRZ0N2t7hWznMzV10ek+wY5LaNbi09suR/Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681856027; x=1684448027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SZagL8fjvW++KTHbtjCcalqgyo1ggkLMR7r8mqWGmc=;
        b=EcSKgL9gSTwUXjvlhCs9W71cG6dfxzHDofuasz/vxtGrjaMP6A8p3agU19Mj9y3LJg
         DJuBumcxwh0d+3bdmj8ggzAtfDg2MoH8Oo1Q21lJNyDXuWRIu/jlmKLieVJco7jBtQ4c
         UOIn3TdndiOJ7X27BO7Ys8yS4lk0o8qZRooOuDPV8utHg86jQgtYb73JX63+m5exvMvn
         FP6o/wy8eMtB64o1O2j0qNOHtFU/AOOhdHx40idw92zujoUvY8ilsTDhA1D4xKemi0lk
         2cef38ALEssbKuhkEfexwlUhcLjstn2hNwgn2S5ywbWNdFvP3cyRY9IIaliEZ2FRltZ+
         Q/TA==
X-Gm-Message-State: AAQBX9d8OgcJIz9aW7AKpU70lRglXB9wBinbbjUwfrFE0OuPafEsqLe2
        LwmifYI1LkvFHPtiZ+idPNX9+Wlt9jC0qMHB23awUg==
X-Google-Smtp-Source: AKy350ZExREQz3w6CoQeZrdTti1DITdqK/ci5lZIPY1mtVRFVKfaJWzV7y8LikMhx8chweDf5WPAby1PY7E9hB9luj4=
X-Received: by 2002:a05:6402:510:b0:506:b209:edb with SMTP id
 m16-20020a056402051000b00506b2090edbmr3347660edv.38.1681856026912; Tue, 18
 Apr 2023 15:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221229071647.437095-1-sarthakkukreti@chromium.org>
 <20230414000219.92640-1-sarthakkukreti@chromium.org> <20230414000219.92640-3-sarthakkukreti@chromium.org>
 <ZDnMl8A1B1+Tfn5S@redhat.com>
In-Reply-To: <ZDnMl8A1B1+Tfn5S@redhat.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Tue, 18 Apr 2023 15:13:35 -0700
Message-ID: <CAG9=OMPS+QVdkkP7OjassJ4YkaAkzC_2hSyooweRqtq+_XBhag@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dm: Add support for block provisioning
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
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

On Fri, Apr 14, 2023 at 2:58=E2=80=AFPM Mike Snitzer <snitzer@kernel.org> w=
rote:
>
> On Thu, Apr 13 2023 at  8:02P -0400,
> Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
>
> > Add support to dm devices for REQ_OP_PROVISION. The default mode
> > is to passthrough the request to the underlying device, if it
> > supports it. dm-thinpool uses the provision request to provision
> > blocks for a dm-thin device. dm-thinpool currently does not
> > pass through REQ_OP_PROVISION to underlying devices.
> >
> > For shared blocks, provision requests will break sharing and copy the
> > contents of the entire block.
> >
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  drivers/md/dm-crypt.c         |   4 +-
> >  drivers/md/dm-linear.c        |   1 +
> >  drivers/md/dm-snap.c          |   7 +++
>
> Have you tested REQ_OP_PROVISION with these targets?  Just want to
> make sure you have an explicit need (and vested interest) for them
> passing through REQ_OP_PROVISION.
>

Yes. I have a vested interest in dm-linear and dm-crypt; I kept
dm-snap support mostly for consistency with thin snapshots.

> > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > index 2055a758541d..5985343384a7 100644
> > --- a/drivers/md/dm-table.c
> > +++ b/drivers/md/dm-table.c
> > @@ -1850,6 +1850,26 @@ static bool dm_table_supports_write_zeroes(struc=
t dm_table *t)
> >       return true;
> >  }
> >
> > +static int device_provision_capable(struct dm_target *ti, struct dm_de=
v *dev,
> > +                                 sector_t start, sector_t len, void *d=
ata)
> > +{
> > +     return !bdev_max_provision_sectors(dev->bdev);
> > +}
> > +
> > +static bool dm_table_supports_provision(struct dm_table *t)
> > +{
> > +     for (unsigned int i =3D 0; i < t->num_targets; i++) {
> > +             struct dm_target *ti =3D dm_table_get_target(t, i);
> > +
> > +             if (ti->provision_supported ||
> > +                 (ti->type->iterate_devices &&
> > +                 ti->type->iterate_devices(ti, device_provision_capabl=
e, NULL)))
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  static int device_not_nowait_capable(struct dm_target *ti, struct dm_d=
ev *dev,
> >                                    sector_t start, sector_t len, void *=
data)
> >  {
> > @@ -1983,6 +2003,11 @@ int dm_table_set_restrictions(struct dm_table *t=
, struct request_queue *q,
> >       if (!dm_table_supports_write_zeroes(t))
> >               q->limits.max_write_zeroes_sectors =3D 0;
> >
> > +     if (dm_table_supports_provision(t))
> > +             blk_queue_max_provision_sectors(q, UINT_MAX >> 9);
>
> This doesn't seem correct in that it'll override whatever
> max_provision_sectors was set by a target (like thinp).
>
> I think you only need the if (!dm_table_supports_provision)) case:
>
Done

> > +     else
> > +             q->limits.max_provision_sectors =3D 0;
> > +
> >       dm_table_verify_integrity(t);
> >
> >       /*
> > diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> > index 13d4677baafd..b08b7ae617be 100644
> > --- a/drivers/md/dm-thin.c
> > +++ b/drivers/md/dm-thin.c
>
> I think it'll make the most sense to split out the dm-thin.c changes
> in a separate patch.
>
Separated the dm-thin changes into a separate patch that follows this one i=
n v4.

> > @@ -909,7 +909,8 @@ static void __inc_remap_and_issue_cell(void *contex=
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
> > @@ -1013,6 +1014,15 @@ static void process_prepared_mapping(struct dm_t=
hin_new_mapping *m)
> >               goto out;
> >       }
> >
> > +     /*
> > +      * For provision requests, once the prepared block has been inser=
ted
> > +      * into the mapping btree, return.
> > +      */
> > +     if (bio && bio_op(bio) =3D=3D REQ_OP_PROVISION) {
> > +             bio_endio(bio);
> > +             return;
> > +     }
> > +
> >       /*
> >        * Release any bios held while the block was being provisioned.
> >        * If we are processing a write bio that completely covers the bl=
ock,
> > @@ -1241,7 +1251,7 @@ static int io_overlaps_block(struct pool *pool, s=
truct bio *bio)
> >
> >  static int io_overwrites_block(struct pool *pool, struct bio *bio)
> >  {
> > -     return (bio_data_dir(bio) =3D=3D WRITE) &&
> > +     return (bio_data_dir(bio) =3D=3D WRITE) && bio_op(bio) !=3D REQ_O=
P_PROVISION &&
> >               io_overlaps_block(pool, bio);
> >  }
> >
> > @@ -1334,10 +1344,11 @@ static void schedule_copy(struct thin_c *tc, dm=
_block_t virt_block,
> >       /*
> >        * IO to pool_dev remaps to the pool target's data_dev.
> >        *
> > -      * If the whole block of data is being overwritten, we can issue =
the
> > -      * bio immediately. Otherwise we use kcopyd to clone the data fir=
st.
> > +      * If the whole block of data is being overwritten and if this is=
 not a
> > +      * provision request, we can issue the bio immediately.
> > +      * Otherwise we use kcopyd to clone the data first.
> >        */
> > -     if (io_overwrites_block(pool, bio))
> > +     if (io_overwrites_block(pool, bio) && bio_op(bio) !=3D REQ_OP_PRO=
VISION)
> >               remap_and_issue_overwrite(tc, bio, data_dest, m);
> >       else {
> >               struct dm_io_region from, to;
> > @@ -1356,7 +1367,8 @@ static void schedule_copy(struct thin_c *tc, dm_b=
lock_t virt_block,
> >               /*
> >                * Do we need to zero a tail region?
> >                */
> > -             if (len < pool->sectors_per_block && pool->pf.zero_new_bl=
ocks) {
> > +             if (len < pool->sectors_per_block && pool->pf.zero_new_bl=
ocks &&
> > +                 bio_op(bio) !=3D REQ_OP_PROVISION) {
> >                       atomic_inc(&m->prepare_actions);
> >                       ll_zero(tc, m,
> >                               data_dest * pool->sectors_per_block + len=
,
> > @@ -1390,6 +1402,10 @@ static void schedule_zero(struct thin_c *tc, dm_=
block_t virt_block,
> >       m->data_block =3D data_block;
> >       m->cell =3D cell;
> >
> > +     /* Provision requests are chained on the original bio. */
> > +     if (bio && bio_op(bio) =3D=3D REQ_OP_PROVISION)
> > +             m->bio =3D bio;
> > +
> >       /*
> >        * If the whole block of data is being overwritten or we are not
> >        * zeroing pre-existing data, we can issue the bio immediately.
> > @@ -1865,7 +1881,8 @@ static void process_shared_bio(struct thin_c *tc,=
 struct bio *bio,
> >
> >       if (bio_data_dir(bio) =3D=3D WRITE && bio->bi_iter.bi_size) {
> >               break_sharing(tc, bio, block, &key, lookup_result, data_c=
ell);
> > -             cell_defer_no_holder(tc, virt_cell);
> > +             if (bio_op(bio) !=3D REQ_OP_PROVISION)
> > +                     cell_defer_no_holder(tc, virt_cell);
> >       } else {
> >               struct dm_thin_endio_hook *h =3D dm_per_bio_data(bio, siz=
eof(struct dm_thin_endio_hook));
> >
>
> Not confident in the above changes given the request that we only
> handle REQ_OP_PROVISION one thinp block at a time.  So I'll gloss over
> them for now.
>
Yeah, the majority of this got removed in v4. I added a check in
io_overwrites_block() to return false for all provision requests.

> > @@ -1982,6 +1999,73 @@ static void process_cell(struct thin_c *tc, stru=
ct dm_bio_prison_cell *cell)
> >       }
> >  }
> >
> > +static void process_provision_cell(struct thin_c *tc, struct dm_bio_pr=
ison_cell *cell)
> > +{
> > +     int r;
> > +     struct pool *pool =3D tc->pool;
> > +     struct bio *bio =3D cell->holder;
> > +     dm_block_t begin, end;
> > +     struct dm_thin_lookup_result lookup_result;
> > +
> > +     if (tc->requeue_mode) {
> > +             cell_requeue(pool, cell);
> > +             return;
> > +     }
> > +
> > +     get_bio_block_range(tc, bio, &begin, &end);
> > +
> > +     while (begin !=3D end) {
> > +             r =3D ensure_next_mapping(pool);
> > +             if (r)
> > +                     /* we did our best */
> > +                     return;
> > +
> > +             r =3D dm_thin_find_block(tc->td, begin, 1, &lookup_result=
);
> > +             switch (r) {
> > +             case 0:
> > +                     if (lookup_result.shared)
> > +                             process_shared_bio(tc, bio, begin,
> > +                                                &lookup_result, cell);
> > +                     begin++;
> > +                     break;
> > +             case -ENODATA:
> > +                     bio_inc_remaining(bio);
> > +                     provision_block(tc, bio, begin, cell);
> > +                     begin++;
> > +                     break;
> > +             default:
> > +                     DMERR_LIMIT(
> > +                             "%s: dm_thin_find_block() failed: error =
=3D %d",
> > +                             __func__, r);
> > +                     cell_defer_no_holder(tc, cell);
> > +                     bio_io_error(bio);
> > +                     begin++;
> > +                     break;
> > +             }
> > +     }
> > +     bio_endio(bio);
> > +     cell_defer_no_holder(tc, cell);
> > +}
> > +
> > +static void process_provision_bio(struct thin_c *tc, struct bio *bio)
> > +{
> > +     dm_block_t begin, end;
> > +     struct dm_cell_key virt_key;
> > +     struct dm_bio_prison_cell *virt_cell;
> > +
> > +     get_bio_block_range(tc, bio, &begin, &end);
> > +     if (begin =3D=3D end) {
> > +             bio_endio(bio);
> > +             return;
> > +     }
>
> Like Joe mentioned, this pattern was fine for discards because they
> are advisory/optional.  But we need to make sure we don't truncate
> REQ_OP_PROVISION -- so we need to round up if we partially bleed into
> the blocks to the left or right.
>
> BUT ranged REQ_OP_PROVISION support is for later, this can be dealt
> with more simply in that each REQ_OP_PROVISION will be handled a block
> at a time initially.  SO you'll want to honor _all_ REQ_OP_PROVISION,
> never returning early.
>
Thanks. The next patch in the series has the simplified version. It
had a lot in common with process_bio() so there was a possibility for
merging the two code paths, but I opted to keep it like this to make
ranged handling and passdown support easier to implement.

> > +
> > +     build_key(tc->td, VIRTUAL, begin, end, &virt_key);
> > +     if (bio_detain(tc->pool, &virt_key, bio, &virt_cell))
> > +             return;
> > +
> > +     process_provision_cell(tc, virt_cell);
> > +}
> > +
> >  static void process_bio(struct thin_c *tc, struct bio *bio)
> >  {
> >       struct pool *pool =3D tc->pool;
> > @@ -2202,6 +2286,8 @@ static void process_thin_deferred_bios(struct thi=
n_c *tc)
> >
> >               if (bio_op(bio) =3D=3D REQ_OP_DISCARD)
> >                       pool->process_discard(tc, bio);
> > +             else if (bio_op(bio) =3D=3D REQ_OP_PROVISION)
> > +                     process_provision_bio(tc, bio);
>
> This should be pool->process_provision() (or ->process_provision_bio
> if you like).  Point is, you need to be switching these methods
> if/when the pool_mode transitions in set_pool_mode().
>
Done

> >               else
> >                       pool->process_bio(tc, bio);
> >
> > @@ -2723,7 +2809,8 @@ static int thin_bio_map(struct dm_target *ti, str=
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
> > @@ -3370,6 +3457,8 @@ static int pool_ctr(struct dm_target *ti, unsigne=
d int argc, char **argv)
> >       pt->adjusted_pf =3D pt->requested_pf =3D pf;
> >       ti->num_flush_bios =3D 1;
> >       ti->limit_swap_bios =3D true;
> > +     ti->num_provision_bios =3D 1;
> > +     ti->provision_supported =3D true;
> >
> >       /*
> >        * Only need to enable discards if the pool should pass
> > @@ -4068,6 +4157,7 @@ static void pool_io_hints(struct dm_target *ti, s=
truct queue_limits *limits)
> >               blk_limits_io_opt(limits, pool->sectors_per_block << SECT=
OR_SHIFT);
> >       }
> >
> > +
>
> Please fix this extra whitespace damage.
>
Done

> >       /*
> >        * pt->adjusted_pf is a staging area for the actual features to u=
se.
> >        * They get transferred to the live pool in bind_control_target()
> > @@ -4261,6 +4351,9 @@ static int thin_ctr(struct dm_target *ti, unsigne=
d int argc, char **argv)
> >               ti->num_discard_bios =3D 1;
> >       }
> >
> > +     ti->num_provision_bios =3D 1;
> > +     ti->provision_supported =3D true;
> > +
> >       mutex_unlock(&dm_thin_pool_table.mutex);
> >
> >       spin_lock_irq(&tc->pool->lock);
> > @@ -4475,6 +4568,7 @@ static void thin_io_hints(struct dm_target *ti, s=
truct queue_limits *limits)
> >
> >       limits->discard_granularity =3D pool->sectors_per_block << SECTOR=
_SHIFT;
> >       limits->max_discard_sectors =3D 2048 * 1024 * 16; /* 16G */
> > +     limits->max_provision_sectors =3D 2048 * 1024 * 16; /* 16G */
>
> Building on my previous reply, with suggested update to
> dm.c:__process_abnormal_io(), once you rebase on dm-6.4's dm-thin.c
> you'll want to instead:
>
> limits->max_provision_sectors =3D pool->sectors_per_block << SECTOR_SHIFT=
;
>
> And you'll want to drop any of the above code that deals with handling
> bio-prison range locking and processing of REQ_OP_PROVISION for
> multiple thinp blocks at once.
>
> Simple REQ_OP_PROVISION processing one thinp block at a time first and
> then we can worry about handling REQ_OP_PROVISION that span blocks
> later.
>
Thanks, done in v4.

> >  static struct target_type thin_target =3D {
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index dfde0088147a..d8f1803062b7 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -1593,6 +1593,7 @@ static bool is_abnormal_io(struct bio *bio)
> >               case REQ_OP_DISCARD:
> >               case REQ_OP_SECURE_ERASE:
> >               case REQ_OP_WRITE_ZEROES:
> > +             case REQ_OP_PROVISION:
> >                       return true;
> >               default:
> >                       break;
> > @@ -1617,6 +1618,9 @@ static blk_status_t __process_abnormal_io(struct =
clone_info *ci,
> >       case REQ_OP_WRITE_ZEROES:
> >               num_bios =3D ti->num_write_zeroes_bios;
> >               break;
> > +     case REQ_OP_PROVISION:
> > +             num_bios =3D ti->num_provision_bios;
> > +             break;
> >       default:
> >               break;
> >       }
>
> Please be sure to include my suggested __process_abnormal_io change
> from my previous reply.
>
Done.

> > diff --git a/include/linux/device-mapper.h b/include/linux/device-mappe=
r.h
> > index 7975483816e4..e9f687521ae6 100644
> > --- a/include/linux/device-mapper.h
> > +++ b/include/linux/device-mapper.h
> > @@ -334,6 +334,12 @@ struct dm_target {
> >        */
> >       unsigned int num_write_zeroes_bios;
> >
> > +     /*
> > +      * The number of PROVISION bios that will be submitted to the tar=
get.
> > +      * The bio number can be accessed with dm_bio_get_target_bio_nr.
> > +      */
> > +     unsigned int num_provision_bios;
> > +
> >       /*
> >        * The minimum number of extra bytes allocated in each io for the
> >        * target to use.
> > @@ -358,6 +364,11 @@ struct dm_target {
> >        */
> >       bool discards_supported:1;
> >
> > +     /* Set if this target needs to receive provision requests regardl=
ess of
> > +      * whether or not its underlying devices have support.
> > +      */
> > +     bool provision_supported:1;
> > +
> >       /*
> >        * Set if we need to limit the number of in-flight bios when swap=
ping.
> >        */
>
> You'll need to add max_provision_granularity bool too (as implied by
> the dm.c:__process_abnormal_io() change suggested in my first reply to
> this patch).
>
> I'm happy to wait for you to consume the v3 feedback we've provided so
> you can create a v4.  I'm thinking I can base dm-thin.c's WRITE_ZEROES
> support ontop of your REQ_OP_PROVISION v4 changes -- they should be
> complementary.
>
Done. Thanks for the review and guidance!

Best
Sarthak

> Thanks,
> Mike
