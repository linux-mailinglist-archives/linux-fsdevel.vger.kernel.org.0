Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FD536E5D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 09:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbhD2HWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 03:22:08 -0400
Received: from verein.lst.de ([213.95.11.211]:52070 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239310AbhD2HWC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:22:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E425867373; Thu, 29 Apr 2021 09:20:28 +0200 (CEST)
Date:   Thu, 29 Apr 2021 09:20:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/15] block: switch polling to be bio based
Message-ID: <20210429072028.GA3682@lst.de>
References: <20210427161619.1294399-1-hch@lst.de> <20210427161619.1294399-13-hch@lst.de> <YIjIOgYS29GvcoIm@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIjIOgYS29GvcoIm@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 10:28:10AM +0800, Ming Lei wrote:

> ...

Can you please avoid the full quote?

> > +	 *  1) the bio is beeing initialized and bi_bdev is NULL.  We can just
> > +	 *     simply nothing in this case
> > +	 *  2) the bio points to a not poll enabled device.  bio_poll will catch
> > +	 *     this and return 0
> > +	 *  3) the bio points to a poll capable device, including but not
> > +	 *     limited to the one that the original bio pointed to.  In this
> > +	 *     case we will call into the actual poll method and poll for I/O,
> > +	 *     even if we don't need to, but it won't cause harm either.
> > +	 */
> > +	rcu_read_lock();
> > +	bio = READ_ONCE(kiocb->private);
> > +	if (bio && bio->bi_bdev)
> 
> ->bi_bdev and associated disk/request_queue/hctx/... refrerred in bio_poll()
> may have being freed now, so there is UAF risk.

the block device is RCU freed, so we are fine there.  There rest OTOH
is more interesting.  Let me think of a good defense using some kind
of liveness check.
