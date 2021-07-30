Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60F53DC1B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jul 2021 01:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhG3XtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 19:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbhG3XtH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 19:49:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5BAC06175F;
        Fri, 30 Jul 2021 16:49:01 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hs10so11006597ejc.0;
        Fri, 30 Jul 2021 16:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HYPzEhg0/ZZoBcXr9dsUKJdtTAKeNCNJr4RSfiPRVf4=;
        b=KjWLVlYdbMHNyu8daHscO5bjhMTc83ScQQRkQJs51/weY6+MoWT2UXvSdqDCM/s9D1
         7sZ2zbFaVw6CuuBPCKR5xaVMVFCe1w03820ESTI3X8yN/6k1Gjvc/0J1asEopf8Us/SX
         krhGPj0E6Mri/Jszps7QWUjiap5dOdRBytWn5QgyJFsmxGHlR1Bjvzhr/gY8rdwq/thF
         DCIRDltbAeKacc+wNSRLGkjk6Z2MiSTPOed/arRPuxBLl9Q6BK5MYReJHxB8Q7LBVf5n
         Sde7ulBRCOf9ZnW7lkyYr7Ms0Okj+9/UOuA2RFGBMopIxg8TGogaLv26b3kBD+TUw5S2
         RrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HYPzEhg0/ZZoBcXr9dsUKJdtTAKeNCNJr4RSfiPRVf4=;
        b=koFDzdgeJCG6PAVz/caTWFKOCKO3/ieOvNLN1arSR6PL95G99PBVC40QcpTZ05Q0kV
         8LVgTSsFXzNMubiX8DMm1e02ucjLGvH9qAmW2doD4x/6vLnSJq568LaZJ7VVC92/1lYG
         Lyonw9cKFbKXG24EZfbYWwsfgQ2W1bxCSLOrugWcseiXWmnzsfouP689u6i6ndSh6uZO
         FsdFsx1fpwnj09eulmlqk8jtqkxhzB2hXdAGFLQr3KIsBij4l/7GRV4F4rgiKEH1RPxE
         4Hngs0FKjmb+DI0nDDaSxIIVbPZBsQCxWPVsdCDQMANokQRjFmqjxJzb3wwtt9YVccmT
         z8mQ==
X-Gm-Message-State: AOAM531IqZUe18zsEH59oSe3FMzObx/YUqEuumdhCE4kRbVsrvNZ0ttU
        FEx4DdPsgY5E7CiqjyhSOViTbcE59+t32P7zKGE=
X-Google-Smtp-Source: ABdhPJw93gmIwH5JvSsjLc49Q82IxtdtjQ/L//coez2gOyINWwXsAL7oghmfNbipmXkMo9pUyizGY4fmwNGfAuk+zqE=
X-Received: by 2002:a17:906:1f82:: with SMTP id t2mr5105584ejr.499.1627688939706;
 Fri, 30 Jul 2021 16:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com> <f3f6f5e7-6749-7830-5627-a1b6b68dc365@google.com>
In-Reply-To: <f3f6f5e7-6749-7830-5627-a1b6b68dc365@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 30 Jul 2021 16:48:48 -0700
Message-ID: <CAHbLzkosYQGKA5V0DLeBm73wz5GAwxyKiy3KpJzXSpPPrCvM6Q@mail.gmail.com>
Subject: Re: [PATCH 02/16] huge tmpfs: fix split_huge_page() after FALLOC_FL_KEEP_SIZE
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

