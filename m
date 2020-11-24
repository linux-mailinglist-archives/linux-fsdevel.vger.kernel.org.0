Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B2B2C1C7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 05:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgKXEHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 23:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbgKXEHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 23:07:43 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2013C0613D6
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 20:07:41 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id z13so4483827ooa.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 20:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4s4srLlSIgeu4tQu6G6mnWxXPBj5BBQqj6M6YAiHAxM=;
        b=aSxbE0mO0zHJeuA0XRlTdeCizmtPtSZk0QeLZ83j9zLU2mI9YpC85EJ1pPCeLJnrhx
         llyE+/HHRk2oxLhvml1dUXheXk+JZJFWHd2GE3fAfgdNT7ChYX8USlgwc6qdIPhLjMGc
         VtJzcno9DZ7eMfYc9ALMaxGJETqujEzWzgK4fPeqbL0WF5lXjdvhsfPSGYzgUt4GB4MD
         llbIwiLTp3MnoxhI+EsLBVGzqVXoCGAM/XhxUCFbD3aSc9HQS81S3dC1vdqmJcx6iOAC
         UuD/0ldJmSAcl7ZDf9ebRXAyFe5Dnlu9zHEO2YVDL12M3HnLz+8sMPQZcGxOhR1r+orM
         Ct/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=4s4srLlSIgeu4tQu6G6mnWxXPBj5BBQqj6M6YAiHAxM=;
        b=iHZGlAiILGgvWdSL6M8kEVJzYI0Y0y0T5Ygfa0HlPCABtfWwsgbq+ESUWZY/e9RHCL
         dBKPthcXNLJIBHILsBD643QNFNLsyMa0O1syYs4AEJevQb6exTQy1Y31GL75V0hLJhqd
         3RSohTg/pPTFlfFkE/0QJx6aQfoGl13SL2eSSTcHVFYgRa72ziBlR3g7rQ65mG+TmSRT
         +rGniZu2rFvz4DC8cWQCpLtLm2/blwXg3rkEY8jM02p/I2/XDTCzB9eBSqLy8zoUt6qD
         Ukx6S/1cxWCYcwa3zwuIvgrIBMjb639DTkrLTdh6oA5wZ54XKUDdFovP8bVsRtE+PW+z
         XukQ==
X-Gm-Message-State: AOAM532jlaOzoTjaHKqgbvWw7064MZPAyBVItMxpt3iTp3/qYAh9QQSE
        fxrGUIqINFBt6wLsyxqmrS/U1w==
