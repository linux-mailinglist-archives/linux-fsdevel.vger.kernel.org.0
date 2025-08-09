Return-Path: <linux-fsdevel+bounces-57172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8D9B1F441
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 12:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0920A62496C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7F01F37C5;
	Sat,  9 Aug 2025 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4Dc3B7x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0AC1EBA1E;
	Sat,  9 Aug 2025 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754736372; cv=none; b=p3SPt66U5uSHClhHGM4X3KGSxWdUtWkouEcoTGNYF6sTFM2STq0cm+ASMRJ9ap8IlZNIlz7a2EvumT2mMs41b+m5H1QMrKX3fkW+PNXeOVJ69QA8tYQQNOVvLKiiiEFzYtGTXnZZby4Q/cFhYwCfExBn0VobV8Yzgjvv1DBIKb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754736372; c=relaxed/simple;
	bh=VDWwFiNaQL6sLOR4v3quskMLHZISy55zpJfpNR4srZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOn21JduR9oNA9Y990jh3eTJAyR+xEozh4H+wwipToQ0HM8LkadN6g6KL5v8PDJ01ttyc8pCiQkNweV5loIHWGx29wMro4nIZszzxFbgl/SnJvm3XkmOP8h+XRt/5pj10y42U+OkeJa95fKpn0M2sP4e3eiTBU+U172d3flHNIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4Dc3B7x; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af9611d8ff7so551091766b.1;
        Sat, 09 Aug 2025 03:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754736369; x=1755341169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XSfd9k6l9vt50/mT8Bcw2mP99MBD57w3Q3gw+gra0k=;
        b=J4Dc3B7xgaQX3nmGXKjHdEdtRN/YOf5d7GcT6hJbRDBgbZ6VW42hmIUdjMYPPLn4U7
         ntZrSgebc5jb3CXxHTZghr23c+pEO4eIc4TExcEDYuUZhSPVIKqXGM+9lz6QffcBOFty
         EZ9yGLsl+KygrRCLWSFBkHAuxIHbaxM/k+NwKUkZH+VgXfSC1XH9Uzz9vDh+SRkuNwtZ
         udpTRqtjcElRrmbJSPdt5dYqkXhHSogtOMpPRdpYoLOQYoFF77Tv/ZHf38+v03LPC+qr
         5jH3ERtvIpKp6GFAR48Y5dgj62BYt/tYsSc0SNBomOLHSudFcJrr4fwMmed/nUAuUjlZ
         gQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754736369; x=1755341169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XSfd9k6l9vt50/mT8Bcw2mP99MBD57w3Q3gw+gra0k=;
        b=BtDOimX4i1pKqqZ8nLeGD9gDPvf4BmFZFMd7xZG4isgyuEf0p4eRnNcNNXbhVlkAic
         K3ncvCCNlYBmB8GssM7bZuMCuQsa3co7Q6FHPthPrG88zsjsfM0nCuIcPOiH3ABfX/rw
         L4NNdaKFwGa7gyjpULE9zwuF0EJ2h7VoeXrDLzDzwzufiacxTvysZzq/L5z/iR+LUbMs
         hHH8erhiLhtbj55gIo6QAkBcGdVLQx5ykVrX+gBdHh/8bmCu5w7A760b9v7V56xL4+lA
         Ks4YeUXhCYZ8Nw6tq/JGnuYbRjchKYYSTRZKTFJi5/cTXmEZsy16tQQ+aNMwfMssdD/L
         dyLw==
