Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0723DE0C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 22:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhHBUjZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 16:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhHBUjY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 16:39:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B20C06175F;
        Mon,  2 Aug 2021 13:39:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id go31so32833195ejc.6;
        Mon, 02 Aug 2021 13:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+1ZVGdug029BKztuBflcFM502/rjs3mo1eYtrMifDk=;
        b=WpqW6gbPXWmSXSnBXN8wuQVcUZ5E+920VtDCBI9sJOXAr5tN2Vf5zVNcGKewIC7PYJ
         1gM06RAbNtITBSUxFkYEWFDPQsnfX3ekTklSXHkCXyK/p1X8Mk9fXWBdHarsIreOLC6l
         J+4ji/fyHzEfPW+YKKlN/ZKuW0fUwUeqdBWZSNtLgQAQRIfwvu2llBdvR/ZYKE/ceJAD
         RC/VI9WxFcMwJzOrdM/OFO/+917WZhOuglpb6YRteH3Lug//OW1e/NjbrvZM5VtieJ//
         vm/OR6HsSi8MJSY/qaoXsXKrjm6v6usut/5pspJ/pDZKmiFbOc8Okx9F8wg8KJJEFh/m
         nDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+1ZVGdug029BKztuBflcFM502/rjs3mo1eYtrMifDk=;
        b=kxTaYwZ3LntMSJPcc6FJUGY+LfNrfyhemc+5xREc3uY72gkZTXt7ZhWVMhhM7pbrLI
         EAzep19qEC177pdrNTB+JD4tImThOXlLBG/iiQgURJmLMWVaard5qgfHR8QrR5tZBg9B
         yCdzFwQJqdDYyrBn2Zox15UiYtExLvRbdkEOn+fbZaa8gDPg7W6RTMyc9K6d4KxkAftz
         oYyt3qO1HCGEoIIxd3sq8RhKZHnf0QVr4M19JZ2t8fB5HftoMdz0IVTN3NbjCQdzyzSS
         0hO16u/VJ3ys7SCR6RxMW9ioO2iTuK6Fb8LB3Hrlvygrw+c6/GpdX2wmNLdHNWYhY8pi
         lqBg==
X-Gm-Message-State: AOAM533xe3SwiII1QqTzvy0qUe6D93qVa5m/LYyQ/WkxAFYqWGWphQk9
        m0M9aITTiuKq8/yY8D9cH8sjeeDizOhncnZaArk=
X-Google-Smtp-Source: ABdhPJz+bFqjk8VaBnBWuFFdFQPRqIUBKPTB9RbWFhRR+y+f3gJt5VIBShRoOFUv/tXM63FGpUHBOjlGJ6nvf3KArRs=
X-Received: by 2002:a17:906:1f82:: with SMTP id t2mr16945837ejr.499.1627936752631;
 Mon, 02 Aug 2021 13:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
 <b44e3619-712e-90af-89d2-e4ba654c5110@google.com> <CAHbLzko5oU_1X=M1LFr=4hNDvs0BF0UY+_8e0RHMhUqspMHV3Q@mail.gmail.com>
 <55526ab1-4280-9538-51d7-6669b8a97f@google.com>
In-Reply-To: <55526ab1-4280-9538-51d7-6669b8a97f@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 2 Aug 2021 13:39:00 -0700
Message-ID: <CAHbLzkqTHcXqxUYzu98Ea_EzEaQ+eLPDmgyoSQEcC3MoEqchmg@mail.gmail.com>
Subject: Re: [PATCH 04/16] huge tmpfs: revert shmem's use of transhuge_vma_enabled()
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 31, 2021 at 9:01 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Fri, 30 Jul 2021, Yang Shi wrote:
> > On Fri, Jul 30, 2021 at 12:36 AM Hugh Dickins <hughd@google.com> wrote:
> > >
> > > 5.14 commit e6be37b2e7bd ("mm/huge_memory.c: add missing read-only THP
> > > checking in transparent_hugepage_enabled()") added transhuge_vma_enabled()
> > > as a wrapper for two very different checks: shmem_huge_enabled() prefers
> > > to show those two checks explicitly, as before.
> >
> > Basically I have no objection to separating them again. But IMHO they
> > seem not very different. Or just makes things easier for the following
> > patches?
>
> Well, it made it easier to apply the patch I'd prepared earlier,
> but that was not the point; and I thought it best to be upfront
> about the reversion, rather than hiding it in the movement.
>
> The end result of the two checks is the same (don't try for huge pages),
> and they have been grouped together because they occurred together in
> several places, and both rely on "vma".
>
> But one check is whether the app has marked that address range not to use
> THPs; and the other check is whether the process is running in a hierarchy
> that has been marked never to use THPs (which just uses vma to get to mm
> to get to mm->flags (whether current->mm would be more relevant is not an
> argument I want to get into, I'm not at all sure)).
>
> To me those are very different; and I'm particularly concerned to make
> MMF_DISABLE_THP references visible, since it did not exist when Kirill
> and I first implemented shmem huge pages, and I've tended to forget it:
> but consider it more in this series.

Yes, I agree one checks vma the other one checks mm, they are
different from this perspective. Anyway, as I said I have no objection
to this change. You could add Reviewed-by: Yang Shi
<shy828301@gmail.com>

>
> Hugh
>
> >
> > >
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > ---
> > >  mm/shmem.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index ce3ccaac54d6..c6fa6f4f2db8 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -4003,7 +4003,8 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
> > >         loff_t i_size;
> > >         pgoff_t off;
> > >
> > > -       if (!transhuge_vma_enabled(vma, vma->vm_flags))
> > > +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> > > +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> > >                 return false;
> > >         if (shmem_huge == SHMEM_HUGE_FORCE)
> > >                 return true;
> > > --
> > > 2.26.2
