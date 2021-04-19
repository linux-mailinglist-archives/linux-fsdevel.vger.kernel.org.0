Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA04336457D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 15:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhDSN5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 09:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbhDSN5y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:57:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB435C061760;
        Mon, 19 Apr 2021 06:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/tlWzbdi//qKHyK5G0slZklY9aETTkVqjGgc9+iYW1k=; b=bbtd/diWxYwVeUnaIIgSpmK8iy
        16LuY12oWmKiMbef3weaPI7r/YcBBr4LE27B2jbZhIUFY7fvcUlJw1tEMpYiMQajBZvNPZ9gi3bsq
        4yTDJRDKxipox9qJH6DY2EAvetdnSJmu9/HoBC9bxse1Bi4EMqBoUN1dMXNTATn4fxOTiw1WX5mf6
        qufYE9Lu5YJIjlY3mz/nDYRPiCwaxN+ai8iMF/8KxbnA9l+S+l6iuj4W88djq4Qo6KTe2YWGvFH8H
        h6vbMatkIn3OaTUBNmkXV6AQEKqVQ8yj9Fal1OwcyAsaQZuM6DWkmgxocgcc1NgaA+Fz/WUyOksdC
        uYwy12QA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYUN6-00DqIB-2k; Mon, 19 Apr 2021 13:56:15 +0000
Date:   Mon, 19 Apr 2021 14:55:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v7 09/28] mm: Create FolioFlags
Message-ID: <20210419135528.GC2531743@casper.infradead.org>
References: <20210409185105.188284-1-willy@infradead.org>
 <20210409185105.188284-10-willy@infradead.org>
 <YH2E2jNvhEOwCinT@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH2E2jNvhEOwCinT@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 19, 2021 at 03:25:46PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 09, 2021 at 07:50:46PM +0100, Matthew Wilcox (Oracle) wrote:
> > These new functions are the folio analogues of the PageFlags functions.
> > If CONFIG_DEBUG_VM_PGFLAGS is enabled, we check the folio is not a tail
> > page at every invocation.  Note that this will also catch the PagePoisoned
> > case as a poisoned page has every bit set, which would include PageTail.
> > 
> > This saves 1727 bytes of text with the distro-derived config that
> > I'm testing due to removing a double call to compound_head() in
> > PageSwapCache().
> 
> I vote for dropping the Camels if we're going to rework all this.

I'm open to that.  It's a bit of rework now, but easier to do it as
part of this than as a separate series.

So, concretely:

PageReferences() becomes folio_referenced()
SetPageReferenced() becomes folio_set_referenced()
ClearPageReferenced() becomes folio_clear_referenced()
__SetFolioReferenced() becomes __folio_set_referenced()
__ClearFolioReferenced() becomes __folio_clear_referenced()
TestSetPageReferenced() becomes folio_test_set_referenced()
TestClearPageReferenced() becomes folio_test_clear_referenced()

We do have some functions already like set_page_writeback(), but I
think those can become folio_set_writeback() without doing any harm.
We also have page_is_young(), page_is_pfmemalloc(), page_is_guard(),
etc.  Should it be folio_referenced()?  or folio_is_referenced()?

