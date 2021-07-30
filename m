Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854C93DC06B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 23:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhG3VvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 17:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhG3VvR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 17:51:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2761DC06175F;
        Fri, 30 Jul 2021 14:51:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id nd39so19298211ejc.5;
        Fri, 30 Jul 2021 14:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALuer+FidfIoua3TUSD8gX2hS4i01XLeemyyVEmMoQc=;
        b=mqVuNenWLGsGEestEyn1VFsrzeMOzP2lqyROg7AXmeoUVCaf6TFWK0BzzfuDLeM8zF
         jrmLd/hIp0m+ic8y82kCwAN0lqF4BBb2R0/TfRuZAMIj75G3qjAMcNI/bmIg3r+iEPAA
         zvlmNMBIbCR9gdYmAXk6vjnxw1Qc7zKeYuh+ou6PBz3PX+ICXhcc6+qSBDL10VuMZoMv
         gO3hy/DQALNsneH7xBudPFMdVe9/kKHac5rsioR4L9rqOdjI/yqHZWh/kci6xACpbJZ7
         Oo5wYVhKkHGi6U3QOU2L3BWo8w2xFyhzX3/Vs+5Z/QywaGRQ/qTIwDX6tFPufDV2UvHe
         Jo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALuer+FidfIoua3TUSD8gX2hS4i01XLeemyyVEmMoQc=;
        b=WXckuOeVbUU0c/Uxmtaby0Jj1Xenjfmzc1NsDUXTDdCpepuI9nBElnc45X23J7nkGV
         4B5rnj7E3APvASn84BARp6fUnsnt/RDVokwhNdErKen0NCdREItEaCHiZss4w7VJeb/r
         B41+Ypu/OyJiYIWZTzSUUJfYgUXjA7NZSmWDpEqDS6YwHqoVAE0RcSnpAcLrkoyoiKBP
         GYiRgq7l4/9I3J3lVu7m5Lrt99Ot3dTz0phwnjGIumEbBaW8k3cSbCopxWO1rDbSxx6r
         T+sO3WLdVF1tw97p9TCBYiM6Y2DwhAaJzFUe3kx+PL5gFBjKC5tDzz5A6fikCXOyMvT7
         xwyg==
X-Gm-Message-State: AOAM5318rp/ej8NAg1t64A+2dubB868JqnqLPwAJfUKH8ZpyxuZbwQcT
        uZtQSYlAEPeAsxAFuUUPMzzlTn7RaAMVX5VsX2o=
X-Google-Smtp-Source: ABdhPJw21kECf87JDJrKuLPPTCnErY9hdTNVhtt2vxlhdDQkryswZ+3LZtsPd3/QdyTUiF1AXes0gf1b7z2RCq/IpB0=
X-Received: by 2002:a17:906:fc0b:: with SMTP id ov11mr1436950ejb.238.1627681870825;
 Fri, 30 Jul 2021 14:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com> <42353193-6896-aa85-9127-78881d5fef66@google.com>
In-Reply-To: <42353193-6896-aa85-9127-78881d5fef66@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 30 Jul 2021 14:50:58 -0700
Message-ID: <CAHbLzkp9UQ9bb4gMN-BtrSHY3uet+nSxN-wMaObrtp5yhSN5Sw@mail.gmail.com>
Subject: Re: [PATCH 03/16] huge tmpfs: remove shrinklist addition from shmem_setattr()
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

On Fri, Jul 30, 2021 at 12:31 AM Hugh Dickins <hughd@google.com> wrote:
>
> There's a block of code in shmem_setattr() to add the inode to
> shmem_unused_huge_shrink()'s shrinklist when lowering i_size: it dates
> from before 5.7 changed truncation to do split_huge_page() for itself,
> and should have been removed at that time.
>
> I am over-stating that: split_huge_page() can fail (notably if there's
> an extra reference to the page at that time), so there might be value in
> retrying.  But there were already retries as truncation worked through
> the tails, and this addition risks repeating unsuccessful retries
> indefinitely: I'd rather remove it now, and work on reducing the
> chance of split_huge_page() failures separately, if we need to.

Yes, agreed. Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Fixes: 71725ed10c40 ("mm: huge tmpfs: try to split_huge_page() when punching hole")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/shmem.c | 19 -------------------
>  1 file changed, 19 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 24c9da6b41c2..ce3ccaac54d6 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1061,7 +1061,6 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
>  {
>         struct inode *inode = d_inode(dentry);
>         struct shmem_inode_info *info = SHMEM_I(inode);
> -       struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
>         int error;
>
>         error = setattr_prepare(&init_user_ns, dentry, attr);
> @@ -1097,24 +1096,6 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
>                         if (oldsize > holebegin)
>                                 unmap_mapping_range(inode->i_mapping,
>                                                         holebegin, 0, 1);
> -
> -                       /*
> -                        * Part of the huge page can be beyond i_size: subject
> -                        * to shrink under memory pressure.
> -                        */
> -                       if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> -                               spin_lock(&sbinfo->shrinklist_lock);
> -                               /*
> -                                * _careful to defend against unlocked access to
> -                                * ->shrink_list in shmem_unused_huge_shrink()
> -                                */
> -                               if (list_empty_careful(&info->shrinklist)) {
> -                                       list_add_tail(&info->shrinklist,
> -                                                       &sbinfo->shrinklist);
> -                                       sbinfo->shrinklist_len++;
> -                               }
> -                               spin_unlock(&sbinfo->shrinklist_lock);
> -                       }
>                 }
>         }
>
> --
> 2.26.2
>
