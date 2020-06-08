Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1431F1699
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 12:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgFHKVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 06:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgFHKVC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:21:02 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F390C08C5C3;
        Mon,  8 Jun 2020 03:21:01 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id c9so5626654uao.11;
        Mon, 08 Jun 2020 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1xQVLvyedSDYtAU70eVEaotl4JWf8hNHrVKRWco4rM4=;
        b=ZBbUg1CFRqx0eMv9dsyQC8s4PiSg5x/oHiyP/2cI25r4knFkxr5umsOVM+Ewk89mjb
         gBd9eW8YvcixlJJqIVWi4I/6m/cbJU593HiS8n1r8w+OTlWyIUfAhg/w+DSqW6TiEFeG
         8tICV/K7rSWA0oH8n2rUoFDZgcQGH6AeqzwCqe8MUVmgTUrRazETiXLXwsGb9a/PCgij
         ddN+gNmPnPnYX8QMqJuIAegYIsTMhj1dUVzXg78hfVrOLA1f++XwZE1HkcoOnfykdsW4
         t16n7XKuL0U01BxqrKlGAlXHVK2A1OZCF/7svCdaWsfID5lkitlH3NsxY+94m5vwKgmw
         yUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1xQVLvyedSDYtAU70eVEaotl4JWf8hNHrVKRWco4rM4=;
        b=rfDtXwOS1eBWyzPkxamtf48xmYfpMM31xcsLTZW99KjcscOkaxi9TtBfjEt0PROQU6
         zFGQNKCFBjBmR3qUj/ecM9k1sOY5z6SURMJ+CNqa+qSa19oQmB1ukNkSkmLc82/VAw3c
         0SL4o5vVYa3cyjTiqRNOOcr+0w+O4DTDen0sXJEHxcbKU4S83lxQKrMlPE8tk3wrHjwx
         JfqIP/Y4X+CVCqX3WHL9d++pevAY5XeRA51P3P/Zz4523zxQ7+bOvmo0SWOIpbnmdOeh
         5EIOj67Jk31uSu8tjNC9tiY36N8idBmuwnrEsrwm1vNZNxf34l94PHHDmc5GBZRtd2t+
         ODOg==
X-Gm-Message-State: AOAM533u/xDFpIbGgyTaZVIeNyJcbOyuVt81jMH550mfgSaCIPtf/K/D
        FBXzEuHHF14XR0O4jgUUoC0vQYvIoDxnKoPEFH0=
X-Google-Smtp-Source: ABdhPJw49uEWq0kxN1GQXZj7ChOyxtI+ZaMW85hg9gfqHwNy0Xax5nRhy7Dv/kl9zbam1cJrMYamkrnKv0R9Hp64H4I=
X-Received: by 2002:ab0:377c:: with SMTP id o28mr15021315uat.135.1591611660293;
 Mon, 08 Jun 2020 03:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200605204838.10765-1-rgoldwyn@suse.de> <20200605204838.10765-3-rgoldwyn@suse.de>
In-Reply-To: <20200605204838.10765-3-rgoldwyn@suse.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 8 Jun 2020 11:20:49 +0100
Message-ID: <CAL3q7H6zFBCMf6YeB-adf08t0ov0WMzLKUOOQK-QqACnRnNULA@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: Wait for extent bits to release page
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Nikolay Borisov <nborisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 5, 2020 at 9:48 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>
> While trying to release a page, the extent containing the page may be loc=
ked
> which would stop the page from being released. Wait for the
> extent lock to be cleared, if blocking is allowed and then clear
> the bits.
>
> While we are at it, clean the code of try_release_extent_state() to make
> it simpler.
>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

I'm confused Goldwyn.

Previously in another thread [1] you mentioned you dropped this patch
from a previous patchset because
it was causing locking issues (iirc you mentioned a deadlock in
another different thread).

Now you send exactly the same patch (unless I missed some very subtle
change, in which case keeping the reviewed-by tags is not correct).
Are the locking issues gone? What fixed them?
And how did you trigger those issues, some specific fstest (which?),
some other test (which/how)?

