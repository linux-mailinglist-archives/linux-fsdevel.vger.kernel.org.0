Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33603808DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 13:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhENLtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 07:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhENLtP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 07:49:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31B6C061574;
        Fri, 14 May 2021 04:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PMuhz7QmjDyUOOcCUlm1J8zGgwrLL0mcmdhwYH7Afe4=; b=QvCrTZ5Ysk4eK80ekakeQIJB79
        t30kKv+swkuk0a/ARhDHBg0cHciJXU5odZ7+irtsvrNLcSbXxJ2HpM5PzJPkRMChDEBrp0hsc6g/+
        N55Blbv9fdSv6W3TUgZtV0xFVqq2dGIAPt27vKf4Nm7C+hJpQw/PajoVUV3ANcadqDEKclSp7PiLg
        ZRX8vLW97ctsKogImgPm1mlpOgjFQ+3h0YrkabYCArd310ucDrDTdR09UUn++gwG91ms0moHDDAlX
        rfXMPqh5JhyW92MYGKy9hlmPvkLDYWIkgg4gyBNpHYvQn6xj4qB4rSNl24JcnX1rNp/n1Lue316hx
        Fydl24rg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lhWHV-00AKdf-Fe; Fri, 14 May 2021 11:47:18 +0000
Date:   Fri, 14 May 2021 12:47:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v10 01/33] mm: Introduce struct folio
Message-ID: <YJ5jNR2HwgfXk7Wv@casper.infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-2-willy@infradead.org>
 <ad8cd2e7-4111-f523-bc9c-5702b9071a5f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad8cd2e7-4111-f523-bc9c-5702b9071a5f@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 12:40:05PM +0200, Vlastimil Babka wrote:
> On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> > +/**
> > + * folio_page - Return a page from a folio.
> > + * @folio: The folio.
> > + * @n: The page number to return.
> > + *
> > + * @n is relative to the start of the folio.  It should be between
> > + * 0 and folio_nr_pages(@folio) - 1, but this is not checked for.
> > + */
> > +#define folio_page(folio, n)	nth_page(&(folio)->page, n)
> 
> BTW, would it make sense to have also a folio_page(folio) wrapper? Or is
> "&folio->page" used in later patches sufficiently elegant and stable enough for
> the future?

Ah!  If you see &folio->page in a patch, it's "a bad smell" [1].  At
this stage, it probably indicates "This other thing I need isn't
converted entirely to folios yet".  I consider it fine in
implementations of utility functions like this:

+static inline unsigned int folio_order(struct folio *folio)
+{
+       return compound_order(&folio->page);
+}

but when we see it here:

+void folio_unlock(struct folio *folio)
 {
        BUILD_BUG_ON(PG_waiters != 7);
-       page = compound_head(page);
-       VM_BUG_ON_PAGE(!PageLocked(page), page);
-       if (clear_bit_unlock_is_negative_byte(PG_locked, &page->flags))
-               wake_up_page_bit(page, PG_locked);
+       VM_BUG_ON_FOLIO(!folio_locked(folio), folio);
+       if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio, 0)))
+               wake_up_page_bit(&folio->page, PG_locked);
 }

that's an indication that wake_up_page_bit() needs to be converted to
folio_wake_bit(), which happens in a later patch.  I could probably
avoid this temporary problem with a different ordering of the patches,
but it's not clear to me that's a good use of my time.

The existing folio_page() is a way of distinguishing between "this
function i need to call doesn't have a folio equivalent yet" and "this
function i need to call needs to deal specifically with one page in
this folio".  For the former, use &folio->page; for the latter, use
folio_page() or folio_file_page().

[1] https://en.wikipedia.org/wiki/Code_smell
