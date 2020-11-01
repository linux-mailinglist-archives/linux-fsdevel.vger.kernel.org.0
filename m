Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54D12A1DB2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 12:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgKALwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 06:52:23 -0500
Received: from verein.lst.de ([213.95.11.211]:58449 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgKALwW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 06:52:22 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8547468B02; Sun,  1 Nov 2020 12:52:18 +0100 (CET)
Date:   Sun, 1 Nov 2020 12:52:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/13] mm: handle readahead in
 generic_file_buffered_read_pagenotuptodate
Message-ID: <20201101115217.GA27488@lst.de>
References: <20201031090004.452516-1-hch@lst.de> <20201031090004.452516-5-hch@lst.de> <20201031170646.GT27442@casper.infradead.org> <20201101103144.GC26447@lst.de> <20201101104958.GU27442@casper.infradead.org> <20201101105112.GA26860@lst.de> <20201101105158.GA26874@lst.de> <20201101110406.GV27442@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101110406.GV27442@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 01, 2020 at 11:04:06AM +0000, Matthew Wilcox wrote:
> > I'll stop for now.
> 
> http://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/next
> 
> is what i currently have.  Haven't pulled in everything from you; certainly not renaming generic_file_buffered_read to filemap_read(), which is awesome.
> i'm about 500 seconds into an xfstests run.

A bunch of comments from a very quick look:

mm/filemap: Rename generic_file_buffered_read subfunctions

 - the commit log still mentions the old names

mm/filemap: Change calling convention for buffered read functions

 - please also drop the mapping argument to the various functions while
   you're at it

mm/filemap: Reduce indentation in gfbr_read_page

 - still mentionds the old function name

mm/filemap: Support readpage splitting a page

 - nitpick, I find this a little hard to read:

+	} else if (!trylock_page(page)) {
+		put_and_wait_on_page_locked(page, TASK_KILLABLE);
+		return NULL;
 	}

and would write this a little more coarse as:

	} else {
		if (!trylock_page(page)) {
			put_and_wait_on_page_locked(page, TASK_KILLABLE);
			return NULL;
		}
	}

Also I think the messy list of uptodate checks could now be simplified
down to:

	if (!PageUptodate(page)) {
		if (inode->i_blkbits <= PAGE_SHIFT &&
		    mapping->a_ops->is_partially_uptodate &&
		    !iov_iter_is_pipe(iter)) {
			if (!page->mapping)
				goto truncated;
			if (mapping->a_ops->is_partially_uptodate(page,
					pos & (thp_size(page) - 1), count))
				goto uptodate;
		}

		return filemap_read_page(iocb, mapping, page);
	}

mm/filemap: Convert filemap_read_page to return an errno:

 - using a goto label for the put_page + return error case like in my
   patch would be cleaner I think

mm/filemap: Restructure filemap_get_pages

 - I have to say I still like my little helper here for
   the two mapping_get_read_thps calls plus page_cache_sync_readahead




