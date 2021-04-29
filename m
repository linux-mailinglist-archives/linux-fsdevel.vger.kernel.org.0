Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A913736E621
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 09:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbhD2HiN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 03:38:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231528AbhD2HiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619681787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UGPeB0oPu7QqJ34l/K46kw94SL7UJPriwj0KM6YFO5w=;
        b=YMylXDa4Oi2gEdpsaJLRFtBnjl+klKIBGUxqa6pSGv9pFs7FYlJms6JzWqp52kY5ZHxDRH
        nUe9mV3Aao/FN6aNmLzAPmnf0Cbe7cyIQQJL6xYLMxu5agkiCN5uoIIJ9fAHKMFA2tG9V+
        5hvyTFGZeRlkOj90NEwoMxz87A2Juhg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-835luwuLOA2_zlKMLQmZQw-1; Thu, 29 Apr 2021 03:36:15 -0400
X-MC-Unique: 835luwuLOA2_zlKMLQmZQw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0EA7501E3;
        Thu, 29 Apr 2021 07:36:13 +0000 (UTC)
Received: from T590 (ovpn-13-18.pek2.redhat.com [10.72.13.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 382FD610DF;
        Thu, 29 Apr 2021 07:36:04 +0000 (UTC)
Date:   Thu, 29 Apr 2021 15:36:14 +0800
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
Subject: Re: [PATCH 12/15] block: switch polling to be bio based
Message-ID: <YIph7qLu4wL5QEXK@T590>
References: <20210427161619.1294399-1-hch@lst.de>
 <20210427161619.1294399-13-hch@lst.de>
 <YIjIOgYS29GvcoIm@T590>
 <20210429072028.GA3682@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429072028.GA3682@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 09:20:28AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 28, 2021 at 10:28:10AM +0800, Ming Lei wrote:
> 
> > ...
> 
> Can you please avoid the full quote?
> 
> > > +	 *  1) the bio is beeing initialized and bi_bdev is NULL.  We can just
> > > +	 *     simply nothing in this case
> > > +	 *  2) the bio points to a not poll enabled device.  bio_poll will catch
> > > +	 *     this and return 0
> > > +	 *  3) the bio points to a poll capable device, including but not
> > > +	 *     limited to the one that the original bio pointed to.  In this
> > > +	 *     case we will call into the actual poll method and poll for I/O,
> > > +	 *     even if we don't need to, but it won't cause harm either.
> > > +	 */
> > > +	rcu_read_lock();
> > > +	bio = READ_ONCE(kiocb->private);
> > > +	if (bio && bio->bi_bdev)
> > 
> > ->bi_bdev and associated disk/request_queue/hctx/... refrerred in bio_poll()
> > may have being freed now, so there is UAF risk.
> 
> the block device is RCU freed, so we are fine there.  There rest OTOH
> is more interesting.  Let me think of a good defense using some kind
> of liveness check.

Or hold gendisk reference in bdev lifetime, then everything referred
won't be released until bdev is freed.


Thanks,
Ming

