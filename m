Return-Path: <linux-fsdevel+bounces-30289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68820988C83
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 00:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7303B1C20F5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACC81B3742;
	Fri, 27 Sep 2024 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKR1LfQg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C111B373A
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727476603; cv=none; b=TGq6GmV9jE8mLqfIlfYg+e0raVMNei5kiIODRbi7vX8wzV6NjlcTsULPtCiVF72VilH4VYIcEEkjZ9PT5iwpVC/umK2vC9LKnsT0wc1wrUKbEwqQ9Wj9OBy9m2QP5f6SETeZw0oKiRTYE5ULMnzBKhRcORa9ruViz7W831JNelw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727476603; c=relaxed/simple;
	bh=uJ3a9hPbPrYgFIiAHoKkZ1J21G6HOLd4NcO/otXV5A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYT4ZK7t6mGjXL/Ml5LIxt9A/UgnfDkJ56WZ6lrXo5ZGVHUcA3D2wsFXjm8qofPMPEiwoofPAwjQ29eTpK12wtGMzwdj+q0EA0fpfPDRSww1c5L0PBs8NeNxXWuSamAbRaLp2KPHyyGMg5Y3xZd9aTizgEmJ3MuJIu9rEVuDTFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKR1LfQg; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-457ce5fda1aso20045821cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 15:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727476600; x=1728081400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sl+IRmkACJD3GG4bP+dTnIAiT186YCH1FI90JiB1kYI=;
        b=SKR1LfQgXy17b3xub/AMZh+Xj4+qs5IqWbXtTVDaGa0ch20s8ulv/Y8QXRW5t1huad
         uHh6yHmTAZ2io06sFCcT02wfX8/rnTZKeuyVIB52urVI1WNSaB7FtwY0yR3Fimv5jqUx
         pBM8+XbpodvI3mx/KciFngO9yUj/HwXTFqff5qvwObTYbaHVWM80z6yGsBnO573TiTcK
         mPvKBVnMQp43z3qNLA1INvYZfaft2/kX9SWqqYXlckCddooiuNoHUC8XAH9ufVoIIOB6
         lEbM7DcO5yK56Co5Q4wEn8EPyMH5uR4kaY9bTc1fxWRqjabiai+J8rUosFT7CQijNmE6
         uEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727476600; x=1728081400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sl+IRmkACJD3GG4bP+dTnIAiT186YCH1FI90JiB1kYI=;
        b=QXJK3CG4lE06Cqz0mEYA+mew2vtMVwdXBUg8rFY5N5E0bgawc3/bxZFzoCE3DynoH3
         w5J91BkIuhw9wUGIPyQWiXXFe0B2iDeTP8kMvOcNmjOu7bMFdavOyw5uJUkmOEgK3/TH
         c7v6EllutuQK2A56vYdhOu0wR1LpskGhdG7zDvyhnsYQZQHTPGNsTXUvuRs34C0sn+G0
         l49NNr3Rl60OuVWB89Vu+yGbq/j7IbDuNesLu2gueZu/nhvjIljkAKJVWeI+kw5dBYM5
         XcGmE8pE5mPL01q/S3lGX9CBtl6tU0JQiZlM2sHWmx0Dbm2evjSfiWZXnNuNW6yZT3aY
         jD/A==
X-Gm-Message-State: AOJu0YyyuCiVmL8PKJWLxaAKbNzL0LIIvR5v14SKVYHsdIWnU8KS1euP
	qFR83zgIURN4Z46JI2nb4DWtWN5TaWzZ7WbC2jlaJjqlbAuk6u16KzpqLh9EnoIWxktJ0s8NG6p
	DuTFdiDGUbGOfAlOYqAexDN+6I6DKzoy0
X-Google-Smtp-Source: AGHT+IHASrAtH5WwP5d/yWtwcDSQ7esdrX9qEWyhSmGVQqfvD2rbMBeFSaR/sL1FAtjSpJSMbKdxN8EBsrGF2xLnsmE=
X-Received: by 2002:a05:622a:610:b0:457:ca9b:a28f with SMTP id
 d75a77b69052e-45c9f2876f9mr62767081cf.47.1727476600321; Fri, 27 Sep 2024
 15:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727469663.git.josef@toxicpanda.com> <00a02299e944530c1be03d2d31b45614bedbc758.1727469663.git.josef@toxicpanda.com>
In-Reply-To: <00a02299e944530c1be03d2d31b45614bedbc758.1727469663.git.josef@toxicpanda.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 27 Sep 2024 15:36:29 -0700
Message-ID: <CAJnrk1bkOSCE1XZ9A1itr7O_X9qX7cLg0e=1nViQnHv66gC-7A@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] fuse: convert fuse_fill_write_pages to use folios
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:45=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Convert this to grab the folio directly, and update all the helpers to
> use the folio related functions.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/file.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 17ac2de61cdb..1f7fe5416139 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1206,7 +1206,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io=
_args *ia,
>
>         do {
>                 size_t tmp;
> -               struct page *page;
> +               struct folio *folio;
>                 pgoff_t index =3D pos >> PAGE_SHIFT;
>                 size_t bytes =3D min_t(size_t, PAGE_SIZE - offset,
>                                      iov_iter_count(ii));
> @@ -1218,25 +1218,27 @@ static ssize_t fuse_fill_write_pages(struct fuse_=
io_args *ia,
>                 if (fault_in_iov_iter_readable(ii, bytes))
>                         break;
>
> -               err =3D -ENOMEM;
> -               page =3D grab_cache_page_write_begin(mapping, index);
> -               if (!page)
> +               folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBE=
GIN,
> +                                           mapping_gfp_mask(mapping));
> +               if (IS_ERR(folio)) {
> +                       err =3D PTR_ERR(folio);
>                         break;
> +               }
>
>                 if (mapping_writably_mapped(mapping))
> -                       flush_dcache_page(page);
> +                       flush_dcache_folio(folio);
>
> -               tmp =3D copy_page_from_iter_atomic(page, offset, bytes, i=
i);
> -               flush_dcache_page(page);
> +               tmp =3D copy_folio_from_iter_atomic(folio, offset, bytes,=
 ii);
> +               flush_dcache_folio(folio);
>
>                 if (!tmp) {
> -                       unlock_page(page);
> -                       put_page(page);
> +                       folio_unlock(folio);
> +                       folio_put(folio);
>                         goto again;
>                 }
>
>                 err =3D 0;
> -               ap->pages[ap->num_pages] =3D page;
> +               ap->pages[ap->num_pages] =3D &folio->page;
>                 ap->descs[ap->num_pages].length =3D tmp;
>                 ap->num_pages++;
>
> @@ -1248,10 +1250,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_=
io_args *ia,
>
>                 /* If we copied full page, mark it uptodate */
>                 if (tmp =3D=3D PAGE_SIZE)
> -                       SetPageUptodate(page);
> +                       folio_mark_uptodate(folio);
>
> -               if (PageUptodate(page)) {
> -                       unlock_page(page);
> +               if (folio_test_uptodate(folio)) {
> +                       folio_unlock(folio);
>                 } else {
>                         ia->write.page_locked =3D true;
>                         break;
> --
> 2.43.0
>
>

