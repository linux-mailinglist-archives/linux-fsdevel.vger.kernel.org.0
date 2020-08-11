Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFC42422AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 00:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgHKWxq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 18:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgHKWxp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 18:53:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8864C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 15:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K2sl4AkU2uo+QTLvHtgtE6LwsWWeqPf/aJKVsrM/Stw=; b=v8VjPNkJaBL+p+SDDpqWbpsXcb
        4uUSVqcuPOMPvXP4rtVhCJLej6UcX2HBy9sVftFVSoK7LvTe5Pe5YS0gvHr/TMhK2q7o1clcOl588
        qV3CJnRey3flSQsZI7PFv60tVfNCxA31M6O5izEyyDV31E588QqLA3GeWfTvcQZr8780Tzfu45DKH
        JWtYpLrNrY5uXXket5yAll+dqcjWhpokCZTP3XSl7ntWuTriTUBN21G8qMDgcU8KywyO0lI56ZTU7
        weLHer6Wzwt86cGjEVlw9QfisHFEuhJ6suPu4cAJIUeF2uGZeok1ntZkL1BpWdMdDPrIM1GVNC1Qr
        6+Yr4QzA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5d9K-0007Ac-03; Tue, 11 Aug 2020 22:53:43 +0000
Date:   Tue, 11 Aug 2020 23:53:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/7] mm: Store compound_nr as well as compound_order
Message-ID: <20200811225341.GZ17456@casper.infradead.org>
References: <20200629151959.15779-1-willy@infradead.org>
 <20200629151959.15779-2-willy@infradead.org>
 <20200706102925.ot3vgdg5mnr5d4gh@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706102925.ot3vgdg5mnr5d4gh@box>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 06, 2020 at 01:29:25PM +0300, Kirill A. Shutemov wrote:
> On Mon, Jun 29, 2020 at 04:19:53PM +0100, Matthew Wilcox (Oracle) wrote:
> > This removes a few instructions from functions which need to know how many
> > pages are in a compound page.  The storage used is either page->mapping
> > on 64-bit or page->index on 32-bit.  Both of these are fine to overlay
> > on tail pages.
> 
> I'm not a fan of redundant data in struct page, even if it's less busy
> tail page. We tend to find more use of the space over time.
> 
> Any numbers on what it gives for typical kernel? Does it really worth it?

Oops, I overlooked this email.  Sorry.  Thanks to Andrew for the reminder.

I haven't analysed the performance win for this.  The assembly is
two instructions (11 bytes) shorter:

before:
    206c:       a9 00 00 01 00          test   $0x10000,%eax
    2071:       0f 84 af 02 00 00       je     2326 <shmem_add_to_page_cache.isra.0+0x3b6>
    2077:       41 0f b6 4c 24 51       movzbl 0x51(%r12),%ecx
    207d:       41 bd 01 00 00 00       mov    $0x1,%r13d
    2083:       49 8b 44 24 08          mov    0x8(%r12),%rax
    2088:       49 d3 e5                shl    %cl,%r13
    208b:       a8 01                   test   $0x1,%al

after:
    2691:       a9 00 00 01 00          test   $0x10000,%eax
    2696:       0f 84 95 01 00 00       je     2831 <shmem_add_to_page_cache.isr
a.0+0x291>
    269c:       49 8b 47 08             mov    0x8(%r15),%rax
    26a0:       45 8b 77 58             mov    0x58(%r15),%r14d
    26a4:       a8 01                   test   $0x1,%al

(there are other changes in these files, so the addresses aren't
meaningful).

If we need the space, we can always revert this patch.  It's all hidden
behind the macro anyway.
