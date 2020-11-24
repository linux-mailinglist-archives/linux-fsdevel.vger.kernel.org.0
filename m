Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0282C2D3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 17:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390586AbgKXQq6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 11:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390479AbgKXQq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:46:58 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3A6C061A4D
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 08:46:57 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id o25so24493914oie.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 08:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=r2MNsblWMD0h7dACeUcQYwsvIz1+vfqKTGuqjygmt6A=;
        b=oek5p2spg5uGjV0ReaRb//qL3MZLLeV+cLAdm0LSD2luaYf/jDNBuTG0Zr/eipkW9j
         h49N3swg1t9yAVac0ZxbkFow2WD6DqYjY155804339u9GxeoPByd7eym9Nr6086ihBDT
         eYf5a0jiyTliGzfdOHSI4ajtt9jnEKy0KZwX3/8wjUnhpdNXJQt8x2xizOQvcCXIoKa1
         97qFZ/LtEYvNuXZvQv40oEAoT+/ppecOzxlCHrblncb8D172okfP5Z0DJf5pdH7Rx2ov
         HfyYP6Txu94ZDlfB44H/EirbhUxHcNNwiAyieHais+Kmop1A9dLE9fUgydyPMXifgKSk
         hwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=r2MNsblWMD0h7dACeUcQYwsvIz1+vfqKTGuqjygmt6A=;
        b=FwMNXpqIMgLNM9UuR+LdByzVxzKHfoJoLJRmppinNANuTns2t7Vjb+JQ7Nsa+Gm2lT
         vc2wm5aOYd6pXdykbN52s9N2Za9qG7M0RZS9g6LjRXfqGlHY+yRGLlH8im2cIl3o2jJA
         WLT8n5gz8iz6UPY360eQLzi1JNUsUhuXUWIrWMHX4wajOwukr1hanqZKILYlaNjIgRBa
         JkH21zXj4yjp1MlMq4SKlGQ48j6BxvXtO4hIObNYYm0Nfzi+hqv5ZNP5k44qG/Aa8lvC
         5FRF6NK+Q2gozbVN71RNLpAtiyl4+rqU88MHtxqw8xCVL/BeUkb/yNNGaac/TKJePfHC
         gSrQ==
X-Gm-Message-State: AOAM532WzLJWWSJK5yfoA9yZbRZ/iWdOhxLY+um11m2fIvO6LHYBfOUS
        XNHeFz9dO/X/ErM1CT0jD6i1Fw==
X-Google-Smtp-Source: ABdhPJzj+z/GgeTxVL78PTGW+krAb7PKM570vmQJp8/lGcFDamW4bBMW1aGm+4bcGrEUYHbbQUxYww==
X-Received: by 2002:aca:d755:: with SMTP id o82mr3124373oig.164.1606236416738;
        Tue, 24 Nov 2020 08:46:56 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i43sm8108918ota.39.2020.11.24.08.46.54
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 24 Nov 2020 08:46:55 -0800 (PST)
Date:   Tue, 24 Nov 2020 08:46:43 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Jan Kara <jack@suse.cz>,
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
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
In-Reply-To: <alpine.LSU.2.11.2011232209540.5235@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2011240837150.1142@eggly.anvils>
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz> <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com> <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
 <CAHk-=whYO5v09E8oHoYQDn7qqV0hBu713AjF+zxJ9DCr1+WOtQ@mail.gmail.com> <alpine.LSU.2.11.2011232209540.5235@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 23 Nov 2020, Hugh Dickins wrote:
> On Mon, 23 Nov 2020, Linus Torvalds wrote:
> > 
> > IOW, why couldn't we just make the __test_set_page_writeback()
> > increment the page count if the writeback flag wasn't already set, and
> > then make the end_page_writeback() do a put_page() after it all?
> 
> Right, that should be a lot simpler, and will not require any of the
> cleanup (much as I liked that).  If you're reasonably confident that
> adding the extra get_page+put_page to every writeback (instead of
> just to the waited case, which I presume significantly less common)
> will get lost in the noise - I was not confident of that, nor
> confident of devising realistic tests to decide it.
> 
> What I did look into before sending, was whether in the filesystems
> there was a pattern of doing a put_page() after *set_page_writeback(),
> when it would just be a matter of deleting that put_page() and doing
> it instead at the end of end_page_writeback().  But no: there were a
> few cases like that, but in general no such pattern.
> 
> Though, what I think I'll try is not quite what you suggest there,
> but instead do both get_page() and put_page() in end_page_writeback().
> The reason being, there are a number of places (in mm at least) where
> we judge what to do by the expected refcount: places that know to add
> 1 on when PagePrivate is set (for buffers), but do not expect to add
> 1 on when PageWriteback is set.  Now, all of those places probably
> have to have their own wait_on_page_writeback() too, but I'd rather
> narrow the window when the refcount is raised, than work through
> what if any change would be needed in those places.

