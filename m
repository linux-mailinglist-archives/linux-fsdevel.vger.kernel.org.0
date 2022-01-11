Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A46948A8E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 08:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348714AbiAKHv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 02:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbiAKHv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:51:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F80DC06173F;
        Mon, 10 Jan 2022 23:51:57 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so3593068pjf.3;
        Mon, 10 Jan 2022 23:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ovARpfXZ3E1QyLpeh1mOwwW3EMNPu45OM4ENk9y2JM0=;
        b=CiG96KAmRBAJfo3O1Y/aYyQxMF9hidKwCp3KFyQ0uFgGL0/v7hBZ4X4AR0GZnJFazO
         aVtNfQiWNCpP5n4pBCAN5pkfUGq/A/exhy4HVDOg+MDBkPrPmXk6jgNeLggbHK2mw/ZH
         3BTzyGhwLo5xosN4EiRlcQfJ/IlanQdFwCpmzjEPKfevSeXR2lvRDCAMOdyrSsrYk1Kb
         YrN49O88GUT+cc63DIMfDVdHAj5v8mmVBGUsW0aYRu7VajGmhtWbOi2NlKGFG9y42AHa
         RIQItk4XBXYakk6COUHUsT5cSFeLGjR+SB7zzOCSx6SkeQWtujGm0rM5aIreskwAe9Kz
         u8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ovARpfXZ3E1QyLpeh1mOwwW3EMNPu45OM4ENk9y2JM0=;
        b=zPXmBNLTTtv4gN3O8+czDJwpUfsvbSJoLvEa/1njJfagqYxwH8Sa8EA/Awm7vqCio9
         JMBKEKZKuE6jl4DSsCtL5w6+wIFQDch/1VEE6sAXqPwca/0EJXsTxP5t6c1s2P+E+edn
         LLMq832wWn3BmzIN4pdrtkS9Z6g6qVv7b24COQkxVV82mboZOv2e2E9j+HCeqrlymhjX
         TdPDLRmCBI3IoWK/mXmGqiz0xOFyIhQcj7z1hmQMu+GP0c6BMmUHnken/sXNm9ucZH9k
         pYQNt/kgoUmjO7vRYKvDG602ns2Ef7skP0ZWOi2xp5MQFAIoqMu2Bj0fhIvzfIJv49m2
         BhUw==
X-Gm-Message-State: AOAM533mFk9QjkdCBl0+XJ2eshFgdKIQSH5vj1CTwT0NJ9YF3Xc0jQFr
        TsqMbh/9xAB/Oiv2Mw2O7pL+RkrNf/GiWT02s8Q=
X-Google-Smtp-Source: ABdhPJx5eq+Ru5g2oF06+KyVKVVM8d8Ydy0ELjjaf9c2hrlbzFb6ug2DAtfN/ZlAS/LzY843RaCllim7EQh5vMZ/P/k=
X-Received: by 2002:a63:ae45:: with SMTP id e5mr3050350pgp.476.1641887517010;
 Mon, 10 Jan 2022 23:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20220110141957.259022-1-sxwjean@me.com> <20220110141957.259022-3-sxwjean@me.com>
 <da578a75-5cee-5c16-b63c-be6ba2b9ba5d@redhat.com>
In-Reply-To: <da578a75-5cee-5c16-b63c-be6ba2b9ba5d@redhat.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Tue, 11 Jan 2022 15:51:30 +0800
Message-ID: <CAEVVKH97F7zO7uaz=Qxk1w9+s4BiYMfXAsvBt1Qovxx7+Odrqg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] proc: Add getting pages info of ZONE_DEVICE support
To:     David Hildenbrand <david@redhat.com>
Cc:     Xiongwei Song <sxwjean@me.com>, akpm@linux-foundation.org,
        mhocko@suse.com, dan.j.williams@intel.com, osalvador@suse.de,
        naoya.horiguchi@nec.com, thunder.leizhen@huawei.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Mon, Jan 10, 2022 at 10:34 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 10.01.22 15:19, sxwjean@me.com wrote:
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > When requesting pages info by /proc/kpage*, the pages in ZONE_DEVICE were
> > missed.
> >
>
> The "missed" part makes it sound like this was done by accident. On the
> contrary, for now we decided to not expose these pages that way, for
> example, because determining if the memmap was already properly
> initialized isn't quite easy.
>

Understood. Thank you for the explanation.

>
> > The pfn_to_devmap_page() function can help to get page that belongs to
> > ZONE_DEVICE.
>
> What's the main motivation for this?

There is no special case. My customer wanted to check page flags in system wide.
I tried to find the way and found there is no capability for pages of
ZONE_DEVICE,
so tried to make the patch and see if upstream needs it.

