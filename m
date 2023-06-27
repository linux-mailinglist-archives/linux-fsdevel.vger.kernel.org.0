Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2276873EF9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 02:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjF0ANb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 20:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjF0ANa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:13:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D19DE5A;
        Mon, 26 Jun 2023 17:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U/tKJDeC9Ma6SKor5x7zCPydbUPIhxnfEKbFjUGAIjU=; b=vB3uUOC03Z/e1lfLsyUOHxeQ7y
        ktAhXuhL6tHs4lLOLjxfGOmXj1JfrwyianGS2N0GVFskczZnGvNLVKqAbqX6qP7dhs5rsApb1CeZB
        79U7VdiTafVYNFgjU1r1G68WOzmB8gd5l18sGALhgWVrUSWzyEV+1Gkhn92zbgTSIGk1rSBbnljhb
        /dKl23kxEFmQrZHe++tdrgO9MLkLSOAFvVWBW3pxAD/NPerkXXlNQ8D2m9w4Tq+hQ6vDxEVVgN2st
        rUO1dcdPKTT2ljMbUHse4nfZ+HWsFUH1yFtYzPLWyjolGSrdrx/6K7N0Fs9uJkhlu1xCniZK+Agz0
        FgUoIkqw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDwKj-002BL7-Gf; Tue, 27 Jun 2023 00:13:25 +0000
Date:   Tue, 27 Jun 2023 01:13:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: Re: [PATCH] fs/buffer.c: remove per-CPU buffer_head lookup cache
Message-ID: <ZJoppezn+EiLQvUm@casper.infradead.org>
References: <ZJnTRfHND0Wi4YcU@tpad>
 <ZJndTjktg17nulcs@casper.infradead.org>
 <ZJofgZ/EHR8kFtth@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJofgZ/EHR8kFtth@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 09:30:09AM +1000, Dave Chinner wrote:
> On Mon, Jun 26, 2023 at 07:47:42PM +0100, Matthew Wilcox wrote:
> > On Mon, Jun 26, 2023 at 03:04:53PM -0300, Marcelo Tosatti wrote:
> > > Upon closer investigation, it was found that in current codebase, lookup_bh_lru
> > > is slower than __find_get_block_slow:
> > > 
> > >  114 ns per __find_get_block
> > >  68 ns per __find_get_block_slow
> > > 
> > > So remove the per-CPU buffer_head caching.
> > 
> > LOL.  That's amazing.  I can't even see why it's so expensive.  The
> > local_irq_disable(), perhaps?  Your test case is the best possible
> > one for lookup_bh_lru() where you're not even doing the copy.
> 
> I think it's even simpler than that.
> 
> i.e. the lookaside cache is being missed, so it's a pure cost and
> the code is always having to call __find_get_block_slow() anyway.

How does that happen?

__find_get_block(struct block_device *bdev, sector_t block, unsigned size)
{
        struct buffer_head *bh = lookup_bh_lru(bdev, block, size);

        if (bh == NULL) {
                /* __find_get_block_slow will mark the page accessed */
                bh = __find_get_block_slow(bdev, block);
                if (bh)
                        bh_lru_install(bh);

The second (and all subsequent) calls to __find_get_block() should find
the BH in the LRU.

> IMO, this is an example of how lookaside caches are only a benefit
> if the working set of items largely fits in the lookaside cache and
> the cache lookup itself is much, much slower than a lookaside cache
> miss.

But the test code he posted always asks for the same buffer each time.
So it should find it in the lookaside cache?
