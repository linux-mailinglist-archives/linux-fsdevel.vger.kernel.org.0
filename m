Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5DF74E258
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 01:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjGJXxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 19:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGJXxM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:53:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF871A7;
        Mon, 10 Jul 2023 16:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A6Q3t9rpIawldu6Yx1X0GYeNwxoc9QguKlvcHh+bziQ=; b=cVAyoFNACF6xmxAznT4dzCJjip
        GNFL/T2+fsUQO3sljICNooqVP1aXlJGHAdGPUZbuTDAfYytY7BJ8pMKa1Pc2MGIqKE0F7hsB/evz6
        SlQsdKBtMPGubvBfEpeHxeE7TCPPddWpMGhejZWu0ivrfOmWCqKsACulCmWu7l0VRvLTwSlk9Z4Or
        5OJFW2ZDwPxydtrpQ9HPlrgwB1U0zw6xRy2RknWEA3lh6UqiNan+1E6onF7LnjNAy8UdG6P0YUbS/
        EER3QzzqNRdJDmFiCN0tQARoDfhuII7Z0tHlOCEQS4PgVsGlYDhBEfC7rI9CipVI5df8WquprsVLK
        eF6eAWuA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJ0gi-00F3Ci-H6; Mon, 10 Jul 2023 23:53:04 +0000
Date:   Tue, 11 Jul 2023 00:53:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH v4 0/9] Create large folios in iomap buffered write path
Message-ID: <ZKyZ4Ie6EEc79iIG@casper.infradead.org>
References: <20230710130253.3484695-1-willy@infradead.org>
 <ZKyMVRDhwYWvqyvv@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKyMVRDhwYWvqyvv@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:55:17PM -0700, Luis Chamberlain wrote:
> On Mon, Jul 10, 2023 at 02:02:44PM +0100, Matthew Wilcox (Oracle) wrote:
> > Commit ebb7fb1557b1 limited the length of ioend chains to 4096 entries
> > to improve worst-case latency.  Unfortunately, this had the effect of
> > limiting the performance of:
> > 
> > fio -name write-bandwidth -rw=write -bs=1024Ki -size=32Gi -runtime=30 \
> >         -iodepth 1 -ioengine sync -zero_buffers=1 -direct=0 -end_fsync=1 \
> >         -numjobs=4 -directory=/mnt/test
> 
> When you say performance, do you mean overall throughput / IOPS /
> latency or all?

This is buffered I/O, so when we run out of RAM, we block until the
dirty pages are written back.  I suppose that makes it throughput, but
it's throughput from the bottom of the page cache to storage, not the
usual app-to-page-cache bottleneck.

> And who noticed it / reported it? The above incantation seems pretty
> specific so I'm curious who runs that test and what sort of work flow
> is it trying to replicate.

Wang Yugui, who is on the cc reported it.
https://lore.kernel.org/linux-xfs/20230508172406.1CF3.409509F4@e16-tech.com/

> > The problem ends up being lock contention on the i_pages spinlock as we
> > clear the writeback bit on each folio (and propagate that up through
> > the tree).  By using larger folios, we decrease the number of folios
> > to be processed by a factor of 256 for this benchmark, eliminating the
> > lock contention.
> 
> Implied here seems to suggest that the associated cost for the search a
> larger folio is pretty negligable compared the gains of finding one.
> That seems to be nice but it gets me wondering if there are other
> benchmarks under which there is any penalties instead.
> 
> Ie, is the above a microbenchmark where this yields good results?

It happens to be constructed in such a way that it yields the optimum
outcome in this case, but that clearly wasn't deliberate.  And the
solution is the one I had in mind from before the bug report came in.

I don't think you'll be able to find a benchmark that regresses as
a result of this, but I welcome your attempt!

> > It's also the right thing to do.  This is a project that has been on
> > the back burner for years, it just hasn't been important enough to do
> > before now.
> 
> Commit ebb7fb1557b1 (xfs, iomap: limit individual ioend chain lengths in
> writeback") dates back to just one year, and so it gets me wondering
> how a project in the back burner for years now finds motivation for
> just a one year old regression.
> 
> What was the original motivation of the older project dating this
> effort back to its inception?

We should create larger folios on write.  It just wasn't important
enough to do before now.  But now there's an actual user who cares.
