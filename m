Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A58D3DCA1E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Aug 2021 07:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhHAFWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Aug 2021 01:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHAFWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Aug 2021 01:22:53 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A159C06175F
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jul 2021 22:22:45 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t66so13698021qkb.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jul 2021 22:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=cVKnxJsFEmP6VTmBi9tS1yfqRxwfKg7VbrVRt8cHCvo=;
        b=nniVekF9vlkNnrUOafOtXHIsYcNQ6rL681EWtkcizPpBYll7lGMYewKh1N7H2JRk17
         W0OqhipS9dSd1GQCB/S4HKMVJ+kCD5IJjKeELxH4EMefOyJk8jTTN3pKMDwIneZUp+ej
         jae6g/X2+jWkwVpG9KNQSuaa5bPuGGEImGu6NNGoZOCk2cNAAPoUpIpjb6yO1DfUJKDo
         0fLMhDxxRlzDyrz7L2+M6p7LMvHMsaEaoarTGBW265h1BQXYdupguv/qK6jzUiF34ZYG
         cP/L9VDHJTKUhgKU3CllS6TWZG3uAfhZQihh+VyjmnPMe8hbV5K7gjV20NEtsdO17mr6
         2hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=cVKnxJsFEmP6VTmBi9tS1yfqRxwfKg7VbrVRt8cHCvo=;
        b=olTk5hAbwF7zSP6TGkBS7tJAbs2purDHA+GDdqAATHyAkHb0KuFfrsNjHCm1KkFgOS
         O4/UwBwcxMJ95U/fFxI8supqJH33YL6U6ETOjU1nQ4z+ZLahOWAjEb6+d5D3z/34Ab4d
         GM4ZZpRzVqXDBeP+EzlBz+cq8qnZ6ng9fVN3Xv2R5v53ikxwZlXjBSKvtIHHBfd/7ICn
         xrwlp6OINugzD/5htNoOTouht5oXSl1lX/RBl0NH7n4ZrCdd51brFrQkXvJnGG2uw0qT
         jGuRGghHUcb6hg6k/C318RUwEtgciuNJ9o76AldF0JjkDXzr3RSkGFqukXLDeyns5gZT
         BKPg==
X-Gm-Message-State: AOAM533CUqJbLR9HrJgS2QRmTPdl3E/Et/0uatGsmb+yT/g0yOLRlOPZ
        AIvgh/thko3LPgJT4814b3R2TQ==
X-Google-Smtp-Source: ABdhPJyrUeF6RAIGrh/c9ff88AZw0UDXNn0Fppp7eogohS/Zaj97Y7d5VtLeRxic/CzNt1nJO85UaA==
X-Received: by 2002:a05:620a:2053:: with SMTP id d19mr7804552qka.402.1627795364185;
        Sat, 31 Jul 2021 22:22:44 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i7sm2891875qtr.80.2021.07.31.22.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 22:22:43 -0700 (PDT)
Date:   Sat, 31 Jul 2021 22:22:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 06/16] huge tmpfs: shmem_is_huge(vma, inode, index)
In-Reply-To: <CAHbLzkoKZ9OdUfP5DX81CKOJWrRZ0GANrmenNeKWNmSOgUh0bQ@mail.gmail.com>
Message-ID: <e7374d7e-4773-aba1-763-8fa2c953f917@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com> <dae523ab-c75b-f532-af9d-8b6a1d4e29b@google.com> <CAHbLzkoKZ9OdUfP5DX81CKOJWrRZ0GANrmenNeKWNmSOgUh0bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Jul 2021, Yang Shi wrote:
> On Fri, Jul 30, 2021 at 12:42 AM Hugh Dickins <hughd@google.com> wrote:
> >
> > Extend shmem_huge_enabled(vma) to shmem_is_huge(vma, inode, index), so
> > that a consistent set of checks can be applied, even when the inode is
> > accessed through read/write syscalls (with NULL vma) instead of mmaps
> > (the index argument is seldom of interest, but required by mount option
> > "huge=within_size").  Clean up and rearrange the checks a little.
> >
> > This then replaces the checks which shmem_fault() and shmem_getpage_gfp()
> > were making, and eliminates the SGP_HUGE and SGP_NOHUGE modes: while it's
> > still true that khugepaged's collapse_file() at that point wants a small
> > page, the race that might allocate it a huge page is too unlikely to be
> > worth optimizing against (we are there *because* there was at least one
> > small page in the way), and handled by a later PageTransCompound check.
> 
> Yes, it seems too unlikely. But if it happens the PageTransCompound
> check may be not good enough since the page allocated by
> shmem_getpage() may be charged to wrong memcg (root memcg). And it
> won't be replaced by a newly allocated huge page so the wrong charge
> can't be undone.

