Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D07851B75A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 07:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbiEEFKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 01:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiEEFKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 01:10:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1219A21821
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 22:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9PrPNmBhAHNOUCiQSrzoiosrqwYC9au1GgJc1tRaZwY=; b=k98IFlHfj9Dtr1wK3d7mqWdqdk
        vnrPf/2iMSrbnVpNIMo0VCQIDT1Aeked9xGbNM8bHYc6yO+NhaOu7mRf48AHeOFgYa0nlwKNY8Ueh
        EkMogrnEvgSqdIWXUGslH3yxz40mIH92ULN33WbXh5lOrjCJTt2C+Pe1qXdlIZDRAHGEvxIPGmWjT
        ZjMyJLCfmIjhl/WaRBM5JFme5GX8oJ9+5nwTQzwj9oeX4v0hrfDFgrFBhi+i0MFGXAaLP/lPfY+jU
        SObp54GS+5y7/w/0FwQMY/rE9a2tdMLXC47CB3V9E6Mf8U8qrRH+09Rj/6vA034U6X+/2pZ/6oOOB
        oZnGxCMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmThn-00HHZQ-Fz; Thu, 05 May 2022 05:07:11 +0000
Date:   Thu, 5 May 2022 06:07:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH 00/10] Make O_SYNC writethrough
Message-ID: <YnNbf9dPhJ3FiHzH@casper.infradead.org>
References: <20220503064008.3682332-1-willy@infradead.org>
 <20220505045821.GA1949718@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505045821.GA1949718@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 05, 2022 at 02:58:21PM +1000, Dave Chinner wrote:
> On Tue, May 03, 2022 at 07:39:58AM +0100, Matthew Wilcox (Oracle) wrote:
> > This is very much in development and basically untested, but Damian
> > started describing to me something that he wanted, and I told him he
> > was asking for the wrong thing, and I already had this patch series
> > in progress.  If someone wants to pick it up and make it mergable,
> > that'd be grand.
> 
> That've very non-descriptive. Saying "someone wanted something, I said it's
> wrong, so here's a patch series about something else" doesn't tell me anything
> about the problem that Damien was trying to solve.

Sorry about that.  I was a bit jet-lagged when I wrote it.

> > The idea is that an O_SYNC write is always going to want to write, and
> > we know that at the time we're storing into the page cache.  So for an
> > otherwise clean folio, we can skip the part where we dirty the folio,
> > find the dirty folios and wait for their writeback.
> 
> What exactly is this shortcut trying to optimise away? A bit of CPU
> time?
> 
> O_SYNC is already a write-through operation - we just call
> filemap_write_and_wait_range() once we've copied the data into the
> page cache and dirtied the page. What does skipping the dirty page
> step gain us?

Two things; the original reason I was doing this, and Damien's reason.

My reason: a small write to a large folio will cause the entire folio to
be dirtied and written.  This is unnecessary with O_SYNC; we're about
to force the write anyway; we may as well do the write of the part of
the folio which is modified, and skip the whole dirtying step.

Damien's reason: It's racy.  Somebody else (... even vmscan) could cause
folios to be written out of order.  This matters for ZoneFS because
writing a file out of order is Not Allowed.  He was looking at relaxing
O_DIRECT, but I think what he really wants is a writethrough page cache.

> > We can just mark the
> > folio as writeback-in-progress and start the IO there and then (where we
> > know exactly which blocks need to be written, so possibly a smaller I/O
> > than writing the entire page).  The existing "find dirty pages, start
> > I/O and wait on them" code will end up waiting on this pre-started I/O
> > to complete, even though it didn't start any of its own I/O.
> > 
> > The important part is patch 9.  Everything before it is boring prep work.
> > I'm in two minds about whether to keep the 'write_through' bool, or
> > remove it.  So feel to read patches 9+10 squashed together, or as if
> > patch 10 doesn't exist.  Whichever feels better.
> > 
> > The biggest problem with all this is that iomap doesn't have the necessary
> > information to cause extent allocation, so if you do an O_SYNC write
> > to an extent which is HOLE or DELALLOC, we can't do this optimisation.
> > Maybe that doesn't really matter for interesting applications.  I suspect
> > it doesn't matter for ZoneFS.
> 
> This seems like a lot of complexity for only partial support. It
> introduces races with page dirtying and cleaning, it likely has
> interesting issues with all the VM dirty/writeback accounting
> (because this series is using a completion path that expects the
> submission path has done it's side of the accounting) and it only
> works in certain preconditions are met.

If we want to have better O_SYNC support, I think we can improve those
conditions.  For example, XFS could preallocate the blocks before calling
into iomap.  Since it's an O_SYNC write, everything is already terrible.
