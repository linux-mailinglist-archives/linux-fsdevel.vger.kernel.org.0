Return-Path: <linux-fsdevel+bounces-34475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E979C5EBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB85BA2197
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 15:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA2A202F92;
	Tue, 12 Nov 2024 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5zBLfn/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECFE1F7068;
	Tue, 12 Nov 2024 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426966; cv=none; b=D78e+bfBTti4v+nX7QO6ZK67zQhYp940xCeTEyiyj3xSbFl3joqhLGbFy5NNuQz9NA0uA2Xm5ajAnXQQ5cYdYb/VK593gDYB/FyjBxS0KeZ34uJa+TP6e4BNYSQQ3PIVaS1Fv21lhMGzLwAPZi7S8F1Uqgy1b1jR4gu7dWwzWSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426966; c=relaxed/simple;
	bh=FUkY8vBvHpNmPvUODc0GVgjz5hCCodk0jxmUUq4d3j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgy7wndBHqvtgT4L4a9d+HgKcZ6TzjMsMIgWSTZ2Vrw+bQZz1QBxG5x27VteWZlg+XON+/qM6yjOS8JOjmMUhbeT8aMTAIcvi2kVDZT2TAeSRXeHL1l212Ih6bP/nhDN428bH/M1CKhoqx0FVRIFzAT/W/n/PmTOVXAi7NtOE0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5zBLfn/; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ebc27fdc30so2892510eaf.2;
        Tue, 12 Nov 2024 07:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731426963; x=1732031763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYmSNlu/VUJDhCWFzgw6Pwurlvm+R+J0mmXptnSbNrU=;
        b=W5zBLfn/HDsIGhE4clBlpbCE5DCfGDi+QyxDbzcRPY69J+KTyXp6gLPAWa/1GR6iOi
         tX5g2r0Y2lWCU60Yj0jhaIGhMdCJSACE9Z5v0XQtVxByDs03AHqbxnbuTykWmj/MrlTU
         Anqdr8T8WMI/QaBvraMaDpGb30LjfbBGiyQMhqRAzMFTvES9yHCxVddbRqkMfxloM7Jh
         LZk2Hd3Me1+2mUDLm0vDcwxM/HYvQZ36VEi8n8cvcD0nYmctoTTqgAM+XNOrSjSOuSRV
         DCagbL8BYhl3gCv0eKklptzyef1rtx1CObHvcsvwxb/pSO49sPwI0jx2GR4Hm8KJrg2R
         MKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731426963; x=1732031763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYmSNlu/VUJDhCWFzgw6Pwurlvm+R+J0mmXptnSbNrU=;
        b=uIDhtKRvx4p5VDr1dZVvcz4WLzrR+AxdXI/ERZPt07+lP8bTZ+sn4E0sokeQ/0AUKm
         /HWJGDtspH8IQDWONk9FfoBxAuC/11Kd8OAF+lxtpwmEhB4r07nrJ9RhzK29N6JvsuXp
         Q6D4pp9c619wC6XIMbabwzU5SgxUa9qmeoQvV7bAV+RZ0NajdvSNso8HQQ96UiwhCIG0
         9rDQ3lnmTSGOxBjLj7e7NqKprzHuUXNwzoV4kQHL7sBiptb2lX7C8dx28nwFENMO9uhz
         nNx4igJG5slDvlzJSQuRbhrqDxP6LlZ5NB7jpE3hypp6+tvqxZRurALRlca+lXK0CKHz
         R8aA==
X-Forwarded-Encrypted: i=1; AJvYcCU/x0E2nb4YXz4rso7uPBTdCYFIyPl8lEaRPIYjiyG+NU4cmslGKs22HNkxHLnRtDJVXIwotjhZU7x2DbOr@vger.kernel.org
X-Gm-Message-State: AOJu0YxA7jFiOBw2kyU+2XN+24h8ni6XXKa2qCD+MNNIrOyN+JUaTr3Q
	AVJsRgn/J4UkxoJg4zABpTm2BX/xecg4CfwYBrhU4bclsmTWC1TsHLWsevh94t/QyHzAcMo4CmP
	X8PYe06UTU9czFLZBE4rey87SqvcEUvsZhVA=
X-Google-Smtp-Source: AGHT+IFezwbgWPN7unZsmswTxXu6sC+1b7SLstIy6sy3nImuLBY2n8J/CIe/ya4BMckZnw191hkIZtJ7537RVfVF1e4=
X-Received: by 2002:a05:6358:9791:b0:1c3:2411:588f with SMTP id
 e5c5f4694b2df-1c641ea72e5mr727978055d.9.1731426963523; Tue, 12 Nov 2024
 07:56:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101135452.19359-1-erin.shepherd@e43.eu> <20241101135452.19359-3-erin.shepherd@e43.eu>
In-Reply-To: <20241101135452.19359-3-erin.shepherd@e43.eu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Nov 2024 16:55:52 +0100
Message-ID: <CAOQ4uxjTN5rXqAgR-ovfEuo7gSYY6Wig1-4QV6a5BXFkfqge6A@mail.gmail.com>
Subject: Re: [PATCH 2/4] pidfs: implement file handle export support
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, paul@paul-moore.com, bluca@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 2:55=E2=80=AFPM Erin Shepherd <erin.shepherd@e43.eu>=
 wrote:
>
> On 64-bit platforms, userspace can read the pidfd's inode in order to
> get a never-repeated PID identifier. On 32-bit platforms this identifier
> is not exposed, as inodes are limited to 32 bits. Instead expose the
> identifier via export_fh, which makes it available to userspace via
> name_to_handle_at
>
> Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/pidfs.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 80675b6bf884..c8e7e9011550 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/anon_inodes.h>
> +#include <linux/exportfs.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/magic.h>
> @@ -347,6 +348,25 @@ static const struct dentry_operations pidfs_dentry_o=
perations =3D {
>         .d_prune        =3D stashed_dentry_prune,
>  };
>
> +static int pidfs_encode_fh(struct inode *inode, __u32 *fh, int *max_len,
> +                          struct inode *parent)
> +{
> +       struct pid *pid =3D inode->i_private;
> +
> +       if (*max_len < 2) {
> +               *max_len =3D 2;
> +               return FILEID_INVALID;
> +       }
> +
> +       *max_len =3D 2;
> +       *(u64 *)fh =3D pid->ino;
> +       return FILEID_KERNFS;
> +}
> +
> +static const struct export_operations pidfs_export_operations =3D {
> +       .encode_fh =3D pidfs_encode_fh,
> +};
> +
>  static int pidfs_init_inode(struct inode *inode, void *data)
>  {
>         inode->i_private =3D data;
> @@ -382,6 +402,7 @@ static int pidfs_init_fs_context(struct fs_context *f=
c)
>                 return -ENOMEM;
>
>         ctx->ops =3D &pidfs_sops;
> +       ctx->eops =3D &pidfs_export_operations;
>         ctx->dops =3D &pidfs_dentry_operations;
>         fc->s_fs_info =3D (void *)&pidfs_stashed_ops;
>         return 0;
> --
> 2.46.1
>
>

