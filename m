Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBC86D5500
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 00:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjDCW51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 18:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjDCW50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:57:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341E8170D
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 15:57:24 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y4so123502453edo.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 15:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680562642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNQNHEmyxWKm570ezYESleHypk8TjPfYsCf01llgY1E=;
        b=YZMXl6HZpBFkK69HxALQ7LA0GcIzQxO+oxSrRlChPUnularuOQlzYizTdFKd8zbW/8
         4CVmgjvUboiGywJcL7luFa82xvVPYnz9Sn0I9fMLtpcE6UKa+WDCIp3PFn6kJGTf4E4C
         92u1WER03J780X/cN8/5CkoYeSKdYCx7tEzsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680562642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNQNHEmyxWKm570ezYESleHypk8TjPfYsCf01llgY1E=;
        b=XJpswvu6E5KdLEG4O5LqIMkXROVsSMiYAlg4K3L8I7VVTZdDb8psNSXgrwrG+O7vJE
         tVSViqREtyjyq+5B8b603H04AQWOsSrMV4bqH3r6FWImcaRVrn29K9/Nx+rIyv401FG5
         FE7Vy4zbHgFI9v/+qMbQk2t5uwTa/Ssyj1o4rzbtD/6G0eudM+VyJGhPUB3OWny0HgA8
         Xe2KN1Gg4/IVpLRWrn2j1IR7UJf+DqS5rbbOGGo8qs+blyOUfHtQ2F516P0xGUVNqXeL
         Jv68kAzUp1QobUWiE2mFUz/VoKgqUkYtH6FgDyEdZRVolu69jNabgPQwmpW9kTSrA4my
         /B1w==
X-Gm-Message-State: AAQBX9cG2fT3ZGlvxCZXRF7sqUCQXgQFnXN9jKMbMeAa20EVlMpB6veE
        J2/TsslbFM8N/y/VhSBcTpRcXSr+OF9xcRfOO7T5ig==
X-Google-Smtp-Source: AKy350ao2Y0z8CpV79IpYns3sYFnAYql88bE6K8ADZnpZfXRr8sA9XZZYmJgi9xahsU6f2Xyn8JJh7ATYaoK/WVvgJY=
X-Received: by 2002:a17:906:9f28:b0:934:b5d6:14d0 with SMTP id
 fy40-20020a1709069f2800b00934b5d614d0mr194797ejc.2.1680562642663; Mon, 03 Apr
 2023 15:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
 <20221229081252.452240-3-sarthakkukreti@chromium.org> <Y7biAQyLKJDjsAlz@bfoster>
 <CAG9=OMNLAL8M2AqzSWzecXJzR7jfC_3Ckc_L24MzNBgz_+u-wQ@mail.gmail.com> <ZCbR4euMpUauJ0iI@bfoster>