X-Forwarded-Encrypted: i=1; AJvYcCUAuzWl/UtktvBRamJCvRtKK4wJHcBS246ccwKZiqIzPM/DECqTn/Q3FLSLLWQgnD/+K9aVdG5e+e88LKgYaQ==@vger.kernel.org, AJvYcCVRLfNfInSxi8qurQ7U42gmlvcaLyE0UJ0aog6iNAbfMufOQooOWEBVCflW0Nd4iyH11xAItrj1sgqXagal@vger.kernel.org, AJvYcCWp0E3p3okJo0HubiUmbpzhKOh0t5yMGuDaFLXI5dsg4boG5ubUN0GkJ3FZJikb6hrh9pfE67md0EUFcl9j@vger.kernel.org
X-Gm-Message-State: AOJu0YxsMOHZi8pDpHAxjGDoOXrj3DbI/I1s1907MX5JFzkCxPjQH3Wf
	fH7IFyH8Ekfi5JCWyyd9oOdv+Q42yUTf4/FMQ0Xzl7oBqWeBrb2WrjHhM6pWnY2NXVEJDCDKW1m
	Ej3+kmgVHttzGpfcUJUqfsBoRt+Nc2XM=
X-Gm-Gg: ASbGncuoYOWgNtClQrNy2uUbXETrVxJyKKcQ+Wd9AKIjAoPMQR5DVVTPy69IwaFa+L8
	511h0oPmAr41b8SwF8EpglzHvZBd3IlJBwhy4EQcjRVcOirFrkSEabq07ymq/2q700J/pug/+W2
	NnEC4xaH6m0dIPi9vELjqwqa3Is5dqahEfPbQ1PQmyiZCzMtoza0lEdHawG3MN62fx2FqShkhS6
	X1FE1g=
X-Google-Smtp-Source: AGHT+IHAKxV6LswVqrxxwf20KpWwQ4BDwlcJET3Wwjt8xJWvVcFLgbEM8YMCfPt4HEtsXzfH8jWOfjKl53pwEkKKKc8=
X-Received: by 2002:a17:907:9709:b0:af9:383e:45ab with SMTP id
 a640c23a62f3a-af9c6e254eamr634507666b.2.1754736368603; Sat, 09 Aug 2025
 03:46:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com> <20250808-tonyk-overlayfs-v3-7-30f9be426ba8@igalia.com>
