Return-Path: <linux-fsdevel+bounces-57854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C913B25F02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 10:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0111E1656B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 08:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FC32E11BF;
	Thu, 14 Aug 2025 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXRPoDu3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4BC1D63EF;
	Thu, 14 Aug 2025 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160566; cv=none; b=JroUfFN722UwIrzLmI3RWZO7+km/8/tbUPSgfFTyNkV1oNDqwz0/mk5yqwPk98SIvoqE002S7HU1euEiquCNQCfaqiPwGFrjSQJ7i7eY+qhiH+bAFtDggBkU7aUvp+n+8BnEjTRt/sy/Skq7XPthVp1vH2RMjFotrnkyqvm2hxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160566; c=relaxed/simple;
	bh=3XYTDHvq2LcjmNTW0zfO8hXKhU53mqovkhniMJZUCHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRZF0FN77gNA+Ev+Njt1sV3nvPuwv0fbL015Ta9j+cVyEAq3HG/SIMgaU5c1omiEoMmD7zoOyk8gSiyQxJAuWRjhRYcln/Nj8Fo2jamL/rED7aDToez+4s0qRjUSMZ2D/j1bHPd5Gbe23IN/WScdolrzN3HsQQtDsBqjzGxnfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXRPoDu3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb61f6044so133007766b.0;
        Thu, 14 Aug 2025 01:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755160563; x=1755765363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOTX1FGjH4RiOoeNqx7UjWESbbgSSspa6JjPrJyJ8Ks=;
        b=CXRPoDu3Niej7OfnA2rji7kzuuum/DreJDVYpeA7ymoepjokZGjRPOGw6Ppjg7IqmT
         pY0M4tu6xYQ+9xRmMLScxJoOTJYLcRlYi446mUt56lfiQEKYYPGPCfNXD80fEA/0YAJ6
         qCTXubrvObl7GfixpAeOj9qbNNWbchiaGJY9Hfj+WDMq9vU8PqZ1zslmwIxOBXF5E84X
         qEC0FIW+Y5aqYckSGBs7J/nS2wJalS+DExTmCNqmr5DuPv7LLllseIFfcCj9jhYYyOLM
         LD54ocC6KrSmxoe+frN8n2/lurKQQOSs4PiSwSth1cjRxY/j0jCfOpBxxfP3xht8Whr4
         quow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755160563; x=1755765363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOTX1FGjH4RiOoeNqx7UjWESbbgSSspa6JjPrJyJ8Ks=;
        b=H+7tM3KsR9W65ifsnruaOyuYt5kuoZhZvNTZt3p6+mDGKs/69HwL0xdL9L06PkyUsK
         86I4oCreO2UxEOph/uRB4xQsvMhDNNHINHDDSxQ4dBSYop9Zhjgab0LMziF7SYyk9G7m
         lSHjzNN/3w4Nifw/HFwVHJCCXfCupeO/rX5pUEEeP8RiEugAm5hIdUql+UF9Bjd7yQMN
         YoTD+Wx/R+ROncFC2dNhtaV24isVrE6mxSpXkvrmjB0S9tWpr1+i5L7Yvfb/UkEFJ1ol
         uq33ECAN5hIB44ojl+rb3bmKNdmag7u8b3drX8K48YGsfUg99oFQWNmZJEUZDphAa9Hw
         N6Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUVccpXlD+U2wPNTGGKv6DlLJNH/K5Dx1b27j7oD0LsBKzhdxPijsHzZiWwSToPtxYLTWC69fzHO1EtZUHbFQ==@vger.kernel.org, AJvYcCUZooJaFEUlD1mMkZ8Wf4oNdbFeHb5cHzPLG+8bviVPqZaH2UeoP5oBoiXLnSBJkDz5er0LP89Iluq/mFAg@vger.kernel.org, AJvYcCXeJD8ryHjQ1ZtYZb9cJqn9wAMm47fdQ2QMwUaV/THbXFSBimQzi0BZpT6hCRwxEpss7Lwp1qWBfFEi/TAr@vger.kernel.org
