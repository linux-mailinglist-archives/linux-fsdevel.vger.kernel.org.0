Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C44A513AF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 19:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350526AbiD1Rb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 13:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350520AbiD1Rb6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:31:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098684ECC6;
        Thu, 28 Apr 2022 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A+D+/+/O4qUxMhyVcAI68wJqSOKSL3LvvXpRZMY+WA0=; b=gn8Jdw8W3r5g87Spt44hs3Ak/H
        8IPwr/zyyJJ3MK3Joqp2+JZzlpjmz69i95f1GEVjsBP/253F4jCt3Sp28RGX91uESfNdsydmuOYmp
        QYe5Fz+cG2ZpXEEfeTHKGRJXFlqnaF3N+7pHg3ZRBFi4Yoc9klI+S9EY+yRc8E2+rXta73Lo4rRFd
        jvM54Y4HQIvX4rsV6TZohyBlpSWQ5Q+cgzOXKbpRBzt2V1BviR7YSQYOLhE5AO7gaLmY+ohSEQUJJ
        RcnafZYUrytbirtOsuPc6dpSYwKYPpUpQD0F4wwxS3/Ya3UJM48TE/GtHS7VPAo5X+c0LF+OeP+Nh
        UOmEVnpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk7wT-00BhXH-IS; Thu, 28 Apr 2022 17:28:37 +0000
Date:   Thu, 28 Apr 2022 18:28:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [RFC] Documentation for folio_lock() and friends
Message-ID: <YmrOxcbygu70fTFb@casper.infradead.org>
References: <YkspW4HDL54xEg69@casper.infradead.org>
 <164913769939.10985.13675614818955421206@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164913769939.10985.13675614818955421206@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 05, 2022 at 03:48:19PM +1000, NeilBrown wrote:
> On Tue, 05 Apr 2022, Matthew Wilcox wrote:
> > It's a shame to not have these functions documented.  I'm sure I've
> > missed a few things that would be useful to document here.
> > 
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index ab47579af434..47b7851f1b64 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -888,6 +888,18 @@ bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
> >  void unlock_page(struct page *page);
> >  void folio_unlock(struct folio *folio);
> >  
> > +/**
> > + * folio_trylock() - Attempt to lock a folio.
> > + * @folio: The folio to attempt to lock.
> > + *
> > + * Sometimes it is undesirable to wait for a folio to be unlocked (eg
> > + * when the locks are being taken in the wrong order, or if making
> > + * progress through a batch of folios is more important than processing
> > + * them in order).  Usually folio_lock() is the correct function to call.
> 
> Usually?
> I think a "see also" type reference to folio_lock() is useful, but I
> don't think "usually" is helpful.

That was supposed to stand in contrast to the "Sometimes".  How about
this:

 * folio_lock() is a sleeping function.  If sleeping is not the right
 * behaviour (eg when the locks are being taken in the wrong order,
 * or if making progress through a batch of folios is more important
 * than processing them in order) then you can use folio_trylock().
 * It is never appropriate to implement a spinlock using folio_trylock().

... if not, could you suggest some better wording?

> > +/**
> > + * folio_lock() - Lock this folio.
> > + * @folio: The folio to lock.
> > + *
> > + * The folio lock protects against many things, probably more than it
> > + * should.  It is primarily held while a folio is being read from storage,
> > + * either from its backing file or from swap.  It is also held while a
> > + * folio is being truncated from its address_space.
> > + *
> > + * Holding the lock usually prevents the contents of the folio from being
> > + * modified by other kernel users, although it does not prevent userspace
> > + * from modifying data if it's mapped.  The lock is not consistently held
> > + * while a folio is being modified by DMA.
> 
> I don't think this paragraph is helpful...  maybe if it listed which
> change *are* prevented by the lock, rather than a few which aren't?

I put that in because it's a common misconception ("holding the page
locked will prevent it from being modified").

> I think it is significant that the lock prevents removal from the page
> cache, and so ->mapping is only stable while the lock is held.  It might
> be worth adding something about that.

That's implied by the last sentence of the first paragraph, but I can
include that.  Actually, ->mapping is also stable if the page is mapped
and you hold the page table lock of a page table it's mapped in.  That's
not theoretical BTW, it's the conditions under which ->dirty_folio() is
called -- either the folio lock is held, OR the folio is mapped and the
PTL is held.  That prevents truncation because truncation unmaps pages
before clearing ->mapping, and it needs to take the PTL to unmap the page.

Hard to express that in a lockdep expression because the PTL isn't
passed to folio_mark_dirty().  That explanation probably doesn't
belong here, so how about ...

 * folio_lock() - Lock this folio.
 * @folio: The folio to lock.
 *
 * The folio lock protects against many things, probably more than it
 * should.  It is primarily held while a folio is being brought uptodate,
 * either from its backing file or from swap.  It is also held while a
 * folio is being truncated from its address_space, so holding the lock
 * is sufficient to keep folio->mapping stable.
 *
 * The folio lock is also held while write() is modifying the page to
 * provide POSIX atomicity guarantees (as long as the write does not
 * cross a page boundary).  Other modifications to the data in the folio
 * do not hold the folio lock and can race with writes, eg DMA and stores
 * to mapped pages.
 *
 * Context: May sleep.  If you need to acquire the locks of two or
 * more folios, they must be in order of ascending index, if they are
 * in the same address_space.  If they are in different address_spaces,
 * acquire the lock of the folio which belongs to the address_space which
 * has the lowest address in memory first.


Looking at the comment on folio_mark_dirty(), it's a bit unhelpful.
How about this:

  * folio_mark_dirty - Mark a folio as being modified.
  * @folio: The folio.
  *
- * For folios with a mapping this should be done with the folio lock held
- * for the benefit of asynchronous memory errors who prefer a consistent
- * dirty state. This rule can be broken in some special cases,
- * but should be better not to.
+ * The folio may not be truncated while this function is running.
+ * Holding the folio lock is sufficient to prevent truncation, but some
+ * callers cannot acquire a sleeping lock.  These callers instead hold
+ * the page table lock for a page table which contains at least one page
+ * in this folio.  Truncation will block on the page table lock as it
+ * unmaps pages before removing the folio from its mapping.
  *
  * Return: True if the folio was newly dirtied, false if it was already dirty.