X-Google-Smtp-Source: ABdhPJwo7tt8Vg6oCOBPbR6cik3I/GPZahth1TIbz0UMD0k+HKHV2p3rilMyVpphvblvLDAY9TVwxA==
X-Received: by 2002:a4a:9cc7:: with SMTP id d7mr1948769ook.8.1606190860479;
        Mon, 23 Nov 2020 20:07:40 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m65sm7930807otm.40.2020.11.23.20.07.37
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 23 Nov 2020 20:07:39 -0800 (PST)
Date:   Mon, 23 Nov 2020 20:07:24 -0800 (PST)
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
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
In-Reply-To: <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz> <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 30 Aug 2020, Linus Torvalds wrote:
> On Mon, Aug 31, 2020 at 3:03 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 28-08-20 12:07:55, Jan Kara wrote:
> > >
> > > Doh, so this is:
> > >
> > >                         wait_on_page_writeback(page);
> > > >>>                     BUG_ON(PageWriteback(page));
> > >
> > > in mpage_prepare_extent_to_map(). So we have PageWriteback() page after we
> > > have called wait_on_page_writeback() on a locked page. Not sure how this
> > > could ever happen even less how ext4 could cause this...
> >
> > I was poking a bit into this and there were actually recent changes into
> > page bit waiting logic by Linus. Linus, any idea?
> 
> So the main change is that now if somebody does a wake_up_page(), the
> page waiter will be released - even if somebody else then set the bit
> again (or possible if the waker never cleared it!).
> 
> It used to be that the waiter went back to sleep.
> 
> Which really shouldn't matter, but if we had any code that did something like
> 
>         end_page_writeback();
>         .. something does set_page_writeback() on the page again ..
> 
> then the old BUG_ON() would likely never have triggered (because the
> waiter would have seen the writeback bit being set again and gone back
> to sleep), but now it will.
> 
> So I would suspect a pre-existing issue that was just hidden by the
> old behavior and was basically impossible to trigger unless you hit
> *just* the right timing.
> 
> And now it's easy to trigger, because the first time somebody clears
> PG_writeback, the wait_on_page_writeback() will just return *without*
> re-testing and *without* going back to sleep.
> 
> Could there be somebody who does set_page_writeback() without holding
> the page lock?
> 
> Maybe adding a
> 
>         WARN_ON_ONCE(!PageLocked(page));
> 
> at the top of __test_set_page_writeback() might find something?
> 
> Note that it looks like this problem has been reported on Android
> before according to that syzbot thing. Ie, this thing:
> 
>     https://groups.google.com/g/syzkaller-android-bugs/c/2CfEdQd4EE0/m/xk_GRJEHBQAJ
> 
> looks very similar, and predates the wake_up_page() changes.
> 
> So it was probably just much _harder_ to hit before, and got easier to hit.
> 
> Hmm. In fact, googling for
> 
>         mpage_prepare_extent_to_map "kernel BUG"
> 
> seems to find stuff going back years. Here's a patchwork discussion
> where you had a debug patch to try to figure it out back in 2016:
> 
>     https://patchwork.ozlabs.org/project/linux-ext4/patch/20161122133452.GF3973@quack2.suse.cz/
> 
> although that one seems to be a different BUG_ON() in the same area.
> 
> Maybe entirely unrelated, but the fact that this function shows up a
> fair amount is perhaps a sign of some long-running issue..

No recent updates here, nor in
https://lore.kernel.org/linux-mm/37abe67a5a7d83b361932464b4af499fdeaf5ef7.camel@redhat.com/
but I believe I've found the answer (or an answer) to this issue.

You may not care for this patch, but I haven't thought of a better,
so let me explain in its commit message.  And its "Fixes:" tag is unfair
to your patch, sorry: I agree the issue has probably lurked there longer.

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

I have not thought of a fix that does not add a little overhead.
It would be safe to wake_up_page() after TestClearPageWriteback()
while still holding i_pages lock (since that lock is needed to remove
the page from cache), but the history of long page lock hash chains
cautions against; so the patch below does get_page() when PageWaiters
there, and put_page() after wake_up_page_bit() at the end.  And in
any case, we do need the i_pages lock, even though it was skipped
before when !mapping_use_writeback_tags() i.e. swap.  Can mapping be
NULL? I don't see how, but allow for that with a WARN_ON_ONCE(): this
patch is no worse than before, but does not fix the issue if !mapping.

The bulk of the patch below is cleanup: it was not helpful to separate
test_clear_page_writeback() from end_page_writeback(), especially with
the latter declaring BUG() on a condition which the former was working
around: combine them into end_page_writeback() in mm/page-writeback.c.

Was there a chance of missed wakeups before, since a page freed before
reaching wake_up_page() would have PageWaiters cleared?  I think not,
because each waiter does hold a reference on the page: this bug comes
not from real waiters, but from when PageWaiters is a false positive.

Reported-by: syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com
Reported-by: Qian Cai <cai@lca.pw>
Fixes: 2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org # v5.8+
---

 include/linux/page-flags.h |    1 
 include/linux/pagemap.h    |    1 
 kernel/sched/wait_bit.c    |    5 -
 mm/filemap.c               |   35 ------------
 mm/page-writeback.c        |   96 ++++++++++++++++++++++-------------
 5 files changed, 67 insertions(+), 71 deletions(-)

--- 5.10-rc5/include/linux/page-flags.h	2020-10-25 16:45:47.061817039 -0700
+++ linux/include/linux/page-flags.h	2020-11-22 18:31:21.303046924 -0800
@@ -550,7 +550,6 @@ static __always_inline void SetPageUptod
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
 
