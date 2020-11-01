Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A2F2A1ECE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 15:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgKAOzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 09:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgKAOzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 09:55:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD5AC0617A6
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2020 06:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+okBHoIIs8U5+YrbJBZ2hPierUJPLUOHVl3LY8+9lGI=; b=WTdx/tkymJtaCfMOfFxddjg08W
        IU0CtGq3pCnV4NPgu219VJKYJO3gQnDFIuOymdEZB1m0eHAPh2zlrSOKxkQE0Bl7cH01o5+BVOkpE
        2AFCh1mw8n9vF/eh5/wObchG4QsBDPRnGhA7s6gj3cq/APN1YkcintziZkcG7CmMIJ7ZgFHnEZq7V
        6EnYW/Xf2GKJESKnYL7yKuhqJ66qyUm8JWWG0KfA0aOIjweLn0AT2UmKZFWC/V+nPgUrWN5ZXxP2j
        Z5+Y/dh6+JSYvsDvRkRSamrkVn5wyPRgB/dmpKxb/U1/pQ8kfWkIN9UmsQErBSuDomroYaePOOjTr
        XQWuTZtw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZEl9-000793-Qi; Sun, 01 Nov 2020 14:55:08 +0000
Date:   Sun, 1 Nov 2020 14:55:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/13] mm: handle readahead in
 generic_file_buffered_read_pagenotuptodate
Message-ID: <20201101145507.GZ27442@casper.infradead.org>
References: <20201031090004.452516-1-hch@lst.de>
 <20201031090004.452516-5-hch@lst.de>
 <20201031170646.GT27442@casper.infradead.org>
 <20201101103144.GC26447@lst.de>
 <20201101104958.GU27442@casper.infradead.org>
 <20201101105112.GA26860@lst.de>
 <20201101105158.GA26874@lst.de>
 <20201101110406.GV27442@casper.infradead.org>
 <20201101115217.GA27488@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101115217.GA27488@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 01, 2020 at 12:52:17PM +0100, Christoph Hellwig wrote:
> On Sun, Nov 01, 2020 at 11:04:06AM +0000, Matthew Wilcox wrote:
> > > I'll stop for now.
> > 
> > http://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/next
> > 
> > is what i currently have.  Haven't pulled in everything from you; certainly not renaming generic_file_buffered_read to filemap_read(), which is awesome.
> > i'm about 500 seconds into an xfstests run.
> 
> A bunch of comments from a very quick look:
> 
> mm/filemap: Rename generic_file_buffered_read subfunctions
> 
>  - the commit log still mentions the old names

Hm?  I have this:

    mm/filemap: Rename generic_file_buffered_read subfunctions
    
    The recent split of generic_file_buffered_read() created some very
    long function names which are hard to distinguish from each other.
    Rename as follows:
    
    generic_file_buffered_read_readpage -> filemap_read_page
    generic_file_buffered_read_pagenotuptodate -> filemap_update_page
    generic_file_buffered_read_no_cached_page -> filemap_create_page
    generic_file_buffered_read_get_pages -> filemap_get_pages

> mm/filemap: Change calling convention for buffered read functions
> 
>  - please also drop the mapping argument to the various functions while
>    you're at it

Not sure I see the point to it.  Sure, they _can_ retrieve it with
iocb->ki_filp->f_mapping, but usually we like to pass the mapping
argument to functions which do something with the mapping.

> mm/filemap: Reduce indentation in gfbr_read_page
> 
>  - still mentionds the old function name

Fixed.

> mm/filemap: Support readpage splitting a page
> 
>  - nitpick, I find this a little hard to read:
> 
> +	} else if (!trylock_page(page)) {
> +		put_and_wait_on_page_locked(page, TASK_KILLABLE);
> +		return NULL;
>  	}
> 
> and would write this a little more coarse as:
> 
> 	} else {
> 		if (!trylock_page(page)) {
> 			put_and_wait_on_page_locked(page, TASK_KILLABLE);
> 			return NULL;
> 		}
> 	}

No strong feeling here.  I'll change it.

> Also I think the messy list of uptodate checks could now be simplified
> down to:
> 
> 	if (!PageUptodate(page)) {
> 		if (inode->i_blkbits <= PAGE_SHIFT &&

I've been wondering about this test's usefulness in the presence
of THP.  Do we want to make it 'if (inode->i_blkbits < (thp_order(page)
+ PAGE_SHIFT)'?  It doesn't make sense to leave it as it is because then
a 1kB and 4kB blocksize filesystem will behave differently.

> 		    mapping->a_ops->is_partially_uptodate &&
> 		    !iov_iter_is_pipe(iter)) {
> 			if (!page->mapping)
> 				goto truncated;
> 			if (mapping->a_ops->is_partially_uptodate(page,
> 					pos & (thp_size(page) - 1), count))
> 				goto uptodate;
> 		}

Now that you've rearranged it like this, it's obvious that the truncated
check is in the wrong place.  We don't want to call filemap_read_page()
if the page has been truncated either.

> 		return filemap_read_page(iocb, mapping, page);
> 	}
> 
> mm/filemap: Convert filemap_read_page to return an errno:
> 
>  - using a goto label for the put_page + return error case like in my
>    patch would be cleaner I think

A later patch hoists the put_page to the caller, so I think you'll like
where it ends up.

> mm/filemap: Restructure filemap_get_pages
> 
>  - I have to say I still like my little helper here for
>    the two mapping_get_read_thps calls plus page_cache_sync_readahead

I'll take a look at that.

Looking at all this again, I think I want to pull the IOCB checks out
of filemap_read_page() and just pass a struct file to it.  It'll make
it more clear that NOIO, NOWAIT and WAITQ can't get to calling ->readpage.

I'll send another rev tomorrow.
