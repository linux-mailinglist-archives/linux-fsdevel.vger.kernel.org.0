Return-Path: <linux-fsdevel+bounces-17657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3C78B11A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 20:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DAF1F26817
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 18:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6010E16D9A8;
	Wed, 24 Apr 2024 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="3cXLBL2J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D9316D9A0
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981775; cv=none; b=YvDgadr+KED93Sk25ob6knfE0zMX/3ZT3GmmtxYQ+XTcN06QpHFNK9QpmiHV5M6WxZob1O/Kl4SAd5IjOW4k47ZXBDq/A7pvgU8iov83Xmvv4qRQLnnUB6W+YrrhfeMNwXpzcbOzZhDtllf+r3AGa1XG9pYo4PXM+YrxyDCN6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981775; c=relaxed/simple;
	bh=q6S5pmCASJyGUUG0ulRx4SOz+3MV38xuPYwg1VcCAtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewRBcJc4YfvfF7RL/5QZu5Jy819Xr8mov4g0XAcPpvLURs1Ce1mBkHE4/6AWrkAX5Md06BmDKDuvTd3U7z6ML/kS6Mf+qfdpj3tZKEWzUzLzmQRGiCzatmgNNhJDu7tdeHZWapEI7kd7vmATGkSpjI/76R+YwCp043IzMUmUBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=3cXLBL2J; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43716c1616dso866571cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 11:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1713981772; x=1714586572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nevhvd1meTfPIZE67PSZAMSBr8400hsjebaOAXqzKS4=;
        b=3cXLBL2JyEaUNe+oVM5SlueT7Fml/lpMNY+liJosBuV6KCEwk/QxI+qH7+NzmFesEW
         yuZicY8SZnEmnVrPX02EOfuSVVNTJUXgq0SfEzUESIH5u6AAJi1vmzUZtQcp3NuXNg0W
         6oz41nE5YYs8+3yxbBDMVqe2e9dXAzhXI+hS5Ic7iRmzvTr9l81ymFaamb6gk198rQTX
         P9s8AwQBi6FamyVQB1YS5jaKw39vfEPbQR0NLBlaiD+VNpQVVR85rQY76exBQ9TOFpo/
         O2vOd29vB8WeJ94L8SyL0SvCT1qeGuYsH3Phne20H2Tlo2vhQCozZcyXAmSDyS2grjbS
         512A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713981772; x=1714586572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nevhvd1meTfPIZE67PSZAMSBr8400hsjebaOAXqzKS4=;
        b=k+CU2MXux9b5QaPmP4mfO0LFPa/PHJxUFPcYZLi9wRGpilzVUlz4L42zNMsKhP4Im/
         i1EWKkFnefHEwaJ2rLZ9JEW0g3hAMLvfMyffbJiNZ9V8/Kqtn8QdowPTdvAser73RY90
         cpA1sEoulYO6ymqxE1j1JMHcV82D772z1P2cQMlKm0h57FEjhLEpY04D42CmvgHK7vB6
         ZIBf7mlnkwQDkSAn2EHnRu+JrVx8Wcud10HXhI2A5BGQ0l/OUvZyaKxK6hOzUkKezSSP
         SCoYAhnU/z2Ph4rT5HouOx48eM0kyvacdPfYvnneOZuVAXn2wSgphrl6gZqtTMvITnFr
         KVeA==
X-Gm-Message-State: AOJu0YzHCO/nQ1BObUzycBjjbE3JkmGOdABCOENuUogQ42emhy6cQP9n
	wE/sIHjlgIyS8NvhnZN/4m/1bGFbsL7n4NVUDi37/AYpSmTfv9zYlPDB0D+xFzD3sPiGWTY7p28
	OpYVYMq0b+9Y+cYr61kGknfRIYz0GpK7j2iqN
