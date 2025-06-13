Return-Path: <linux-fsdevel+bounces-51618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C97AD964B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 22:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395313A9577
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 20:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3E324A041;
	Fri, 13 Jun 2025 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8JK1l3M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D0E24676D
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846696; cv=none; b=RQelxL/Rp40MVA+D5BNZOwwvqUs5ymCnB7sQN8M9eEGkz7Raq4yQB9o9ID/KhWiEpZG6OMxZWU0crR48j2dC7zwDkBXtc5fx+oz4q0+rf4RaVh90uyteIl3Mrh9JtuUq/WtGsdp7rQaqElXze5PanLKbMsMGo3jfFJTPvOuG4Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846696; c=relaxed/simple;
	bh=W50Lkr5REka+YbWIrKW0Rlp2DJar2xiGj2SU6nj2DwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZEge4xPA2dIl5MFtmn69UxGLdWXr0PJ5NDq2ZZMcm+P3kIjaAc9OWktTyMZ/FgyANvYzpklicd0yarHLhnHW9L1jtj/rECk29efAPSlegPB52GehZcOwxYezFLMB4sPv+5qwrWiddb5YnCP4UoqkDbguonPPw0vs1p3sABtK+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8JK1l3M; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a58e0b26c4so44465491cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749846693; x=1750451493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cC+1swhZihd+yIo68YlKvWKbfjHljezJd35OfrZ/SaM=;
        b=F8JK1l3MkJbS9hrwdk0IovaGbO5TKWmZapa8bGK1FYbWqTrSNLB2jq719+uVV95y2b
         R9QiYrUwkKPkyaqQ6NOiNxrIMabiGXhLulHvWSfILurH2YhkYg8kgpZ5t3aO4EcudsbO
         8EmCazO5ozIthxgOmdSkwTAKuviVONw+IQMwq6HK56K+gj41Gifp+vTUczpj24C0e0zV
         Gi6ZQSrHTdCfYqo6ZERtAU3Pjxfh4CIJo71yXcl6uN6BH1FoAN08tdcu/RPLhngXaOf7
         C1KDbhRPo3Fi7Lwo1zfqDUdeb9Eo1e4RXYOb13uc5DQyuP0omCzqXZJSKyCAczJx6TJL
         R6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749846693; x=1750451493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cC+1swhZihd+yIo68YlKvWKbfjHljezJd35OfrZ/SaM=;
        b=YY5/3FIYDpkziEhPoA87BJ4tT3zs0WQlVL9JMGc6UaruZg2mKab5wgLBcyTLIt5MXk
         mo/VAGDv+zUmRKWWWSYIfIofiOOpfh1vHHGdfwq+YPqXJ4yXr3uyTkC533NSUQ9+yQv7
         eiDU0EYdheOsivR4ywZxqQ4X7DV6uzLz8QYxc86d0a8mqvxLZszJDIWTuqbVFhIpcKoD
         2anSzn5Rkowcjo7U7fixYQ5g78L/M6pqjzLeN/nH+hBzrQ/0zmDD8i+KGoSO+Vx/zRvM
         Y9D2mTIyzKKG37RRuxGbWTbrppNQN0P2qRN4ZYPkZw9B8MpT6QTgmMwCPAakP5AZnYcb
         tPkw==
X-Forwarded-Encrypted: i=1; AJvYcCXGcOF53aO2H4gstNB6XRRlBGTcluU3SZ3Y/4F3CNkhF2wkg9zEF9IL9uLq7mUK/zzyy16o0yc1AVHC5DqS@vger.kernel.org
X-Gm-Message-State: AOJu0YznpwEZ/HPKV4h6xb2NodO47VxGcAFtLxhyduyx6eOSx+UEnD2q
	HfVEuoaBZKMJLgAhXOKGhDFDJlZFVwd99FanuxT3/w6lf6rAKwpt5nnc2U61jXhlDuZQi/Exq1A
	0fag1o1NFmMvFt0/FwOr/KXLrmdRKTnv2V8hq
X-Gm-Gg: ASbGncs1dYBqIHe9ZMpUDvGxC7VvjfIn7CpFxiqV80qH4sN7ipRs/p5fO9HTUPJCh2Q
	vQNlkZ9gpUp7uFUN52Ecqk2CY9rr5jR9xDUccG4ZWWm5WlTXWTsSUju3Z7QprqoWAyG6DXVDP0D
	UzDnHsOVQtr++iTJsrN3KIeEpT8nVVHmu/NgqUNZ9jZJn2e/xdcrWVoba12tI=
