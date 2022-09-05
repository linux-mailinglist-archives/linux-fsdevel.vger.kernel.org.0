Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAE55ACB6A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 08:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiIEGys (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 02:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbiIEGyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:54:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA25BAE5F;
        Sun,  4 Sep 2022 23:54:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A346568AFE; Mon,  5 Sep 2022 08:54:38 +0200 (CEST)
Date:   Mon, 5 Sep 2022 08:54:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/17] btrfs: calculate file system wide queue limit
 for zoned mode
Message-ID: <20220905065438.GH2092@lst.de>
References: <20220901074216.1849941-1-hch@lst.de> <20220901074216.1849941-16-hch@lst.de> <429d26b8-f7d8-6365-a2fa-f4ed892182e4@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429d26b8-f7d8-6365-a2fa-f4ed892182e4@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:56:40AM +0900, Damien Le Moal wrote:
> > -	/* Max size to emit ZONE_APPEND write command */
> > +	/* Constraints for ZONE_APPEND commands: */
> > +	struct queue_limits limits;
> >  	u64 max_zone_append_size;
> 
> Can't we get rid of this one and have the code directly use
> fs_info->limits.max_zone_append_sectors through a little helper doing a
> conversion to bytes (a 9 bit shift) ?

Well, the helper would be a little more complicated, doing three
different shifts, a max3 and and ALIGN_DOWN.  That's why I thought
I'd rather cache the value then recalculating it on every write.  But
either way would be entirely feasible.

> This does:
> 
> 	t->max_zone_append_sectors = min(t->max_zone_append_sectors,
>                                         b->max_zone_append_sectors);
> 
> So if we are mixing zoned and non-zoned devices in a multi-dev volume,
> we'll end up with max_zone_append_sectors being 0. The previous code
> prevented that.
> 
> Note that I am not sure if it is allowed to mix zoned and non-zoned drives
> in the same volume. Given that we have a fake zone emulation for non-zoned
> drives with zoned btrfs, I do not see why it would not work. But I may be
> wrong.

Yes, this could be problematic.  I wonder if we need to initialize
max_zone_append_sectors to max_hw_sectors by default and use a separate
flag if it is actually supported in the block layer if we want to
support that.
