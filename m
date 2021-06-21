Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78BF3AE503
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 10:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFUIiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 04:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230225AbhFUIiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624264546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kDqaJylOpEO+y/MxTzmjHISDevTkUAwoLV6gGI0zT9E=;
        b=U0RyjVWTT0ji5g8Zt5yOMGZOLSoOvEs243Dv66sLvG5teX91i4I82Ysxf/uyq/xZqH9cjk
        BpyR+tFSjgtnKJ25wCalIdTvT4GjhpcQm4z1V7GRmGdBrMGXx8SCMeVBQj0F52ySDwdjBJ
        LDZ5laQMbDy2LV5jfWITk/gaW8ad0S4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-HSBqi19DNOSAtdmrF3VSXQ-1; Mon, 21 Jun 2021 04:35:45 -0400
X-MC-Unique: HSBqi19DNOSAtdmrF3VSXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741D81084F53;
        Mon, 21 Jun 2021 08:35:43 +0000 (UTC)
Received: from T590 (ovpn-13-237.pek2.redhat.com [10.72.13.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EB5F60CA1;
        Mon, 21 Jun 2021 08:35:34 +0000 (UTC)
Date:   Mon, 21 Jun 2021 16:35:29 +0800
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
Message-ID: <YNBPUUVtxSb6/gv1@T590>
References: <20210615131034.752623-1-hch@lst.de>
 <20210615131034.752623-14-hch@lst.de>
 <YMliP6sFVuPhMbOB@T590>
 <20210618140147.GA16258@lst.de>
 <YMytSIBm7k2pqFlc@T590>
 <20210621072005.GA6651@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621072005.GA6651@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 09:20:05AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 18, 2021 at 10:27:20PM +0800, Ming Lei wrote:
> > > How?  On a block device the caller needs to hold the block device open
> > > to read/write from it.  On a file systems the file systems needs to
> > > be mounted, which also holds a bdev reference.
> > 
> > +       rcu_read_lock();
> > +       bio = READ_ONCE(kiocb->private);
> > +       if (bio && bio->bi_bdev)
> > 
> > The bio may be ended now from another polling job, then the disk is
> > closed & deleted, and released. Then request queue & hctxs are released.
> > 
> > +               ret = bio_poll(bio, flags);
> > 
> > But disk & request queue & hctx can still be referred in above bio_poll().
> 
> I don't see how this can happen.  A bio stashed into kiocb->private needs
> to belong to the correct device initially.  For it to point to the "wrong"
> device it needs to have been completed on the correct one, and then be
> reused for a different device.  At the point it is reused that device
> must obviously have been alive, and for it to be freed a RCU grace
> period must have been passed.  And that grace period can't have started
> earlier than when iocb_bio_iopoll was called.

gendisk isn't freed after a RCU grace period, so even though bio->bi_bdev
may not be freed really, but the gendisk may have been freed already.

+       rcu_read_lock();
+       bio = READ_ONCE(kiocb->private);
+       if (bio && bio->bi_bdev)

The bio may be ended now from another polling job, and it is freed
and re-allocated & freed, then bio->bi_bdev->bd_disk is freed too, which
will be observed in the following bio_poll().

+               ret = bio_poll(bio, flags);


Thanks,
Ming

