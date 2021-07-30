Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB643DC1A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jul 2021 01:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbhG3XlN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 19:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhG3XlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 19:41:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C01C06175F;
        Fri, 30 Jul 2021 16:41:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b7so15443986edu.3;
        Fri, 30 Jul 2021 16:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSLUnuuq5fV++9tMx9L7dLU+YzP6IguTmZ4Xmh+94Bg=;
        b=nJKDksbiCLIFAtUQDafEvw8Tzb1I9e/ExJonodW9mAQVo7IJwENFLNXkXhOxQeKsnF
         poz0zfkeaJomNjwwRAtTVImPZ92rp8E3H3CqyHF5VgrqRpilrelaFtxpKdggbwdknlCr
         +frMG9q5tu10/1KIxHyes8BTAmU+QlEfUuJ7sO5JvAx8phaVDZzW5wzyVupRCAacJXNr
         8tyaFCL2nt6rxITYE0xsb5sZ+Hy2cz09YeQZxlkcM0wHwtYgFgMRZMbJKLv2Z6DzZe5m
         cDi/yh4U3O7fgoOk1CIomGbWhRk9XwpRqGI0XGnw7VcJq6oDOZAdFx31F6W6U9IWMDge
         aGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSLUnuuq5fV++9tMx9L7dLU+YzP6IguTmZ4Xmh+94Bg=;
        b=s+uiL59t5wzD51UH+syFsE0X75ihfncp2mVPIPLknL/CgeTqYWuAfG6QqT7iVUhgMR
         5SMsHEoxFRkalz5GNAWqJBulPS82iNQ3GhcrQHGdJTE6xTpA6WkU7hSwpJJ/LelM8gp6
         WtPAvR0/uhW579GWQW6+zLC8YrudWJCylYQhaInfhRA2UsgufLqZMW3Sa2gwQGsOSJn6
         05zV2cYPhwhJsXN5vz3jmAESpmrhnHXtdv0zYreiVbqZbC0zoHJMuCtdLVAXPSUiag0D
         APkfyzAsZhwEQQIRELUSZAxFxb1O2OITtBwpF4aiVgg90ImxwcKEs6swSvqcR8B/YeGJ
         xmfw==
X-Gm-Message-State: AOAM530EbjgnbcuqB8z7J+XZ6uZXSnGu8MytyhLP1U3zASWmPG3qqMRO
        bUcCnYFDu+U91ZzC/TSqf0fv1yil5yxmqiGhSMA=
X-Google-Smtp-Source: ABdhPJxfYN/q50PwtEt3EJiGj5Xb4PpKv5m7TrjWQ6Yme3cRMXL+6f6psAPwR3C5mFjRRECnBjMITxj+5Mu6oUPn4q4=
X-Received: by 2002:a50:ce45:: with SMTP id k5mr6111555edj.168.1627688466110;
 Fri, 30 Jul 2021 16:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com> <e6e572-f314-8a43-41a7-7582759d24@google.com>
In-Reply-To: <e6e572-f314-8a43-41a7-7582759d24@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 30 Jul 2021 16:40:54 -0700
Message-ID: <CAHbLzkp2s+Tkd1kdD4XPU-BF_rDy3Ck7+peTg+WdOWORMjwK-g@mail.gmail.com>
Subject: Re: [PATCH 09/16] huge tmpfs: decide stat.st_blksize by shmem_is_huge()
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

On Fri, Jul 30, 2021 at 12:51 AM Hugh Dickins <hughd@google.com> wrote:
>
> 4.18 commit 89fdcd262fd4 ("mm: shmem: make stat.st_blksize return huge
> page size if THP is on") added is_huge_enabled() to decide st_blksize:
> now that hugeness can be defined per file, that too needs to be replaced
> by shmem_is_huge().
>
> Unless they have been fcntl'ed F_HUGEPAGE, this does give a different
> answer (No) for small files on a "huge=within_size" mount: but that can
> be considered a minor bugfix.  And a different answer (No) for unfcntl'ed
> files on a "huge=advise" mount: I'm reluctant to complicate it, just to
> reproduce the same debatable answer as before.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/shmem.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 67a4b7a4849b..f50f2ede71da 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -712,15 +712,6 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
> -static inline bool is_huge_enabled(struct shmem_sb_info *sbinfo)
> -{
> -       if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> -           (shmem_huge == SHMEM_HUGE_FORCE || sbinfo->huge) &&
> -           shmem_huge != SHMEM_HUGE_DENY)
> -               return true;
> -       return false;
> -}
> -
>  /*
>   * Like add_to_page_cache_locked, but error if expected item has gone.
>   */
> @@ -1101,7 +1092,6 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
>  {
>         struct inode *inode = path->dentry->d_inode;
>         struct shmem_inode_info *info = SHMEM_I(inode);
> -       struct shmem_sb_info *sb_info = SHMEM_SB(inode->i_sb);
>
>         if (info->alloced - info->swapped != inode->i_mapping->nrpages) {
>                 spin_lock_irq(&info->lock);
> @@ -1110,7 +1100,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
>         }
>         generic_fillattr(&init_user_ns, inode, stat);
>
> -       if (is_huge_enabled(sb_info))
> +       if (shmem_is_huge(NULL, inode, 0))
>                 stat->blksize = HPAGE_PMD_SIZE;
>
>         return 0;
> --
> 2.26.2
>
