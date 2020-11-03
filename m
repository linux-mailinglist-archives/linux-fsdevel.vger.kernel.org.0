Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBADA2A4F73
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 19:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgKCSzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 13:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgKCSzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:55:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45858C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 10:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=55Rk7l095QACDFFB0DO6Z0QPESjg61svdadMOXv8hNA=; b=fU8/96JTG/VRQhvHHdYnYxcMzn
        S2GXsDxJuEc0QEs8f0BBkET8bOjdXEdIgt9ghvTJPxpEZKBEObhcqqT2CxDeUrXjy/ubpVzTKMi8Q
        O1MvM3e42I8liHdvbgO0QfsoBPnN1kVL2D4t9fwjKSkRAsaGCsM18TxP6iLttoW2mWfUNrrCvvd8A
        Hhgn8M7FiPohPldTaP2DcN/FhFeZMKoArtse4wL5F47izGJdRKRmaad7gv50B6rw4WHjS6IGhzHiO
        SpHhMgN6oBYLfDXUCBuR+oFb9+7PHUUA4PpYKgpy4DNVy44QEbIK2YvvK24BzdoGHjt7LaImvCipZ
        p8zE5HUg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ka1TA-0005hb-Gx; Tue, 03 Nov 2020 18:55:48 +0000
Date:   Tue, 3 Nov 2020 18:55:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 15/17] mm/filemap: Don't relock the page after calling
 readpage
Message-ID: <20201103185548.GD27442@casper.infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-16-willy@infradead.org>
 <20201103080045.GN8389@lst.de>
 <20201103152436.GA27442@casper.infradead.org>
 <20201103171356.GA18303@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103171356.GA18303@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 06:13:56PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 03, 2020 at 03:24:36PM +0000, Matthew Wilcox wrote:
> > On Tue, Nov 03, 2020 at 09:00:45AM +0100, Christoph Hellwig wrote:
> > > On Mon, Nov 02, 2020 at 06:43:10PM +0000, Matthew Wilcox (Oracle) wrote:
> > > > We don't need to get the page lock again; we just need to wait for
> > > > the I/O to finish, so use wait_on_page_locked_killable() like the
> > > > other callers of ->readpage.
> > > 
> > > As that isn't entirely obvious, what about adding a comment next to
> > > the wait_on_page_locked_killable call to document it?
> > 
> > The other callers of ->readpage don't document that, so not sure why
> > we should here?
> 
> The callers of ->readpage are a mess :(
> 
> Many use lock_page or trylock_page, one uses wait_on_page_locked directly,
> another one uses the wait_on_page_read helper.  I think we need a good
> helper here, and I think it looks a lot like filemap_read_page in your
> tree..

Oh, heh.  Turns out I wrote this in a patch series the other day ...

static int mapping_readpage(struct file *file, struct address_space *mapping,
                struct page *page, bool synchronous)
{
        struct readahead_control ractl = {
                .file = file,
                .mapping = mapping,
                ._index = page->index,
                ._nr_pages = 1,
        };
        int ret;

        if (!synchronous && mapping->a_ops->readahead) {
                mapping->a_ops->readahead(&ractl);
                return 0;
        }

        ret = mapping->a_ops->readpage(file, page);
        if (ret != AOP_UPDATED_PAGE)
                return ret;
        unlock_page(page);
        return 0;
}

(it's for swap_readpage, which is generally called in an async manner ...
and really doesn't handle errors at all well)

This does illustrate that we need the mapping argument.  Some of the
callers of ->readpage need to pass a NULL file pointer, so we can't
get it from file->f_mapping.
