Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB6B179420
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 16:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgCDPz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 10:55:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgCDPz3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9QQq9u6kSfHiorY+/vLIa3epilFmkrg1M/ZbdVdNKdY=; b=tM9xZtDis4Q/g4RkNbzO+uGs0A
        ZHxmPKRRssL3h9i1PyPKQ/k5uPlfJNbBBLJSSKXqsiftmQf3kGfm2F/ijAvEX5mf3WMwOQVeNDaPr
        t56qEfCRxfoOUvVQzlYCDBzuJ+sS1glG7ZIKn6fa4Kw/+FHEzPfDvb8FIRmw0GxKQWDknP2Df9WX2
        H6B8QQMiv+tcGEH3huMe+ZVtUunmeJo2tY5wr9WM0/XXPUJyr9q9xffd2ZpHH9PAShIAxds/tKazF
        jM9jbVA5IBQ8BB+4TnpgD6QTj8yUiLFd/IHzphu2c5NiX0ycuB317scVYSDa4tw2K35Q6RUWAHrIk
        iAbrf4SQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9WMq-0003Zd-Rw; Wed, 04 Mar 2020 15:55:28 +0000
Date:   Wed, 4 Mar 2020 07:55:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] iomap: Remove pgoff from tracepoints
Message-ID: <20200304155528.GJ17565@infradead.org>
References: <20200304154706.GH29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304154706.GH29971@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 07:47:06AM -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> The 'pgoff' displayed by the tracepoints wasn't a pgoff at all; it
> was a byte offset from the start of the file.  We already emit that in
> the form of the 'offset', so we can just remove pgoff.  That means we
> can remove 'page' as an argument to the tracepoint, and rename this
> type of tracepoint from being a page class to being a range class.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7057ef155a29..cab29ffb2b40 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -487,7 +487,7 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
>  int
>  iomap_releasepage(struct page *page, gfp_t gfp_mask)
>  {
> -	trace_iomap_releasepage(page->mapping->host, page, 0, 0);
> +	trace_iomap_releasepage(page->mapping->host, 0, 0);

I think we should pass page_offset() for the offset here now.  Maybe
also PAGE_SIZE len for completeness while we're at it.

> @@ -1503,7 +1503,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  	u64 end_offset;
>  	loff_t offset;
>  
> -	trace_iomap_writepage(inode, page, 0, 0);
> +	trace_iomap_writepage(inode, 0, 0);

Same here.
