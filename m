Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597AD5205F3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 22:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiEIUic (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 16:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiEIUiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 16:38:17 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0248E27EBBD;
        Mon,  9 May 2022 13:34:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c11so14919591plg.13;
        Mon, 09 May 2022 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8q8hS13mezAfTrD0NxBCh3WW3DjGFdjsDczU3OI0oc=;
        b=G5N/JMPIwivQiHptH5/whFI3nH4TMi31rra93rxi48Fc3Uwhx0zRuO75G/xD/6fgRs
         mUuL2ZNO9UklkK4Gf06a7ully8/IGidEPjSavVIQFd37zoT33G47do+mumd1Ac7oRDXv
         pehs4xfS35G/N0w0Hte9MnqBAThy7H4lZEykJ95yBGiZ23DzbUDkGyKec3GLyr5IVhgc
         fNdmZp3F5l4oNlyCjEzPayh8zujw7LIfgmAlVXI+N4IFytFiD6uuNDkPtCZy/tDSrgk9
         g5t84ScsBytD7BrxvxHl070nnGJlv0eDiMUkGFeCXCW0O/cYp3LjbbcYXAmUbvQQcOmX
         YVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8q8hS13mezAfTrD0NxBCh3WW3DjGFdjsDczU3OI0oc=;
        b=BIsOwgr7oCKfT4ijqYqqlf31luWOEmaM0PW2EighE+mZzuaEw4n8+abTR5wsInnlO6
         b8GYItkapV8g6Ol2LH4xWLc+QuZqAn7SFa+TCiUOrPgwkTn3Ji5sEA2QUJwA/pcvq77G
         IfglDGB9osQ09jBZbQ9D8NtRh2UTArPSIHaDhCEyrK+98MhvMGpeiak0vnuPNRftXOH0
         oWNXOxVhWEmua05bGPYoruxi22SK9FbTdeUBoCnfgUwfUlVUH96OVUeIJKmvZ78EHtTh
         DhCo/9bSTUtGWvMyOPlc9iM38xasvEEj91E/sPGc5zx24KkzAcq008MPgdK31MdJD0qC
         iPeg==
X-Gm-Message-State: AOAM531+w5dMfRsDWWgY6ptzt8YaMENMNgMd5WzPPDEDrUHBy16maiU+
        Z1gfbdCurUyk/3kwjJEkLcZ0RI8h7Vjy7fICeek=
X-Google-Smtp-Source: ABdhPJx/s8hXrP/qllB2VLxqIOnghx9MB0AOjfslleJuVeqgRcuT487dkChNAInW3ZagiVKZQ3utmLNKaHRgzV0pA/I=
X-Received: by 2002:a17:90b:1b52:b0:1dc:54ea:ac00 with SMTP id
 nv18-20020a17090b1b5200b001dc54eaac00mr28126284pjb.99.1652128462376; Mon, 09
 May 2022 13:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220404200250.321455-1-shy828301@gmail.com> <627a71f8-e879-69a5-ceb3-fc8d29d2f7f1@suse.cz>
In-Reply-To: <627a71f8-e879-69a5-ceb3-fc8d29d2f7f1@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 9 May 2022 13:34:09 -0700
Message-ID: <CAHbLzkrZb6r1r6xFaEFvvJzwvVgDgeZWfjhq-SFu_mQZ0j5tTQ@mail.gmail.com>
Subject: Re: [v3 PATCH 0/8] Make khugepaged collapse readonly FS THP more consistent
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 9, 2022 at 9:05 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 4/4/22 22:02, Yang Shi wrote:
> >  include/linux/huge_mm.h        | 14 ++++++++++++
> >  include/linux/khugepaged.h     | 59 ++++++++++++---------------------------------------
> >  include/linux/sched/coredump.h |  3 ++-
> >  kernel/fork.c                  |  4 +---
> >  mm/huge_memory.c               | 15 ++++---------
> >  mm/khugepaged.c                | 76 +++++++++++++++++++++++++++++++++++++-----------------------------
> >  mm/mmap.c                      | 14 ++++++++----
> >  mm/shmem.c                     | 12 -----------
> >  8 files changed, 88 insertions(+), 109 deletions(-)
>
> Resending my general feedback from mm-commits thread to include the
> public ML's:
>
> There's modestly less lines in the end, some duplicate code removed,
> special casing in shmem.c removed, that's all good as it is. Also patch 8/8
> become quite boring in v3, no need to change individual filesystems and also
> no hook in fault path, just the common mmap path. So I would just handle
> patch 6 differently as I just replied to it, and acked the rest.
>
> That said it's still unfortunately rather a mess of functions that have
> similar names. transhuge_vma_enabled(vma). hugepage_vma_check(vma),
> transparent_hugepage_active(vma), transhuge_vma_suitable(vma, addr)?
> So maybe still some space for further cleanups. But the series is fine as it
> is so we don't have to wait for it now.

Yeah, I agree that we do have a lot thp checks. Will find some time to
look into it deeper later.

>
> We could also consider that the tracking of which mm is to be scanned is
> modelled after ksm which has its own madvise flag, but also no "always"
> mode. What if for THP we only tracked actual THP madvised mm's, and in
> "always" mode just scanned all vm's, would that allow ripping out some code
> perhaps, while not adding too many unnecessary scans? If some processes are

Do you mean add all mm(s) to the scan list unconditionally? I don't
think it will scale.

> being scanned without any effect, maybe track success separately, and scan
> them less frequently etc. That could be ultimately more efficinet than
> painfully tracking just *eligibility* for scanning in "always" mode?

Sounds like we need a couple of different lists, for example, inactive
and active? And promote or demote mm(s) between the two lists? TBH I
don't see too many benefits at the moment. Or I misunderstood you?

>
> Even more radical thing to consider (maybe that's a LSF/MM level topic, too
> bad :) is that we scan pagetables in ksm, khugepaged, numa balancing, soon
> in MGLRU, and I probably forgot something else. Maybe time to think about
> unifying those scanners?

We do have pagewalk (walk_page_range()) which is used by a couple of
mm stuff, for example, mlock, mempolicy, mprotect, etc. I'm not sure
whether it is feasible for khugepaged, ksm, etc, or not since I didn't
look that hard. But I agree it should be worth looking at.

>
>
