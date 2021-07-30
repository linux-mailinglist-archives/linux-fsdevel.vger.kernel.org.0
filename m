Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61A23DC04F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 23:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhG3Vgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 17:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhG3Vgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 17:36:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965C9C061765;
        Fri, 30 Jul 2021 14:36:41 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id x11so18298984ejj.8;
        Fri, 30 Jul 2021 14:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BHRdpHzssosN281+yG++IdMiDGzijOSqxARWz3dit88=;
        b=aui1RaBDIevJde/b4U2A9KW2i7OSym58Ljf37Yt407gYsdr3UjgRvhVyxXb49AHR0s
         xvaH5NuuZufzFD/u3Gu/jceTu4lKxySYb9rUqS/XcaP8+HyfRg5Vzkxi4V4Zmm3uec48
         sIZDw+1sSU/dg/+T5CPNsEk6dBZgZDsw6iiyeNCYPI6XLlRiNM1fhqENpY2FN7Tjq2od
         /E+HHKVELqMJ5eI3JxZFsaLxtQMbu/ScZcVeBBxLwV1Z9pVDDX/5fR+lExNNOTTwAv8B
         QT08FB6ZVSIlJS30Gx/G5P3maeOX/MIEBBkPbqbpsKxDz+oUhxn0qTAeF2vJ6qM1kdT2
         4n9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHRdpHzssosN281+yG++IdMiDGzijOSqxARWz3dit88=;
        b=IhQfwlUsE3ZOLjdaLCLwVsq/IXwk2ORzm2DVQgDjhmdfq7R1m9KqzwQiBqaXpBFUBH
         HOYVQQPJ7gVp72clS3FmM8dMWrp0jz35bmuBcYnEvNToVxL/LjK5cxCObVH1qk9HaOWH
         brZeqd+tnz4IYGk9bH2BpV1HZKOmvCJLwtwiT+6saIltq316zEKU+wq5Ovuyqpm7+p3g
         cNyjEhgD1wW4grj8g7Q+BEoijejHUd+OZA3dOS6sqBLPYNtpenc60vW8HjM8/2jfzk6d
         ZyjRePF5X+gagrjBQGtOQhrcjdBP1kFtRTg3CkO0fV77SZk2Tv08k9mtTsiNn6vZdq2c
         qzqQ==
X-Gm-Message-State: AOAM531PFHyRVnU5kxkP8nbG3pfV9IYTnUfSZOs5GstsRtEWAmSUqaSk
        WcBzSszwBRfMc0pakFr1ojCcwCzmajZnP8uXIPU=
X-Google-Smtp-Source: ABdhPJy9R4i42eTcls1i9Y/2WZAQ0xCIG6g3TtP09aeUVBKpq+6WOSbADUykf66Emajn0U1oncUepgaehqmCD4oyJsg=
X-Received: by 2002:a17:906:1919:: with SMTP id a25mr4722791eje.161.1627681000237;
 Fri, 30 Jul 2021 14:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com> <af71608e-ecc-af95-3511-1a62cbf8d751@google.com>
In-Reply-To: <af71608e-ecc-af95-3511-1a62cbf8d751@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 30 Jul 2021 14:36:28 -0700
Message-ID: <CAHbLzkqp5-SrOBkpvxieswD6OwPT70gsztNpXCTBXW2JnrFpfg@mail.gmail.com>
Subject: Re: [PATCH 01/16] huge tmpfs: fix fallocate(vanilla) advance over
 huge pages
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

On Fri, Jul 30, 2021 at 12:25 AM Hugh Dickins <hughd@google.com> wrote:
>
> shmem_fallocate() goes to a lot of trouble to leave its newly allocated
> pages !Uptodate, partly to identify and undo them on failure, partly to
> leave the overhead of clearing them until later.  But the huge page case
> did not skip to the end of the extent, walked through the tail pages one
> by one, and appeared to work just fine: but in doing so, cleared and
> Uptodated the huge page, so there was no way to undo it on failure.
>
> Now advance immediately to the end of the huge extent, with a comment on
> why this is more than just an optimization.  But although this speeds up
> huge tmpfs fallocation, it does leave the clearing until first use, and
> some users may have come to appreciate slow fallocate but fast first use:
> if they complain, then we can consider adding a pass to clear at the end.
>
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

A nit below:

> ---
>  mm/shmem.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 70d9ce294bb4..0cd5c9156457 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2736,7 +2736,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>         inode->i_private = &shmem_falloc;
>         spin_unlock(&inode->i_lock);
>
> -       for (index = start; index < end; index++) {
> +       for (index = start; index < end; ) {
>                 struct page *page;
>
>                 /*
> @@ -2759,13 +2759,26 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>                         goto undone;
>                 }
>
> +               index++;
> +               /*
> +                * Here is a more important optimization than it appears:
> +                * a second SGP_FALLOC on the same huge page will clear it,
> +                * making it PageUptodate and un-undoable if we fail later.
> +                */
> +               if (PageTransCompound(page)) {
> +                       index = round_up(index, HPAGE_PMD_NR);
> +                       /* Beware 32-bit wraparound */
> +                       if (!index)
> +                               index--;
> +               }
> +
>                 /*
>                  * Inform shmem_writepage() how far we have reached.
>                  * No need for lock or barrier: we have the page lock.
>                  */
> -               shmem_falloc.next++;
>                 if (!PageUptodate(page))
> -                       shmem_falloc.nr_falloced++;
> +                       shmem_falloc.nr_falloced += index - shmem_falloc.next;
> +               shmem_falloc.next = index;

This also fixed the wrong accounting of nr_falloced, so it should be
able to avoid returning -ENOMEM prematurely IIUC. Is it worth
mentioning in the commit log?

>
>                 /*
>                  * If !PageUptodate, leave it that way so that freeable pages
> --
> 2.26.2
>
