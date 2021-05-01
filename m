Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D4A37078F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 May 2021 16:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhEAOcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 May 2021 10:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhEAOcG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 May 2021 10:32:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF89EC06174A
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 May 2021 07:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xDmBUI6hsWPgWcBw60PznzQUmAxS2/iaYf0yquB+Hew=; b=slUcHygL38UmDpEXWUfGqoh0v4
        O0u/QlQhk+SxhhU2JNvuhPWOzfm2ubkOwoKcIsCW/3iJlqWNRbYsGJCx1FEVzuAB3sDR9uNjByVbP
        /P44k0HciHIstfyUy/NzclobuIw4vDNKvIP+dXU4Rk1DQIgKs6qZDyYpuzTGkhiI1skgrf8BTlW67
        P5dDFS0tESSTdatWbS8w/VCvA0ExoG3Z9eSCCBCgxJQHXf7rilj1zLFyQJUs4BQin3CL07w2YQfAI
        jBT9ovRKfJopYByN/EEvreGP3+BwqsszsUb4Vb9Y73POYG1EhZULS+B/Q30WnPdoO1UyKSuk7N+T+
        V0iHY8Wg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcqe8-00CTP8-IA; Sat, 01 May 2021 14:31:07 +0000
Date:   Sat, 1 May 2021 15:31:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v8.1 00/31] Memory Folios
Message-ID: <20210501143104.GR1847222@casper.infradead.org>
References: <20210430180740.2707166-1-willy@infradead.org>
 <alpine.LSU.2.11.2104301141320.16885@eggly.anvils>
 <1619832406.8taoh84cay.astroid@bobo.none>
 <20210501023711.GP1847222@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210501023711.GP1847222@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 01, 2021 at 03:37:11AM +0100, Matthew Wilcox wrote:
> On Sat, May 01, 2021 at 11:32:20AM +1000, Nicholas Piggin wrote:
> > Excerpts from Hugh Dickins's message of May 1, 2021 4:47 am:
> > > On Fri, 30 Apr 2021, Matthew Wilcox (Oracle) wrote:
> > >>  - Big renaming (thanks to peterz):
> > >>    - PageFoo() becomes folio_foo()
> > >>    - SetFolioFoo() becomes folio_set_foo()
> > >>    - ClearFolioFoo() becomes folio_clear_foo()
> > >>    - __SetFolioFoo() becomes __folio_set_foo()
> > >>    - __ClearFolioFoo() becomes __folio_clear_foo()
> > >>    - TestSetPageFoo() becomes folio_test_set_foo()
> > >>    - TestClearPageFoo() becomes folio_test_clear_foo()
> > >>    - PageHuge() is now folio_hugetlb()
> > 
> > If you rename these things at the same time, can you make it clear 
> > they're flags (folio_flag_set_foo())? The weird camel case accessors at 
> > least make that clear (after you get to know them).
> > 
> > We have a set_page_dirty(), so page_set_dirty() would be annoying.
> > page_flag_set_dirty() keeps the easy distinction that SetPageDirty()
> > provides.
> 
> Maybe I should have sent more of the patches in this batch ...
> 
> mark_page_accessed() becomes folio_mark_accessed()
> set_page_dirty() becomes folio_mark_dirty()
> set_page_writeback() becomes folio_start_writeback()
> test_clear_page_writeback() becomes __folio_end_writeback()
> cancel_dirty_page() becomes folio_cancel_dirty()
> clear_page_dirty_for_io() becomes folio_clear_dirty_for_io()
> lru_cache_add() becomes folio_add_lru()
> add_to_page_cache_lru() becomes folio_add_to_page_cache()
> write_one_page() becomes folio_write_one()
> account_page_redirty() becomes folio_account_redirty()
> account_page_cleaned() becomes folio_account_cleaned()
> 
> So the general pattern is that folio_set_foo() and folio_clear_foo()
> works on the flag directly.  If we do anything fancy to it, it's
> folio_verb_foo() where verb depends on foo.

After sleeping on this, I now think "Why not both?"

folio_dirty() -- defined in page-flags.h

folio_test_set_dirty_flag()
folio_test_clear_dirty_flag()
__folio_clear_dirty_flag()
__folio_set_dirty_flag()
folio_clear_dirty_flag()
folio_set_dirty_flag() -- generated in filemap.h under #ifndef MODULE

folio_mark_dirty() -- declared in mm.h (this is rare; turns out all kinds of
			crap wants to mark pages as being dirty)
folio_clear_dirty_for_io() -- declared in filemap.h


the other flags would mostly follow this pattern.  i'd also change
folio_set_uptodate() to folio_mark_uptodate().
