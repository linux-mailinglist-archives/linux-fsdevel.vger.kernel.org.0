Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D979E26E482
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 20:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgIQSvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 14:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgIQSuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:50:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E59CC06174A;
        Thu, 17 Sep 2020 11:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l7sLBRdTa9442o84PVey1bL2sMDr0vZDh7iLdT5mIuU=; b=H6LVbgrgi+1cLUIERdy2SEyQ4f
        Cx1+Q+NLesCWl7YQRNfSt4Mmmn9HpnChnf/e4ydxD6JD++gepjBP86bnINZzwyYFhslXDnt+JMT3x
        mmSBJG6ev0m4P6bh6bMmV3ViBn5vbODswQTRr8KuEujSaNh+1Okr2XpYt/JGRqTnkXJDkspqVzXh4
        ZasTbHC64Cmu2FiP133wDtehWo88r+jgermEcDhJeM8jlKEa4IOnais5Mnj8evV814WNURamjXiDK
        5ic8mCBehDOkprKOiqEATDAdWEp8Y8ZVSxIyLBIsf6OtZIy7Y2rSp5FuVB3yA3VUKiTfxvcyDZZJy
        LQcgPUeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIyzZ-0008CV-O2; Thu, 17 Sep 2020 18:50:50 +0000
Date:   Thu, 17 Sep 2020 19:50:49 +0100
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
Message-ID: <20200917185049.GV5449@casper.infradead.org>
References: <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com>
 <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com>
 <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
 <20200917182314.GU5449@casper.infradead.org>
 <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:30:00AM -0700, Linus Torvalds wrote:
> On Thu, Sep 17, 2020 at 11:23 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> >             Something like taking
> > the i_mmap_lock_read(file->f_mapping) in filemap_fault, then adding a
> > new VM_FAULT_I_MMAP_LOCKED bit so that do_read_fault() and friends add:
> >
> >         if (ret & VM_FAULT_I_MMAP_LOCKED)
> >                 i_mmap_unlock_read(vmf->vma->vm_file->f_mapping);
> >         else
> >                 unlock_page(page);
> >
> > ... want me to turn that into a real patch?
> 
> I can't guarantee it's the right model - it does worry me how many
> places we might get that i_mmap_rwlock, and how long we migth hold it
> for writing, and what deadlocks it might cause when we take it for
> reading in the page fault path.
> 
> But I think it might be very interesting as a benchmark patch and a
> trial balloon. Maybe it "just works".

Ahh.  Here's a race this doesn't close:

int truncate_inode_page(struct address_space *mapping, struct page *page)
{
        VM_BUG_ON_PAGE(PageTail(page), page);

        if (page->mapping != mapping)
                return -EIO;

        truncate_cleanup_page(mapping, page);
        delete_from_page_cache(page);
        return 0;
}

truncate_cleanup_page() does
        if (page_mapped(page)) {
                pgoff_t nr = PageTransHuge(page) ? HPAGE_PMD_NR : 1;
                unmap_mapping_pages(mapping, page->index, nr, false);
        }

but ->mapping isn't cleared until delete_from_page_cache() many
instructions later.  So we can get the lock and have a page which appears
to be not-truncated, only for it to get truncated on us later.

> I would _love_ for the page lock itself to be only (or at least
> _mainly_) about the actual IO synchronization on the page.
> 
> That was the origin of it, the whole "protect all the complex state of
> a page" behavior kind of grew over time, since it was the only
> per-page lock we had.

Yes, I think that's a noble goal.
