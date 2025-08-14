Return-Path: <linux-fsdevel+bounces-57882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BFCB26603
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 14:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B2B188B9AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9752FF648;
	Thu, 14 Aug 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtvYHf8B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C012FD1AD;
	Thu, 14 Aug 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176187; cv=none; b=NPIQ+yL0SdlOfFCPdXkhn1XtPoBia5/tSDItwppqf2yLpn4id9KAzJHkZbBWI1+gCDX6GY9G92diITCMifOmG/FJ9bi/vSt7N1JwDpcaz9ZqYLjrAkJhTah26xLTJ5xwS+oFN0cFmCa4T76g3iLJWhd093XP/uS2ByZloxu6xVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176187; c=relaxed/simple;
	bh=H+krWooNThzmoBjiMWmv9TsCAf0pn+TkzqGagctJwO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hbg7GNrWdEhBgxQzK3ga4wdEB7jN2OWjYiPYFMHofWreG2mlMD9VmXr9DSKm31dmzwqgXoaFtR38hDfeo6vPCKzGapUcTF/id46BrbjxrNQq1DIDKMnJe19Axx0+L1uNkGnEF5tgwie3x2q7TF8dOstBthmMKeOz4aShTSb5qW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtvYHf8B; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b7949f6so1850747a12.3;
        Thu, 14 Aug 2025 05:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755176184; x=1755780984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC9feQ0w/HBGjSmf5+i8MbMaxjtgIgwOC+Pl6VRFzV8=;
        b=BtvYHf8By6ymLSC9tjsWNx5co6WbqwaNkMPvGrtuGjtsgoG672xsH/BsZ1CmTamd6c
         JlJnrgZoDvonik4IHNpX6e46Wt6yKsUCYl/2FpnRPceDxP9UhXslH7TCL2U0zyprMRSQ
         zD64+hNRizfKi8FV1UnJhK6HGq/G/2yM4+Wgi/S/SgCOUyWRUmXvo6OubZt8GJpyH+Gf
         O8PSwo1nj9FWc0iuIieKcfOpewBz5AaCpAaEpDcOOtg7OW/O8sCugoSXRGvR+2Vg11X9
         SbSDxwBNx7qrGhU1a62A+LzvMhJXkGo/w3tn4ujjVhWFMchWoa+yZsw+fMteJWi5YbG6
         VOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755176184; x=1755780984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JC9feQ0w/HBGjSmf5+i8MbMaxjtgIgwOC+Pl6VRFzV8=;
        b=HVptvwy5n5FLOFeSmwK8GChtvj7kBY49Ny5uiSh6tj8QmhRb+c98tfbbCiY0qf8FMZ
         HKSycO0IvRxEOaxnZEoEvW8BgQ7JyD4rwwWF/xCJwkukEJnTHB8tFvpihNt7v/GtdSk3
         z9VAHtPQXVyO+JmU+0hS3d7/byUjTClXV/4IlegSiw4yGEBCVEnxOaMMG1lCrRT3FBxL
         8AQB1IQ3vQbvQKViFQqrLYEc9a8xpgUxAXjW1xEYbp/FN1jpVJU0jg+OdYu2tNlyFrNd
         xwnH6a7oC8eMZVI5FnIBbpqakIRj4RKz0f59h9nvnlWSTuTjagSRKox97vOlA5DKonsf
         Z+1A==
X-Forwarded-Encrypted: i=1; AJvYcCVkqPo6PNBugp6+lMcHRLCxwIRdlHgul+lkvWb+ZgrqwpK8MXwOKZ22qFro574ZmoIVDDCtGKcjWriSyAM1@vger.kernel.org, AJvYcCWx1mPYc+SNw4/sQT2JKYeYUip8F9juPnaWANGWLG87uR3XycnqrsCmnMnHsng7z0P7F40VV3SfHUae+Ja5@vger.kernel.org, AJvYcCXXgGYGEqZ9OViGgqfzCHg24ZIE9e6nOMyHeEa3r1RjQ0tf+TVsv6GAQmMFSX9YE714kamcK+mdXYK2ZFXqzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhQW8g4IPkrLXhAFlhunrSvjBbHWKguHo0tf+3g085Z8JRxI6F
	WVP5fH4BlKworsvbRrmtlqwiALRy0fjia3om3VUQpuncsrc0Pki612ke/+LkPHacaJgL8PkgjAz
	FMxwlgc0whYFHmbbp13UwMunLQDppjRs=
