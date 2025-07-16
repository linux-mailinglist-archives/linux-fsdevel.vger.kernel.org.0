Return-Path: <linux-fsdevel+bounces-55101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A951B06EA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7B5566A63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6491B28A737;
	Wed, 16 Jul 2025 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQifZAeb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F383533D6;
	Wed, 16 Jul 2025 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650119; cv=none; b=HAZvnaODccPybPxUl0LGCIT8c6B4vQNbJmObDX4XiDRGVcTIvzlXc5/RUUdxyZ8hGsMyNY6NKp3DZHc3YiLL8alU8TOBdTx+gwb2t5LiltSBwW3Zfv3VIZXB0gP51/Yk2ddUVaoHN28Bif+uL5W4HuYRTYI9gA1sytrHJIWiIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650119; c=relaxed/simple;
	bh=RjgcebwwwoKLs3HiOuMAnbRKB8sodnlHCQwxdp34oqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llHPyPCBQYZPwPdO9eJ+TJ7zvgTo6ZOKmJQHqDMBYS9bM0lcfXXFVUFhy7MUuo/PtyJN7D7Qb4o656wK3GyKKigA50lpb8kTftrmmtI/8p6u+o5gkKOOhMH4Jcx1eYgSjs0K5et34vdMOORTaxwj6iW3lBsJVWsYYpD2cal0AcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQifZAeb; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso1306333266b.2;
        Wed, 16 Jul 2025 00:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752650116; x=1753254916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9R+4DoLDIyvQ7kd1oQGB3MH7O5ovXFZwVco0qELFYek=;
        b=aQifZAebMX8Gv2kYd5wq7NV+t8t6nXJaRIbOYx3HX8D7YDbCrqHNh/Sc8QVtXhfXE+
         w0Rv5+cwcFmPoRf/oIJLPZscM3il1sBKftUo0iuVto3XY8CWZRPBpCHhCRGBJwWNWjvT
         A8AoB5W5qavSBRi8UPMcrVYNx4wB69jVtbm2vFiR+1SOfJWMVJ7RKkTYCCzYdNLjVFzG
         QyYuTkPYs/Eh1LhXyPPBAShdERXjxO0vdUl8A11Y9CQ2FzdKTJZGXiQNA1zuuOufmHVh
         FNZ8cqLQ568q098XN9r+pDQ0ffB3XGwcDRLfS13/cwKS0X+laZB31dCi/mB8ZZPsH77h
         5ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752650116; x=1753254916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9R+4DoLDIyvQ7kd1oQGB3MH7O5ovXFZwVco0qELFYek=;
        b=AnJYybwJNsyPQnFLQDipXpH0LvpjyWjXeWObeJU1Zt2er8BmwR9PJF8hpjo3CoVigW
         kQLrgkTETo7NR/4HqeuQk64vsCPx8Q7rNUgHK0EyJG9aYjYszDE5SdUIrQyJ9JZ8FAZ0
         EMPjGqp9ryBNmp+40ypzVpzOSnzLpauI3tB5DQGE0TxDqscxJuRJ9pefuXh+jXWDmPAg
         NMQ44SW1c6WtJbu1f4babHvgqriPazRosTTaIMrpeUHrljUosVki+qmA0HX2MEWKJ7dH
         Uxvy8Ezy9LuX+wFiJblUH7/SjKn+t/7x5ph0wHQCvE6axJ5MJolh9tTZ7piivkB/YsBE
         H3Ew==
X-Forwarded-Encrypted: i=1; AJvYcCW9KsSI6ecAYkIe/ycHiqKRrjVyLmXWFaMDe96OBIv0fEEBrPjVnDZ5iSg8sGU5pJk/p04+18Ti9M5+k2JW6w==@vger.kernel.org, AJvYcCXC4SaxDwpjsuWI1cieX+duxJqvscr9priE+YX5dCmRbabVciQ/9G4lHifefhv9XvWqTo4y9YbcWg7bGDgr@vger.kernel.org
X-Gm-Message-State: AOJu0YwJyQplUHVbPV5UuJhykzkxmj6o75lCw6YXg8Zthy+1eiEPnTOb
	E+0Sr48ffAEt7xPwNkc8tIpOGlDchlu3FAW+MwOKceU+VI7r5KOeoXbf7Z5pQbnrQHs8YT4Yhkt
	g9rwAzK1tbpBYrPLfwBV/uySMlnekKTA=
X-Gm-Gg: ASbGncuhtAlYFV2MWWkXFnTMUOQHgMRG2zvfby+cWbVJrkKX29YSV1vQsJMB3fYPrTk
	Swj7oJk3VoqcTseTaDFSqKJk4YbJEI+iHgNbFD4ejihQsBgQNQOmreaMWi1YgpVkMGPBduSDgkD
	VVlUrtZJoSq0HUS0i1Cn487gan/0XToWQTjvRA/SwFNvk5ntfED3sG7Pu0OKu3fKSEjYwjwCnwJ
	majohE=
