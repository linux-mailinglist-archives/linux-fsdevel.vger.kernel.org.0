Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC7638ED46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 17:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbhEXPfm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 11:35:42 -0400
Received: from verein.lst.de ([213.95.11.211]:55288 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233654AbhEXPeR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 11:34:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 57D6667373; Mon, 24 May 2021 17:32:47 +0200 (CEST)
Date:   Mon, 24 May 2021 17:32:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: iomap: writeback ioend/bio allocation deadlock risk
Message-ID: <20210524153247.GA6041@lst.de>
References: <YKcouuVR/y/L4T58@T590> <20210521071727.GA11473@lst.de> <YKdhuUZBtKMxDpsr@T590> <20210521073547.GA11955@lst.de> <YKdwtzp+WWQ3krhI@T590> <20210521083635.GA15311@lst.de> <YKd1VS5gkzQRn+7x@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKd1VS5gkzQRn+7x@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 04:54:45PM +0800, Ming Lei wrote:
> On Fri, May 21, 2021 at 10:36:35AM +0200, Christoph Hellwig wrote:
> > On Fri, May 21, 2021 at 04:35:03PM +0800, Ming Lei wrote:
> > > Just wondering why the ioend isn't submitted out after it becomes full?
> > 
> > block layer plugging?  Although failing bio allocations will kick that,
> > so that is not a deadlock risk.
> 
> These ioends are just added to one list stored on local stack variable(submit_list),

Yes.  But only until the code finished iterating over a page.  The
worst case number of bios for a page is PAGE_SIZE / SECTOR_SIZE, and
the bio_set is side to handle that comfortably.

> how can block layer plugging observe & submit them out?

It can't.  I was talking about the high-level plug that is held
over multiple pages.  At that point the bios are submitted to the
block layer already, but they might be held in a plug.  And looking at
the bio_alloc_bioset code we don't actually flush a plug at the moment
in that case.  Something like the patch below would do that:

diff --git a/block/bio.c b/block/bio.c
index 44205dfb6b60..5b9d2f4d7c08 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -432,6 +432,7 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned short nr_iovecs,
 
 	p = mempool_alloc(&bs->bio_pool, gfp_mask);
 	if (!p && gfp_mask != saved_gfp) {
+		blk_schedule_flush_plug(current);
 		punt_bios_to_rescuer(bs);
 		gfp_mask = saved_gfp;
 		p = mempool_alloc(&bs->bio_pool, gfp_mask);
