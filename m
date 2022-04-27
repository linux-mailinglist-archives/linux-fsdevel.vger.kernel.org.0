Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5CE512770
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 01:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiD0XUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 19:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiD0XUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 19:20:08 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23E163E4;
        Wed, 27 Apr 2022 16:16:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p6so2830986plf.9;
        Wed, 27 Apr 2022 16:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HA2iOZcTH9xcoVq+fhYi3f+JG1jZPj5iAWQGBU6dxYk=;
        b=M100Rgh1scYfFJVKHX6QedUDxXFHqefXLnvT4SqpUd/oHlGHbb/oobYGJFfZlvRt1M
         95u5K/iCnx6NQ7kgK7bkszLk8x7ofF3bQKGcGV45CNFuq4OUGo/RYoEh4F3EVIvemdEx
         yOFupPUtEIQR2vhi+lhYq1DTpri8x/xGnjCBCf1N36k55KMSggE7TSA7G5uRqI1wT1zO
         J7cNpB211LLtBzO2XzHUH5cdVhbLWGjq+bDG09a3GHhMkBuqZls7iw92MiCcPd+FGFvc
         Z2TGRypKxvKunQrWePC0n4oj+29gCKwlaf54Vbgu4O74ohCNVv39Omp0RAR38diwNweB
         9igQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HA2iOZcTH9xcoVq+fhYi3f+JG1jZPj5iAWQGBU6dxYk=;
        b=rbIXLOARMvvyx9QuOQQNG+djHea9U/qNUJOaUYNchtoTiZoD+/rNB9iS1FzSdGfrwX
         ls5SRwczhJdDEJvZo6FiRylDapsMEJvR7eW/P1ICCudj9agJl6Q6aQnUG+1qR3xgtEsU
         fbsPUWSO21DbtKFN1wnP3K1KHNsgEcMt9acumI+vjk+0BYS28JEfQNz1LmH5+elDEk9n
         N1rGkuPsMOu5gKFh63oDTmv5KfVilgq3fqOhlzpYMFi6rggu1Gk+g0WfvZSwBt2t4XBw
         nXhvU5EYIqYZM9sWTJUc2g11dHtX4ZAehdsbefisLhRTMquC62abOnhGmxladaoHemC5
         dHcg==
X-Gm-Message-State: AOAM533+bzrlagW68D7HvYXcz4hC43Be8UqUgFGgfXqJ4LDmW99J4i3r
        HrD82kdi05ZnzcRW8GzW6RqDfpiLw90SW7qK53Q=
X-Google-Smtp-Source: ABdhPJwQD/s4Wm0t1d5fd85VE3pA75rhD0V4WeNDy9GUto3y7CAzPGk0OO4/YD3GwumzVQoz/fYfJTWJroTeWij17TU=
X-Received: by 2002:a17:90b:4b07:b0:1db:c488:7394 with SMTP id
 lx7-20020a17090b4b0700b001dbc4887394mr2634716pjb.21.1651101415382; Wed, 27
 Apr 2022 16:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220404200250.321455-1-shy828301@gmail.com> <YkuKbMbSecBVsa1k@casper.infradead.org>
 <CAHbLzkoWPN+ahrvu2JrvoDpf8J_QGR6Ug6BbPnC11C82Lb-NaA@mail.gmail.com> <YmmuivdOWcr46oNC@casper.infradead.org>
In-Reply-To: <YmmuivdOWcr46oNC@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 27 Apr 2022 16:16:41 -0700
Message-ID: <CAHbLzkpH6zRtgBZixVsvMnO8Y+fM74dTAP=ktqS_bBUrsNz8qg@mail.gmail.com>
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

Song Liu already acked the series, please see
https://lore.kernel.org/linux-mm/96F2D93B-2043-44C3-8062-C639372A0212@fb.com/