Good point on the memcg charge: I hadn't thought of that.  Of course
it's not specific to SGP_CACHE versus SGP_NOHUGE (this patch), but I
admit that a huge mischarge is hugely worse than a small mischarge.

We could fix it by making shmem_getpage_gfp() non-static, and pointing
to the vma (hence its mm, hence its memcg) here, couldn't we?  Easily
done, but I don't really want to make shmem_getpage_gfp() public just
for this, for two reasons.

One is that the huge race it just so unlikely; and a mischarge to root
is not the end of the world, so long as it's not reproducible.  It can
only happen on the very first page of the huge extent, and the prior
"Stop if extent has been truncated" check makes sure there was one
entry in the extent at that point: so the race with hole-punch can only
occur after we xas_unlock_irq(&xas) immediately before shmem_getpage()
looks up the page in the tree (and I say hole-punch not truncate,
because shmem_getpage()'s i_size check will reject when truncated).
I don't doubt that it could happen, but stand by not optimizing against.

Other reason is that doing shmem_getpage() (or shmem_getpage_gfp())
there is unhealthy for unrelated reasons, that I cannot afford to get
into sending patches for at this time: but some of our users found the
worst-case latencies in collapse_file() intolerable - shmem_getpage()
may be reading in from swap, while the locked head of the huge page
being built is in the page cache keeping other users waiting.  So,
I'd say there's something worse than memcg in that shmem_getpage(),
but fixing that cannot be a part of this series.

> 
> And, another question is it seems the newly allocated huge page will
> just be uncharged instead of being freed until
> "khugepaged_pages_to_scan" pages are scanned. The
> khugepaged_prealloc_page() is called to free the allocated huge page
> before each call to khugepaged_scan_mm_slot(). But
> khugepaged_scan_file() -> collapse_fille() -> khugepaged_alloc_page()
> may be called multiple times in the loop in khugepaged_scan_mm_slot(),
> so khugepaged_alloc_page() may see that page to trigger VM_BUG IIUC.
> 
> The code is quite convoluted, I'm not sure whether I miss something or
> not. And this problem seems very hard to trigger in real life
> workload.

Just to clarify, those two paragraphs are not about this patch, but about
what happens to mm/khugepaged.c's newly allocated huge page, when collapse
fails for any reason.

Yes, the code is convoluted: that's because it takes very different paths
when CONFIG_NUMA=y (when it cannot predict which node to allocate from)
and when not NUMA (when it can allocate the huge page at a good unlocked
moment, and carry it forward from one attempt to the next).

I don't like it at all, the two paths are confusing: sometimes I wonder
whether we should just remove the !CONFIG_NUMA path entirely; and other
times I wonder in the other direction, whether the CONFIG_NUMA=y path
ought to go the other way when it finds nr_node_ids is 1.  Undecided.

I'm confident that if you work through the two cases (thinking about
only one of them at once!), you'll find that the failure paths (not
to mention the successful paths) do actually work correctly without
leaking (well, maybe the !NUMA path can hold on to one huge page
indefinitely, I forget, but I wouldn't count that as leaking).

Collapse failure is not uncommon and leaking huge pages gets noticed.

Hugh
