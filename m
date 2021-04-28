Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DD336D08F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 04:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhD1Cdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 22:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235422AbhD1Cdb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 22:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619577166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8uu0Je4biOqdiy4H9hWkuCvZi6Oweuv/QJoR9hpxbRI=;
        b=CNlEdrQoFLevAG3mxWh4f90R0hW4sN8/xFH5mlNKUnFELY9gIXF8bHW4CAVy+LYKAEZL1V
        IlRCaQp3k4jg6hdpIAF2rKc6PiUdzNJbWwxSoy6ZbuPrOoRqLEDIF46yCz5rPs8RPQo6ts
        f0hB10KORu6GzAbnsowLBSgq1Cmd+io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-CWZPv_34PsmbxS0QtiYb_Q-1; Tue, 27 Apr 2021 22:32:41 -0400
X-MC-Unique: CWZPv_34PsmbxS0QtiYb_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20377803620;
        Wed, 28 Apr 2021 02:32:40 +0000 (UTC)
Received: from T590 (ovpn-12-77.pek2.redhat.com [10.72.12.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD29F6A04C;
        Wed, 28 Apr 2021 02:32:31 +0000 (UTC)
Date:   Wed, 28 Apr 2021 10:32:38 +0800
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
Subject: Re: [PATCH 14/15] nvme-multipath: set QUEUE_FLAG_NOWAIT
Message-ID: <YIjJRiyA26gELV+d@T590>
References: <20210427161619.1294399-1-hch@lst.de>
 <20210427161619.1294399-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427161619.1294399-15-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 06:16:18PM +0200, Christoph Hellwig wrote:
> The nvme multipathing code just dispatches bios to one of the blk-mq
> based paths and never blocks on its own, so set QUEUE_FLAG_NOWAIT
> to support REQ_NOWAIT bios.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/multipath.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 4e2c3a6787e9..1d17b2387884 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -442,6 +442,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>  	if (!q)
>  		goto out;
>  	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
> +	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);

BLK_MQ_F_BLOCKING is set for nvme-tcp, and the blocking may be done inside
nvme_ns_head_submit_bio(), is that one problem?


Thanks,
Ming

