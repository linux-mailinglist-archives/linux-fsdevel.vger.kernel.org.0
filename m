Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A4C36E836
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 11:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbhD2Jvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 05:51:46 -0400
Received: from verein.lst.de ([213.95.11.211]:52508 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233048AbhD2Jvp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:51:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4E9CC67373; Thu, 29 Apr 2021 11:50:36 +0200 (CEST)
Date:   Thu, 29 Apr 2021 11:50:36 +0200
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
Message-ID: <20210429095036.GA15615@lst.de>
References: <20210427161619.1294399-1-hch@lst.de> <20210427161619.1294399-13-hch@lst.de> <YIjIOgYS29GvcoIm@T590> <20210429072028.GA3682@lst.de> <YIph7qLu4wL5QEXK@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIph7qLu4wL5QEXK@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 03:36:14PM +0800, Ming Lei wrote:
> > > ->bi_bdev and associated disk/request_queue/hctx/... refrerred in bio_poll()
> > > may have being freed now, so there is UAF risk.
> > 
> > the block device is RCU freed, so we are fine there.  There rest OTOH
> > is more interesting.  Let me think of a good defense using some kind
> > of liveness check.
> 
> Or hold gendisk reference in bdev lifetime, then everything referred
> won't be released until bdev is freed.

The whole device bdev controls the gendisk liftetime, so that one is
easy.  But for partitions it is probably a good idea to ensure that
the gendisk is kept allocated as long as the block devices are around
as well.
