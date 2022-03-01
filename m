Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3AF4C818F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 04:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiCADQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 22:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiCADQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 22:16:14 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93A45AEF3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 19:15:33 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id y189so24630168ybe.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 19:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0AjxvjFrHR6fu2oGFLcKZSFRRlXKq1Dcqtae0GYicM=;
        b=zI7OFwma/V9whbuWLP6/dekw2Ef4XO1BHT/odjfXiqqBSBN3wNRSaGlW2e5S3DMHh7
         6nafsyPBh4XZpyLf2y8+bx1wiOP4m/XVyOhznsE0nDLtBWURJEZWY5eN+FSlXebfO/aq
         MwUsslVUGDBvCplLbj0DodURsvuHlZKfRKRtG0HI9/Ohu/g8Fmg0lYEl7PCIAzTcnaWE
         Up6KvQB5PLEdim8+dqyWUZVrTMjwU+YF2tRj6Iur3Wzj7yuugcJee25X7gymnZVLr5Q2
         EiswuU88iHSTSH58Nu6p49kDjlzAq1dGIhw6LjEOdmlf7xGuc1AM4V3PFzyIodKR2Uzv
         nGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0AjxvjFrHR6fu2oGFLcKZSFRRlXKq1Dcqtae0GYicM=;
        b=j5aZ/OA/p9hBhfMTobQJs2j/nGN0aHx8mKXJr0MN5DDeCYC9EWFZyJpmz4rIqlfY8S
         kPQ3N4satbyzVbm/JCYIlWrWScXJMfSV2zpS4unfhTrL1PNcEvAOVzJ8KvCXuuu+eaxa
         aVVcsK4Bf3/Gf3KqRlmU6loMXTEDR20z8j4FwgI8NX+lj3s/ZxBV0Fe8QSRObAKkSLC0
         2CncPpfHEKulYsJgPKxDgB2MGoz5OBTPd5SlRKMaO+hId4VBdJ7n2SwGDDbE/kiFCEW0
         6AlsaER6k+X1K6D76AbnwSvElhmXb6qsXCZD0ycwp3EhWyDbFMBzOZXsSwTHZypsDja6
         YmaQ==
X-Gm-Message-State: AOAM530DMWgwuFcsSsOAEr/QGyipBJmGh6PuKgPmU3S3uXYLBneE/Jrm
        11dCgXF+t2hpcH5yr9zTp8suClvufILiSKh5ayIS6A==
X-Google-Smtp-Source: ABdhPJyLlgGIyou+wAfEaWXmEmFOpM1Brk7yD9bDbyrwHm7wvg19Gmdb28Sqk2YKeULEgdNtRu+P34JXz4ZnYeV1Fww=
X-Received: by 2002:a25:3d87:0:b0:61e:170c:aa9 with SMTP id
 k129-20020a253d87000000b0061e170c0aa9mr21333575yba.89.1646104533214; Mon, 28
 Feb 2022 19:15:33 -0800 (PST)
MIME-Version: 1.0
References: <20220228063536.24911-1-songmuchun@bytedance.com>
 <20220228063536.24911-5-songmuchun@bytedance.com> <20220228132606.7a9c2bc2d38c70604da98275@linux-foundation.org>
In-Reply-To: <20220228132606.7a9c2bc2d38c70604da98275@linux-foundation.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 1 Mar 2022 11:14:53 +0800
Message-ID: <CAMZfGtWrHCdE9PfUK2MGHfujBU=o1Dxv=ztdFwhXpjcTPCxnPw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] mm: pvmw: add support for walking devmap pages
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        zwisler@kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        nvdimm@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 1, 2022 at 5:26 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 28 Feb 2022 14:35:34 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>
> > The devmap pages can not use page_vma_mapped_walk() to check if a huge
> > devmap page is mapped into a vma.  Add support for walking huge devmap
> > pages so that DAX can use it in the next patch.
> >
>
> x86_64 allnoconfig:
>
> In file included from <command-line>:
> In function 'check_pmd',
>     inlined from 'page_vma_mapped_walk' at mm/page_vma_mapped.c:219:10:
> ././include/linux/compiler_types.h:347:45: error: call to '__compiletime_assert_232' declared with attribute error: BUILD_BUG failed
>   347 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                             ^
> ././include/linux/compiler_types.h:328:25: note: in definition of macro '__compiletime_assert'
>   328 |                         prefix ## suffix();                             \
>       |                         ^~~~~~
> ././include/linux/compiler_types.h:347:9: note: in expansion of macro '_compiletime_assert'
>   347 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>       |                     ^~~~~~~~~~~~~~~~
> ./include/linux/huge_mm.h:307:28: note: in expansion of macro 'BUILD_BUG'
>   307 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>       |                            ^~~~~~~~~
> ./include/linux/huge_mm.h:104:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
>   104 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>       |                          ^~~~~~~~~~~~~~~
> ./include/linux/huge_mm.h:105:26: note: in expansion of macro 'HPAGE_PMD_ORDER'
>   105 | #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>       |                          ^~~~~~~~~~~~~~~
> mm/page_vma_mapped.c:113:20: note: in expansion of macro 'HPAGE_PMD_NR'
>   113 |         if ((pfn + HPAGE_PMD_NR - 1) < pvmw->pfn)
>       |                    ^~~~~~~~~~~~
> make[1]: *** [scripts/Makefile.build:288: mm/page_vma_mapped.o] Error 1
> make: *** [Makefile:1971: mm] Error 2
>
>
> because check_pmd() uses HPAGE_PMD_NR and
>
> #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>
> I don't immediately see why this patch triggers it...

Maybe the reason is as follows.

The first check_pmd() is wrapped inside `if (pmd_trans_huge(pmde))`
block, since pmd_trans_huge() just returns 0, check_pmd() will be
optimized out.  There is a `if (!thp_migration_supported()) return;` block
before the second check_pmd(), however, thp_migration_supported()
returns 0 on riscv. So the second check_pmd() can be optimized out as
well.  I think I should replace `pmd_leaf` with `pmd_trans_huge() ||
pmd_devmap()`
to fix it.

Thanks.
