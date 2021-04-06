Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16F355438
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 14:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344204AbhDFMst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 08:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344206AbhDFMss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:48:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825F0C06174A;
        Tue,  6 Apr 2021 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CA9+GCPN3x6Z5hKcYRzM3r8Ts3deLeZx5UJVoF7+tNE=; b=wR3a+Y4XXolRLqwzrQyiky8UUC
        pAJ5CpX/TpwCDY1hw2XJH07o/43t5sM9R4Pcb4W1JBVJUnvf50TFWsSjz9HTSGklLw2aQFXMDPlEo
        w/k4IWIGr6GFOiwYaEl7HBAiVkr0U0EQqye/rLfyvNdQgGhy+JZS4bFZTSfnzgDu86vtlcVYxIVkb
        cKcqhjLSGLdsFDqrUz8abYZHUIy4DZsZrNzxAbOXWY0I2s0k7k/RW2IrVffvJTBZLrEmm+mnWwOwf
        HQtaugWjj5yq9EPRp8CaJE/XCiXxi0fV3U3ruHurV+fyLRLnsXDwHcJjXAaYQbCFKxXLb85QlZTQJ
        FvETcUFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTl7n-00CoN1-SM; Tue, 06 Apr 2021 12:48:27 +0000
Date:   Tue, 6 Apr 2021 13:48:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 01/27] mm: Introduce struct folio
Message-ID: <20210406124807.GO2531743@casper.infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-2-willy@infradead.org>
 <20210406122918.h5dsnbjhmwpfasf4@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406122918.h5dsnbjhmwpfasf4@box.shutemov.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 03:29:18PM +0300, Kirill A. Shutemov wrote:
> On Wed, Mar 31, 2021 at 07:47:02PM +0100, Matthew Wilcox (Oracle) wrote:
> > +/**
> > + * folio_next - Move to the next physical folio.
> > + * @folio: The folio we're currently operating on.
> > + *
> > + * If you have physically contiguous memory which may span more than
> > + * one folio (eg a &struct bio_vec), use this function to move from one
> > + * folio to the next.  Do not use it if the memory is only virtually
> > + * contiguous as the folios are almost certainly not adjacent to each
> > + * other.  This is the folio equivalent to writing ``page++``.
> > + *
> > + * Context: We assume that the folios are refcounted and/or locked at a
> > + * higher level and do not adjust the reference counts.
> > + * Return: The next struct folio.
> > + */
> > +static inline struct folio *folio_next(struct folio *folio)
> > +{
> > +#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
> > +	return (struct folio *)nth_page(&folio->page, folio_nr_pages(folio));
> > +#else
> > +	return folio + folio_nr_pages(folio);
> > +#endif
> 
> Do we really need the #if here?
> 
> >From quick look at nth_page() and memory_model.h, compiler should be able
> to simplify calculation for FLATMEM or SPARSEMEM_VMEMMAP to what you do in
> the #else. No?

No.

0000000000001180 <a>:
struct page *a(struct page *p, unsigned long n)
{
    1180:       e8 00 00 00 00          callq  1185 <a+0x5>
                        1181: R_X86_64_PLT32    __fentry__-0x4
    1185:       55                      push   %rbp
        return nth_page(p, n);
    1186:       48 2b 3d 00 00 00 00    sub    0x0(%rip),%rdi
                        1189: R_X86_64_PC32     vmemmap_base-0x4
    118d:       48 c1 ff 06             sar    $0x6,%rdi
    1191:       48 8d 04 37             lea    (%rdi,%rsi,1),%rax
    1195:       48 89 e5                mov    %rsp,%rbp
        return nth_page(p, n);
    1198:       48 c1 e0 06             shl    $0x6,%rax
    119c:       48 03 05 00 00 00 00    add    0x0(%rip),%rax
                        119f: R_X86_64_PC32     vmemmap_base-0x4
    11a3:       5d                      pop    %rbp
    11a4:       c3                      retq   

vs

00000000000011b0 <b>:

struct page *b(struct page *p, unsigned long n)
{
    11b0:       e8 00 00 00 00          callq  11b5 <b+0x5>
                        11b1: R_X86_64_PLT32    __fentry__-0x4
    11b5:       55                      push   %rbp
        return p + n;
    11b6:       48 c1 e6 06             shl    $0x6,%rsi
    11ba:       48 8d 04 37             lea    (%rdi,%rsi,1),%rax
    11be:       48 89 e5                mov    %rsp,%rbp
    11c1:       5d                      pop    %rbp
    11c2:       c3                      retq   

Now, maybe we should put this optimisation into the definition of nth_page?

> > +struct folio {
> > +	/* private: don't document the anon union */
> > +	union {
> > +		struct {
> > +	/* public: */
> > +			unsigned long flags;
> > +			struct list_head lru;
> > +			struct address_space *mapping;
> > +			pgoff_t index;
> > +			unsigned long private;
> > +			atomic_t _mapcount;
> > +			atomic_t _refcount;
> > +#ifdef CONFIG_MEMCG
> > +			unsigned long memcg_data;
> > +#endif
> 
> As Christoph, I'm not a fan of this :/

What would you prefer?
