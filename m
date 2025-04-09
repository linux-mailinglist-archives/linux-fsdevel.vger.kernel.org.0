Return-Path: <linux-fsdevel+bounces-46044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08024A81CCD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 08:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A818A091D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 06:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123091E25E8;
	Wed,  9 Apr 2025 06:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3Kw/ql4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0911E230E;
	Wed,  9 Apr 2025 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179157; cv=none; b=UCGbY1CAbBvgAajdcUauMFLaok+nozwDc+dw7oW8xD3smVFqDv0XGdRGgRPRoR40zrWXZSH0qEfYOnoXHwT8QdsusmButwjcph20oJ1dWp7KAeiMbDdigWE3bYuyBduCndipP4KxeWCFxZ6i/DuOjDsoftAZ20Yw9bg63qdtXa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179157; c=relaxed/simple;
	bh=uEwXmv/FgLn3QoENCm9861yYiSd2QYbQM2+E7xQyjLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=js8Wu8EmV48kj+oMCwa/yhjSWqOoPUnnJCiB4ATr8MfBDo8S9sHnwB9opH2NaaYej7Z3E8wVmGB3q9MH6rg/7AZmuaftflMLCRx2rYGZsfNqhhEJpAWIO8/aHlF++O1n8NJK0gSvXaxKmKAvgwmN4y/neUjCDsgGvNw9/ZSEPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3Kw/ql4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac73723b2d5so1304509766b.3;
        Tue, 08 Apr 2025 23:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744179154; x=1744783954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+67AhPpMjssHreYeqHg++4VLIbAsTf8ThE65Y22B+4=;
        b=E3Kw/ql4hwAihA4PHWbTH4SGhT95H1vqHflCwMsBzUYvjHwG+BeuMiLV1r32HNL1/u
         qObxZJLJTGYLuTWkLbQSgldh0kvE059P6r2xCPgqDoxW73HPOe7RU13GqRzDfMjzsCnH
         3lkHWRt8cLucVGNgsEO504ELI8PNIBarOfLgfq6YkXQ+cS9HmOmp05FXmfTa98Pty0yB
         AJqn70dNPVXrLIzRC1tJrjQ5Qo1lD6Wf4ewdIptDoTDGf0YwBpdAo79amNmNY+/nMzuu
         UHjcq3MVu0OOXu2pgE1yOzkiGZw2Z8gRkgj2AznJ6DWz0PKYqvK5+t6RSQV+W2XDK6qL
         9uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179154; x=1744783954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+67AhPpMjssHreYeqHg++4VLIbAsTf8ThE65Y22B+4=;
        b=KqChu2HNDVRtjE/ww861bOaM9DBK+EgMn06O4a6Sp6VTDJdlf5MjpQ+SMjhEf3naUI
         Vj1/HtUoqOfYnhGkc09nJb6cMGVeSXK3I5KSr1TbanLCJ5VzIqVa7w9shlimEN8N474O
         hSDDKwhVPMIl33JfUa169SsRnDQ2Bt0PI7A87ts+fpBsbUjmfGPrJDrg4MFj6vtF28aH
         MCaKrXQIkBwT+ifpCR7AzT5dnwlMIl6lGrQAKWugNC0e7mq1Om7uo9eKi0MLfN0eLDcw
         AA1Xt0pnGqiQ54UmdJpm6TvzE3pQH43WmxuFvuXESrscvLr2tAaJ0a5WInOBT2sv9x20
         AtzA==
X-Forwarded-Encrypted: i=1; AJvYcCWKyIp+I9HRgenhzxGiccTIZMK99vaosqXrDJ++dxQgQiuND9izBObTxt3uhudmLoJaaGVK+QrzPpMYqszb@vger.kernel.org
X-Gm-Message-State: AOJu0YznmtRpBqXXR4GCVy4648ZqJucATzfTYep2QprkwDQIqSCEWg+o
	KJD3Qi+9e10MZ+vgJcE8/m9eGr0wiG5/cj4pvFC2+uPMaiOX+lAe+T5aQdRy1p56F1DPaVlRs/w
	f4Z2kHcNGJsX9uQcOBCOSFkdu3wM=
X-Gm-Gg: ASbGncuf5T7OXEu5TIJk0d92qhQZkWuB3+wM9RhhP2/EWrxfEnrd7DRebUh5wyDXugJ
	aFNIRD15rnoMB9TlYGaksreJS49c5+HsHMTATfB0HnLJns5vS9K2qCg/6IAYNvVis6HYNIiLYAQ
	lcaVRe38Ls4HzL2UiL8KhWPw==
X-Google-Smtp-Source: AGHT+IGnKY2QEG9XpdTq+JzMnz6dZpGexQU0+xUlXxdT8rHaTZ9e8s4osbq1NXOgzQaTgyMlshi4yHqB+9daVoVlGWo=
X-Received: by 2002:a17:907:d26:b0:ac8:1a8e:46b7 with SMTP id
 a640c23a62f3a-aca9b6987eamr160476166b.26.1744179153368; Tue, 08 Apr 2025
 23:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408154011.673891-1-mszeredi@redhat.com> <20250408154011.673891-4-mszeredi@redhat.com>
