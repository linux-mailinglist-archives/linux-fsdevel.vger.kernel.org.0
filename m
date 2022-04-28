Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A18A513AFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 19:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350555AbiD1Rhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 13:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiD1Rhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:37:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69746833E;
        Thu, 28 Apr 2022 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CU5vNoZ2DyJnMSSsv6FKJaOR1+kQZIFv71gVo+f6jqA=; b=jYC4utzF59Rb/tKOmYemaP/wEU
        wlAwR2UrulKrgeXbx+/XQ0gpzYVB7MUifsOGD3Z+QGWNETWT18yE5kxNH6g2tCGUTKNaxu1V30mKc
        HHjpH4ZhdAywtV6L7pe/Qu39s3KZVt54yTBL6LMkSFs6tLRz0hCHoUOsJXrpicBzyVRiQjcPIeLEC
        AxX8KkaoM3BJvxEU3MgDQpBsZuHWf2imtywFQtsSoT5sbDHlYNiv/lCJP+6BbHnma14GU45TN1sqe
        PMDDVUElH/4aFK31a21gZCcTDUSyuvKpWrTHUE7MO9NPsBNFg7Fn3rbVi7b1zjNlhgIS/VVnNw8fq
        TAus3vPA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk81u-0083c3-7l; Thu, 28 Apr 2022 17:34:14 +0000
Date:   Thu, 28 Apr 2022 10:34:14 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
        axboe@kernel.dk, snitzer@kernel.org, hch@lst.de,
        naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        johannes.thumshirn@wdc.com, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, clm@fb.com, gost.dev@samsung.com,
        chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        josef@toxicpanda.com, jonathan.derrick@linux.dev, agk@redhat.com,
        kbusch@kernel.org, kch@nvidia.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, bvanassche@acm.org, jiangbo.365@bytedance.com,
        linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 16/16] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Message-ID: <YmrQFu9EbMmrL2Ys@bombadil.infradead.org>
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160313eucas1p1feecf74ec15c8c3d9250444710fd1676@eucas1p1.samsung.com>
 <20220427160255.300418-17-p.raghav@samsung.com>
 <2ffc46c7-945f-ba26-90db-737fccd74fdf@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ffc46c7-945f-ba26-90db-737fccd74fdf@opensource.wdc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 08:42:41AM +0900, Damien Le Moal wrote:
> On 4/28/22 01:02, Pankaj Raghav wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > Today dm-zoned relies on the assumption that you have a zone size
> > with a power of 2. Even though the block layer today enforces this
> > requirement, these devices do exist and so provide a stop-gap measure
> > to ensure these devices cannot be used by mistake
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >  drivers/md/dm-zone.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> > index 57daa86c19cf..221e0aa0f1a7 100644
> > --- a/drivers/md/dm-zone.c
> > +++ b/drivers/md/dm-zone.c
> > @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
> >  	struct request_queue *q = md->queue;
> >  	unsigned int noio_flag;
> >  	int ret;
> > +	struct block_device *bdev = md->disk->part0;
> > +	sector_t zone_sectors;
> > +	char bname[BDEVNAME_SIZE];
> > +
> > +	zone_sectors = bdev_zone_sectors(bdev);
> > +
> > +	if (!is_power_of_2(zone_sectors)) {
> > +		DMWARN("%s: %s only power of two zone size supported\n",
> > +		       dm_device_name(md),
> > +		       bdevname(bdev, bname));
> > +		return 1;
> > +	}
> 
> Why ?
> 
> See my previous email about still allowing ZC < ZS for non power of 2 zone
> size drives. dm-zoned can easily support non power of 2 zone size as long
> as ZC == ZS for all zones.

Great, thanks for the heads up.

> The problem with dm-zoned is ZC < ZS *AND* potentially variable ZC per
> zone. That cannot be supported easily (still not impossible, but
> definitely a lot more complex).

I see thanks.

Testing would still be required to ensure this all works well with npo2.
So I'd prefer to do that as a separate effort, even if it is easy. So
for now I think it makes sense to avoid this as this is not yet well
tested.

As with filesystem support, we've even have gotten hints that support
for npo2 should be easy, but without proper testing it would not be
prudent to enable support for users yet.

One step at a time.

  Luis
