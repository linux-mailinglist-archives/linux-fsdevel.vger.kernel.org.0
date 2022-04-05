Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754424F20A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 04:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiDECF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 22:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiDECF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:05:26 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FA8135081;
        Mon,  4 Apr 2022 18:22:13 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t21so11901663oie.11;
        Mon, 04 Apr 2022 18:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7CfRmOu2mFNhlP27BBXPAgEnRTv2JAfJlw4FzS8AkI=;
        b=Z/ADUipXSo6cCCoApgoWmuri8ib7Z2ZRmbnR54h8/VrIGaueK5QGu/WZtyWNFshPcu
         iAUxF22NOgckmUzcLG64u90kuydHGTVHt9OYXf690baDj9sOYSCj/jaZkbYXeWXHpMmB
         fAHEsMsaWg7XOguwyTv9/4z8MTuyMLKrHnwV08vQpUkIZUwgrbHKz3AVmSD3jtcNlM/x
         0UinNkINbSntmhwlU0tlzyGj/QAvnPpxiM0jFhKpPSABVsY/8/XIx1H5kYyTNNFKFogR
         jNANubjJDZQhCftsvAm3pWtbim5rG5UTWikV3yCU0eXPRTt1v5MNXIOEz9cyijS6kP55
         XDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7CfRmOu2mFNhlP27BBXPAgEnRTv2JAfJlw4FzS8AkI=;
        b=LP6A0w0tgaMTEoQt/CdUYE9qBQGsBNo8Z8vLuS1o6ayplFYbJkgXfpjiEJBQxTFFi0
         3mLGOevxCl0Boeg3O9XU3vXF7wA+GIxscRcvhwPdp82+jZz7tElpf/TfHhSrUHkXGAq6
         WgGgq7VZny1ApersE8krX2x/FJIQ6kqDOyqAF5ffCi+SoLDRn/5m5xBynQ/a57xkMoVu
         XC7o8KVTX7GKXtgLrKFGYbGEFokgX6zSo8puN0Hq6WAlQ4JrCgcDu633lI+DhJUspOL+
         NJOEzWTt4a1L0JgLrD2uqSD7mYT0h7tDkV9Ibz0shwdKw6HfMgp9ZSyVxRH+giCXTYV2
         CRfw==
X-Gm-Message-State: AOAM530rmVfmY6W3K8TkJ6OG7BU288KIniTRaJ6ZMm4jBTWEnAsoS/fX
        WUNj4NyB7KSdmCOF5NMT8j51dUJYBEwLoMu6qa2UkD5rZSc=
X-Google-Smtp-Source: ABdhPJyefORiL8A7gzvpS7dFgoDZqSwDNKY91Ji/hlxmeFS27O7LqO1jBzOIggw1AkXZ8Y44Dm+GJ8fQng2R1BpN3QQ=
X-Received: by 2002:a17:90a:5298:b0:1ca:7fb3:145 with SMTP id
 w24-20020a17090a529800b001ca7fb30145mr1036706pjh.200.1649119741666; Mon, 04
 Apr 2022 17:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220404200250.321455-1-shy828301@gmail.com> <YkuKbMbSecBVsa1k@casper.infradead.org>
In-Reply-To: <YkuKbMbSecBVsa1k@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 4 Apr 2022 17:48:49 -0700
Message-ID: <CAHbLzkoWPN+ahrvu2JrvoDpf8J_QGR6Ug6BbPnC11C82Lb-NaA@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 4, 2022 at 5:16 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Apr 04, 2022 at 01:02:42PM -0700, Yang Shi wrote:
> > The readonly FS THP relies on khugepaged to collapse THP for suitable
> > vmas.  But it is kind of "random luck" for khugepaged to see the
> > readonly FS vmas (see report: https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/) since currently the vmas are registered to khugepaged when:
>
> I still don't see the point.  The effort should be put into
> supporting large folios, not in making this hack work better.

The series makes sense even though the hack is replaced by large
folios IMHO. The problem is the file VMAs may be not registered by
khugepaged consistently for some THP modes, for example, always,
regardless of whether it's readonly or the hack is gone or not. IIUC
even though the hack is replaced by the large folios, we still have
khugepaged to collapse pmd-mappable huge pages for both anonymous vmas
and file vmas, right? Or are you thinking about killing khugepaged
soon with supporting large folios?

Anyway it may make things clearer if the cover letter is rephrased to:

When khugepaged collapses file THPs, its behavior is not consistent.
It is kind of "random luck" for khugepaged to see the file vmas (see
report: https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/)
since currently the vmas are registered to khugepaged when:
  - Anon huge pmd page fault
  - VMA merge
  - MADV_HUGEPAGE
  - Shmem mmap

If the above conditions are not met, even though khugepaged is enabled
it won't see any file vma at all.  MADV_HUGEPAGE could be specified
explicitly to tell khugepaged to collapse this area, but when
khugepaged mode is "always" it should scan suitable vmas as long as
VM_NOHUGEPAGE is not set.

So make sure file vmas are registered to khugepaged to make the
behavior more consistent.
