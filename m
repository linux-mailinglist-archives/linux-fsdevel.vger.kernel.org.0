Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1934DE0B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 19:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbiCRSGC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 14:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239003AbiCRSGB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:06:01 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E439926D12A;
        Fri, 18 Mar 2022 11:04:41 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id z3so7565482plg.8;
        Fri, 18 Mar 2022 11:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLw5aT9zVs0EZtCEb7VglCzhcgG8kUImgdGoeG9GVtU=;
        b=h4XjFNIvnTxd7SCcqa4K1v3yCHtVZx1a4IiGsVy5mzRoao7zIm5Z8vE7dex62Wjs/z
         +BfwO+qlQ2GblYO5rDNVIfyCpcee+MT+ZH4gRIZZLwxDVNTUInwDI1vOXfxDTZQSvZhD
         dVyMtYaX1BbziVKOmRVkvsfHDd1264JoMAQmf7kqBJkPZeugN7F8JxSHtNEpDxV2N57N
         nEXlza1aP73Z16QqooUm6u8ml/QPb/oUe9EDhC62fkwnFE7EfI/JboNlFlrxhgKp98m3
         LnJxglLaS0bNmxyS6Vb0hCU05ZIYpD3U8UEoVHni0e88aH3p8IsN2dme9O4RepGWHF2S
         CECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLw5aT9zVs0EZtCEb7VglCzhcgG8kUImgdGoeG9GVtU=;
        b=5ukO14L7o6qoLz+gPMZkYRuPpD2KZOrq1hbIOyxrbCP9xb9WqQrP09YGRB+cqVBXYY
         RoGkviF9HkgPYXI9HmIZeNiNeCRE7MRrnRb+zbkdYtGPfIt1NX2sr9fXtWkxqvC5jPR7
         pxKVk/+/4yMX2NsmMeQyQSKy5cBfK3QKgHhbAJay13EtXbCG+bOeYkYBMAJPoOnqJHpH
         j3wTk66l9H/9EnG4ssgwnoXQO78MG0Pc7Glp9TTgsonnQb2cen6V7r5wix92uhgE344A
         1wSmnWi7pTAwNOx3W1NRgfBTI4BFTi2g/C2RZw0VR38hl1dqkeXGZim5jzyAITm9UfBy
         nlUg==
X-Gm-Message-State: AOAM532EMvQgPy8LBnicS1/bosyYu52ujSsYdf91uCGtmAsQ1vIEGXQt
        nJYiyyTVOfy8hhJgavtvNKIBCoIdFJvGYytYs2c=
X-Google-Smtp-Source: ABdhPJxHdDv5DRrnv94ev/44w4EUImE7+wTlEpf9gjK2FKARb3LV+FFA3II4f7AWpqyh8dNZs/Kk1ItNxk6tyCE1TE4=
X-Received: by 2002:a17:90a:3b06:b0:1c6:7140:348d with SMTP id
 d6-20020a17090a3b0600b001c67140348dmr13534192pjc.99.1647626681305; Fri, 18
 Mar 2022 11:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220317234827.447799-1-shy828301@gmail.com> <20220318012948.GE1544202@dread.disaster.area>
 <YjP+oyoT9Y2SFt8L@casper.infradead.org>
In-Reply-To: <YjP+oyoT9Y2SFt8L@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 18 Mar 2022 11:04:29 -0700
Message-ID: <CAHbLzkonVj63+up4-BCPm29yjaf_29asMFJHpXiZp96UjGGNSg@mail.gmail.com>
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

