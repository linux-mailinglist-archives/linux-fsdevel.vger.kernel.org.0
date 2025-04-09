Return-Path: <linux-fsdevel+bounces-46043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C7FA81CC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 08:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6988A026D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 06:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2E6213244;
	Wed,  9 Apr 2025 06:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPui1dl0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31D1DE2CD;
	Wed,  9 Apr 2025 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179093; cv=none; b=AyKvUte/QUwihvSfr3avnroBenYL7E0qBFNyhMTQEmFSK8Gilqt4cNfTPNOJLT4QmpjKE3Qw0czQwa3N88TuLLhAsiEUFNNVsdwaJJLTb8LGRPwK+AaVVxSgDvjK3rbn3bKurGgqp3WVoJDe/b2Rp/N+XnXbcLQ2LLnsXn5POXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179093; c=relaxed/simple;
	bh=xUOLg5WiPsm3ARlzkD6DmSN1PD1p0ts1llMaXwGix5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxseLlILK8VyXYmYpNLuD9/VCvTvBh2AHuoD43EK+opTKxe9v3zXmosSn6TQiFrr84FLB4MI5gXs3JxRp1006Rm3JyBZ8Y67V4HVxkeq7qWj/CJ2KAlic0yotKtRQ0Pj5qHZOqQiikmEupkbmbrA1NYKcptTloGLRmOEHmIdSqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPui1dl0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac298c8fa50so1047041366b.1;
        Tue, 08 Apr 2025 23:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744179090; x=1744783890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0im+636vizs2n8/+dli7Cgy+7xMPpfdN8ysH3dINN4=;
        b=dPui1dl0IY8fZL4UGsNqq/lhdCm5ymIeZYx1zzu/EAcfn+qNVnWeFEsVexi2MJFxgL
         5vlWaS9HdVLo6SbtDq3daFQobGu4PcBzzR+db1s/yre24zl2mX3Y+PY2BoDjREdxLV6d
         zqZbjzN/5r4jSRA9LGuM4+AmUhMfI6rev3diSMeLpIs+lyDDz5RIFsS2eQyXoBwms9DE
         0Leh0viyGne7l6mpI5VPkgPKdXVUtzHG5bx2LkXBSjznZ9m0YCrMNn672RRUr9RqrW7u
         75vrYbscg5pIMT7Ks8TQgBLSGCp2j+GuxN9wUpN/onjZrNIBxgGhpDEQreDUF7HKPDMf
         IDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179090; x=1744783890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0im+636vizs2n8/+dli7Cgy+7xMPpfdN8ysH3dINN4=;
        b=GOTdt9NUhNvNa/WETLxceyLcWDpLVtRIGGek+AO+Pgu+/7ggSm784+zIzHuZA+5IFn
         wvZeqpFkenKNZQ9y60JFJN2BOQmxUbh1iWcNVOTf5JLciu2mv99SzbNhnhFkmaIQ20xi
         X/D7sMcQoPZLcnQfqsbG9mLSFbk1ajA5weSMB3whFSQGUpnZFokKfGkWRPeAbuliFEp7
         y1ZPxAFM+0Y1fqoamZulltWoedu3/SEvC0qJbcac20rARurBnOH00MAKGK984rt3h86I
         L3FZCq1Fsodc0q9OPOfdUgLdYKw5eZfPUvSl81n5RL65G07lvKGBKuSHscQtShnQE1cs
         HdsA==
X-Forwarded-Encrypted: i=1; AJvYcCWD2Ax2us1IViECzeph2tKOgLav4n/olca8H/AtCWa3pCKfOyATwpZanfWPyfn/WkCM/+UXnFVoaJlS7LLi@vger.kernel.org
X-Gm-Message-State: AOJu0YxN+6kh7Qnxvi2RdTBR9eGRoydv/aJ5su9ZLWFG0OclTYxIaDlS
	1au08GDlSERSab4uRTgjbs0ZRl7flPtcqRohvCMRq7RRw6iqKakAFq0QjHfe0q3Rew4tfDqCN+T
	umgiBejSFwyoovk0HZnGyqqJ6CDXMNKPY914=
X-Gm-Gg: ASbGncudPP5uICBJy4XKMbfL28PZtdnQgh/0+89tqnlwt5B27OQ4jISx7cWXSODAmw9
	ZrMKnB8TEZKgjPMJ7P58LTe8dnPdB9eeglgg8G61I5vlXEkOI16cZXAYEUqfpBgsbhMCJQRK87s
	D9CTR342rOxWteowUuhan0xw==
X-Google-Smtp-Source: AGHT+IGBosx3cmkcrcaBxf1/Sm5Txsl1Ew2s+5FteO5h1x4TuThwZ1W+sK9SME2dzQlsy1sUGM9YSRKfHnVQoJqn1sU=
X-Received: by 2002:a17:907:72c4:b0:ac3:f1de:a49a with SMTP id
 a640c23a62f3a-aca9d720169mr123050866b.52.1744179089827; Tue, 08 Apr 2025
 23:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408154011.673891-1-mszeredi@redhat.com> <20250408154011.673891-3-mszeredi@redhat.com>
