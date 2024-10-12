Return-Path: <linux-fsdevel+bounces-31795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71A299B183
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 09:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C888E1C22558
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 07:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5A813C9A9;
	Sat, 12 Oct 2024 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN4xUxUK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B412CDA5;
	Sat, 12 Oct 2024 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717699; cv=none; b=DFS7kIwKYg1QRKI4BOmJszl2mB/NJeHzINFomk+OPKaF16lOFzQhJuVVP1qtUbWuzzA2ATAoQHQWDPNx/9MN1E8LmkJ4xTcrQ4m5BDJG1EGsiLOHFIYf+TkM/VL7dkf/z/oNP5aQgIz1oVBXAq1FWiLqSbp8xoRw0BqLVpzj8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717699; c=relaxed/simple;
	bh=ecbVtV23lVFHYfzJIZT2bYLRIVh2pTpPLqvxS0n2m0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+/Nnq4DneYoKUYvgg10GzjvlReWeji5LqsnOwqlel63igBwexbUMNw8Y4aCu87pmmHfs06PQKhYZeydMxhraYB0+VcEC4r2NAx+wf4Yo7fi8Ni9QmetTMMJ9RHShcfV0b8AmVa4DKN8l5aVppHVnfb87pFWBLCHLlQrV3rWlsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FN4xUxUK; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b1109e80f8so198530785a.0;
        Sat, 12 Oct 2024 00:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728717696; x=1729322496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8mOG9MbiudhfLmzoSHfBQjhy604ut/s3KlqRdwyU0k=;
        b=FN4xUxUKTgzGUUIY2uTbWvdVKH4AmeogqqA1fntF76QCssAT2LnyIUl/OoiGT7TntK
         xRlWcfNDWC3jypq16WypoZi/RlhJfQJ6s1o7I4ias34HSGUF9FloVcSTRGVJNimH7MU7
         N56Mqza8TRAbwiKeVVSF43/vvLwELtJ2+r1lrPXdVW8I+Qm+9HBEEJZRJqN5vN3HZmz+
         1CAYcJCLUuS2grkgKcGvx6dnjJcxWN56FmdqGK03D++GthbZzNuorn9Po6Hij8oaEPFT
         szSWHITfP7S9ltsFTpySSh9a63YvZVKRlzmtqmqtY+YFt8LEaKarWbqwVpYbAy9T6lbc
         /tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728717696; x=1729322496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8mOG9MbiudhfLmzoSHfBQjhy604ut/s3KlqRdwyU0k=;
        b=cmZkPnw+ymJQnvK9j4hLDINrjrHftahX1O3riGKPTJPoonKE35smozmqr39q2/0G9U
         5RPk1IUs7CiCECCpXjhLu/Z89c3X3P1Kgylj05/Y6awBiKgOHFFRLOazInTeoseJ5ApX
         3vxC42/5yqzs9THdLN41ARCG5MnhHYOldqrnOCNW1IHx9+uoTTnWrNu754iZ+MMNSXwT
         CMnS41EKKwqHolNlARMfSOIN8V7zywI0ztrUHgsbsVUT4dy2qSFcZiIV2W7CvI8TtyNx
         3pA2x/3aTosQfU6Zt49IAC2HNw57XqNv3oXT4kwotm0iL09Jt32Rzu5CKdP/b3VfSTKl
         Ivug==
X-Forwarded-Encrypted: i=1; AJvYcCU2oBS1RLRN8gbh91zUXhwf/IYH1SrJKDjZ+bv+eGi+IwhS26iA+ho554ycfW00lWR1xAY0ebj6jLqWM2O9@vger.kernel.org, AJvYcCUyTYStJ6IlAr4J7+wW0FHFUIXRkpCdSp3O5PBw/MuJyfpM1GWh8awK5kS1iuDUn0JdrVFOHcwbE9+i9hUC7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YykxgMPBAiMgI47Y32KEmPKhmNNMNHoWkTHAJLaxTnLx6ky0wBQ
	pVmmriJjUmDYimb+f7RVMVYlwFcf4YwNRm4lb0MvyuBCosXIQrSel/fc8L5v8vrIO6MJz1Dol1g
	7LsvXeqMG2Wv/dLTevUC7NvfTaCs=
