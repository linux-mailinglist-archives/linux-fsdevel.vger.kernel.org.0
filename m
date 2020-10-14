Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213C828E1A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 15:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgJNNtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 09:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgJNNtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:49:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8D0C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Xrn4UVQxl89wkUAKqCKref0AgwtCQZS0u+gdq+m30fA=; b=ksKg7vwg2L5KNjxMdVR0QfRKSe
        GePJvw6XrxBnwXTACw6lwaTx9IaWm5sYtEF442PCP2/SMtJj9VBQiEgP/uv2K23d7xF8KiEhyiVEB
        ovXs8L6eeRJg7kjstDeKJVZnaJTrt/OlXj+g978Uu9tyJ1S2JdOZlcwxN0rYrH9XtcKG+EshkW77w
        U7093BsUCx3HtLMZXNi2nx2hmhba089pSKg0kOErsKSHOSoHSU3OGIkyDsc8jnDUx//tcHdb1vLOW
        bscKj64SCxaazjPuE8bBgfSNe8dLC2XYi19nXHWXhQ99UBRDa0MA1n0mL1zR0fD67aysJ4Bj832Wo
        DRAN5P+w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSh9R-0000DG-4J; Wed, 14 Oct 2020 13:49:09 +0000
Date:   Wed, 14 Oct 2020 14:49:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Howells <dhowells@redhat.com>
Subject: PagePrivate handling
Message-ID: <20201014134909.GL20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Our handling of PagePrivate, page->private and PagePrivate2 is a giant
mess.  Let's recap.

Filesystems which use bufferheads (ie most of them) set page->private
to point to a buffer_head, set the PagePrivate bit and increment the
refcount on the page.

The vmscan pageout code (*) needs to know whether a page is freeable:
        if (!is_page_cache_freeable(page))
                return PAGE_KEEP;
... where is_page_cache_freeable() contains ...
        return page_count(page) - page_has_private(page) == 1 + page_cache_pins;

That's a little inscrutable, but the important thing is that if
page_has_private() is true, then the page's reference count is supposed
to be one higher than it would be otherwise.  And that makes sense given
how "having bufferheads" means "page refcount ges incremented".

But page_has_private() doesn't actually mean "PagePrivate is set".
It means "PagePrivate or PagePrivate2 is set".  And I don't understand
how filesystems are supposed to keep that straight -- if we're setting
PagePrivate2, and PagePrivate is clear, increment the refcount?
If we're clearing PagePrivate, decrement the refcount if PagePrivate2
is also clear?

We introduced attach_page_private() and detach_page_private() earlier
this year to help filesystems get the refcount right.  But we still
have a few filesystems using PagePrivate themselves (afs, btrfs, ceph,
crypto, erofs, f2fs, jfs, nfs, orangefs & ubifs) and I'm not convinced
they're all getting it right.

Here's a bug I happened on while looking into this:

        if (page_has_private(page))
                attach_page_private(newpage, detach_page_private(page));

        if (PagePrivate2(page)) {
                ClearPagePrivate2(page);
                SetPagePrivate2(newpage);
        }

The aggravating thing is that this doesn't even look like a bug.
You have to be in the kind of mood where you're thinking "What if page
has Private2 set and Private clear?" and the answer is that newpage
ends up with PagePrivate set, but page->private set to NULL.  And I
don't know whether this is a situation that can ever happen with btrfs,
but we shouldn't have code like this lying around in the tree because
it _looks_ right and somebody else might copy it.

So what shold we do about all this?  First, I want to make the code
snippet above correct, because it looks right.  So page_has_private()
needs to test just PagePrivate and not PagePrivate2.  Now we need a
new function to call to determine whether the filesystem needs its
invalidatepage callback invoked.  Not sure what that should be named.

I think I also want to rename PG_private_2 to PG_owner_priv_2.
There's a clear relationship between PG_private and page->private.
There is no relationship between PG_private_2 and page->private, so it's
a misleading name.  Or maybe it should just be PG_fscache and btrfs can
find some other way to mark the pages?

Also ... do we really need to increment the page refcount if we have
PagePrivate set?  I'm not awfully familiar with the buffercache -- is
it possible we end up in a situation where a buffer, perhaps under I/O,
has the last reference to a struct page?  It seems like that reference is
always put from drop_buffers() which is called from try_to_free_buffers()
which is always called by someone who has a reference to a struct page
that they got from the pagecache.  So what is this reference count for?

(*) Also THP split and page migration.  But maybe you don't care about
those things ... you definitely care about pageout!
