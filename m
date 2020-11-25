Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E47C2C4591
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 17:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbgKYQpW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 11:45:22 -0500
Received: from verein.lst.de ([213.95.11.211]:59718 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732072AbgKYQpU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:45:20 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 05B8968B02; Wed, 25 Nov 2020 17:45:16 +0100 (CET)
Date:   Wed, 25 Nov 2020 17:45:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 25/45] block: reference struct block_device from struct
 hd_struct
Message-ID: <20201125164515.GB1975@lst.de>
References: <20201124132751.3747337-1-hch@lst.de> <20201124132751.3747337-26-hch@lst.de> <X714udEyPuGarVYp@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X714udEyPuGarVYp@mtj.duckdns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 04:18:49PM -0500, Tejun Heo wrote:
> Hello,
> 
> Please see lkml.kernel.org/r/X708BTJ5njtbC2z1@mtj.duckdns.org for a few nits
> on the previous version.

Thanks, I've addressed the mapping_set_gfp mask nit and updated the
commit log.  As Jan pointed also pointed out I think we do need the
remove_inode_hash.

> I might be confused but am wondering whether RCU is needed. It's currently
> used to ensure that gendisk is accessible in the blkdev_get path but
> wouldn't it be possible to simply pin gendisk from block_devices? The
> gendisk and hd_structs hold the base refs of the block_devices and in turn
> the block_devices pin the gendisk. When the gendisk gets deleted, it puts
> the base refs of the block devices but stays around while the block devices
> are being accessed.

Yes, that sounds sensible.  I'll take a look.

> Also, would it make sense to separate out lookup_sem removal? I *think* it's
> there to ensure that the same bdev doesn't get associated with old and new
> gendisks at the same time but can't wrap my head around how it works
> exactly. I can see that this may not be needed once the lifetimes of gendisk
> and block_devices are tied together but that may warrant a bit more
> explanation.

Jan added lookup_sem in commit 56c0908c855afbb to prevent a three way
race between del_gendisk and blkdev_open due to the weird bdev vs
gendisk lifetime rules.  None of that can happen with the new lookup
scheme.
