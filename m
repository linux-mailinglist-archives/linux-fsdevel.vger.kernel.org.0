Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896BA29C7E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 19:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371310AbgJ0S6N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 14:58:13 -0400
Received: from casper.infradead.org ([90.155.50.34]:53356 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S371306AbgJ0S6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mE1cwDDEmEjCnd5IdzIeq1L8rwr+K0PfUJkE+ZW/YUw=; b=b4/4PvdY33liOR8x2ruSgiRKg8
        DgfQufrKwk4krix3uddSCJ90fBypGZ5jqxEthiA8wLgWHvzVTiqmOBmF7DGw1F+U1cxZ+hgfy/sci
        rG0R8W79qM7PiMSGqnInGAblwFDSpSkQLUe9l+WseAHcFHUpQoJ0wDuq9bNxpekgx3QbFUp4Dp+BE
        H3xM1AeFVBnHKz3lj7tnOByIKWtXF2+4h2MAuMbQyv4oZQLAUY5UYjOKjqlA8kk4rTDH3YPhPQhPt
        kyUJLBdkS1DzIGvNv6BSM8KwUMNazSO+lB6joRAQLrkmpfMsF3oMkUW5GxmcohVj12mAVXgLe55TD
        WT+Dd5FA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXUAb-0004F1-Qa; Tue, 27 Oct 2020 18:58:09 +0000
Date:   Tue, 27 Oct 2020 18:58:09 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v3 04/12] mm/filemap: Add mapping_seek_hole_data
Message-ID: <20201027185809.GB15201@infradead.org>
References: <20201026041408.25230-1-willy@infradead.org>
 <20201026041408.25230-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026041408.25230-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +/**
> + * mapping_seek_hole_data - Seek for SEEK_DATA / SEEK_HOLE in the page cache.
> + * @mapping: Address space to search.
> + * @start: First byte to consider.
> + * @end: Limit of search (exclusive).
> + * @whence: Either SEEK_HOLE or SEEK_DATA.
> + *
> + * If the page cache knows which blocks contain holes and which blocks
> + * contain data, your filesystem can use this function to implement
> + * SEEK_HOLE and SEEK_DATA.  This is useful for filesystems which are
> + * entirely memory-based such as tmpfs, and filesystems which support
> + * unwritten extents.
> + *
> + * Return: The requested offset on successs, or -ENXIO if @whence specifies
> + * SEEK_DATA and there is no data after @start.  There is an implicit hole
> + * after @end - 1, so SEEK_HOLE returns @end if all the bytes between @start
> + * and @end contain data.
> + */

This seems to just lift the tmpfs one to common code.  If it really
is supposed to be generic it should be able to replace
page_cache_seek_hole_data as well.  So I don't think moving this without
removing the other common one is an all that good idea.
