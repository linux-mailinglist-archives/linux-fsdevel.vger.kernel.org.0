Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24E747E474
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 15:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243771AbhLWOSo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 09:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLWOSm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 09:18:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B989AC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 06:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=af1HB3iQXtGY96eAtIbQ9A2o1JhPBSZtPCS4+NWkcYE=; b=YCkfflfGOS/KJkEKl9FUzUTPgv
        RreldabdUEmgYccieLGO3w1FVa3jKrgGJVGi8ALVuSgYm/9tb+8rjjPZHJEZC+6HAVMc8UNuZeoX9
        iA9/roErqV/34tpixMZCVKjiaqZFTWPwi67/+0jq0nxlFh0RzobZiCo7ovlJ92EQaHd5Molfgge2X
        KUaIBS6x9NvP5tWVPgBGDNif7IORhKDjMKrN0wdIgT7FDHnqG+brOOiRBCfwxoJ7z1DJH0rhWlTCA
        1VYu+k9zTLu/4gBKojVz+KdYVwwxPkzjDV2MoygmjmRap4cmZkra7CyWBaFCqCXTlAGDsEBgKsvkH
        j9yBdj0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0OvZ-004KUh-0W; Thu, 23 Dec 2021 14:18:41 +0000
Date:   Thu, 23 Dec 2021 14:18:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/48] pagevec: Add folio_batch
Message-ID: <YcSFQBrz9vgroel9@casper.infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-6-willy@infradead.org>
 <YcQdI9lvCfBY8odQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcQdI9lvCfBY8odQ@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:54:27PM -0800, Christoph Hellwig wrote:
> On Wed, Dec 08, 2021 at 04:22:13AM +0000, Matthew Wilcox (Oracle) wrote:
> > +static inline void folio_batch_release(struct folio_batch *fbatch)
> > +{
> > +	pagevec_release((struct pagevec *)fbatch);
> > +}
> > +
> > +static inline void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
> > +{
> > +	pagevec_remove_exceptionals((struct pagevec *)fbatch);
> > +}
> 
> I think these casts need documentation, both here and at the
> struct folio_batch and struct pagevec definitions.
> 
> Alternatively I wonder if a union in stuct pagevec so that it can store
> folios or pages might be the better option.

I tried that way first, but then the caller & callee need to agree
whether they're storing folios or pages in the pagevec.  And that's kind
of why we have types.

pagevec_remove_exceptionals() goes away by the end of this series.
pagevec_release() will take longer to remove.  What documentation
do you want to see?
