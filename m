Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E8D2C3BDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 10:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgKYJUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 04:20:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:43090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgKYJUK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 04:20:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7E1A2AE42;
        Wed, 25 Nov 2020 09:20:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 96F841E130F; Wed, 25 Nov 2020 10:20:07 +0100 (CET)
Date:   Wed, 25 Nov 2020 10:20:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20201125092007.GA16944@quack2.suse.cz>
References: <000000000000d3a33205add2f7b2@google.com>
 <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz>
 <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
 <20201124121912.GZ4327@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124121912.GZ4327@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 24-11-20 12:19:12, Matthew Wilcox wrote:
> On Mon, Nov 23, 2020 at 08:07:24PM -0800, Hugh Dickins wrote:
> > Twice now, when exercising ext4 looped on shmem huge pages, I have crashed
> > on the PF_ONLY_HEAD check inside PageWaiters(): ext4_finish_bio() calling
> > end_page_writeback() calling wake_up_page() on tail of a shmem huge page,
> > no longer an ext4 page at all.
> > 
> > The problem is that PageWriteback is not accompanied by a page reference
> > (as the NOTE at the end of test_clear_page_writeback() acknowledges): as
> > soon as TestClearPageWriteback has been done, that page could be removed
> > from page cache, freed, and reused for something else by the time that
> > wake_up_page() is reached.
> > 
> > https://lore.kernel.org/linux-mm/20200827122019.GC14765@casper.infradead.org/
> > Matthew Wilcox suggested avoiding or weakening the PageWaiters() tail
> > check; but I'm paranoid about even looking at an unreferenced struct page,
> > lest its memory might itself have already been reused or hotremoved (and
> > wake_up_page_bit() may modify that memory with its ClearPageWaiters()).
> > 
> > Then on crashing a second time, realized there's a stronger reason against
> > that approach.  If my testing just occasionally crashes on that check,
> > when the page is reused for part of a compound page, wouldn't it be much
> > more common for the page to get reused as an order-0 page before reaching
> > wake_up_page()?  And on rare occasions, might that reused page already be
> > marked PageWriteback by its new user, and already be waited upon?  What
> > would that look like?
> > 
> > It would look like BUG_ON(PageWriteback) after wait_on_page_writeback()
> > in write_cache_pages() (though I have never seen that crash myself).
> 
> I don't think this is it.  write_cache_pages() holds a reference to the
> page -- indeed, it holds the page lock!  So this particular race cannot
> cause the page to get recycled.  I still have no good ideas what this
> is :-(

But does it really matter what write_cache_pages() does? I mean we start
page writeback. I mean struct bio holds no reference to the page it writes.
The only thing that prevents the page from being freed under bio's hands is
PageWriteback bit. So when the bio is completing we do (e.g. in
ext4_end_bio()), we usually walk all pages in a bio
bio_for_each_segment_all() and for each page call end_page_writeback(), now
once end_page_writeback() calls test_clear_page_writeback() which clears
PageWriteback(), the page can get freed. And that can happen before the
wake_up_page() call in end_page_writeback(). So a race will be like:

CPU1					CPU2
ext4_end_bio()
  ...
  end_page_writeback(page)
    test_clear_page_writeback(page)
					free page
					reallocate page for something else
					we can even dirty & start to
					  writeback 'page'
    wake_up_page(page)

and we have a "spurious" wake up on 'page'.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
