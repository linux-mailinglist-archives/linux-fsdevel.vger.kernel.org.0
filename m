Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0F4215F03
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 20:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgGFSuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 14:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbgGFSuC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:50:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6331EC061755
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2020 11:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FZ1GTUJbHt2UVdMS+1l/ulphkyYygdgKZTWjwmCf1Tg=; b=RV+9KJfgQNn+JF6wEifqtNnQpi
        BdG9mN2HzNSHK7Fr/vd3M/HihP8patHmRtslmdY884hhzbmoWEpEdtD6yjBVuX+YnRlI51jHY3eqa
        2xMPhygAV9ur4l36FGeYHa5UaFUfR0HvIAJb1YDl7YINSlogcxMhSS+lq34YQkin4Mr1IdNrGqjPf
        2CNgwmCe/2xFwtQ3kp26tSB/3hbB+pN4m+nm5tipMrhMCOrGcA0EY46itiEVsHbyqy/YQv90AJnpN
        wh9S0VuNfmQrB/cDIPfBDd2AWYDoHgP6Xpwd2mD+fF5lo/DJggiNZ9Tvrb7zIWesVcZlpLRy8yfI4
        whMyGGpw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsWBk-0008Rm-8y; Mon, 06 Jul 2020 18:50:00 +0000
Date:   Mon, 6 Jul 2020 19:50:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] Use multi-index entries in the page cache
Message-ID: <20200706185000.GC25523@casper.infradead.org>
References: <20200629152033.16175-1-willy@infradead.org>
 <alpine.LSU.2.11.2007041206270.1056@eggly.anvils>
 <20200706144320.GB25523@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706144320.GB25523@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 06, 2020 at 03:43:20PM +0100, Matthew Wilcox wrote:
> On Sat, Jul 04, 2020 at 01:20:19PM -0700, Hugh Dickins wrote:
> > These problems were either mm/filemap.c:1565 find_lock_entry()
> > VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page); or hangs, which
> > (at least the ones that I went on to investigate) turned out also to be
> > find_lock_entry(), circling around with page_mapping(page) != mapping.
> > It seems that find_get_entry() is sometimes supplying the wrong page,
> > and you will work out why much quicker than I shall.  (One tantalizing
> > detail of the bad offset crashes: very often page pgoff is exactly one
> > less than the requested offset.)
> 
> I added this:
> 
> @@ -1535,6 +1535,11 @@ struct page *find_get_entry(struct address_space *mapping, pgoff_t offset)
>                 goto repeat;
>         }
>         page = find_subpage(page, offset);
> +       if (page_to_index(page) != offset) {
> +               printk("offset %ld xas index %ld offset %d\n", offset, xas.xa_index, xas.xa_offset);
> +               dump_page(page, "index mismatch");
> +               printk("xa_load %p\n", xa_load(&mapping->i_pages, offset));
> +       }
>  out:
>         rcu_read_unlock();
>  
> and I have a good clue now:
> 
> 1322 offset 631 xas index 631 offset 48
> 1322 page:000000008c9a9bc3 refcount:4 mapcount:0 mapping:00000000d8615d47 index:0x276
> 1322 flags: 0x4000000000002026(referenced|uptodate|active|private)
> 1322 mapping->aops:0xffffffff88a2ebc0 ino 1800b82 dentry name:"f1141"
> 1322 raw: 4000000000002026 dead000000000100 dead000000000122 ffff98ff2a8b8a20
> 1322 raw: 0000000000000276 ffff98ff1ac271a0 00000004ffffffff 0000000000000000
> 1322 page dumped because: index mismatch
> 1322 xa_load 000000008c9a9bc3
> 
> 0x276 is decimal 630.  So we're looking up a tail page and getting its
> erstwhile head page.  I'll dig in and figure out exactly how that's
> happening.

@@ -841,6 +842,7 @@ static int __add_to_page_cache_locked(struct page *page,
                nr = thp_nr_pages(page);
        }
 
+       VM_BUG_ON_PAGE(xa_load(&mapping->i_pages, offset + nr) == page, page);
        page_ref_add(page, nr);
        page->mapping = mapping;
        page->index = offset;
@@ -880,6 +882,7 @@ static int __add_to_page_cache_locked(struct page *page,
                goto error;
        }
 
+       VM_BUG_ON_PAGE(xa_load(&mapping->i_pages, offset + nr) == page, page);
        trace_mm_filemap_add_to_page_cache(page);
        return 0;
 error:

The second one triggers with generic/051 (running against xfs with the
rest of my patches).  So I deduce that we have a shadow entry which
takes up multiple indices, then when we store the page, we now have
a multi-index entry which refers to a single page.  And this explains
basically all the accounting problems.

Now I'm musing how best to fix this.

1. When removing a compound page from the cache, we could store only
a single entry.  That seems bad because we cuold hit somewhere else in
the compound page and we'd have the wrong information about workingset
history (or worse believe that a shmem page isn't in swap!)

2. When removing a compound page from the cache, we could split the
entry and store the same entry N times.  Again, this seems bad for shmem
because then all the swap entries would be the same, and we'd fetch the
wrong data from swap.

3 & 4. When adding a page to the cache, we delete any shadow entry which was
previously there, or replicate the shadow entry.  Same drawbacks as the
above two, I feel.

5. Use the size of the shadow entry to allocate a page of the right size.
We don't currently have an API to find the right size, so that would
need to be written.  And what do we do if we can't allocate a page of
sufficient size?

So that's five ideas with their drawbacks as I see them.  Maybe you have
a better idea?
