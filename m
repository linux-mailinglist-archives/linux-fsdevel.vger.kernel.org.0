Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B66E1A576A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 01:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgDKXWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 19:22:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgDKXWE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kQkDW0nh6/SfP4OPM8VhrnzpbvEqadvFvedQUkcdAZw=; b=MwXAfGgw1DYwAIj42DDJRJxpi8
        lOeqwfBQzpC1GCKO/kqjSXId1O3AJyZk7Y/nf88jms+vOJlN1O7nC6M/pdX+dxi+/7M8FLPVZMm7p
        qAQbgsYA7fpbytNPN2ux44QglDhxGrjUFCfZ5sUgsjDBR8oE8Hm9uF/FmBz6kyu5YgCnlpO89jcUL
        naLX3uHkXsfIU/XXqwcue1vzkxpqh2Ec3+SvIIrJpH2MWQLQk66ayvCm+0UPGzM1fXTrCP7yWJI6Q
        bGp04EULVg5zXezCjDZcPtDyzi8ROk8i3Xzum6JLZ6pme6aZMSi5yuMB1JwTsgdu+jq4K6WfejwOr
        C/lJQNdQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNPRt-0005TR-7h; Sat, 11 Apr 2020 23:22:05 +0000
Date:   Sat, 11 Apr 2020 16:22:05 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Rename page_offset() to page_pos()
Message-ID: <20200411232205.GJ21484@bombadil.infradead.org>
References: <20200411203220.GG21484@bombadil.infradead.org>
 <CAHk-=wgCAGVwAVTuaoJu4bF99JEG66iN7_vzih=Z33GMmOTC_Q@mail.gmail.com>
 <20200411214818.GH21484@bombadil.infradead.org>
 <CAHk-=wj71d1ExE-_W0hy87r3d=2URMwx0f6oh+bvdfve6G71ew@mail.gmail.com>
 <20200411220603.GI21484@bombadil.infradead.org>
 <CAHk-=whFfcUEMq5C9Xy=c=sJrT-+3uOE2bAwEQo9MUdbhP2X3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whFfcUEMq5C9Xy=c=sJrT-+3uOE2bAwEQo9MUdbhP2X3Q@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 11, 2020 at 03:09:35PM -0700, Linus Torvalds wrote:
> On Sat, Apr 11, 2020 at 3:06 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > But we _have_ an offset_in_page() and it doesn't take a struct page
> > argument.
> 
> .. it doesn't take a struct page argument because a struct page always
> has one compile-time fixed size.
> 
> The only reason you seem to want to get the new interface is because
> you want to change that fact.
> 
> So yes, you'd have to change the _existing_ offset_in_page() to take
> that extra "which page" argument.
> 
> That's not confusing.

Unfortunately there isn't always a struct page around.  For example:

int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
                struct list_head *uf, bool downgrade)
{
        unsigned long end;
        struct vm_area_struct *vma, *prev, *last;

        if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
                return -EINVAL;

where we don't care _which_ page, we just want to know the offset relative
to the architecturally defined page size.  In this specific case, it
should probably be changed to is_page_aligned(start).

There are trickier ones like on powerpc:

unsigned long vmalloc_to_phys(void *va)
{
        unsigned long pfn = vmalloc_to_pfn(va);

        BUG_ON(!pfn);
        return __pa(pfn_to_kaddr(pfn)) + offset_in_page(va);
}

where there actually _is_ a struct page, but it will need to be found.
Maybe we can pass in NULL to indicate to use the base page size.  Or
rename all current callers to offset_in_base_page() before adding a
struct page pointer to offset_in_page().  Tedious, but doable.
