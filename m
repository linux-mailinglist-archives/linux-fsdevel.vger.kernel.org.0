Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677D76F4DCB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 01:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjEBXlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 19:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEBXlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 19:41:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E6D3591;
        Tue,  2 May 2023 16:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ixUAA5uNhzAoOQPplItQehmJAKqUj/F6wVFG7dDKyGE=; b=NN/kZVDqglULqT5zSsS1VhodAV
        aKhTZx9jkdKv7e9TJYl21DqMmeyd0Nr8RDdfm4IESQLh4/rFC4WQCMMHxR51/BJepYp9mbu93G65K
        gLlUU3nlqrvK8r6N9D4SJ0SGp/2wCzC29UAFmaOrli7gsefN3Wlw3XiBaF2/0r7AOHaF0YGMGjKje
        lbV6KW9MkdCwLXKxd1zkPT9DxPqMjjHHCcxH4vGjUG9hhW61rSGngnjW5NMlAxzLs82bMpzbwjy23
        2D7p8emkLqCgtj7bsJbJj7RovfeP8mr0qB6SbhcmOwSOpLSV1z2AGupvV0gjPRVIT7K1e00Dx4xeY
        KJ9r20gA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ptzbd-008rny-Jj; Tue, 02 May 2023 23:40:25 +0000
Date:   Wed, 3 May 2023 00:40:25 +0100
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
Message-ID: <ZFGfaSA7buH0yBv7@casper.infradead.org>
References: <20230501175025.36233-1-surenb@google.com>
 <ZFBvOh8r5WbTVyA8@casper.infradead.org>
 <CAJuCfpHfAFx9rjv0gHK77LbP-8gd-kFnWw=aqfQTP6pH=zvMNg@mail.gmail.com>
 <ZFCB+G9KSNE+J9cZ@casper.infradead.org>
 <CAJuCfpES=G8i99yYXWoeJq9+JVUjX5Bkq_5VNVTVX7QT+Wkfxg@mail.gmail.com>
 <ZFEmN6G7WRy59Mum@casper.infradead.org>
 <CAJuCfpFs+Rgpu8v+ddHFwtOx33W5k1sKDdXHM2ej1Upyo_9y4g@mail.gmail.com>
 <ZFGPLXIis6tl1QWX@casper.infradead.org>
 <CAJuCfpGgc_bCEAE5LrhYPk=qXMU=owgiABTO9ZNqaBx-xfrOuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGgc_bCEAE5LrhYPk=qXMU=owgiABTO9ZNqaBx-xfrOuQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 02, 2023 at 04:04:59PM -0700, Suren Baghdasaryan wrote:
> On Tue, May 2, 2023 at 3:31 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, May 02, 2023 at 09:36:03AM -0700, Suren Baghdasaryan wrote:
> > > On Tue, May 2, 2023 at 8:03 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Mon, May 01, 2023 at 10:04:56PM -0700, Suren Baghdasaryan wrote:
> > > > > On Mon, May 1, 2023 at 8:22 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > >
> > > > > > On Mon, May 01, 2023 at 07:30:13PM -0700, Suren Baghdasaryan wrote:
> > > > > > > On Mon, May 1, 2023 at 7:02 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, May 01, 2023 at 10:50:23AM -0700, Suren Baghdasaryan wrote:
> > > > > > > > > +++ b/mm/memory.c
> > > > > > > > > @@ -3711,11 +3711,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > > > > > > > >       if (!pte_unmap_same(vmf))
> > > > > > > > >               goto out;
> > > > > > > > >
> > > > > > > > > -     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > > > > > > > > -             ret = VM_FAULT_RETRY;
> > > > > > > > > -             goto out;
> > > > > > > > > -     }
> > > > > > > > > -
> > > > > > > > >       entry = pte_to_swp_entry(vmf->orig_pte);
> > > > > > > > >       if (unlikely(non_swap_entry(entry))) {
> > > > > > > > >               if (is_migration_entry(entry)) {
> > > > > > > >
> > > > > > > > You're missing the necessary fallback in the (!folio) case.
> > > > > > > > swap_readpage() is synchronous and will sleep.
> > > > > > >
> > > > > > > True, but is it unsafe to do that under VMA lock and has to be done
> > > > > > > under mmap_lock?
> > > > > >
> > > > > > ... you were the one arguing that we didn't want to wait for I/O with
> > > > > > the VMA lock held?
> > > > >
> > > > > Well, that discussion was about waiting in folio_lock_or_retry() with
> > > > > the lock being held. I argued against it because currently we drop
> > > > > mmap_lock lock before waiting, so if we don't drop VMA lock we would
> > > > > be changing the current behavior which might introduce new
> > > > > regressions. In the case of swap_readpage and swapin_readahead we
> > > > > already wait with mmap_lock held, so waiting with VMA lock held does
> > > > > not introduce new problems (unless there is a need to hold mmap_lock).
> > > > >
> > > > > That said, you are absolutely correct that this situation can be
> > > > > improved by dropping the lock in these cases too. I just didn't want
> > > > > to attack everything at once. I believe after we agree on the approach
> > > > > implemented in https://lore.kernel.org/all/20230501175025.36233-3-surenb@google.com
> > > > > for dropping the VMA lock before waiting, these cases can be added
> > > > > easier. Does that make sense?
> > > >
> > > > OK, I looked at this path some more, and I think we're fine.  This
> > > > patch is only called for SWP_SYNCHRONOUS_IO which is only set for
> > > > QUEUE_FLAG_SYNCHRONOUS devices, which are brd, zram and nvdimms
> > > > (both btt and pmem).  So the answer is that we don't sleep in this
> > > > path, and there's no need to drop the lock.
> > >
> > > Yes but swapin_readahead does sleep, so I'll have to handle that case
> > > too after this.
> >
> > Sleeping is OK, we do that in pXd_alloc()!  Do we block on I/O anywhere
> > in swapin_readahead()?  It all looks like async I/O to me.
> 
> Hmm. I thought that we have synchronous I/O in the following paths:
>     swapin_readahead()->swap_cluster_readahead()->swap_readpage()
>     swapin_readahead()->swap_vma_readahead()->swap_readpage()
> but just noticed that in both cases swap_readpage() is called with the
> synchronous parameter being false. So you are probably right here...
> Does that mean swapin_readahead() might return a page which does not
> have its content swapped-in yet?

That's my understanding.  In that case it's !uptodate and still locked.
The folio_lock_or_retry() will wait for the read to complete unless
we've told it we'd rather retry.
