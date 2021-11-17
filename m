Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AF2454BAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 18:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbhKQRNx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 12:13:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239189AbhKQRNx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:13:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72085619EA;
        Wed, 17 Nov 2021 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637169054;
        bh=KGmd4dlCzXTx0ktWJ7d3n0IoBMN+qSH6lMejQB+vFeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HaAukoFgPTm520Wo37EMhEZoim660Vzl505RvlYVrSMqH3eVj1m+12QYnMPogZl7w
         lpAMVk77T0a7687qJaOSJ/v0+dgMBdbCnKMGZfkDqtQKAHrGC9R+4hR+KMDLVRbm9/
         +jPKXJs25lfC39vud1TDMDcnQoVbjGsG+oJb9A1H8Wnv/uiRPJyazmEg2YVfNcjHkI
         oiuWqJGbwHfW71l+PMBMKt6ltT7hYQTYKVgeRwNKHY7Ga9dmt+i42o0sA5mkR5Oyvx
         7681GGSvolROElW0yPKndjVZcW+Ftv6fs6CwhNFS6pKAdeGuHdBfqMXDwcd1rNLvlU
         BWI4LxeHk3QxA==
Date:   Wed, 17 Nov 2021 09:10:54 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 20/28] iomap: Convert iomap_write_begin() and
 iomap_write_end() to folios
Message-ID: <20211117171054.GX24307@magnolia>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-21-willy@infradead.org>
 <20211117043127.GK24307@magnolia>
 <YZUSPga7V797gY4Z@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZUSPga7V797gY4Z@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 02:31:26PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 16, 2021 at 08:31:27PM -0800, Darrick J. Wong wrote:
> > > @@ -764,16 +761,17 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> > >  			break;
> > >  		}
> > >  
> > > -		status = iomap_write_begin(iter, pos, bytes, &page);
> > > +		status = iomap_write_begin(iter, pos, bytes, &folio);
> > >  		if (unlikely(status))
> > >  			break;
> > >  
> > > +		page = folio_file_page(folio, pos >> PAGE_SHIFT);
> > >  		if (mapping_writably_mapped(iter->inode->i_mapping))
> > >  			flush_dcache_page(page);
> > >  
> > >  		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
> > 
> > Hrmm.  In principle (or I guess even a subsequent patch), if we had
> > multi-page folios, could we simply loop the pages in the folio instead
> > of doing a single page and then calling back into iomap_write_begin to
> > get (probably) the same folio?
> > 
> > This looks like a fairly straightforward conversion, but I was wondering
> > about that one little point...
> 
> Theoretically, yes, we should be able to do that.  But all of this code
> is pretty subtle ("What if we hit a page fault?  What if we're writing
> to part of this folio from an mmap of a different part of this folio?
> What if it's !Uptodate?  What if we hit this weird ARM super-mprotect
> memory tag thing?  What if ...") and, frankly, I got scared.  So I've
> left that as future work; someone else can try to wrap their brain around
> all of this.

<nod> That's roughly the same conclusion I came to -- conceptually we
could keep walking pages until we hit /any/ problem or other difference
with the first page that we don't feel like dealing with, and pass that
count to iomap_end... but no need to try that right this second.

Just checking that I grokked what's going on in this series. :)

--D
