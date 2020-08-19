Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339362494A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 07:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHSFuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 01:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSFuM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 01:50:12 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071BEC061389;
        Tue, 18 Aug 2020 22:50:12 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id t15so23644696iob.3;
        Tue, 18 Aug 2020 22:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FWORnw1azmbSbvzLnh/tIRdOU+3S3lvKRvzW43g3p2w=;
        b=JMnBeDhbIEpSSRZGvurhYc+pGaAGIrbMaMl1813GA6QctAE2ylv5occLjJTYAx5ubq
         maARt6EJlG5pfR3dW0y4IjDxcqqS8MD333FA8+2CD0ZZLthlNgWf03Ypih7DeXB62ffv
         EkSzzf3R8Ku47raX3Ry0VEBCb6bctlJucbBnidY8RIaWCRP3iSFbZvaORPWQVCsHqlys
         ry1en3ZTKW83VLg1NF3jAX9RXmh9qk+cwz4KsIQ6t6cqbg8RNpHpABb6zD8/Undn3SX3
         p+d2qvgFSdUhymwW/G0Txsr/A0bSMJ/nCRVkq61VsWVizKwuVcdslMcX6/eGzeBHPIQY
         dKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWORnw1azmbSbvzLnh/tIRdOU+3S3lvKRvzW43g3p2w=;
        b=T6+H150tuspcqH3cUDqJqVTfE2EqDoqXBs/1/hUUE32NGJrbE5jsayaVFZZdh4Jr0l
         3KBOeJjVrs669sHOPElYrA0DD1fBLDuTL5njHHlAg2y5kIpb47xczAFqbBc/PCR5aaqm
         inknNklFuPcxlBQ7OICUNBtAJoZ+YDEXnWKys53i2j92EREWOyB48c3yAQYz+IKNpAGa
         bkrYLQV4ioNgyZ6jIieB0N3vaLmZSfA0j7DAVpD73gpOsCC3bg3Uhu/Prcrv4ymlkiLg
         32eYmal0hqSA09E3UxqjfuKuKc9QCJmkqLaXxEiPCRWivEKU4kYlm5IFTd1uRp2n/52W
         glTw==
X-Gm-Message-State: AOAM5332Q8fQp7nDRyAh68qSvOQs00+0AkX0Q/LN9Slak4wFFs9DMoXN
        M3Rr8WT/jtPAvao83ovsusGYhcgONJVtSoN7cnU=
X-Google-Smtp-Source: ABdhPJxs/FnoumZ+flV4yn0aL3VPpcffDP4FcVyZBIaaRWA+RRu5MB8bmikf88LxvrChlUaek0ceQ1JYbzNQvvb8SA4=
X-Received: by 2002:a05:6638:22d0:: with SMTP id j16mr22572725jat.97.1597816211407;
 Tue, 18 Aug 2020 22:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200819022425.25188-1-laoar.shao@gmail.com> <20200819022425.25188-2-laoar.shao@gmail.com>
 <20200819030852.GX17456@casper.infradead.org>
In-Reply-To: <20200819030852.GX17456@casper.infradead.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 19 Aug 2020 13:49:35 +0800
Message-ID: <CALOAHbBoJbKJ82iPzBumqSm81fUmrJkP_+wPiA+A5dJiD24cdA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mm: Add become_kswapd and restore_kswapd
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:08 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Aug 19, 2020 at 10:24:24AM +0800, Yafang Shao wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >
> > Since XFS needs to pretend to be kswapd in some of its worker threads,
> > create methods to save & restore kswapd state.  Don't bother restoring
> > kswapd state in kswapd -- the only time we reach this code is when we're
> > exiting and the task_struct is about to be destroyed anyway.
> >
> > Cc: Dave Chinner <david@fromorbit.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Darrick J. Wong <darrick.wong@oracle.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> See https://lore.kernel.org/linux-mm/20200625123143.GK1320@dhcp22.suse.cz/
>
> Please add:
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>

Sure.
I missed that discussion.

> > +/*
> > + * Tell the memory management that we're a "memory allocator",
> > + * and that if we need more memory we should get access to it
> > + * regardless (see "__alloc_pages()"). "kswapd" should
> > + * never get caught in the normal page freeing logic.
> > + *
> > + * (Kswapd normally doesn't need memory anyway, but sometimes
> > + * you need a small amount of memory in order to be able to
> > + * page out something else, and this flag essentially protects
> > + * us from recursively trying to free more memory as we're
> > + * trying to free the first piece of memory in the first place).
> > + */
>
> And let's change that comment as suggested by Michal (slightly edited
> by me):
>
> /*
>  * Tell the memory management code that this thread is working on behalf
>  * of background memory reclaim (like kswapd).  That means that it will
>  * get access to memory reserves should it need to allocate memory in
>  * order to make forward progress.  With this great power comes great
>  * responsibility to not exhaust those reserves.
>  */
>

I will update it with that comment.

> > +#define KSWAPD_PF_FLAGS              (PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD)
> > +
> > +static inline unsigned long become_kswapd(void)
> > +{
> > +     unsigned long flags = current->flags & KSWAPD_PF_FLAGS;
> > +
> > +     current->flags |= KSWAPD_PF_FLAGS;
> > +
> > +     return flags;
> > +}
> > +
> > +static inline void restore_kswapd(unsigned long flags)
> > +{
> > +     current->flags &= ~(flags ^ KSWAPD_PF_FLAGS);
> > +}
> > +
> >  #ifdef CONFIG_MEMCG
> >  /**
> >   * memalloc_use_memcg - Starts the remote memcg charging scope.
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 99e1796eb833..3a2615bfde35 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3859,19 +3859,7 @@ static int kswapd(void *p)
> >       if (!cpumask_empty(cpumask))
> >               set_cpus_allowed_ptr(tsk, cpumask);
> >
> > -     /*
> > -      * Tell the memory management that we're a "memory allocator",
> > -      * and that if we need more memory we should get access to it
> > -      * regardless (see "__alloc_pages()"). "kswapd" should
> > -      * never get caught in the normal page freeing logic.
> > -      *
> > -      * (Kswapd normally doesn't need memory anyway, but sometimes
> > -      * you need a small amount of memory in order to be able to
> > -      * page out something else, and this flag essentially protects
> > -      * us from recursively trying to free more memory as we're
> > -      * trying to free the first piece of memory in the first place).
> > -      */
> > -     tsk->flags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
> > +     become_kswapd();
> >       set_freezable();
> >
> >       WRITE_ONCE(pgdat->kswapd_order, 0);
> > @@ -3921,8 +3909,6 @@ static int kswapd(void *p)
> >                       goto kswapd_try_sleep;
> >       }
> >
> > -     tsk->flags &= ~(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD);
> > -
> >       return 0;
> >  }
> >
> > --
> > 2.18.1
> >



-- 
Thanks
Yafang
