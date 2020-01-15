Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB51013BA6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 08:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgAOHmo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 02:42:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59780 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAOHmo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 02:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MDYWdjGGmcWnpZT3ouoEuxSyV5yZ0wjwxjz7hyW60DM=; b=eHFGlrIzud6d8f9GXVuMszsjO
        /rbNpuDFoQZ90bROWAg2nW17K6o2sObtocHT3gcAMlmChiU/FilCrEj5XBTiuqVOLmz0NzisXDl7O
        Zb14n3nON5axpJ5p2MaaMM7u3j2tQC7MdgFn6Coiwx4RnlBPEWqQAFYLgIQnoyPblEGpLwgWFrcld
        gJGE7UFPhtxbNfZN8WEqL9HcRZH0Ehq/CK7dvOgLSz3l5tUSYy2+Qbs2v3XCLyxVxqY7vsB+X6Us4
        DAYjOjTSOykvrSsO3EeRszBXJUjR1rThIg7Wpej6Wm3VOpZxZYrgzHGXAEUFAp8DG3J0BlVpIrPKp
        Rtkc746rA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irdK8-0001fT-0v; Wed, 15 Jan 2020 07:42:44 +0000
Date:   Tue, 14 Jan 2020 23:42:43 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH v2 6/9] iomap,xfs: Convert from readpages to readahead
Message-ID: <20200115074243.GA31744@bombadil.infradead.org>
References: <20200115023843.31325-1-willy@infradead.org>
 <20200115023843.31325-7-willy@infradead.org>
 <20200115071628.GA3460@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115071628.GA3460@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 11:16:28PM -0800, Christoph Hellwig wrote:
> On Tue, Jan 14, 2020 at 06:38:40PM -0800, Matthew Wilcox wrote:
> >  static loff_t
> > +iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
> >  		void *data, struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	struct iomap_readpage_ctx *ctx = data;
> > @@ -410,10 +381,8 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
> >  			ctx->cur_page = NULL;
> >  		}
> >  		if (!ctx->cur_page) {
> > -			ctx->cur_page = iomap_next_page(inode, ctx->pages,
> > -					pos, length, &done);
> > -			if (!ctx->cur_page)
> > -				break;
> > +			ctx->cur_page = readahead_page(inode->i_mapping,
> > +					pos / PAGE_SIZE);
> 
> Don't we at least need a sanity check for a NULL cur_page here?

I don't think so.  The caller has already put the locked page into the
page cache at that index.  If the page has gone away, that's a bug, and
I don't think BUG_ON is all that much better than a NULL pointer derefence.
Indeed, readahead_page() checks PageLocked, so it can't return NULL.

> Also the readahead_page version in your previous patch seems to expect
> a byte offset, so the division above would not be required.

Oops.  I had intended to make readahead_pages() look like this:

struct page *readahead_page(struct address_space *mapping, pgoff_t index)
{
        struct page *page = xa_load(&mapping->i_pages, index);
        VM_BUG_ON_PAGE(!PageLocked(page), page);

        return page;
}

If only our tools could warn about these kinds of mistakes.

> (and should
> probably be replaced with a right shift anyway no matter where it ends
> up)

If the compiler can't tell that x / 4096 and x >> 12 are precisely the same
and choose the more efficient of the two, we have big problems.

> > +unsigned
> > +iomap_readahead(struct address_space *mapping, pgoff_t start,
> >  		unsigned nr_pages, const struct iomap_ops *ops)
> >  {
> >  	struct iomap_readpage_ctx ctx = {
> > -		.pages		= pages,
> >  		.is_readahead	= true,
> >  	};
> > -	loff_t pos = page_offset(list_entry(pages->prev, struct page, lru));
> > -	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
> > -	loff_t length = last - pos + PAGE_SIZE, ret = 0;
> > +	loff_t pos = start * PAGE_SIZE;
> > +	loff_t length = nr_pages * PAGE_SIZE;
> 
> Any good reason not to pass byte offsets for start and length?
> 
> > +	return length / PAGE_SIZE;
> 
> Same for the return value?
> 
> For the file systems that would usually be a more natural interface than
> a page index and number of pages.

That seems to depend on the filesystem.  iomap definitely would be happier
with loff_t, but cifs prefers pgoff_t.  I should probably survey a few
more filesystems and see if there's a strong lean in one direction or
the other.

