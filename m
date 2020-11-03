Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA56E2A4977
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 16:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgKCPYk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 10:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgKCPYj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:24:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C21DC0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 07:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IsUXNrto464dQH3Wc9ET6gj2wgCGm2mi1KG8sqhLC/A=; b=m13hV2ZWSI/tCXUSOZFhCkLOn4
        M8VHgyvOcL3nKnes4mIOJ78DGf6lJUjAjTINZjEe7jKVaOK4TIYJsmHRpik3hJL4/Af15IaMp4t3U
        6CwcF61Oqb2fqlGQ3PaU0F/YXIT25cPGxDqidKM8Tb9Oy5ysCA2MDMQVYnnDJOG8Pg41yn0uj9egz
        S199wIRG/Yl5AnQphwSDvX9c/i9pb2mFlJv94z4UCnp4NQ9HNfwg3CcJvfjcHHesVBotvCqJSjhTH
        WKlRVbVgOCaeC/BTzuEm4B4JLsyuIzEn/pex5hw8gnw7HAserzcmGXiyzbdVU4G8nX1LbsdtDxduY
        jzG5bCyg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZyAn-0006tA-40; Tue, 03 Nov 2020 15:24:37 +0000
Date:   Tue, 3 Nov 2020 15:24:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 15/17] mm/filemap: Don't relock the page after calling
 readpage
Message-ID: <20201103152436.GA27442@casper.infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-16-willy@infradead.org>
 <20201103080045.GN8389@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103080045.GN8389@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 09:00:45AM +0100, Christoph Hellwig wrote:
> On Mon, Nov 02, 2020 at 06:43:10PM +0000, Matthew Wilcox (Oracle) wrote:
> > We don't need to get the page lock again; we just need to wait for
> > the I/O to finish, so use wait_on_page_locked_killable() like the
> > other callers of ->readpage.
> 
> As that isn't entirely obvious, what about adding a comment next to
> the wait_on_page_locked_killable call to document it?

The other callers of ->readpage don't document that, so not sure why
we should here?

> > +	error = wait_on_page_locked_killable(page);
> >  	if (error)
> >  		return error;
> > +	if (PageUptodate(page))
> > +		return 0;
> > +	if (!page->mapping)	/* page truncated */
> > +		return AOP_TRUNCATED_PAGE;
> > +	shrink_readahead_size_eio(&file->f_ra);
> > +	return -EIO;
> 
> You might notice a theme here, but I hate having the fast path exit
> early without a good reason, so I'd be much happier with:
> 
> 	if (!PageUptodate(page)) {
> 		if (!page->mapping)	/* page truncated */
> 			return AOP_TRUNCATED_PAGE;
> 		shrink_readahead_size_eio(&file->f_ra);
> 		return -EIO;
> 	}
> 	return 0;

I'm just not a fan of unnecessary indentation.
