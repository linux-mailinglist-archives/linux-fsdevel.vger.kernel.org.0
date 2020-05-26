Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F7D1E3187
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 23:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389452AbgEZVyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 17:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389025AbgEZVyQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 17:54:16 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C49C061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 14:54:16 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 1so12676221vsl.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0jK21EhVqfBvbPITLkn+96MTGZW6Bo0ptE3mNnDRD3A=;
        b=VJFY+sE6R0lEkr2FcepjY3oBdZps0iISn6dQY5y2gFvrCz2MSn+lg0Aw+uDaS/9/K0
         +fZwAZx9BypRwHJ5b5N2BEeEZyeipRgosXa0XlUo9pjdLYPG1fSAaMdUk96eMjNpibvN
         sDrOL4pEyDyi4h6gTIgKVUwNpMNz18HQr7oWqcjlAzA/rZPn1wFrocCdJe7W0BrPJnJK
         oEgCcRj6+GWXgVuL8ADPu1yXjAz7mj+yFngENH/Jcq0haWcO11IshEC4nog2VKbuUApP
         6D8BcyICqXQJE8snuXfTXHHUKWTlc3Ac3y1G2MKe2ow4emUmUJRcYUjMrC973SHCcKXr
         QCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jK21EhVqfBvbPITLkn+96MTGZW6Bo0ptE3mNnDRD3A=;
        b=HIJui1BjGGzx99HQGVOT3Zx8MNYm7DZ1omJRUWHlFicXAtRnaKS+VCFctB2KndkUWm
         JNsPgmOdF2LTJlpSLE3uhSV7HHSnirFC5MtB1IzcBg9NVGb2XSswnLVXAH0CuA6WPaO6
         hN1uROWgzdzfXaukUSDoqwhJZygOtgo07nSYUXbuWK/rN64BLe5bQHfMMikz7KTcrgaL
         ubDS6/eUf1TNg+2kJUoQxtIwJy5igupeWp7WQjGArNFGCqpFga/gfKKJQwNdSIFj1INf
         5pnTP1H3mTo/PJGy1gRQhWdJm6BRug7ClAlOJz3tXtLaislldys1h/bR/sEE85SAHz+n
         M74A==
X-Gm-Message-State: AOAM530Ni2sDNZ1YrMhizLmtoxR4r3EX2oXj9Wg8bcEenbMHq8Va3Xsc
        Veu8jKVQ6+uGHq6JCFzeJ7za6EKPrpN2fkipxRjDXA==
X-Google-Smtp-Source: ABdhPJzzaoMzy16lHwO6Cit4whNo24TT0SRB502FPqok9VsYLq5zk1Uuoxa+iC0FlPfnq33B0P3WZwccZGYkEDw15oU=
X-Received: by 2002:a05:6102:20cb:: with SMTP id i11mr2618905vsr.137.1590530055726;
 Tue, 26 May 2020 14:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com> <20200517214718.468-9-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20200517214718.468-9-guoqing.jiang@cloud.ionos.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Tue, 26 May 2020 17:54:04 -0400
Message-ID: <CAOg9mSQ+nGCD-k2OwWWd6Ze_PAh3mhSOwYcLugD-SQHCb0ymWw@mail.gmail.com>
Subject: Re: [PATCH 08/10] orangefs: use attach/detach_page_private
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I apologize for not mentioning that I ran this patch set
through orangefs xfstests at 5.7 rc5 with no problems
or regressions.

-Mike


On Sun, May 17, 2020 at 5:47 PM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> Since the new pair function is introduced, we can call them to clean the
> code in orangefs.
>
> Cc: Mike Marshall <hubcap@omnibond.com>
> Cc: Martin Brandenburg <martin@omnibond.com>
> Cc: devel@lists.orangefs.org
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
> No change since RFC V3.
>
> RFC V2 -> RFC V3
> 1. rename clear_page_private to detach_page_private.
>
> RFC -> RFC V2
> 1. change the name of new functions to attach/clear_page_private.
> 2. avoid potential use-after-free as suggested by Dave Chinner.
>
>  fs/orangefs/inode.c | 32 ++++++--------------------------
>  1 file changed, 6 insertions(+), 26 deletions(-)
>
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index 12ae630fbed7..48f0547d4850 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -62,12 +62,7 @@ static int orangefs_writepage_locked(struct page *page,
>         } else {
>                 ret = 0;
>         }
> -       if (wr) {
> -               kfree(wr);
> -               set_page_private(page, 0);
> -               ClearPagePrivate(page);
> -               put_page(page);
> -       }
> +       kfree(detach_page_private(page));
>         return ret;
>  }
>
> @@ -409,9 +404,7 @@ static int orangefs_write_begin(struct file *file,
>         wr->len = len;
>         wr->uid = current_fsuid();
>         wr->gid = current_fsgid();
> -       SetPagePrivate(page);
> -       set_page_private(page, (unsigned long)wr);
> -       get_page(page);
> +       attach_page_private(page, wr);
>  okay:
>         return 0;
>  }
> @@ -459,18 +452,12 @@ static void orangefs_invalidatepage(struct page *page,
>         wr = (struct orangefs_write_range *)page_private(page);
>
>         if (offset == 0 && length == PAGE_SIZE) {
> -               kfree((struct orangefs_write_range *)page_private(page));
> -               set_page_private(page, 0);
> -               ClearPagePrivate(page);
> -               put_page(page);
> +               kfree(detach_page_private(page));
>                 return;
>         /* write range entirely within invalidate range (or equal) */
>         } else if (page_offset(page) + offset <= wr->pos &&
>             wr->pos + wr->len <= page_offset(page) + offset + length) {
> -               kfree((struct orangefs_write_range *)page_private(page));
> -               set_page_private(page, 0);
> -               ClearPagePrivate(page);
> -               put_page(page);
> +               kfree(detach_page_private(page));
>                 /* XXX is this right? only caller in fs */
>                 cancel_dirty_page(page);
>                 return;
> @@ -535,12 +522,7 @@ static int orangefs_releasepage(struct page *page, gfp_t foo)
>
>  static void orangefs_freepage(struct page *page)
>  {
> -       if (PagePrivate(page)) {
> -               kfree((struct orangefs_write_range *)page_private(page));
> -               set_page_private(page, 0);
> -               ClearPagePrivate(page);
> -               put_page(page);
> -       }
> +       kfree(detach_page_private(page));
>  }
>
>  static int orangefs_launder_page(struct page *page)
> @@ -740,9 +722,7 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
>         wr->len = PAGE_SIZE;
>         wr->uid = current_fsuid();
>         wr->gid = current_fsgid();
> -       SetPagePrivate(page);
> -       set_page_private(page, (unsigned long)wr);
> -       get_page(page);
> +       attach_page_private(page, wr);
>  okay:
>
>         file_update_time(vmf->vma->vm_file);
> --
> 2.17.1
>
