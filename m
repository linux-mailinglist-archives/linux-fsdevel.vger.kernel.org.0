Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB474403C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 22:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhJ2UHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 16:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhJ2UHE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 16:07:04 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3F7C0613F5
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 13:04:35 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id n23so212906pgh.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 13:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPlRuudRvswXk7E3B3ka8rl3JZvCvqQzeFmVZcMQuPI=;
        b=N2IJwnyD/f2Knhs9wKjiOPxN6iDWj6WpWK/SSri5mVxDrNVpDuJfyxK8Kmozd+4RLB
         TpsvhIAYZ1/wjA1438WQa94stcZ1ZuS+/J4/WXhl5NJYy7nFltD+GXVpsl4owLSmtm36
         mpP4MaUWVhsyIvei1aRNMbFtX8bishmT/B+1zV5LGxIhmcBZfXOk2ClOH0N9skyCOEX1
         u8k72XPm7HX2gpnc+he11ZT2pVvvOaxU+L/cBW2ivcQG8B4E1+t5KAs4NoH0TahPfJV+
         mRZ/v+ISB1S1X3pq2nNJeBk1VleX/dSiTA0sPHRmvDdSbLpGrGlm4gqztAjcXgAaCBeM
         fyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPlRuudRvswXk7E3B3ka8rl3JZvCvqQzeFmVZcMQuPI=;
        b=zF1j7QBDaHu+5hCg+msRcKD/DWUJeqsuOtFD0dyZKL3NKrNlJwzZL/VdTeqGOzZ3KH
         Yj+zAy7Aq7Bih2TrVG1lvPBMrl+R53a2AHa3sxCvMu6SPidRZfKvE1rhD/1Ikf9LI7TU
         N3SCaxAV2Puz+20zm2Y5xQjbv8Eo8h2/qQBsjZtQ7HqdXQ0KHTtvSnOxsWoNpY554UfI
         JVfRuyIGhvA/FrHfkcCnGnUCL0zOJKYdW2expsGd5gMEiS8rysO+U5uzazsOsKJknO8Y
         RRtwECt1a2h/1sAnKm+OBZktcemoJ4O40j3CNwqP5Feb0hwOFbJ+04d/xeY1bBEXDDBQ
         Y35g==
X-Gm-Message-State: AOAM5304Q/vhcO6iGdB6iZNwAizTuwkpVHDksQl7PgWT1e/ie+PrsYyM
        jix3qggrDMzHKJTqFhDcJD6LdaMGXUtZ3iENIww0Xg==
X-Google-Smtp-Source: ABdhPJw/j8i7NsUhJpP541ghCDtcejh2n/V3NAQ2aIDQ/IaiHSEP1CSrecXGtsu9g9a1Jnij8KhB2DTYkqQgtLhLabw=
X-Received: by 2002:a63:9042:: with SMTP id a63mr7505878pge.369.1635537873674;
 Fri, 29 Oct 2021 13:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211028205854.830200-1-almasrymina@google.com> <2fede4d2-9d82-eac9-002b-9a7246b2c3f8@redhat.com>
In-Reply-To: <2fede4d2-9d82-eac9-002b-9a7246b2c3f8@redhat.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 29 Oct 2021 13:04:22 -0700
Message-ID: <CAHS8izMckg03uLB0vrTGv2g-_xmTh1LPRc2P8sfnmL-FK5A8hg@mail.gmail.com>
Subject: Re: [PATCH v1] mm: Add /proc/$PID/pageflags
To:     David Hildenbrand <david@redhat.com>, Nathan Lewis <npl@google.com>
Cc:     Yu Zhao <yuzhao@google.com>,
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

