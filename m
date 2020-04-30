Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410071C0A1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 00:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgD3WK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 18:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgD3WK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 18:10:28 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C8BC035494;
        Thu, 30 Apr 2020 15:10:27 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id u189so2918850ilc.4;
        Thu, 30 Apr 2020 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ET+MOiHcfDMgOrMdmamXFlGdEeR/f0vqWkjUxmdClw=;
        b=DEPtrDBeYCAoQ0fIRW9vAO9AKdIBDd19yOKxqpCf33m+D4aDmFK0jWp2gDkDUfLIF3
         a0RiY8WUBuL/OywF0Sfe7Mw+U8PZHBrvRLi/cWr1L1zS3KXtS0LME1w+kYJIPn7rausY
         nZhWTdF599LEhKufQQYjD1zsGEBgcBeH3K1sOcIdbr8EtnqnwRv4/l6hVhEMsdoJUqpk
         XjIQpgLOLavv3PmRpNfqyxxh4+hksm0y3AwKeb0sOmtqDJXCcblH+SeQl3NWtKJFZ0bP
         L4LI0dNHCatdsYd8Gkx8mfgs4X1yi/Bli1OkCGFhW4U70l4V5687nZe5sfnbXXVoZr1N
         GG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ET+MOiHcfDMgOrMdmamXFlGdEeR/f0vqWkjUxmdClw=;
        b=lh/YhRsTPEyAIm6mGIauGy0rrfIdukqmi/Lg6I0k8vejtQ9HwFTdPWAOkKlMCy+lqv
         6u33qT6Ldqp72zO0wZ9uD/3RcufmaOeVAajS0FPoC3ShLhaNwN2T78QZzqsa1y3bGkDR
         YqU2tVFW9uRMbgKfjsFC2d/t93hCivTei35JWyjAP95nYik3Kbsvi4LyUATtE2khrPxH
         BndInfG6l/ypbOl8S9RyPq+gCBoUZl5oLLWfPyvO7Yl7Pac1XCWO6p0pXMeG/2ZI4BvM
         05yavQwgAE3yWYp3IFvE0OzGaDhLO+GS8r+KGLCmFHdoCEl8Z24NmYGVn/c66roIJR37
         mcOg==
X-Gm-Message-State: AGi0PuZEI6IlfpIUdMJl6M1Aro+Wem6OyndJO22BI9/WS9hzekmX3547
        aBan1eiqUgt/zEusNqeRAtWqJ5fEuE20haTtjOQ=
X-Google-Smtp-Source: APiQypJJdXHu9wsfILyXAYVgqjt8UsMKQuE8/0rB4pSAfnWGHEsBd9R1cDbXdgQq9K8UTJgqdLieT21my6+JZOjxZdE=
X-Received: by 2002:a92:9e0b:: with SMTP id q11mr601506ili.133.1588284626957;
 Thu, 30 Apr 2020 15:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com> <20200430214450.10662-2-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20200430214450.10662-2-guoqing.jiang@cloud.ionos.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 1 May 2020 00:10:15 +0200
Message-ID: <CAHpGcMKdzSBGZTRwuoBTuCFUX44egmutvCr9LcjYW7KpWxmhHA@mail.gmail.com>
Subject: Re: [RFC PATCH V2 1/9] include/linux/pagemap.h: introduce attach/clear_page_private
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, willy@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yafang Shao <laoar.shao@gmail.com>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andreas Dilger <adilger@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Am Do., 30. Apr. 2020 um 23:56 Uhr schrieb Guoqing Jiang
<guoqing.jiang@cloud.ionos.com>:
> The logic in attach_page_buffers and  __clear_page_buffers are quite
> paired, but
>
> 1. they are located in different files.
>
> 2. attach_page_buffers is implemented in buffer_head.h, so it could be
>    used by other files. But __clear_page_buffers is static function in
>    buffer.c and other potential users can't call the function, md-bitmap
>    even copied the function.
>
> So, introduce the new attach/clear_page_private to replace them. With
> the new pair of function, we will remove the usage of attach_page_buffers
> and  __clear_page_buffers in next patches. Thanks for the new names from
> Christoph Hellwig.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> Cc: William Kucharski <william.kucharski@oracle.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Yafang Shao <laoar.shao@gmail.com>
> Cc: Song Liu <song@kernel.org>
> Cc: linux-raid@vger.kernel.org
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: linux-xfs@vger.kernel.org
> Cc: Anton Altaparmakov <anton@tuxera.com>
> Cc: linux-ntfs-dev@lists.sourceforge.net
> Cc: Mike Marshall <hubcap@omnibond.com>
> Cc: Martin Brandenburg <martin@omnibond.com>
> Cc: devel@lists.orangefs.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
> RFC -> RFC V2:  Address the comments from Christoph Hellwig
> 1. change function names to attach/clear_page_private and add comments.
> 2. change the return type of attach_page_private.
>
>  include/linux/pagemap.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index a8f7bd8ea1c6..2e515f210b18 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -205,6 +205,41 @@ static inline int page_cache_add_speculative(struct page *page, int count)
>         return __page_cache_add_speculative(page, count);
>  }
>
> +/**
> + * attach_page_private - attach data to page's private field and set PG_private.
> + * @page: page to be attached and set flag.
> + * @data: data to attach to page's private field.
> + *
> + * Need to take reference as mm.h said "Setting PG_private should also increment
> + * the refcount".
> + */
> +static inline void attach_page_private(struct page *page, void *data)
> +{
> +       get_page(page);
> +       set_page_private(page, (unsigned long)data);
> +       SetPagePrivate(page);
> +}
> +
> +/**
> + * clear_page_private - clear page's private field and PG_private.
> + * @page: page to be cleared.
> + *
> + * The counterpart function of attach_page_private.
> + * Return: private data of page or NULL if page doesn't have private data.
> + */
> +static inline void *clear_page_private(struct page *page)
> +{
> +       void *data = (void *)page_private(page);
> +
> +       if (!PagePrivate(page))
> +               return NULL;
> +       ClearPagePrivate(page);
> +       set_page_private(page, 0);
> +       put_page(page);
> +
> +       return data;
> +}
> +

I like this in general, but the name clear_page_private suggests that
this might be the inverse operation of set_page_private, which it is
not. So maybe this can be renamed to detach_page_private to more
clearly indicate that it pairs with attach_page_private?

>  #ifdef CONFIG_NUMA
>  extern struct page *__page_cache_alloc(gfp_t gfp);
>  #else
> --
> 2.17.1
>

Thanks,
Andreas
