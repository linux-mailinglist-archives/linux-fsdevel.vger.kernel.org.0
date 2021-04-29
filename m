Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABC736EC8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 16:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhD2Omy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 10:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233602AbhD2Omx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619707327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5j+rL0qw44y0T4crpkr6NmrX5ib7bkJ4lhhHCiai/js=;
        b=iMfvgzpNeftDYm8auyrjNWT6w67bykFmjlAt/bSJqzHOOZ0Nm7FM3wORk5Ifta9y20CW7g
        wr/BY/Kyx/YYqke3UigyQEWUJy8dBD24vkFI/WG4LTlJzGn0EgcC+G8fSZuCvU4949F3hL
        EXsUcgN4GHv2JUZEtaSq95QR9v5vFz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-MXezInh7OiyCWToQuYkGYw-1; Thu, 29 Apr 2021 10:42:03 -0400
X-MC-Unique: MXezInh7OiyCWToQuYkGYw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D21D8CCFEC;
        Thu, 29 Apr 2021 14:42:01 +0000 (UTC)
Received: from T590 (ovpn-12-74.pek2.redhat.com [10.72.12.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F0DF679F3;
        Thu, 29 Apr 2021 14:41:53 +0000 (UTC)
Date:   Thu, 29 Apr 2021 22:42:03 +0800
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
Message-ID: <YIrFu4LiZwipcsbg@T590>
References: <20210427161619.1294399-1-hch@lst.de>
 <20210427161619.1294399-13-hch@lst.de>
 <YIjIOgYS29GvcoIm@T590>
 <20210429072028.GA3682@lst.de>
 <YIph7qLu4wL5QEXK@T590>
 <20210429095036.GA15615@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429095036.GA15615@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 11:50:36AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 29, 2021 at 03:36:14PM +0800, Ming Lei wrote:
> > > > ->bi_bdev and associated disk/request_queue/hctx/... refrerred in bio_poll()
> > > > may have being freed now, so there is UAF risk.
> > > 
> > > the block device is RCU freed, so we are fine there.  There rest OTOH
> > > is more interesting.  Let me think of a good defense using some kind
> > > of liveness check.
> > 
> > Or hold gendisk reference in bdev lifetime, then everything referred
> > won't be released until bdev is freed.
> 
> The whole device bdev controls the gendisk liftetime, so that one is
> easy.  But for partitions it is probably a good idea to ensure that
> the gendisk is kept allocated as long as the block devices are around
> as well.

Looks we needn't to care if the bdev is disk or partition: bdev is always
associated with gendisk via ->bd_disk, the gendisk instance has to be kept
alive since bio->bi_bdev->bd_disk is used everywhere almost.


Thanks,
Ming

