Return-Path: <linux-fsdevel+bounces-57168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826B9B1F401
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 12:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43474726B6B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B591E221FB1;
	Sat,  9 Aug 2025 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ+lPAPj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B652F252292;
	Sat,  9 Aug 2025 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754733701; cv=none; b=MSjv84sSbgzC5LYJIzNFj4NZO0qcLgBBhOyjTMjxL+pCYKcgTZ52VhMZ7MXSwez7J78/qEnpBRWQjMJWLHAmFczne0H8ZasClJa7BD+boWlx3gPz3iu20PkuZsP8TRu2EEdJDPc0feK7aEpKIyzvu5ZUsbmgptMH4mgfksRNjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754733701; c=relaxed/simple;
	bh=az885+90iLBhcRYBBw/buQhmprKt9Gsei0KvAVcbtQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aEfjpJn2kcMVVuTpl4ilwijVh/mktbB4Up/ymmCOaokez6VhNJYqY2pBaJIgQJS0DigPJ8EhJM80/UlRJ2k4dtSGID5MqVoh4oDKY9i4+bdgdYoYcJH+vkwXx1DU0TOA5D2lXm0NnyGSNHkPbplh7lzr9w9qkif2iv2revQO7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ+lPAPj; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-617d24e7246so4383326a12.2;
        Sat, 09 Aug 2025 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754733696; x=1755338496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8mMRa/M3Y0T73jOiSL73hGVow9fICclLp12FGiAzKc=;
        b=CQ+lPAPj5k7tuflBHhcWBErE73ZG8WjlqeYnyObMsN1nW3fFtAbBXLJTi8L54Z5UWq
         fvCewcsZ3kioMZPtq34fLi2lQ/3YgDaFxNvJ3bQsvePEL6IBm0k/bPNvSIdsmppr6uxh
         +Q/a6DCH2mSgTR4zuUZaW0WEnijUIGDLPymbOXn3o+VAF7EatzVSxSUaf0Ark2WVcX0R
         AjS5crj9fHoe6oBwcKplPJUddw2ChGRi4V1oZqeivdz3kHLcTaXaOhPE7I/DUz+O5KDu
         hhn4bkHvSxbfWeaiUzcE6kPY7IEchlmQGH7e3OQR4WfrJ373ggmdSszXxdNZifgGWTXc
         bxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754733696; x=1755338496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8mMRa/M3Y0T73jOiSL73hGVow9fICclLp12FGiAzKc=;
        b=QiewEqrnw2TNd83VIz0rgYJCDk16+0DOdX6wIFfsMqMTC+8craZRfS73F8Rp/1Smfk
         UVUnHudbmGicmr1q4G3Xgg+JmB/+OZXAcI2Og3ymkVqX6P7Na3sDdGhZMBRFN5lxU+2X
         2cT1pN5KLwKshMhcYqXHX1fFYK6dUWSHmP0FD+Ur9KYf1l1QF7dC1N2rgjJ3HsRsP2n5
         hxqKgimMuGqT6HvW7dIRh6y9xSQNV+dgjuo8wM0lZnovDzXw0L978gLucdth1hkVPJdu
         MWyPdBoRECpPyDpmdrzwBgG0drup/K6Ftsl6pGCNgv+eQQPk/+Rz9LlXhWh0TUmeueRY
         AAlg==
