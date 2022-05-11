Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9822E52380C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 18:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344304AbiEKQEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 12:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344273AbiEKQEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 12:04:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23011A15D4;
        Wed, 11 May 2022 09:04:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CBA4A1F460;
        Wed, 11 May 2022 16:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652285057;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xc6b2DGSHNoqcRaRJAmNz3xmM8+5hVjJ6d9Uf3kedYI=;
        b=AptAfNQUACxbGuDofIFikwhqSmZLKp4LaZkHv0nu5pVn6UGKlHaoJuH95JxLwf223Z+HIf
        R8aoLP+L+YwysdX0gx8806E5IouENUnMmezge+u6h42ZR1TitVwdwkQ25tBBdHfU4gLBzg
        bPkaIp0vtR6+ExEinYmIQH18c7X68Oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652285057;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xc6b2DGSHNoqcRaRJAmNz3xmM8+5hVjJ6d9Uf3kedYI=;
        b=XqXkW74F8Zok5rdnrEAgPSVAz1K4bzmN0oplvOFkQ34V3VduS2lJo/LPWmHvXSFvI7IzbV
        VI5pIiFWh6KxVkAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D07B13A76;
        Wed, 11 May 2022 16:04:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ton9CYHee2KSRQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 11 May 2022 16:04:17 +0000
Date:   Wed, 11 May 2022 18:00:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     dsterba@suse.cz, jaegeuk@kernel.org, hare@suse.de,
        dsterba@suse.com, axboe@kernel.dk, hch@lst.de,
        damien.lemoal@opensource.wdc.com, snitzer@kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        bvanassche@acm.org, linux-fsdevel@vger.kernel.org,
        matias.bjorling@wdc.com, Jens Axboe <axboe@fb.com>,
        gost.dev@samsung.com, jonathan.derrick@linux.dev,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alasdair Kergon <agk@redhat.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v3 11/11] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Message-ID: <20220511160001.GQ18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pankaj Raghav <p.raghav@samsung.com>,
        jaegeuk@kernel.org, hare@suse.de, dsterba@suse.com, axboe@kernel.dk,
        hch@lst.de, damien.lemoal@opensource.wdc.com, snitzer@kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        bvanassche@acm.org, linux-fsdevel@vger.kernel.org,
        matias.bjorling@wdc.com, Jens Axboe <axboe@fb.com>,
        gost.dev@samsung.com, jonathan.derrick@linux.dev,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Alasdair Kergon <agk@redhat.com>,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a@eucas1p1.samsung.com>
 <20220506081105.29134-12-p.raghav@samsung.com>
 <20220509185432.GB18596@twin.jikos.cz>
 <d8e86c32-f122-01df-168e-648179766c55@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8e86c32-f122-01df-168e-648179766c55@samsung.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 04:39:17PM +0200, Pankaj Raghav wrote:
> Hi David,
> 
> On 2022-05-09 20:54, David Sterba wrote:>> diff --git
> a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> >> index 3e7b1fe15..27dc4ddf2 100644
> >> --- a/drivers/md/dm-zone.c
> >> +++ b/drivers/md/dm-zone.c
> >> @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
> >>  	struct request_queue *q = md->queue;
> >>  	unsigned int noio_flag;
> >>  	int ret;
> >> +	struct block_device *bdev = md->disk->part0;
> >> +	sector_t zone_sectors;
> >> +	char bname[BDEVNAME_SIZE];
> >> +
> >> +	zone_sectors = bdev_zone_sectors(bdev);
> >> +
> >> +	if (!is_power_of_2(zone_sectors)) {
> > 
> > is_power_of_2 takes 'unsigned long' and sector_t is u64, so this is not
> > 32bit clean and we had an actual bug where value 1<<48 was not
> > recognized as power of 2.
> > 
> Good catch. Now I understand why btrfs has a helper for is_power_of_two_u64.
> 
> But the zone size can never be more than 32bit value so the zone size
> sect will never greater than unsigned long.

We've set the maximum supported zone size in btrfs to be 8G, which is a
lot and should be sufficient for some time, but this also means that the
value is larger than 32bit maximum. I have actually tested btrfs on top
of such emaulated zoned device via TCMU, so it's not dm-zoned, so it's
up to you to make sure that a silent overflow won't happen.

> With that said, we have two options:
> 
> 1.) We can put a comment explaining that even though it is 32 bit
> unsafe, zone size sect can never be a 32bit value

This is probably part of the protocol and specification of the zoned
devices, the filesystem either accepts the spec or makes some room for
larger values in case it's not too costly.

> or
> 
> 2) We should move the btrfs only helper `is_power_of_two_u64` to some
> common header and use it everywhere.

Yeah, that can be done independently. With some macro magic it can be
made type-safe for any argument while preserving the 'is_power_of_2'
name.
