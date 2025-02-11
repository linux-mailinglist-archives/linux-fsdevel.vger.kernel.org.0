Return-Path: <linux-fsdevel+bounces-41508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C84FA30919
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 11:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C037F1887A17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 10:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0471F3B8A;
	Tue, 11 Feb 2025 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqEgq49E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763DE1C3308;
	Tue, 11 Feb 2025 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739271008; cv=none; b=RnG9aq/FwBzSAqobX96NF9lHjw3cVyXVYFeH73z3OEVMppvA7kM3ewQAJCeIsoN90N7p3+Z1E6I4TgVIrSZV9A1MMVHcg78y47Kyc7Jv5V+0zG+31qiJIPVvy66HiBL7zfn+C3rrJ5c4kIJ8EvFdCurwXBgprXj73xtxI2xpxbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739271008; c=relaxed/simple;
	bh=h+luzOhZkAp1YWXJcoWBu4JhwFZQBBTCCkA7svssvkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFOT2SYQlnp7cwCjmq2apmVeNRRB8RhkStv9iqrgqN4r9/54jHvsDp0b63Z07OZnWzUhpsRI0K7iKVMFXOcbKMnvTsz68Jf42v9csTnw1+LPv+MvHPH2ygG2v9D1G7S5oxC8NJpDENYRst6ZahU1BY9eMcU1FRhyGjeRWxXv6ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqEgq49E; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5de51a735acso7357300a12.0;
        Tue, 11 Feb 2025 02:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739271005; x=1739875805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6T5ddoh2W/zRDde0eilO5nEY51ozsIA8aDbiDD9DR0=;
        b=AqEgq49ErybmCmlHe75pDrf7tNVuYWrUV6FBWHlMh1t0FKuBoDQDqgCrL2iWsQJGnY
         74hhWFpqJ5Nhe/NLN7ElzT1BvLHaupR4yCRXJGDbEIDE7qnr3B2YxEdODccRpzAFwA/D
         uu8qA6ve8U17be6rxAbPH42yHf2zv0EiMEujblQB2rhPZ/vx/uUFN3ZBF6E25FkQF7n5
         qqRf1+ED41FT7IcOdCsiZdaM0iNouZkUTrk31e11TQ+dYNs8xpKYpo5whb7koo/EsAJO
         Wo3sOprmYFX2sp9cSEWmnCQbkrpwqkjw7yIBWR36VbLzSRlcwrc2JPEGBkZ7codNXsm3
         FYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739271005; x=1739875805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6T5ddoh2W/zRDde0eilO5nEY51ozsIA8aDbiDD9DR0=;
        b=D8U1kVGB7TuA+D+gbsNkf57Q/IszDY9WGOSrnZPbrZa8NGfioljgtC4tnMy3wchJbW
         yi9Po0oGuLHKAA7WpA0uSKYC/nOiNyU6oUSmhQ7MX1k5ulU0b3TQJYuY131L+WgirN61
         RYQL9v6IRZLIhC2Ba+z7jKr8rn1MqZOrYXTIFbic2LlRiSKgPfJkdVvp9mZRffJsnM53
         P9fuXW+XaWmo8TVxNN9bQoVeliFfq/gnid3wZnHgoaX/nGjGtaHq2dB4aWknhDOTGcH/
         dYUMyGfbyzLqzHFtNPELMMQNCFAH6oRL9HRHvQhIfy2y1/B9p+FPACupGhFW/8fKUjcY
         vasg==
X-Forwarded-Encrypted: i=1; AJvYcCVwY/cFuqGU3VO4AMs129cbYbIbyjKBHvt6JUg8x124LeQaQMHG/Ri6sA+frzAY6kI080w/tYxSY6/Gp4Kw@vger.kernel.org
X-Gm-Message-State: AOJu0YwytDwP/o8KtSg5QjZxIx1SPySvv1RsYiorlAMJlxQXDfZ+ZcrV
	3CEXUE+RRRqPbuocmshQmRS5InEzsLhs782VUr5w++dGxP49ObkqEPjOhqK3+j1b7VEKeUDQBEe
	8PA+prCavIa6x8sRR5qooG0+/AvJ4gjjkkuE=
X-Gm-Gg: ASbGncvIJeOdHE6vWG0pHapDQTrcnf5ziKXdLSmAvdS7Deu5pphoSUhAiZ0HuajUP7l
	xa2bgDNjsHrxSQnwAmiI/XHEJE4z/ZPh1vuqJ/eaRixgpWrRUsYDdCF70gg8wyBqZ5gsplZMv
X-Google-Smtp-Source: AGHT+IEN5KUxljo5XBOU3cH1Y7gwgVcYEQZ7Rww24ZXK4e91HWRS3qIbICJapRFdDOjXFWBFVF+TjvMnscOJIKwpVvE=
X-Received: by 2002:a05:6402:5cd:b0:5d0:d9e6:fea1 with SMTP id
 4fb4d7f45d1cf-5de4503cc06mr18499004a12.19.1739271004340; Tue, 11 Feb 2025
 02:50:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-5-mszeredi@redhat.com>
In-Reply-To: <20250210194512.417339-5-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Feb 2025 11:49:52 +0100
X-Gm-Features: AWEUYZkDaJg7jJH1KsmgBhdgaFV5sgCauZgTTAcIqoeOIpbQ0cN5tYl4o87U5PI
Message-ID: <CAOQ4uxgOwu1pnS9BoMYDua6D4aJ+UUOwbsSyUakP2dMd5wQaBg@mail.gmail.com>
Subject: Re: [PATCH 5/5] ovl: don't require "metacopy=on" for "verity"
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 8:45=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Allow the "verity" mount option to be used with "userxattr" data-only
> layer(s).

This standalone sentence sounds like a security risk,
because unpriv users could change the verity digest.
I suggest explaining it better.

>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/params.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index 54468b2b0fba..7300ed904e6d 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -846,8 +846,8 @@ int ovl_fs_params_verify(const struct ovl_fs_context =
*ctx,
>                 config->uuid =3D OVL_UUID_NULL;
>         }
>
> -       /* Resolve verity -> metacopy dependency */
> -       if (config->verity_mode && !config->metacopy) {
> +       /* Resolve verity -> metacopy dependency (unless used with userxa=
ttr) */
> +       if (config->verity_mode && !config->metacopy && !config->userxatt=
r) {
>                 /* Don't allow explicit specified conflicting combination=
s */
>                 if (set.metacopy) {
>                         pr_err("conflicting options: metacopy=3Doff,verit=
y=3D%s\n",
> @@ -945,7 +945,7 @@ int ovl_fs_params_verify(const struct ovl_fs_context =
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
> @@ -957,11 +957,6 @@ int ovl_fs_params_verify(const struct ovl_fs_context=
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
> @@ -986,10 +981,6 @@ int ovl_fs_params_verify(const struct ovl_fs_context=
 *ctx,
>                         pr_err("metacopy requires permission to access tr=
usted xattrs\n");
>                         return -EPERM;
>                 }
> -               if (config->verity_mode) {
> -                       pr_err("verity requires permission to access trus=
ted xattrs\n");
> -                       return -EPERM;
> -               }

This looks wrong.
I don't think you meant to change the case of
(!config->userxattr && !capable(CAP_SYS_ADMIN))

Thanks,
Amir.