In-Reply-To: <20250408154011.673891-4-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 9 Apr 2025 08:12:22 +0200
X-Gm-Features: ATxdqUGWC2XvV1jObLUnVnkZ_4Lo7tVMM2pNoy-QU0POKfkVVMerFQPHKd2Xy5g
Message-ID: <CAOQ4uxjPoHAPvR8EjrnksMSKrfzmxYWT1spQ5rBn5B6w6iOYfw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ovl: don't require "metacopy=on" for "verity"
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Giuseppe Scrivano <gscrivan@redhat.com>, Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 5:40=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com>=
 wrote:
>
> This allows the "verity" mount option to be used with "userxattr" data-on=
ly
> layer(s).
>
> Also it allows dropping the "metacopy=3Don" option when the "datadir+" op=
tion
> is to be used.  This cleanly separates the two features that have been
> lumped together under "metacopy=3Don":
>
>  - data-redirect: data access is redirected to the data-only layer
>
>  - meta-copy: copy up metadata only if possible
>
> Previous patches made sure that with "userxattr" metacopy only works in t=
he
> lower -> data scenario.
>
> In this scenario the lower (metadata) layer must be secured against
> tampering, in which case the verity checksums contained in this layer can
> ensure integrity of data even in the case of an untrusted data layer.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>


> ---
>  fs/overlayfs/params.c | 26 ++------------------------
>  1 file changed, 2 insertions(+), 24 deletions(-)
>
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index 2468b436bb13..e297681ecac7 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -871,18 +871,6 @@ int ovl_fs_params_verify(const struct ovl_fs_context=
 *ctx,
>                 config->uuid =3D OVL_UUID_NULL;
>         }
>
> -       /* Resolve verity -> metacopy dependency */
> -       if (config->verity_mode && !config->metacopy) {
> -               /* Don't allow explicit specified conflicting combination=
s */
> -               if (set.metacopy) {
> -                       pr_err("conflicting options: metacopy=3Doff,verit=
y=3D%s\n",
> -                              ovl_verity_mode(config));
> -                       return -EINVAL;
> -               }
> -               /* Otherwise automatically enable metacopy. */
> -               config->metacopy =3D true;
> -       }
> -
>         /*
>          * This is to make the logic below simpler.  It doesn't make any =
other
>          * difference, since redirect_dir=3Don is only used for upper.
> @@ -890,18 +878,13 @@ int ovl_fs_params_verify(const struct ovl_fs_contex=
t *ctx,
>         if (!config->upperdir && config->redirect_mode =3D=3D OVL_REDIREC=
T_FOLLOW)
>                 config->redirect_mode =3D OVL_REDIRECT_ON;
>
> -       /* Resolve verity -> metacopy -> redirect_dir dependency */
> +       /* metacopy -> redirect_dir dependency */
>         if (config->metacopy && config->redirect_mode !=3D OVL_REDIRECT_O=
N) {
>                 if (set.metacopy && set.redirect) {
>                         pr_err("conflicting options: metacopy=3Don,redire=
ct_dir=3D%s\n",
>                                ovl_redirect_mode(config));
>                         return -EINVAL;
>                 }
> -               if (config->verity_mode && set.redirect) {
> -                       pr_err("conflicting options: verity=3D%s,redirect=
_dir=3D%s\n",
> -                              ovl_verity_mode(config), ovl_redirect_mode=
(config));
> -                       return -EINVAL;
> -               }
>                 if (set.redirect) {
>                         /*
>                          * There was an explicit redirect_dir=3D... that =
resulted
> @@ -970,7 +953,7 @@ int ovl_fs_params_verify(const struct ovl_fs_context =
*ctx,
>         }
>
>
> -       /* Resolve userxattr -> !redirect && !metacopy && !verity depende=
ncy */
> +       /* Resolve userxattr -> !redirect && !metacopy dependency */
>         if (config->userxattr) {
>                 if (set.redirect &&
>                     config->redirect_mode !=3D OVL_REDIRECT_NOFOLLOW) {
> @@ -982,11 +965,6 @@ int ovl_fs_params_verify(const struct ovl_fs_context=
 *ctx,
>                         pr_err("conflicting options: userxattr,metacopy=
=3Don\n");
>                         return -EINVAL;
>                 }
> -               if (config->verity_mode) {
> -                       pr_err("conflicting options: userxattr,verity=3D%=
s\n",
> -                              ovl_verity_mode(config));
> -                       return -EINVAL;
> -               }
>                 /*
>                  * Silently disable default setting of redirect and metac=
opy.
>                  * This shall be the default in the future as well: these
> --
> 2.49.0
>

