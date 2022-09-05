Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DA75ACB53
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 08:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbiIEGon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 02:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbiIEGoi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:44:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C19F65;
        Sun,  4 Sep 2022 23:44:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1AB6868AFE; Mon,  5 Sep 2022 08:44:32 +0200 (CEST)
Date:   Mon, 5 Sep 2022 08:44:31 +0200
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
Subject: Re: [PATCH 01/17] block: export bio_split_rw
Message-ID: <20220905064431.GC2092@lst.de>
References: <20220901074216.1849941-1-hch@lst.de> <20220901074216.1849941-2-hch@lst.de> <de16bd58-3f14-01d9-9de5-6a79792c62c7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de16bd58-3f14-01d9-9de5-6a79792c62c7@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 04:54:32PM +0800, Qu Wenruo wrote:
> I found the queue_limits structure pretty scary, while we only have very
> limited members used in this case:
>
> - lim->virt_boundary_mask
>   Used in bvec_gap_to_prev()
>
> - lim->max_segments
>
> - lim->seg_boundary_mask
> - lim->max_segment_size
>   Used in bvec_split_segs()
>
> - lim->logical_block_size
>
> Not familiar with block layer, thus I'm wondering do btrfs really need a
> full queue_limits structure to call bio_split_rw().

Well, the queue limits is what the block layer uses for communicating
the I/O size limitations, and thus both bio_split_rw and the stacking
layer helpers operate on it. 

> Or can we have a simplified wrapper?

I don't think we can simplify anything here.  The alternative would
be to open code the I/O path logic, which means a lot more code that
needs to be maintained and has a high probability to get out of sync
with the block layer logic.  So I'd much rather share this code
between everything that stacks block devices, be that to represent
another block device on the top like dm/md or for a 'direct' stacking
in the file system like btrfs does.

> IIRC inside btrfs we only need two cases for bio split:
>
> - Split for stripe boundary
>
> - Split for OE/zoned boundary

No.  For zoned devices we all limitations for bio, basically all that
you mentioned above.