And if this patch is now working for some reason, then why are patches
1/3 and 3/3 needed?
Wasn't patch 1/3 motivated exactly because this patch (2/3) was
causing the locking issues.

Thanks.

[1] https://lore.kernel.org/linux-btrfs/20200526164428.sirhx6yjsghxpnqt@fio=
na/

> ---
>  fs/btrfs/extent_io.c | 37 ++++++++++++++++---------------------
>  fs/btrfs/extent_io.h |  2 +-
>  fs/btrfs/inode.c     |  4 ++--
>  3 files changed, 19 insertions(+), 24 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c59e07360083..0ab444d2028d 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4466,33 +4466,28 @@ int extent_invalidatepage(struct extent_io_tree *=
tree,
>   * are locked or under IO and drops the related state bits if it is safe
>   * to drop the page.
>   */
> -static int try_release_extent_state(struct extent_io_tree *tree,
> +static bool try_release_extent_state(struct extent_io_tree *tree,
>                                     struct page *page, gfp_t mask)
>  {
>         u64 start =3D page_offset(page);
>         u64 end =3D start + PAGE_SIZE - 1;
> -       int ret =3D 1;
>
>         if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
> -               ret =3D 0;
> -       } else {
> -               /*
> -                * at this point we can safely clear everything except th=
e
> -                * locked bit and the nodatasum bit
> -                */
> -               ret =3D __clear_extent_bit(tree, start, end,
> -                                ~(EXTENT_LOCKED | EXTENT_NODATASUM),
> -                                0, 0, NULL, mask, NULL);
> -
> -               /* if clear_extent_bit failed for enomem reasons,
> -                * we can't allow the release to continue.
> -                */
> -               if (ret < 0)
> -                       ret =3D 0;
> -               else
> -                       ret =3D 1;
> +               if (!gfpflags_allow_blocking(mask))
> +                       return false;
> +               wait_extent_bit(tree, start, end, EXTENT_LOCKED);
>         }
> -       return ret;
> +       /*
> +        * At this point we can safely clear everything except the locked=
 and
> +        * nodatasum bits. If clear_extent_bit failed due to -ENOMEM,
> +        * don't allow release.
> +        */
> +       if (__clear_extent_bit(tree, start, end,
> +                               ~(EXTENT_LOCKED | EXTENT_NODATASUM), 0, 0=
,
> +                               NULL, mask, NULL) < 0)
> +               return false;
> +
> +       return true;
>  }
>
>  /*
> @@ -4500,7 +4495,7 @@ static int try_release_extent_state(struct extent_i=
o_tree *tree,
>   * in the range corresponding to the page, both state records and extent
>   * map records are removed
>   */
> -int try_release_extent_mapping(struct page *page, gfp_t mask)
> +bool try_release_extent_mapping(struct page *page, gfp_t mask)
>  {
>         struct extent_map *em;
>         u64 start =3D page_offset(page);
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 9a10681b12bf..6cba4ad6ebc1 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -189,7 +189,7 @@ typedef struct extent_map *(get_extent_t)(struct btrf=
s_inode *inode,
>                                           struct page *page, size_t pg_of=
fset,
>                                           u64 start, u64 len);
>
> -int try_release_extent_mapping(struct page *page, gfp_t mask);
> +bool try_release_extent_mapping(struct page *page, gfp_t mask);
>  int try_release_extent_buffer(struct page *page);
>
>  int extent_read_full_page(struct page *page, get_extent_t *get_extent,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 1242d0aa108d..8cb44c49c1d2 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7887,8 +7887,8 @@ btrfs_readpages(struct file *file, struct address_s=
pace *mapping,
>
>  static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
>  {
> -       int ret =3D try_release_extent_mapping(page, gfp_flags);
> -       if (ret =3D=3D 1) {
> +       bool ret =3D try_release_extent_mapping(page, gfp_flags);
> +       if (ret) {
>                 ClearPagePrivate(page);
>                 set_page_private(page, 0);
>                 put_page(page);
> --
> 2.25.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
