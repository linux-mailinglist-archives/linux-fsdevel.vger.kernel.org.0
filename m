Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB072C501D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 09:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388785AbgKZIQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 03:16:54 -0500
Received: from verein.lst.de ([213.95.11.211]:33418 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388774AbgKZIQy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 03:16:54 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AF45968B02; Thu, 26 Nov 2020 09:16:50 +0100 (CET)
Date:   Thu, 26 Nov 2020 09:16:50 +0100
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
Message-ID: <20201126081650.GA18807@lst.de>
References: <20201124132751.3747337-1-hch@lst.de> <20201124132751.3747337-26-hch@lst.de> <X714udEyPuGarVYp@mtj.duckdns.org> <20201125164515.GB1975@lst.de> <X768hzEnD/ySog5b@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X768hzEnD/ySog5b@mtj.duckdns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 03:20:23PM -0500, Tejun Heo wrote:
> Agreed. It'd be nice to replace the stale comment.

I've updated the comment.

> > Jan added lookup_sem in commit 56c0908c855afbb to prevent a three way
> > race between del_gendisk and blkdev_open due to the weird bdev vs
> > gendisk lifetime rules.  None of that can happen with the new lookup
> > scheme.
> 
> Understood. I think it'd be worthwhile to note that in the commit log.

So after the idea of just holding a disk reference from each bdev did
not work out very well I've reworked this a bit, and lookup_sem stays,
but becomes global to protect the disk lookup (similar to the previous
global bdev_map_lock).
