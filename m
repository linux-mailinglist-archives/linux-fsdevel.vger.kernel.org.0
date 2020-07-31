Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462F2233F8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 08:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbgGaG7v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 02:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731566AbgGaG7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 02:59:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692FDC061574;
        Thu, 30 Jul 2020 23:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lDee4pOFLZSB3nuhpAPdiW8K8t8auXkIPj1PU+i4wwU=; b=BRwdExN41fb4azXzQCAyPVCd3Z
        VH/lhXhua5z5h8iRo7NB5hzFaL8GkfpxDJX8e7kBGZI0c4W80SeT6UG5xRoyUB2ofgf15DjlNmuCL
        NbwvefmyLXujmYfQabvNDUuR1H3J4DQmaasi32XE6oBdXI9wNe4vDytUMTT1d73RN+QrSZftXoBuT
        xMEssx6G8IhE3ekT+rTcModhFaKbea8yO7PKeShsvFsObvlf0/V+sWFaN5a2nEFZCYT27M54QJhYV
        y/5RuM2Oj0rm1M2POeu8DmIfmil1gwC3ErIib1qwZNLE6dK4HUBl4V9bMpsUIJY+l2oKjr+MhJEam
        7L61Kckw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1P14-0007p7-31; Fri, 31 Jul 2020 06:59:42 +0000
Date:   Fri, 31 Jul 2020 07:59:41 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yu Kuai <yukuai3@huawei.com>, hch@infradead.org,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [RFC PATCH] iomap: add support to track dirty state of sub pages
Message-ID: <20200731065941.GD25674@infradead.org>
References: <20200730011901.2840886-1-yukuai3@huawei.com>
 <20200730031934.GA23808@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730031934.GA23808@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 04:19:34AM +0100, Matthew Wilcox wrote:
> On Thu, Jul 30, 2020 at 09:19:01AM +0800, Yu Kuai wrote:
> > +++ b/fs/iomap/buffered-io.c
> > @@ -29,7 +29,9 @@ struct iomap_page {
> >  	atomic_t		read_count;
> >  	atomic_t		write_count;
> >  	spinlock_t		uptodate_lock;
> > +	spinlock_t		dirty_lock;
> 
> No need for a separate spinlock.  Just rename uptodate_lock.  Maybe
> 'bitmap_lock'.

Agreed.

> 
> >  	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
> > +	DECLARE_BITMAP(dirty, PAGE_SIZE / 512);
> 
> This is inefficient and poses difficulties for the THP patchset.
> Maybe let the discussion on removing the ->uptodate array finish
> before posting another patch for review?

I really don't think we can kill the uptodate bit.   But what we can
do is have on bitmap array (flex size as in your prep patches) and just
alternating bits for uptodate and dirty.
