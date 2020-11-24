Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856862C1E4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgKXGea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgKXGe3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:34:29 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302AEC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 22:34:28 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id f11so22664851oij.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 22:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NRH6VONBYNIxV3zO4nNRr9V11VXjtGQdzP+hrNGAm3A=;
        b=qhe1mkmWMwhGuf8fqGpCpj+e8tRFPMtqWbixqm50z4cHkRXVBUsZ7CU1/j/3vZBSEx
         i02OxFKXk2LaAEF2fZz5tPHf9/q0ss9DbDxNVwhC7LKVfn+oQXptj0CFmw2v7eEfmSFJ
         M86CkeLLA/t8Wn0Nn9rrOWw8p4ZUls/7JJw8vEpy+N6au2YzdMd/T4PwcEHuveafA3sq
         zxAujieBdrx0MmJ2WiNkfYcYGM5h/HaN0/81OBBEE+PaVIft5zJvVBg0mxu7bj5mV/zF
         0CCxa96dPF8hFwabQ+wMVg+QK5D/GRETSm2SsNTVmgVJ6yDhF5p3QGC7wnIvZr2Oad3A
         aq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NRH6VONBYNIxV3zO4nNRr9V11VXjtGQdzP+hrNGAm3A=;
        b=T6cbmWobyD0mEe6npkDuF9Fl07889h5D1jGwYdj/71YAfQ1JqSeYTELeifZV8HTJRJ
         cVnDp6v8f5YV1NBuhLp6ljQwqO3hWnDpKZLNVHOI8PN1bpkSS8kruQq9Otc8z1WK/hru
         pWcrDkdmrorMdLIqp+VU0T3ze5bwEVUWKa4rxlL3obAZ2LEoEz6HyHf94L8qifDMsFUb
         wtlCLQZCYeZxkEoLoxwgMt95E1HYQwUl9V2GPFJfP6dXi7hQwbotMXj5yoenMNVJ1rY/
         9U6SZCgiXdAvKtJ0KD2KhSsBPlUe2Epbo6IGsSFHUATYKfIlYPtb1DXcXBZg3iFLoJI0
         00ew==
X-Gm-Message-State: AOAM5327vMJp1Orqvt4wopKXdR8ZpIrthghizs+Qcl9Z+2aMn9QkAd+y
        763KfkZUI/hRfi/I4n4K9QIdzw==
X-Google-Smtp-Source: ABdhPJyQ+wMmSncaYJbGrsIp+MuAFAXtXoBkYvhGm11e160LsNcAa3QgtmSHaVmvUvzrXb/dS3G0lQ==
X-Received: by 2002:aca:3087:: with SMTP id w129mr1737657oiw.78.1606199667073;
        Mon, 23 Nov 2020 22:34:27 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m65sm8116677otm.40.2020.11.23.22.34.24
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 23 Nov 2020 22:34:25 -0800 (PST)
Date:   Mon, 23 Nov 2020 22:34:12 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
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
        Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
In-Reply-To: <CAHk-=whYO5v09E8oHoYQDn7qqV0hBu713AjF+zxJ9DCr1+WOtQ@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2011232209540.5235@eggly.anvils>
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz> <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com> <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
 <CAHk-=whYO5v09E8oHoYQDn7qqV0hBu713AjF+zxJ9DCr1+WOtQ@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 23 Nov 2020, Linus Torvalds wrote:
> On Mon, Nov 23, 2020 at 8:07 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > The problem is that PageWriteback is not accompanied by a page reference
> > (as the NOTE at the end of test_clear_page_writeback() acknowledges): as
> > soon as TestClearPageWriteback has been done, that page could be removed
> > from page cache, freed, and reused for something else by the time that
> > wake_up_page() is reached.
> 
> Ugh.
> 
> Would it be possible to instead just make PageWriteback take the ref?
> 
> I don't hate your patch per se, but looking at that long explanation,
> and looking at the gyrations end_page_writeback() does, I go "why
> don't we do that?"
> 
> IOW, why couldn't we just make the __test_set_page_writeback()
> increment the page count if the writeback flag wasn't already set, and
> then make the end_page_writeback() do a put_page() after it all?

Right, that should be a lot simpler, and will not require any of the
cleanup (much as I liked that).  If you're reasonably confident that
adding the extra get_page+put_page to every writeback (instead of
just to the waited case, which I presume significantly less common)
will get lost in the noise - I was not confident of that, nor
confident of devising realistic tests to decide it.

What I did look into before sending, was whether in the filesystems
there was a pattern of doing a put_page() after *set_page_writeback(),
when it would just be a matter of deleting that put_page() and doing
it instead at the end of end_page_writeback().  But no: there were a
few cases like that, but in general no such pattern.

Though, what I think I'll try is not quite what you suggest there,
but instead do both get_page() and put_page() in end_page_writeback().
The reason being, there are a number of places (in mm at least) where
we judge what to do by the expected refcount: places that know to add
1 on when PagePrivate is set (for buffers), but do not expect to add
1 on when PageWriteback is set.  Now, all of those places probably
have to have their own wait_on_page_writeback() too, but I'd rather
narrow the window when the refcount is raised, than work through
what if any change would be needed in those places.

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
> So looking more at the patch, I started looking at this part:
> 
> > +       writeback = TestClearPageWriteback(page);
> > +       /* No need for smp_mb__after_atomic() after TestClear */
> > +       waiters = PageWaiters(page);
> > +       if (waiters) {
> > +               /*
> > +                * Writeback doesn't hold a page reference on its own, relying
> > +                * on truncation to wait for the clearing of PG_writeback.
> > +                * We could safely wake_up_page_bit(page, PG_writeback) here,
> > +                * while holding i_pages lock: but that would be a poor choice
> > +                * if the page is on a long hash chain; so instead choose to
> > +                * get_page+put_page - though atomics will add some overhead.
> > +                */
> > +               get_page(page);
> > +       }
> 
> and thinking more about this, my first reaction was "but that has the
> same race, just a smaller window".
> 
> And then reading the comment more, I realize you relied on the i_pages
> lock, and that this odd ordering was to avoid the possible latency.

Yes.  I decided to send the get_page+put_page variant, rather than the
wake_up_page_bit while holding i_pages variant (also tested), in part
because it's easier to edit the get_page+put_page one to the other.

> 
> But what about the non-mapping case? I'm not sure how that happens,
> but this does seem very fragile.

I don't see how the non-mapping case would ever occur: I think it
probably comes from a general pattern of caution about NULL mapping
when akpm (I think) originally wrote these functions.

> 
> I'm wondering why you didn't want to just do the get_page()
> unconditionally and early. Is avoiding the refcount really such a big
> optimization?

I don't know: I trust your judgement more than mine.

Hugh
