Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D8D28E56D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 19:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbgJNRfC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 13:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388388AbgJNRfC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:35:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18BFC061755;
        Wed, 14 Oct 2020 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bFmp8qmgBGhqB/X65ibwSq7YXKtNnPqEkqnUE5CNjEo=; b=e/CJ+gzF8JKH8KtYyrNxYuOSkV
        B454oRZUzlRVyVXJUQWRlJTYtsR8r3hhJHGjfJN1Lci0RKBHG3yxMXwjZPIX+jHCUNpTVTa+J4jKW
        AkKR2toT/nv9lv9ZZT72RmzL2+NPZssaoNRObRc42/aRDwc35u6GvkHpZz0UITqGWF2BFMtla+uyx
        W0BtjjcG8eKeWpDjO6YcChWX2QBThekM5dGa10yQc+bI0l3wY0fRiLiYACT/Zee565bhjAAAJjag/
        H4p3LeTHLebyk99pmv+4UHsysvX3qjsql3DqWx9Lfhyb2ymaQhT5z0SrRobDc/Qd8ZHrDQO5iOmiH
        autXjUeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSkg0-0005Gv-8n; Wed, 14 Oct 2020 17:35:00 +0000
Date:   Wed, 14 Oct 2020 18:35:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 07/14] iomap: Support THPs in readpage
Message-ID: <20201014173500.GR20115@casper.infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
 <20201014030357.21898-8-willy@infradead.org>
 <20201014163936.GJ9832@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014163936.GJ9832@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:39:36AM -0700, Darrick J. Wong wrote:
> On Wed, Oct 14, 2020 at 04:03:50AM +0100, Matthew Wilcox (Oracle) wrote:
> > +/*
> > + * The page that was passed in has become Uptodate.  This may be due to
> > + * the storage being synchronous or due to a page split finding the page
> > + * is actually uptodate.  The page is still locked.
> > + * Lift this into the VFS at some point.
> > + */
> > +#define AOP_UPDATED_PAGE       (AOP_TRUNCATED_PAGE + 1)
> 
> Er... why not lift it now?
> 
> "Because touching fs.h causes the whole kernel to be rebuilt and that's
> annoying"? :D

Hah!  Because I already have a patch series out that does lift it to
the VFS:

https://lore.kernel.org/linux-fsdevel/20201009143104.22673-1-willy@infradead.org/

which I'm kind of hoping gets merged first.  Then I can adjust this patch.

> > +static int iomap_split_page(struct inode *inode, struct page *page)
> > +{
> > +	struct page *head = thp_head(page);
> > +	bool uptodate = iomap_range_uptodate(inode, head,
> > +				(page - head) * PAGE_SIZE, PAGE_SIZE);
> > +
> > +	iomap_page_release(head);
> > +	if (split_huge_page(page) < 0) {
> > +		unlock_page(page);
> > +		return AOP_TRUNCATED_PAGE;
> > +	}
> > +	if (!uptodate)
> > +		return 0;
> > +	SetPageUptodate(page);
> > +	return AOP_UPDATED_PAGE;
> > +}
> > +
> >  int
> >  iomap_readpage(struct page *page, const struct iomap_ops *ops)
> >  {
> >  	struct iomap_readpage_ctx ctx = { .cur_page = page };
> > -	struct inode *inode = page->mapping->host;
> > +	struct inode *inode = thp_head(page)->mapping->host;
> >  	unsigned poff;
> >  	loff_t ret;
> >  
> > -	trace_iomap_readpage(page->mapping->host, 1);
> > +	trace_iomap_readpage(inode, 1);
> > +
> > +	if (PageTransCompound(page)) {
> > +		int status = iomap_split_page(inode, page);
> > +		if (status == AOP_UPDATED_PAGE) {
> > +			unlock_page(page);
> 
> /me wonders why not do the unlock in iomap_split_page?

This is working around AOP_UPDATED_PAGE not existing in the VFS.  So
adjusting this patch becomes:

		int status = iomap_split_page(inode, page);
		if (status)
			return status;
