Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CFF4DDFFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 18:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbiCRRd0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 13:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiCRRd0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:33:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE27CF488;
        Fri, 18 Mar 2022 10:32:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so5106776pjm.0;
        Fri, 18 Mar 2022 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2+7TjxCz/iJePRyFbqQRLmhTrxcszamkFrqGEeq6RE=;
        b=j6rdW0vl3K3sGSkYu5w7VUoJZJZvYdcycVs5qyXdXGtGv/mX1pV1rkvC+ckVdBL/Ts
         wvoc0z+Ja9EpA3+aKl1DVOsCRjgJKx36A8CareMJUtbIejvnh7zRR1RHLrb6JRUsAhRx
         y0XUYRpUFdMt12mg3Z5uz8Lg5USvnTqhJt5vEWr6o+HZ9irOkyy/DovkNM2SbrQ1JX8M
         Lna+vYwAd0Rq7IOpPk7i0MgBEJKL+nnQ3bg5tkxA+RaNMuaObzgsjcFqQ5RukRiVwvzQ
         sgIGO2lunB2ZEKsPV6TA44T15jtdf435vfQTo3DmA/yN/XVMy6OnkbkfkFbbTdP8O2J1
         lxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2+7TjxCz/iJePRyFbqQRLmhTrxcszamkFrqGEeq6RE=;
        b=rAqSx1OpdliI+/3Ggpnvvu+8EBfz/QJles4EcDHQIwfl7xpPsyZkYSXY5B+SHY/6Kx
         UbVuwFFXqcy2fmuAhUYMwAKGuDeZrvVFE4ZTm3HILzfqmprI4glPh6UItql8DzHU5zFR
         v1gXmCXGSdChCMhvIHm3s3kqhRrxs8giNwAOptOwbIVmA3u0WfyMhNA20cbWDp8+eGM4
         pK/jkY/VRHiTqwmf9Wq39vv7fw8ut49GR0ScRdkPTArBLjlRA8WI677irim+7+qX+a5+
         t9SsC8MEuDVheFSTxLf2tsApBiSJnXFAN2wazMQLqbmhBib+W1q0l8uL0gsyURdQjYqJ
         MqPQ==
X-Gm-Message-State: AOAM530RLxARBvL1j5k/uhnP28aM+XhH7tvhDbm1Od0HaKE8I+qTKnMj
        9jXBv+ulDC47BkF5tVxhyTiGAeY2MsLHc7S10nk=
X-Google-Smtp-Source: ABdhPJyh5sar5ek5GT9YTEP77ixsCcilYxYkIste3RuLag/BYsrgSRi1slJnriJ+u/pf99Z+trolDxeILv7BgoSjLmA=
X-Received: by 2002:a17:90a:3906:b0:1bf:a0a6:d208 with SMTP id
 y6-20020a17090a390600b001bfa0a6d208mr22604556pjb.21.1647624726981; Fri, 18
 Mar 2022 10:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220317234827.447799-1-shy828301@gmail.com> <20220318012948.GE1544202@dread.disaster.area>
In-Reply-To: <20220318012948.GE1544202@dread.disaster.area>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 18 Mar 2022 10:31:55 -0700
Message-ID: <CAHbLzkpFch0+=XorZXpaqvFb=_OXdn4ZsjOLhWg1EJpMZNaM0A@mail.gmail.com>
Subject: Re: [v2 PATCH 0/8] Make khugepaged collapse readonly FS THP more consistent
To:     Dave Chinner <david@fromorbit.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Mar 17, 2022 at 6:29 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Mar 17, 2022 at 04:48:19PM -0700, Yang Shi wrote:
> >
> > Changelog
> > v2: * Collected reviewed-by tags from Miaohe Lin.
> >     * Fixed build error for patch 4/8.
> >
> > The readonly FS THP relies on khugepaged to collapse THP for suitable
> > vmas.  But it is kind of "random luck" for khugepaged to see the
> > readonly FS vmas (see report: https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/) since currently the vmas are registered to khugepaged when:
> >   - Anon huge pmd page fault
> >   - VMA merge
> >   - MADV_HUGEPAGE
> >   - Shmem mmap
> >
> > If the above conditions are not met, even though khugepaged is enabled
> > it won't see readonly FS vmas at all.  MADV_HUGEPAGE could be specified
> > explicitly to tell khugepaged to collapse this area, but when khugepaged
> > mode is "always" it should scan suitable vmas as long as VM_NOHUGEPAGE
> > is not set.
> >
> > So make sure readonly FS vmas are registered to khugepaged to make the
> > behavior more consistent.
> >
> > Registering the vmas in mmap path seems more preferred from performance
> > point of view since page fault path is definitely hot path.
> >
> >
> > The patch 1 ~ 7 are minor bug fixes, clean up and preparation patches.
> > The patch 8 converts ext4 and xfs.  We may need convert more filesystems,
> > but I'd like to hear some comments before doing that.
>
> After reading through the patchset, I have no idea what this is even
> doing or enabling. I can't comment on the last patch and it's effect
> on XFS because there's no high level explanation of the
> functionality or feature to provide me with the context in which I
> should be reviewing this patchset.
>
> I understand this has something to do with hugepages, but there's no
> explaination of exactly where huge pages are going to be used in the
> filesystem, what the problems with khugepaged and filesystems are
> that this apparently solves, what constraints it places on
> filesystems to enable huge pages to be used, etc.
>
> I'm guessing that the result is that we'll suddenly see huge pages
> in the page cache for some undefined set of files in some undefined
> set of workloads. But that doesn't help me understand any of the
> impacts it may have. e.g:

Song introduced READ_ONLY_THP_FOR_FS back in 2019. It collapses huge
pages for readonly executable file mappings to speed up the programs
with huge text section. The huge page is allocated/collapsed by
khugepaged instead of in page fault path.

Vlastimil reported the huge pages are not collapsed consistently since
the suitable MMs were not registered by khugepaged consistently as the
commit log elaborated. So this patchset makes the behavior of
khugepaged (for collapsing readonly file THP) more consistent.

>
> - how does this relate to the folio conversion and use of large
>   pages in the page cache?
> - why do we want two completely separate large page mechanisms in
>   the page cache?

It has nothing to do with the folio conversion. But once the file
THP/huge page is fully supported, the READ_ONLY_THP_FOR_FS may be
deprecated. However, making khugepaged collapse file THP more
consistently is applicable to full file huge page support as well as
long as we still use khugepaged to collapse THP.

> - why is this limited to "read only VMAs" and how does the
>   filesystem actually ensure that the VMAs are read only?

It uses the below check:

(IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) &&
               (vma->vm_flags & VM_EXEC) &&
               !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);

This condition was introduced by READ_ONLY_THP_FOR_FS in the first
place, not this patchset.

> - what happens if we have a file that huge pages mapped into the
>   page cache via read only VMAs then has write() called on it via a
>   different file descriptor and so we need to dirty the page cache
>   that has huge pages in it?

Once someone else opens the fd in write mode, the THP will be
truncated and khugepaged will backoff IIUC.

>
> I've got a lot more questions, but to save me having to ask them,
> how about you explain what this new functionality actually does, why
> we need to support it, and why it is better than the fully writeable
> huge page support via folios that we already have in the works...
>
> Cheers,
>
> Dave.
>
> --
> Dave Chinner
> david@fromorbit.com
