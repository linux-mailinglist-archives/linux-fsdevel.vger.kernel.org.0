Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A72F567611
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 19:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiGER5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 13:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiGER5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:57:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7351BE86;
        Tue,  5 Jul 2022 10:57:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81FDBB81887;
        Tue,  5 Jul 2022 17:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DDEC341C7;
        Tue,  5 Jul 2022 17:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657043862;
        bh=2n0MdI/phNcEmcix0C+izbdt51lZOoB1FibJBB1glbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPWuUIYH2m+thvDdaR7J1//HnOGKOFxxB4NJp6pNe6vMzogtjLZRoFBtxO5LlMNeI
         yWudYsaRp5DLrK6fJ3hIMQYHCgLjjZ5MxX3p6AyAqdxBjjw/h26TTzcR/Pc8ewwHf7
         QMwbCfdPkWn2iRfmb6GBERZ1Soz212xPz3jM9A45G2MEhQieqAKfyzJ4nbOrHPEOTO
         N/cG0O5LyrMmRlQhtqIXscvzDi/zOUEEQMIE8bYNhu2xUZunJpe+x4Vs289Np/BdU0
         uO/tchQgfmJcBt4F7r3FfIciHf3T2qrWT6ajp55T795YNQmliXF17uGnd3wfJMeH/3
         7Zg6dyGWPk/BA==
Date:   Tue, 5 Jul 2022 10:57:41 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "javier@javigon.com" <javier@javigon.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 1/6] block: add support for REQ_OP_VERIFY
Message-ID: <YsR7lbTfBH0dUMMg@magnolia>
References: <20220630091406.19624-1-kch@nvidia.com>
 <20220630091406.19624-2-kch@nvidia.com>
 <Yr3M0W5T/CwMtvte@magnolia>
 <476112fe-c01e-dbaa-793d-19d3ec94c6ef@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <476112fe-c01e-dbaa-793d-19d3ec94c6ef@nvidia.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 05, 2022 at 04:50:33PM +0000, Chaitanya Kulkarni wrote:
> Darrik,
> 
> Thanks for the reply.
> 
> >> +
> >> +/**
> >> + * __blkdev_issue_verify - generate number of verify operations
> >> + * @bdev:	blockdev to issue
> >> + * @sector:	start sector
> >> + * @nr_sects:	number of sectors to verify
> >> + * @gfp_mask:	memory allocation flags (for bio_alloc())
> >> + * @biop:	pointer to anchor bio
> >> + *
> >> + * Description:
> >> + *  Verify a block range using hardware offload.
> >> + *
> >> + * The function will emulate verify operation if no explicit hardware
> >> + * offloading for verifying is provided.
> >> + */
> >> +int __blkdev_issue_verify(struct block_device *bdev, sector_t sector,
> >> +		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
> >> +{
> >> +	unsigned int max_verify_sectors = bdev_verify_sectors(bdev);
> >> +	sector_t min_io_sect = (BIO_MAX_VECS << PAGE_SHIFT) >> 9;
> >> +	struct bio *bio = *biop;
> >> +	sector_t curr_sects;
> >> +	char *buf;
> >> +
> >> +	if (!max_verify_sectors) {
> >> +		int ret = 0;
> >> +
> >> +		buf = kzalloc(min_io_sect << 9, GFP_KERNEL);
> > 
> > k*z*alloc?  I don't think you need to zero a buffer that we're reading
> > into, right?
> > 
> > --D
> 
> we don't need to but I guess it is just a habit to make sure alloced
> buffer is zeored, should I remove it for any particular reason ?

What's the point in wasting CPU time zeroing a buffer if you're just
going to DMA into it?

--D

> -ck
> 
> 