In-Reply-To: <20250808-tonyk-overlayfs-v3-7-30f9be426ba8@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 9 Aug 2025 12:45:57 +0200
X-Gm-Features: Ac12FXwagDraiTkdbvI01whjCxi6KJ0B1gs9Zt5DVu3ZYwoTLQiSsLoKaWS8dx4
Message-ID: <CAOQ4uxhnpFbwLKT3aGek3Ag3zwwtOAw=GttT6i1Vd9XW3rLu3A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 7/7] ovl: Support case-insensitive lookup
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
> Drop the restriction for casefold dentries to enable support for
> case-insensitive filesystems in overlayfs.
>
> Support case-insensitive filesystems with the condition that they should
> be uniformly enabled across the stack and the layers (i.e. if the root
> mount dir has casefold enabled, so should all the dirs bellow for every
> layer).
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v2:
> - Create new ovl_fs flag, bool casefold
> - Check if casefolded dentry is consistent with the root dentry
> ---
>  fs/overlayfs/namei.c     | 17 +++++++++--------
>  fs/overlayfs/ovl_entry.h |  1 +
>  fs/overlayfs/params.c    |  7 ++-----
>  fs/overlayfs/util.c      |  8 ++++----
>  4 files changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index 76d6248b625e7c58e09685e421aef616aadea40a..08b34e52b36f93d4da09e4d13=
b51d23dc99ca6d6 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -239,13 +239,14 @@ static int ovl_lookup_single(struct dentry *base, s=
truct ovl_lookup_data *d,
>         char val;
>
>         /*
> -        * We allow filesystems that are case-folding capable but deny co=
mposing
> -        * ovl stack from case-folded directories. If someone has enabled=
 case
> -        * folding on a directory on underlying layer, the warranty of th=
e ovl
> -        * stack is voided.
> +        * We allow filesystems that are case-folding capable as long as =
the
> +        * layers are consistently enabled in the stack, enabled for ever=
y dir
> +        * or disabled in all dirs. If someone has enabled case folding o=
n a

If someone has modified case folding....

> +        * directory on underlying layer, the warranty of the ovl stack i=
s
> +        * voided.
>          */
> -       if (ovl_dentry_casefolded(base)) {
> -               warn =3D "case folded parent";
> +       if (ofs->casefold !=3D ovl_dentry_casefolded(base)) {
> +               warn =3D "parent wrong casefold";
>                 err =3D -ESTALE;
>                 goto out_warn;
>         }
> @@ -259,8 +260,8 @@ static int ovl_lookup_single(struct dentry *base, str=
uct ovl_lookup_data *d,
>                 goto out_err;
>         }
>
> -       if (ovl_dentry_casefolded(this)) {
> -               warn =3D "case folded child";
> +       if (ofs->casefold !=3D ovl_dentry_casefolded(this)) {
> +               warn =3D "child wrong casefold";
>                 err =3D -EREMOTE;
>                 goto out_warn;
>         }
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

Better introduce this in an earlier patch, even if it is only set in the
last patch, so that other code can use it, like the inode S_CASEFOLD
assertion.

>  };
>
>  /* Number of lower layers, not including data-only layers */
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index f4e7fff909ac49e2f8c58a76273426c1158a7472..afa1c29515a9729bfe88c8166=
da4aefa6cddc5a5 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -277,16 +277,13 @@ static int ovl_mount_dir_check(struct fs_context *f=
c, const struct path *path,
>                                enum ovl_opt layer, const char *name, bool=
 upper)
>  {
>         struct ovl_fs_context *ctx =3D fc->fs_private;
> +       struct ovl_fs *ovl =3D fc->s_fs_info;

ofs, not ovl

>
>         if (!d_is_dir(path->dentry))
>                 return invalfc(fc, "%s is not a directory", name);
>
> -       /*
> -        * Allow filesystems that are case-folding capable but deny compo=
sing
> -        * ovl stack from case-folded directories.
> -        */
>         if (ovl_dentry_casefolded(path->dentry))
> -               return invalfc(fc, "case-insensitive directory on %s not =
supported", name);
> +               ovl->casefold =3D true;
>

The problem with removing this invalf() is that it is more useful to usersp=
ace
than the kernel logs in ovl_fill_supper(), so I prefer to leave this descri=
ptive
configuration error here, something like this:

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index f4e7fff909ac..57035f0f594e 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -277,16 +277,24 @@ static int ovl_mount_dir_check(struct fs_context
*fc, const struct path *path,
                               enum ovl_opt layer, const char *name, bool u=
pper)
 {
        struct ovl_fs_context *ctx =3D fc->fs_private;
+       struct ovl_fs *ofs =3D fc->s_fs_info;
+       bool is_casefolded =3D ovl_dentry_casefolded(path->dentry);

        if (!d_is_dir(path->dentry))
                return invalfc(fc, "%s is not a directory", name);

        /*
         * Allow filesystems that are case-folding capable but deny composi=
ng
-        * ovl stack from case-folded directories.
+        * ovl stack from inconsistent case-folded directories.
         */
-       if (ovl_dentry_casefolded(path->dentry))
-               return invalfc(fc, "case-insensitive directory on %s
not supported", name);
+       if (!ctx->casefold_set) {
+               ofs->casefold =3D is_casefolded;
+               ctx->casefold_set =3D true;
+       }
+       if (ofs->casefold !=3D is_casefolded)
+               return invalfc(fc, "case-%ssensitive directory on %s
is inconsistent",
+                              is_casefolded ? "in" : "", name);
+       }

        if (ovl_dentry_weird(path->dentry))
                return invalfc(fc, "filesystem on %s not supported", name);
diff --git a/fs/overlayfs/params.h b/fs/overlayfs/params.h
index c96d93982021..ffd53cdd8482 100644
--- a/fs/overlayfs/params.h
+++ b/fs/overlayfs/params.h
@@ -33,6 +33,7 @@ struct ovl_fs_context {
        struct ovl_opt_set set;
        struct ovl_fs_context_layer *lower;
        char *lowerdir_all; /* user provided lowerdir string */
+       bool casefold_set;
 };

Thanks,
Amir.