>
> >
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > ---
> >  fs/proc/page.c | 35 ++++++++++++++++++++++-------------
> >  1 file changed, 22 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/proc/page.c b/fs/proc/page.c
> > index 9f1077d94cde..2cdc2b315ff8 100644
> > --- a/fs/proc/page.c
> > +++ b/fs/proc/page.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/page_idle.h>
> >  #include <linux/kernel-page-flags.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/memremap.h>
> >  #include "internal.h"
> >
> >  #define KPMSIZE sizeof(u64)
> > @@ -46,6 +47,7 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
> >  {
> >       const unsigned long max_dump_pfn = get_max_dump_pfn();
> >       u64 __user *out = (u64 __user *)buf;
> > +     struct dev_pagemap *pgmap = NULL;
> >       struct page *ppage;
> >       unsigned long src = *ppos;
> >       unsigned long pfn;
> > @@ -60,17 +62,18 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
> >       count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
> >
> >       while (count > 0) {
> > -             /*
> > -              * TODO: ZONE_DEVICE support requires to identify
> > -              * memmaps that were actually initialized.
> > -              */
> >               ppage = pfn_to_online_page(pfn);
> > +             if (!ppage)
> > +                     ppage = pfn_to_devmap_page(pfn, &pgmap);
> >
> >               if (!ppage || PageSlab(ppage) || page_has_type(ppage))
> >                       pcount = 0;
> >               else
> >                       pcount = page_mapcount(ppage);
> >
> > +             if (pgmap)
> > +                     put_dev_pagemap(pgmap);
>
> Ehm, don't you have to reset pgmap back to NULL? Otherwise during the
> next iteration, you'll see pgmap != NULL again.

Oops. I totally agree. Will do this in the next version.

>
> > +
> >               if (put_user(pcount, out)) {
> >                       ret = -EFAULT;
> >                       break;
> > @@ -229,10 +232,12 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
> >  {
> >       const unsigned long max_dump_pfn = get_max_dump_pfn();
> >       u64 __user *out = (u64 __user *)buf;
> > +     struct dev_pagemap *pgmap = NULL;
> >       struct page *ppage;
> >       unsigned long src = *ppos;
> >       unsigned long pfn;
> >       ssize_t ret = 0;
> > +     u64 flags;
> >
> >       pfn = src / KPMSIZE;
> >       if (src & KPMMASK || count & KPMMASK)
> > @@ -242,13 +247,15 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
> >       count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
> >
> >       while (count > 0) {
> > -             /*
> > -              * TODO: ZONE_DEVICE support requires to identify
> > -              * memmaps that were actually initialized.
> > -              */
> >               ppage = pfn_to_online_page(pfn);
> > +             if (!ppage)
> > +                     ppage = pfn_to_devmap_page(pfn, &pgmap);
> > +
> > +             flags = stable_page_flags(ppage);
> > +             if (pgmap)
> > +                     put_dev_pagemap(pgmap);
>
> Similar comment.

Okay.

>
> >
> > -             if (put_user(stable_page_flags(ppage), out)) {
> > +             if (put_user(flags, out)) {
> >                       ret = -EFAULT;
> >                       break;
> >               }
> > @@ -277,6 +284,7 @@ static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
> >  {
> >       const unsigned long max_dump_pfn = get_max_dump_pfn();
> >       u64 __user *out = (u64 __user *)buf;
> > +     struct dev_pagemap *pgmap = NULL;
> >       struct page *ppage;
> >       unsigned long src = *ppos;
> >       unsigned long pfn;
> > @@ -291,17 +299,18 @@ static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
> >       count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
> >
> >       while (count > 0) {
> > -             /*
> > -              * TODO: ZONE_DEVICE support requires to identify
> > -              * memmaps that were actually initialized.
> > -              */
> >               ppage = pfn_to_online_page(pfn);
> > +             if (!ppage)
> > +                     ppage = pfn_to_devmap_page(pfn, &pgmap);
> >
> >               if (ppage)
> >                       ino = page_cgroup_ino(ppage);
> >               else
> >                       ino = 0;
> >
> > +             if (pgmap)
> > +                     put_dev_pagemap(pgmap);
>
> Similar comment.

Okay.

>
>
> IIRC, we might still stumble over uninitialized devmap memmaps that
> essentially contain garbage -- I recall it might be the device metadata.
> I wonder if we at least have to check pgmap_pfn_valid().

Oh, ok.  But how about putting pgmap_pfn_valid into pfn_to_devmap_page()?

Appreciated your review.

Regards,
Xiongwei