This ran fine overnight on several machines - just to check I hadn't
screwed it up.  Vanishingly unlikely to have hit either condition,
nor would I have noticed any difference in performance.

[PATCH] mm: fix VM_BUG_ON(PageTail) and BUG_ON(PageWriteback)

Twice now, when exercising ext4 looped on shmem huge pages, I have crashed
on the PF_ONLY_HEAD check inside PageWaiters(): ext4_finish_bio() calling
end_page_writeback() calling wake_up_page() on tail of a shmem huge page,
no longer an ext4 page at all.

The problem is that PageWriteback is not accompanied by a page reference
(as the NOTE at the end of test_clear_page_writeback() acknowledges): as
soon as TestClearPageWriteback has been done, that page could be removed
from page cache, freed, and reused for something else by the time that
wake_up_page() is reached.

https://lore.kernel.org/linux-mm/20200827122019.GC14765@casper.infradead.org/
Matthew Wilcox suggested avoiding or weakening the PageWaiters() tail
check; but I'm paranoid about even looking at an unreferenced struct page,
lest its memory might itself have already been reused or hotremoved (and
wake_up_page_bit() may modify that memory with its ClearPageWaiters()).

Then on crashing a second time, realized there's a stronger reason against
that approach.  If my testing just occasionally crashes on that check,
when the page is reused for part of a compound page, wouldn't it be much
more common for the page to get reused as an order-0 page before reaching
wake_up_page()?  And on rare occasions, might that reused page already be
marked PageWriteback by its new user, and already be waited upon?  What
would that look like?

It would look like BUG_ON(PageWriteback) after wait_on_page_writeback()
in write_cache_pages() (though I have never seen that crash myself).

And prior to 2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic")
this would have been much less likely: before that, wake_page_function()'s
non-exclusive case would stop walking and not wake if it found Writeback
already set again; whereas now the non-exclusive case proceeds to wake.

I have not thought of a fix that does not add a little overhead: the
simplest fix is for end_page_writeback() to get_page() before calling
test_clear_page_writeback(), then put_page() after wake_up_page().

Was there a chance of missed wakeups before, since a page freed before
reaching wake_up_page() would have PageWaiters cleared?  I think not,
because each waiter does hold a reference on the page.  This bug comes
when the old use of the page, the one we do TestClearPageWriteback on,
had *no* waiters, so no additional page reference beyond the page cache
(and whoever racily freed it).  The reuse of the page has a waiter
holding a reference, and its own PageWriteback set; but the belated
wake_up_page() has woken the reuse to hit that BUG_ON(PageWriteback).

Reported-by: syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com
Reported-by: Qian Cai <cai@lca.pw>
Fixes: 2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org # v5.8+
---

 mm/filemap.c        |    8 ++++++++
 mm/page-writeback.c |    6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

--- 5.10-rc5/mm/filemap.c	2020-11-22 17:43:01.637279974 -0800
+++ linux/mm/filemap.c	2020-11-23 23:08:20.141851113 -0800
@@ -1484,11 +1484,19 @@ void end_page_writeback(struct page *pag
 		rotate_reclaimable_page(page);
 	}
 
+	/*
+	 * Writeback does not hold a page reference of its own, relying
+	 * on truncation to wait for the clearing of PG_writeback.
+	 * But here we must make sure that the page is not freed and
+	 * reused before the wake_up_page().
+	 */
+	get_page(page);
 	if (!test_clear_page_writeback(page))
 		BUG();
 
 	smp_mb__after_atomic();
 	wake_up_page(page, PG_writeback);
+	put_page(page);
 }
 EXPORT_SYMBOL(end_page_writeback);
 
--- 5.10-rc5/mm/page-writeback.c	2020-10-25 16:45:47.977843485 -0700
+++ linux/mm/page-writeback.c	2020-11-23 23:08:20.141851113 -0800
@@ -2754,12 +2754,6 @@ int test_clear_page_writeback(struct pag
 	} else {
 		ret = TestClearPageWriteback(page);
 	}
-	/*
-	 * NOTE: Page might be free now! Writeback doesn't hold a page
-	 * reference on its own, it relies on truncation to wait for
-	 * the clearing of PG_writeback. The below can only access
-	 * page state that is static across allocation cycles.
-	 */
 	if (ret) {
 		dec_lruvec_state(lruvec, NR_WRITEBACK);
 		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
