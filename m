Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B973A8ED7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 04:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhFPCcr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 22:32:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231233AbhFPCcq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 22:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623810640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y6D2FLYsK7JeK0vnQ+MjYTD2DRF3ATEwQXscjYAEAPw=;
        b=ijaDqDGEMH4estfT1ESjjmsz4jWtFBwICllRy3nc3G0P9RmnWqfwwkc2hd/pjfGX25CuTW
        hzS3xEN8ApjmEUdny36W4ezGLJtmQ5QKbh1YiTTISWIH35PtM0wf8zwNKxSorIe43MpShe
        4h/4HvlF6nl0fQIJN1Jh98lFEckMhes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-Y5zuCd8_MzeZ5AjSJEsUuQ-1; Tue, 15 Jun 2021 22:30:39 -0400
X-MC-Unique: Y5zuCd8_MzeZ5AjSJEsUuQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13ACF81840D;
        Wed, 16 Jun 2021 02:30:38 +0000 (UTC)
Received: from T590 (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EF9119C66;
        Wed, 16 Jun 2021 02:30:28 +0000 (UTC)
Date:   Wed, 16 Jun 2021 10:30:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 13/16] block: switch polling to be bio based
Message-ID: <YMliP6sFVuPhMbOB@T590>
References: <20210615131034.752623-1-hch@lst.de>
 <20210615131034.752623-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615131034.752623-14-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 03:10:31PM +0200, Christoph Hellwig wrote:
> Replace the blk_poll interface that requires the caller to keep a queue
> and cookie from the submissions with polling based on the bio.
> 
> Polling for the bio itself leads to a few advantages:
> 
>  - the cookie construction can made entirely private in blk-mq.c
>  - the caller does not need to remember the request_queue and cookie
>    separately and thus sidesteps their lifetime issues
>  - keeping the device and the cookie inside the bio allows to trivially
>    support polling BIOs remapping by stacking drivers
>  - a lot of code to propagate the cookie back up the submission path can
>    be removed entirely.
> 

...

> +/**
> + * bio_poll - poll for BIO completions
> + * @bio: bio to poll for
> + * @flags: BLK_POLL_* flags that control the behavior
> + *
> + * Poll for completions on queue associated with the bio. Returns number of
> + * completed entries found.
> + *
> + * Note: the caller must either be the context that submitted @bio, or
> + * be in a RCU critical section to prevent freeing of @bio.
> + */
> +int bio_poll(struct bio *bio, unsigned int flags)
> +{
> +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> +	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
> +	int ret;
> +
> +	if (cookie == BLK_QC_T_NONE ||
> +	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> +		return 0;
> +
> +	if (current->plug)
> +		blk_flush_plug_list(current->plug, false);
> +
> +	if (blk_queue_enter(q, BLK_MQ_REQ_NOWAIT))
> +		return 0;
> +	if (WARN_ON_ONCE(!queue_is_mq(q)))
> +		ret = 0;	/* not yet implemented, should not happen */
> +	else
> +		ret = blk_mq_poll(q, cookie, flags);
> +	blk_queue_exit(q);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(bio_poll);
> +
> +/*
> + * Helper to implement file_operations.iopoll.  Requires the bio to be stored
> + * in iocb->private, and cleared before freeing the bio.
> + */
> +int iocb_bio_iopoll(struct kiocb *kiocb, unsigned int flags)
> +{
> +	struct bio *bio;
> +	int ret = 0;
> +
> +	/*
> +	 * Note: the bio cache only uses SLAB_TYPESAFE_BY_RCU, so bio can
> +	 * point to a freshly allocated bio at this point.  If that happens
> +	 * we have a few cases to consider:
> +	 *
> +	 *  1) the bio is beeing initialized and bi_bdev is NULL.  We can just
> +	 *     simply nothing in this case
> +	 *  2) the bio points to a not poll enabled device.  bio_poll will catch
> +	 *     this and return 0
> +	 *  3) the bio points to a poll capable device, including but not
> +	 *     limited to the one that the original bio pointed to.  In this
> +	 *     case we will call into the actual poll method and poll for I/O,
> +	 *     even if we don't need to, but it won't cause harm either.
> +	 *
> +	 * For cases 2) and 3) above the RCU grace period ensures that bi_bdev
> +	 * is still allocated. Because partitions hold a reference to the whole
> +	 * device bdev and thus disk, the disk is also still valid.  Grabbing
> +	 * a reference to the queue in bio_poll() ensures the hctxs and requests
> +	 * are still valid as well.
> +	 */

Not sure disk is valid, we only hold the disk when opening a bdev, but
the bdev can be closed during polling. Also disk always holds one
reference on request queue, so if disk is valid, no need to grab queue's
refcnt in bio_poll().


Thanks,
Ming

