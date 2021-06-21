Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5640D3AE3FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 09:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFUHW0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 03:22:26 -0400
Received: from verein.lst.de ([213.95.11.211]:40846 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhFUHWZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:22:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 11AB568BFE; Mon, 21 Jun 2021 09:20:06 +0200 (CEST)
Date:   Mon, 21 Jun 2021 09:20:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 13/16] block: switch polling to be bio based
Message-ID: <20210621072005.GA6651@lst.de>
References: <20210615131034.752623-1-hch@lst.de> <20210615131034.752623-14-hch@lst.de> <YMliP6sFVuPhMbOB@T590> <20210618140147.GA16258@lst.de> <YMytSIBm7k2pqFlc@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMytSIBm7k2pqFlc@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 10:27:20PM +0800, Ming Lei wrote:
> > How?  On a block device the caller needs to hold the block device open
> > to read/write from it.  On a file systems the file systems needs to
> > be mounted, which also holds a bdev reference.
> 
> +       rcu_read_lock();
> +       bio = READ_ONCE(kiocb->private);
> +       if (bio && bio->bi_bdev)
> 
> The bio may be ended now from another polling job, then the disk is
> closed & deleted, and released. Then request queue & hctxs are released.
> 
> +               ret = bio_poll(bio, flags);
> 
> But disk & request queue & hctx can still be referred in above bio_poll().

I don't see how this can happen.  A bio stashed into kiocb->private needs
to belong to the correct device initially.  For it to point to the "wrong"
device it needs to have been completed on the correct one, and then be
reused for a different device.  At the point it is reused that device
must obviously have been alive, and for it to be freed a RCU grace
period must have been passed.  And that grace period can't have started
earlier than when iocb_bio_iopoll was called.
