Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD0637F0E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 03:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhEMBZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 21:25:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233036AbhEMBZN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 21:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620869044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ApXt0lTU+wHkW/Hw5FHEMTlgYZ3cL3RrSCxBAdJAAg=;
        b=Q3OjhM3TV9d2UWbf22mwLJhJF2FMgo9YxCB+xP6nx5uZwWV6c8n24kHEVQRFnFlsTGNO0Z
        7QQ+jlav9cqTHirqeKBIxcZCXgewYfufXnAngngp7sm6GR67kC3zrr3snfTe4biBgGpGsD
        JY0dbSqQn/voGi79y8/otL7XSWxj7k0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-DHD9XigsNrWqitZoa_jjAA-1; Wed, 12 May 2021 21:24:00 -0400
X-MC-Unique: DHD9XigsNrWqitZoa_jjAA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E60906123C;
        Thu, 13 May 2021 01:23:58 +0000 (UTC)
Received: from T590 (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B95F56D8C2;
        Thu, 13 May 2021 01:23:47 +0000 (UTC)
Date:   Thu, 13 May 2021 09:23:42 +0800
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
Subject: Re: [PATCH 12/15] block: switch polling to be bio based
Message-ID: <YJx/nlec4yy0DHq3@T590>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512131545.495160-13-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 03:15:42PM +0200, Christoph Hellwig wrote:
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
> Signed-off-by: Christoph Hellwig <hch@lst.de>

...

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
> +	 * For cases 2) and 3) above the RCU grace period ensures that the
> +	 * bi_bdev is still allocated, and because partitions hold a reference
> +	 * to the whole device bdev and thus disk it is still valid.
> +	 */
> +	rcu_read_lock();
> +	bio = READ_ONCE(kiocb->private);
> +	if (bio && bio->bi_bdev)
> +		ret = bio_poll(bio, flags);

The bio can be re-allocated from another IO path & bdev after checking on
bio->bi_bdev in the above code, then this bio is freed, its ->bi_bdev is freed,
same with its associated disk/hw queues/request queue.

Both bdev and request queue are freed via rcu, but disk/hw queues are freed
immediately, so there is still UAF risk in bio_poll().

Thanks, 
Ming

