Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10F074781C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 20:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGDSDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 14:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGDSDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:03:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456F010CA;
        Tue,  4 Jul 2023 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DnSneZk2dwwUszQpTYSf7MYjJAwskKKHrxvlsvcy1u8=; b=YHpSDLiTOzNYTkPXom6tOnSnks
        4KhFWeJZ2Zpl0oThz4UFqyR4LbiVqcZq86EvVWZT1K1oiV1asaN0bfGSa89P+EpnPhytYiqTuXhO6
        aYXbM7N5LZ1D9X3LOUoJdGfk25FyBcOHy4jV0VW+bUqqLQgK8a+4F6v9aitNZCCc/XQFt1gfm8Dzy
        b0yVFhRqYTfMJuWOHtP6yP5xtKM0MW66onj1ecR1YjzVPCUF68y5fbuF+whKKO9EqyZg5lHNv5HyF
        N7nclX31FGTZNDzRWtJOyecHMI4g2CiijqUae68x76nA3CVggAume1r6bLvbR6qMN1j78HZiS8I30
        W3x4463w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qGkMi-009M8M-ER; Tue, 04 Jul 2023 18:03:04 +0000
Date:   Tue, 4 Jul 2023 19:03:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] writeback: Account the number of pages written back
Message-ID: <ZKRe2F9BVioSk8YW@casper.infradead.org>
References: <20230628185548.981888-1-willy@infradead.org>
 <20230702130615.b72616d7f03b3ab4f6fc8dab@linux-foundation.org>
 <ZKIuu6uQQJIQE640@casper.infradead.org>
 <ZKM/jUXRjlq19AXN@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKM/jUXRjlq19AXN@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 04, 2023 at 07:37:17AM +1000, Dave Chinner wrote:
> On Mon, Jul 03, 2023 at 03:13:15AM +0100, Matthew Wilcox wrote:
> > On Sun, Jul 02, 2023 at 01:06:15PM -0700, Andrew Morton wrote:
> > > On Wed, 28 Jun 2023 19:55:48 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> > > 
> > > > nr_to_write is a count of pages, so we need to decrease it by the number
> > > > of pages in the folio we just wrote, not by 1.  Most callers specify
> > > > either LONG_MAX or 1, so are unaffected, but writeback_sb_inodes()
> > > > might end up writing 512x as many pages as it asked for.
> > > 
> > > 512 is a big number,  Should we backport this?
> > 
> > I'm really not sure.  Maybe?  I'm hoping one of the bots comes up with a
> > meaningful performance change as a result of this patch and we find out.
> 
> XFS is the only filesystem this would affect, right? AFAIA, nothing
> else enables large folios and uses writeback through
> write_cache_pages() at this point...

Good point.  Still, Intel's 0day has squawked about a loss of performance
when large folios have _stopped_ being used, so they are at least testing
with XFS.
