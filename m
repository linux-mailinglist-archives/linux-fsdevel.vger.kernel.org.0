Return-Path: <linux-fsdevel+bounces-37796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FE89F7CC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CC616DA6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 14:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD82224AE3;
	Thu, 19 Dec 2024 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHfQApo7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE57224AEB;
	Thu, 19 Dec 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617033; cv=none; b=DDvzOI7AFpec1aApfM0HlSOAcSqfEnzDU+QvqnEOxmUVND0LHqIbgsFYw/UaUwMvHzp4Q5OX5/N79/Coo96LRj8I6tvBxZZeeP8h7dGRUiyPAw1gWV1rGtTEBzYDJ+Nl6fltWKG44RBWTE0ly5ink6mrQj0U7JE7Lmq5acx6omA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617033; c=relaxed/simple;
	bh=SvmUuyQyFr4uGst4abikBEocTmIlPcqLVco6Jv0dXjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjRUSshQ9TGB/ewmnfpEL4FIgxNqfUOS0CTYXJE49SnzMbtUkSvzqzcfaXDfw0pmJCOnGiKKxeBItvYlOAA10SB9npMQGOnTBkhpISBxtD2FQ95W/vBKOPdAcuv4Gt19wlaHJnyFzz92Fl11yqKXO9SgNmel3oxmdMbWY4mZISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHfQApo7; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so1020174a12.1;
        Thu, 19 Dec 2024 06:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734617030; x=1735221830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oDR4celxliNyZRpM72Sc5yWpWAlWHmW2d+ic9H91NA=;
        b=JHfQApo7mwVGPIPSVsj8sHkaJb65/DymuHkXvWKx1TH9M5fquX+gKz0ngsW2Vzh5YH
         W0KPnRmxjjqxRIWn71NdfvVxOSNWmKQitqXuuAqwOR6aT1zSoyJcHMkXB6juuOPOTc2Z
         iQmGZEQ6BVDnpjN8LJ6zUMH90ulKFZdtUULDVLNozd1rfx6+KDbZbF8ER7V+dK9U0wuy
         1y5v5fiQa2zUSjeT+sto7eXTqaZlmIwMwyY5yQopIhUfAVv5zTmYZwLlazD0amIZnxlv
         ecaJS+8jEwKGX58TYvToIvghIiNeIADoJpjSzqYIt3tyYG+4VuykTzC1ve2MfHk/jSO/
         /DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734617030; x=1735221830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oDR4celxliNyZRpM72Sc5yWpWAlWHmW2d+ic9H91NA=;
        b=fpAAw9QBx8+Db/JhBdplq3zhIYMDcn+Q6GunqxJd/+IiFoMobuZdZpzdcoo5DGlWe4
         siurVJGhArJazIaEHWvn1X0OR+zy96X3VFZN08QwmezmMN6ptEJT+dKzk5ovzdMydsYk
         TVwbmugDQtP9uDYxliLOrLZ929XM9Gq2yu5qJzoChgOvTCP62o7b/cG5qVSNVP8ipq1W
         28Fm36Appf8v5CIfIBS3cafb+L5A6vIVZGFi8uVgg0wax2ZJOZbyN1EVZfn5mvmkgJgl
         thMU34rcR6bILHbv8AWNQ4Bv9vQOPwXGiFb//5S5qKL2U1raUmzS6qFubh3c4YfEqhjk
         1s0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuO/9zVwZKuPFs7Y7s3rqmQLt9jPgmAINZUSiMuYi055vpLofS90yFOHLdzq2ibj3IsrLMMM9YpPADJxM2@vger.kernel.org, AJvYcCV5x+FbZM53Jhpkus1zDKKM/QqMZFmnWVgY5H+zrpqV1wlnKuLNmnXS5532RaF8RGdh1jfCq0fUgxIZI2pyvQ==@vger.kernel.org, AJvYcCWdMVLRRYf39Mv6RcPi65kPAfeR8gVoOe4itvDjyO3wN2deJfkPh0d6VvN6eRvKuJyxGckaP3v7@vger.kernel.org
X-Gm-Message-State: AOJu0YwJzUxCvl28ICZMKodSRxFSRmSDXBK33HW5ncRsLvFbZkaeS3dP
	O+o2osnjd2Gg7OnDSoLCd+mUfUiDivVC71MwVfyqvYYLjXTPfw/9afqen599Lpl7b01uXSFGzF0
	jnt0k7WSD2T+10NQf+CqsoNGNibM=
X-Gm-Gg: ASbGncudnneDXFVd9HFXuKJpJI1g4bqrkeqivNHnXLYnqLF6FPEJOtvwSlmgldQaPIK
	GqJpg7SXAjUeBuE7dJkrDv56RDcm1f+IbPo2mCQ==
