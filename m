Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEA82877B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 17:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbgJHPno (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 11:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbgJHPno (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:43:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F22C061755;
        Thu,  8 Oct 2020 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FjknbtecctPRg6UGd8CgS2F3TAJYIRTYsOwlNQaT3TI=; b=IwmwO/rXmuZjUGrgUEhwRzEaQf
        NsCbD5Js7XLNi+EJgIYwF2AQEafsd+o8aNq+MPyDL4o516/9TCoiyiE+huoDPgaLqcjTEM2IYgGtw
        7Pw6/5c3cxivhu8KBsC0WFaLd7DnlrBdk0Ida8e8KaaMRPX7wHkQ2SdhJmipqt6aZLNML7T6V1RIr
        TrwXTqWXkuA7p2A4gYfOcLagcgAhLdfPKAlTT7f7NT5AptrvUDV070qmzpX0ZOTYoKT0STh+JOMTL
        tfXIBvFcxWbVjpp4Pdv5Cm7HR3PCCLk0phC7L8mCoWWGauBULeS4pvpXtBqfariXUSQOvNFCiqFLl
        T/k3GD7g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQY4z-0001CH-4a; Thu, 08 Oct 2020 15:43:41 +0000
Date:   Thu, 8 Oct 2020 16:43:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 00/14] Small step toward KSM for file back page.
Message-ID: <20201008154341.GJ20115@casper.infradead.org>
References: <20201007010603.3452458-1-jglisse@redhat.com>
 <20201007032013.GS20115@casper.infradead.org>
 <20201007144835.GA3471400@redhat.com>
 <20201007170558.GU20115@casper.infradead.org>
 <20201007175419.GA3478056@redhat.com>
 <20201007220916.GX20115@casper.infradead.org>
 <20201008153028.GA3508856@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008153028.GA3508856@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 08, 2020 at 11:30:28AM -0400, Jerome Glisse wrote:
> On Wed, Oct 07, 2020 at 11:09:16PM +0100, Matthew Wilcox wrote:
> > So ... why don't you put a PageKsm page in the page cache?  That way you
> > can share code with the current KSM implementation.  You'd need
> > something like this:
> 
> I do just that but there is no need to change anything in page cache.

That's clearly untrue.  If you just put a PageKsm page in the page
cache today, here's what will happen on a truncate:

void truncate_inode_pages_range(struct address_space *mapping,
                                loff_t lstart, loff_t lend)
{
...
                struct page *page = find_lock_page(mapping, start - 1);

find_lock_page() does this:
        return pagecache_get_page(mapping, offset, FGP_LOCK, 0);

pagecache_get_page():

repeat:
        page = find_get_entry(mapping, index);
...
        if (fgp_flags & FGP_LOCK) {
...
                if (unlikely(compound_head(page)->mapping != mapping)) {
                        unlock_page(page);
                        put_page(page);
                        goto repeat;

so it's just going to spin.  There are plenty of other codepaths that
would need to be checked.  If you haven't found them, that shows you
don't understand the problem deeply enough yet.

I believe we should solve this problem, but I don't think you're going
about it the right way.

> So flow is:
> 
>   Same as before:
>     1 - write fault (address, vma)
>     2 - regular write fault handler -> find page in page cache
> 
>   New to common page fault code:
>     3 - ksm check in write fault common code (same as ksm today
>         for anonymous page fault code path).
>     4 - break ksm (address, vma) -> (file offset, mapping)
>         4.a - use mapping and file offset to lookup the proper
>               fs specific information that were save when the
>               page was made ksm.
>         4.b - allocate new page and initialize it with that
>               information (and page content), update page cache
>               and mappings ie all the pte who where pointing to
>               the ksm for that mapping at that offset to now use
>               the new page (like KSM for anonymous page today).

But by putting that logic in the page fault path, you've missed
the truncate path.  And maybe other places.  Putting the logic
down in pagecache_get_page() means you _don't_ need to find
all the places that call pagecache_get_page().

