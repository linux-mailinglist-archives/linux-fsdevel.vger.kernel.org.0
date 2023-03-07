Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344646AE380
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 15:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCGO6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 09:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCGO4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:56:00 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA1E90784;
        Tue,  7 Mar 2023 06:41:10 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5C7AC68B05; Tue,  7 Mar 2023 15:41:06 +0100 (CET)
Date:   Tue, 7 Mar 2023 15:41:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/34] btrfs: add a btrfs_inode pointer to struct
 btrfs_bio
Message-ID: <20230307144106.GA19477@lst.de>
References: <20230121065031.1139353-1-hch@lst.de> <20230121065031.1139353-4-hch@lst.de> <88b2fae1-8d95-2172-7bc4-c5dfc4ff7410@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88b2fae1-8d95-2172-7bc4-c5dfc4ff7410@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 07, 2023 at 09:44:32AM +0800, Qu Wenruo wrote:
> With my recent restart on scrub rework, this patch makes me wonder, what if 
> scrub wants to use btrfs_bio, but don't want to pass a valid btrfs_inode 
> pointer?

The full inode is only really needed for the data repair code.  But a lot
of code uses the fs_info, which would have to be added as a separate
counter.  The other usage is the sync_writers counter, which is a bit
odd and should probably be keyed off the REQ_SYNC flag instead.

> E.g. scrub code just wants to read certain mirror of a logical bytenr.
> This can simplify the handling of RAID56, as for data stripes the repair 
> path is the same, just try the next mirror(s).
>
> Furthermore most of the new btrfs_bio code is handling data reads by 
> triggering read-repair automatically.
> This can be unnecessary for scrub.

This sounds like you don't want to use the btrfs_bio at all as you
don't rely on any of the functionality from it.

>
> And since we're here, can we also have btrfs equivalent of on-stack bio?
> As scrub can benefit a lot from that, as for sector-by-sector read, we want 
> to avoid repeating allocating/freeing a btrfs_bio just for reading one 
> sector.
> (The existing behavior is using on-stack bio with bio_init/bio_uninit 
> inside scrub_recheck_block())

You can do that right now by declaring a btrfs_bio on-stack and then
calling bio_init on the embedded bio followed by a btrfs_bio_init on
the btrfs_bio.  But I don't think doing this will actually be a win
for the scrub code in terms of speed or code size.