X-Google-Smtp-Source: AGHT+IFeXWhHl9N/z1dogvN08jcU3FFXJ7mRKwL03eZbZXSO2JU2mqoXsjmdRlJcqTFkjH4WBYgURUXBaQbPRBRwKxo=
X-Received: by 2002:a05:622a:14f:b0:476:8e3e:2da3 with SMTP id
 d75a77b69052e-4a73c62de4fmr9851961cf.30.1749846693468; Fri, 13 Jun 2025
 13:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613164646.3139481-1-willy@infradead.org> <20250613164646.3139481-3-willy@infradead.org>
In-Reply-To: <20250613164646.3139481-3-willy@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 13 Jun 2025 13:31:21 -0700
X-Gm-Features: AX0GCFvJKEMK0mU0QTzVNTrTvBXbAbxUkL5WjF03qIHg2HujchfJkOM3JuE-GUs
Message-ID: <CAJnrk1YSrdfMP4SRgTtACeT7Kx=kr9t+CuBN0OCzxwBZkdJVEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Use a folio in fuse_readdir_cached()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 9:46=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Retrieve a folio from the page cache and use it throughout.
> Removes seven hidden calls to compound_head().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/fuse/readdir.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index 09bed488ee35..37abf4e484ec 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -452,7 +452,7 @@ static int fuse_readdir_cached(struct file *file, str=
uct dir_context *ctx)
>         enum fuse_parse_result res;
>         pgoff_t index;
>         unsigned int size;
> -       struct page *page;
> +       struct folio *folio;
>         void *addr;
>
>         /* Seeked?  If so, reset the cache stream */
> @@ -528,42 +528,42 @@ static int fuse_readdir_cached(struct file *file, s=
truct dir_context *ctx)
>         if ((ff->readdir.cache_off & ~PAGE_MASK) =3D=3D size)
>                 return 0;
>
> -       page =3D find_get_page_flags(file->f_mapping, index,
> -                                  FGP_ACCESSED | FGP_LOCK);
> +       folio =3D __filemap_get_folio(file->f_mapping, index,
> +                       FGP_ACCESSED | FGP_LOCK, 0);
>         /* Page gone missing, then re-added to cache, but not initialized=
? */

Should this comment also get updated to "Folio gone missing"?

> -       if (page && !PageUptodate(page)) {
> -               unlock_page(page);
> -               put_page(page);
> -               page =3D NULL;
> +       if (folio && !folio_test_uptodate(folio)) {

I think you meant "if (!(IS_ERR(folio) && ..." here?

> +               folio_unlock(folio);
> +               folio_put(folio);
> +               folio =3D NULL;
>         }
>         spin_lock(&fi->rdc.lock);
> -       if (!page) {
> +       if (!folio) {

same here

>                 /*
> -                * Uh-oh: page gone missing, cache is useless
> +                * Uh-oh: folio gone missing, cache is useless
>                  */
>                 if (fi->rdc.version =3D=3D ff->readdir.version)
>                         fuse_rdc_reset(inode);
>                 goto retry_locked;
>         }
>
> -       /* Make sure it's still the same version after getting the page. =
*/
> +       /* Make sure it's still the same version after getting the folio.=
 */
>         if (ff->readdir.version !=3D fi->rdc.version) {
>                 spin_unlock(&fi->rdc.lock);
> -               unlock_page(page);
> -               put_page(page);
> +               folio_unlock(folio);
> +               folio_put(folio);
>                 goto retry;
>         }
>         spin_unlock(&fi->rdc.lock);
>
>         /*
> -        * Contents of the page are now protected against changing by hol=
ding
> -        * the page lock.
> +        * Contents of the folio are now protected against changing by ho=
lding
> +        * the folio lock.
>          */
> -       addr =3D kmap_local_page(page);
> +       addr =3D kmap_local_folio(folio, 0);
>         res =3D fuse_parse_cache(ff, addr, size, ctx);
>         kunmap_local(addr);
> -       unlock_page(page);
> -       put_page(page);
> +       folio_unlock(folio);
> +       folio_put(folio);
>
>         if (res =3D=3D FOUND_ERR)
>                 return -EIO;
> --
> 2.47.2
>

