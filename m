Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AF02C31CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 21:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgKXUQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 15:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbgKXUP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 15:15:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4251EC0613D6;
        Tue, 24 Nov 2020 12:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r81uB21KgkrQOks2IFcrN3ZOTlRJS3bUyN7vYcsmfFs=; b=UlG140+SGaMtrTfp69FggRQZT2
        ua4M8lWOfBdQjG/fVnSThO5rTs+SVW0D2ckxd67Q5PXBI012Svr53SElnjEBQ+BcbPkWpOxyit+zn
        JTXRW5S2yebgbbbmDgc4SFbBo62a4s2goDFOD29PLJHpuYbtlskUkcK1oY2q8AqYKLjKIVZrciXIo
        8sB3tfUXK8DxuWA5cWodBpAwcn47cgqWVQOrhQMuFyK+3SYe54Btds2vzaHA8+m3McQZpOae8rEkS
        zNABYfLBTEFYtw0ObLKVnr5Xk2HUBZ7nwD5GQBoOLe7GuQ8l8WJPcLvo/eHwfuGAOMtbiasHd1pLF
        cvFQA94w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khejA-0001KH-FM; Tue, 24 Nov 2020 20:15:52 +0000
Date:   Tue, 24 Nov 2020 20:15:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
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
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
Message-ID: <20201124201552.GE4327@casper.infradead.org>
References: <000000000000d3a33205add2f7b2@google.com>
 <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz>
 <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
 <20201124121912.GZ4327@casper.infradead.org>
 <alpine.LSU.2.11.2011240810470.1029@eggly.anvils>
 <20201124183351.GD4327@casper.infradead.org>
 <CAHk-=wjtGAUP5fydxR8iWbzB65p2XvM0BrHE=PkPLQcJ=kq_8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjtGAUP5fydxR8iWbzB65p2XvM0BrHE=PkPLQcJ=kq_8A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:00:42AM -0800, Linus Torvalds wrote:
> On Tue, Nov 24, 2020 at 10:33 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > We could fix this by turning that 'if' into a 'while' in
> > write_cache_pages().
> 
> That might be the simplest patch indeed.
> 
> At the same time, I do worry about other cases like this: while
> spurious wakeup events are normal and happen in other places, this is
> a bit different.
> 
> This is literally a wakeup that leaks from a previous use of a page,
> and makes us think that something could have happened to the new use.
> 
> The unlock_page() case presumably never hits that, because even if we
> have some unlock without a page ref (which I don't think can happen,
> but whatever..), the exclusive nature of "lock_page()" means that no
> locker can care - once you get the lock, you own the page./
> 
> The writeback code is special in that the writeback bit isn't some
> kind of exclusive bit, but this code kind of expected it to be that.
> 
> So I'd _like_ to have something like
> 
>         WARN_ON_ONCE(!page_count(page));
> 
> in the wake_up_page_bit() function, to catch things that wake up a
> page that has already been released and might be reused..
> 
> And that would require the "get_page()" to be done when we set the
> writeback bit and queue the page up for IO (so that then
> end_page_writeback() would clear the bit, do the wakeup, and then drop
> the ref).
> 
> Hugh's second patch isn't pretty - I think the "get_page()" is
> conceptually in the wrong place - but it "works" in that it keeps that
> "implicit page reference" being kept by the PG_writeback bit, and then
> it takes an explicit page reference before it clears the bit.
> 
> So while I don't love the whole "PG_writeback is an implicit reference
> to the page" model, Hugh's patch at least makes that model much more
> straightforward: we really either have that PG_writeback, _or_ we have
> a real ref to the page, and we never have that odd "we could actually
> lose the page" situation.
> 
> So I think I prefer Hugh's two-liner over your one-liner suggestion.
> 
> But your one-liner is technically not just smaller, it obviously also
> avoids the whole mucking with the atomic page ref.
> 
> I don't _think_ that the extra get/put overhead could possibly really
> matter: doing the writeback is going to be a lot more expensive
> anyway. And an atomic access to a 'struct page' sounds expensive, but
> that cacheline is already likely dirty in the L1 cache because we've
> touch page->flags and done other things to it).
> 
> So I'd personally be inclined to go with Hugh's patch. Comments?

My only objection to Hugh's patch is that it may cause us to fail
to split pages when we can currently split them.  That is, we do:

	wait_on_page_writeback()
	if (page_has_private(page))
		do_invalidatepage(page, offset, length);
	split_huge_page()

(at least we do in my THP patchset; not sure if there's any of that
in the kernel today), and the extra reference held for a few nanoseconds
after calling wake_up_page() will cause us to fail to split the page.
It probably doesn't matter; there has to be a fallback path anyway.

Now I'm looking at that codepath, and the race that Hugh uncovered now
looks like a real bug.  Consider this sequence:

page allocated, added to page cache, dirtied, writeback started

--- thread A ---
end_page_writeback()
	test_clear_page_writeback
--- ctx switch to thread B ---
alloc page, add to page cache, dirty page, start page writeback,
truncate_inode_pages_range()
	wait_on_page_writeback()
--- ctx switch to thread A ---
	wake_up_page()
--- ctx switch to thread B ---
free page
alloc page
write new data to page

... now the DMA actually starts to do page writeback, and it's writing
the new data.

So my s/if/while/ suggestion is wrong and we need to do something to
prevent spurious wakeups.  Unless we bury the spurious wakeup logic
inside wait_on_page_writeback() ...
