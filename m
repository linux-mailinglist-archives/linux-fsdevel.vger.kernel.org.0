Return-Path: <linux-fsdevel+bounces-29459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6328197A03A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0BE282E4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 11:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB95B156C4B;
	Mon, 16 Sep 2024 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBzn4Hyg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63B153824;
	Mon, 16 Sep 2024 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726485987; cv=none; b=lN4fgbpBqnT0QwiU0Kv6+dsZFWdVF6sXSfYBTTkKBcQ6vbYF5QwNGnEEYszaPtNirNC25d2CLd8AGIxEhdx7T/8oEJCN9NttIMfAxr8fDv0kZUa/25gbBmpAjjwmJqRm2bVT+tcJ/Qkn/x7386+dLrt1RdZr4MO9dhNjp6ylIJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726485987; c=relaxed/simple;
	bh=kBxRN4+A9nI+jGY+SpCiXzyst+cFTPyXKpIHPn9AaEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emgx4XY1jFRQpo4sV8OkKel+IZWy5lnkw3iKz9Kv/p8d61O4SOwGBlesv3SPQCSV5Yb7qnCJFR+C2UHtRQLJH4sUXjHrSAuxormUxDzGkKGk2msJpelS2NPaZ4F3GDQ3V2CpHNM74azQWIhcn83UpaXXOH4t/p+Am5qhNt797xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBzn4Hyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4E5C4AF09;
	Mon, 16 Sep 2024 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726485987;
	bh=kBxRN4+A9nI+jGY+SpCiXzyst+cFTPyXKpIHPn9AaEY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VBzn4HygCd848/qcr8DSoVNckSNj7dp1IEeLVuQjtq9v2pWu//sOlW/jPJ0we7et6
	 Ks8OmHlxzvUk1uUabAjdRCfKH1RiMXpMWhWbfU04pFbqkE3/dzN/tRBxZzys8BNL1K
	 wMham44dcJYMk8nYiUR49hu4B5UZ7N2fCDW47Asznpi/QfAyvXSkd3npfGfkocB9Af
	 ai5CecEaKlw3LWUdx4YXMgOTI8SamXFBfM8uz0SI0Hjm0nytav8Uoi2qpFeno/G6CT
	 XVVE6Np0Z/U+YFpJg2t3Fw33hgNSxlkSk0qrnhqPxCOruiHyAJjbE0Z5E2XrNLHZ0C
	 Qx1hr3FpRk2PA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-277e965305dso1808050fac.2;
        Mon, 16 Sep 2024 04:26:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvfA+5Jp+/K26PNOqexd5KgwGyUgs0Zm0vdC+CJnvBEYqQRp7qmobkiLWHlx0AMLU0ZDzsodQ8/PGyRLYZ@vger.kernel.org, AJvYcCXrVYFwOi3igeoCtYhBT+vAFMmpJXmR/0CedusMScQk+MJo2cwWhLJ9EZ0gVy4y+hxOSOWXpmi+W2fpT6Df@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6AYArapUTiWZRpCizdLvCqfUg9Peyb5N1+2sBRPZZomreDWtj
	UVgsaZsK8YezmLWw3g0NG5297CYhmEbGlxGLcuILrornzIAUSHNeqUEZ8wbtjd7H2u6QkO4tm7H
	0+b/BlrOfNDIYeLayBwfVrpyvc4E=
X-Google-Smtp-Source: AGHT+IGv/P5tvaTcEKdJrnXglxCQCIgAgugU4dZVkbj2Mb5cj/Klpk1NLuzMsix2YFy6JuccQuKPOvwFVq9rmcblraQ=
X-Received: by 2002:a05:6871:520d:b0:277:e6f6:b383 with SMTP id
 586e51a60fabf-27c3f2c661cmr8843258fac.24.1726485986763; Mon, 16 Sep 2024
 04:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916052128.225475-1-danielyangkang@gmail.com>
In-Reply-To: <20240916052128.225475-1-danielyangkang@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 16 Sep 2024 20:26:15 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_M1x-Lzsozp=o_wqR4gODpdf8SbMwLYrLmPs_hN=p8Kg@mail.gmail.com>
Message-ID: <CAKYAXd_M1x-Lzsozp=o_wqR4gODpdf8SbMwLYrLmPs_hN=p8Kg@mail.gmail.com>
Subject: Re: [PATCH v2] fs/exfat: resolve memory leak from exfat_create_upcase_table()
To: Daniel Yang <danielyangkang@gmail.com>
Cc: viro@zeniv.linux.org.uk, Sungjong Seo <sj1557.seo@samsung.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 2:21=E2=80=AFPM Daniel Yang <danielyangkang@gmail.c=
om> wrote:
>
>     If exfat_load_upcase_table reaches end and returns -EINVAL,
>     allocated memory doesn't get freed and while
>     exfat_load_default_upcase_table allocates more memory, leading to a
>     memory leak.
>
>     Here's link to syzkaller crash report illustrating this issue:
>     https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D1406c2019800=
00
>
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> Reported-by: syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com
> ---
> V1 -> V2: Moved the mem free to create_upcase_table
>
>  fs/exfat/nls.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> index afdf13c34..8828f9d29 100644
> --- a/fs/exfat/nls.c
> +++ b/fs/exfat/nls.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
>   */
>
> +#include <cerrno>
Why did you add this?

>  #include <linux/string.h>
>  #include <linux/slab.h>
>  #include <linux/buffer_head.h>
> @@ -779,8 +780,13 @@ int exfat_create_upcase_table(struct super_block *sb=
)
>                                 le32_to_cpu(ep->dentry.upcase.checksum));
>
>                         brelse(bh);
> -                       if (ret && ret !=3D -EIO)
> +                       if (ret && ret !=3D -EIO) {
> +                               /* free memory from exfat_load_upcase_tab=
le call */
> +                               if (ret =3D=3D -EINVAL) {
Why did you add this check here? If you consider that ->vol_utbl is
NULL, this check is unnecessary.

Thanks.
> +                                       exfat_free_upcase_table(sbi);
> +                               }
>                                 goto load_default;
> +                       }
>
>                         /* load successfully */
>                         return ret;
> --
> 2.39.2
>

