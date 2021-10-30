Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4000440C05
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Oct 2021 00:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhJ3WJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Oct 2021 18:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhJ3WJO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Oct 2021 18:09:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92325C061570
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Oct 2021 15:06:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id r5so9194530pls.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Oct 2021 15:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tbB3d5zVgujTV0TOqakgeD/X/IPORCFGNolROeRM60Y=;
        b=NWuUiWRU7WCCwmDHJ5cbIUu2DzoJCWwI7yiU48FRgg+lFnwLVl6l9veLcbLYYPGnVF
         3OTRAKV+gfuZyp2C7ThkegcACxXyL7vGBbO0URBAiWsHaJJkRxoYIQHLNBThl+TFSDkR
         GJ40mVz3GmEh/hr5UIWiyQA0Fri5OF+YHm6/9EfIqi+gkhPGDsLddLSQXIf6UvF9lfoP
         QXi/r3wazhX1oZbnjr9kqZyGr66q8q1BUqYLTzTcP/VUtRoWCnjzhTHRH/sbeNdE3Z5k
         0Wq8WMPH575tzdQFeYMOl7ecWSxwHx7LB4/N43dmIMP99hpjr2wnf9aDVZyTKqcSys79
         an4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbB3d5zVgujTV0TOqakgeD/X/IPORCFGNolROeRM60Y=;
        b=O4mwNkmAmtrasHsWDoXbP5XRd7QNtwTVQcx+wcIHgZrvyI+nqNbbCBoDC+lj4z0KED
         q7vP87sN8ocb9pnUxXJb+8waScxFYy/Q+kjJG9rEoDlLPu8IQz8AmeawVzjoKr9noqmt
         50ePv30k9wJbEQc8IAwFIvNadxzG4GgmpUHeZUVwLNHq7v2Jy6M6yB5W6vNygxsjYCVa
         gGoD/3pGFLz697FmrWXnpoiZrOy5KcFRtzs3mJ8s01kNsIFeHBHdrZducderX0pgiMTB
         8deaNpMyaXir6Z3yMIfPeJDTNYaJqpBDoonNe25VV4oD/HQwF6xfFCx64NyTNJjtMsTM
         wceQ==
X-Gm-Message-State: AOAM530sDvusuooYcRiPdQVrTIgvFT1erEbrdhGTz8smV0VJAhlxn/zR
        oFL8mH2GMEpFrnKu7wBYj+6nOXSZp+87dKhfVADB/w==
X-Google-Smtp-Source: ABdhPJyABihg5QNhd5Tgz+ZcGqxgDaHSE5WkaOpDQtDL0Sy/j/tDpSxeDrQZxoNDeVD6qz4CWv65bsGQpUW8l0YBxVg=
X-Received: by 2002:a17:90a:62ca:: with SMTP id k10mr20162478pjs.38.1635631602830;
 Sat, 30 Oct 2021 15:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211028205854.830200-1-almasrymina@google.com>
 <2fede4d2-9d82-eac9-002b-9a7246b2c3f8@redhat.com> <CAHS8izMckg03uLB0vrTGv2g-_xmTh1LPRc2P8sfnmL-FK5A8hg@mail.gmail.com>
 <e02b1a75-58ab-2b8a-1e21-5199e3e3c5e9@redhat.com>
In-Reply-To: <e02b1a75-58ab-2b8a-1e21-5199e3e3c5e9@redhat.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sat, 30 Oct 2021 15:06:31 -0700
Message-ID: <CAHS8izOkvuZ2pEGZXaYb0mfwC3xwpvXSgc9S+u_R-0zLWjzznQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm: Add /proc/$PID/pageflags
To:     David Hildenbrand <david@redhat.com>
Cc:     Nathan Lewis <npl@google.com>, Yu Zhao <yuzhao@google.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 2:37 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 29.10.21 22:04, Mina Almasry wrote:
> > On Fri, Oct 29, 2021 at 12:11 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 28.10.21 22:58, Mina Almasry wrote:
> >>> From: Yu Zhao <yuzhao@google.com>
> >>>
> >>> This file lets a userspace process know the page flags of each of its virtual
> >>> pages.  It contains a 64-bit set of flags for each virtual page, containing
> >>> data identical to that emitted by /proc/kpageflags.  This allows the user-space
> >>> task can learn the kpageflags for the pages backing its address-space by
> >>> consulting one file, without needing to be root.
> >>>
> >>> Example use case is a performance sensitive user-space process querying the
> >>> hugepage backing of its own memory without the root access required to access
> >>> /proc/kpageflags, and without accessing /proc/self/smaps_rollup which can be
> >>> slow and needs to hold mmap_lock.
> >>
> >> Can you elaborate on
> >>
> >> a) The target use case. Are you primarily interested to see if a page
> >> given base page is head or tail?
> >>
> >
> > Not quite. Generally some userspace process (most notably our network
> > service) has a region of performance critical memory and would like to
> > know if this memory is backed by hugepages or not. It uses
> > /proc/self/pageflags to inspect the pageflags of the pages backing
> > this region, and counts how many ranges are backed by hugepages and
> > how many are not. Generally we export this data to metrics, and if the
> > hugepage backing drops or is insufficient we look into the issue
> > postmortem.
>
> Okay, so it's all about detecting if/where THPs are mapped. I assume
> knowing just the number of THPs getting used by that process is not
> sufficient for your use case? If you just need numbers, it might be
> better to let the kernel do the counting :)
>
> [...]
>

