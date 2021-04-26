Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA336B567
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 17:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhDZPHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 11:07:23 -0400
Received: from verein.lst.de ([213.95.11.211]:41684 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233825AbhDZPHW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:07:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3DBEE68C4E; Mon, 26 Apr 2021 17:06:38 +0200 (CEST)
Date:   Mon, 26 Apr 2021 17:06:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: switch block layer polling to a bio based model
Message-ID: <20210426150638.GA24618@lst.de>
References: <20210426134821.2191160-1-hch@lst.de> <2d229167-f56d-583b-569c-166c97ce2e71@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d229167-f56d-583b-569c-166c97ce2e71@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 08:57:31AM -0600, Jens Axboe wrote:
> I was separately curious about this as I have a (as of yet unposted)
> patchset that recycles bio allocations, as we spend quite a bit of time
> doing that for high rate polled IO. It's good for taking the above 2.97M
> IOPS to 3.2-3.3M IOPS, and it'd obviously be a bit more problematic with
> required RCU freeing of bio's. Even without the alloc cache, using RCU
> will ruin any potential cache locality on back-to-back bio free + bio
> alloc.

That sucks indeed.  How do you recycle the bios?  If we make sure the
bio is only ever recycled as a bio and bi_bdev remaings valid long
enough we might not need the rcu free.  Even without your recycling
we could probably do something nasty using SLAB_TYPESAFE_BY_RCU.
