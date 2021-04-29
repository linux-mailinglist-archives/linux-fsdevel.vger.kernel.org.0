Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F6A36E626
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 09:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbhD2Hij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 03:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239619AbhD2Hih (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619681871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XQq6HQYt2KRjmeddb0bfJBsySmGjBP/o+T78t28weow=;
        b=AYSNRH6BzxVmMeB69TEDc9a86sx+LDqUh7Ltqk2rxhe1w3mMnakbLVBfvHtB3mJJVoQCx0
        IsPx5rrpzfczipEUWjU6iTmJXhwH8xTA4tVLlZius9qu0DVOz0lN65cUuXx7ptL+U58YRB
        s7gUJPRi31wyoKOmiP9S6YJiP8q75e0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-sQzD-JKHPo2u51Wi4EQpVA-1; Thu, 29 Apr 2021 03:37:47 -0400
X-MC-Unique: sQzD-JKHPo2u51Wi4EQpVA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D9E610054F6;
        Thu, 29 Apr 2021 07:37:46 +0000 (UTC)
Received: from T590 (ovpn-13-18.pek2.redhat.com [10.72.13.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98FA519714;
        Thu, 29 Apr 2021 07:37:37 +0000 (UTC)
Date:   Thu, 29 Apr 2021 15:37:47 +0800
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
Message-ID: <YIpiS0d1NeoX6p0H@T590>
References: <20210427161619.1294399-1-hch@lst.de>
 <20210427161619.1294399-15-hch@lst.de>
 <YIjJRiyA26gELV+d@T590>
 <20210429072737.GA3873@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429072737.GA3873@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 09:27:37AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 28, 2021 at 10:32:38AM +0800, Ming Lei wrote:
> > > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> > > index 4e2c3a6787e9..1d17b2387884 100644
> > > --- a/drivers/nvme/host/multipath.c
> > > +++ b/drivers/nvme/host/multipath.c
> > > @@ -442,6 +442,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
> > >  	if (!q)
> > >  		goto out;
> > >  	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
> > > +	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
> > 
> > BLK_MQ_F_BLOCKING is set for nvme-tcp, and the blocking may be done inside
> > nvme_ns_head_submit_bio(), is that one problem?
> 
> The point of BLK_MQ_F_BLOCKING is that ->queue_rq can block, and
> because of that it is not called from the submitting context but in
> a work queue.  nvme-tcp also sets QUEUE_FLAG_NOWAIT, just like all blk-mq
> drivers.

BLK_MQ_F_BLOCKING can be called from submitting context, see
blk_mq_try_issue_directly().



Thanks,
Ming