X-Gm-Message-State: AOJu0YwiZnz15/WjWyxt/ZThmTRqQL7JnTYaqNHcPGgCSXaDzWHMRwZS
	zl5sl3Eyx/HbKS/pEs2q/N/85I2jheWIi+MKGohmAv0EtImhe5hjTu5VfWOAYT0NClzHWUgK6Zm
	hqfV7jJa/roRXgpTZwLhMK933ongXWCIdqAKE7xM=
X-Gm-Gg: ASbGncvkus6G5P6TNudacncn883dqrUN1KnE2RYh488o45qtjufCvlXOxtFU3oLpjfe
	V+l7mHKm6b5lvxB/HhqAr3GXSlu48ryzEhEBL7XaOiVjSBu7KqDwbL4aM9Mudf/kyUHOIaLiD6L
	+PlEjZR/cCIFT2MAljIcZCbW9+HxqFw3WqUldogAWftdIXyPM/rHgmQO0BZH4s5fb+RocXjn26x
	PwGgc0=
X-Google-Smtp-Source: AGHT+IGKKcOvuN1xDm8xMO/A263wHFSD+iuYL8w56j7NOwzuXtzyteYNUT8Uf2GHIeb7FSp0j9xzMB/PIYYKHbd/ZdY=
X-Received: by 2002:a17:906:7310:b0:af8:fded:6b7a with SMTP id
 a640c23a62f3a-afcbd80b8bemr187546166b.17.1755160562402; Thu, 14 Aug 2025
 01:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com> <20250813-tonyk-overlayfs-v4-1-357ccf2e12ad@igalia.com>
In-Reply-To: <20250813-tonyk-overlayfs-v4-1-357ccf2e12ad@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 10:35:50 +0200
X-Gm-Features: Ac12FXyQFKZFtMXoO1ZIyMwxUcr7ZUnQIr-Bnp2f50ZUtWYRV8pIETgB3OmS4Es
Message-ID: <CAOQ4uxiENaCd7RcAS8j+UUNmtmOzKZ3BwBWst=fKN6zWLZyvuQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] ovl: Support mounting case-insensitive enabled filesystems
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andre,

As a methodology in patch series, although they are often merged together
we want to abide by the concept of bisectability of the series, so it is no=
t
good practice to "Support mounting case-insensitive enabled filesystems"
before this support is fully implemented.

Suggest to change the title of this patch to:
"ovl: Prepare for mounting case-insensitive enabled filesystems"
which implements the logic of enforcing "uniform casefolded layers"
but do not change ovl_dentry_weird() yet - do that in patch 9, so that
both lookup and mount of casefolded dirs are allowed together.

commit message need to be changed of course.

On Thu, Aug 14, 2025 at 12:37=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@ig=
alia.com> wrote:
>
> Enable mounting filesystems with case-insensitive dentries in order to
> support such filesystems in overlayfs.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v3:
> - Move this patch to be ealier in the series
> - Split this patch with the ovl_lookup_single() restriction patch
> ---
>  fs/overlayfs/ovl_entry.h |  1 +
>  fs/overlayfs/params.c    | 15 ++++++++++++---
>  fs/overlayfs/params.h    |  1 +
>  fs/overlayfs/util.c      |  8 ++++----
>  4 files changed, 18 insertions(+), 7 deletions(-)
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
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index a33115e7384c129c543746326642813add63f060..7a6ee058568283453350153c1=
720c35e11ad4d1b 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -210,11 +210,11 @@ bool ovl_dentry_weird(struct dentry *dentry)
>                 return true;
>
>         /*
> -        * Allow filesystems that are case-folding capable but deny compo=
sing
> -        * ovl stack from case-folded directories.
> +        * Exceptionally for casefold dentries, we accept that they have =
their
> +        * own hash and compare operations
>          */
> -       if (sb_has_encoding(dentry->d_sb))
> -               return IS_CASEFOLDED(d_inode(dentry));
> +       if (ovl_dentry_casefolded(dentry))
> +               return false;
>
>         return dentry->d_flags & (DCACHE_OP_HASH | DCACHE_OP_COMPARE);
>  }

Move relaxing of ovl_dentry_weird() to patch 9 please.

Thanks,
Amir.