X-Google-Smtp-Source: AGHT+IGjnT7YGImFjIEXFUMZV+sxVlVJd2ImPBReiAy29nuw3ytAfzXFRFKC81XvvV2gil7w07uMd7n0Mr1abG71dWI=
X-Received: by 2002:a05:620a:4587:b0:7a4:f2e9:814a with SMTP id
 af79cd13be357-7b12101af5dmr325732785a.54.1728717696486; Sat, 12 Oct 2024
 00:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org> <20241011-work-overlayfs-v2-1-1b43328c5a31@kernel.org>
In-Reply-To: <20241011-work-overlayfs-v2-1-1b43328c5a31@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 12 Oct 2024 09:21:25 +0200
Message-ID: <CAOQ4uxgGiXN-X1KbZZT=pnbhRbUSPNUJscVHn9J=Fii6fZs-cw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/4] fs: add helper to use mount option as path or fd
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 11:46=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Allow filesystems to use a mount option either as a
> path or a file descriptor.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks sane

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/fs_parser.c            | 19 +++++++++++++++++++
>  include/linux/fs_parser.h |  5 ++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index 24727ec34e5aa434364e87879cccf9fe1ec19d37..a017415d8d6bc91608ece5d42=
fa4bea26e47456b 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -308,6 +308,25 @@ int fs_param_is_fd(struct p_log *log, const struct f=
s_parameter_spec *p,
>  }
>  EXPORT_SYMBOL(fs_param_is_fd);
>
> +int fs_param_is_fd_or_path(struct p_log *log, const struct fs_parameter_=
spec *p,
> +                          struct fs_parameter *param,
> +                          struct fs_parse_result *result)
> +{
> +       switch (param->type) {
> +       case fs_value_is_string:
> +               return fs_param_is_string(log, p, param, result);
> +       case fs_value_is_file:
> +               result->uint_32 =3D param->dirfd;
> +               if (result->uint_32 <=3D INT_MAX)
> +                       return 0;
> +               break;
> +       default:
> +               break;
> +       }
> +       return fs_param_bad_value(log, param);
> +}
> +EXPORT_SYMBOL(fs_param_is_fd_or_path);
> +
>  int fs_param_is_uid(struct p_log *log, const struct fs_parameter_spec *p=
,
>                     struct fs_parameter *param, struct fs_parse_result *r=
esult)
>  {
> diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
> index 6cf713a7e6c6fc2402a68c87036264eaed921432..73fe4e119ee24b3bed1f0cf2b=
c23d6b31811cb69 100644
> --- a/include/linux/fs_parser.h
> +++ b/include/linux/fs_parser.h
> @@ -28,7 +28,8 @@ typedef int fs_param_type(struct p_log *,
>   */
>  fs_param_type fs_param_is_bool, fs_param_is_u32, fs_param_is_s32, fs_par=
am_is_u64,
>         fs_param_is_enum, fs_param_is_string, fs_param_is_blob, fs_param_=
is_blockdev,
> -       fs_param_is_path, fs_param_is_fd, fs_param_is_uid, fs_param_is_gi=
d;
> +       fs_param_is_path, fs_param_is_fd, fs_param_is_uid, fs_param_is_gi=
d,
> +       fs_param_is_fd_or_path;
>
>  /*
>   * Specification of the type of value a parameter wants.
> @@ -133,6 +134,8 @@ static inline bool fs_validate_description(const char=
 *name,
>  #define fsparam_bdev(NAME, OPT)        __fsparam(fs_param_is_blockdev, N=
AME, OPT, 0, NULL)
>  #define fsparam_path(NAME, OPT)        __fsparam(fs_param_is_path, NAME,=
 OPT, 0, NULL)
>  #define fsparam_fd(NAME, OPT)  __fsparam(fs_param_is_fd, NAME, OPT, 0, N=
ULL)
> +#define fsparam_fd_or_path(NAME, OPT) \
> +                               __fsparam(fs_param_is_fd_or_path, NAME, O=
PT, 0, NULL)
>  #define fsparam_uid(NAME, OPT) __fsparam(fs_param_is_uid, NAME, OPT, 0, =
NULL)
>  #define fsparam_gid(NAME, OPT) __fsparam(fs_param_is_gid, NAME, OPT, 0, =
NULL)
>
>
> --
> 2.45.2
>

