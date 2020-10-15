Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A2228EFA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 11:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgJOJwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 05:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgJOJwb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:52:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7724C061755;
        Thu, 15 Oct 2020 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0sspeSzbMoNOt+Y0+5s4yntOhLMzul98HqpZU5SErqs=; b=YQ26DI0u/Owi43kA4Sv1XieZQR
        z4qVuuSWD8uFaQWwEwWszMjI+6FGJJw8+aXJ4jGBz+RNSaTobMu1oOk+G325wRys8NiQFmVT2QyEP
        RS3tz1ttA3c1hwNN/bqMthE3LuLxXtHby7vsD947QqFW0/eRNFQZHPNCoUaSrKswAnX1nUbwqkCq0
        9RE5eNJQsqb8xxCfoH5vTf8LoWIyjJhJ2KTbLC6JaZaDL0HaVy3ypArePCeChdis551g6woEYliaI
        MiFvlW/RfuAvWq7gEnv32HCHe8BAfVO2ok337yxJhhGf2tTfYD0EJYY1Cdb2LwLPxsE780jTHBKtW
        UDQY82Uw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSzvx-0006JF-C4; Thu, 15 Oct 2020 09:52:29 +0000
Date:   Thu, 15 Oct 2020 10:52:29 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 08/14] iomap: Support THPs in readahead
Message-ID: <20201015095229.GC23441@infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
 <20201014030357.21898-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014030357.21898-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 04:03:51AM +0100, Matthew Wilcox (Oracle) wrote:
> +/*
> + * Estimate the number of vectors we need based on the current page size;
> + * if we're wrong we'll end up doing an overly large allocation or needing
> + * to do a second allocation, neither of which is a big deal.
> + */
> +static unsigned int iomap_nr_vecs(struct page *page, loff_t length)
> +{
> +	return (length + thp_size(page) - 1) >> page_shift(page);
> +}

This doesn't seem iomap specific, and would seems useful also for e.g.
direct I/O.
