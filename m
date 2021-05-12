Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3E837EF92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 01:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhELXNr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 19:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1443376AbhELWSB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 18:18:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DCE160FE5;
        Wed, 12 May 2021 22:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620857812;
        bh=gWvXwEcUW9/zyCDBF+2nlh6sqFqdf0UI2tvHhr1sEBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HGr9heSTZtAV6hJ5Uuoc0TrX22mINbku96TDtiPDJ084KaKqhXEFugrSKPQfNUhU2
         riINRXq+ogjYsM29IVthNd95eYfXF/RsaYH7xzp4Fw8yy+SeciMASLxH2E3NHCH3RH
         R+LWxFsOcUPva+cE1D7AmmgPLFP8PSFkHOpHQFxQH4pJdfEJS4bP16B2tzO4Dkjxns
         NYKXG+TX3H0RHzfBfTZAM6w13rTIBaZzBqKZ/C97gYTeKMsGg2lECJMVFO9PZK+ihS
         AJZgMwQtnSzzEde48iIQ/IyVvwUs65yzGeQyAbo3sEE6wJnZ1FhW54IHPX7b9M/O2+
         cpZzTb+2e9Dhw==
Date:   Wed, 12 May 2021 15:16:49 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 15/15] nvme-multipath: enable polled I/O
Message-ID: <20210512221649.GB2270434@dhcp-10-100-145-180.wdc.com>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-16-hch@lst.de>
 <2ae11b40-1d03-af08-aade-022fc1f0a743@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ae11b40-1d03-af08-aade-022fc1f0a743@grimberg.me>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 03:10:58PM -0700, Sagi Grimberg wrote:
> 
> > Set the poll queue flag to enable polling, given that the multipath
> > node just dispatches the bios to a lower queue.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >   drivers/nvme/host/multipath.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> > index 516fe977606d..e95b93655d06 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -446,6 +446,15 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
> >   		goto out;
> >   	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
> >   	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
> > +	/*
> > +	 * This assumes all controllers that refer to a namespace either
> > +	 * support poll queues or not.  That is not a strict guarantee,
> > +	 * but if the assumption is wrong the effect is only suboptimal
> > +	 * performance but not correctness problem.
> > +	 */
> > +	if (ctrl->tagset->nr_maps > HCTX_TYPE_POLL &&
> > +	    ctrl->tagset->map[HCTX_TYPE_POLL].nr_queues)
> > +		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
> 
> If one controller does not support polling and the other does, won't
> the block layer fail to map a queue for REQ_POLLED requests?
> 
> Maybe clear in the else case here?

This only gets called once per head, though, so it's just going to
inherit whatever capabilities the first controller happens to have. If
we do set QUEUE_FLAG_POLL, but the chosen path happens to not support
it, then submit_bio_checks() will strip off the bio flag and it will be
processed as a non-polled request.

If the first controller can't support a polled queue, then other
controllers that do will just have unusable resources.
