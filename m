Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EFE4DE251
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 21:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbiCRUUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 16:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbiCRUUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:20:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A5AB2455;
        Fri, 18 Mar 2022 13:19:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v4so8279560pjh.2;
        Fri, 18 Mar 2022 13:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HV4U7qntOGnpJQ2Afj++lgXG3IzP1EpW8jb1OgmKEbs=;
        b=cv/wFbgGRgnZTrAo2iSw2ZYNZUvLSvO2ykavsVExcgFHItqQBTyFH7XfiGSzuYmgwA
         Ed/JqSZs6k0xhbTvukrPZxEZWV4jv5BtS4zuCxqFqhs2oXgCojO8M1opGbEwTKSG4awU
         lhBbN+i+NnMlCgMprP9pR+cCkED5e/56cGEarkY/Ah0B68BqRb4VcQ/YZN/fWJ6ZzWgb
         sKicUq3R3HPPAKLMthT1J6DFsMHC27D8b35u/5XMiKH/TJ8FAXlzqZHDmEBL2uIpHWSa
         MnyPKyGIYzKEJiYv7difK79cDiFRCJnz5WPIfDR2pzRioPQmcDWorTSHCivvHfRSseRM
         TBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HV4U7qntOGnpJQ2Afj++lgXG3IzP1EpW8jb1OgmKEbs=;
        b=TpIz/hXueDbtS/AIxi1Vp/VzvwJbsmSnkPfxlOJUlSPG9o+1C7NOSZQvixMMMyWYMm
         i4k8s5q5md/omP86IZ9nXPk1qNj9VNIaNb9wieD54FpPRdUyRP64op3YYirZeJ/ZHwcO
         k5LchIgvLxn2hmAOsTRIeyWoCdJ/RUCT/kcoXCXmCdP143Rv8yImboCsEkaYUzkQC2Ac
         eHiGPEd6pKpdrucQw15qFgS33BA4++LWAdV+IIh5D5fNx3Ot6nMKXPlXkK9QYFUkHRp+
         WZ/b5liDxL3NgcSRm0PQGJIMqA4evkPfEfWB1SrHGVLRtPn0OZZefPWvtSskHJZWrSiq
         2lvQ==
X-Gm-Message-State: AOAM533VaUt7wxBkQ64eGqhfEXU9Y5TRLFUGSiQuVosGS+p+N/eWyRpe
        e8HL0cul/0IhITtOVgKpYRKTQTDHQhN/gIVZkAk=
X-Google-Smtp-Source: ABdhPJzS7VKxms885c65Z+VAIRBodeDJ9R0QcxFh8fU+8LTK7EQHr7jWlQVtwvzDdeaT2HcKmVDeVupzLGpfuzOqFwo=
X-Received: by 2002:a17:90a:3906:b0:1bf:a0a6:d208 with SMTP id
 y6-20020a17090a390600b001bfa0a6d208mr23331916pjb.21.1647634752753; Fri, 18
 Mar 2022 13:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220317234827.447799-1-shy828301@gmail.com> <20220318012948.GE1544202@dread.disaster.area>
 <YjP+oyoT9Y2SFt8L@casper.infradead.org> <CAHbLzkonVj63+up4-BCPm29yjaf_29asMFJHpXiZp96UjGGNSg@mail.gmail.com>
 <YjTT5Meqdn8fiuC2@casper.infradead.org>
In-Reply-To: <YjTT5Meqdn8fiuC2@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 18 Mar 2022 13:19:00 -0700
Message-ID: <CAHbLzkrE1sF2bcv=eB8szx047pUgMZzo9JuyADTCBzZ9V-+7XA@mail.gmail.com>
Subject: Re: [v2 PATCH 0/8] Make khugepaged collapse readonly FS THP more consistent
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        songliubraving@fb.com, riel@surriel.com, ziy@nvidia.com,
        akpm@linux-foundation.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        darrick.wong@oracle.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Mar 18, 2022 at 11:48 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Mar 18, 2022 at 11:04:29AM -0700, Yang Shi wrote:
> > I agree once page cache huge page is fully supported,
> > READ_ONLY_THP_FOR_FS could be deprecated. But actually this patchset
> > makes khugepaged collapse file THP more consistently. It guarantees
> > the THP could be collapsed as long as file THP is supported and
> > configured properly and there is suitable file vmas, it is not
> > guaranteed by the current code. So it should be useful even though
> > READ_ONLY_THP_FOR_FS is gone IMHO.
>
> I don't know if it's a good thing or not.  Experiments with 64k
> PAGE_SIZE on arm64 shows some benchmarks improving and others regressing.
> Just because we _can_ collapse a 2MB range of pages into a single 2MB
> page doesn't mean we _should_.  I suspect the right size folio for any
> given file will depend on the access pattern.  For example, dirtying a
> few bytes in a folio will result in the entire folio being written back.
> Is that what you want?  Maybe!  It may prompt the filesystem to defragment
> that range, which would be good.  On the other hand, if you're bandwidth
> limited, it may decrease your performance.  And if your media has limited
> write endurance, it may result in your drive wearing out more quickly.
>
> Changing the heuristics should come with data.  Preferably from a wide
> range of systems and use cases.  I know that's hard to do, but how else
> can we proceed?

TBH I don't think it belongs to "change the heuristics". Its users'
decision if their workloads could benefit from huge pages or not. They
could set THP to always/madivse/never per their workloads. The
patchset is aimed to fix the misbehavior. The user visible issue is
even though users enable READ_ONLY_THP_FOR_FS and configure THP to
"always" (khugepaged always runs) and do expect their huge text
section is backed by THP but THP may not be collapsed.

>
> And I think you ignored my point that READ_ONLY_THP_FOR_FS required
> no changes to filesystems.  It was completely invisible to them, by
> design.  Now this patchset requires each filesystem to do something.
> That's not a great step.

I don't mean to ignore your point. I do understand it is not perfect.
I was thinking about making it FS agnostic in the first place. But I
didn't think of a perfect way to do it at that time, so I followed
what tmpfs does.

However, by rethinking this we may be able to call
khugepaged_enter_file() in filemap_fault(). I was concerned about the
overhead in the page fault path. But it may be neglectable since
khugepaged_enter_file() does bail out in the first place if the mm is
already registered in khugepaged, just the first page fault needs to
go through all the check, but the first page fault is typically a
major fault so the overhead should be not noticeable comparing to the
overhead of I/O. Calling khugepaged_enter() in page fault path is the
approach used by anonymous THP too.

>
> P.S. khugepaged currently does nothing if a range contains a compound
> page.  It assumes that the page is compound because it's now a THP.
> Large folios break that assumption, so khugepaged will now never
> collapse a range which includes large folios.  Thanks to commit
>     mm/filemap: Support VM_HUGEPAGE for file mappings
> we'll always try to bring in PMD-sized pages for MADV_HUGEPAGE, so
> it _probably_ doesn't matter.  But it's something we should watch
> for as filesystems grow support for large folios.

Yeah, I agree, thanks for reminding this. In addition I think the
users of READ_ONLY_THP_FOR_FS should also expect the PMD-sized THP to
be collapsed for their usecase with full page cache THP support since
their benefits come from reduced TLB miss.
