Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7A07A7405
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 09:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjITH0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 03:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbjITH0U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:26:20 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00DCC9;
        Wed, 20 Sep 2023 00:26:12 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-495c10cec8aso2412237e0c.1;
        Wed, 20 Sep 2023 00:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695194771; x=1695799571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQu/iPxRaWTK1rhHGERjdyj3zLGL4cZdjE4RNeJI6UE=;
        b=SeeO1Ae4kypzSNScnVBvW0bI2L1St02MQMW3+P9z20ybKAUp92VZdCNVVWRDNmn+TC
         ZXPEEHhMQmHsSw5fxpbm+9k6D2GeUnKhpBkwKBAULcGGg9b/QPmrhpnIfOeAJwpsfXiM
         hS0bXZhsCXyAOyBThHhJ0FBAREF8zfCbxYqChTGQsEWnvzqGRLtGYSlZrba+UjGDTvM1
         EQvZmYCOz8FI3Zdn41QAPJnbHlCqiQBcn5lln0FfgEIzAlwvExnlwno0ig3qqakGOe5i
         c4uK6z7C4D2/MuLTvIurodQiDlX0BvSVCpn+99qMjJMTCla8nNP+tstVgGkN+Y1RZ/Uj
         jj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695194771; x=1695799571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQu/iPxRaWTK1rhHGERjdyj3zLGL4cZdjE4RNeJI6UE=;
        b=jDA54YrDsxdOqpv/6J1b40gelbfpUpLB0+/S83F9qqdUJYMwT3gtmkVc6jpSFqIJGo
         VMzGseMsuRyPzkjTL5KJnukpgdcsRA0+Bb76e/ygsTFRTnKI+SJTi6ejZxhstL0aX1qU
         1puppQa/GbmAUDWdunCXvcUj5HabKB6H8byxzuViWG1o5ndBH12ilun1ubH3dKVGgNTs
         7sdyAQIFsK2T0YzivUWEwlY8z3LDMtLz9ovb6HBGvqJG7YOr7HIBQ1vPJNCrNUFB4T0J
         HKCOQlgn+agbk2Gsqglpgf/yjcVIVeDu/9zLaxIW4s4G9CyXRpuC8GP6zGI4dG/7Jfw5
         Rx4A==
X-Gm-Message-State: AOJu0YzRYLNF6dI9lDS1l2lnHRyqnzJjfnaXccrYiN9hAc0J0smLIuid
        2bEvwQ1PCCFJFZ68qibRncSeE7KfQ63D5yiBZqE=
X-Google-Smtp-Source: AGHT+IFQlFeFAcKAQ7LPppd3w6KDWjLwNbdHXda8Z23QhXjgisZYRRlc9Mek2KJpmLRFy8U78oSpyqfwiEocIqQmsWU=
X-Received: by 2002:a1f:e043:0:b0:495:e530:5155 with SMTP id
 x64-20020a1fe043000000b00495e5305155mr1981897vkg.3.1695194771638; Wed, 20 Sep
 2023 00:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230919045135.3635437-1-willy@infradead.org> <20230919045135.3635437-13-willy@infradead.org>
In-Reply-To: <20230919045135.3635437-13-willy@infradead.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 20 Sep 2023 16:25:55 +0900
Message-ID: <CAKFNMokf=ucSpitwt2sF-nBPJPfL02MmorwXvdcw_h1zEoB7BA@mail.gmail.com>
Subject: Re: [PATCH 12/26] nilfs2: Convert nilfs_mdt_forget_block() to use a folio
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

On Tue, Sep 19, 2023 at 3:04=E2=80=AFPM Matthew Wilcox (Oracle) wrote:
>
> Remove a number of folio->page->folio conversions.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/nilfs2/mdt.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
> index db2260d6e44d..11b7cf4acc92 100644
> --- a/fs/nilfs2/mdt.c
> +++ b/fs/nilfs2/mdt.c
> @@ -356,30 +356,28 @@ int nilfs_mdt_delete_block(struct inode *inode, uns=
igned long block)
>   */
>  int nilfs_mdt_forget_block(struct inode *inode, unsigned long block)
>  {
> -       pgoff_t index =3D (pgoff_t)block >>
> -               (PAGE_SHIFT - inode->i_blkbits);
> -       struct page *page;
> -       unsigned long first_block;
> +       pgoff_t index =3D block >> (PAGE_SHIFT - inode->i_blkbits);
> +       struct folio *folio;
> +       struct buffer_head *bh;
>         int ret =3D 0;
>         int still_dirty;
>
> -       page =3D find_lock_page(inode->i_mapping, index);
> -       if (!page)
> +       folio =3D filemap_lock_folio(inode->i_mapping, index);
> +       if (IS_ERR(folio))
>                 return -ENOENT;
>
> -       wait_on_page_writeback(page);
> +       folio_wait_writeback(folio);
>
> -       first_block =3D (unsigned long)index <<
> -               (PAGE_SHIFT - inode->i_blkbits);
> -       if (page_has_buffers(page)) {
> -               struct buffer_head *bh;
> -
> -               bh =3D nilfs_page_get_nth_block(page, block - first_block=
);
> +       bh =3D folio_buffers(folio);
> +       if (bh) {
> +               unsigned long first_block =3D index <<
> +                               (PAGE_SHIFT - inode->i_blkbits);
> +               bh =3D get_nth_bh(bh, block - first_block);
>                 nilfs_forget_buffer(bh);
>         }
> -       still_dirty =3D PageDirty(page);
> -       unlock_page(page);
> -       put_page(page);
> +       still_dirty =3D folio_test_dirty(folio);
> +       folio_unlock(folio);
> +       folio_put(folio);
>
>         if (still_dirty ||
>             invalidate_inode_pages2_range(inode->i_mapping, index, index)=
 !=3D 0)
> --
> 2.40.1
>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Looks good to me.

Thanks,
Ryusuke Konishi
