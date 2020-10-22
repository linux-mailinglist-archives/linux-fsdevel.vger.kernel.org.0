Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D44295A78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 10:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508051AbgJVIgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 04:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503237AbgJVIgN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:36:13 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FA6C0613CE;
        Thu, 22 Oct 2020 01:36:13 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l2so1235713lfk.0;
        Thu, 22 Oct 2020 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xlVNR5MT533FUS1JF8L1q49ITq1fYHlTih4/0CprSQ=;
        b=ImlF7BpC+SQJ5a+w1+aqs9+p1Ew71mi1yRUXxVt13tWxc2DD44uQJCmfV0lRGkkY2b
         0mVhfRBq9CnEB94V/EJrv0zy+QDUrbU7kABLF7qfK1sKosXGQlYSrOm6J26GCSLSsEU5
         oedsYRJjx/fBfNMzly3Uh4VcqpqDsypZsdQH3+TRYWhJ/eWOztNG31b5wL1WVFcVyIlE
         MKYeN1qiwnsoked9dPxZn9hQGco1vXOMhD1t/tbGYNLHXJ6v+LOVQrJjCsD+IP7CJPsc
         o11u+xT1dvZKsK5s0qkiMBmRkuL83bDdFoyKi4dcPvcDFwTrJPxCIYQ+T2tFok8zJY/z
         oHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xlVNR5MT533FUS1JF8L1q49ITq1fYHlTih4/0CprSQ=;
        b=CnKzhclCmbwdjqKog+wZwPTymM66EJrJfkT3hLCjimaaq4WsFzoxg4d2UH9RUyDkdg
         RIeCemznopsxxONgAb+FQl/JHiim0e1zEXwDgBLWTjJCr2T7SdqgJ/GoxNiu72K3l4WT
         /tXwvbQj5NyC8VjM9+VIZhARqaIDVqyXO3QjErKIjTs/A3MhKmhfDFAes0B8sC01dUDq
         7BlmHjONydtSk0lAMKv0VdlwDjBce+K36HXtdsCCGFblr06B2VlsWGc/U/qHsNnRnkNS
         2q3V2ZJSxWqMWm5fNDI47tWhXsXQBE0i2LmDMc2YRrGiADK/tWDJtpyn2I6g4miu2STH
         GGLg==
X-Gm-Message-State: AOAM531KKyL3Vfld3J1iGLPCXKbPeU6B1HRN1KmUF6Nhvc8lkBARReAM
        129CUo9+cdblp4dde4Bfh2auFebpUMjByaU6FMs=
X-Google-Smtp-Source: ABdhPJz69yRsxfeDbkNZj9vnFl/k1hyGCtYM1bIVOsuVk8U6DInvbj1dp6FO8ezZ5HR32cI2EPUjyHWJIROz2NHCEgs=
X-Received: by 2002:a19:83c1:: with SMTP id f184mr421377lfd.97.1603355771467;
 Thu, 22 Oct 2020 01:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201021195745.3420101-1-kent.overstreet@gmail.com> <20201021195745.3420101-2-kent.overstreet@gmail.com>
In-Reply-To: <20201021195745.3420101-2-kent.overstreet@gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 22 Oct 2020 03:36:00 -0500
Message-ID: <CAH2r5msOSo2fj4GhJgPm-+z3YFg0osJp-V7u9Tm8Vk9LfDjAow@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cifs: convert to add_to_page_cache()
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

you can add my reviewed-by if you would like

On Thu, Oct 22, 2020 at 1:48 AM Kent Overstreet
<kent.overstreet@gmail.com> wrote:
>
> This is just open coding add_to_page_cache(), and the next patch will
> delete add_to_page_cache_locked().
>
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  fs/cifs/file.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index be46fab4c9..b3ee790532 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -4296,20 +4296,11 @@ readpages_get_pages(struct address_space *mapping, struct list_head *page_list,
>
>         page = lru_to_page(page_list);
>
> -       /*
> -        * Lock the page and put it in the cache. Since no one else
> -        * should have access to this page, we're safe to simply set
> -        * PG_locked without checking it first.
> -        */
> -       __SetPageLocked(page);
> -       rc = add_to_page_cache_locked(page, mapping,
> -                                     page->index, gfp);
> +       rc = add_to_page_cache(page, mapping, page->index, gfp);
>
>         /* give up if we can't stick it in the cache */
> -       if (rc) {
> -               __ClearPageLocked(page);
> +       if (rc)
>                 return rc;
> -       }
>
>         /* move first page to the tmplist */
>         *offset = (loff_t)page->index << PAGE_SHIFT;
> @@ -4328,12 +4319,9 @@ readpages_get_pages(struct address_space *mapping, struct list_head *page_list,
>                 if (*bytes + PAGE_SIZE > rsize)
>                         break;
>
> -               __SetPageLocked(page);
> -               rc = add_to_page_cache_locked(page, mapping, page->index, gfp);
> -               if (rc) {
> -                       __ClearPageLocked(page);
> +               rc = add_to_page_cache(page, mapping, page->index, gfp);
> +               if (rc)
>                         break;
> -               }
>                 list_move_tail(&page->lru, tmplist);
>                 (*bytes) += PAGE_SIZE;
>                 expected_index++;
> --
> 2.28.0
>


-- 
Thanks,

Steve
