Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4876D51255C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 00:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiD0Wl3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 18:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiD0Wl0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:41:26 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74A26D3B4;
        Wed, 27 Apr 2022 15:38:13 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id bo5so2727014pfb.4;
        Wed, 27 Apr 2022 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drm1OQdyw43I3bW2ueb7Nz1xPsW07ECbYZ6BCyW/SWg=;
        b=g6C7JMcnrZ5ojJ8YLJNvmY7lTaxV4r0eAyKMoPajLiumweS31BhCzTuThLIrUiRBGc
         eRXEE8IQN7ojqtn7KQXhZzxHW3UtKQE6oXVeGGE/7u8c0+AKrAbRC9ttkrd+I6YHw0Vj
         Zj3iNJJBGhASQA/IKrYgpcgqfPs03eeGcULbEi/OVrmv2sYZefNNGnPQ8ETr6z7SF64Q
         FPPcYllE5FMCrqIDzoM6t3OkB6Otua3142EyPLSj76zSVSdg1uD5kFFlTpAqrgHq+wvR
         8Ibq5glylHByEctpFQp8LKT/Fd5S/qFS+IN83Z3A9MNSxusFkYGbL/aYTcGfKwd0IMqv
         vxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drm1OQdyw43I3bW2ueb7Nz1xPsW07ECbYZ6BCyW/SWg=;
        b=CPA3aEdUVnCAEfYwIVbu5ecsUVGb3LWmNshVqRGolO4srjqHXaFiNGpJJWSfv4XoAe
         9jTCUqQtF+TOEVIxorxaGzrSDwLq/eM95+f9uEFkg1uBzH0ZbTLwxHkoulLitrZpKvsk
         /UiGMPYeDbFYBm6B0AHn61uYd44lyC+ugzuoKXTSg+vRQE9AuOn4It16T7hs9fQxgmAQ
         K7OZuNNHvgUO/xrV5YpY+4UoO2ebzgxeUw+kH3ZQWICsNtyFjz0tm5xh83vFqEjI1Rs7
         gcsJkPRSYt9FiC3mcRzQ3HnksO0WNnwE9oslI4cYN/PHX+xtmfK9nPhEk1C798iK+2Jy
         489Q==
X-Gm-Message-State: AOAM531d2A16qTKntAK3sLXHQIkCPYPYrcZuP2Jq7O6oaZnPbio3dfZv
        TB5LfI5JbsV6J2KhXrf0o0i8vDU14tFLzbsxCK0=
X-Google-Smtp-Source: ABdhPJz5hgyo4J17oiLJQvgmGBUrY5Szb7LLTDZQuKW+KQqtiG1uSOJB7kXebmgJ2zuSLtC0gH0cpsi+p7k4QYGE8nk=
X-Received: by 2002:a63:90ca:0:b0:3aa:fff3:6f76 with SMTP id
 a193-20020a6390ca000000b003aafff36f76mr19460147pge.206.1651099093287; Wed, 27
 Apr 2022 15:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220404200250.321455-1-shy828301@gmail.com> <YkuKbMbSecBVsa1k@casper.infradead.org>
 <CAHbLzkoWPN+ahrvu2JrvoDpf8J_QGR6Ug6BbPnC11C82Lb-NaA@mail.gmail.com> <YmmuivdOWcr46oNC@casper.infradead.org>
In-Reply-To: <YmmuivdOWcr46oNC@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 27 Apr 2022 15:38:00 -0700
Message-ID: <CAHbLzkoOvewQ6DfXH1Pac50xDS+PHRh3BbYVwGnptov55N6msQ@mail.gmail.com>
Subject: Re: [v3 PATCH 0/8] Make khugepaged collapse readonly FS THP more consistent
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>, Zi Yan <ziy@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 27, 2022 at 1:59 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Apr 04, 2022 at 05:48:49PM -0700, Yang Shi wrote:
> > When khugepaged collapses file THPs, its behavior is not consistent.
> > It is kind of "random luck" for khugepaged to see the file vmas (see
> > report: https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/)
> > since currently the vmas are registered to khugepaged when:
> >   - Anon huge pmd page fault
> >   - VMA merge
> >   - MADV_HUGEPAGE
> >   - Shmem mmap
> >
> > If the above conditions are not met, even though khugepaged is enabled
> > it won't see any file vma at all.  MADV_HUGEPAGE could be specified
> > explicitly to tell khugepaged to collapse this area, but when
> > khugepaged mode is "always" it should scan suitable vmas as long as
> > VM_NOHUGEPAGE is not set.
>
> I don't see that as being true at all.  The point of this hack was that
> applications which really knew what they were doing could enable it.
> It makes no sense to me that setting "always" by the sysadmin for shmem
> also force-enables ROTHP, even for applications which aren't aware of it.
>
> Most telling, I think, is that Song Liu hasn't weighed in on this at
> all.  It's clearly not important to the original author.

I tend to agree that MADV_MADVISE should be preferred when this
feature (or hack) was designed in the original author's mind in the
first place. And "madvise" is definitely the recommended way to use
THP, but I don't think it means we should not care "always" and assume
nobody uses it otherwise the issue would have not been reported.