On Fri, Oct 29, 2021 at 12:11 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 28.10.21 22:58, Mina Almasry wrote:
> > From: Yu Zhao <yuzhao@google.com>
> >
> > This file lets a userspace process know the page flags of each of its virtual
> > pages.  It contains a 64-bit set of flags for each virtual page, containing
> > data identical to that emitted by /proc/kpageflags.  This allows the user-space
> > task can learn the kpageflags for the pages backing its address-space by
> > consulting one file, without needing to be root.
> >
> > Example use case is a performance sensitive user-space process querying the
> > hugepage backing of its own memory without the root access required to access
> > /proc/kpageflags, and without accessing /proc/self/smaps_rollup which can be
> > slow and needs to hold mmap_lock.
>
> Can you elaborate on
>
> a) The target use case. Are you primarily interested to see if a page
> given base page is head or tail?
>

Not quite. Generally some userspace process (most notably our network
service) has a region of performance critical memory and would like to
know if this memory is backed by hugepages or not. It uses
/proc/self/pageflags to inspect the pageflags of the pages backing
this region, and counts how many ranges are backed by hugepages and
how many are not. Generally we export this data to metrics, and if the
hugepage backing drops or is insufficient we look into the issue
postmortem.

> b) Your mmap_lock comment. pagemap_read() needs to hold the mmap lock in
> read mode while walking process page tables via walk_page_range().
>

Gah, I'm _very_ sorry for the misinformation. I was (very incorrectly)
under the impression that /proc/self/smaps_rollup required holding the
mmap lock but /proc/self/pageflags didn't. I'll remove the comment
about the mmap lock from the commit message in V2.

> Also, do you have a rough performance comparison?
>

So from my tests with simple processes querying smaps/pageflags I
don't see any performance difference, but I suspect it's due to my
test cases not mapping much memory or regions.

I've CC'd Nathan who works on our network service and has run into
performance issues with smaps. Nathan, do you have a rough performance
comparison? If so please do share.

> >
> > Similar to /proc/kpageflags, the flags printed out by the kernel for
> > each page are provided by stable_page_flags(), which exports flag bits
> > that are user visible and stable over time.
>
> It exports flags (documented for pageflags_read()) that are not
> applicable to processes, like OFFLINE. BUDDY, SLAB, PGTABLE ... and can
> never happen. Some of these kpageflags are not even page->flags, they
> include abstracted types we use for physical memory pages based on other
> struct page members (OFFLINE, BUDDY, MMAP, PGTABLE, ...). This feels wrong.
>
> Also, to me it feels like we are exposing too much internal information
> to the user, essentially making it ABI that user space processes will
> rely on.
>

I'm honestly a bit surprised by this comment because AFAIU (sorry if
wrong) we are already exporting this information via /proc/kpageflags
and therefore it's already somewhat part of an ABI, and the
stable_page_flags() output already needs to be stable and backwards
compatible due to potential root users being affected by any
non-backwards compatible changes. I am yes extending access to this
information to non-root users.

> Did you investigate
>
> a) Reducing the flags we expose to a bare minimum necessary for your use
> case (and actually applicable to mmaped pages).
>

To be honest I haven't, but this is something that's certainly doable.
I'm not sure it's easier for processes to understand or the kernel to
maintain. My thinking:
1. Processes parsing /proc/kpageflags can also easily parse
/proc/self/pageflags and re-use code/implementations between them.
2. Userspace code can extract the flags they need and ignore the ones
they don't need or are not applicable.
3. For kernel it's maybe easier to maintain 1 set of
stable_page_flags() and keep that list backwards compatible. To
address your comment I'd need to create a subset,
stable_ps_page_flags(), and both lists now need to be backwards
compatible.

But I hear you, and if you feel strongly about this I'm more than
happy to oblige. Please confirm if this is something you would like to
see in V2.

> b) Extending pagemap output instead.
>

No I have not until you mentioned it, but even now AFAIU (and again
sorry if wrong, please correct) all the bits exposed by pagemap as
documented in pagemap.rst are in use, and it's a non-starter for me to
modify how pagemap works because it'd break backwards compatibility.
But if you see a way I'm happy to oblige :-)

Thanks for your review!

> You seem to be interested in the "hugepage backing", which smells like
> "what is mapped" as in "pagemap".
>
>
> --
> Thanks,
>
> David / dhildenb
>
