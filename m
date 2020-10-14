Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789CE28E367
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 17:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgJNPil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 11:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgJNPil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:38:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B18C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=gCQenQmonwfZIEocLMbRlLubh9CqyAW01QUy3LdwUVk=; b=a0nr9Jo2mkDYlUfy/x6loKnsUx
        wavuwzHSlSherzjmTVTOS1Ry8BxZFllJ6TUgEWDMFp8TBsAxH0vuDS9iE1nanvNvA/EMvQ/327INC
        ZkeONnkRD+A6HvJXgAXUN78c+pc+rhWoPGGVpnL/gkBKE6GUvYjADrtjmQIKxYU25sYrdK9dl0+Cy
        xbzptPxy7sogf/dIn00HLHhpFuyFl9FPNN8PkvTHHn+Nuxt1G44eqVtyhvVXMmiixIe/WITX0KdC0
        A4mSpwJ4m25riQTOdyIfKccOZQrMKzFFOwDPg/dIjcCLFckcEzdqBl+f4O2R5TBP9MmgCzbuo/MJs
        j5K34sIA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSirM-0006HA-H3; Wed, 14 Oct 2020 15:38:36 +0000
Date:   Wed, 14 Oct 2020 16:38:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Mason <clm@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: PagePrivate handling
Message-ID: <20201014153836.GM20115@casper.infradead.org>
References: <20201014134909.GL20115@casper.infradead.org>
 <B60A55DB-6AB7-48BF-8F11-68FF6FF46C4E@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B60A55DB-6AB7-48BF-8F11-68FF6FF46C4E@fb.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 10:50:51AM -0400, Chris Mason wrote:
> On 14 Oct 2020, at 9:49, Matthew Wilcox wrote:
> > Our handling of PagePrivate, page->private and PagePrivate2 is a giant
> > mess.  Let's recap.
> > 
> > Filesystems which use bufferheads (ie most of them) set page->private
> > to point to a buffer_head, set the PagePrivate bit and increment the
> > refcount on the page.
> > 
> > The vmscan pageout code (*) needs to know whether a page is freeable:
> >         if (!is_page_cache_freeable(page))
> >                 return PAGE_KEEP;
> > ... where is_page_cache_freeable() contains ...
> >         return page_count(page) - page_has_private(page) == 1 +
> > page_cache_pins;
> > 
> > That's a little inscrutable, but the important thing is that if
> > page_has_private() is true, then the page's reference count is supposed
> > to be one higher than it would be otherwise.  And that makes sense given
> > how "having bufferheads" means "page refcount ges incremented".
> > 
> > But page_has_private() doesn't actually mean "PagePrivate is set".
> > It means "PagePrivate or PagePrivate2 is set".  And I don't understand
> > how filesystems are supposed to keep that straight -- if we're setting
> > PagePrivate2, and PagePrivate is clear, increment the refcount?
> > If we're clearing PagePrivate, decrement the refcount if PagePrivate2
> > is also clear?
> 
> At least for btrfs, only PagePrivate elevates the refcount on the page.
> PagePrivate2 means:
> 
> This page has been properly setup for COW’d IO, and it went through the
> normal path of page_mkwrite() or file_write() instead of being silently
> dirtied by a deep corner of the MM.

What's not clear to me is whether btrfs can be in the situation where
PagePrivate2 is set and PagePrivate is clear.  If so, then we have a bug
to fix.

> > We introduced attach_page_private() and detach_page_private() earlier
> > this year to help filesystems get the refcount right.  But we still
> > have a few filesystems using PagePrivate themselves (afs, btrfs, ceph,
> > crypto, erofs, f2fs, jfs, nfs, orangefs & ubifs) and I'm not convinced
> > they're all getting it right.
> > 
> > Here's a bug I happened on while looking into this:
> > 
> >         if (page_has_private(page))
> >                 attach_page_private(newpage, detach_page_private(page));
> > 
> >         if (PagePrivate2(page)) {
> >                 ClearPagePrivate2(page);
> >                 SetPagePrivate2(newpage);
> >         }
> > 
> > The aggravating thing is that this doesn't even look like a bug.
> > You have to be in the kind of mood where you're thinking "What if page
> > has Private2 set and Private clear?" and the answer is that newpage
> > ends up with PagePrivate set, but page->private set to NULL.
> 
> Do you mean PagePrivate2 set but page->private NULL?

