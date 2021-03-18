Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE99340C56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 18:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhCRR6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 13:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhCRR6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:58:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C589C06174A;
        Thu, 18 Mar 2021 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vZm4w+si9uU9aQrNJ3zwhuKonm9Y0JsStk/oRatNIc4=; b=QJVS2QBikxM65SlYiOHVDHGTvn
        jr2tWC5lD4nNxv30RZK00MhCdXvYT+rEuQa7l7tjRO0zyWCJb6VTWFL78QDlmm+eLHhEnyws/SA4r
        iAkbV3kr/ZNOnFDEXxSxFlI+QTnuDGb9m7pPWmHvk7AG+ZiV8DGhFom5aW4kg7PnAaVRU7uCV6XfQ
        7/ronkKeYKGdpsSRDemEQnvpSjyslzK/7Mb8ThUxwyCrGbwx1gNg6befAQ54piW2Za17/yuUnj4bz
        xh/H8F0UyfdZ5auGs9f8wXp1yhjmomXf1BHaIdgFgZPory6Iydt6tM8AF9gl5j+nqeNmphr6CxpK6
        uc5Oasyw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMwu7-003Jkp-S5; Thu, 18 Mar 2021 17:57:58 +0000
Date:   Thu, 18 Mar 2021 17:57:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 08/25] mm: Handle per-folio private data
Message-ID: <20210318175751.GS3420@casper.infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-9-willy@infradead.org>
 <YFI6YOe2uU/n2vR6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFI6YOe2uU/n2vR6@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 06:20:32PM +0100, Christoph Hellwig wrote:
> > +static inline void attach_page_private(struct page *page, void *data)
> > +{
> > +	attach_folio_private((struct folio *)page, data);
> > +}
> > +
> > +static inline void *detach_page_private(struct page *page)
> > +{
> > +	return detach_folio_private((struct folio *)page);
> > +}
> 
> I hate these open code casts.  Can't we have a single central
> page_to_folio helper, which could also grow a debug check (maybe
> under a new config option) to check that it really is called on a
> head page?

Some of that is already there.  We have page_folio() which is the
page_to_folio() helper you're asking for.  And folio_flags() (which is
called *all the time*) contains
        VM_BUG_ON_PGFLAGS(PageTail(page), page);
Someone passing around a tail pointer cast to a folio is not going to
get very far, assuming CONFIG_DEBUG_VM_PGFLAGS is enabled (most distros
don't, but I do when I'm testing anything THPish).

These helpers aren't going to live for very long ... I expect to have
all filesystems which use attach/detach page private converted to folios
pretty soon.  Certainly before any of them _use_ multi-page folios.

Anyway, the simple thing to do is just to use page_folio() here and eat
the cost of calling compound_head() on something we're certain is an
order-0 page.  It only defers the win of removing the compound_head()
call; it doesn't preclude it.  And it means we're not setting a bad
example here (there really shouldn't be any casts from pages to folios,
except in the folio allocator, which uses the page allocator and then
casts what _must be_ a non-tail page to a folio).
