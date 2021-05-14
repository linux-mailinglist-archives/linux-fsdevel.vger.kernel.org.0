Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC54380E22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 18:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhENQ11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 12:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhENQ10 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 12:27:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42950613F1;
        Fri, 14 May 2021 16:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621009575;
        bh=BmQjlO9W718wi8igXBtPXxdqosqGpUfGqz6z39ZK124=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y98hyR4cMYKLTCUQNVrSCzmNI9ZVf0gmaoYwlQUp4e6NdRX+Po6JSRHrYoqot739E
         OIJ3gpo+RadN2lv8ZgEeKdb0vuEMLL7fk0c4ywdYndOCt1mxXfC4N1idPM3dLQNagm
         J1P6OWZS0F93bpKOShBHiZGEiwufHiEjf57wWg+zVMmxeWuQWqiuy7Fqa+PbTY7ys4
         fDul0qPlHqtayyLCEEADZZXjaK9EGu54lPnyRDOD5inU76/TXNK3KpAL0RN6njDwwE
         aSamaf4+CTuKNwhsVMtVmYwhzJGwT2hs7aPSrgIJmeDbuwpWk7w/nYkIUSOugHDoAH
         +1+YMURMeQ+iA==
Date:   Fri, 14 May 2021 09:26:12 -0700
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
Message-ID: <20210514162612.GA2706199@dhcp-10-100-145-180.wdc.com>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-13-hch@lst.de>
 <45d66945-165c-ae48-69f4-75dc553b0386@grimberg.me>
 <20210512221237.GA2270434@dhcp-10-100-145-180.wdc.com>
 <20210514025026.GA2447336@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514025026.GA2447336@dhcp-10-100-145-180.wdc.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 13, 2021 at 07:50:26PM -0700, Keith Busch wrote:
> On Wed, May 12, 2021 at 03:12:37PM -0700, Keith Busch wrote:
> > On Wed, May 12, 2021 at 03:03:40PM -0700, Sagi Grimberg wrote:
> > > On 5/12/21 6:15 AM, Christoph Hellwig wrote:
> > > > + *
> > > > + * Note: the caller must either be the context that submitted @bio, or
> > > > + * be in a RCU critical section to prevent freeing of @bio.
> > > > + */
> > > > +int bio_poll(struct bio *bio, unsigned int flags)
> > > > +{
> > > > +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> > > > +	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
> > > > +
> > > > +	if (cookie == BLK_QC_T_NONE ||
> > > > +	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> > > > +		return 0;
> > > > +
> > > > +	if (current->plug)
> > > > +		blk_flush_plug_list(current->plug, false);
> > > > +
> > > > +	/* not yet implemented, so this should not happen */
> > > > +	if (WARN_ON_ONCE(!queue_is_mq(q)))
> > > 
> > > What happens if the I/O wasn't (yet) queued to the bottom device
> > > (i.e. no available path in nvme-mpath)?
> > > 
> > > In this case the disk would be the mpath device node (which is
> > > not mq...)
> > 
> > The bi_cookie should remain BLK_QC_T_NONE in that case, so we wouldn't
> > get to the warning. But if that does happen, it doesn't appear that
> > anyone is going to wake up thread that needs to poll for this bio's
> > completion when a path becomes available for dispatch. I think it would
> > make sense for nvme-mpath to just clear the REQ_POLLED flag if it
> > doesn't immediately have viable path.
> 
> It looks like there is a way to hit this warning. If you induce a path
> error to create a failover, the nvme-mpath will reset the bio's bdev to
> the mpath one, which is not MQ. I can occaisionally hit it with a fault
> injection test.

Oh, and it gets a bit worse. Using pvsync2 will block forever once this
warning is hit, or if nvme-mpath had to requeue the IO for lack of a
path. io_uring doesn't have that hang problem though.

Christoph, I think patch 15 needs something like this:

---
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 7febdb57f690..d40a9331daf7 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -419,6 +419,11 @@ static void nvme_requeue_work(struct work_struct *work)
 		 * path.
 		 */
 		bio_set_dev(bio, head->disk->part0);
+
+		if (bio->bi_opf & REQ_POLLED) {
+			bio->bi_opf &= ~REQ_POLLED;
+			bio->bi_cookie = BLK_QC_T_NONE;
+		}
 		submit_bio_noacct(bio);
 	}
 }
--

This should fix the hang since requeued bio's will use an interrupt
driven queue, but it doesn't fix the warning. The recent commit
"nvme-multipath: reset bdev to ns head when failover" looks like it
makes preventing the polling thread from using the non-MQ head disk
not possible.
