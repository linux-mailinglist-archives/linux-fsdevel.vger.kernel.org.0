Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B241F6D1412
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 02:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCaAap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 20:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjCaAan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:30:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2506010251
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 17:30:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id er13so42445086edb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 17:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680222633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3r5eQncDU04l860YNWqLD6wbbCGIfGDlp9mbjOhdOU=;
        b=dQ93Wk+Ks0MpqcGc+XVhyiMMrBUMuOTlnyUdvZTqVp0bN0Nmlc332OAwEYAAl4bdOb
         rMvMFpmV/ShWfjSwJCQQlIG8eLhnJAG6GIFRRac4zR3uNqv31lS4gB+893Ba8gr7luBu
         NYPe2fAf2Jbhe561F22ak4DIq2XkXoPQMnFZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680222633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3r5eQncDU04l860YNWqLD6wbbCGIfGDlp9mbjOhdOU=;
        b=wB1lRXQKwm5RlGDltduqG/FPP/B0uDSHuTz6Zmx3rRqKoiQ2KIJ39UgisUU4sozE7q
         OsYqSVTETi90QPXCd1/wHJuXO+ZeTx71AjcHRo3q/D33F6VM4O+pIUpYPW8iQo+PkCSj
         KSCOFcdV2IcdNh/XolTj2phR91SGyyqtUeI2AaZBQcAVk8IurceSVU40O2zUBN8qSuPP
         ymo9YH+KnO74mVkdzckT0KlGqVilUPqHv8osyAgmg6na4qciFBKLqNpMH8Dd5BRXyJMB
         /XMIGfrUk12OE8xf9cMEQV/YPAHJoOjQmdc2s/gGrzEuaOumhzb6JTSfNrvBMwDtJpsH
         RXbQ==
X-Gm-Message-State: AAQBX9czRPcxCQirxbx2aThSAIppWhIpj3YxnAj0W6y6CmJgJ9j6bfJU
        eadU6nuZL5kCIB9sLJQHBoNzBpwTUXmXd4pR9n6cyJ9yKxiJFYNX
X-Google-Smtp-Source: AKy350bUrFjid7TXbTeqMBKOpuNLpzymdFUzXKXUsWM99Dh5ebCTsP5lJJEB9dpSdwE6OtCHBeIdQ5BHXLCCKNvPA98=
X-Received: by 2002:a17:907:d687:b0:93d:a14f:c9b4 with SMTP id
 wf7-20020a170907d68700b0093da14fc9b4mr12727665ejc.2.1680222633437; Thu, 30
 Mar 2023 17:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
 <20221229081252.452240-3-sarthakkukreti@chromium.org> <Y7biAQyLKJDjsAlz@bfoster>
In-Reply-To: <Y7biAQyLKJDjsAlz@bfoster>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 30 Mar 2023 17:30:22 -0700
Message-ID: <CAG9=OMNLAL8M2AqzSWzecXJzR7jfC_3Ckc_L24MzNBgz_+u-wQ@mail.gmail.com>
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

