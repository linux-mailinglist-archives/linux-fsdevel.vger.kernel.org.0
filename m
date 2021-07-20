Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D913CF997
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 14:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbhGTLsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 07:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbhGTLrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:47:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6673C061762;
        Tue, 20 Jul 2021 05:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EBtMOByrcNZTpZamd7vqMiPT8BGfzfVoE5+l0Oro6Xc=; b=wZKBntg2iI5dfqysaj6yR+A3KC
        Cuh6iTF59q/wLsk6V/sBVbI0jBpUkR+mm4G85ldiarVSdPUrY33Sqm5qwXB6zcaw6GJA3j7fmNrVq
        bI7/8Fyuk0V/20UeAO3ybRSXvuaUO9vNYHDuV7q36fN870fDzsxV8Xz7ncF6GpUvw7W8xwiLNbyho
        UlID7Wn41APR924AoMsudi/KU65WcdNhd1WnYFs1PWIFeHRmXQzSD2P+3HKVve80LHnWmYooZ91di
        eUSaScYAioNHhHmbeja1066NqcC7v5ufjWqCA+0sJjbomKX6Hx2TZ4/c9wgFNmadMCsa3S7wrDuZQ
        aeAk8TVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5oqK-0085x6-Vm; Tue, 20 Jul 2021 12:27:33 +0000
Date:   Tue, 20 Jul 2021 13:27:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: simplify iomap_readpage_actor
Message-ID: <YPbBLCphExqjig1O@casper.infradead.org>
References: <20210720084320.184877-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720084320.184877-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 10:43:19AM +0200, Christoph Hellwig wrote:
> Now that the outstanding reads are counted in bytes, there is no need
> to use the low-level __bio_try_merge_page API, we can switch back to
> always using bio_add_page and simply iomap_readpage_actor again.

I don't think this quite works.  You need to check the return value
from bio_add_page(), otherwise you can be in a situation where you try
to add a page to the last bvec and it's not contiguous, so it fails.

I was imagining something more like this:

-       bool same_page = false, is_contig = false;
+       bool is_contig = false;
...
        /* Try to merge into a previous segment if we can */
        sector = iomap_sector(iomap, pos);
-       if (ctx->bio && bio_end_sector(ctx->bio) == sector) {
-               if (__bio_try_merge_page(ctx->bio, page, plen, poff,
-                               &same_page))
-                       goto done;
-               is_contig = true;
-       }
+       if (ctx->bio && bio_end_sector(ctx->bio) == sector)
+               is_contig = bio_add_page(ctx->bio, page, plen, poff) > 0;

-       if (!is_contig || bio_full(ctx->bio, plen)) {
+       if (!is_contig) {
                gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
                gfp_t orig_gfp = gfp;
...
                bio_set_dev(ctx->bio, iomap->bdev);
                ctx->bio->bi_end_io = iomap_read_end_io;
+               bio_add_page(ctx->bio, page, plen, poff);
        }

-       bio_add_page(ctx->bio, page, plen, poff);
 done:
        /*

