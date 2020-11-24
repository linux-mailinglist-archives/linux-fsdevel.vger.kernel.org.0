Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BF12C3000
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 19:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404211AbgKXSd7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 13:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbgKXSd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:33:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93594C0613D6;
        Tue, 24 Nov 2020 10:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tYzsIguZF1KzH8yF7YgXxi0wukPYn54G/R4/HvqYvBw=; b=GPn+9JAXTzYRQFP/tGUfh/zXs1
        SAA3hxoM8fIrWUcQDhxDaR7HdvrLA1QTQMkytkLpbSOn3thdtvYU/U26jGgQqjzr2RDceiH4TUrkk
        eULgQxje5WTdX9D3PFAf7a7JPOkM1n2aQOVEs03eaUN+Mx2YcwPjfCC7vSsLWmfhjg2Hzi+6x44D2
        +kB2uMNKqCgu2UGWp6LY5dQGkZ0tFFAFuk6VcQfNOcb/nGW1U+0IYtoNH8iNrhmkiAYt5ug4J+w6A
        84v3dC6uGzTrWND1VPGDm2QxFnIbPdfwVsycpb0M/UyxFVDntLu3DpxE8YhF2/WOQxTdX9pVR6I3O
        IfC31lAA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khd8R-0003CI-Ad; Tue, 24 Nov 2020 18:33:51 +0000
Date:   Tue, 24 Nov 2020 18:33:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        syzbot <syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Theodore Ts'o <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
Message-ID: <20201124183351.GD4327@casper.infradead.org>
References: <000000000000d3a33205add2f7b2@google.com>
 <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz>
 <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
 <20201124121912.GZ4327@casper.infradead.org>
 <alpine.LSU.2.11.2011240810470.1029@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2011240810470.1029@eggly.anvils>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 08:28:16AM -0800, Hugh Dickins wrote:
> On Tue, 24 Nov 2020, Matthew Wilcox wrote:
> > On Mon, Nov 23, 2020 at 08:07:24PM -0800, Hugh Dickins wrote:
> > > 
> > > Then on crashing a second time, realized there's a stronger reason against
> > > that approach.  If my testing just occasionally crashes on that check,
> > > when the page is reused for part of a compound page, wouldn't it be much
> > > more common for the page to get reused as an order-0 page before reaching
> > > wake_up_page()?  And on rare occasions, might that reused page already be
> > > marked PageWriteback by its new user, and already be waited upon?  What
> > > would that look like?
> > > 
> > > It would look like BUG_ON(PageWriteback) after wait_on_page_writeback()
> > > in write_cache_pages() (though I have never seen that crash myself).
> > 
> > I don't think this is it.  write_cache_pages() holds a reference to the
> > page -- indeed, it holds the page lock!  So this particular race cannot
> > cause the page to get recycled.  I still have no good ideas what this
> > is :-(
> 
> It is confusing. I tried to explain that in the final paragraph:
> 
> > > Was there a chance of missed wakeups before, since a page freed before
> > > reaching wake_up_page() would have PageWaiters cleared?  I think not,
> > > because each waiter does hold a reference on the page: this bug comes
> > > not from real waiters, but from when PageWaiters is a false positive.
> 
> but got lost in between the original end_page_writeback() and the patched
> version when writing that last part - false positive PageWaiters are not
> relevant.  I'll try rewording that in the simpler version, following.
> 
> The BUG_ON(PageWriteback) would occur when the old use of the page, the
> one we do TestClearPageWriteback on, had *no* waiters, so no additional
> page reference beyond the page cache (and whoever racily frees it). The
> reuse of the page definitely has a waiter holding a reference, as you
> point out, and PageWriteback still set; but our belated wake_up_page()
> has woken it to hit the BUG_ON.

I ... think I see.  Let me try to write it out:

page is allocated, added to page cache, dirtied, writeback starts,

--- thread A ---
filesystem calls end_page_writeback()
	test_clear_page_writeback()
--- context switch to thread B ---
truncate_inode_pages_range() finds the page, it doesn't have writeback set,
we delete it from the page cache.  Page gets reallocated, dirtied, writeback
starts again.  Then we call write_cache_pages(), see
PageWriteback() set, call wait_on_page_writeback()
--- context switch back to thread A ---
wake_up_page(page, PG_writeback);
... thread B is woken, but because the wakeup was for the old use of
the page, PageWriteback is still set.

Devious.

We could fix this by turning that 'if' into a 'while' in
write_cache_pages().  Just accept that spurious wakeups can happen
and they're harmless.  We do need to remove that check of PageWaiters
in wake_up_page() -- as you say, we shouldn't be checking that after
dropping the reference.  I had patches to do that ..

https://lore.kernel.org/linux-mm/20200416220130.13343-1-willy@infradead.org/
specifically:
https://lore.kernel.org/linux-mm/20200416220130.13343-11-willy@infradead.org/
