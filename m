Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EC7765BFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 21:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjG0TSA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 15:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjG0TR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:17:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968B2F3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 12:17:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99454855de1so171743366b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690485476; x=1691090276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m/Z3Y+hMVv3AErLDGm1fTiSMK1jl55Ger2mmkiHOsY8=;
        b=Bp5UDylaPcmhnK3Xbwfo0AvC//e+dFqvTB0V4G00cZjUWyGl23uo490gmrJ1a4jEbW
         18IHjc4jCv2clUs92d6mThmWaKi1PUmpN02Q5Dz/iU296qTyocfYFNuOC2Js7mWooSMG
         ey+2bD5lRBJ5aOU1QH3qnkkb1aHt+q9CJ1O5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690485476; x=1691090276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/Z3Y+hMVv3AErLDGm1fTiSMK1jl55Ger2mmkiHOsY8=;
        b=MW3NZqmOvANoy/TjKuignQeUFRrq//sOZGM3LztOs7TSwlZT3d1I7UUWrUGmxKiZKE
         fKb0iNdpuTzEC7r3oIZai/3j8edZhkfQ0jaIBtJh5PrSETWf6ztlQuofjoPh0NnLKVea
         dJUS23ui1MtiHRcfEd9M7eNo9NDT7pF1+yQC304/a08fSTe1SBy6xz9ChORhs6b6/R9X
         OT57xUX06yHpJSQ69DEydw5GzHkpaK1rRolUc0WmMDOGbd+gzEUYg9HGNEQSnQIIVvjn
         Oaw5mQSfkQSwnHtuqA67257q2KTtZIaXeHINC2dV3LM92rnMdfZLSamP3rgzKBFraWf3
         toOQ==
X-Gm-Message-State: ABy/qLYvgwptToScegE2IJjU/E/8rlFTHMSb6ZLu8bHxO4LbU5VhKN+o
        F6vEh8iM9z7BIiMZmI7RkBMGLHkUc7yWGcFABrUWxw==
X-Google-Smtp-Source: APBJJlG/NyZXS4Z9DgKkeGQoqD4R/EQ4e/CgZ5EWEoafo2el6mR+ufrS1dLK5zHnk3jd5RsbiNBJJLLTHRhOR3JewvU=
X-Received: by 2002:a17:906:2257:b0:989:450:e585 with SMTP id
 23-20020a170906225700b009890450e585mr109063ejr.45.1690485475978; Thu, 27 Jul
 2023 12:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230726105953.843-1-jaco@uls.co.za> <20230727081237.18217-1-jaco@uls.co.za>
 <CAJfpegvJ7FOS35yiKsTAzQh5Uf71FatU-kTJpXJtDPQbXeMgxA@mail.gmail.com> <567b798d-9883-aa9c-05e6-3d5ce3d716ca@uls.co.za>
In-Reply-To: <567b798d-9883-aa9c-05e6-3d5ce3d716ca@uls.co.za>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 27 Jul 2023 21:17:44 +0200
Message-ID: <CAJfpegsrA93ZzWGwgTNdJgPK0UXhiTSK0QV--k=YpaucnrNj5A@mail.gmail.com>
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

