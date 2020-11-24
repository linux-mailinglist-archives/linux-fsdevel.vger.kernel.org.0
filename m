Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E844D2C258E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 13:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbgKXMTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 07:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgKXMTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:19:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826ACC0613D6;
        Tue, 24 Nov 2020 04:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uvDfFcTJVIdXBGR+joN6zXz154p6r479ClVsKuidpag=; b=AoYEmNwScc3ZhYqB9VycOafUC5
        2v8rbvnu68twnK4hQ1ICV3Qzd3tbpCIgVcqUSI2A3/4FgAKbdGgoPE3j691S9i44M+3BMOp+ucZpe
        WYTpbzzzuC8m5I6rqbpj7uJxVy2iPPq4BbrJt3tnjp156mNc79iiEIPR+k4akIFcqQYYTWMEGNmOn
        GTS+ei+v5ogGFPnIWlWKqtnu9wWzezGV6iDyvZWWbfaK41ZVxjD7qnMAJMwYOli6+LnTRhtDS8F/J
        ATpzt8UTjj6e/hWbcAEtZdqToH0AwcokShCJbDWUIV5xBWmnCgjfTQnUGBa3qUsMVttttRPptukAc
        Xc1lNbWw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khXHs-0002FJ-2w; Tue, 24 Nov 2020 12:19:12 +0000
Date:   Tue, 24 Nov 2020 12:19:12 +0000
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
Message-ID: <20201124121912.GZ4327@casper.infradead.org>
References: <000000000000d3a33205add2f7b2@google.com>
 <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz>
 <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 08:07:24PM -0800, Hugh Dickins wrote:
> Twice now, when exercising ext4 looped on shmem huge pages, I have crashed
> on the PF_ONLY_HEAD check inside PageWaiters(): ext4_finish_bio() calling
> end_page_writeback() calling wake_up_page() on tail of a shmem huge page,
> no longer an ext4 page at all.
> 
> The problem is that PageWriteback is not accompanied by a page reference
> (as the NOTE at the end of test_clear_page_writeback() acknowledges): as
> soon as TestClearPageWriteback has been done, that page could be removed
> from page cache, freed, and reused for something else by the time that
> wake_up_page() is reached.
> 
> https://lore.kernel.org/linux-mm/20200827122019.GC14765@casper.infradead.org/
> Matthew Wilcox suggested avoiding or weakening the PageWaiters() tail
> check; but I'm paranoid about even looking at an unreferenced struct page,
> lest its memory might itself have already been reused or hotremoved (and
> wake_up_page_bit() may modify that memory with its ClearPageWaiters()).
> 
> Then on crashing a second time, realized there's a stronger reason against
> that approach.  If my testing just occasionally crashes on that check,
> when the page is reused for part of a compound page, wouldn't it be much
> more common for the page to get reused as an order-0 page before reaching
> wake_up_page()?  And on rare occasions, might that reused page already be
> marked PageWriteback by its new user, and already be waited upon?  What
> would that look like?
> 
> It would look like BUG_ON(PageWriteback) after wait_on_page_writeback()
> in write_cache_pages() (though I have never seen that crash myself).

I don't think this is it.  write_cache_pages() holds a reference to the
page -- indeed, it holds the page lock!  So this particular race cannot
cause the page to get recycled.  I still have no good ideas what this
is :-(
