Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B6551B74C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 06:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbiEEFCH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 01:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiEEFCG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 01:02:06 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C53D41F86
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 21:58:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id BCDF6534663;
        Thu,  5 May 2022 14:58:23 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nmTZF-008ByF-PH; Thu, 05 May 2022 14:58:21 +1000
Date:   Thu, 5 May 2022 14:58:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH 00/10] Make O_SYNC writethrough
Message-ID: <20220505045821.GA1949718@dread.disaster.area>
References: <20220503064008.3682332-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503064008.3682332-1-willy@infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62735971
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=9IrBKQgY0YAoGv9hgi0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 03, 2022 at 07:39:58AM +0100, Matthew Wilcox (Oracle) wrote:
> This is very much in development and basically untested, but Damian
> started describing to me something that he wanted, and I told him he
> was asking for the wrong thing, and I already had this patch series
> in progress.  If someone wants to pick it up and make it mergable,
> that'd be grand.

That've very non-descriptive. Saying "someone wanted something, I said it's
wrong, so here's a patch series about something else" doesn't tell me anything
about the problem that Damien was trying to solve.

> The idea is that an O_SYNC write is always going to want to write, and
> we know that at the time we're storing into the page cache.  So for an
> otherwise clean folio, we can skip the part where we dirty the folio,
> find the dirty folios and wait for their writeback.

What exactly is this shortcut trying to optimise away? A bit of CPU
time?

O_SYNC is already a write-through operation - we just call
filemap_write_and_wait_range() once we've copied the data into the
page cache and dirtied the page. What does skipping the dirty page
step gain us?

> We can just mark the
> folio as writeback-in-progress and start the IO there and then (where we
> know exactly which blocks need to be written, so possibly a smaller I/O
> than writing the entire page).  The existing "find dirty pages, start
> I/O and wait on them" code will end up waiting on this pre-started I/O
> to complete, even though it didn't start any of its own I/O.
> 
> The important part is patch 9.  Everything before it is boring prep work.
> I'm in two minds about whether to keep the 'write_through' bool, or
> remove it.  So feel to read patches 9+10 squashed together, or as if
> patch 10 doesn't exist.  Whichever feels better.
> 
> The biggest problem with all this is that iomap doesn't have the necessary
> information to cause extent allocation, so if you do an O_SYNC write
> to an extent which is HOLE or DELALLOC, we can't do this optimisation.
> Maybe that doesn't really matter for interesting applications.  I suspect
> it doesn't matter for ZoneFS.

This seems like a lot of complexity for only partial support. It
introduces races with page dirtying and cleaning, it likely has
interesting issues with all the VM dirty/writeback accounting
(because this series is using a completion path that expects the
submission path has done it's side of the accounting) and it only
works in certain preconditions are met.

And I still don't know what problem this code actually trying to
solve....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
