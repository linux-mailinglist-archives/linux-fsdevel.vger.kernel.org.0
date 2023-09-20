Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE947A7178
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 06:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjITEOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 00:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjITEOJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 00:14:09 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B515B0;
        Tue, 19 Sep 2023 21:14:03 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7ab30cee473so386116241.2;
        Tue, 19 Sep 2023 21:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695183242; x=1695788042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0rt7w3e82POtgPKP1THsIMl2ekopUlVw4b9tDepiWE=;
        b=N1oBJ5Pk69IwRoTdPPZCfX9w3ms0bY00XHcPHEPZybptv3sEY3PN3e6Q8RAAaL8LEz
         vzIs7cljTd46Qs3L8ACG3gtSEkCn/ndQtUvrbJQt1q+Joe7zhMAWhlccpC9zI2/sTDHH
         AXebXcciG2wUzL41ekKy/OBrT4+hpe9Fr8qIFcSIB9Ccwh9VOO4q48Vq2C3tv3s1xIOJ
         uD4qys+Var6IChL2PXvwULFP/zDoa31jGQsfgMGOdySEyQrMo6yLWACr/P/xak9aGleV
         vKmkCLVHe58WjFC1Y+cJMA9p93e0FPYELvSLHNoI50ly97SaKVt1fIsSyXsSzmBOYd3/
         Z8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695183242; x=1695788042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0rt7w3e82POtgPKP1THsIMl2ekopUlVw4b9tDepiWE=;
        b=BOdYyVkbJXdpKp7JS8u8dn6dOBoRe3mWEmIVd7zAocb/17UGmgFrkalO5DZSYulTNv
         dTBFqKi8/qN2Fv5dc1s1XQQ5zA4XOUu1lM8bOUSe/Cr3yCz1lbb7zewI4UCGe7Dn6vJc
         tlM/un07bM/gAznuLA80uZ+DF/Sy3uUxIPVFnEV+K1MPr2gBqoGygowLIF0HanjfrcTU
         ZjBjPIw07v1uqa2c2mRmigu8oO2dguUnHC0fuVaKUdudo+WZeMN1d2mcOoUyPRrU2A0l
         cR4nTwl7lv8H7abDRMIKoJXPSxGB+D+0wJOE/nQaHO1ZsX1pw02YoaJmpS6SE8nFp+5f
         ju3A==
X-Gm-Message-State: AOJu0YzEhEHssPX6FZrMUoWo+kxLaZ332VUX8t/onI6mmF562tnooEwR
        /lZ35B5CMGlUQRJyDkMQIFocHe8hrgR9ikgm5wg=
X-Google-Smtp-Source: AGHT+IGCKO6LeP33eZK46vTIa58jvzUXNGW5L0NVntBiKaEkNCqYCRfexXS3jzHPQ4GIsPMvj/0pYBrkJxVEdJ5Rjcw=
X-Received: by 2002:a05:6102:184:b0:452:635b:8440 with SMTP id
 r4-20020a056102018400b00452635b8440mr1509703vsq.30.1695183242192; Tue, 19 Sep
 2023 21:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230919045135.3635437-1-willy@infradead.org> <20230919045135.3635437-11-willy@infradead.org>
In-Reply-To: <20230919045135.3635437-11-willy@infradead.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 20 Sep 2023 13:13:45 +0900
Message-ID: <CAKFNMomBNvU-cRbrHMem8qPtLdfeO7VgKdSwxPixA1-vZMyDVg@mail.gmail.com>
Subject: Re: [PATCH 10/26] nilfs2: Convert nilfs_grab_buffer() to use a folio
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 7:20=E2=80=AFPM Matthew Wilcox (Oracle) wrote:
>
> Remove a number of folio->page->folio conversions.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/nilfs2/page.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
> index b4e54d079b7d..1c075bd906c9 100644
> --- a/fs/nilfs2/page.c
> +++ b/fs/nilfs2/page.c
> @@ -25,19 +25,19 @@
>         (BIT(BH_Uptodate) | BIT(BH_Mapped) | BIT(BH_NILFS_Node) |       \
>          BIT(BH_NILFS_Volatile) | BIT(BH_NILFS_Checked))
>
> -static struct buffer_head *
> -__nilfs_get_page_block(struct page *page, unsigned long block, pgoff_t i=
ndex,
> -                      int blkbits, unsigned long b_state)
> +static struct buffer_head *__nilfs_get_folio_block(struct folio *folio,
> +               unsigned long block, pgoff_t index, int blkbits,
> +               unsigned long b_state)
>
>  {
>         unsigned long first_block;
> -       struct buffer_head *bh;
> +       struct buffer_head *bh =3D folio_buffers(folio);
>
> -       if (!page_has_buffers(page))
> -               create_empty_buffers(page, 1 << blkbits, b_state);
> +       if (!bh)
> +               bh =3D folio_create_empty_buffers(folio, 1 << blkbits, b_=
state);
>
>         first_block =3D (unsigned long)index << (PAGE_SHIFT - blkbits);
> -       bh =3D nilfs_page_get_nth_block(page, block - first_block);
> +       bh =3D get_nth_bh(bh, block - first_block);
>
>         touch_buffer(bh);
>         wait_on_buffer(bh);
> @@ -51,17 +51,17 @@ struct buffer_head *nilfs_grab_buffer(struct inode *i=
node,
>  {
>         int blkbits =3D inode->i_blkbits;
>         pgoff_t index =3D blkoff >> (PAGE_SHIFT - blkbits);
> -       struct page *page;
> +       struct folio *folio;
>         struct buffer_head *bh;
>
> -       page =3D grab_cache_page(mapping, index);
> -       if (unlikely(!page))
> +       folio =3D filemap_grab_folio(mapping, index);
> +       if (IS_ERR(folio))
>                 return NULL;
>
> -       bh =3D __nilfs_get_page_block(page, blkoff, index, blkbits, b_sta=
te);
> +       bh =3D __nilfs_get_folio_block(folio, blkoff, index, blkbits, b_s=
tate);
>         if (unlikely(!bh)) {
> -               unlock_page(page);
> -               put_page(page);
> +               folio_unlock(folio);
> +               folio_put(folio);
>                 return NULL;
>         }
>         return bh;
> --
> 2.40.1
>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Looks good to me.

Thanks,
Ryusuke Konishi
