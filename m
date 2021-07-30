Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A663DC098
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 23:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhG3V5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 17:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbhG3V5W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 17:57:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE3EC061765;
        Fri, 30 Jul 2021 14:57:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id v21so19354403ejg.1;
        Fri, 30 Jul 2021 14:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrIzY8j2yYLkehrtcval9e6BUzVad0s08f0U7LWpnwA=;
        b=nI2TXFUnbg8oTBLDOaojxF7LCZFdfIXqdTD0uXoPrplSbe36woWGekEaG5hC6WpdLr
         GB/ihzbc5dvZQoFAiam+DvYb5UtGRU+pEo6Pj7madgA0DQKTo9JiWeKHXH9H/XL8OG8l
         QCZHD7ZgaJDRVK+2FjYvn5QQvGsSTfnhIb0sb4csSc6pBs9I+ALu3+VabpGLyZze8+c5
         kMi8QsoRY1Vra/jpmCkBLkKpNo4Od3Dp9QxBlB70LZFl+eDb8Su287SNVfm2nmRJoauM
         JZDdFas6QqqTnJG4Nwq95twzwF1odCyx6WVNzLu2I5UR4yUI1pxMOJPQtNG2BynkUddR
         B2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrIzY8j2yYLkehrtcval9e6BUzVad0s08f0U7LWpnwA=;
        b=dORGOEaSKxTP4JYu4y9yTSlFwdftSFO+XNvFYDO+Y89XY7RgFbI+/4WOmD66lNClGi
         z/aiRywXrQXB5PXGn+oNNgKWDZoHB4qCef7mhGEz5j4j+lRA29L5gbxJUVCxGQj+oF5F
         vynTEpNgjSC7vJCtbKZxMkfaH3ODiRXVG/9ZuRiIdTN8fmDm8SU5om+rZYI+dgeJXKY1
         6ugdHvyz7fFC4F3zOCzLq1aWsD230jRcXhKXIwne/gfgvxN4Ny87vWCr8TszWWIw7DS5
         PX6KDubbQ0eZ1gUi0Sfa0oZqNMAROQ+y1r1S1a/IFWzq858+QuVkMa75hNSVZzNnmACu
         4KyA==
X-Gm-Message-State: AOAM5333BkBICiFdfqB2SkZ5tfp4uq6k7iN1iE2fACterkBS7ULbWVxl
        fcEWHRprjG8wUok1A3lwtcMMDJxN8km95JztGX4=
X-Google-Smtp-Source: ABdhPJwXr19W46p8+tqQaHSrAPmzwbwrcXZjYiiVIis53O6eVmkhtzsp3pu6mqnXDc7pr59/PZtsU65J+yC7blYyNEQ=
X-Received: by 2002:a17:906:c182:: with SMTP id g2mr4713313ejz.507.1627682234854;
 Fri, 30 Jul 2021 14:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com> <a859bb7f-7978-7e3a-eb32-88224cfa50dc@google.com>
In-Reply-To: <a859bb7f-7978-7e3a-eb32-88224cfa50dc@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 30 Jul 2021 14:57:03 -0700
Message-ID: <CAHbLzkqN0L9S3shxU-2PJBeqbKwt4knFN2_Nh-tAcfq=QfLJDw@mail.gmail.com>
Subject: Re: [PATCH 05/16] huge tmpfs: move shmem_huge_enabled() upwards
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

On Fri, Jul 30, 2021 at 12:39 AM Hugh Dickins <hughd@google.com> wrote:
>
> shmem_huge_enabled() is about to be enhanced into shmem_is_huge(),
> so that it can be used more widely throughout: before making functional
> changes, shift it to its final position (to avoid forward declaration).
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/shmem.c | 72 ++++++++++++++++++++++++++----------------------------
>  1 file changed, 35 insertions(+), 37 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index c6fa6f4f2db8..740d48ef1eb5 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -476,6 +476,41 @@ static bool shmem_confirm_swap(struct address_space *mapping,
>
>  static int shmem_huge __read_mostly;
>
> +bool shmem_huge_enabled(struct vm_area_struct *vma)
> +{
> +       struct inode *inode = file_inode(vma->vm_file);
> +       struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> +       loff_t i_size;
> +       pgoff_t off;
> +
> +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> +               return false;
> +       if (shmem_huge == SHMEM_HUGE_FORCE)
> +               return true;
> +       if (shmem_huge == SHMEM_HUGE_DENY)
> +               return false;
> +       switch (sbinfo->huge) {
> +       case SHMEM_HUGE_NEVER:
> +               return false;
> +       case SHMEM_HUGE_ALWAYS:
> +               return true;
> +       case SHMEM_HUGE_WITHIN_SIZE:
> +               off = round_up(vma->vm_pgoff, HPAGE_PMD_NR);
> +               i_size = round_up(i_size_read(inode), PAGE_SIZE);
> +               if (i_size >= HPAGE_PMD_SIZE &&
> +                               i_size >> PAGE_SHIFT >= off)
> +                       return true;
> +               fallthrough;
> +       case SHMEM_HUGE_ADVISE:
> +               /* TODO: implement fadvise() hints */
> +               return (vma->vm_flags & VM_HUGEPAGE);
> +       default:
> +               VM_BUG_ON(1);
> +               return false;
> +       }
> +}
> +
>  #if defined(CONFIG_SYSFS)
>  static int shmem_parse_huge(const char *str)
>  {
> @@ -3995,43 +4030,6 @@ struct kobj_attribute shmem_enabled_attr =
>         __ATTR(shmem_enabled, 0644, shmem_enabled_show, shmem_enabled_store);
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE && CONFIG_SYSFS */
>
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -bool shmem_huge_enabled(struct vm_area_struct *vma)
> -{
> -       struct inode *inode = file_inode(vma->vm_file);
> -       struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> -       loff_t i_size;
> -       pgoff_t off;
> -
> -       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> -           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> -               return false;
> -       if (shmem_huge == SHMEM_HUGE_FORCE)
> -               return true;
> -       if (shmem_huge == SHMEM_HUGE_DENY)
> -               return false;
> -       switch (sbinfo->huge) {
> -               case SHMEM_HUGE_NEVER:
> -                       return false;
> -               case SHMEM_HUGE_ALWAYS:
> -                       return true;
> -               case SHMEM_HUGE_WITHIN_SIZE:
> -                       off = round_up(vma->vm_pgoff, HPAGE_PMD_NR);
> -                       i_size = round_up(i_size_read(inode), PAGE_SIZE);
> -                       if (i_size >= HPAGE_PMD_SIZE &&
> -                                       i_size >> PAGE_SHIFT >= off)
> -                               return true;
> -                       fallthrough;
> -               case SHMEM_HUGE_ADVISE:
> -                       /* TODO: implement fadvise() hints */
> -                       return (vma->vm_flags & VM_HUGEPAGE);
> -               default:
> -                       VM_BUG_ON(1);
> -                       return false;
> -       }
> -}
> -#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> -
>  #else /* !CONFIG_SHMEM */
>
>  /*
> --
> 2.26.2
>
