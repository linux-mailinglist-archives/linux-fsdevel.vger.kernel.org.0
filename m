Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A719B43FDD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 16:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhJ2OIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 10:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhJ2OIP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:08:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A811C061570;
        Fri, 29 Oct 2021 07:05:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r4so38459479edi.5;
        Fri, 29 Oct 2021 07:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvaOZ+L7Q/hsGmgFIj1Fd0g2K7g1gQBbyCtdTWJts7g=;
        b=k3ESfV5YtenEJ/NOkxsM84lYLQWIN00Dm9aqiA9jgI4swsqfLAEkI/ab/eKHSqMRQr
         Zj6jmYK3kTsyMGKTF46IYBnC65esbPtG9eEg6U7YAKzp5N3GvpBL7m57hAAQ2hClX4oL
         0XtFIryldx8HXL7f4vipSifahc6nJv6O/REYNJB9+04h4Yp2kRwNK/u3tDU+ZzV/FjrO
         2PaoSXeQpwQ3EhZKPi4HSaQWhasznxo33DgG2xTeSJof53lpP4JqDCPOZGCNGPLVBvkw
         RRvkCxr1Gj1KxPALv6tPGhGscizSde7P2504Tp9EpMbS0ki3n59anIoFZcvNSHrfmJqM
         yW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvaOZ+L7Q/hsGmgFIj1Fd0g2K7g1gQBbyCtdTWJts7g=;
        b=ncqDEzdp/RET4q9jvA0bH71Q8nRJgreqnJ8Jz223h4/Y/mEBEB5mLCWjnv/jz5nnKe
         XHv9CxQ6D1v6ktNVxGK7DbJNbhmxIMD+7yOUeLFO6EaCZB8mqRLpn+wuR8Ud7oshwRgV
         j3Yl4HjEN9GEItKybCNJ1kXYd5433KxBiRT6M74w0J+/6rPX12j13E+eXvanuX+s3saQ
         J9vv8xF9KQMCqLJDMsPSwJK1K1Iy8t+6amJWyd4W3EVP80kflAX5JJWYFkwfb/r+y3g0
         2Flu02NOGL+zIeY7U3w/aPw9qluiRAyOg/9BkhRCI7po5bbsEVxcbt5JSmzMXxph6i5g
         mR8Q==
X-Gm-Message-State: AOAM5337tUpx4PMyjjDYR+xWAq9C1cxA4cgoqlnc/XOz8MWLjdQlGO/u
        bVzqteo7FR8NiTgXXQs/dh4Mlgwn5MgQcZVL+EI=
X-Google-Smtp-Source: ABdhPJwtVXLFoFhFJUkbD073vlIqpwXOQ4Dd3cpc71Nl6L3ircqX5Unm2vzoFJ+Zbc907xuOR/EA9TYdqu94eALaABk=
X-Received: by 2002:a17:906:58d3:: with SMTP id e19mr13384663ejs.350.1635516343380;
 Fri, 29 Oct 2021 07:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211025150223.13621-1-mhocko@kernel.org> <20211025150223.13621-3-mhocko@kernel.org>
 <CA+KHdyVqOuKny7bT+CtrCk8BrnARYz744Ze6cKMuy2BXo5e7jw@mail.gmail.com>
 <YXgsxF/NRlHjH+Ng@dhcp22.suse.cz> <20211026193315.GA1860@pc638.lan>
 <20211027175550.GA1776@pc638.lan> <YXupZjQgLAi6ClRi@dhcp22.suse.cz>
In-Reply-To: <YXupZjQgLAi6ClRi@dhcp22.suse.cz>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Fri, 29 Oct 2021 16:05:32 +0200
Message-ID: <CA+KHdyX_0B-hM8m0eZBetcdBC9X3ddnA4dMyZvA2_xCjJJeJCA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/vmalloc: add support for __GFP_NOFAIL
To:     Michal Hocko <mhocko@suse.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index d77830ff604c..f4b7927e217e 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2889,8 +2889,14 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >       unsigned long array_size;
> >       unsigned int nr_small_pages = size >> PAGE_SHIFT;
> >       unsigned int page_order;
> > +     unsigned long flags;
> > +     int ret;
> >
> >       array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
> > +
> > +     /*
> > +      * This is i do not understand why we do not want to see warning messages.
> > +      */
> >       gfp_mask |= __GFP_NOWARN;
>
> I suspect this is becauser vmalloc wants to have its own failure
> reporting.
>
But as i see it is broken. All three warn_alloc() reports in the
__vmalloc_area_node()
are useless because the __GFP_NOWARN is added on top of gfp_mask:

void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
{
        struct va_format vaf;
        va_list args;
        static DEFINE_RATELIMIT_STATE(nopage_rs, 10*HZ, 1);

        if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs))
                return;
...

everything with the __GFP_NOWARN is just reverted.

> [...]
> > @@ -3010,16 +3037,22 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
> >       area = __get_vm_area_node(real_size, align, shift, VM_ALLOC |
> >                                 VM_UNINITIALIZED | vm_flags, start, end, node,
> >                                 gfp_mask, caller);
> > -     if (!area) {
> > -             warn_alloc(gfp_mask, NULL,
> > -                     "vmalloc error: size %lu, vm_struct allocation failed",
> > -                     real_size);
> > -             goto fail;
> > -     }
> > +     if (area)
> > +             addr = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
> > +
> > +     if (!area || !addr) {
> > +             if (gfp_mask & __GFP_NOFAIL) {
> > +                     schedule_timeout_uninterruptible(1);
> > +                     goto again;
> > +             }
> > +
> > +             if (!area)
> > +                     warn_alloc(gfp_mask, NULL,
> > +                             "vmalloc error: size %lu, vm_struct allocation failed",
> > +                             real_size);
> >
> > -     addr = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
> > -     if (!addr)
> >               goto fail;
> > +     }
> >
> >       /*
> >        * In this function, newly allocated vm_struct has VM_UNINITIALIZED
> > <snip>
>
> OK, this looks easier from the code reading but isn't it quite wasteful
> to throw all the pages backing the area (all of them allocated as
> __GFP_NOFAIL) just to then fail to allocate few page tables pages and
> drop all of that on the floor (this will happen in __vunmap AFAICS).
>
> I mean I do not care all that strongly but it seems to me that more
> changes would need to be done here and optimizations can be done on top.
>
> Is this something you feel strongly about?
>
Will try to provide some motivations :)

It depends on how to look at it. My view is as follows a more simple code
is preferred. It is not considered as a hot path and it is rather a corner
case to me. I think "unwinding" has some advantage. At least one motivation
is to release a memory(on failure) before a delay that will prevent holding
of extra memory in case of __GFP_NOFAIL infinitelly does not succeed, i.e.
if a process stuck due to __GFP_NOFAIL it does not "hold" an extra memory
forever.

-- 
Uladzislau Rezki
