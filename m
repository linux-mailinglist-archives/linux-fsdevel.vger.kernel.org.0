Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E18936E5E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 09:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbhD2H21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 03:28:27 -0400
Received: from verein.lst.de ([213.95.11.211]:52084 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238991AbhD2H20 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:28:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A67AE67373; Thu, 29 Apr 2021 09:27:37 +0200 (CEST)
Date:   Thu, 29 Apr 2021 09:27:37 +0200
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
Subject: Re: [PATCH 14/15] nvme-multipath: set QUEUE_FLAG_NOWAIT
Message-ID: <20210429072737.GA3873@lst.de>
References: <20210427161619.1294399-1-hch@lst.de> <20210427161619.1294399-15-hch@lst.de> <YIjJRiyA26gELV+d@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIjJRiyA26gELV+d@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 10:32:38AM +0800, Ming Lei wrote:
> > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> > index 4e2c3a6787e9..1d17b2387884 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -442,6 +442,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
> >  	if (!q)
> >  		goto out;
> >  	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
> > +	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
> 
> BLK_MQ_F_BLOCKING is set for nvme-tcp, and the blocking may be done inside
> nvme_ns_head_submit_bio(), is that one problem?

The point of BLK_MQ_F_BLOCKING is that ->queue_rq can block, and
because of that it is not called from the submitting context but in
a work queue.  nvme-tcp also sets QUEUE_FLAG_NOWAIT, just like all blk-mq
drivers.
