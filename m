Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9313ECAEB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 22:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhHOUYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 16:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhHOUYx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 16:24:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E35EC061764;
        Sun, 15 Aug 2021 13:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3hjLDBVIUuEhPE/QTKjTt6SD+T+B8p+I9/1rjQ1tlWw=; b=JDrV3hdxAMiAk9A1PYJebdSnnM
        RiAvvc8JofuBVJKF4j5mLzGMSH7jK+Q8rUXkcvhNlmzDfNZUc3o7TGtRIuBR15uXxXt9NwmgT+zLi
        FJ3YKjYHI/9NEbpLtnqWN4DcDB+2xWe9v0l6MeBYJVzmVr/rCsD8R3WXChBNVxFvmLWizNo9E3AG8
        BmvcphhW7VruAqXA9FgoD/mE+M1zFIEbQxTBGcxtXYeE33MrS4bjYZTJPUNR8KrEmO+28/u7Bex8k
        xu8RymFIgm77ppFY4cpmmwjqA2QtqjTBfOnQwaGJpBWvuFqcgFDB3EOnzt/EERoXRWa1xfujDRVqB
        O0beq22w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFMfl-000c6H-SK; Sun, 15 Aug 2021 20:24:07 +0000
Date:   Sun, 15 Aug 2021 21:23:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 078/138] mm/filemap: Add
 folio_mkwrite_check_truncate()
Message-ID: <YRl33SHZYkonh+ED@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-79-willy@infradead.org>
 <658f52db-47a1-606d-f19a-a666f5817ad9@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658f52db-47a1-606d-f19a-a666f5817ad9@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 07:08:33PM +0200, Vlastimil Babka wrote:
> > +/**
> > + * folio_mkwrite_check_truncate - check if folio was truncated
> > + * @folio: the folio to check
> > + * @inode: the inode to check the folio against
> > + *
> > + * Return: the number of bytes in the folio up to EOF,
> > + * or -EFAULT if the folio was truncated.
> > + */
> > +static inline ssize_t folio_mkwrite_check_truncate(struct folio *folio,
> > +					      struct inode *inode)
> > +{
> > +	loff_t size = i_size_read(inode);
> > +	pgoff_t index = size >> PAGE_SHIFT;
> > +	size_t offset = offset_in_folio(folio, size);
> > +
> > +	if (!folio->mapping)
> 
> The check in the page_ version is
> if (page->mapping != inode->i_mapping)
> 
> Why is the one above sufficient?

Oh, good question!

We know that at some point this page belonged to this file.  The caller
has a reference on it (and at the time they acquired a refcount on the
page, the page was part of the file).  The caller also has the page
locked, but has not checked that the page is still part of the file.
That's where we come in.

The truncate path looks up the page, locks it, removes it from i_pages,
unmaps it, sets the page->mapping to NULL, unlocks it and puts the page.

Because the folio_mkwrite_check_truncate() caller holds a reference on
the page, the truncate path will not free the page.  So there are only
two possibilities for the value of page->mapping; either it's the same
as inode->i_mapping, or it's NULL.

Now, maybe this is a bit subtle.  For robustness, perhaps we should
check that it's definitely still part of this file instead of checking
whether it is currently part of no file.  Perhaps at some point in the
future, we might get the reference to the page without checking that
it's still part of this file.  Opinions?
