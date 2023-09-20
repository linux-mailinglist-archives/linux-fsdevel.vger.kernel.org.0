Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849D17A710D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 05:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjITDkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 23:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjITDkc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:40:32 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F409F;
        Tue, 19 Sep 2023 20:40:24 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-4528cba7892so624982137.0;
        Tue, 19 Sep 2023 20:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695181223; x=1695786023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbsTDv/vdTgo0XJKb9aBetBXttLdsN9uZRk25mtVFgs=;
        b=kz9uGzclLEKXiK8jGnVi4hO0X9fmmd9lNpXxOv9ixEy5GdXZgRYrQ3Jhm4udhbR+cz
         zkLlxLHBB2jvbcvY2QIhRBc6LMyn0tiYvqeUq4Wy3xy8ePVf3NrSzVWoZB73PcrMti+Q
         z1VPVW87pMGxtWeCFY7pW1o/FmH2Vs9kgbmC6jcun3SMfhuGZFCGRgHgO0LoIBxqXdun
         M6HR94J6UxHpxr+rZ31HXAg/gESNm1z25qgpwGD7Z+0jWNYMldnAtGqwacN1B/ufZ46U
         AYeygJ9aO+aC9PQj2cNUtx8gkmmstjQVahNZvpqtlHzh3EQjTg4fmcQWKdeyUMXSffm2
         yCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695181223; x=1695786023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbsTDv/vdTgo0XJKb9aBetBXttLdsN9uZRk25mtVFgs=;
        b=cSq3e5g/gWcu+0pR/XGcqtCKhM6c7bKH9UZXHTemkjQcoH29QFubtHiyPG12rq3I52
         xiTVfgDKWGwM4/eE5ROaKLN75jLf2/363Ii9iLKFSXsL55GwmgL8ZRvJuXHgBbvyXts3
         1Bis1Qzd/4yq5esqeUHvTyxBrsaCaPzdRjI8MBZZXNCj3q04sO5z58kKC98kKXoNAIhF
         T1xmlSw0/Dbr2bfrAdTvq98/41ssu7BCWz/aA5YN3vmOjSdZHXGE+RVpCi9tG7l4sr5Z
         8qfR7VbUzAB4Y60x1z/nmBmPct2qbqRefhtElRgOHYALDSHCtJavBrnOCk3nv7BG+Pn7
         Jzog==
X-Gm-Message-State: AOJu0YxqAnwzpflUhEFsSeSQCSCr9irzMwu9J27CR+EBBPupMZGsumhA
        F+JR8MKnjygn4Fey/tcd+k/tWpb+B9LHosWCmXkXDifiIV0Isg==
X-Google-Smtp-Source: AGHT+IHEBWq/1XTZtP0mhqwg3tAU0M9kblloDD8+XtqFaWUz5y3r1rDHF8lseWtoSoONYJCT/DOmQ8XEC2PsGWaMvyQ=
X-Received: by 2002:a67:fe97:0:b0:452:62b2:36b with SMTP id
 b23-20020a67fe97000000b0045262b2036bmr1651569vsr.30.1695181223031; Tue, 19
 Sep 2023 20:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230919045135.3635437-1-willy@infradead.org> <20230919045135.3635437-5-willy@infradead.org>
In-Reply-To: <20230919045135.3635437-5-willy@infradead.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 20 Sep 2023 12:40:06 +0900
Message-ID: <CAKFNMonYFYCXnJTkM+MQbDCfTWV19v+acYZwHs-W4NuBBHE7Tg@mail.gmail.com>
Subject: Re: [PATCH 04/26] buffer: Add get_nth_bh()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 4:20=E2=80=AFPM Matthew Wilcox (Oracle) wrote:
>
> Extract this useful helper from nilfs_page_get_nth_block()
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/nilfs2/page.h            |  7 +------
>  include/linux/buffer_head.h | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
> index 21ddcdd4d63e..344d71942d36 100644
> --- a/fs/nilfs2/page.h
> +++ b/fs/nilfs2/page.h
> @@ -55,12 +55,7 @@ unsigned long nilfs_find_uncommitted_extent(struct ino=
de *inode,
>  static inline struct buffer_head *
>  nilfs_page_get_nth_block(struct page *page, unsigned int count)
>  {
> -       struct buffer_head *bh =3D page_buffers(page);
> -
> -       while (count-- > 0)
> -               bh =3D bh->b_this_page;
> -       get_bh(bh);
> -       return bh;
> +       return get_nth_bh(page_buffers(page), count);
>  }
>
>  #endif /* _NILFS_PAGE_H */
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 1001244a8941..9fc615ee17fd 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -457,6 +457,28 @@ __bread(struct block_device *bdev, sector_t block, u=
nsigned size)
>         return __bread_gfp(bdev, block, size, __GFP_MOVABLE);
>  }
>
> +/**
> + * get_nth_bh - Get a reference on the n'th buffer after this one.
> + * @bh: The buffer to start counting from.
> + * @count: How many buffers to skip.
> + *
> + * This is primarily useful for finding the nth buffer in a folio; in
> + * that case you pass the head buffer and the byte offset in the folio
> + * divided by the block size.  It can be used for other purposes, but
> + * it will wrap at the end of the folio rather than returning NULL or
> + * proceeding to the next folio for you.
> + *
> + * Return: The requested buffer with an elevated refcount.
> + */
> +static inline struct buffer_head *get_nth_bh(struct buffer_head *bh,
> +               unsigned int count)
> +{
> +       while (count--)
> +               bh =3D bh->b_this_page;
> +       get_bh(bh);
> +       return bh;
> +}
> +
>  bool block_dirty_folio(struct address_space *mapping, struct folio *foli=
o);
>
>  #ifdef CONFIG_BUFFER_HEAD
> --
> 2.40.1
>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Looks good to me.

Thanks,
Ryusuke Konishi
