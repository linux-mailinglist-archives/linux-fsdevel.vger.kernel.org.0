Return-Path: <linux-fsdevel+bounces-57949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3765B26F46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 20:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6845188F9D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 18:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD43F223DD0;
	Thu, 14 Aug 2025 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL9wBYhX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A86B3FE7;
	Thu, 14 Aug 2025 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197279; cv=none; b=oDriwIsSZ9v108HjK+hBZ32nb5FRI+0N2QK904zeicAmZbS9AHG2LbgTolmzrxUxKV0e+SDYO+R0MDBkcrwopfNUB5G5xyMoYXvToNpKY0qx0sA3ZIkvTbiDz8ETdn/HIpbGpwLfryjreuG+eI2k94P+Zv0mVuB2GlDsczEOvrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197279; c=relaxed/simple;
	bh=gHKmF+idgcMOnun2WA7XqdHIPGI5h3SAvT1spIkA1LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCOVfdZrBwRJgGI2LWlf5GXIW6qZGNmfUB8uAky1Bn3XLL+OSEKmK6RLCy3LNJdhJjdEpFQJmJezBydHMehEMbCln0mUq1WScNDU6QQunmlNBNz5Ndqp1wgJ8eldCaTi1A45H1+OMaJSF1TKGqYoAxbqNAyydcgcUt8u6C1rT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KL9wBYhX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78da8a7so204862066b.1;
        Thu, 14 Aug 2025 11:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755197270; x=1755802070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcbkEp63K07Iouz5e5FEqAqfkHCLkJA7rRvR9fXslSg=;
        b=KL9wBYhXGZULyp7NbX2+jse3Zb7nlusrIWNrSzEFSRwkKQmX8EFVHn9UGiTKRjDNVW
         PeEZtXBUX0sFiFI/JcUWYa8KrSAFfK/OhsdI5pFodsRoZAt6KHTXsUWfa+6UAmulOaSd
         YNU+a8Ppo8QLQMi8frbT986dOPIuevxuvdX872SmqbqJrtwbQoii0S8vPqKxGyAUdcEZ
         gGFWMWLjZkprmpZMhTEm73ktzH+MgbOXO2qZDQpV4l8EslUbPovzCxWzLaE1T3THRv0k
         GWcW8kko06kk71dZUSFeLUtXc3pNmgEgJ3Rhcl9+M/rVEnTM6ovzZF7ylXysorrLhSTd
         PvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755197270; x=1755802070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcbkEp63K07Iouz5e5FEqAqfkHCLkJA7rRvR9fXslSg=;
        b=oQ0B0LPFJ71zFEA++w/VWzs20n579Izgptj9DUAhHS/4KuK9PMBMAfaouayQNgeQHn
         Yrm24y0kCcu4onYPf6hHjVTv2DBBxU7UWjXKH4YqrRZNlFAEe6/W+adoOiGDDj2fnkQo
         l283j0gRiwPwKlVSimxq8GAQUEQ7Zzkz1mszIBYQs1aVQWhoFaNOgFUa0OWWndevN0ZP
         l2UsEswVMfGetpUNYC8phykAN+Lteb7tBVt6+a+zy/k7XTyNXuEuJzL2/LOQ6L0R5pdM
         1hWlh3cPpXHVSp33YfIR0S7skf8dUEOQ7WjIn9OQdE3v2NP9fwFanPwoxK1vGm3gzTUP
         QLPg==
X-Forwarded-Encrypted: i=1; AJvYcCUR6P8Fz/kPU2/QlMdDlpvcK34A9KcrW5TgrFOuNpqk+JWBJJYZl0TgLYcWXmIuc2wihdV/jStPM8Htu8x80A==@vger.kernel.org, AJvYcCV8XL5I084iQWMmdC/b/jrsB52kAg/9DnBle9LQU3vFvJFs0sD0Ex0GAe5h0hE54dxt2/kH3sDbkb/gOFIm@vger.kernel.org, AJvYcCXIgK/Aoz/DCLQfQ2dAhZBkiRXNDNUB4U5rtn9mOz00Xy6RmzFy3HfbxnVvaaEOkHwEqBOylFhzJKwzxCQK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2grQOMa9ZP9Fe2QaOnlnXKf8KyNN8BqroZkeHTCXWCtO6R0An
	IiDpQyFM9qy40ibF7Kh/3829/DtiUCZ3z9KTJmUGpU2WCBgTcmmFy8xeQCoLmjcUmOJN21JN8eD
	3D9jk39x62XxSA1/fiIvRvYzRtyQLEl8=
