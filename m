Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B3F7A7115
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 05:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjITDnS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 23:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjITDnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:43:15 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5FFE4;
        Tue, 19 Sep 2023 20:43:09 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7a8aec82539so1737684241.2;
        Tue, 19 Sep 2023 20:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695181388; x=1695786188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ngNBnUvO+0NVI0ss84Zb16ZvzrZCajcq442dwEgXZM=;
        b=g+3/Erv4hFKcuCv2O7BRAjQ/Sf5qNufTwuCHO9aZUPwz5wkniiYT5IFjWhmXgPAN8q
         684QC4tmy7nWrWUXjQzDY5ejXdA1KuGrHAMlUDa8J+xGEdI2KwwZ5TZBSuoa39M3vfbi
         RHzcyFl6765pSpCIPY0p09rQfEWtYwh/DI1JbABtM4cY0v5vNH7ToFbUJHw2Fn2Gyey3
         eb1/iFoFEpEkgoXxv1br7LhWwzxMbZKx9nMCtTHPROqYOpYOjXk3xMHHq9h6BqWzA97y
         M4RKms9pEfdtoNhCrIncJrMslBrnDDDS9aSOiKCAkr56NcLKzts2W7HJRHZ9VZo+sETk
         1OsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695181388; x=1695786188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ngNBnUvO+0NVI0ss84Zb16ZvzrZCajcq442dwEgXZM=;
        b=OGpk8goygr/066dtsb3sYG63ZQX/M17hLdsHQwowyI6N+Rb+ETBYiZl1erb/AcbyT7
         +oCb9DbtXYZ0WJBZKb3kPovwhp+e7HUrTZ+9AdFxgJdym2NidEsf5TRKZn+Qk7w0Y+Mw
         NV7v0ioy5sSR55FY9IH9QJilXHel9VrYphA03tT0hDk31+gb74Smuoy/6KqiRxEKO6q4
         VPEBeTwmFZLBrtUVLvc2ALtFBuYDNWMZXoSUYvv1Q7+nytbtH+nRQZoaGaIzvlO2PzVl
         z+ymc/ViGTXhX5dJhV1avXuAUXa5j2KraVFLiD+AjEbKRHW/due5kHyuTcBONIpvv5Vn
         BFiA==
X-Gm-Message-State: AOJu0YyyWP6xK5aiN96YqmMh4ANQHOeLKwt6y7v15+HjOC8rtXqg0QK6
        sMcfuJce5ExH7dtf4gHunmtIlkBEBE9Qp9V+QYs=
X-Google-Smtp-Source: AGHT+IGPPyxUdWQmz12+jR8GRkg4Q7xlkbrev/wkMNzsTNm8rjJQLm794z9bRnC0gXpAvfWgdwBP7VgL2CwiFhgTFmo=
X-Received: by 2002:a67:f3d0:0:b0:44e:bc13:b761 with SMTP id
 j16-20020a67f3d0000000b0044ebc13b761mr1886156vsn.14.1695181388190; Tue, 19
 Sep 2023 20:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230919045135.3635437-1-willy@infradead.org> <20230919045135.3635437-10-willy@infradead.org>
In-Reply-To: <20230919045135.3635437-10-willy@infradead.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 20 Sep 2023 12:42:51 +0900
Message-ID: <CAKFNMokgW2Js5RUpLujf72C+vpMmJbLM=0OfDpD6MvGwLWFphw@mail.gmail.com>
Subject: Re: [PATCH 09/26] nilfs2: Convert nilfs_mdt_freeze_buffer to use a folio
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

On Tue, Sep 19, 2023 at 6:09=E2=80=AFPM Matthew Wilcox (Oracle) wrote:
>
> Remove a number of folio->page->folio conversions.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/nilfs2/mdt.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
> index 19c8158605ed..db2260d6e44d 100644
> --- a/fs/nilfs2/mdt.c
> +++ b/fs/nilfs2/mdt.c
> @@ -560,17 +560,19 @@ int nilfs_mdt_freeze_buffer(struct inode *inode, st=
ruct buffer_head *bh)
>  {
>         struct nilfs_shadow_map *shadow =3D NILFS_MDT(inode)->mi_shadow;
>         struct buffer_head *bh_frozen;
> -       struct page *page;
> +       struct folio *folio;
>         int blkbits =3D inode->i_blkbits;
>
> -       page =3D grab_cache_page(shadow->inode->i_mapping, bh->b_folio->i=
ndex);
> -       if (!page)
> -               return -ENOMEM;
> +       folio =3D filemap_grab_folio(shadow->inode->i_mapping,
> +                       bh->b_folio->index);
> +       if (IS_ERR(folio))
> +               return PTR_ERR(folio);
>
> -       if (!page_has_buffers(page))
> -               create_empty_buffers(page, 1 << blkbits, 0);
> +       bh_frozen =3D folio_buffers(folio);
> +       if (!bh_frozen)
> +               bh_frozen =3D folio_create_empty_buffers(folio, 1 << blkb=
its, 0);
>
> -       bh_frozen =3D nilfs_page_get_nth_block(page, bh_offset(bh) >> blk=
bits);
> +       bh_frozen =3D get_nth_bh(bh_frozen, bh_offset(bh) >> blkbits);
>
>         if (!buffer_uptodate(bh_frozen))
>                 nilfs_copy_buffer(bh_frozen, bh);
> @@ -582,8 +584,8 @@ int nilfs_mdt_freeze_buffer(struct inode *inode, stru=
ct buffer_head *bh)
>                 brelse(bh_frozen); /* already frozen */
>         }
>
> -       unlock_page(page);
> -       put_page(page);
> +       folio_unlock(folio);
> +       folio_put(folio);
>         return 0;
>  }
>
> --
> 2.40.1
>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Looks good to me.

Thanks,
Ryusuke Konishi
