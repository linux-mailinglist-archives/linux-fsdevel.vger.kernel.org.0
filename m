Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624063ACD02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 16:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhFROEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 10:04:01 -0400
Received: from verein.lst.de ([213.95.11.211]:35031 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233973AbhFROEA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:04:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D8BE068D08; Fri, 18 Jun 2021 16:01:47 +0200 (CEST)
Date:   Fri, 18 Jun 2021 16:01:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 13/16] block: switch polling to be bio based
Message-ID: <20210618140147.GA16258@lst.de>
References: <20210615131034.752623-1-hch@lst.de> <20210615131034.752623-14-hch@lst.de> <YMliP6sFVuPhMbOB@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMliP6sFVuPhMbOB@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 10:30:23AM +0800, Ming Lei wrote:
> Not sure disk is valid, we only hold the disk when opening a bdev, but
> the bdev can be closed during polling.

How?  On a block device the caller needs to hold the block device open
to read/write from it.  On a file systems the file systems needs to
be mounted, which also holds a bdev reference.

> Also disk always holds one
> reference on request queue, so if disk is valid, no need to grab queue's
> refcnt in bio_poll().

But we need to avoid going into the lowlevel blk-mq polling code to not
reference the potentially freed hctxs or tags as correctly pointed by
yourself on the previous iteration.