X-Google-Smtp-Source: AGHT+IHnoeVrZy/udZ8RnupvBrpsTluJuRxJva4kaqcCtTaKZXJAqiRK0gCohu/wLYrsH0KeXzdMg67Iu98wUdgKBPA=
X-Received: by 2002:a05:6402:3514:b0:5d0:e877:7664 with SMTP id
 4fb4d7f45d1cf-5d7ee3e0924mr6043649a12.19.1734617027832; Thu, 19 Dec 2024
 06:03:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219115301.465396-1-amir73il@gmail.com>
In-Reply-To: <20241219115301.465396-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Dec 2024 15:03:36 +0100
Message-ID: <CAOQ4uxg2Lx9bKmkou7jGeOr4JfSXYj6CB48bP=SSUYQr+DR7mg@mail.gmail.com>
Subject: Re: [PATCH] fs: relax assertions on failure to encode file handles
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, Edward Adam Davis <eadavis@qq.com>, 
	Dmitry Safonov <dima@arista.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, 
	syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 12:53=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> Encoding file handles is usually performed by a filesystem >encode_fh()
> method that may fail for various reasons.
>
> The legacy users of exportfs_encode_fh(), namely, nfsd and
> name_to_handle_at(2) syscall are ready to cope with the possibility
> of failure to encode a file handle.
>
> There are a few other users of exportfs_encode_{fh,fid}() that
> currently have a WARN_ON() assertion when ->encode_fh() fails.
> Relax those assertions because they are wrong.
>
> The second linked bug report states commit 16aac5ad1fa9 ("ovl: support
> encoding non-decodable file handles") in v6.6 as the regressing commit,
> but this is not accurate.
>
> The aforementioned commit only increases the chances of the assertion
> and allows triggering the assertion with the reproducer using overlayfs,
> inotify and drop_caches.
>
> Triggering this assertion was always possible with other filesystems and
> other reasons of ->encode_fh() failures and more particularly, it was
> also possible with the exact same reproducer using overlayfs that is
> mounted with options index=3Don,nfs_export=3Don also on kernels < v6.6.
> Therefore, I am not listing the aforementioned commit as a Fixes commit.
>
> Backport hint: this patch will have a trivial conflict applying to
> v6.6.y, and other trivial conflicts applying to stable kernels < v6.6.
>
> Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
> Tested-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-unionfs/671fd40c.050a0220.4735a.024=
f.GAE@google.com/
> Reported-by: Dmitry Safonov <dima@arista.com>
> Closes: https://lore.kernel.org/linux-fsdevel/CAGrbwDTLt6drB9eaUagnQVgdPB=
mhLfqqxAf3F+Juqy_o6oP8uw@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Christian,
>
> I could have sumbitted two independant patches to relax the assertion
> in fsnotify and overlayfs via fsnotify and overlayfs trees, but the
> nature of the problem is the same and in both cases, the problem became
> worse with the introduction of non-decodable file handles support,
> so decided to fix them together and ask you to take the fix via the
> vfs tree.
>
> Please let you if you think it should be done differently.

FWIW, pushed two separate patches to branch fsnotify-fixes
on my github.

I guess it is nicer this way and will help automatic backporting.

Thanks,
Amir.

>
> Thanks,
> Amir.
>
>  fs/notify/fdinfo.c     | 4 +---
>  fs/overlayfs/copy_up.c | 5 ++---
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index dec553034027e..e933f9c65d904 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -47,10 +47,8 @@ static void show_mark_fhandle(struct seq_file *m, stru=
ct inode *inode)
>         size =3D f->handle_bytes >> 2;
>
>         ret =3D exportfs_encode_fid(inode, (struct fid *)f->f_handle, &si=
ze);
> -       if ((ret =3D=3D FILEID_INVALID) || (ret < 0)) {
> -               WARN_ONCE(1, "Can't encode file handler for inotify: %d\n=
", ret);
> +       if ((ret =3D=3D FILEID_INVALID) || (ret < 0))
>                 return;
> -       }
>
>         f->handle_type =3D ret;
>         f->handle_bytes =3D size * sizeof(u32);
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 3601ddfeddc2e..56eee9f23ea9a 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -442,9 +442,8 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs,=
 struct dentry *real,
>         buflen =3D (dwords << 2);
>
>         err =3D -EIO;
> -       if (WARN_ON(fh_type < 0) ||
> -           WARN_ON(buflen > MAX_HANDLE_SZ) ||
> -           WARN_ON(fh_type =3D=3D FILEID_INVALID))
> +       if (fh_type < 0 || fh_type =3D=3D FILEID_INVALID ||
> +           WARN_ON(buflen > MAX_HANDLE_SZ))
>                 goto out_err;
>
>         fh->fb.version =3D OVL_FH_VERSION;
> --
> 2.34.1
>

