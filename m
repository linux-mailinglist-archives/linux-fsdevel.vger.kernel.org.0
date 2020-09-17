Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0870426E376
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 20:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgIQSYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 14:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgIQSX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:23:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB55C061788;
        Thu, 17 Sep 2020 11:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aQypP2koUNv6+aNM9YoRhJ4Vxqa2kdyCFpg475chs+w=; b=UtXFKTQOrX0oh0UsjMY4y9EB4O
        eu1iPyOoelbV5FTZ000VWSOdR8VGghEFBiO1tInSIH/2JygdPP6GJZl6HNr8pYFiY1Pg+EYeFciaQ
        TKgzudBxxcJFlL3+/ns+ypCVJA+XxWIluNyD8IK5FIRd77PDPRr20eOFAbloJZ5T8gQIku1Zvym8D
        7ah4EuEBcrJaTVSLDrN1h7BFWnUgEMFP+vMTOUOocrdPk2H9BJsCWfYiywD5kbDgz9QOZ6LCEHdJX
        uNeZHcPe5XrF+mlAZA9Ta53XFlaZzrpoqQz0CToiyQRvcCcTZPLcgKbTuoIba9UEnytp5ovwzCT/P
        X7bszgdQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIyYs-0006AE-Hs; Thu, 17 Sep 2020 18:23:14 +0000
Date:   Thu, 17 Sep 2020 19:23:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Amir Goldstein <amir73il@gmail.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Kernel Benchmarking
Message-ID: <20200917182314.GU5449@casper.infradead.org>
References: <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com>
 <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com>
 <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 10:51:41AM -0700, Linus Torvalds wrote:
> It does strike me that if the main source of contention comes from
> that "we need to check that the mapping is still valid as we insert
> the page into the page tables", then the page lock really isn't the
> obvious lock to use.
> 
> It would be much more natural to use the mapping->i_mmap_rwsem, I feel.
> 
> Willy? Your "just check for uptodate without any lock" patch itself
> feels wrong. That's what we do for plain reads, but the difference is
> that a read is a one-time event and a race is fine: we get valid data,
> it's just that it's only valid *concurrently* with the truncate or
> hole-punching event (ie either all zeroes or old data is fine).
> 
> The reason faulting a page in is different from a read is that if you
> then map in a stale page, it might have had the correct contents at
> the time of the fault, but it will not have the correct contents going
> forward.
> 
> So a page-in requires fundamentally stronger locking than a read()
> does, because of how the page-in causes that "future lifetime" of the
> page, in ways a read() event does not.

Yes, I agree, mmap is granting future access to a page in a
way that read is not.  So we need to be sure that any concurrent
truncate/hole-punch/collapse-range/invalidate-for-directio/migration
(henceforth page-killer) doesn't allow a page that's about to be recycled
to be added to the page tables.

What I was going for was that every page-killer currently does something
like this:

        if (page_mapped(page))
                unmap_mapping_pages(mapping, page->index, nr, false);

so as long as we mark the page as being no-new-maps-allowed before
the page-killer checks page_mapped(), and the map-page path checks
that the page isn't no-new-maps-allowed after incrementing page_mapped(),
then we'll never see something we shouldn't in the page tables -- either
it will show up in the page tables right before the page-killer calls
unmap_mapping_pages() (in which case you'll get the old contents), or
it won't show up in the page tables.

I'd actually want to wrap all that into:

static inline void page_kill_mappings(struct page)
{
	ClearPageUptodate(page);
	smb_mb__before_atomic();
	if (!page_mapped(page))
		return;
	unmap_mapping_pages(mapping, page->index, compound_nr(page), false);
}

but that's just syntax.

I'm pretty sure that patch I sent out doesn't handle page faults on
disappearing pages correctly; it needs to retry so it can instantiate
a new page in the page cache.  And as Jan pointed out, it didn't handle
the page migration case.  But that wasn't really the point of the patch.

> But truncation that does page cache removal already requires that
> i_mmap_rwsem, and in fact the VM already very much uses that (ie when
> walking the page mapping).
> 
> The other alternative might be just the mapping->private_lock. It's
> not a reader-writer lock, but if we don't need to sleep (and I don't
> think the final "check ->mapping" can sleep anyway since it has to be
> done together with the page table lock), a spinlock would be fine.

I'm not a huge fan of taking file-wide locks for something that has
a naturally finer granularity.  It tends to bite us when weirdos with
giant databases mmap the whole thing and then whine about contention on
the rwsem during page faults.

But you're right that unmap_mapping_range() already takes this lock for
removing pages from the page table, so it would be reasonable to take
it for read when adding pages to the page table.  Something like taking
the i_mmap_lock_read(file->f_mapping) in filemap_fault, then adding a
new VM_FAULT_I_MMAP_LOCKED bit so that do_read_fault() and friends add:

	if (ret & VM_FAULT_I_MMAP_LOCKED)
		i_mmap_unlock_read(vmf->vma->vm_file->f_mapping);
	else
		unlock_page(page);

... want me to turn that into a real patch?