In-Reply-To: <ZCbR4euMpUauJ0iI@bfoster>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Mon, 3 Apr 2023 15:57:11 -0700
Message-ID: <CAG9=OMNT8c=Pkzd-Nw99R32i5VjYtyQsscY0huJFg3EbtRJ5BQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dm: Add support for block provisioning
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
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 31, 2023 at 5:26=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Thu, Mar 30, 2023 at 05:30:22PM -0700, Sarthak Kukreti wrote:
> > On Thu, Jan 5, 2023 at 6:42=E2=80=AFAM Brian Foster <bfoster@redhat.com=
> wrote:
> > >
> > > On Thu, Dec 29, 2022 at 12:12:47AM -0800, Sarthak Kukreti wrote:
> > > > Add support to dm devices for REQ_OP_PROVISION. The default mode
> > > > is to pass through the request and dm-thin will utilize it to provi=
sion
> > > > blocks.
> > > >
> > > > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > > ---
> > > >  drivers/md/dm-crypt.c         |  4 +-
> > > >  drivers/md/dm-linear.c        |  1 +
> > > >  drivers/md/dm-snap.c          |  7 +++
> > > >  drivers/md/dm-table.c         | 25 ++++++++++
> > > >  drivers/md/dm-thin.c          | 90 +++++++++++++++++++++++++++++++=
+++-
> > > >  drivers/md/dm.c               |  4 ++
> > > >  include/linux/device-mapper.h | 11 +++++
> > > >  7 files changed, 139 insertions(+), 3 deletions(-)
> > > >
> > > ...
> > > > diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> > > > index 64cfcf46881d..ab3f1abfabaf 100644
> > > > --- a/drivers/md/dm-thin.c
> > > > +++ b/drivers/md/dm-thin.c
> > > ...
> > > > @@ -1980,6 +1992,70 @@ static void process_cell(struct thin_c *tc, =
struct dm_bio_prison_cell *cell)
> > > >       }
> > > >  }
> > > >
> > > > +static void process_provision_cell(struct thin_c *tc, struct dm_bi=
o_prison_cell *cell)
> > > > +{
> > > > +     int r;
> > > > +     struct pool *pool =3D tc->pool;
> > > > +     struct bio *bio =3D cell->holder;
> > > > +     dm_block_t begin, end;
> > > > +     struct dm_thin_lookup_result lookup_result;
> > > > +
> > > > +     if (tc->requeue_mode) {
> > > > +             cell_requeue(pool, cell);
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     get_bio_block_range(tc, bio, &begin, &end);
> > > > +
> > > > +     while (begin !=3D end) {
> > > > +             r =3D ensure_next_mapping(pool);
> > > > +             if (r)
> > > > +                     /* we did our best */
> > > > +                     return;
> > > > +
> > > > +             r =3D dm_thin_find_block(tc->td, begin, 1, &lookup_re=
sult);
> > >
> > > Hi Sarthak,
> > >
> > > I think we discussed this before.. but remind me if/how we wanted to
> > > handle the case if the thin blocks are shared..? Would a provision op
> > > carry enough information to distinguish an FALLOC_FL_UNSHARE_RANGE
> > > request from upper layers to conditionally provision in that case?
> > >
> > I think that should depend on how the filesystem implements unsharing:
> > assuming that we use provision on first allocation, unsharing on xfs
> > should result in xfs calling REQ_OP_PROVISION on the newly allocated
> > blocks first. But for ext4, we'd fail UNSHARE_RANGE unless provision
> > (instead of noprovision, provision_on_alloc), in which case, we'd send
> > REQ_OP_PROVISION.
> >
>
> I think my question was unclear... It doesn't necessarily have much to
> do with the filesystem or associated provision policy. Since dm-thin can
> share blocks internally via snapshots, do you intend to support
> FL_UNSHARE_RANGE via blkdev_fallocate() and REQ_OP_PROVISION?
>
> If so, then presumably this wants an UNSHARE request flag to pair with
> REQ_OP_PROVISION. Also, the dm-thin code above needs to check whether an
> existing block it finds is shared and basically do whatever COW breaking
> is necessary during the PROVISION request.
>
> If not, why? And what is expected behavior if blkdev_fallocate() is
> called with FL_UNSHARE_RANGE?
>
I think the handling of REQ_OP_PROVISION by each snapshot target is
kind-of implicit:

- snapshot-origin: do nothing
- snapshot: send REQ_OP_PROVISION to the COW device
- snapshot-merge: send REQ_OP_PROVISION to the origin.

From the thinpool's perspective, REQ_OP_PROVISION reuses the
provision_block() primitive to break sharing (there's a bug in the
below code, as you pointed out: case 0 should also call
provision_block() if the lookup result shows that this is a shared
block).

So, I think the provision op would carry enough information to
conditionally provision and copy the block. Are there other cases
where UNSHARE_RANGE would be useful?

Best
Sarthak

> Brian
>
> > Best
> > Sarthak
> >
> >
> > Sarthak
> >
> > > Brian
> > >
> > > > +             switch (r) {
> > > > +             case 0:
> > > > +                     begin++;
> > > > +                     break;
> > > > +             case -ENODATA:
> > > > +                     bio_inc_remaining(bio);
> > > > +                     provision_block(tc, bio, begin, cell);
> > > > +                     begin++;
> > > > +                     break;
> > > > +             default:
> > > > +                     DMERR_LIMIT(
> > > > +                             "%s: dm_thin_find_block() failed: err=
or =3D %d",
> > > > +                             __func__, r);
> > > > +                     cell_defer_no_holder(tc, cell);
> > > > +                     bio_io_error(bio);
> > > > +                     begin++;
> > > > +                     break;
> > > > +             }
> > > > +     }
> > > > +     bio_endio(bio);
> > > > +     cell_defer_no_holder(tc, cell);
> > > > +}
> > > > +
> > > > +static void process_provision_bio(struct thin_c *tc, struct bio *b=
io)
> > > > +{
> > > > +     dm_block_t begin, end;
> > > > +     struct dm_cell_key virt_key;
> > > > +     struct dm_bio_prison_cell *virt_cell;
> > > > +
> > > > +     get_bio_block_range(tc, bio, &begin, &end);
> > > > +     if (begin =3D=3D end) {
> > > > +             bio_endio(bio);
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     build_key(tc->td, VIRTUAL, begin, end, &virt_key);
> > > > +     if (bio_detain(tc->pool, &virt_key, bio, &virt_cell))
> > > > +             return;
> > > > +
> > > > +     process_provision_cell(tc, virt_cell);
> > > > +}
> > > > +
> > > >  static void process_bio(struct thin_c *tc, struct bio *bio)
> > > >  {
> > > >       struct pool *pool =3D tc->pool;
> > > > @@ -2200,6 +2276,8 @@ static void process_thin_deferred_bios(struct=
 thin_c *tc)
> > > >
> > > >               if (bio_op(bio) =3D=3D REQ_OP_DISCARD)
> > > >                       pool->process_discard(tc, bio);
> > > > +             else if (bio_op(bio) =3D=3D REQ_OP_PROVISION)
> > > > +                     process_provision_bio(tc, bio);
> > > >               else
> > > >                       pool->process_bio(tc, bio);
> > > >
> > > > @@ -2716,7 +2794,8 @@ static int thin_bio_map(struct dm_target *ti,=
 struct bio *bio)
> > > >               return DM_MAPIO_SUBMITTED;
> > > >       }
> > > >
> > > > -     if (op_is_flush(bio->bi_opf) || bio_op(bio) =3D=3D REQ_OP_DIS=
CARD) {
> > > > +     if (op_is_flush(bio->bi_opf) || bio_op(bio) =3D=3D REQ_OP_DIS=
CARD ||
> > > > +         bio_op(bio) =3D=3D REQ_OP_PROVISION) {
> > > >               thin_defer_bio_with_throttle(tc, bio);
> > > >               return DM_MAPIO_SUBMITTED;
> > > >       }
> > > > @@ -3355,6 +3434,8 @@ static int pool_ctr(struct dm_target *ti, uns=
igned argc, char **argv)
> > > >       pt->low_water_blocks =3D low_water_blocks;
> > > >       pt->adjusted_pf =3D pt->requested_pf =3D pf;
> > > >       ti->num_flush_bios =3D 1;
> > > > +     ti->num_provision_bios =3D 1;
> > > > +     ti->provision_supported =3D true;
> > > >
> > > >       /*
> > > >        * Only need to enable discards if the pool should pass
> > > > @@ -4053,6 +4134,7 @@ static void pool_io_hints(struct dm_target *t=
i, struct queue_limits *limits)
> > > >               blk_limits_io_opt(limits, pool->sectors_per_block << =
SECTOR_SHIFT);
> > > >       }
> > > >
> > > > +
> > > >       /*
> > > >        * pt->adjusted_pf is a staging area for the actual features =
to use.
> > > >        * They get transferred to the live pool in bind_control_targ=
et()
> > > > @@ -4243,6 +4325,9 @@ static int thin_ctr(struct dm_target *ti, uns=
igned argc, char **argv)
> > > >               ti->num_discard_bios =3D 1;
> > > >       }
> > > >
> > > > +     ti->num_provision_bios =3D 1;
> > > > +     ti->provision_supported =3D true;
> > > > +
> > > >       mutex_unlock(&dm_thin_pool_table.mutex);
> > > >
> > > >       spin_lock_irq(&tc->pool->lock);
> > > > @@ -4457,6 +4542,7 @@ static void thin_io_hints(struct dm_target *t=
i, struct queue_limits *limits)
> > > >
> > > >       limits->discard_granularity =3D pool->sectors_per_block << SE=
CTOR_SHIFT;
> > > >       limits->max_discard_sectors =3D 2048 * 1024 * 16; /* 16G */
> > > > +     limits->max_provision_sectors =3D 2048 * 1024 * 16; /* 16G */
> > > >  }
> > > >
> > > >  static struct target_type thin_target =3D {
> > > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > > index e1ea3a7bd9d9..4d19bae9da4a 100644
> > > > --- a/drivers/md/dm.c
> > > > +++ b/drivers/md/dm.c
> > > > @@ -1587,6 +1587,7 @@ static bool is_abnormal_io(struct bio *bio)
> > > >               case REQ_OP_DISCARD:
> > > >               case REQ_OP_SECURE_ERASE:
> > > >               case REQ_OP_WRITE_ZEROES:
> > > > +             case REQ_OP_PROVISION:
> > > >                       return true;
> > > >               default:
> > > >                       break;
> > > > @@ -1611,6 +1612,9 @@ static blk_status_t __process_abnormal_io(str=
uct clone_info *ci,
> > > >       case REQ_OP_WRITE_ZEROES:
> > > >               num_bios =3D ti->num_write_zeroes_bios;
> > > >               break;
> > > > +     case REQ_OP_PROVISION:
> > > > +             num_bios =3D ti->num_provision_bios;
> > > > +             break;
> > > >       default:
> > > >               break;
> > > >       }
> > > > diff --git a/include/linux/device-mapper.h b/include/linux/device-m=
apper.h
> > > > index 04c6acf7faaa..b4d97d5d75b8 100644
> > > > --- a/include/linux/device-mapper.h
> > > > +++ b/include/linux/device-mapper.h
> > > > @@ -333,6 +333,12 @@ struct dm_target {
> > > >        */
> > > >       unsigned num_write_zeroes_bios;
> > > >
> > > > +     /*
> > > > +      * The number of PROVISION bios that will be submitted to the=
 target.
> > > > +      * The bio number can be accessed with dm_bio_get_target_bio_=
nr.
> > > > +      */
> > > > +     unsigned num_provision_bios;
> > > > +
> > > >       /*
> > > >        * The minimum number of extra bytes allocated in each io for=
 the
> > > >        * target to use.
> > > > @@ -357,6 +363,11 @@ struct dm_target {
> > > >        */
> > > >       bool discards_supported:1;
> > > >
> > > > +     /* Set if this target needs to receive provision requests reg=
ardless of
> > > > +      * whether or not its underlying devices have support.
> > > > +      */
> > > > +     bool provision_supported:1;
> > > > +
> > > >       /*
> > > >        * Set if we need to limit the number of in-flight bios when =
swapping.
> > > >        */
> > > > --
> > > > 2.37.3
> > > >
> > >
> >
>
