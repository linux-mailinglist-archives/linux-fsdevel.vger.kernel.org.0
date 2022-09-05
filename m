Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A495ACB49
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 08:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbiIEGtc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 02:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiIEGt3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:49:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11F0E24;
        Sun,  4 Sep 2022 23:49:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0AD1F68AFE; Mon,  5 Sep 2022 08:49:23 +0200 (CEST)
Date:   Mon, 5 Sep 2022 08:49:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 10/17] btrfs: remove stripe boundary calculation for
 compressed I/O
Message-ID: <20220905064922.GE2092@lst.de>
References: <20220901074216.1849941-1-hch@lst.de> <20220901074216.1849941-11-hch@lst.de> <SA0PR04MB7418043F611C6BC2CD453F659B7B9@SA0PR04MB7418.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR04MB7418043F611C6BC2CD453F659B7B9@SA0PR04MB7418.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:56:05AM +0000, Johannes Thumshirn wrote:
> On 01.09.22 09:43, Christoph Hellwig wrote:
> > +	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> > +		struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
> > +		struct extent_map *em;
> >  
> > -	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
> > -		bio_set_dev(bio, em->map_lookup->stripes[0].dev->bdev);
> > +		em = btrfs_get_chunk_map(fs_info, disk_bytenr,
> > +					 fs_info->sectorsize);
> > +		if (IS_ERR(em)) {
> > +			bio_put(bio);
> > +			return ERR_CAST(em);
> > +		}
> 
> Please use btrfs_get_zoned_device() instead of open coding it.

I though of that, decided againt doing this in this patch as an
unrelated patch and moved it to a separate cleanup.  And then
I noticed that btrfs_get_zoned_device goes away later in the series
entirely, so I dropped that patch again..
