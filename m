Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A549F7657CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 17:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjG0PgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 11:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjG0PgO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:36:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C752701
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 08:36:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fdd14c1fbfso1978442e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690472168; x=1691076968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wnhGuO24k3ZJG4n69+tp8wr6XFgAqNGJKPH/fiKo8cU=;
        b=UuRhiEn/Ecme2Yfsq5P+MTTtKSJW31H/NZ2qe92/kR/LVHlru559dm3beXn4Iqb6Ot
         uw35+Ss6JMAvDrcEi/czK3YYIi6H9984/VXI8ZFmVCH1c4s71rU9gp4HgJPaPTs3JBHX
         ziJsXl6dDwzPXgYg91f0iyZlT9jvMe4Kkn7bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690472168; x=1691076968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnhGuO24k3ZJG4n69+tp8wr6XFgAqNGJKPH/fiKo8cU=;
        b=AWwrtZvNaYsNZxsuN651dzTbdgkdaMxZ0IUaiIEewnhlEk8tu3X0js3h0MwL8C8bjO
         dh/nv3SIJE2HViYY2MdrTumh2NcBeBXMRyG0OGDimHNi4qkEpByf3wC6L0RG39iudCTD
         V3o0GYptFA+F7sCSut3zNB2EaZcAdigJp2D58rUDVVWjv+KGSxd3TAMNRO4BAllDXYSW
         RRD9EwRzxEhCuGT4MeqOMn5E+LtddtWF3P0g/ikvrrUFyIx9ZM5j1SxCcP+IuNqOY4zu
         l96uhMoNhpkf7xM4pRLsrwuYDHg2IiYwVvseSjbjawxJiZiyg3+LWrISGiffGm2Psx1D
         isOg==
X-Gm-Message-State: ABy/qLa+xUKR6E2YJbjB8KKcq7hFD78oh6rxDgHUcMIptbnwYN9R2uoC
        KbbvIt60f7oO0bDEgeMHYgnYGpZGlSChiusFnwOZSw==
X-Google-Smtp-Source: APBJJlGsCN6HuHCxz+inQTU2CKEQtL3hsMB5InlEYoL2mvREWd8E42W1h8ZQPNtdHp+/rq06HMdJBPdRekSa9sa4znQ=
X-Received: by 2002:ac2:58e4:0:b0:4f8:d385:41bd with SMTP id
 v4-20020ac258e4000000b004f8d38541bdmr1804567lfo.8.1690472168200; Thu, 27 Jul
 2023 08:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230726105953.843-1-jaco@uls.co.za> <20230727081237.18217-1-jaco@uls.co.za>
In-Reply-To: <20230727081237.18217-1-jaco@uls.co.za>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 27 Jul 2023 17:35:56 +0200
Message-ID: <CAJfpegvJ7FOS35yiKsTAzQh5Uf71FatU-kTJpXJtDPQbXeMgxA@mail.gmail.com>
Subject: Re: [PATCH] fuse: enable larger read buffers for readdir [v2].
To:     Jaco Kroon <jaco@uls.co.za>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        Antonio SJ Musumeci <trapexit@spawn.link>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 Jul 2023 at 10:13, Jaco Kroon <jaco@uls.co.za> wrote:
>
> This patch does not mess with the caching infrastructure like the
> previous one, which we believe caused excessive CPU and broke directory
> listings in some cases.
>
> This version only affects the uncached read, which then during parse adds an
> entry at a time to the cached structures by way of copying, and as such,
> we believe this should be sufficient.
>
> We're still seeing cases where getdents64 takes ~10s (this was the case
> in any case without this patch, the difference now that we get ~500
> entries for that time rather than the 14-18 previously).  We believe
> that that latency is introduced on glusterfs side and is under separate
> discussion with the glusterfs developers.
>
> This is still a compile-time option, but a working one compared to
> previous patch.  For now this works, but it's not recommended for merge
> (as per email discussion).
>
> This still uses alloc_pages rather than kvmalloc/kvfree.
>
> Signed-off-by: Jaco Kroon <jaco@uls.co.za>
> ---
>  fs/fuse/Kconfig   | 16 ++++++++++++++++
>  fs/fuse/readdir.c | 18 ++++++++++++------
>  2 files changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 038ed0b9aaa5..0783f9ee5cd3 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -18,6 +18,22 @@ config FUSE_FS
>           If you want to develop a userspace FS, or if you want to use
>           a filesystem based on FUSE, answer Y or M.
>
> +config FUSE_READDIR_ORDER
> +       int
> +       range 0 5
> +       default 5
> +       help
> +               readdir performance varies greatly depending on the size of the read.
> +               Larger buffers results in larger reads, thus fewer reads and higher
> +               performance in return.
> +
> +               You may want to reduce this value on seriously constrained memory
> +               systems where 128KiB (assuming 4KiB pages) cache pages is not ideal.
> +
> +               This value reprents the order of the number of pages to allocate (ie,
> +               the shift value).  A value of 0 is thus 1 page (4KiB) where 5 is 32
> +               pages (128KiB).
> +
>  config CUSE
>         tristate "Character device in Userspace support"
>         depends on FUSE_FS
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index dc603479b30e..47cea4d91228 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -13,6 +13,12 @@
>  #include <linux/pagemap.h>
>  #include <linux/highmem.h>
>
> +#define READDIR_PAGES_ORDER            CONFIG_FUSE_READDIR_ORDER
> +#define READDIR_PAGES                  (1 << READDIR_PAGES_ORDER)
> +#define READDIR_PAGES_SIZE             (PAGE_SIZE << READDIR_PAGES_ORDER)
> +#define READDIR_PAGES_MASK             (READDIR_PAGES_SIZE - 1)
> +#define READDIR_PAGES_SHIFT            (PAGE_SHIFT + READDIR_PAGES_ORDER)
> +
>  static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
>  {
>         struct fuse_conn *fc = get_fuse_conn(dir);
> @@ -328,25 +334,25 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
>         struct fuse_mount *fm = get_fuse_mount(inode);
>         struct fuse_io_args ia = {};
>         struct fuse_args_pages *ap = &ia.ap;
> -       struct fuse_page_desc desc = { .length = PAGE_SIZE };
> +       struct fuse_page_desc desc = { .length = READDIR_PAGES_SIZE };

Does this really work?  I would've thought we are relying on single
page lengths somewhere.

>         u64 attr_version = 0;
>         bool locked;
>
> -       page = alloc_page(GFP_KERNEL);
> +       page = alloc_pages(GFP_KERNEL, READDIR_PAGES_ORDER);
>         if (!page)
>                 return -ENOMEM;
>
>         plus = fuse_use_readdirplus(inode, ctx);
>         ap->args.out_pages = true;
> -       ap->num_pages = 1;
> +       ap->num_pages = READDIR_PAGES;

No.  This is the array lenght, which is 1.  This is the hack I guess,
which makes the above trick work.

Better use kvmalloc, which might have a slightly worse performance
than a large page, but definitely not worse than the current single
page.

If we want to optimize the overhead of kvmalloc (and it's a big if)
then the parse_dir*file() functions would need to be converted to
using a page array instead of a plain kernel pointer, which would add
some complexity for sure.

Thanks,
Miklos