On Thu, Mar 17, 2022 at 8:38 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Mar 18, 2022 at 12:29:48PM +1100, Dave Chinner wrote:
> > On Thu, Mar 17, 2022 at 04:48:19PM -0700, Yang Shi wrote:
> > >
> > > Changelog
> > > v2: * Collected reviewed-by tags from Miaohe Lin.
> > >     * Fixed build error for patch 4/8.
> > >
> > > The readonly FS THP relies on khugepaged to collapse THP for suitable
> > > vmas.  But it is kind of "random luck" for khugepaged to see the
> > > readonly FS vmas (see report: https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/) since currently the vmas are registered to khugepaged when:
> > >   - Anon huge pmd page fault
> > >   - VMA merge
> > >   - MADV_HUGEPAGE
> > >   - Shmem mmap
> > >
> > > If the above conditions are not met, even though khugepaged is enabled
> > > it won't see readonly FS vmas at all.  MADV_HUGEPAGE could be specified
> > > explicitly to tell khugepaged to collapse this area, but when khugepaged
> > > mode is "always" it should scan suitable vmas as long as VM_NOHUGEPAGE
> > > is not set.
> > >
> > > So make sure readonly FS vmas are registered to khugepaged to make the
> > > behavior more consistent.
> > >
> > > Registering the vmas in mmap path seems more preferred from performance
> > > point of view since page fault path is definitely hot path.
> > >
> > >
> > > The patch 1 ~ 7 are minor bug fixes, clean up and preparation patches.
> > > The patch 8 converts ext4 and xfs.  We may need convert more filesystems,
> > > but I'd like to hear some comments before doing that.
> >
> > After reading through the patchset, I have no idea what this is even
> > doing or enabling. I can't comment on the last patch and it's effect
> > on XFS because there's no high level explanation of the
> > functionality or feature to provide me with the context in which I
> > should be reviewing this patchset.
> >
> > I understand this has something to do with hugepages, but there's no
> > explaination of exactly where huge pages are going to be used in the
> > filesystem, what the problems with khugepaged and filesystems are
> > that this apparently solves, what constraints it places on
> > filesystems to enable huge pages to be used, etc.
> >
> > I'm guessing that the result is that we'll suddenly see huge pages
> > in the page cache for some undefined set of files in some undefined
> > set of workloads. But that doesn't help me understand any of the
> > impacts it may have. e.g:
> >
> > - how does this relate to the folio conversion and use of large
> >   pages in the page cache?
> > - why do we want two completely separate large page mechanisms in
> >   the page cache?
> > - why is this limited to "read only VMAs" and how does the
> >   filesystem actually ensure that the VMAs are read only?
> > - what happens if we have a file that huge pages mapped into the
> >   page cache via read only VMAs then has write() called on it via a
> >   different file descriptor and so we need to dirty the page cache
> >   that has huge pages in it?
> >
> > I've got a lot more questions, but to save me having to ask them,
> > how about you explain what this new functionality actually does, why
> > we need to support it, and why it is better than the fully writeable
> > huge page support via folios that we already have in the works...
>
> Back in Puerto Rico when we set up the THP Cabal, we had two competing
> approaches for using larger pages in the page cache; mine (which turned
> into folios after I realised that THPs were the wrong model) and Song
> Liu's CONFIG_READ_ONLY_THP_FOR_FS.  Song's patches were ready earlier
> (2019) and were helpful in unveiling some of the problems which needed
> to be fixed.  The filesystem never sees the large pages because they're
> only used for read-only files, and the pages are already Uptodate at
> the point they're collapsed into a THP.  So there's no changes needed
> to the filesystem.
>
> This collection of patches I'm agnostic about.  As far as I can
> tell, they're a way to improve how often the ROTHP feature gets used.
> That doesn't really interest me since we're so close to having proper
> support for large pages/folios in filesystems.  So I'm not particularly
> interested in improving a feature that we're about to delete.  But I also
> don't like it that the filesystem now has to do something; the ROTHP
> feature is supposed to be completely transparent from the point of view
> of the filesystem.

I agree once page cache huge page is fully supported,
READ_ONLY_THP_FOR_FS could be deprecated. But actually this patchset
makes khugepaged collapse file THP more consistently. It guarantees
the THP could be collapsed as long as file THP is supported and
configured properly and there is suitable file vmas, it is not
guaranteed by the current code. So it should be useful even though
READ_ONLY_THP_FOR_FS is gone IMHO.

>