In-Reply-To: <20250408154011.673891-3-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 9 Apr 2025 08:11:18 +0200
X-Gm-Features: ATxdqUEqhgKSFqVPzyT8K55N7Rt1Mr2a54CcF1pZJHNGlPhpBQrpZWqrfAFkO1s
Message-ID: <CAOQ4uxhK+AQR6dbc2EsPQ6E3CT=O=yKB_qKgvmbEMDvb7vWXdQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ovl: relax redirect/metacopy requirements for
 lower -> data redirect
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Giuseppe Scrivano <gscrivan@redhat.com>, Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 5:40=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com>=
 wrote:
>
> Allow the special case of a redirect from a lower layer to a data layer
> without having to turn on metacopy.  This makes the feature work with
> userxattr, which in turn allows data layers to be usable in user
> namespaces.
>
> Minimize the risk by only enabling redirect from a single lower layer to =
a
> data layer iff a data layer is specified.  The only way to access a data
> layer is to enable this, so there's really no reason not to enable this.
>
> This can be used safely if the lower layer is read-only and the
> user.overlay.redirect xattr cannot be modified.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  Documentation/filesystems/overlayfs.rst |  7 +++++++
>  fs/overlayfs/namei.c                    | 14 ++++++++------
>  fs/overlayfs/params.c                   |  5 -----
>  3 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/file=
systems/overlayfs.rst
> index 2db379b4b31e..4133a336486d 100644
> --- a/Documentation/filesystems/overlayfs.rst
> +++ b/Documentation/filesystems/overlayfs.rst
> @@ -443,6 +443,13 @@ Only the data of the files in the "data-only" lower =
layers may be visible
>  when a "metacopy" file in one of the lower layers above it, has a "redir=
ect"
>  to the absolute path of the "lower data" file in the "data-only" lower l=
ayer.
>
> +Instead of explicitly enabling "metacopy=3Don" it is sufficient to speci=
fy at
> +least one data-only layer to enable redirection of data to a data-only l=
ayer.
> +In this case other forms of metacopy are rejected.  Note: this way data-=
only
> +layers may be used toghether with "userxattr", in which case careful att=
ention
> +must be given to privileges needed to change the "user.overlay.redirect"=
 xattr
> +to prevent misuse.
> +
>  Since kernel version v6.8, "data-only" lower layers can also be added us=
ing
>  the "datadir+" mount options and the fsconfig syscall from new mount api=
.
>  For example::
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index 5cebdd05ab3a..3d99e5fe5cfc 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -1068,6 +1068,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct=
 dentry *dentry,
>         struct inode *inode =3D NULL;
>         bool upperopaque =3D false;
>         char *upperredirect =3D NULL;
> +       bool check_redirect =3D (ovl_redirect_follow(ofs) || ofs->numdata=
layer);
>         struct dentry *this;
>         unsigned int i;
>         int err;
> @@ -1080,7 +1081,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct=
 dentry *dentry,
>                 .is_dir =3D false,
>                 .opaque =3D false,
>                 .stop =3D false,
> -               .last =3D ovl_redirect_follow(ofs) ? false : !ovl_numlowe=
r(poe),
> +               .last =3D check_redirect ? false : !ovl_numlower(poe),
>                 .redirect =3D NULL,
>                 .metacopy =3D 0,
>                 .nextredirect =3D false,
> @@ -1152,7 +1153,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct=
 dentry *dentry,
>                         goto out_put;
>                 }
>
> -               if (!ovl_redirect_follow(ofs))
> +               if (!check_redirect)
>                         d.last =3D i =3D=3D ovl_numlower(poe) - 1;
>                 else if (d.is_dir || !ofs->numdatalayer)
>                         d.last =3D lower.layer->idx =3D=3D ovl_numlower(r=
oe);
> @@ -1233,13 +1234,14 @@ struct dentry *ovl_lookup(struct inode *dir, stru=
ct dentry *dentry,
>                 }
>         }
>
> -       /* Defer lookup of lowerdata in data-only layers to first access =
*/
> +       /*
> +        * Defer lookup of lowerdata in data-only layers to first access.
> +        * Don't require redirect=3Dfollow and metacopy=3Don in this case=
.
> +        */
>         if (d.metacopy && ctr && ofs->numdatalayer && d.absolute_redirect=
) {
>                 d.metacopy =3D 0;
>                 ctr++;
> -       }
> -
> -       if (!ovl_check_nextredirect(&d)) {
> +       } else if (!ovl_check_nextredirect(&d)) {
>                 err =3D -EPERM;
>                 goto out_put;
>         }
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index 6759f7d040c8..2468b436bb13 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -1025,11 +1025,6 @@ int ovl_fs_params_verify(const struct ovl_fs_conte=
xt *ctx,
>                  */
>         }
>
> -       if (ctx->nr_data > 0 && !config->metacopy) {
> -               pr_err("lower data-only dirs require metacopy support.\n"=
);
> -               return -EINVAL;
> -       }
> -
>         return 0;
>  }
>
> --
> 2.49.0
>

