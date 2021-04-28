Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A492536D092
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 04:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhD1ChH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 22:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235422AbhD1ChH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 22:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619577382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Aeu9vV+AZ5fymINj1ibMxlQo4LnGE6PkzOS++zg/VhE=;
        b=Nxiq+kIJqgRi2JTt3oMCoYwJJi7iy+kPTEg7EcCf+0aNU6o4H0JF7WSZqq7/FrOJOYfxph
        dyHePQu6k/NuU+pct/TekIzUZeIRJbW2ttWsL6240rrhGY/WTX5W1olrQzkZyWpyXwRxpa
        7Fho4FWqsrwKYqhRMYCCvqP9BGnurso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-21NXNnUDPLCgdTfaBsMUwg-1; Tue, 27 Apr 2021 22:36:20 -0400
X-MC-Unique: 21NXNnUDPLCgdTfaBsMUwg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E7158049CA;
        Wed, 28 Apr 2021 02:36:19 +0000 (UTC)
Received: from T590 (ovpn-12-77.pek2.redhat.com [10.72.12.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B89695C8AA;
        Wed, 28 Apr 2021 02:36:08 +0000 (UTC)
Date:   Wed, 28 Apr 2021 10:36:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/15] nvme-multipath: enable polled I/O
Message-ID: <YIjKIA0a5JR4jofr@T590>
References: <20210427161619.1294399-1-hch@lst.de>
 <20210427161619.1294399-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427161619.1294399-16-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 06:16:19PM +0200, Christoph Hellwig wrote:
> Set the poll queue flags to enable polling, given that the multipath
> node just dispatches the bios to a lower queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/multipath.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 1d17b2387884..0fa38f648ae7 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -443,6 +443,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>  		goto out;
>  	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
>  	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
> +	blk_queue_flag_set(QUEUE_FLAG_POLL_CAPABLE, q);
> +	blk_queue_flag_set(QUEUE_FLAG_POLL, q);

After POLL_CAPABLE is enabled on nvme mpath, POLL can be disabled via
queue_poll_store(). However, blk_mq_freeze_queue() just blocks and drain bio
submission, then pending POLL bio can't be polled any more because
QUEUE_FLAG_POLL is checked in bio_poll().


Thanks,
Ming

