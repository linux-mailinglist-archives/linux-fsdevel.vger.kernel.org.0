Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF63119033
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 19:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfLJS6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 13:58:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfLJS6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zfXhVy9B767K7H4PjJR005yREJ5bgu9ZcNoGeacGpfc=; b=S3lrVAOKD9e+RcqNq2Fj62ubQ
        fCLdabp/oSuJ+lKtkHlU4SqFGFLm6aCe4lds9k77TBkwFA2dHT6E9vtJqk5Bb7pS3lg48xufiNdCs
        TV7xTTypMs7dnguFN2N6FHqSo+B5omY+Fz53XCSRVHhv036SWsRVggz1zvl929afJnQDdspgnH3R0
        KYjq2RtAtkKT5teTkOmfiDb8ieMGiF8V35f0752VD10Q0Mq7oaHqiefUrNLzja1alz+vbVbCjdZr6
        lx6TcgVuIu2x0XXKShicKEg+jvVjjUX1dNNSCNc5LIWWQX4B7ogQaE8e2UVxWSpiyBXNGqIlPV+GU
        TUmtoEG5Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieki6-0001vC-17; Tue, 10 Dec 2019 18:58:14 +0000
Date:   Tue, 10 Dec 2019 10:58:13 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: make buffered writes work with RWF_UNCACHED
Message-ID: <20191210185813.GK32169@bombadil.infradead.org>
References: <20191210162454.8608-1-axboe@kernel.dk>
 <20191210162454.8608-4-axboe@kernel.dk>
 <20191210165532.GJ32169@bombadil.infradead.org>
 <721d8d7e-9e24-bded-a3c0-fa5bf433e129@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <721d8d7e-9e24-bded-a3c0-fa5bf433e129@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 10:02:18AM -0700, Jens Axboe wrote:
> On 12/10/19 9:55 AM, Matthew Wilcox wrote:
> > On Tue, Dec 10, 2019 at 09:24:52AM -0700, Jens Axboe wrote:
> >> +/*
> >> + * Start writeback on the pages in pgs[], and then try and remove those pages
> >> + * from the page cached. Used with RWF_UNCACHED.
> >> + */
> >> +void write_drop_cached_pages(struct page **pgs, struct address_space *mapping,
> >> +			     unsigned *nr)
> > 
> > It would seem more natural to use a pagevec instead of pgs/nr.
> 
> I did look into that, but they are intertwined with LRU etc. I
> deliberately avoided the LRU on the read side, as it adds noticeable
> overhead and gains us nothing since the pages will be dropped agian.

I agree the LRU uses them, but they're used in all kinds of places where
we need to batch pages, eg truncate, munlock.

