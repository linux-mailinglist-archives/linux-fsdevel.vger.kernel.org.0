Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BB6681BF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 22:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjA3VAH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 16:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA3VAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:00:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAC34614A;
        Mon, 30 Jan 2023 13:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iMH79EDuldmDv/JRm60H7Tyu5jJ616aQwUiAS1dltUo=; b=V9mbvogyZQlauwp8YV9juJqWSt
        SKIyk8Hg0B+APk0YvAn4Hl88bgLMYjFK3xE4nkehlqqQ8IZHGE2QRz26UCQSsrpA03rG2hthgNi8B
        a67mpBT+HEUAdmbvV5Rhe2ZvXS5QKtEb+zW9Kc8LpfCsNlgqCmoQDCK/vi/23uIsLGqc5V2iX0znk
        cKL73Cye1P9cNQJDWftjE5yLnM40CZ7NZOcLT6XWXvwf3JkIgVzAAdbwd0ByWpfo5yAZl/x+E1qfH
        LaAaokkRWep0BPoJMhWop5QoNmEQbe0bihaCE7LHrhHwBVWQddu/Mbr6oKi7cya2JUSxY2yHusz6C
        XdIedePQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMbFx-00AgYh-1p; Mon, 30 Jan 2023 21:00:01 +0000
Date:   Mon, 30 Jan 2023 21:00:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 1/3] iomap: Move creation of iomap_page early in
 __iomap_write_begin
Message-ID: <Y9gv0YV9V6gR9l3F@casper.infradead.org>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <d879704250b5f890a755873aefe3171cbd193ae9.1675093524.git.ritesh.list@gmail.com>
 <Y9f4MFzpFEi73E6P@infradead.org>
 <20230130202150.pfohy5yg6dtu64ce@rh-tp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130202150.pfohy5yg6dtu64ce@rh-tp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 31, 2023 at 01:51:50AM +0530, Ritesh Harjani (IBM) wrote:
> > > Thus the iop structure will only gets allocated at the time of writeback
> > > in iomap_writepage_map(). This I think, was a not problem till now since
> > > we anyway only track uptodate status in iop (no support of tracking
> > > dirty bitmap status which later patches will add), and we also end up
> > > setting all the bits in iomap_page_create(), if the page is uptodate.
> >
> > delayed iop allocation is a feature and not a bug.  We might have to
> > refine the criteria for sub-page dirty tracking, but in general having
> > the iop allocates is a memory and performance overhead and should be
> > avoided as much as possible.  In fact I still have some unfinished
> > work to allocate it even more lazily.
> 
> So, what I meant here was that the commit[1] chaged the behavior/functionality
> without indenting to. I agree it's not a bug.

It didn't change the behaviour or functionality.  It broke your patches,
but it certainly doesn't deserve its own commit reverting it -- because
it's not wrong.

> But when I added dirty bitmap tracking support, I couldn't understand for
> sometime on why were we allocating iop only at the time of writeback.
> And it was due to a small line change which somehow slipped into this commit [1].
> Hence I made this as a seperate patch so that it doesn't slip through again w/o
> getting noticed/review.

It didn't "slip through".  It was intended.

> Thanks for the info on the lazy allocation work. Yes, though it is not a bug, but
> with subpage dirty tracking in iop->state[], if we end up allocating iop only
> at the time of writeback, than that might cause some performance degradation
> compared to, if we allocat iop at ->write_begin() and mark the required dirty
> bit ranges in ->write_end(). Like how we do in this patch series.
> (Ofcourse it is true only for bs < ps use case).
> 
> [1]: https://lore.kernel.org/all/20220623175157.1715274-5-shr@fb.com/

You absolutely can allocate it in iomap_write_begin, but you can avoid
allocating it until writeback time if (pos, len) entirely overlap the
folio.  ie:

	if (pos > folio_pos(folio) ||
	    pos + len < folio_pos(folio) + folio_size(folio))
		iop = iomap_page_create(iter->inode, folio, iter->flags, false);