On Thu, 27 Jul 2023 at 18:58, Jaco Kroon <jaco@uls.co.za> wrote:
>
> Hi,
>
> On 2023/07/27 17:35, Miklos Szeredi wrote:
> > On Thu, 27 Jul 2023 at 10:13, Jaco Kroon <jaco@uls.co.za> wrote:
> >> This patch does not mess with the caching infrastructure like the
> >> previous one, which we believe caused excessive CPU and broke directory
> >> listings in some cases.
> >>
> >> This version only affects the uncached read, which then during parse adds an
> >> entry at a time to the cached structures by way of copying, and as such,
> >> we believe this should be sufficient.
> >>
> >> We're still seeing cases where getdents64 takes ~10s (this was the case
> >> in any case without this patch, the difference now that we get ~500
> >> entries for that time rather than the 14-18 previously).  We believe
> >> that that latency is introduced on glusterfs side and is under separate
> >> discussion with the glusterfs developers.
> >>
> >> This is still a compile-time option, but a working one compared to
> >> previous patch.  For now this works, but it's not recommended for merge
> >> (as per email discussion).
> >>
> >> This still uses alloc_pages rather than kvmalloc/kvfree.
> >>
> >> Signed-off-by: Jaco Kroon <jaco@uls.co.za>
> >> ---
> >>   fs/fuse/Kconfig   | 16 ++++++++++++++++
> >>   fs/fuse/readdir.c | 18 ++++++++++++------
> >>   2 files changed, 28 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> >> index 038ed0b9aaa5..0783f9ee5cd3 100644
> >> --- a/fs/fuse/Kconfig
> >> +++ b/fs/fuse/Kconfig
> >> @@ -18,6 +18,22 @@ config FUSE_FS
> >>            If you want to develop a userspace FS, or if you want to use
> >>            a filesystem based on FUSE, answer Y or M.
> >>
> >> +config FUSE_READDIR_ORDER
> >> +       int
> >> +       range 0 5
> >> +       default 5
> >> +       help
> >> +               readdir performance varies greatly depending on the size of the read.
> >> +               Larger buffers results in larger reads, thus fewer reads and higher
> >> +               performance in return.
> >> +
> >> +               You may want to reduce this value on seriously constrained memory
> >> +               systems where 128KiB (assuming 4KiB pages) cache pages is not ideal.
> >> +
> >> +               This value reprents the order of the number of pages to allocate (ie,
> >> +               the shift value).  A value of 0 is thus 1 page (4KiB) where 5 is 32
> >> +               pages (128KiB).
> >> +
> >>   config CUSE
> >>          tristate "Character device in Userspace support"
> >>          depends on FUSE_FS
> >> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> >> index dc603479b30e..47cea4d91228 100644
> >> --- a/fs/fuse/readdir.c
> >> +++ b/fs/fuse/readdir.c
> >> @@ -13,6 +13,12 @@
> >>   #include <linux/pagemap.h>
> >>   #include <linux/highmem.h>
> >>
> >> +#define READDIR_PAGES_ORDER            CONFIG_FUSE_READDIR_ORDER
> >> +#define READDIR_PAGES                  (1 << READDIR_PAGES_ORDER)
> >> +#define READDIR_PAGES_SIZE             (PAGE_SIZE << READDIR_PAGES_ORDER)
> >> +#define READDIR_PAGES_MASK             (READDIR_PAGES_SIZE - 1)
> >> +#define READDIR_PAGES_SHIFT            (PAGE_SHIFT + READDIR_PAGES_ORDER)
> >> +
> >>   static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
> >>   {
> >>          struct fuse_conn *fc = get_fuse_conn(dir);
> >> @@ -328,25 +334,25 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
> >>          struct fuse_mount *fm = get_fuse_mount(inode);
> >>          struct fuse_io_args ia = {};
> >>          struct fuse_args_pages *ap = &ia.ap;
> >> -       struct fuse_page_desc desc = { .length = PAGE_SIZE };
> >> +       struct fuse_page_desc desc = { .length = READDIR_PAGES_SIZE };
> > Does this really work?  I would've thought we are relying on single
> > page lengths somewhere.
> Based on my testing yes.  Getting just under 500 entries per
> getdents64() call from userspace vs 14-18 before I guess the answer is yes.
> >
> >>          u64 attr_version = 0;
> >>          bool locked;
> >>
> >> -       page = alloc_page(GFP_KERNEL);
> >> +       page = alloc_pages(GFP_KERNEL, READDIR_PAGES_ORDER);
> >>          if (!page)
> >>                  return -ENOMEM;
> >>
> >>          plus = fuse_use_readdirplus(inode, ctx);
> >>          ap->args.out_pages = true;
> >> -       ap->num_pages = 1;
> >> +       ap->num_pages = READDIR_PAGES;
> > No.  This is the array lenght, which is 1.  This is the hack I guess,
> > which makes the above trick work.
>
> Oh?  So the page referenced above isn't an array of pages?  It's
> actually a single piece of contiguous memory?

Yes.

>
> > Better use kvmalloc, which might have a slightly worse performance
> > than a large page, but definitely not worse than the current single
> > page.
>
> Which returns a void*, not struct page* - guess this can be converted
> using __virt_to_page (iirc)?

No, it cannot be converted to a page or a page array, use it as just a
piece of kernel memory.

Which means:

 - don't set ->args.out_pages and ->num_pages
 - instead set  ->args.out_args[0].value to the allocated pointer

and that should be it (fingers crossed).

>
> > If we want to optimize the overhead of kvmalloc (and it's a big if)
> > then the parse_dir*file() functions would need to be converted to
> > using a page array instead of a plain kernel pointer, which would add
> > some complexity for sure.
>
> Sorry, I read the above as "I'm surprised this works at all and you're
> not kernel panicking all over the show", this is probably the most
> ambitious kernel patch I've attempted to date.

Good start, you'll learn.

Thanks,
Miklos
