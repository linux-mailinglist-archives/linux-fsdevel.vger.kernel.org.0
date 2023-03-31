Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054BC6D203B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 14:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjCaM1L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 08:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjCaM1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE61EFD3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 05:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680265580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DH2TEGtbu6b5LqxnMSb70uBmRZl7fmkRGu9vSpf9xqk=;
        b=i8/ZevfIEEKjY49zjeVNPUASff5cam28/XNkCdvGDevIjNfKZxpivbkUHA0pK20JhV2ohW
        XbdfNR8GrBLxVnXn3lKaql2d8jX8GMxaeIbvtNu8Z2d1HmRHlpceXqVjYfUtDQUVkoppAS
        wmOLUyLPZQdWOGbOxQgG3kz/hJRBjQs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-i6F6AQt3MZuKUCadYxIXjA-1; Fri, 31 Mar 2023 08:26:19 -0400
X-MC-Unique: i6F6AQt3MZuKUCadYxIXjA-1
Received: by mail-qk1-f200.google.com with SMTP id d72-20020ae9ef4b000000b007467a30076fso10358824qkg.18
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 05:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680265579;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DH2TEGtbu6b5LqxnMSb70uBmRZl7fmkRGu9vSpf9xqk=;
        b=wfjyXHZPJID8Vwt2hL5FwDXGmr8UpEv34SbFncD5MEtuzDbzVB71m4PmTJc5bCt/cQ
         1DhgYmb9Po7sFNDF47K0d9gM3Ch6eWe2pAy+SfD4uiIXgNV7Ww05LiwoCG9poIufDAl8
         /ezAoREs/A+VE1yeAtR+wFuYYozifbIoyCTGgkr9g3QHsBDrEdweiKdD/XnvKJ9QrqCP
         Qb8nqCy6INMHukLSDyPX5eCO0hx8JjnAm/aM38q/rxHQ58rBWXPyGwilLBstSSZnubA3
         Ph9UasFYmfLmI1lE+MhaXhQnydSW6YyaOKoh44pZNIWRGD3QFf/JDe3vpB5FilmrxS6r
         YMUw==
X-Gm-Message-State: AAQBX9cFhgp6KBkofy/6CcrK8KgsnMo1HXuXwuWpVLNf+/HsrXaq/o50
        pBj0wMfs6hgsrf7dp+iAVdinNXy47begIJwkoGHYPzw7+Fi+zNsUqVc2nQp032JnQvTejOKIHCT
        M/4N+splvwQnazlPiRrzu3/tyTTkAT35C9w==
X-Received: by 2002:ad4:5dc9:0:b0:5ac:fb9a:677f with SMTP id m9-20020ad45dc9000000b005acfb9a677fmr34608101qvh.34.1680265578981;
        Fri, 31 Mar 2023 05:26:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z6rYxqMC+gfIXFXxm8RLwpDPGgPB876v8cq7C6XuwWCma4+tnHWKvrv1GKg+lUyow88OEGQA==
X-Received: by 2002:ad4:5dc9:0:b0:5ac:fb9a:677f with SMTP id m9-20020ad45dc9000000b005acfb9a677fmr34608064qvh.34.1680265578627;
        Fri, 31 Mar 2023 05:26:18 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id s11-20020a05621412cb00b005dd8b9345efsm536061qvv.135.2023.03.31.05.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 05:26:18 -0700 (PDT)
Date:   Fri, 31 Mar 2023 08:28:17 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
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
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 2/7] dm: Add support for block provisioning
Message-ID: <ZCbR4euMpUauJ0iI@bfoster>
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
 <20221229081252.452240-3-sarthakkukreti@chromium.org>
 <Y7biAQyLKJDjsAlz@bfoster>
 <CAG9=OMNLAL8M2AqzSWzecXJzR7jfC_3Ckc_L24MzNBgz_+u-wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9=OMNLAL8M2AqzSWzecXJzR7jfC_3Ckc_L24MzNBgz_+u-wQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 05:30:22PM -0700, Sarthak Kukreti wrote:
