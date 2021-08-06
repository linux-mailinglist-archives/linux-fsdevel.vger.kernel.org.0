Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCA63E2232
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 05:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241025AbhHFDe0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 23:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239651AbhHFDeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 23:34:25 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2487C061798
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Aug 2021 20:34:09 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id h27so5511345qtu.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Aug 2021 20:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=y8ogEIVcPiFxpMZEeFL+iB1RVC44ARrL6FG7si/okV8=;
        b=GtN34Q4YXatK1FMDurMfqzSx7R3KDMxupETssqL8pGpziaAyzf1nRXPdqlfpp06Gbi
         NjER6XOHZV5MUt/Tr6ws1pXwJHYoNlOpWYuyM6cYzihK6CD4QpmjPptGUP3BognP/y5r
         IMn+8LZvRCNaaHmv8GbKDgzSked5v5yzzQRcAGlGy8ijswcgSpc0YUVAgpRDvsZ7+yVx
         b8lIDWO7QnJuwZA7B3nl0GdDT1FZEd7jPc7mZ7mv/BRg6fLuH3EuacGjugEuZvGSaXFv
         pFXw1NUa4gT6YyyFR9ylK7FKqo83wUrqG+XytD5mjyBoxcvIeJkhT0ulox1y/HW5wrF4
         etUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=y8ogEIVcPiFxpMZEeFL+iB1RVC44ARrL6FG7si/okV8=;
        b=HIMnSOOIRWzXlWwTUVMyLQ2pQGm3dMd8sQgSSmE9NqjjLjBU1vgOk59HA1/8JWutJb
         FlSzNgxJY6Ez569y5ClnFGHYG6j6mbOJD/zi53G2HXU6pV6H7yBLXlQWQSepm4QVzwm2
         IQwWvMYGNuBcG3JTr3Jx58KMoYUaVlh/jld97EtQIeGFujltXWkwK7eRT8usekk65Gzt
         u6LEk36X+7/8IQpW7iaqiDSMFNVUtMCU3jrVc2hTEruO+MySNnW9S4M/Kb27MynhdX0M
         1AScqDtchojtcNnmnxu/1+yEu8HvBTgK5LDEmh5offGN3jdhfHMpW3uPRKgRRMvFsBfj
         HcXA==
X-Gm-Message-State: AOAM531HxVHvTn5AFrWzbwnOhWK+bIu3ZcG9zFQ4dAx/bcZT/RHODc6q
        b2TmY5ghivNFL4SZs1+gJyUCIw==
X-Google-Smtp-Source: ABdhPJy8OuSwStOaQYrXr5aTHo+kB9ZBtuCUXy8wngT9cE4vUh2LOYzxm50BNMMBD1AItuok2DUtOw==
X-Received: by 2002:ac8:5ac7:: with SMTP id d7mr7294096qtd.240.1628220848602;
        Thu, 05 Aug 2021 20:34:08 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x10sm3936003qkf.91.2021.08.05.20.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 20:34:07 -0700 (PDT)
Date:   Thu, 5 Aug 2021 20:33:21 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
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
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/16] memfd: memfd_create(name, MFD_HUGEPAGE) for shmem
 huge pages
In-Reply-To: <20210804140341.m3ptxesrxwivqjmk@box.shutemov.name>
Message-ID: <7852f33a-bfe8-cbf6-65c8-30f7c06d5e@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com> <c140f56a-1aa3-f7ae-b7d1-93da7d5a3572@google.com> <20210804140341.m3ptxesrxwivqjmk@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 4 Aug 2021, Kirill A. Shutemov wrote:
> On Fri, Jul 30, 2021 at 12:45:49AM -0700, Hugh Dickins wrote:
> > Commit 749df87bd7be ("mm/shmem: add hugetlbfs support to memfd_create()")
> > in 4.14 added the MFD_HUGETLB flag to memfd_create(), to use hugetlbfs
> > pages instead of tmpfs pages: now add the MFD_HUGEPAGE flag, to use tmpfs
> > Transparent Huge Pages when they can be allocated (flag named to follow
> > the precedent of madvise's MADV_HUGEPAGE for THPs).
> 
> I don't like the interface. THP supposed to be transparent, not yet another
> hugetlbs.

THP is transparent in the sense that it builds hugepages from the
normal page pool, when it can (or not when it cannot), rather than
promising hugepages from a separate pre-reserved hugetlbfs pool.

Not transparent in the sense that it cannot be limited or guided.

> 
> > /sys/kernel/mm/transparent_hugepage/shmem_enabled "always" or "force"
> > already made this possible: but that is much too blunt an instrument,
> > affecting all the very different kinds of files on the internal shmem
> > mount, and was intended just for ease of testing hugepage loads.
> 
> I wounder if your tried "always" in production? What breaks? Maybe we can
> make it work with a heuristic? This would speed up adoption.

We have not tried /sys/kernel/mm/transparent_hugepage/shmem_enabled
"always" in production.  Is that an experiment I want to recommend for
production?  No, I don't think so!  Why should we?

I am not looking to "speed up adoption" of huge tmpfs everywhere:
let those who find it useful use it, there is no need for it to be
used everywhere.

We have had this disagreement before: you were aiming for tmpfs on /tmp
huge=always, I didn't see the need for that; but we have always agreed
that it should not be broken there, and the better it works the better -
you did the unused_huge_shrink stuff in particular to meet such cases.

> 
> If a tunable needed, I would rather go with fadvise(). It would operate on
> a couple of bits per struct file and they get translated into VM_HUGEPAGE
> and VM_NOHUGEPAGE on mmap().
> 
> Later if needed fadvise() implementation may be extended to track
> requested ranges. But initially it can be simple.

Let me shift that to the 08/16 (fcntl) response, and here answer:

> Hm, But why is the MFD_* needed if the fcntl() can do the same.

You're right, MFD_HUGEPAGE (and MFD_MEM_LOCK) are not strictly
needed if there's an fcntl() or fadvise() which can do that too.

But MFD_HUGEPAGE is the option which was first asked for, and is
the most popular usage internally - I did the fcntl at the same time,
and it has been found useful, but MFD_HUGEPAGE was the priority
(largely because fiddling with shmem_enabled interferes with
everyone's different usages, whereas huge=always on a mount
can be deployed selectively).

And it makes good sense for memfd_create() to offer MFD_HUGEPAGE,
as it is already offering MFD_HUGETLB: when we document MFD_HUGEPAGE
next to MFD_HUGETLB in the memfd_create(2) man page, that will help
developers to make a good choice.

(You said MFD_*, so I take it that you're thinking of MFD_MEM_LOCK
too: MFD_MEM_LOCK is something I added when building this series,
when I realized that it became possible once size change permitted.
Nobody here is using it yet, I don't mind if it's dropped; but it's
natural to propose it as part of the series, and it can be justified
as offering the memlock option which MFD_HUGETLB already bundles in.)

Hugh
