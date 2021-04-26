Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B8A36B68E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 18:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhDZQPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 12:15:51 -0400
Received: from verein.lst.de ([213.95.11.211]:41988 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhDZQPu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:15:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C97DE68CFE; Mon, 26 Apr 2021 18:15:04 +0200 (CEST)
Date:   Mon, 26 Apr 2021 18:15:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: switch block layer polling to a bio based model
Message-ID: <20210426161503.GA30994@lst.de>
References: <20210426134821.2191160-1-hch@lst.de> <2d229167-f56d-583b-569c-166c97ce2e71@kernel.dk> <20210426150638.GA24618@lst.de> <6b7e3ba0-aa09-b86d-8ea1-dc2e78c7529e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b7e3ba0-aa09-b86d-8ea1-dc2e78c7529e@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 09:12:09AM -0600, Jens Axboe wrote:
> Here's the series. It's not super clean (yet), but basically allows
> users like io_uring to setup a bio cache, and pass that in through
> iocb->ki_bi_cache. With that, we can recycle them instead of going
> through free+alloc continually. If you look at profiles for high iops,
> we're spending more time than desired doing just that.
> 
> https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-bio-cache

So where do you spend the cycles?  The do not memset the whole bio
optimization is pretty obvious and is someting we should do independent
of the allocator.

The other thing that sucks is the mempool implementation, as it forces
each allocation and free to do an indirect call.  I think it might be
worth to try to frontend it with a normal slab cache and only fall back
to the mempool if that fails.
