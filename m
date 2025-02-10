Return-Path: <linux-fsdevel+bounces-41396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E809A2EDBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 14:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA123A8058
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 13:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3362122E402;
	Mon, 10 Feb 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUw5SG4w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C222CBF0;
	Mon, 10 Feb 2025 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194031; cv=none; b=glebYthoXpoetsVcW3cwteNYSO6RFcdOQV0ra8W1JL0S1Cw4eaGyAbQGGG8d25cifeN7FCXsvMKLnJerMm3BAit/Dx9cXX3IMIFuk/wIveQjl1L3OQr8PDK/hzBdN0fZIgMZJmnRv9Efg5Xt76Y5hBtL5xKzNXM0Pjp0qWi56nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194031; c=relaxed/simple;
	bh=JG137+wVJR35Xb2Lwl9Tp8s9PIn8BsCMpROGSvTtSNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGMGkl3nCgjkk3h+6fMoVpRZfy+s5AS5UXq6/pJcHtSHVj+Pd83uBVDvrN/rSATGKT04vfUBvXJCkPezh7juwKRO8qtfwO8o1cIX3LlIwg0WRXmfhEhI/Zd2dTDp69rzi3jRlFZ2BcQWCnpU76B1gE1sEGMi4np2R6dUpeae9D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUw5SG4w; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so646916166b.3;
        Mon, 10 Feb 2025 05:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194028; x=1739798828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKfrkYSNYGseqTKIlquzIIAPBMHuIR1EbIObrXoKY8E=;
        b=HUw5SG4wmxAsTmP0eLpf8spysy4fiAKUBDCDZ2U9SRpQdgLF32s8ZuGfFZLstx3/+i
         sjl24qNJtlGRGiumyQFFoPKeV1X+rPVFvvpeGJkVKD2UHk1pXXjd+bIAAm++LgFB4wxs
         vbRVVwBWWhdxPYsnl5zk7iW99HRMjGVcPbu8H1xcUuXDyv4zZgBVhCsIzQrVQ0y4GQMT
         5jgcoSlhTndSN10uzZrdwzMuqkNs9Ow7aLj1pwxlyvTOOElBT6MxqOpCuZo3sUbfzsVW
         EmP34mIbNpYrFHyq8fULZkqYSXS/+BNBZ2oTIaZny1OsuluZfvCyjc56dpZYdGuXTT64
         MCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194028; x=1739798828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKfrkYSNYGseqTKIlquzIIAPBMHuIR1EbIObrXoKY8E=;
        b=n6N+KR9B0XrAJYpQrlXnBY5P2qtPolotC6jb4U5tdYxpRO4VJhuDffEC0KGoF9G55l
         k7i5r0Nso+bLCjtm9LCfFJVG+0nh8Hdg0TWDRUQfwIVDIokG+6TxP45879uA1zJ32D7z
         IdlNxrA/gMJzTVvnzqL+2fWbyLob8iI1ilskLiJ20SWv2JubzW8wemmmbqmjqnRR1g78
         eH4uXJCdKtD6lvZDRetsiIO1JHNUMzEPgj5IUm6lVg5cvdf8V+uAHPUgkZogBG6U27Au
         SpOZ4bicnC3hmLFmuVGm4WNg2U2XgZ0G0HzVSiN6vF+KoBjgwTNknfjUtzEQ6GZT6vf0
         aSrg==
X-Forwarded-Encrypted: i=1; AJvYcCXS7uFyti7FC1NOjsWAULAEbPtaCTz4hWQUR2pAHEfzqsJoxR3ouct6GvMJggppbcUMlgbF7GdRp56OQbyL@vger.kernel.org
X-Gm-Message-State: AOJu0YzdD1FQdVk4cHVmhAJXFALaOxlc0XVFi81NEYPP5t9MTJr5LczJ
	inJs+qpYCG1jak96ZKkdvSUqZiAjXuAtPT2pdnp8U1vpd/EqDsjokW98AawlUJgZqnI6YptHzZr
	DgR0MVn+K2Z6AifDpjiObQGa51ZQ=
X-Gm-Gg: ASbGnctDGgGfxCGAFPxnabBZ+4C8R5asEI5z8ba23yJ9Qm5tdwAzDCkoI3VuQZOkDvN
	QB2Ul/UxVTWylOE6ihiOdcX5lMOJLdJUZh8lQk+MQ6tv7s/if1w12xXSybIjoceYrKRYS7M6X
X-Google-Smtp-Source: AGHT+IHaQ9Ht+GfxlNdtWsVMwUIdYrHDdHAOmLP1Kh5Kn0CzLdXKez91cYQP8sgUIR/jIPlL+B3o4CQtt+CPqpPQpAg=
X-Received: by 2002:a17:907:6d23:b0:ab6:949f:c52f with SMTP id
 a640c23a62f3a-ab789aef87emr1208294466b.28.1739194027468; Mon, 10 Feb 2025
 05:27:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-work-overlayfs-v2-0-ed2a949b674b@kernel.org> <20250210-work-overlayfs-v2-1-ed2a949b674b@kernel.org>
In-Reply-To: <20250210-work-overlayfs-v2-1-ed2a949b674b@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 10 Feb 2025 14:26:56 +0100
X-Gm-Features: AWEUYZl0i0RkYKsmEtsyroeltjWQ8UTpcYFTcQy0mXH2BfHzUfkE_P0xPacWaWk
Message-ID: <CAOQ4uxgzv-k2hL5pecxt=+2AyRkdr+LGvm9wYYuWxs9LQyyN2Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fs: support O_PATH fds with FSCONFIG_SET_FD
To: Christian Brauner <brauner@kernel.org>
Cc: linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Mike Baynton <mike@mbaynton.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 1:39=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Let FSCONFIG_SET_FD handle O_PATH file descriptors. This is particularly
> useful in the context of overlayfs where layers can be specified via
> file descriptors instead of paths. But userspace must currently use
> non-O_PATH file desriptors which is often pointless especially if
> the file descriptors have been created via open_tree(OPEN_TREE_CLONE).
>
> Fixes: a08557d19ef41 ("ovl: specify layers via file descriptors")
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/autofs/autofs_i.h | 2 ++
>  fs/fsopen.c          | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
> index 77c7991d89aa..23cea74f9933 100644
> --- a/fs/autofs/autofs_i.h
> +++ b/fs/autofs/autofs_i.h
> @@ -218,6 +218,8 @@ void autofs_clean_ino(struct autofs_info *);
>
>  static inline int autofs_check_pipe(struct file *pipe)
>  {
> +       if (pipe->f_mode & FMODE_PATH)
> +               return -EINVAL;
>         if (!(pipe->f_mode & FMODE_CAN_WRITE))
>                 return -EINVAL;

I thought you said the above check is redundant due to the lower check.

In any case feel free to add

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>         if (!S_ISFIFO(file_inode(pipe)->i_mode))
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index 094a7f510edf..1aaf4cb2afb2 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -453,7 +453,7 @@ SYSCALL_DEFINE5(fsconfig,
>         case FSCONFIG_SET_FD:
>                 param.type =3D fs_value_is_file;
>                 ret =3D -EBADF;
> -               param.file =3D fget(aux);
> +               param.file =3D fget_raw(aux);
>                 if (!param.file)
>                         goto out_key;
>                 param.dirfd =3D aux;
>
> --
> 2.47.2
>