-int test_clear_page_writeback(struct page *page);
 int __test_set_page_writeback(struct page *page, bool keep_write);
 
 #define test_set_page_writeback(page)			\
--- 5.10-rc5/include/linux/pagemap.h	2020-11-22 17:43:01.585279333 -0800
+++ linux/include/linux/pagemap.h	2020-11-22 18:31:21.303046924 -0800
@@ -660,6 +660,7 @@ static inline int lock_page_or_retry(str
  */
 extern void wait_on_page_bit(struct page *page, int bit_nr);
 extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
+extern void wake_up_page_bit(struct page *page, int bit_nr);
 
 /* 
  * Wait for a page to be unlocked.
--- 5.10-rc5/kernel/sched/wait_bit.c	2020-03-29 15:25:41.000000000 -0700
+++ linux/kernel/sched/wait_bit.c	2020-11-22 18:31:21.303046924 -0800
@@ -90,9 +90,8 @@ __wait_on_bit_lock(struct wait_queue_hea
 			ret = action(&wbq_entry->key, mode);
 			/*
 			 * See the comment in prepare_to_wait_event().
-			 * finish_wait() does not necessarily takes wwq_head->lock,
-			 * but test_and_set_bit() implies mb() which pairs with
-			 * smp_mb__after_atomic() before wake_up_page().
+			 * finish_wait() does not necessarily take
+			 * wwq_head->lock, but test_and_set_bit() implies mb().
 			 */
 			if (ret)
 				finish_wait(wq_head, &wbq_entry->wq_entry);
--- 5.10-rc5/mm/filemap.c	2020-11-22 17:43:01.637279974 -0800
+++ linux/mm/filemap.c	2020-11-22 18:31:21.303046924 -0800
@@ -1093,7 +1093,7 @@ static int wake_page_function(wait_queue
 	return (flags & WQ_FLAG_EXCLUSIVE) != 0;
 }
 
-static void wake_up_page_bit(struct page *page, int bit_nr)
+void wake_up_page_bit(struct page *page, int bit_nr)
 {
 	wait_queue_head_t *q = page_waitqueue(page);
 	struct wait_page_key key;
@@ -1147,13 +1147,6 @@ static void wake_up_page_bit(struct page
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
-static void wake_up_page(struct page *page, int bit)
-{
-	if (!PageWaiters(page))
-		return;
-	wake_up_page_bit(page, bit);
-}
-
 /*
  * A choice of three behaviors for wait_on_page_bit_common():
  */
@@ -1466,32 +1459,6 @@ void unlock_page(struct page *page)
 }
 EXPORT_SYMBOL(unlock_page);
 
-/**
- * end_page_writeback - end writeback against a page
- * @page: the page
- */
-void end_page_writeback(struct page *page)
-{
-	/*
-	 * TestClearPageReclaim could be used here but it is an atomic
-	 * operation and overkill in this particular case. Failing to
-	 * shuffle a page marked for immediate reclaim is too mild to
-	 * justify taking an atomic operation penalty at the end of
-	 * ever page writeback.
-	 */
-	if (PageReclaim(page)) {
-		ClearPageReclaim(page);
-		rotate_reclaimable_page(page);
-	}
-
-	if (!test_clear_page_writeback(page))
-		BUG();
-
-	smp_mb__after_atomic();
-	wake_up_page(page, PG_writeback);
-}
-EXPORT_SYMBOL(end_page_writeback);
-
 /*
  * After completing I/O on a page, call this routine to update the page
  * flags appropriately
--- 5.10-rc5/mm/page-writeback.c	2020-10-25 16:45:47.977843485 -0700
+++ linux/mm/page-writeback.c	2020-11-22 18:31:21.303046924 -0800
@@ -589,7 +589,7 @@ static void wb_domain_writeout_inc(struc
 
 /*
  * Increment @wb's writeout completion count and the global writeout
- * completion count. Called from test_clear_page_writeback().
+ * completion count. Called from end_page_writeback().
  */
 static inline void __wb_writeout_inc(struct bdi_writeback *wb)
 {
@@ -2719,55 +2719,85 @@ int clear_page_dirty_for_io(struct page
 }
 EXPORT_SYMBOL(clear_page_dirty_for_io);
 
-int test_clear_page_writeback(struct page *page)
+/**
+ * end_page_writeback - end writeback against a page
+ * @page: the page
+ */
+void end_page_writeback(struct page *page)
 {
-	struct address_space *mapping = page_mapping(page);
+	struct address_space *mapping;
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
-	int ret;
+	unsigned long flags;
+	int writeback;
+	int waiters;
+
+	/*
+	 * TestClearPageReclaim could be used here but it is an atomic
+	 * operation and overkill in this particular case. Failing to
+	 * shuffle a page marked for immediate reclaim is too mild to
+	 * justify taking an atomic operation penalty at the end of
+	 * every page writeback.
+	 */
+	if (PageReclaim(page)) {
+		ClearPageReclaim(page);
+		rotate_reclaimable_page(page);
+	}
 
+	mapping = page_mapping(page);
+	WARN_ON_ONCE(!mapping);
 	memcg = lock_page_memcg(page);
 	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+
+	dec_lruvec_state(lruvec, NR_WRITEBACK);
+	dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
+	inc_node_page_state(page, NR_WRITTEN);
+
+	if (mapping)
+		xa_lock_irqsave(&mapping->i_pages, flags);
+
+	writeback = TestClearPageWriteback(page);
+	/* No need for smp_mb__after_atomic() after TestClear */
+	waiters = PageWaiters(page);
+	if (waiters) {
+		/*
+		 * Writeback doesn't hold a page reference on its own, relying
+		 * on truncation to wait for the clearing of PG_writeback.
+		 * We could safely wake_up_page_bit(page, PG_writeback) here,
+		 * while holding i_pages lock: but that would be a poor choice
+		 * if the page is on a long hash chain; so instead choose to
+		 * get_page+put_page - though atomics will add some overhead.
+		 */
+		get_page(page);
+	}
+
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
-		unsigned long flags;
 
-		xa_lock_irqsave(&mapping->i_pages, flags);
-		ret = TestClearPageWriteback(page);
-		if (ret) {
-			__xa_clear_mark(&mapping->i_pages, page_index(page),
+		__xa_clear_mark(&mapping->i_pages, page_index(page),
 						PAGECACHE_TAG_WRITEBACK);
-			if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
-				struct bdi_writeback *wb = inode_to_wb(inode);
+		if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
+			struct bdi_writeback *wb = inode_to_wb(inode);
 
-				dec_wb_stat(wb, WB_WRITEBACK);
-				__wb_writeout_inc(wb);
-			}
+			dec_wb_stat(wb, WB_WRITEBACK);
+			__wb_writeout_inc(wb);
 		}
+		if (inode && !mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
+			sb_clear_inode_writeback(inode);
+	}
 
-		if (mapping->host && !mapping_tagged(mapping,
-						     PAGECACHE_TAG_WRITEBACK))
-			sb_clear_inode_writeback(mapping->host);
-
+	if (mapping)
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
-	} else {
-		ret = TestClearPageWriteback(page);
-	}
-	/*
-	 * NOTE: Page might be free now! Writeback doesn't hold a page
-	 * reference on its own, it relies on truncation to wait for
-	 * the clearing of PG_writeback. The below can only access
-	 * page state that is static across allocation cycles.
-	 */
-	if (ret) {
-		dec_lruvec_state(lruvec, NR_WRITEBACK);
-		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
-		inc_node_page_state(page, NR_WRITTEN);
-	}
 	__unlock_page_memcg(memcg);
-	return ret;
+
+	if (waiters) {
+		wake_up_page_bit(page, PG_writeback);
+		put_page(page);
+	}
+	BUG_ON(!writeback);
 }
+EXPORT_SYMBOL(end_page_writeback);
 
 int __test_set_page_writeback(struct page *page, bool keep_write)
 {