> On Thu, Jan 5, 2023 at 6:42 AM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Thu, Dec 29, 2022 at 12:12:47AM -0800, Sarthak Kukreti wrote:
> > > Add support to dm devices for REQ_OP_PROVISION. The default mode
> > > is to pass through the request and dm-thin will utilize it to provision
> > > blocks.
> > >
> > > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > ---
> > >  drivers/md/dm-crypt.c         |  4 +-
> > >  drivers/md/dm-linear.c        |  1 +
> > >  drivers/md/dm-snap.c          |  7 +++
> > >  drivers/md/dm-table.c         | 25 ++++++++++
> > >  drivers/md/dm-thin.c          | 90 ++++++++++++++++++++++++++++++++++-
> > >  drivers/md/dm.c               |  4 ++
> > >  include/linux/device-mapper.h | 11 +++++
> > >  7 files changed, 139 insertions(+), 3 deletions(-)
> > >
> > ...
> > > diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> > > index 64cfcf46881d..ab3f1abfabaf 100644
> > > --- a/drivers/md/dm-thin.c
> > > +++ b/drivers/md/dm-thin.c
> > ...
> > > @@ -1980,6 +1992,70 @@ static void process_cell(struct thin_c *tc, struct dm_bio_prison_cell *cell)
> > >       }
> > >  }
> > >
> > > +static void process_provision_cell(struct thin_c *tc, struct dm_bio_prison_cell *cell)
> > > +{
> > > +     int r;
> > > +     struct pool *pool = tc->pool;
> > > +     struct bio *bio = cell->holder;
> > > +     dm_block_t begin, end;
> > > +     struct dm_thin_lookup_result lookup_result;
> > > +
> > > +     if (tc->requeue_mode) {
> > > +             cell_requeue(pool, cell);
> > > +             return;
> > > +     }
> > > +
> > > +     get_bio_block_range(tc, bio, &begin, &end);
> > > +
> > > +     while (begin != end) {
> > > +             r = ensure_next_mapping(pool);
> > > +             if (r)
> > > +                     /* we did our best */
> > > +                     return;
> > > +
> > > +             r = dm_thin_find_block(tc->td, begin, 1, &lookup_result);
> >
> > Hi Sarthak,
> >
> > I think we discussed this before.. but remind me if/how we wanted to
> > handle the case if the thin blocks are shared..? Would a provision op
> > carry enough information to distinguish an FALLOC_FL_UNSHARE_RANGE
> > request from upper layers to conditionally provision in that case?
> >
> I think that should depend on how the filesystem implements unsharing:
> assuming that we use provision on first allocation, unsharing on xfs
> should result in xfs calling REQ_OP_PROVISION on the newly allocated
> blocks first. But for ext4, we'd fail UNSHARE_RANGE unless provision
> (instead of noprovision, provision_on_alloc), in which case, we'd send
> REQ_OP_PROVISION.
> 

I think my question was unclear... It doesn't necessarily have much to
do with the filesystem or associated provision policy. Since dm-thin can
share blocks internally via snapshots, do you intend to support
FL_UNSHARE_RANGE via blkdev_fallocate() and REQ_OP_PROVISION?

If so, then presumably this wants an UNSHARE request flag to pair with
REQ_OP_PROVISION. Also, the dm-thin code above needs to check whether an
existing block it finds is shared and basically do whatever COW breaking
is necessary during the PROVISION request.

If not, why? And what is expected behavior if blkdev_fallocate() is
called with FL_UNSHARE_RANGE?

Brian 

> Best
> Sarthak
> 
> 
> Sarthak
> 
> > Brian
> >
> > > +             switch (r) {
> > > +             case 0:
> > > +                     begin++;
> > > +                     break;
> > > +             case -ENODATA:
> > > +                     bio_inc_remaining(bio);
> > > +                     provision_block(tc, bio, begin, cell);
> > > +                     begin++;
> > > +                     break;
> > > +             default:
> > > +                     DMERR_LIMIT(
> > > +                             "%s: dm_thin_find_block() failed: error = %d",
> > > +                             __func__, r);
> > > +                     cell_defer_no_holder(tc, cell);
> > > +                     bio_io_error(bio);
> > > +                     begin++;
> > > +                     break;
> > > +             }
> > > +     }
> > > +     bio_endio(bio);
> > > +     cell_defer_no_holder(tc, cell);
> > > +}
> > > +
> > > +static void process_provision_bio(struct thin_c *tc, struct bio *bio)
> > > +{
> > > +     dm_block_t begin, end;
> > > +     struct dm_cell_key virt_key;
> > > +     struct dm_bio_prison_cell *virt_cell;
> > > +
> > > +     get_bio_block_range(tc, bio, &begin, &end);
> > > +     if (begin == end) {
> > > +             bio_endio(bio);
> > > +             return;
> > > +     }
> > > +
> > > +     build_key(tc->td, VIRTUAL, begin, end, &virt_key);
> > > +     if (bio_detain(tc->pool, &virt_key, bio, &virt_cell))
> > > +             return;
> > > +
> > > +     process_provision_cell(tc, virt_cell);
> > > +}
> > > +
> > >  static void process_bio(struct thin_c *tc, struct bio *bio)
> > >  {
> > >       struct pool *pool = tc->pool;
> > > @@ -2200,6 +2276,8 @@ static void process_thin_deferred_bios(struct thin_c *tc)
> > >
> > >               if (bio_op(bio) == REQ_OP_DISCARD)
> > >                       pool->process_discard(tc, bio);
> > > +             else if (bio_op(bio) == REQ_OP_PROVISION)
> > > +                     process_provision_bio(tc, bio);
> > >               else
> > >                       pool->process_bio(tc, bio);
> > >
> > > @@ -2716,7 +2794,8 @@ static int thin_bio_map(struct dm_target *ti, struct bio *bio)
> > >               return DM_MAPIO_SUBMITTED;
> > >       }
> > >
> > > -     if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD) {
> > > +     if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD ||
> > > +         bio_op(bio) == REQ_OP_PROVISION) {
> > >               thin_defer_bio_with_throttle(tc, bio);
> > >               return DM_MAPIO_SUBMITTED;
> > >       }
> > > @@ -3355,6 +3434,8 @@ static int pool_ctr(struct dm_target *ti, unsigned argc, char **argv)
> > >       pt->low_water_blocks = low_water_blocks;
> > >       pt->adjusted_pf = pt->requested_pf = pf;
> > >       ti->num_flush_bios = 1;
> > > +     ti->num_provision_bios = 1;
> > > +     ti->provision_supported = true;
> > >
> > >       /*
> > >        * Only need to enable discards if the pool should pass
> > > @@ -4053,6 +4134,7 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
> > >               blk_limits_io_opt(limits, pool->sectors_per_block << SECTOR_SHIFT);
> > >       }
> > >
> > > +
> > >       /*
> > >        * pt->adjusted_pf is a staging area for the actual features to use.
> > >        * They get transferred to the live pool in bind_control_target()
> > > @@ -4243,6 +4325,9 @@ static int thin_ctr(struct dm_target *ti, unsigned argc, char **argv)
> > >               ti->num_discard_bios = 1;
> > >       }
> > >
> > > +     ti->num_provision_bios = 1;
> > > +     ti->provision_supported = true;
> > > +
> > >       mutex_unlock(&dm_thin_pool_table.mutex);
> > >
> > >       spin_lock_irq(&tc->pool->lock);
> > > @@ -4457,6 +4542,7 @@ static void thin_io_hints(struct dm_target *ti, struct queue_limits *limits)
> > >
> > >       limits->discard_granularity = pool->sectors_per_block << SECTOR_SHIFT;
> > >       limits->max_discard_sectors = 2048 * 1024 * 16; /* 16G */
> > > +     limits->max_provision_sectors = 2048 * 1024 * 16; /* 16G */
> > >  }
> > >
> > >  static struct target_type thin_target = {
> > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > index e1ea3a7bd9d9..4d19bae9da4a 100644
> > > --- a/drivers/md/dm.c
> > > +++ b/drivers/md/dm.c
> > > @@ -1587,6 +1587,7 @@ static bool is_abnormal_io(struct bio *bio)
> > >               case REQ_OP_DISCARD:
> > >               case REQ_OP_SECURE_ERASE:
> > >               case REQ_OP_WRITE_ZEROES:
> > > +             case REQ_OP_PROVISION:
> > >                       return true;
> > >               default:
> > >                       break;
> > > @@ -1611,6 +1612,9 @@ static blk_status_t __process_abnormal_io(struct clone_info *ci,
> > >       case REQ_OP_WRITE_ZEROES:
> > >               num_bios = ti->num_write_zeroes_bios;
> > >               break;
> > > +     case REQ_OP_PROVISION:
> > > +             num_bios = ti->num_provision_bios;
> > > +             break;
> > >       default:
> > >               break;
> > >       }
> > > diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> > > index 04c6acf7faaa..b4d97d5d75b8 100644
> > > --- a/include/linux/device-mapper.h
> > > +++ b/include/linux/device-mapper.h
> > > @@ -333,6 +333,12 @@ struct dm_target {
> > >        */
> > >       unsigned num_write_zeroes_bios;
> > >
> > > +     /*
> > > +      * The number of PROVISION bios that will be submitted to the target.
> > > +      * The bio number can be accessed with dm_bio_get_target_bio_nr.
> > > +      */
> > > +     unsigned num_provision_bios;
> > > +
> > >       /*
> > >        * The minimum number of extra bytes allocated in each io for the
> > >        * target to use.
> > > @@ -357,6 +363,11 @@ struct dm_target {
> > >        */
> > >       bool discards_supported:1;
> > >
> > > +     /* Set if this target needs to receive provision requests regardless of
> > > +      * whether or not its underlying devices have support.
> > > +      */
> > > +     bool provision_supported:1;
> > > +
> > >       /*
> > >        * Set if we need to limit the number of in-flight bios when swapping.
> > >        */
> > > --
> > > 2.37.3
> > >
> >
> 

