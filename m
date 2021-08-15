Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313CA3EC8AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 12:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhHOKyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 06:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhHOKyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 06:54:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB8EC061764;
        Sun, 15 Aug 2021 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BPpQnC+2U721SzsLqmKDnAhfH5B8tesCsHy+xocU1F0=; b=uPCnuqIVC7EMq+U9nIXh1InckD
        RvEC4JUXgEZRkbPhnQjM475xx+aRmSPe1qS4HuYil7vHWaR5WuBJYGKrtztsBr/jCSb8QyqC3yzTu
        0nmS8ZEDGTSkpCehVEs1HdrfyZHJ8vIOSg2NDcaA1Y0JW96c3ggaYwnaesE7lYjAmbAMDR+MBim5G
        TIJciqqzbed/O4pXdzYDbF37vq7PAisuhun+4kbNF0A7hshjyX//SeGQ1fze/L4PMYMGA2wBQzOoc
        /yD8B2hPI98JIdjz0RRxZDtrEF330DjoPauoosVisalNpp8Fjvl3hR3WCySPAwdYSmIq3hVhG9QtZ
        jIq6IU9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFDmB-0005BS-Pt; Sun, 15 Aug 2021 10:54:06 +0000
Date:   Sun, 15 Aug 2021 11:53:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 072/138] mm/writeback: Add folio_account_cleaned()
Message-ID: <YRjyR/5DMyCChe6p@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-73-willy@infradead.org>
 <ea89a40c-68b3-c54d-8e7f-3c09757ddd8d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea89a40c-68b3-c54d-8e7f-3c09757ddd8d@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 06:14:22PM +0200, Vlastimil Babka wrote:
> On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> > Get the statistics right; compound pages were being accounted as a
> > single page.  This didn't matter before now as no filesystem which
> > supported compound pages did writeback.  Also move the declaration
> > to filemap.h since this is part of the page cache.  Add a wrapper for
> 
> Seems to be pagemap.h :)

Ugh, right.  filemap.c.  pagemap.h.  obviously.

> > +		wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
> > +		task_io_account_cancelled_write(folio_size(folio));
> 
> In "mm/writeback: Add __folio_mark_dirty()" you used nr*PAGE_SIZE. Consistency?

We don't have any ;-)  I'll change that.  Some places we use <<
PAGE_SHIFT, some places we use * PAGE_SIZE ... either are better than
calling folio_size() unnecessarily.
