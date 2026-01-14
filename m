Return-Path: <linux-fsdevel+bounces-73800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A5BD20DD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 19:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4FC43038F56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 18:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987B63396E4;
	Wed, 14 Jan 2026 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No4lJjc9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3532E7F1D
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416081; cv=pass; b=qfgHqNnSglbAPgRb2RXFXcYpFafiSCvWSlQGJ8upANyO/pFmV2u8yM/3AQljQ8BtA5dIvAWvoSgGKMMxzN7EaikmMke7/Gtb4+/WpfKOI94aPb2t6l/wHf18svLXRx1SMF1oNYV2gvpPTa0cuzcx6q9kD9Klt/qE15oQnsQcCjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416081; c=relaxed/simple;
	bh=cO7AvlZ6VHaU8aIyizjiqGRmHzdgM+G7L3XPoh+b6pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGJtwObDuWzkSsdoczM0NdWQ6/TC2ls+C2Q/jN1ct4AvvNtKIvIh0MkJDkJPQbGNSrJQBcgmaQkT/tm9ASdaNewkTrtU/VFdnbUV2a+aVolB1GewQOXbxTCu1f+554kdPL/n56lWGbdTvUSSI8iADDBYfECHdHy1GLCvLwn/21M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No4lJjc9; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5013c1850bdso914721cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 10:41:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768416078; cv=none;
        d=google.com; s=arc-20240605;
        b=jlcVhJfrjB+5mckOa+lQBqVz5NOYnV83hijAg9e1m7kysgNeM3uFAuBPtUorScJnie
         oizbsJ4B9TF3zoYjUni5v+vk9vu/AMr6DgIuUiwPZNW84VuEthJ6xAgsArpjyd5wMTS4
         ReNcEE8XxcF1OABaXiiSvluTSSo0L2J9GPnzP2v9WkLC/V9IcRv4lB9Bzby8Z6UAmhOT
         AjHnAIV0JsfXD0crPPbPvtnSS07VlbtIj1C66eF4qqBJmgoBaSVSXEBrtt68xrPCzffi
         aDmk+fOfr7bM7iydnZ+HtFEBr2K+o44XU4QmSDg+rVGlu82P41+/XNKqLrStJ0B+Vsye
         dEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0nvtzfay+8PXzMSSNBi8aYxXpOB59iGxr6aJMbTKSHg=;
        fh=daWkBFEV+SAwfIBgLBoUTJZDwdEnCTTHXHKrER8Wgdk=;
        b=QMsfOVYYl8cmDU0uf+hVi+2ySOpy+/aqrjc/c76zMlsJQwEr7otrxv0CYxKnew3H+F
         It14WG4e+RG2gdAXUE4BMMV70J7w831a4nIYrNgi2Olf0sOSVHYZptAfEOt3Mfzy2xeN
         jQR/URqyXbyI8qCaum5oYzhwnJoQbg3LrKm+FLDXhmvo2z7A7YK6m98d8Nw6Yc6WpLpn
         I12Pmfr0i+owX1mwpKiRxcTHJGOOlkdRiGinjA3SfSL9/9bUtre0nLSxV/DxVI3a6cW8
         r23jPBa1P+X/anKPn0cVjpsJYNbvg47yPhTAtl+K3WQCp44ZhAbBgMhDAwwKPEQh1011
         J+kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768416078; x=1769020878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nvtzfay+8PXzMSSNBi8aYxXpOB59iGxr6aJMbTKSHg=;
        b=No4lJjc98Sqg6BdbIBCOenXF4p+LkXNzpEYAwzwd+LuBDOUTSFfRnanKo7Etm2d/6b
         UlrVJMBtc/3srbqBy3vN+rcIg0bff4yV3wvFDCqxOcKO1pF5tpgs32CJufw9x7pk+Ypf
         5f/bqFvVSOjMZsS7K48VGes8PTcqHHPj/qk1p79mnMu8rwnyayq/s7RubpPi4DGDZAQB
         Rjey9QgdoToZMa8RG9ANurHDvWC5yP4cc6nL4617twkSzYwfOQHytPE94QTppDKa0oVa
         ZSjt07AeuVxQ3QmPNrQGR82UJ0L4WlWu0dLDzlBXjXV4OHeumvay9DF7+4jrPnccfuuv
         uM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768416078; x=1769020878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0nvtzfay+8PXzMSSNBi8aYxXpOB59iGxr6aJMbTKSHg=;
        b=ZcJ3goj8n5JJlDnn1A7I/RdFzkD9hzUBJtSey+6+2x0B1NQ8B9PmdJRn3og8JPKd9L
         SVssCNZosqfAmEo4vg7ldjZB2ULfENFkZrWrwdn53YPqeGWYKEEEsgjhSs9K48JGUurW
         HyGEuANyR0I/sStgbVtzwTnkvyY6BlJcmD3aYRqolAcUO7eXfAckX/HmXT/b/jjfBH12
         /GzahbggLJ24DuzC7vtIYnCy5cbTnFgYKX0tKgFiktb8SD7PuIQ44DFGm71wPqdGUSI4
         Bx0d8r0JLwnRpUgigJAuwQniWNAj9dm9YlSspzU9MNYlV+eVPESZfi7PZV/M4yK0tbYh
         Ox4w==
