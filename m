Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C782A25F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 09:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgKBISr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 03:18:47 -0500
Received: from verein.lst.de ([213.95.11.211]:60357 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbgKBISr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:18:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 902F267373; Mon,  2 Nov 2020 09:18:44 +0100 (CET)
Date:   Mon, 2 Nov 2020 09:18:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/13] mm: handle readahead in
 generic_file_buffered_read_pagenotuptodate
Message-ID: <20201102081844.GA12752@lst.de>
References: <20201031090004.452516-1-hch@lst.de> <20201031090004.452516-5-hch@lst.de> <20201031170646.GT27442@casper.infradead.org> <20201101103144.GC26447@lst.de> <20201101104958.GU27442@casper.infradead.org> <20201101105112.GA26860@lst.de> <20201101105158.GA26874@lst.de> <20201101110406.GV27442@casper.infradead.org> <20201101115217.GA27488@lst.de> <20201101145507.GZ27442@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101145507.GZ27442@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 01, 2020 at 02:55:07PM +0000, Matthew Wilcox wrote:
> Hm?  I have this:

Yes, this looks fine.  Not sure if I saw an earlier version or was
just confused.

> > mm/filemap: Change calling convention for buffered read functions
> > 
> >  - please also drop the mapping argument to the various functions while
> >    you're at it
> 
> Not sure I see the point to it.  Sure, they _can_ retrieve it with
> iocb->ki_filp->f_mapping, but usually we like to pass the mapping
> argument to functions which do something with the mapping.

There really isn't any point in passing an extra argument that can
trivially be derived.

> > Also I think the messy list of uptodate checks could now be simplified
> > down to:
> > 
> > 	if (!PageUptodate(page)) {
> > 		if (inode->i_blkbits <= PAGE_SHIFT &&
> 
> I've been wondering about this test's usefulness in the presence
> of THP.  Do we want to make it 'if (inode->i_blkbits < (thp_order(page)
> + PAGE_SHIFT)'?  It doesn't make sense to leave it as it is because then
> a 1kB and 4kB blocksize filesystem will behave differently.

Yeah, the partially uptodate checks would make sense for huge pages.
Just make sure that the iomap version does the right thing for this
case first.

> 
> > 		    mapping->a_ops->is_partially_uptodate &&
> > 		    !iov_iter_is_pipe(iter)) {
> > 			if (!page->mapping)
> > 				goto truncated;
> > 			if (mapping->a_ops->is_partially_uptodate(page,
> > 					pos & (thp_size(page) - 1), count))
> > 				goto uptodate;
> > 		}
> 
> Now that you've rearranged it like this, it's obvious that the truncated
> check is in the wrong place.  We don't want to call filemap_read_page()
> if the page has been truncated either.

True.

> A later patch hoists the put_page to the caller, so I think you'll like
> where it ends up.

I still find the result in the callers a little weird as it doesn't
follow the normal jump to the end for exceptions flow, but that is
just another tiny nitpick.

> 
> > mm/filemap: Restructure filemap_get_pages
> > 
> >  - I have to say I still like my little helper here for
> >    the two mapping_get_read_thps calls plus page_cache_sync_readahead
> 
> I'll take a look at that.
> 
> Looking at all this again, I think I want to pull the IOCB checks out
> of filemap_read_page() and just pass a struct file to it.  It'll make
> it more clear that NOIO, NOWAIT and WAITQ can't get to calling ->readpage.

filemap_update_page alread exits early for NOWAIT, so it would just
need the NOIO check.  filemap_create_page checks NOIO early, but
allocating the page for NOWAIT also seems rather pointless.  So yes,
I think this would be an improvement.