X-Google-Smtp-Source: AGHT+IEZLEzW3ErvXOcewusmOzUnrSjq9J/ZI/oRg4C/1s4sDda5QLQZ0cDtCyJKmkp6UYic0DRuHkQ5H49IAP+pnu0=
X-Received: by 2002:a05:622a:2c2:b0:432:dd26:e1db with SMTP id
 a2-20020a05622a02c200b00432dd26e1dbmr4728651qtx.59.1713981771923; Wed, 24 Apr
 2024 11:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420025029.2166544-1-willy@infradead.org> <20240420025029.2166544-19-willy@infradead.org>
In-Reply-To: <20240420025029.2166544-19-willy@infradead.org>
From: Mike Marshall <hubcap@omnibond.com>
Date: Wed, 24 Apr 2024 14:02:40 -0400
Message-ID: <CAOg9mSQtqXWF400L9K4=FC453vBwrvj6Ps3PUM_V0Q5-TGoP8w@mail.gmail.com>
Subject: Re: [PATCH 18/30] orangefs: Remove calls to set/clear the error flag
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Martin Brandenburg <martin@omnibond.com>, 
	devel@lists.orangefs.org, Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I added this patch to 6.9.0-rc5 and ran it through xfstests with no problem=
s...

-Mike

On Fri, Apr 19, 2024 at 10:50=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Nobody checks the error flag on orangefs folios, so stop setting and
> clearing it.  We can also use folio_end_read() to simplify
> orangefs_read_folio().
>
> Cc: Mike Marshall <hubcap@omnibond.com>
> Cc: Martin Brandenburg <martin@omnibond.com>
> Cc: devel@lists.orangefs.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/orangefs/inode.c           | 13 +++----------
>  fs/orangefs/orangefs-bufmap.c |  4 +---
>  2 files changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index 085912268442..fdb9b65db1de 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -56,7 +56,6 @@ static int orangefs_writepage_locked(struct page *page,
>         ret =3D wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter,=
 wlen,
>             len, wr, NULL, NULL);
>         if (ret < 0) {
> -               SetPageError(page);
>                 mapping_set_error(page->mapping, ret);
>         } else {
>                 ret =3D 0;
> @@ -119,7 +118,6 @@ static int orangefs_writepages_work(struct orangefs_w=
ritepages *ow,
>             0, &wr, NULL, NULL);
>         if (ret < 0) {
>                 for (i =3D 0; i < ow->npages; i++) {
> -                       SetPageError(ow->pages[i]);
>                         mapping_set_error(ow->pages[i]->mapping, ret);
>                         if (PagePrivate(ow->pages[i])) {
>                                 wrp =3D (struct orangefs_write_range *)
> @@ -303,15 +301,10 @@ static int orangefs_read_folio(struct file *file, s=
truct folio *folio)
>         iov_iter_zero(~0U, &iter);
>         /* takes care of potential aliasing */
>         flush_dcache_folio(folio);
> -       if (ret < 0) {
> -               folio_set_error(folio);
> -       } else {
> -               folio_mark_uptodate(folio);
> +       if (ret > 0)
>                 ret =3D 0;
> -       }
> -       /* unlock the folio after the ->read_folio() routine completes */
> -       folio_unlock(folio);
> -        return ret;
> +       folio_end_read(folio, ret =3D=3D 0);
> +       return ret;
>  }
>
>  static int orangefs_write_begin(struct file *file,
> diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.=
c
> index b501dc07f922..edcca4beb765 100644
> --- a/fs/orangefs/orangefs-bufmap.c
> +++ b/fs/orangefs/orangefs-bufmap.c
> @@ -274,10 +274,8 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
>                 gossip_err("orangefs error: asked for %d pages, only got =
%d.\n",
>                                 bufmap->page_count, ret);
>
> -               for (i =3D 0; i < ret; i++) {
> -                       SetPageError(bufmap->page_array[i]);
> +               for (i =3D 0; i < ret; i++)
>                         unpin_user_page(bufmap->page_array[i]);
> -               }
>                 return -ENOMEM;
>         }
>
> --
> 2.43.0
>