X-Gm-Gg: ASbGncuYVohcsLW1ixLhR8mMJvJv8cfUoN7myugCrfs5CvAJgJC3yLo7hSSEF8MWVzq
	kLbMosoq2V1P9RRgXtGAFkzhbD68pH7p1c4ReVMcc9m4eZo47fEEvfxDm8P29RaWEBYhEvWxd4u
	lmfvaRMHSam783ChI90aYJD7bINpYhsgT8/pTTmJLDDbR3XFjmG2gkSbCyZsoXg8qKK1i0xejjj
	62vsb8=
X-Google-Smtp-Source: AGHT+IE0s1OEDlNQ3tqff9xzEk2e7hiSUFv3mTS/YjyWCNtU7Rx8NZ24vyZpPI1G2/nrrjp5u/WWKMYRwk7x3AzDnz4=
X-Received: by 2002:a17:907:3f9d:b0:af9:5b3f:2dfc with SMTP id
 a640c23a62f3a-afcb98eac2emr391327266b.47.1755197270317; Thu, 14 Aug 2025
 11:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com> <20250814-tonyk-overlayfs-v5-3-c5b80a909cbd@igalia.com>
In-Reply-To: <20250814-tonyk-overlayfs-v5-3-c5b80a909cbd@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 20:47:39 +0200
X-Gm-Features: Ac12FXzo__mwv7IqEMcrlcu_xrQcZz_ZJ3xoHuJrsAKUmgOVdNlvN60ZDoqAjtg
Message-ID: <CAOQ4uxjJSm6P2ZPUy6o2ZPAHrxCeiVOz0ixSKcNpK7U18d-yjA@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] ovl: Prepare for mounting case-insensitive enabled layers
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 7:22=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Prepare for mounting layers with case-insensitive dentries in order to
> supporting such layers in overlayfs, while enforcing uniform casefold
> layers.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes from v4:
> - Move relaxation of dentry_weird to the last patch
> - s/filesystems/layerss
> - Commit now says "Prepare for" instead of "Support"
> ---
>  fs/overlayfs/ovl_entry.h |  1 +
>  fs/overlayfs/params.c    | 15 ++++++++++++---
>  fs/overlayfs/params.h    |  1 +
>  3 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index 4c1bae935ced274f93a0d23fe10d34455e226ec4..1d4828dbcf7ac4ba9657221e6=
01bbf79d970d225 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -91,6 +91,7 @@ struct ovl_fs {
>         struct mutex whiteout_lock;
>         /* r/o snapshot of upperdir sb's only taken on volatile mounts */
>         errseq_t errseq;
> +       bool casefold;
>  };
>
>  /* Number of lower layers, not including data-only layers */
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index f4e7fff909ac49e2f8c58a76273426c1158a7472..17d2354ba88d92e1d9653e8cb=
1382d860a7329c5 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -277,16 +277,25 @@ static int ovl_mount_dir_check(struct fs_context *f=
c, const struct path *path,
>                                enum ovl_opt layer, const char *name, bool=
 upper)
>  {
>         struct ovl_fs_context *ctx =3D fc->fs_private;
> +       struct ovl_fs *ofs =3D fc->s_fs_info;
> +       bool is_casefolded =3D ovl_dentry_casefolded(path->dentry);
>
>         if (!d_is_dir(path->dentry))
>                 return invalfc(fc, "%s is not a directory", name);
>
>         /*
>          * Allow filesystems that are case-folding capable but deny compo=
sing
> -        * ovl stack from case-folded directories.
> +        * ovl stack from inconsistent case-folded directories.
>          */
> -       if (ovl_dentry_casefolded(path->dentry))
> -               return invalfc(fc, "case-insensitive directory on %s not =
supported", name);
> +       if (!ctx->casefold_set) {
> +               ofs->casefold =3D is_casefolded;
> +               ctx->casefold_set =3D true;
> +       }
> +
> +       if (ofs->casefold !=3D is_casefolded) {
> +               return invalfc(fc, "case-%ssensitive directory on %s is i=
nconsistent",
> +                              is_casefolded ? "in" : "", name);
> +       }
>
>         if (ovl_dentry_weird(path->dentry))
>                 return invalfc(fc, "filesystem on %s not supported", name=
);
> diff --git a/fs/overlayfs/params.h b/fs/overlayfs/params.h
> index c96d939820211ddc63e265670a2aff60d95eec49..ffd53cdd84827cce827e8852f=
2de545f966ce60d 100644
> --- a/fs/overlayfs/params.h
> +++ b/fs/overlayfs/params.h
> @@ -33,6 +33,7 @@ struct ovl_fs_context {
>         struct ovl_opt_set set;
>         struct ovl_fs_context_layer *lower;
>         char *lowerdir_all; /* user provided lowerdir string */
> +       bool casefold_set;
>  };
>
>  int ovl_init_fs_context(struct fs_context *fc);
>
> --
> 2.50.1
>

