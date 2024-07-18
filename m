Return-Path: <linux-fsdevel+bounces-23949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39209935124
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 19:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF3A1F22878
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 17:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D899714533D;
	Thu, 18 Jul 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaiaxQFS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A56E144D10
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721322863; cv=none; b=OvHPIhvKawa2B44Mv3KUROXRAX22Y7cELTJ2i+RMFHAJkHO0TNk0eYh/8KwOQkNTfpLGbgsddnp2lrZnJe5WzyGfekwFI/wBEPz0OAEjZURfBTFX47tIc7Qf4HSDKdueJ4FvKjvBSupC5ev/gyFmBIbLtg4dcuNjPbFtQFX+kjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721322863; c=relaxed/simple;
	bh=YKhP/xX+9ov930w1am1v6T07A1GWxB3Rfd+zdPCwd7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBj2VptIIlnkOPCBidmVdsrWZ7U1qD43UMGWEwLjSLsUHijQC3vyJhoLhsNErQub6vRWiWcA/7P3klQ7JobO2Dk3OPu4NedN7v+ZUTFtJfSu/acuIWmgsjrHb7KAX0B4KtKev5UyEvBUpINr6u4oIqAYn/KcaIGcd6ahtxNDvM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaiaxQFS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso16080731fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 10:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721322860; x=1721927660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfNpQDRrtdR4dXwaL8kqT+LoC/XknaKv70zK13zN35U=;
        b=gaiaxQFSjSWk3gY0ECV4eeQlap9z7wc5w24ahQxfLFOMBCGhCAQAVjtZ4X8T+shNw3
         4PDRPui3f8qJDl3j0tHJDh3xDVfP3DDBMcq3IFLu0erF2U1FfcEzf9R7QEVBxuWv1O8/
         7Kb+PqiyusjLUPm8e+PJUeBbsWgrmNK00NO8dWa89Vz36949LQ0pOBQPZ82kMX7W/FeS
         EJ2R6cdOgXytAlIpAMkwhbFxNA7XEEAhdXQwNHcZJ/wCo+mWvetFBtJ3jKGk45lTZKP7
         GSHyzqh8RAOdQ0mXWbY5oQbGeQl/zPNY/WCvckskXpu6qaE4LDWkrLG9Sfpx/xXjskoY
         6WGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721322860; x=1721927660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfNpQDRrtdR4dXwaL8kqT+LoC/XknaKv70zK13zN35U=;
        b=oCK+NoyMj8iM5/nccwZ73FTp86KY/OcZ8YZsuGpN367FrhRUP7u04y9tCXu2Dom+le
         4e8LWAXG3Z5Az9hsN266UMnitf9aWa5QKxOjicXbQkedsP59kyfThuC85QTO7cWl19Rm
         F7LwCXAuKDS049cZTJrmwbXa5+ehn1Bb9FeG9WHxKm+rhZJP2tE+bf4/v+VyvIg/CDGo
         OBQs3ChqMwg7mzNr6CjWajZ9I6v8xu4+/BOe9mKG1irOI6gk/rFwyaVE/DKHuGG5Ygir
         AtdCFKwnwYOuU/uxwfh4BumWGRWgLlahhZHx8+0a4FPhw/vnQ8j3rtesKR4fXNK2MyKj
         HtXg==
X-Gm-Message-State: AOJu0YxJr6E0hgRIcXr4k4jo+ZBXU5HBIMyB83uLB5Fdv5Z+gLgu19KZ
	BBQn4MnrFe6qhJyPsYzlrZoXjWvt2wvxu6KMF/HFANF1ZJFrvfvb6jCeZIp9Rke6MQi2PXdHbus
	KkwZQOcaw8rq7hj8h/qEJbVZmb8LVChKO
X-Google-Smtp-Source: AGHT+IGFh+OFTuOD6F/KxHTkXXoqcFVeoA02k36qmHUY8QHgIxyHpNHYG3wkUFjbb5k0NU9qrqPZ+aIx4TyOFs8lAs8=
X-Received: by 2002:a05:651c:1052:b0:2ee:4f93:ae25 with SMTP id
 38308e7fff4ca-2ef05ca1e53mr21433201fa.29.1721322859404; Thu, 18 Jul 2024
 10:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717154716.237943-1-willy@infradead.org> <20240717154716.237943-6-willy@infradead.org>
In-Reply-To: <20240717154716.237943-6-willy@infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 19 Jul 2024 02:14:02 +0900
Message-ID: <CAKFNMons45kMv80MEM554Jmn8Ep-2b=RFFKZ=1HzyU07tTOAqw@mail.gmail.com>
Subject: Re: [PATCH 05/23] nilfs2: Use a folio in nilfs_recover_dsync_blocks()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 12:54=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
>
> Replaces four hidden calls to compound_head() with one.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/nilfs2/recovery.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>

I've checked this patch (and the big-bang patches as well, mainly for
the nilfs2 related parts).
The conversion was straightforward and I didn't find any issues.

Feel free to add

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

to this.  Thanks.

Ryusuke Konishi

> diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
> index b638dc06df2f..15653701b1c8 100644
> --- a/fs/nilfs2/recovery.c
> +++ b/fs/nilfs2/recovery.c
> @@ -499,6 +499,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilf=
s *nilfs,
>         struct nilfs_recovery_block *rb, *n;
>         unsigned int blocksize =3D nilfs->ns_blocksize;
>         struct page *page;
> +       struct folio *folio;
>         loff_t pos;
>         int err =3D 0, err2 =3D 0;
>
> @@ -522,6 +523,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilf=
s *nilfs,
>                         goto failed_inode;
>                 }
>
> +               folio =3D page_folio(page);
>                 err =3D nilfs_recovery_copy_block(nilfs, rb, pos, page);
>                 if (unlikely(err))
>                         goto failed_page;
> @@ -533,15 +535,15 @@ static int nilfs_recover_dsync_blocks(struct the_ni=
lfs *nilfs,
>                 block_write_end(NULL, inode->i_mapping, pos, blocksize,
>                                 blocksize, page, NULL);
>
> -               unlock_page(page);
> -               put_page(page);
> +               folio_unlock(folio);
> +               folio_put(folio);
>
>                 (*nr_salvaged_blocks)++;
>                 goto next;
>
>   failed_page:
> -               unlock_page(page);
> -               put_page(page);
> +               folio_unlock(folio);
> +               folio_put(folio);
>
>   failed_inode:
>                 nilfs_warn(sb,
> --
> 2.43.0
>
>

