Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4343ACD74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 16:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhFRO3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 10:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233789AbhFRO3s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624026458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/sCBTOwdqNgII3IAySkNB1KoKYpTV/nD9ZDHSFtulM=;
        b=FtvDhXLzMyaigWBrIVONU/xv4xtvLuN0ulDj9D3UjcT6fityNBBC/4dJAvLI+B+yEPFZba
        OUcuMMjUZ+485noDAgfdC/NlM7N0DetB/H3xvlK0zhxfyksfMXG8Mm+J5VOvzMk5yV1gf7
        467PUY1F5KexPaJxxsBGeRMeOWAjdDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-cumL99HCPe6gWJ4U4OdTKw-1; Fri, 18 Jun 2021 10:27:35 -0400
X-MC-Unique: cumL99HCPe6gWJ4U4OdTKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7781ABBEE0;
        Fri, 18 Jun 2021 14:27:33 +0000 (UTC)
Received: from T590 (ovpn-12-158.pek2.redhat.com [10.72.12.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2C7B60C4A;
        Fri, 18 Jun 2021 14:27:24 +0000 (UTC)
Date:   Fri, 18 Jun 2021 22:27:20 +0800
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
Message-ID: <YMytSIBm7k2pqFlc@T590>
References: <20210615131034.752623-1-hch@lst.de>
 <20210615131034.752623-14-hch@lst.de>
 <YMliP6sFVuPhMbOB@T590>
 <20210618140147.GA16258@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618140147.GA16258@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:01:47PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 16, 2021 at 10:30:23AM +0800, Ming Lei wrote:
> > Not sure disk is valid, we only hold the disk when opening a bdev, but
> > the bdev can be closed during polling.
> 
> How?  On a block device the caller needs to hold the block device open
> to read/write from it.  On a file systems the file systems needs to
> be mounted, which also holds a bdev reference.

+       rcu_read_lock();
+       bio = READ_ONCE(kiocb->private);
+       if (bio && bio->bi_bdev)

The bio may be ended now from another polling job, then the disk is
closed & deleted, and released. Then request queue & hctxs are released.

+               ret = bio_poll(bio, flags);

But disk & request queue & hctx can still be referred in above bio_poll().

+       rcu_read_unlock();

> 
> > Also disk always holds one
> > reference on request queue, so if disk is valid, no need to grab queue's
> > refcnt in bio_poll().
> 
> But we need to avoid going into the lowlevel blk-mq polling code to not
> reference the potentially freed hctxs or tags as correctly pointed by
> yourself on the previous iteration.

If request queue isn't released, hctx won't be freed too. Tagset can be
freed, but it is supposed to not be touched after request queue is cleanup.


Thanks, 
Ming

