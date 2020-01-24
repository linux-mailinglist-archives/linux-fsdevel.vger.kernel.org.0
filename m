Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2D514915D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 23:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgAXWxX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 17:53:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgAXWxW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 17:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9nHdECu+t1DtUiZWoY8Q+YMfG1ZuOUtzAdx+s6acK5g=; b=ii4K6ImlPdZxl7l2n3T5uaQm6
        GJo8R9CLEnUKIWoXJYGJjE/SrRd8O1McKjo3Ey/WcYOpjbHcPGB1JGe8EOB2Vg2o/rcWp3Q1wkXo3
        FB832Ej+wGXXZ32NXV2ODeE8//D+9ftQCaBVcZXUI+tGFVne5cpWu1457mPzwNERZvIXO/M8cYOxX
        vb9qIDPEykb1gbEjgjmgf5jeq0dfb9ffRGQotOy6QEn6zalhZsV0EuLe9gvZGlo2L++JqyoghSplH
        AUuXDw8FSXNIjpewmVtmUb4t7JNlcw2RYqLtQAjgMF4HSrRIKbqs3L6kaWIDxqE3tPgPhIF4evLQx
        1/dKJ2L6Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iv7pJ-0003t3-BJ; Fri, 24 Jan 2020 22:53:21 +0000
Date:   Fri, 24 Jan 2020 14:53:21 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH v2 6/9] iomap,xfs: Convert from readpages to readahead
Message-ID: <20200124225321.GM4675@bombadil.infradead.org>
References: <20200115023843.31325-1-willy@infradead.org>
 <20200115023843.31325-7-willy@infradead.org>
 <20200115071628.GA3460@infradead.org>
 <20200115074243.GA31744@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115074243.GA31744@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 11:42:43PM -0800, Matthew Wilcox wrote:
> On Tue, Jan 14, 2020 at 11:16:28PM -0800, Christoph Hellwig wrote:
> > On Tue, Jan 14, 2020 at 06:38:40PM -0800, Matthew Wilcox wrote:
> > > +iomap_readahead(struct address_space *mapping, pgoff_t start,
> > >  		unsigned nr_pages, const struct iomap_ops *ops)
> > >  {
> > >  	struct iomap_readpage_ctx ctx = {
> > > -		.pages		= pages,
> > >  		.is_readahead	= true,
> > >  	};
> > > -	loff_t pos = page_offset(list_entry(pages->prev, struct page, lru));
> > > -	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
> > > -	loff_t length = last - pos + PAGE_SIZE, ret = 0;
> > > +	loff_t pos = start * PAGE_SIZE;
> > > +	loff_t length = nr_pages * PAGE_SIZE;
> > 
> > Any good reason not to pass byte offsets for start and length?
> > 
> > > +	return length / PAGE_SIZE;
> > 
> > Same for the return value?
> > 
> > For the file systems that would usually be a more natural interface than
> > a page index and number of pages.
> 
> That seems to depend on the filesystem.  iomap definitely would be happier
> with loff_t, but cifs prefers pgoff_t.  I should probably survey a few
> more filesystems and see if there's a strong lean in one direction or
> the other.

I've converted all the filesystems now except for those that use fscache.
http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/readahead

iomap is the only one for which an loff_t makes sense as an argument.
fscache will also prefer page index & count once Dave's conversion series
lands:
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=fscache-iter&id=ae317744dfb9732123e554467a9f6d93733e8a5b

I'll prep a serious conversion series for 5.6 soon (skipping cifs, but
converting all the non-fscache filesystems).
