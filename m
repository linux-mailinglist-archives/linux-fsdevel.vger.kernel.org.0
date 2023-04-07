Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B966DB4F0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 22:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjDGUMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 16:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjDGUMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:12:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806507ABF
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=nSXvMunQZ6w/r4GXG20xJdtyoIFgTw/AYd8vmxIJz6E=; b=KsHu1oFLu0IsbFLsbvUEvuao7v
        u88SJDIUrYCEr7alRSnZhp8cXePhpv7UeZM6veZR/XEN0qM/CT21afHCZwgriQxy2dqaa+/RvoorJ
        TtzHbzQj6tn22sqTOKhq/d5GQ7JiSpSj0XPyWWWEFBKeT8anfmGxVQNhChKcD7PWmc28F0JpGfI1u
        BKm6xr1Zm1RcJUEaV8XpnX2CyPEjbz7gU3BiTeRYG5LyvDyek7mYJ51C/DBwif0YU0j4KuFxDw0Dh
        Pc4JKdwny7rxKgHSr5VHBcV64MM2jYI0PVWY7LCAMNHgMtCPplA/0v8pg5xEc9YCYXcywOttaL0eB
        lZDnBHaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pksRu-001AWj-OO; Fri, 07 Apr 2023 20:12:42 +0000
Date:   Fri, 7 Apr 2023 21:12:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: Re: [PATCH 1/6] mm: Allow per-VMA locks on file-backed VMAs
Message-ID: <ZDB5OsBc3R7o489l@casper.infradead.org>
References: <20230404135850.3673404-1-willy@infradead.org>
 <20230404135850.3673404-2-willy@infradead.org>
 <CAJuCfpGPYNerqu6EjRNX2ov4uaFOawmXf1bS_xYPX5b6BAnaWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGPYNerqu6EjRNX2ov4uaFOawmXf1bS_xYPX5b6BAnaWg@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 07, 2023 at 10:54:00AM -0700, Suren Baghdasaryan wrote:
> On Tue, Apr 4, 2023 at 6:59 AM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> >
> > The fault path will immediately fail in handle_mm_fault(), so this
> > is the minimal step which allows the per-VMA lock to be taken on
> > file-backed VMAs.  There may be a small performance reduction as a
> > little unnecessary work will be done on each page fault.  See later
> > patches for the improvement.
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  mm/memory.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index fdaec7772fff..f726f85f0081 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5223,6 +5223,9 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
> >                                             flags & FAULT_FLAG_REMOTE))
> >                 return VM_FAULT_SIGSEGV;
> >
> > +       if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma))
> > +               return VM_FAULT_RETRY;
> > +
> 
> There are count_vm_event(PGFAULT) and count_memcg_event_mm(vma->vm_mm,
> PGFAULT) earlier in this function. Returning here and retrying I think
> will double-count this page fault. Returning before this accounting
> should fix this issue.

You're right, but this will be an issue with later patches in the series
anyway as we move the check further and further down the call-chain.
For that matter, it's an issue in do_swap_page() right now, isn't it?
I suppose we don't care too much because it's the rare case where we go
into do_swap_page() and so the stats are "correct enough".