On Fri, Jul 30, 2021 at 12:28 AM Hugh Dickins <hughd@google.com> wrote:
>
> A successful shmem_fallocate() guarantees that the extent has been
> reserved, even beyond i_size when the FALLOC_FL_KEEP_SIZE flag was used.
> But that guarantee is broken by shmem_unused_huge_shrink()'s attempts to
> split huge pages and free their excess beyond i_size; and by other uses
> of split_huge_page() near i_size.
>
> It's sad to add a shmem inode field just for this, but I did not find a
> better way to keep the guarantee.  A flag to say KEEP_SIZE has been used
> would be cheaper, but I'm averse to unclearable flags.  The fallocend
> field is not perfect either (many disjoint ranges might be fallocated),
> but good enough; and gains another use later on.
>
> Fixes: 779750d20b93 ("shmem: split huge pages beyond i_size under memory pressure")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  include/linux/shmem_fs.h | 13 +++++++++++++
>  mm/huge_memory.c         |  6 ++++--
>  mm/shmem.c               | 15 ++++++++++++++-
>  3 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 8e775ce517bb..9b7f7ac52351 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -18,6 +18,7 @@ struct shmem_inode_info {
>         unsigned long           flags;
>         unsigned long           alloced;        /* data pages alloced to file */
>         unsigned long           swapped;        /* subtotal assigned to swap */
> +       pgoff_t                 fallocend;      /* highest fallocate endindex */
>         struct list_head        shrinklist;     /* shrinkable hpage inodes */
>         struct list_head        swaplist;       /* chain of maybes on swap */
>         struct shared_policy    policy;         /* NUMA memory alloc policy */
> @@ -119,6 +120,18 @@ static inline bool shmem_file(struct file *file)
>         return shmem_mapping(file->f_mapping);
>  }
>
> +/*
> + * If fallocate(FALLOC_FL_KEEP_SIZE) has been used, there may be pages
> + * beyond i_size's notion of EOF, which fallocate has committed to reserving:
> + * which split_huge_page() must therefore not delete.  This use of a single
> + * "fallocend" per inode errs on the side of not deleting a reservation when
> + * in doubt: there are plenty of cases when it preserves unreserved pages.
> + */
> +static inline pgoff_t shmem_fallocend(struct inode *inode, pgoff_t eof)
> +{
> +       return max(eof, SHMEM_I(inode)->fallocend);
> +}
> +
>  extern bool shmem_charge(struct inode *inode, long pages);
>  extern void shmem_uncharge(struct inode *inode, long pages);
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index afff3ac87067..890fb73ac89b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2454,11 +2454,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>
>         for (i = nr - 1; i >= 1; i--) {
>                 __split_huge_page_tail(head, i, lruvec, list);
> -               /* Some pages can be beyond i_size: drop them from page cache */
> +               /* Some pages can be beyond EOF: drop them from page cache */
>                 if (head[i].index >= end) {
>                         ClearPageDirty(head + i);
>                         __delete_from_page_cache(head + i, NULL);
> -                       if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
> +                       if (shmem_mapping(head->mapping))
>                                 shmem_uncharge(head->mapping->host, 1);
>                         put_page(head + i);
>                 } else if (!PageAnon(page)) {
> @@ -2686,6 +2686,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>                  * head page lock is good enough to serialize the trimming.
>                  */
>                 end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
> +               if (shmem_mapping(mapping))
> +                       end = shmem_fallocend(mapping->host, end);
>         }
>
>         /*
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0cd5c9156457..24c9da6b41c2 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -905,6 +905,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>         if (lend == -1)
>                 end = -1;       /* unsigned, so actually very big */
>
> +       if (info->fallocend > start && info->fallocend <= end && !unfalloc)
> +               info->fallocend = start;
> +
>         pagevec_init(&pvec);
>         index = start;
>         while (index < end && find_lock_entries(mapping, index, end - 1,
> @@ -2667,7 +2670,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>         struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
>         struct shmem_inode_info *info = SHMEM_I(inode);
>         struct shmem_falloc shmem_falloc;
> -       pgoff_t start, index, end;
> +       pgoff_t start, index, end, undo_fallocend;
>         int error;
>
>         if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
> @@ -2736,6 +2739,15 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>         inode->i_private = &shmem_falloc;
>         spin_unlock(&inode->i_lock);
>
> +       /*
> +        * info->fallocend is only relevant when huge pages might be
> +        * involved: to prevent split_huge_page() freeing fallocated
> +        * pages when FALLOC_FL_KEEP_SIZE committed beyond i_size.
> +        */
> +       undo_fallocend = info->fallocend;
> +       if (info->fallocend < end)
> +               info->fallocend = end;
> +
>         for (index = start; index < end; ) {
>                 struct page *page;
>
> @@ -2750,6 +2762,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>                 else
>                         error = shmem_getpage(inode, index, &page, SGP_FALLOC);
>                 if (error) {
> +                       info->fallocend = undo_fallocend;
>                         /* Remove the !PageUptodate pages we added */
>                         if (index > start) {
>                                 shmem_undo_range(inode,
> --
> 2.26.2
>
