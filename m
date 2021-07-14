Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384533C85BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 16:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbhGNOHF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 10:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhGNOHF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:07:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C67C06175F;
        Wed, 14 Jul 2021 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WOmlUxJ/fNDV743IUVs9ki0OfQCNwpCeAeNQZqslUxs=; b=JdFOgclV2hYdDuLhl/7tmnxIFu
        Yp5ZTizwqbUY0ckDTQPlYCtnyqBsO3MjWmPfkjKm+Npgjro/enXyebDYDa9dlqu3NMlJgwWI2XvpR
        0u3z1aZXDyCY4TdYOWutI2Jus3QPdOUwzDKRbTJd8WCEvDGSmwtH3rQtyYwo8BBdqAAveyQU3/rE0
        HeXBJXKEJQ5V4qU1XExMKVeneNZEio4D66+f98O2u8nq5Y51mnpGl767Ulz23xswqEftIVEYK2QoC
        T4vsnvwyCxinQzcFv9Luugqi4hlmlyW/m7WBfamRk+mkJq0EV2LuBivg/g6jg0hcmloUSpNnhmfb1
        zULYF3tA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3fUF-002GdH-Vh; Wed, 14 Jul 2021 14:03:48 +0000
Date:   Wed, 14 Jul 2021 15:03:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v13 010/137] mm: Add folio flag manipulation functions
Message-ID: <YO7uv8tBI7yQiLb/@casper.infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
 <20210712030701.4000097-11-willy@infradead.org>
 <YOzdKYejOEUbjvMj@cmpxchg.org>
 <YOz3Lms9pcsHPKLt@casper.infradead.org>
 <20210713091533.GB4132@worktop.programming.kicks-ass.net>
 <YO23WOUhhZtL6Gtn@cmpxchg.org>
 <20210713185628.9962f4ce987fd952515c83fa@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713185628.9962f4ce987fd952515c83fa@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 13, 2021 at 06:56:28PM -0700, Andrew Morton wrote:
> On Tue, 13 Jul 2021 11:55:04 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> > I agree that _is_ reads nicer by itself, but paired with other ops
> > such as testset, _test_ might be better.
> > 
> > For example, in __set_page_dirty_no_writeback()
> > 
> > 	if (folio_is_dirty())
> > 		return !folio_testset_dirty()
> > 
> > is less clear about what's going on than would be:
> > 
> > 	if (folio_test_dirty())
> > 		return !folio_testset_dirty()
> 
> I like folio_is_foo().  As long as it is used consistently, we'll get
> used to it quickly.

I'm not sure that folio_is_private(), folio_is_lru(),
folio_is_waiters(), or folio_is_reclaim() really work.

> Some GNU tools are careful about appending "_p" to
> functions-which-test-something (stands for "predicate").  Having spent
> a lot of time a long time ago with my nose in this stuff, I found the
> convention to be very useful.  I think foo_is_bar() is as good as
> foo_bar_p() in this regard.

I just wish C let us put '?' on the end of a function name, but I
recognise the ambiguity with foo?bar:baz;

> And sure, the CaMeLcAsE is fugly, but it sure is useful. 
> set_page_dirty() is very different from SetPageDirty() and boy that
> visual differentiation is a relief.

Oh, I'm glad you brought that up </sarcasm>

In folios, here's how that ends up looking:

SetPageDirty() -> folio_set_dirty_flag()
		 (johannes proposes folio_set_dirty instead)
set_page_dirty() -> folio_mark_dirty()
aops->set_page_dirty() -> aops->dirty_folio()
__set_page_dirty() -> __folio_mark_dirty()
__set_page_dirty_buffers() -> block_dirty_folio()
__set_page_dirty_nobuffers() -> filemap_dirty_folio()
__set_page_dirty_no_writeback() -> dirty_folio_no_writeback()

I kind of feel that last one should be nowb_dirty_folio(), but I'm also
hoping to eliminate it; if the filesystem sets AS_NO_WRITEBACK_TAGS
in mapping->flags, then we just inline the no-writeback case into
folio_mark_dirty() (which already has it for the !mapping case).
