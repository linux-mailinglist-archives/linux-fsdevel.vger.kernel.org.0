Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40366370509
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 May 2021 04:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhEACiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 22:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhEACiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 22:38:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE29FC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 19:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6I9FPHGXTulJKTj12DEmkVmAHPYyqomkRPK519Zr5Ao=; b=PTqNAMZndlMQ01Jkl2BBForNBl
        po14iGZhCDGLek83XwJc9Sfda0c0+D/tpzztVHF3h91ZruvGeNzKzfuKvCkKPqJ05u97GVuZtSf4k
        RDZ0TREX5eEkJvieiyuayBRs9dGtn24MX4GsDCXgtPwMw1/AOjeL6rqaT93QSiT7QtQ3QP+5PiNCD
        ArXICoeUj2pEdxBu25LYmdKD1kU85//17P3y8T3/Y5ilqkCu7XE0Mcw3Msj4NF+dNzPJHPK5temh/
        hWzguK0bFFLKf5wLi3iXpORcYkdZ2tSw0KufSTJt+Jq6s86eO/QlLc6lwT+HlsvFxC+S56kG+O+Vc
        bcMhFocw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcfVH-00BqsZ-37; Sat, 01 May 2021 02:37:14 +0000
Date:   Sat, 1 May 2021 03:37:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v8.1 00/31] Memory Folios
Message-ID: <20210501023711.GP1847222@casper.infradead.org>
References: <20210430180740.2707166-1-willy@infradead.org>
 <alpine.LSU.2.11.2104301141320.16885@eggly.anvils>
 <1619832406.8taoh84cay.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619832406.8taoh84cay.astroid@bobo.none>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 01, 2021 at 11:32:20AM +1000, Nicholas Piggin wrote:
> Excerpts from Hugh Dickins's message of May 1, 2021 4:47 am:
> > On Fri, 30 Apr 2021, Matthew Wilcox (Oracle) wrote:
> >>  - Big renaming (thanks to peterz):
> >>    - PageFoo() becomes folio_foo()
> >>    - SetFolioFoo() becomes folio_set_foo()
> >>    - ClearFolioFoo() becomes folio_clear_foo()
> >>    - __SetFolioFoo() becomes __folio_set_foo()
> >>    - __ClearFolioFoo() becomes __folio_clear_foo()
> >>    - TestSetPageFoo() becomes folio_test_set_foo()
> >>    - TestClearPageFoo() becomes folio_test_clear_foo()
> >>    - PageHuge() is now folio_hugetlb()
> 
> If you rename these things at the same time, can you make it clear 
> they're flags (folio_flag_set_foo())? The weird camel case accessors at 
> least make that clear (after you get to know them).
> 
> We have a set_page_dirty(), so page_set_dirty() would be annoying.
> page_flag_set_dirty() keeps the easy distinction that SetPageDirty()
> provides.

Maybe I should have sent more of the patches in this batch ...

mark_page_accessed() becomes folio_mark_accessed()
set_page_dirty() becomes folio_mark_dirty()
set_page_writeback() becomes folio_start_writeback()
test_clear_page_writeback() becomes __folio_end_writeback()
cancel_dirty_page() becomes folio_cancel_dirty()
clear_page_dirty_for_io() becomes folio_clear_dirty_for_io()
lru_cache_add() becomes folio_add_lru()
add_to_page_cache_lru() becomes folio_add_to_page_cache()
write_one_page() becomes folio_write_one()
account_page_redirty() becomes folio_account_redirty()
account_page_cleaned() becomes folio_account_cleaned()

So the general pattern is that folio_set_foo() and folio_clear_foo()
works on the flag directly.  If we do anything fancy to it, it's
folio_verb_foo() where verb depends on foo.

I'm not entirely comfortable with this.  I'd like to stop modules
from accessing folio_set_dirty() because it's just going to mess
up filesystems.  I just haven't thought of a good way to expose
some flags and not others.

Actually, looking at what filesystems actually use at the moment, it's
quite a small subset:

ClearPageChecked
ClearPageDirty
ClearPageError
ClearPageFsCache
__ClearPageLocked
ClearPageMappedToDisk
ClearPagePrivate2
ClearPagePrivate
ClearPageReferenced
ClearPageUptodate
TestClearPageError
TestClearPageFsCache
TestClearPagePrivate2
TestClearPageDirty

SetPageError
__SetPageLocked
SetPageMappedToDisk
SetPagePrivate2
SetPagePrivate
SetPageUptodate
__SetPageUptodate
TestSetPageDirty
TestSetPageFsCache

several of those are ... confused ... but the vast majority of page flags
don't need to be exposed to filesystems.  Does it make you feel better if
folio_set_dirty() doesn't get exposed outside the VFS?