X-Forwarded-Encrypted: i=1; AJvYcCUs7h5Y7hQXCR82YXD7nZpMp5r3xRyhCq8oSYvImDORpL2bhCiG1KgWoxGPl6SmffqStCYLpx2ulQvmjKhx2w==@vger.kernel.org, AJvYcCUxRpdJ0aHzrlSTsWdfktHX3pKFcLRldpMsOFDajEeSclbnQ5IKP8wd2mw7qFpMeH0TnEKv18tBfeAPxWod@vger.kernel.org, AJvYcCVIHy1syOMP0L5Aryumoy/q1ptd8zFGWNRwAP95U7U+J8lbKnde99gxsZypVvD0LrexZhX6c4BLXkYI/9PY@vger.kernel.org
X-Gm-Message-State: AOJu0YzexEZYATztcOkJqLCCf3tIjDqTCAC1HlDK2RCFXgX7oMZFsfuz
	nM+0H1wSubp4wvZ9g8TnGknYoF0gneJ5z3H7x8Y0EqwWzv1ZqiAFj3AyXAWkPTVHLIvFJ99NBl7
	Ec1BWVC2R60qqgNz18Yddsg6AJsS//bg=
X-Gm-Gg: ASbGncsUEuPXXGBea3BbMUdJXs5EL8ZehKrmhWXuW4z+3dzhVGtssgjtccFCewUvpSa
	XQlaZbrYyKr8wEwO45eqr/fCZDadfNhfBTgeJhVX3qCocoRkEkPqAabOWFho4Bg0+CSNHKhRFI/
	PzQVzgJ3LYQ8qA2ohAkhT/Mp/FzG574C+aNrhNizUy9228KkfyjMobLmbAAzGmgpStBQYN9yvAd
	U0qyrE=
X-Google-Smtp-Source: AGHT+IFD9nf2IbRwxa01dS7TJ7qpk6yA7P1KMZFU3dhM1iF7Xslmx+mig/rAcU8xsKlgbrhW0Akte21RGjtoY5YSYMo=
X-Received: by 2002:a17:907:971c:b0:ae0:bd4d:4d66 with SMTP id
 a640c23a62f3a-af9c638542cmr571245566b.27.1754733695776; Sat, 09 Aug 2025
 03:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com> <20250808-tonyk-overlayfs-v3-3-30f9be426ba8@igalia.com>
In-Reply-To: <20250808-tonyk-overlayfs-v3-3-30f9be426ba8@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 9 Aug 2025 12:01:24 +0200
X-Gm-Features: Ac12FXwf1uKpzGeKHFlErlj6DDCkfrtWh-IWgN_pK10SWVEAb0YoJSWU4j_aJpo
Message-ID: <CAOQ4uxg3d4CoJd49gNFnqfjeOS1AC5nGXLuVsoWppaNcWvVx9g@mail.gmail.com>
Subject: Re: [PATCH RFC v3 3/7] fs: Create sb_same_encoding() helper
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 10:59=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> For cases where a file lookup can go to different mount points (like in

s/can go to different mount points/can look in different filesystems/

> overlayfs), both super blocks must have the same encoding and the same
> flags. To help with that, create a sb_same_encoding() function.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

With wording fixed feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
> Changes from v2:
> - Simplify the code. Instead of `if (cond) return true`, just do `return
>   cond`;
> ---
>  include/linux/fs.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index db49a17376d124785b87dd7f35672fc6e5434f47..d1fe69f233c046a960a60072d=
5ac3f6286d32c17 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3746,6 +3746,25 @@ static inline bool sb_has_encoding(const struct su=
per_block *sb)
>  #endif
>  }
>
> +/*
> + * Compare if two super blocks have the same encoding and flags
> + */
> +static inline bool sb_same_encoding(const struct super_block *sb1,
> +                                   const struct super_block *sb2)
> +{
> +#if IS_ENABLED(CONFIG_UNICODE)
> +       if (sb1->s_encoding =3D=3D sb2->s_encoding)
> +               return true;
> +
> +       return (sb1->s_encoding && sb2->s_encoding &&
> +              (sb1->s_encoding->version =3D=3D sb2->s_encoding->version)=
 &&
> +              (sb1->s_encoding_flags =3D=3D sb2->s_encoding_flags));
> +#else
> +       return true;
> +#endif
> +}
> +
> +
>  int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
>                 unsigned int ia_valid);
>  int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *)=
;
>
> --
> 2.50.1
>