On Thu, Jan 5, 2023 at 6:42=E2=80=AFAM Brian Foster <bfoster@redhat.com> wr=
ote:
>
> On Thu, Dec 29, 2022 at 12:12:47AM -0800, Sarthak Kukreti wrote:
> > Add support to dm devices for REQ_OP_PROVISION. The default mode
> > is to pass through the request and dm-thin will utilize it to provision
> > blocks.
> >
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  drivers/md/dm-crypt.c         |  4 +-
> >  drivers/md/dm-linear.c        |  1 +
> >  drivers/md/dm-snap.c          |  7 +++
> >  drivers/md/dm-table.c         | 25 ++++++++++
> >  drivers/md/dm-thin.c          | 90 ++++++++++++++++++++++++++++++++++-
> >  drivers/md/dm.c               |  4 ++
> >  include/linux/device-mapper.h | 11 +++++
> >  7 files changed, 139 insertions(+), 3 deletions(-)
> >
> ...
> > diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> > index 64cfcf46881d..ab3f1abfabaf 100644
> > --- a/drivers/md/dm-thin.c
> > +++ b/drivers/md/dm-thin.c
> ...
> > @@ -1980,6 +1992,70 @@ static void process_cell(struct thin_c *tc, stru=
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
>
> Hi Sarthak,
>
> I think we discussed this before.. but remind me if/how we wanted to
> handle the case if the thin blocks are shared..? Would a provision op
> carry enough information to distinguish an FALLOC_FL_UNSHARE_RANGE
> request from upper layers to conditionally provision in that case?
>
I think that should depend on how the filesystem implements unsharing:
assuming that we use provision on first allocation, unsharing on xfs
should result in xfs calling REQ_OP_PROVISION on the newly allocated
blocks first. But for ext4, we'd fail UNSHARE_RANGE unless provision
(instead of noprovision, provision_on_alloc), in which case, we'd send
REQ_OP_PROVISION.

Best
Sarthak


Sarthak

> Brian
>
> > +             switch (r) {
> > +             case 0:
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
> > @@ -2200,6 +2276,8 @@ static void process_thin_deferred_bios(struct thi=
n_c *tc)
> >
> >               if (bio_op(bio) =3D=3D REQ_OP_DISCARD)
> >                       pool->process_discard(tc, bio);
> > +             else if (bio_op(bio) =3D=3D REQ_OP_PROVISION)
> > +                     process_provision_bio(tc, bio);
> >               else
> >                       pool->process_bio(tc, bio);
> >
> > @@ -2716,7 +2794,8 @@ static int thin_bio_map(struct dm_target *ti, str=
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
> > @@ -3355,6 +3434,8 @@ static int pool_ctr(struct dm_target *ti, unsigne=
d argc, char **argv)
> >       pt->low_water_blocks =3D low_water_blocks;
> >       pt->adjusted_pf =3D pt->requested_pf =3D pf;
> >       ti->num_flush_bios =3D 1;
> > +     ti->num_provision_bios =3D 1;
> > +     ti->provision_supported =3D true;
> >
> >       /*
> >        * Only need to enable discards if the pool should pass
> > @@ -4053,6 +4134,7 @@ static void pool_io_hints(struct dm_target *ti, s=
truct queue_limits *limits)
> >               blk_limits_io_opt(limits, pool->sectors_per_block << SECT=
OR_SHIFT);
> >       }
> >
> > +
> >       /*
> >        * pt->adjusted_pf is a staging area for the actual features to u=
se.
> >        * They get transferred to the live pool in bind_control_target()
> > @@ -4243,6 +4325,9 @@ static int thin_ctr(struct dm_target *ti, unsigne=
d argc, char **argv)
> >               ti->num_discard_bios =3D 1;
> >       }
> >
> > +     ti->num_provision_bios =3D 1;
> > +     ti->provision_supported =3D true;
> > +
> >       mutex_unlock(&dm_thin_pool_table.mutex);
> >
> >       spin_lock_irq(&tc->pool->lock);
> > @@ -4457,6 +4542,7 @@ static void thin_io_hints(struct dm_target *ti, s=
truct queue_limits *limits)
> >
> >       limits->discard_granularity =3D pool->sectors_per_block << SECTOR=
_SHIFT;
> >       limits->max_discard_sectors =3D 2048 * 1024 * 16; /* 16G */
> > +     limits->max_provision_sectors =3D 2048 * 1024 * 16; /* 16G */
> >  }
> >
> >  static struct target_type thin_target =3D {
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index e1ea3a7bd9d9..4d19bae9da4a 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -1587,6 +1587,7 @@ static bool is_abnormal_io(struct bio *bio)
> >               case REQ_OP_DISCARD:
> >               case REQ_OP_SECURE_ERASE:
> >               case REQ_OP_WRITE_ZEROES:
> > +             case REQ_OP_PROVISION:
> >                       return true;
> >               default:
> >                       break;
> > @@ -1611,6 +1612,9 @@ static blk_status_t __process_abnormal_io(struct =
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
> > diff --git a/include/linux/device-mapper.h b/include/linux/device-mappe=
r.h
> > index 04c6acf7faaa..b4d97d5d75b8 100644
> > --- a/include/linux/device-mapper.h
> > +++ b/include/linux/device-mapper.h
> > @@ -333,6 +333,12 @@ struct dm_target {
> >        */
> >       unsigned num_write_zeroes_bios;
> >
> > +     /*
> > +      * The number of PROVISION bios that will be submitted to the tar=
get.
> > +      * The bio number can be accessed with dm_bio_get_target_bio_nr.
> > +      */
> > +     unsigned num_provision_bios;
> > +
> >       /*
> >        * The minimum number of extra bytes allocated in each io for the
> >        * target to use.
> > @@ -357,6 +363,11 @@ struct dm_target {
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
> > --
> > 2.37.3
> >
>
