Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28FC7A7556
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjITIHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjITIHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:07:43 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7682F9E;
        Wed, 20 Sep 2023 01:07:37 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-490cd6db592so2736673e0c.1;
        Wed, 20 Sep 2023 01:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695197256; x=1695802056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cH5sDHtnVKWCV3iCYyvX8z8Hs3DAvkXrfeXQp9YY8c=;
        b=OuiXP01hUoxoUzTLFPVW9oPxBvpT1XOogxeSwwAtspy6pdhyj/s/LGbvpfopL3k8gu
         khWOuehEHcZZcs6IC2Js3rZ5utcZLHy2Lwstt3u/C03KYU4BvPjRTKjxFcutYQrYyM9C
         Q8drta0kRjN15QsKwa+1SNvq/zOybu8pANgEZtJ8dVd4htx8KD5n5P433SLYcr3jknuZ
         9fnZEXvQozYw8ZKfykMzp9EocW+pBgxtfsSlmVw57SNRmN5cAqSgWNiXg4jaYY2VCi7J
         ECJdl/Vzfs2XQQjYfyHNfeazrMe7EMVMgp2RpEYN1oLl0YYe2w8n71ku0p/e7Hgu7tUp
         +C3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695197256; x=1695802056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cH5sDHtnVKWCV3iCYyvX8z8Hs3DAvkXrfeXQp9YY8c=;
        b=uY73qdB/+4aqKKX3nyhljFDazpxPlLSwMluQG/ApItrZ29gvJsUZfV49pCY8m+9N0o
         v9TDJAtfXQ0q3GOzJd4qQz8E1kvUQpcU4IF4xr7B6yhed3MWuRkLZ7Sa9D1zwWqM1xcs
         3xQ9ldXi0VCBhs9djhBt2zjhZ0UyIfTIyhgVsG0L+FuDuBeldUrgubk1f5zyWDmsVeED
         zCbw1TZA8uWDBmRS8Sy9CZsklIE6tfQYtbdR7I4B5Sjg6mZ5pqPZt0oj9H/7t3NaBP0u
         wONKNM4ws6GWB7CE6ywdgmzm/q76n9939vV17gaHm2+WNtxKf2BY2P/3Y09FZC/kHjnQ
         4h+w==
X-Gm-Message-State: AOJu0YyHb94eToNjulJVWztG4Qh5LZD5fJByT+Gxqznyg+U4TqXnJ9VK
        Amf8PszfV2tIJ/6xO679Kdm3g2Ydxadkngee4LU=
X-Google-Smtp-Source: AGHT+IFkmee8vYqiRU2MDwPCUYc12H9bxQ6dbTyVl2uMQTPK3nmmRGzDpQBcuukLJM94BaZ9yBg2NObfT5FOrPxTcNo=
X-Received: by 2002:a1f:4c41:0:b0:48f:e0c4:1a1 with SMTP id
 z62-20020a1f4c41000000b0048fe0c401a1mr1862870vka.12.1695197256424; Wed, 20
 Sep 2023 01:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230919045135.3635437-1-willy@infradead.org> <20230919045135.3635437-14-willy@infradead.org>
In-Reply-To: <20230919045135.3635437-14-willy@infradead.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 20 Sep 2023 17:07:20 +0900
Message-ID: <CAKFNMokMe_QOPuLXsvUJf2+qZLUyi7Z_JFAKvh853N6ZV3yGyA@mail.gmail.com>
Subject: Re: [PATCH 13/26] nilfs2: Convert nilfs_mdt_get_frozen_buffer to use
 a folio
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

On Tue, Sep 19, 2023 at 6:25=E2=80=AFPM Matthew Wilcox (Oracle) wrote:
>
> Remove a number of folio->page->folio conversions.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/nilfs2/mdt.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
> index 11b7cf4acc92..7b754e6494d7 100644
> --- a/fs/nilfs2/mdt.c
> +++ b/fs/nilfs2/mdt.c
> @@ -592,17 +592,19 @@ nilfs_mdt_get_frozen_buffer(struct inode *inode, st=
ruct buffer_head *bh)
>  {
>         struct nilfs_shadow_map *shadow =3D NILFS_MDT(inode)->mi_shadow;
>         struct buffer_head *bh_frozen =3D NULL;
> -       struct page *page;
> +       struct folio *folio;
>         int n;
>
> -       page =3D find_lock_page(shadow->inode->i_mapping, bh->b_folio->in=
dex);
> -       if (page) {
> -               if (page_has_buffers(page)) {
> +       folio =3D filemap_lock_folio(shadow->inode->i_mapping,
> +                       bh->b_folio->index);
> +       if (!IS_ERR(folio)) {
> +               bh_frozen =3D folio_buffers(folio);
> +               if (bh_frozen) {
>                         n =3D bh_offset(bh) >> inode->i_blkbits;
> -                       bh_frozen =3D nilfs_page_get_nth_block(page, n);
> +                       bh_frozen =3D get_nth_bh(bh_frozen, n);
>                 }
> -               unlock_page(page);
> -               put_page(page);
> +               folio_unlock(folio);
> +               folio_put(folio);
>         }
>         return bh_frozen;
>  }
> --
> 2.40.1
>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Looks good to me.

Thanks,
Ryusuke Konishi