Not quite sufficient, no. The process may have lots of non performance
critical memory. The network service cares about specific memory
ranges and wants to know if those are backed by hugepages.


> >> Also, do you have a rough performance comparison?
> >>
> >
> > So from my tests with simple processes querying smaps/pageflags I
> > don't see any performance difference, but I suspect it's due to my
> > test cases not mapping much memory or regions.
> >
> > I've CC'd Nathan who works on our network service and has run into
> > performance issues with smaps. Nathan, do you have a rough performance
> > comparison? If so please do share.
> >
>
> That would be great, because we tend to not add interfaces if the
> information can already be obtained differently and there is no clear
> benefit. Performance comparisons can help.
>
> >>>
> >>> Similar to /proc/kpageflags, the flags printed out by the kernel for
> >>> each page are provided by stable_page_flags(), which exports flag bits
> >>> that are user visible and stable over time.
> >>
> >> It exports flags (documented for pageflags_read()) that are not
> >> applicable to processes, like OFFLINE. BUDDY, SLAB, PGTABLE ... and can
> >> never happen. Some of these kpageflags are not even page->flags, they
> >> include abstracted types we use for physical memory pages based on other
> >> struct page members (OFFLINE, BUDDY, MMAP, PGTABLE, ...). This feels wrong.
> >>
> >> Also, to me it feels like we are exposing too much internal information
> >> to the user, essentially making it ABI that user space processes will
> >> rely on.
> >>
> >
> > I'm honestly a bit surprised by this comment because AFAIU (sorry if
> > wrong) we are already exporting this information via /proc/kpageflags
> > and therefore it's already somewhat part of an ABI, and the
> > stable_page_flags() output already needs to be stable and backwards
> > compatible due to potential root users being affected by any
> > non-backwards compatible changes. I am yes extending access to this
> > information to non-root users.
>
> Sure, a (root) application could access these flags via /proc/kpageflags
> -- in my thinking usually for debugging purposes, like how I've been
> using it a couple of times.
>
> Because for something in process context it's barely usable: once you
> have the PFN via the pagemap for a virtual address and you would want to
> read the flags of that PFN via kpageflags, the PFN might already have
> changed for the virtual address and you'd be reading wrong data. It's racy.
>
> I might be wrong, maybe there are some system services making use of
> that information for some kind of optimizations. A quick google search
> didn't reveal anything, but maybe I just gave up too early :)
>
> Exposing this information to non-root users would most certainly let
> some random libraries use this information for real and depend on it,
> for whatever purpose. If that makes sense.
>

Ah, now I understand. Your concerns here make perfect sense. To be
honest I still wonder if stable_page_flags() are exposed to the
userspace 'enough' that they have to remain backwards compatible
anyway, but I can see that not being really true. Adding
/proc/pid/pageflags definitely sets them in stone.

> >
> >> Did you investigate
> >>
> >> a) Reducing the flags we expose to a bare minimum necessary for your use
> >> case (and actually applicable to mmaped pages).
> >>
> >
> > To be honest I haven't, but this is something that's certainly doable.
> > I'm not sure it's easier for processes to understand or the kernel to
> > maintain. My thinking:
> > 1. Processes parsing /proc/kpageflags can also easily parse
> > /proc/self/pageflags and re-use code/implementations between them.
> > 2. Userspace code can extract the flags they need and ignore the ones
> > they don't need or are not applicable.
> > 3. For kernel it's maybe easier to maintain 1 set of
> > stable_page_flags() and keep that list backwards compatible. To
> > address your comment I'd need to create a subset,
> > stable_ps_page_flags(), and both lists now need to be backwards
> > compatible.
>
> I'd love to hear other opinions, because maybe I'm just being paranoid. :)
>
> >
> > But I hear you, and if you feel strongly about this I'm more than
> > happy to oblige. Please confirm if this is something you would like to
> > see in V2.
> >
> >> b) Extending pagemap output instead.
> >>
> >
> > No I have not until you mentioned it, but even now AFAIU (and again
> > sorry if wrong, please correct) all the bits exposed by pagemap as
> > documented in pagemap.rst are in use, and it's a non-starter for me to
> > modify how pagemap works because it'd break backwards compatibility.
> > But if you see a way I'm happy to oblige :-)
> >
>
> Bit 58-60 are still free, no? Bit 57 was recently added for uffd-wp
> purposes I think.
>
> #define PM_SOFT_DIRTY           BIT_ULL(55)
> #define PM_MMAP_EXCLUSIVE       BIT_ULL(56)
> #define PM_UFFD_WP              BIT_ULL(57)
> #define PM_FILE                 BIT_ULL(61)
> #define PM_SWAP                 BIT_ULL(62)
> #define PM_PRESENT              BIT_ULL(63)
>
> PM_MMAP_EXCLUSIVE and PM_FILE already go into the direction of "what is
> mapped" IMHO. So just a thought if something in there (PM_HUGE? PM_THP?)
> ... could make sense.
>

Thanks! I _think_ that would work for us, I'll look into confirming.
To be honest I still wonder if eventually different folks will find
uses for other page flags and eventually we'll run out of pagemaps
bits, but I'll yield to whatever you think is best here.

> --
> Thanks,
>
> David / dhildenb
>
