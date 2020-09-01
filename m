Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B25259167
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 16:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgIAOue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 10:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgIAOu2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:50:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7277CC061244;
        Tue,  1 Sep 2020 07:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Rt/RZHQFZtQJpY49CCYUhZi6SfUgNAgVHQnBlTr1a8=; b=p0kE1kiXY5lbGjtOOeelZHKPdk
        7iMPjVGysg30dWVyHTYa/7qTF85jbeQApGpvwh9vLRAeSov9Kkw9pyOYtg6MLHPei5ysnPcg/D0wP
        OVFO7sIcqeFGxFQF+OWY+FNImcPS1QlADW1bKTujj68AEqLLCmI22G2oHbx/iSdPe6dZJqZ0ndze2
        wdSk3Lg3vBJLzB0pSQXyzKM7zWDzdte/mlFQmSFd1sb7kZifW1JTL+PcnrV+c878uuvpb5Zz2eth7
        EZ58fYYp9C0RNZ+YM3mPSztxfw3WkMAdW64l27FlJElaZ++LGU7SJUCyKFQ5EOgkvEaxpEY4s7y+c
        juZfy6Iw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kD7c9-0006mc-FV; Tue, 01 Sep 2020 14:50:25 +0000
Date:   Tue, 1 Sep 2020 15:50:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] block: Add bio_for_each_thp_segment_all
Message-ID: <20200901145025.GA23220@infradead.org>
References: <20200824151700.16097-1-willy@infradead.org>
 <20200824151700.16097-5-willy@infradead.org>
 <20200827084431.GA15909@infradead.org>
 <20200831194837.GJ14765@casper.infradead.org>
 <20200901053426.GB24560@infradead.org>
 <20200901130525.GK14765@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901130525.GK14765@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 01, 2020 at 02:05:25PM +0100, Matthew Wilcox wrote:
> > >                 struct page *page = bvec->bv_page;
> > > 
> > >                 while (length > 0) { 
> > >                         size_t count = thp_size(page) - offset;
> > >                         
> > >                         if (count > length)
> > >                                 count = length;
> > >                         iomap_read_page_end_io(page, offset, count, error);
> > >                         page += (offset + count) / PAGE_SIZE;
> > 
> > Shouldn't the page_size here be thp_size?
> 
> No.  Let's suppose we have a 20kB I/O which starts on a page boundary and
> the first page is order-2.  To get from the first head page to the second
> page, we need to add 4, which is 16kB / 4kB, not 16kB / 16kB.

True.

> I'm not entirely sure the bvec would shrink.  On 64-bit systems, it's
> currently 8 bytes for the struct page, 4 bytes for the len and 4 bytes
> for the offset.  Sure, we can get rid of the offset, but the compiler
> will just pad the struct from 12 bytes back to 16.  On 32-bit systems
> with 32-bit phys_addr_t, we go from 12 bytes down to 8, but most 32-bit
> systems have a 64-bit phys_addr_t these days, don't they?

Actually on those system that still are 32-bit because they are so
tiny I'd very much still expect a 32-bit phys_addr_t.  E.g. arm
without LPAE or 32-bit RISC-V.

But yeah, point taken on the alignment for the 64-bit ones.

> That's a bit more boilerplate than I'd like, but if bio_vec is going to
> lose its bv_page then I don't see a better way.  Unless we come up with
> a different page/offset/length struct that bio_vecs are decomposed into.

I'm not sure it is going to lose bv_page any time soon.  I'd sure like
to, but least time something like that came up Linus wasn't entirely
in favor.  Things might have changed now, though and I think it is about
time to give it another try.
