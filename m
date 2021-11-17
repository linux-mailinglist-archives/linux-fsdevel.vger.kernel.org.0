Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E763F4548C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 15:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbhKQOeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 09:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbhKQOe2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:34:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96B8C061570;
        Wed, 17 Nov 2021 06:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H4bB6JtajRihCQwe9/p1L6wP+6CkaZyC/lV4Gg4tmXM=; b=YSun8BX0UKQ0J2y2SXQ8KhIlbj
        05e64lOL1DNzm/0U77uXqObjzaEnVXO0FqRfNV9O5zFVhN9Wj76OYOusjWPM4wMC/9fSA018cOXV2
        yzl7SZhRttJe+Q2mKqSuaRJi7aZ9aOULBOmRW8SS+AQ5Ub9XUXwkZf7R419UIeeDH73X/RUcM+YBS
        2grlLvyo8f8h4uJWiF8mrQkpSYPsVVxfqAcE4YsCcXMM+ihZQPi5/xuuOQnWPylDcY8HAMFpXQ0GT
        nmrDX/Uer7HMBjel9FiY9HxqP0rRDQxCadr9zlbJvWUlXDjT2gJ6lN8t64TTr9UZ4ZhVn7Lu3qcYN
        DJD0XIBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnLyA-007fzM-Ib; Wed, 17 Nov 2021 14:31:26 +0000
Date:   Wed, 17 Nov 2021 14:31:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 20/28] iomap: Convert iomap_write_begin() and
 iomap_write_end() to folios
Message-ID: <YZUSPga7V797gY4Z@casper.infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-21-willy@infradead.org>
 <20211117043127.GK24307@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117043127.GK24307@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 08:31:27PM -0800, Darrick J. Wong wrote:
> > @@ -764,16 +761,17 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> >  			break;
> >  		}
> >  
> > -		status = iomap_write_begin(iter, pos, bytes, &page);
> > +		status = iomap_write_begin(iter, pos, bytes, &folio);
> >  		if (unlikely(status))
> >  			break;
> >  
> > +		page = folio_file_page(folio, pos >> PAGE_SHIFT);
> >  		if (mapping_writably_mapped(iter->inode->i_mapping))
> >  			flush_dcache_page(page);
> >  
> >  		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
> 
> Hrmm.  In principle (or I guess even a subsequent patch), if we had
> multi-page folios, could we simply loop the pages in the folio instead
> of doing a single page and then calling back into iomap_write_begin to
> get (probably) the same folio?
> 
> This looks like a fairly straightforward conversion, but I was wondering
> about that one little point...

Theoretically, yes, we should be able to do that.  But all of this code
is pretty subtle ("What if we hit a page fault?  What if we're writing
to part of this folio from an mmap of a different part of this folio?
What if it's !Uptodate?  What if we hit this weird ARM super-mprotect
memory tag thing?  What if ...") and, frankly, I got scared.  So I've
left that as future work; someone else can try to wrap their brain around
all of this.
