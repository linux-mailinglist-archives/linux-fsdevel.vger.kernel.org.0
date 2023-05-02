Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242CD6F3C58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 05:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjEBDXR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 23:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjEBDXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 23:23:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656DA30FB;
        Mon,  1 May 2023 20:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=nXmf0Oq3hf/xcZYM/3kRmIN8D01IMk38tYjoW66T3NY=; b=GzRXVt0QN1kSn5nmjZq6AFgAAJ
        Pui33jCvlrbmp7hG351ObI6AbFlVgohdWAIeNp7x7F4CTECjTisr78jIPJGGLx6nUJfg4wbde/3eh
        kQET8VP233fNOd5CZMpq/WDxzrH0Y/CErIvzC5gQCflnseANAiBWyDI1YLtycN7Qdlb68o13+ionH
        hfw1GqRsSjt84fb7crwkNpLcAoIREVB/GSIWISdvddcQYptG2xHdjCr0m+YEBC8bG/NEkykmXlKuG
        yIVMNL5kULJoFDRQ6g/xohHCQG5HkjZRFhQbR6VT6xJ/hUUQL/0IK9xkkCWdWorsEeRGq+foXdeTN
        aSHi96ZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ptgb2-007wdp-Md; Tue, 02 May 2023 03:22:32 +0000
Date:   Tue, 2 May 2023 04:22:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/3] mm: handle swap page faults under VMA lock if page
 is uncontended
Message-ID: <ZFCB+G9KSNE+J9cZ@casper.infradead.org>
References: <20230501175025.36233-1-surenb@google.com>
 <ZFBvOh8r5WbTVyA8@casper.infradead.org>
 <CAJuCfpHfAFx9rjv0gHK77LbP-8gd-kFnWw=aqfQTP6pH=zvMNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHfAFx9rjv0gHK77LbP-8gd-kFnWw=aqfQTP6pH=zvMNg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 01, 2023 at 07:30:13PM -0700, Suren Baghdasaryan wrote:
> On Mon, May 1, 2023 at 7:02 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, May 01, 2023 at 10:50:23AM -0700, Suren Baghdasaryan wrote:
> > > +++ b/mm/memory.c
> > > @@ -3711,11 +3711,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >       if (!pte_unmap_same(vmf))
> > >               goto out;
> > >
> > > -     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > > -             ret = VM_FAULT_RETRY;
> > > -             goto out;
> > > -     }
> > > -
> > >       entry = pte_to_swp_entry(vmf->orig_pte);
> > >       if (unlikely(non_swap_entry(entry))) {
> > >               if (is_migration_entry(entry)) {
> >
> > You're missing the necessary fallback in the (!folio) case.
> > swap_readpage() is synchronous and will sleep.
> 
> True, but is it unsafe to do that under VMA lock and has to be done
> under mmap_lock?

... you were the one arguing that we didn't want to wait for I/O with
the VMA lock held?