Sorry, I skipped a step of the explanation.

page_has_private returns true if Private or Private2 is set.  So if
page has PagePrivate clear and PagePrivate2 set, newpage will end up
with both PagePrivate and PagePrivate2 set -- attach_page_private()
doesn't check whether the pointer is NULL (and IMO, it shouldn't).

Given our current macros, what was _meant_ here was:

         if (PagePrivate(page))
                 attach_page_private(newpage, detach_page_private(page));

but that's not obviously right.

> Btrfs should only hage
> PagePrivate2 set on pages that are formally in our writeback state machine,
> so it’ll get cleared as we unwind through normal IO or truncate etc.  For
> data pages, btrfs page->private is simply set to 1 so the MM will kindly
> call releasepage for us.

That's not what I'm seeing here:

static void attach_extent_buffer_page(struct extent_buffer *eb,
                                      struct page *page)
{
        if (!PagePrivate(page))
                attach_page_private(page, eb);
        else
                WARN_ON(page->private != (unsigned long)eb);
}

Or is that not a data page?

> > So what shold we do about all this?  First, I want to make the code
> > snippet above correct, because it looks right.  So page_has_private()
> > needs to test just PagePrivate and not PagePrivate2.  Now we need a
> > new function to call to determine whether the filesystem needs its
> > invalidatepage callback invoked.  Not sure what that should be named.
> 
> I haven’t checked all the page_has_private() callers, but maybe
> page_has_private() should stay the same and add page_private_count() for
> times where we need to get out our fingers and toes for the refcount math.

I was thinking about page_expected_count() which returns the number of
references from the page cache plus the number of references from
the various page privates.  So is_page_cache_freeable() becomes:

	return page_count(page) == page_expected_count(page) + 1;

can_split_huge_page() becomes:

	if (page_has_private(page))
		return false;
	return page_count(page) == page_expected_count(page) +
			total_mapcount(page) + 1;

> > I think I also want to rename PG_private_2 to PG_owner_priv_2.
> > There's a clear relationship between PG_private and page->private.
> > There is no relationship between PG_private_2 and page->private, so it's
> > a misleading name.  Or maybe it should just be PG_fscache and btrfs can
> > find some other way to mark the pages?
> 
> Btrfs should be able to flip bits in page->private to cover our current
> usage of PG_private_2.  If we ever attach something real to page->private,
> we can flip bits in that instead.  It’s kinda messy though and we’d have to
> change attach_page_private a little to reflect its new life as a bit setting
> machine.

It's not great, but with David wanting to change how PageFsCache is used,
it may be unavoidable (I'm not sure if he's discussed that with you yet)
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=fscache-iter&id=6f10fd7766ed6d87c3f696bb7931281557b389f5 shows part of it
-- essentially he wants to make PagePrivate2 mean that I/O is currently
ongoing to an fscache, and so truncate needs to wait on it being finished.

> > 
> > Also ... do we really need to increment the page refcount if we have
> > PagePrivate set?  I'm not awfully familiar with the buffercache -- is
> > it possible we end up in a situation where a buffer, perhaps under I/O,
> > has the last reference to a struct page?  It seems like that reference
> > is
> > always put from drop_buffers() which is called from
> > try_to_free_buffers()
> > which is always called by someone who has a reference to a struct page
> > that they got from the pagecache.  So what is this reference count for?
> 
> I’m not sure what we gain by avoiding the refcount bump?  Many filesystems
> use the pattern of: “put something in page->private, free that thing in
> releasepage.”  Without the refcount bump it feels like we’d have more magic
> to avoid freeing the page without leaking things in page->private.  I think
> the extra ref lets the FS crowd keep our noses out of the MM more often, so
> it seems like a net positive to me.

The question is whether the "thing" in page->private can ever have the
last reference on a struct page.  Gao says erofs can be in that situation,
so never mind this change.