X-Forwarded-Encrypted: i=1; AJvYcCUniRrGBZb++WeDU44MiEiRowlp6tdgd3Rp4Oy4iwPZbn/odEAq/iJ9K3jOBG0EXstM2YFWNMK/p1acaLKk@vger.kernel.org
X-Gm-Message-State: AOJu0YxSqof7fcY+R0Eq/k7svlH/4ED+da/r3ldA2n1JBc8Prao6Ccfm
	wmLfFUjKI/omlLtNNJ0MbNybbGVwCbPgRZ3o328iTx6tAf4aOiIbLq9YhS79rZTLTK9bH6hFJ4F
	Ye2zjh1qvyOet/BwdWpEzfvnb89NlV+8=
X-Gm-Gg: AY/fxX4JBil8K60YDOh9ypKeqQY5H0je3YxxmQ/u2EcCCiZE7qhiKy/8c0lNegg9dpS
	fF6qpFd9lm90e0p6KMLTiCCX2WZGLWwfbr+eBFaGdtPGQUycHDKnWHMfn+bf1/MMTTc+Bi7kfen
	bAkd9U2LugQn+2g59CW4LShqZsCm7dltTl6q5zQsbuMVG1X5l5Ylp5fuQ334PJhOhjLm+/MPCzL
	95oKjJJ8oXsKli93PuMPEtoAfKEbGpO6AJxuCyaXFQM9syg4FSGomWBTSpDQiFr8nBaXw==
X-Received: by 2002:a05:622a:1342:b0:4ee:7ee:df70 with SMTP id
 d75a77b69052e-501484adbd2mr49198291cf.80.1768416078449; Wed, 14 Jan 2026
 10:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114124514.62998-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20260114124514.62998-1-jefflexu@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 14 Jan 2026 10:41:07 -0800
X-Gm-Features: AZwV_QjlpXxbIficdAys7I8i3vb1w29UoaCEDS8rOaf-pPSe3PP3rOJUWEu-WPg
Message-ID: <CAJnrk1bjxyUw58WyiwsyBcJ0CcsBJZKNkcm_U+A+2KSmNqvjyQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: fix premature writetrhough request for large folio
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, horst@birthelmer.de, 
	joseph.qi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 4:45=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> When large folio is enabled and the initial folio offset exceeds
> PAGE_SIZE, e.g. the position resides in the second page of a large
> folio, after the folio copying the offset (in the page) won't be updated
> to 0 even though the expected range is successfully copied until the end
> of the folio.  In this case fuse_fill_write_pages() exits prematurelly
> before the request has reached the max_write/max_pages limit.
>
> Fix this by eliminating page offset entirely and use folio offset
> instead.
>
> Fixes: d60a6015e1a2 ("fuse: support large folios for writethrough writes"=
)
> Cc: stable@vger.kernel.org

This should not need the stable tag or any backports. The bug cannot
trigger until the future patch for turning on large folios lands.

> Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

This LGTM, thanks for spotting this.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Btw, are your prod systems running fuse with large folios enabled? If
so, are your servers using writeback caching too?

Thanks,
Joanne

> ---
> changes since v1:
> - add Reviewed-by tag (Horst)
>
> v1: https://yhbt.net/lore/all/20260114055615.17903-1-jefflexu@linux.aliba=
ba.com/
> ---
>  fs/fuse/file.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 625d236b881b..6aafb32338b6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1272,7 +1272,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io=
_args *ia,
>  {
>         struct fuse_args_pages *ap =3D &ia->ap;
>         struct fuse_conn *fc =3D get_fuse_conn(mapping->host);
> -       unsigned offset =3D pos & (PAGE_SIZE - 1);
>         size_t count =3D 0;
>         unsigned int num;
>         int err =3D 0;
> @@ -1299,7 +1298,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io=
_args *ia,
>                 if (mapping_writably_mapped(mapping))
>                         flush_dcache_folio(folio);
>
> -               folio_offset =3D ((index - folio->index) << PAGE_SHIFT) +=
 offset;
> +               folio_offset =3D offset_in_folio(folio, pos);
>                 bytes =3D min(folio_size(folio) - folio_offset, num);
>
>                 tmp =3D copy_folio_from_iter_atomic(folio, folio_offset, =
bytes, ii);
> @@ -1329,9 +1328,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io=
_args *ia,
>                 count +=3D tmp;
>                 pos +=3D tmp;
>                 num -=3D tmp;
> -               offset +=3D tmp;
> -               if (offset =3D=3D folio_size(folio))
> -                       offset =3D 0;
>
>                 /* If we copied full folio, mark it uptodate */
>                 if (tmp =3D=3D folio_size(folio))
> @@ -1343,7 +1339,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_io=
_args *ia,
>                         ia->write.folio_locked =3D true;
>                         break;
>                 }
> -               if (!fc->big_writes || offset !=3D 0)
> +               if (!fc->big_writes)
> +                       break;
> +               if (folio_offset + tmp !=3D folio_size(folio))
>                         break;
>         }
>
> --
> 2.19.1.6.gb485710b
>

