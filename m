Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EE44CADC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 19:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244241AbiCBSo2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 13:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiCBSo2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:44:28 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5AFCA0ED;
        Wed,  2 Mar 2022 10:43:44 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a23so5656047eju.3;
        Wed, 02 Mar 2022 10:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYacYFBXciHmpzBVvSdoS7PTXsJUtBNkCcTgWfD2hXg=;
        b=IirjpbFJTyj19jcvRBrG6M2PJAxHcjEHQfbNn3mOZadb1e1ccHA/LRrHk1rksJpt35
         MMt2dm7wSSrSlQQTxI44MM0nypv3syVFTI5nsJPKjrZqprWNhtUpFBqSmN7jueiuRM9O
         nM1/br4YMIBeEaR/nknarhnm2LTZnxp8rxb9jOgLVboCFtdMZok9gz9GuCPYUoA0jX+N
         IcsILGgEFTzGaOtAw+W4jNLvqf2OCbQ2R+153snnJ8Ltdo/8MshR/5j02p+VlkM+E33r
         J0KpTmjs0vzUF2pWRa2+W654eN+vr/n+pXKZMBNudNlOAfIqSM9ZhZzjnl51p3wTxGZy
         tlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYacYFBXciHmpzBVvSdoS7PTXsJUtBNkCcTgWfD2hXg=;
        b=TkHI2XU/n8ywJ8R+ZT3MFLG/e4zro/gZaQ5EBVMaYvr8mdDPfUx1iFhlRZqx70+B+D
         5ZRTLb2vNR9xUeCY4gz8ruxsWDQkANC+Fk9DRS/XSspZU1DUqJbbwrq/Gu4VlA7iuzUd
         KU5xWEzlNMAmQ5g8NySLtIuWXCoq6abLglAh2Z8h3aM9T/w5x3EuRx4erESza+6IESjF
         50+uZkGLIIoz8iHKbmMJ+PAOK2bPSfDBX+GUv8wA9IZVEZFQozJCB/MMo8DS8yQHRmh8
         ZLg/l0kSaLC7CG9cCGLqeCh492UjCKOhuy9Q31vDUp8ohWZujXGa66U7iU4YFgM2VKnO
         n0ZA==
X-Gm-Message-State: AOAM532SiP/XTfom5//6ANSxs8C0bl/OgCqo6uVplzYu5GSuwoyj6gNg
        8hwLFCQCRY/k1YisdJmp4kaVTO2g5f+wHpQb+98=
X-Google-Smtp-Source: ABdhPJyuYRtx7NDrJEc4gq8pmV8JxkyEHirpVjET0jmaEbM8g2xi3VgPWfm3DCWICSOT7fYRWup0wjnZgNE081ucq84=
X-Received: by 2002:a17:906:e28a:b0:6d6:e2e9:d39d with SMTP id
 gg10-20020a170906e28a00b006d6e2e9d39dmr8101292ejb.2.1646246622894; Wed, 02
 Mar 2022 10:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20220228235741.102941-1-shy828301@gmail.com> <20220228235741.102941-3-shy828301@gmail.com>
 <968ccc31-a87c-4657-7193-464f6b5b9259@huawei.com>
In-Reply-To: <968ccc31-a87c-4657-7193-464f6b5b9259@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 2 Mar 2022 10:43:31 -0800
Message-ID: <CAHbLzkqNq_H6Cdwzd-3VazsQbEz=ZUFU60ec+Py8w3nhx7E5pw@mail.gmail.com>
Subject: Re: [PATCH 2/8] mm: khugepaged: remove redundant check for VM_NO_KHUGEPAGED
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        darrick.wong@oracle.com
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

On Tue, Mar 1, 2022 at 1:07 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/3/1 7:57, Yang Shi wrote:
> > The hugepage_vma_check() called by khugepaged_enter_vma_merge() does
> > check VM_NO_KHUGEPAGED. Remove the check from caller and move the check
> > in hugepage_vma_check() up.
> >
> > More checks may be run for VM_NO_KHUGEPAGED vmas, but MADV_HUGEPAGE is
> > definitely not a hot path, so cleaner code does outweigh.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/khugepaged.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 131492fd1148..82c71c6da9ce 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -366,8 +366,7 @@ int hugepage_madvise(struct vm_area_struct *vma,
> >                * register it here without waiting a page fault that
> >                * may not happen any time soon.
> >                */
> > -             if (!(*vm_flags & VM_NO_KHUGEPAGED) &&
> > -                             khugepaged_enter_vma_merge(vma, *vm_flags))
> > +             if (khugepaged_enter_vma_merge(vma, *vm_flags))
> >                       return -ENOMEM;
> >               break;
> >       case MADV_NOHUGEPAGE:
> > @@ -446,6 +445,9 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
> >       if (!transhuge_vma_enabled(vma, vm_flags))
> >               return false;
> >
> > +     if (vm_flags & VM_NO_KHUGEPAGED)
> > +             return false;
> > +
>
> This patch does improve the readability. But I have a question.
> It seems VM_NO_KHUGEPAGED is not checked in the below if-condition:
>
>         /* Only regular file is valid */
>         if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
>             (vm_flags & VM_EXEC)) {
>                 struct inode *inode = vma->vm_file->f_inode;
>
>                 return !inode_is_open_for_write(inode) &&
>                         S_ISREG(inode->i_mode);
>         }
>
> If we return false due to VM_NO_KHUGEPAGED here, it seems it will affect the
> return value of this CONFIG_READ_ONLY_THP_FOR_FS condition check.
> Or am I miss something?

Yes, it will return false instead of true if that file THP check is
true, but wasn't that old behavior actually problematic? Khugepaged
definitely can't collapse VM_NO_KHUGEPAGED vmas even though it
satisfies all the readonly file THP checks. With the old behavior
khugepaged may scan an exec file hugetlb vma IIUC although it will
fail later due to other page sanity checks, i.e. page compound check.

>
> Thanks.
>
> >       if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
> >                               vma->vm_pgoff, HPAGE_PMD_NR))
> >               return false;
> > @@ -471,7 +473,8 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
> >               return false;
> >       if (vma_is_temporary_stack(vma))
> >               return false;
> > -     return !(vm_flags & VM_NO_KHUGEPAGED);
> > +
> > +     return true;
> >  }
> >
> >  int __khugepaged_enter(struct mm_struct *mm)
> >
>
>