X-Google-Smtp-Source: AGHT+IF6i0B9HfbXuJ2x2GoQNBEGp+aVwSvJOCuq9OF9bDopo/XI4L01lTgoPxgZ5dGkBmhTDPG0qEx19fZ1bMcSugg=
X-Received: by 2002:a17:907:3cc6:b0:ae0:b847:435 with SMTP id
 a640c23a62f3a-ae9ce14a734mr181833666b.49.1752650116062; Wed, 16 Jul 2025
 00:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716004725.1206467-1-neil@brown.name> <20250716004725.1206467-19-neil@brown.name>
In-Reply-To: <20250716004725.1206467-19-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 09:15:04 +0200
X-Gm-Features: Ac12FXzz9NzQRNvwP6FmPFr3XDjtvJwPAvKXj03mnt6YAicdNgtAniLNGdQ9lZo
Message-ID: <CAOQ4uxhW5iEHAT7bZcG20fjBYwRF-6Rwoa14oQuj81DQMqPb_w@mail.gmail.com>
Subject: Re: [PATCH v3 18/21] ovl: narrow locking in ovl_whiteout()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:47=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> ovl_whiteout() relies on the workdir i_rwsem to provide exclusive access
> to ofs->whiteout which it manipulates.  Rather than depending on this,
> add a new mutex, "whiteout_lock" to explicitly provide the required
> locking.  Use guard(mutex) for this so that we can return without
> needing to explicitly unlock.
>
> Then take the lock on workdir only when needed - to lookup the temp name
> and to do the whiteout or link.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/dir.c       | 44 ++++++++++++++++++++++------------------
>  fs/overlayfs/ovl_entry.h |  1 +
>  fs/overlayfs/params.c    |  2 ++
>  3 files changed, 27 insertions(+), 20 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 6a70faeee6fa..7eb806a4e5f8 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -84,41 +84,45 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs=
)
>         struct dentry *workdir =3D ofs->workdir;
>         struct inode *wdir =3D workdir->d_inode;
>
> -       inode_lock_nested(wdir, I_MUTEX_PARENT);
> +       guard(mutex)(&ofs->whiteout_lock);
> +
>         if (!ofs->whiteout) {
> +               inode_lock_nested(wdir, I_MUTEX_PARENT);
>                 whiteout =3D ovl_lookup_temp(ofs, workdir);
> -               if (IS_ERR(whiteout))
> -                       goto out;
> -
> -               err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> -               if (err) {
> -                       dput(whiteout);
> -                       whiteout =3D ERR_PTR(err);
> -                       goto out;
> +               if (!IS_ERR(whiteout)) {
> +                       err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> +                       if (err) {
> +                               dput(whiteout);
> +                               whiteout =3D ERR_PTR(err);
> +                       }
>                 }
> +               inode_unlock(wdir);
> +               if (IS_ERR(whiteout))
> +                       return whiteout;
>                 ofs->whiteout =3D whiteout;
>         }
>
>         if (!ofs->no_shared_whiteout) {
> +               inode_lock_nested(wdir, I_MUTEX_PARENT);
>                 whiteout =3D ovl_lookup_temp(ofs, workdir);
> -               if (IS_ERR(whiteout))
> -                       goto out;
> -
> -               err =3D ovl_do_link(ofs, ofs->whiteout, wdir, whiteout);
> -               if (!err)
> -                       goto out;
> -
> -               if (err !=3D -EMLINK) {
> +               if (!IS_ERR(whiteout)) {
> +                       err =3D ovl_do_link(ofs, ofs->whiteout, wdir, whi=
teout);
> +                       if (err) {
> +                               dput(whiteout);
> +                               whiteout =3D ERR_PTR(err);
> +                       }
> +               }
> +               inode_unlock(wdir);
> +               if (!IS_ERR(whiteout))
> +                       return whiteout;
> +               if (PTR_ERR(whiteout) !=3D -EMLINK) {
>                         pr_warn("Failed to link whiteout - disabling whit=
eout inode sharing(nlink=3D%u, err=3D%i)\n",
>                                 ofs->whiteout->d_inode->i_nlink, err);
>                         ofs->no_shared_whiteout =3D true;
>                 }
> -               dput(whiteout);
>         }
>         whiteout =3D ofs->whiteout;
>         ofs->whiteout =3D NULL;
> -out:
> -       inode_unlock(wdir);
>         return whiteout;
>  }
>
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index afb7762f873f..4c1bae935ced 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -88,6 +88,7 @@ struct ovl_fs {
>         /* Shared whiteout cache */
>         struct dentry *whiteout;
>         bool no_shared_whiteout;
> +       struct mutex whiteout_lock;
>         /* r/o snapshot of upperdir sb's only taken on volatile mounts */
>         errseq_t errseq;
>  };
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index f42488c01957..cb1a17c066cd 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -797,6 +797,8 @@ int ovl_init_fs_context(struct fs_context *fc)
>         fc->s_fs_info           =3D ofs;
>         fc->fs_private          =3D ctx;
>         fc->ops                 =3D &ovl_context_ops;
> +
> +       mutex_init(&ofs->whiteout_lock);
>         return 0;
>
>  out_err:
> --
> 2.49.0
>

