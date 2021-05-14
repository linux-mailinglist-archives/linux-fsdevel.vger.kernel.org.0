Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E253F38022C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 04:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhENCvk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 22:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229981AbhENCvj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 22:51:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3180661406;
        Fri, 14 May 2021 02:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620960629;
        bh=NdnNFHHJEnnVdOQS/NvyN81+kLTnIQhndpEaWGvbIkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p6lg52MiipVtHKORxFKkxhPtjHOMJuM+qn04bKswzW9CL7/CqGNe4jNQbkFgdAoLP
         +at4jzGXLiC5kGM4fUIhaDb5VvTqvkYYqk7+jgPUE9lg3fgU+clX8uazEmGnRMk/JK
         Z8+0/K69+GopRHaKSyibsg6Mc5rYtoiAMxr5CZ+qjykLUKuX27oU5wW0cs1MrPDzjJ
         WoHCZmck9TnWq9z+MZt9NIGlJvatXD1+N1l7SNoFkDCsSyCNyH4hbHRxbo+74GlrL4
         C7wyheFxd6X+hYYo0CgdFSreX9JIVTpf+9VNyZMdn7xL4UPtb/HxCS/mt+NV6eLHck
         aoQhiOuvX9Y0A==
Date:   Thu, 13 May 2021 19:50:26 -0700
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
Subject: Re: [PATCH 12/15] block: switch polling to be bio based
Message-ID: <20210514025026.GA2447336@dhcp-10-100-145-180.wdc.com>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-13-hch@lst.de>
 <45d66945-165c-ae48-69f4-75dc553b0386@grimberg.me>
 <20210512221237.GA2270434@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512221237.GA2270434@dhcp-10-100-145-180.wdc.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 03:12:37PM -0700, Keith Busch wrote:
> On Wed, May 12, 2021 at 03:03:40PM -0700, Sagi Grimberg wrote:
> > On 5/12/21 6:15 AM, Christoph Hellwig wrote:
> > > + *
> > > + * Note: the caller must either be the context that submitted @bio, or
> > > + * be in a RCU critical section to prevent freeing of @bio.
> > > + */
> > > +int bio_poll(struct bio *bio, unsigned int flags)
> > > +{
> > > +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> > > +	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
> > > +
> > > +	if (cookie == BLK_QC_T_NONE ||
> > > +	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> > > +		return 0;
> > > +
> > > +	if (current->plug)
> > > +		blk_flush_plug_list(current->plug, false);
> > > +
> > > +	/* not yet implemented, so this should not happen */
> > > +	if (WARN_ON_ONCE(!queue_is_mq(q)))
> > 
> > What happens if the I/O wasn't (yet) queued to the bottom device
> > (i.e. no available path in nvme-mpath)?
> > 
> > In this case the disk would be the mpath device node (which is
> > not mq...)
> 
> The bi_cookie should remain BLK_QC_T_NONE in that case, so we wouldn't
> get to the warning. But if that does happen, it doesn't appear that
> anyone is going to wake up thread that needs to poll for this bio's
> completion when a path becomes available for dispatch. I think it would
> make sense for nvme-mpath to just clear the REQ_POLLED flag if it
> doesn't immediately have viable path.

It looks like there is a way to hit this warning. If you induce a path
error to create a failover, the nvme-mpath will reset the bio's bdev to
the mpath one, which is not MQ. I can occaisionally hit it with a fault
injection test.