X-Gm-Gg: ASbGncuzRy3oKVqBf3C6b6/L7q2QVrdfU38nQtats0oHNmiY6MHGU2g7xLdvJSBLJO0
	ReesHSqCF+wn5Nkb92ok6RT2WSZMLzNLlIncgvqPNiIJbhSZuT3lgVymarAieCcGCJrL2QlHaLG
	Ozyinp+pVd3p65GTZr0UElinhUnnevRa422uAI8pEyIJzqJYaIVmCEqDXH9zUR/0u6JscJQB3qD
	H7dqsmyzz4ddGhFYA==
X-Google-Smtp-Source: AGHT+IEK1Q0lq8d+u9R/AFktm4aeA03xJJFuqG85+n2UVZLlHsrqf5xNqEkLMmGKiyhRSSgT1iGBhmBBi57YPZiJ9/U=
X-Received: by 2002:a05:6402:354e:b0:607:f082:5fbf with SMTP id
 4fb4d7f45d1cf-61891585a22mr2037965a12.12.1755176183770; Thu, 14 Aug 2025
 05:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com> <20250813-tonyk-overlayfs-v4-5-357ccf2e12ad@igalia.com>
In-Reply-To: <20250813-tonyk-overlayfs-v4-5-357ccf2e12ad@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 14:56:12 +0200
X-Gm-Features: Ac12FXxY-XTQEuehTH1k75L02fcM6ke98YEqCdMrA8NKT1sBcMdAQpQRfLtRcug
Message-ID: <CAOQ4uxi4Y7PPg8DH4NS2KhZxg0mirr3_4Dz5jiFiXBjZAdOtJg@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] ovl: Ensure that all layers have the same encoding
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 12:37=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@ig=
alia.com> wrote:
>
> When merging layers from different filesystems with casefold enabled,
> all layers should use the same encoding version and have the same flags
> to avoid any kind of incompatibility issues.
>
> Also, set the encoding and the encoding flags for the ovl super block as
> the same as used by the first valid layer.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes from v3:
> - Check this restriction just when casefold is enabled
> - Create new helper ovl_set_encoding() and change the logic a bit
> ---
>  fs/overlayfs/super.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index df85a76597e910d00323018f1d2cd720c5db921d..b1dbd3c79961094d00c7f99cc=
622e515d544d22f 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -991,6 +991,18 @@ static int ovl_get_data_fsid(struct ovl_fs *ofs)
>         return ofs->numfs;
>  }
>
> +/*
> + * Set the ovl sb encoding as the same one used by the first layer
> + */
> +static void ovl_set_encoding(struct super_block *sb, struct super_block =
*fs_sb)
> +{
> +#if IS_ENABLED(CONFIG_UNICODE)
> +       if (sb_has_encoding(fs_sb)) {
> +               sb->s_encoding =3D fs_sb->s_encoding;
> +               sb->s_encoding_flags =3D fs_sb->s_encoding_flags;
> +       }
> +#endif
> +}
>
>  static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
>                           struct ovl_fs_context *ctx, struct ovl_layer *l=
ayers)
> @@ -1024,6 +1036,9 @@ static int ovl_get_layers(struct super_block *sb, s=
truct ovl_fs *ofs,
>         if (ovl_upper_mnt(ofs)) {
>                 ofs->fs[0].sb =3D ovl_upper_mnt(ofs)->mnt_sb;
>                 ofs->fs[0].is_lower =3D false;
> +
> +               if (ofs->casefold)
> +                       ovl_set_encoding(sb, ofs->fs[0].sb);
>         }
>
>         nr_merged_lower =3D ctx->nr - ctx->nr_data;
> @@ -1083,6 +1098,16 @@ static int ovl_get_layers(struct super_block *sb, =
struct ovl_fs *ofs,
>                 l->name =3D NULL;
>                 ofs->numlayer++;
>                 ofs->fs[fsid].is_lower =3D true;
> +
> +               if (ofs->casefold) {
> +                       if (!ovl_upper_mnt(ofs) && !sb_has_encoding(sb))
> +                               ovl_set_encoding(sb, ofs->fs[fsid].sb);
> +
> +                       if (!sb_has_encoding(sb) || !sb_same_encoding(sb,=
 mnt->mnt_sb)) {
> +                               pr_err("all layers must have the same enc=
oding\n");
> +                               return -EINVAL;
> +                       }
> +               }
>         }
>
>         /*
>
> --
> 2.50.1
>

