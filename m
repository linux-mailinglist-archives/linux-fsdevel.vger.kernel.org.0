Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150674598CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 01:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhKWADv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 19:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbhKWADi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 19:03:38 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD33BC061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 16:00:31 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id e144so25589336iof.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 16:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvbMJXxda82XEAO4bPeDnXK3sn8Cfx5yhstWkFf0DAg=;
        b=CBWZMiPBAHyR1bSiIeNHOTa63ZJ/mqntNkqFRQdxVUZda0KmcRfPQ7whve014QDwcr
         /vr9YG4LAZGDRWUR4KP4Nk69Mzv71kwWUI5zsnLsxTWExZledIN3r5a31bm+k0UEBtQ8
         ZSLF4HPtY4R8t7vUchL04wmUjB3l1AIydNDE8f7lw7QGsBmNeeck27QlWAUl7p9aJWYU
         cwVTb1pDvrFr54vOc/2+vYSDz5p7UYTs4eV68Ku2Dv0AuvcapC5w8kjsR5bc1qrYfSI2
         AiuO/raM65ZeWzIaNl8MKowkETzpiW+T0HymjHpMJjcJnd8zhIc7XaeWTFjgPQZ3GJQN
         d8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvbMJXxda82XEAO4bPeDnXK3sn8Cfx5yhstWkFf0DAg=;
        b=C83OftbIc484WiBSjWYDjPAbocEY4VDUyQKbh9X0oBda/y7+xIQ28NyUrTXI3ay5S/
         UzWI4aZWA81i/TN1bp1qVELk5twyiHTKk4SlBwYkTR+nxYXdBgEfOTCBPvAYWh/b77WT
         yaHmEvN4toTg9ges6MI2KcNgOd9THy4J8i74TkW4R1OxJhjZ/RyIYWI6URZfEX6Mk8RK
         2Lk3sToeCXZVSJZnFzX13bL518h8+6L4tP3WFP2JdX4NFcQfqmI/MFGKxSbztuc++UjV
         IX72JbfLWUms4jQshRUHF/lPwVTnex52mobzAJy3RqHyKt7P6xLUont3qrMZV7kK9omn
         KxKg==
X-Gm-Message-State: AOAM531qqIJNiim7QTLkfIOX+HAkNn2/Sm8vzfJL+aGo0Up32Q23BLto
        lSRbc1CF4UzOcfIBB5s9cn3uv0GMdQVzJFhbBNu2Og==
X-Google-Smtp-Source: ABdhPJxDPKkz48KkZ5ene9+3EHyc9YnR7TuDhr0v8XiNE369M3RHLdIfTrZ7leu23bvuyctbUhkB1Ba/wgdkm4TL2fk=
X-Received: by 2002:a05:6638:2590:: with SMTP id s16mr398394jat.93.1637625630932;
 Mon, 22 Nov 2021 16:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20211117194855.398455-1-almasrymina@google.com> <YZWfhsMtH8KUaEqO@xz-m1.local>
In-Reply-To: <YZWfhsMtH8KUaEqO@xz-m1.local>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 22 Nov 2021 16:00:19 -0800
Message-ID: <CAHS8izPKm3jFjpwtGwcF=UVnxYhZFkJ-NZKOyV+gjPDvzi5reQ@mail.gmail.com>
Subject: Re: [PATCH v6] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
To:     Peter Xu <peterx@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 4:34 PM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Mina,
>
> On Wed, Nov 17, 2021 at 11:48:54AM -0800, Mina Almasry wrote:
> > Add PM_THP_MAPPED MAPPING to allow userspace to detect whether a given virt
> > address is currently mapped by a transparent huge page or not.  Example
> > use case is a process requesting THPs from the kernel (via a huge tmpfs
> > mount for example), for a performance critical region of memory.  The
> > userspace may want to query whether the kernel is actually backing this
> > memory by hugepages or not.
> >
> > PM_THP_MAPPED bit is set if the virt address is mapped at the PMD
> > level and the underlying page is a transparent huge page.
> >
> > A few options were considered:
> > 1. Add /proc/pid/pageflags that exports the same info as
> >    /proc/kpageflags.  This is not appropriate because many kpageflags are
> >    inappropriate to expose to userspace processes.
> > 2. Simply get this info from the existing /proc/pid/smaps interface.
> >    There are a couple of issues with that:
> >    1. /proc/pid/smaps output is human readable and unfriendly to
> >       programatically parse.
> >    2. /proc/pid/smaps is slow.  The cost of reading /proc/pid/smaps into
> >       userspace buffers is about ~800us per call, and this doesn't
> >       include parsing the output to get the information you need. The
> >       cost of querying 1 virt address in /proc/pid/pagemaps however is
> >       around 5-7us.
>
> This does not seem to be fair...  Should the "800us" value relevant to the
> process memory size being mapped?  As smaps requires walking the whole memory
> range and provides all stat info including THP accountings.
>
> While querying 1 virt address can only account 1 single THP at most.
>
> It means if we want to do all THP accounting for the whole range from pagemap
> we need multiple read()s, right?  The fair comparison should compare the sum of
> all the read()s on the virt addr we care to a single smap call.
>
> And it's hard to be fair too, IMHO, because all these depend on size of mm.
>
> Smaps is, logically, faster because of two things:
>
>   - Smaps needs only one syscall for whatever memory range (so one
>     user->kernel->user switch).
>
>     Comparing to pagemap use case of yours, you'll need to read 1 virt address
>     for each PMD, so when the PMD mapped size is huge, it could turn out that
>     smaps is faster even counting in the parsing time of smaps output.
>
>   - Smaps knows how to handle things in PMD level without looping into PTEs:
>     see smaps_pmd_entry().
>
>     Smaps will not duplicate the PMD entry into 512 PTE entries, because smaps
>     is doing statistic (and that's exaxtly what your use case wants!), while
>     pagemap is defined in 4K page size even for huge mappings because the
>     structure is defined upon the offset of the pagemap fd; that's why it needs
>     to duplicate the 2M entry into 512 same ones; even if they're not really so
>     meaningful.
>
> That's also why I tried to propose the interface of smaps to allow querying
> partial of the memory range, because IMHO it solves the exact problem you're
> describing and it'll also be in the most efficient way, meanwhile I think it
> expose all the rest smaps data too besides THP accountings so it could help
> more than thp accountings.
>
> So again, no objection on this simple and working patch, but perhaps rephrasing
> the 2nd bullet as: "smaps is slow because it must read the whole memory range
> rather than a small range we care"?
>

Sure thing, added in v7.

If I'm coming across as resisting a range-based smaps, I don't mean
to. I think it addresses my use case. I'm just warning/pointing out
that:
1. It'll be a large(r than 2 line) patch and probably an added kernel
interface, and I'm not sure my use case is an acceptable justification
to do that given the problem can be equally addressed very simply like
I'm adding here, but if it is an acceptable justification then I'm
fine with a range-based smaps.
2. I'm not 100% sure what the performance would be like. But I can
protype it and let you know if I have any issues with the performance.
I just need to know what interface you're envisioning for this.

I'll upload a v7 with the commit message change, and let me know what you think!

> Thanks,

>
> --
> Peter Xu
>
