Return-Path: <linux-fsdevel+bounces-68266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A01BC57A76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D03394E6B55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789B735292B;
	Thu, 13 Nov 2025 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUf+W6FA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41683351FDA
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040547; cv=none; b=ep9MhRqYh28HTXWtDChkWVVEkLM4RYrorKmkO9mBDLaZQdujhSE7M8dVoxM9Abf38CmKq1aMWOg1u7NB5w6Zq0evGBzT9NsOBjWYJvM1+c/GbhJ+0/qa3xbcBlsumhgoPLS4jifZSys5euwrnuEfmhTmxJiwQV+lvjPir/ZE95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040547; c=relaxed/simple;
	bh=X2R+F/XRtaKhmUDSKPMYcTX6v8IAEUkyS/OWFpx+E2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEhmYsiQnSPlnc1qJZnpLHztcyGZsbqa5FKudD3o6rMEQo5gLdHxNW4a0Oh2D78pgwe8yoPuKJcRjxHAYwrFpHFkeFCw6o6O/Xy74Coudqm58mBTXIYJkix9cVZVDh1s30meW8SlWvHeay0B+WTqQwBPf1Xca7taA0qYzzS8LHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUf+W6FA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso1219419a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 05:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763040543; x=1763645343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oY71TIPYVN9PuTiZ3OlvZTDSV+me+lv0LSynZBsnDaM=;
        b=eUf+W6FARmBejhLDTdbSSxh8+IN5pl4cUzj7BTggr3MXR8y26RgddMXJ8LFw2ZSGHz
         iebTeyqOE+ghXtuw3N4h0ZqY3naaCk3Aio5UmtawkwpUJ8XcMd/EPVEot02OBvNCk/28
         NWkCvYTVifpUy1b627ojojUjvtNO+GlhIW/pQoBOEJydxzoJYjyDS7J464WWR5n5rcf7
         OZhdCyp5ulxhLZTqcSyR3zmeTUnFF3nNHbG3QYtYLNZ4Bu6IPaR073h3jN7Zk4A0AZrs
         OehtGsDbTXCWxy6TMrHPA1EaTc9z3YL44YnKa+LjDjMN403gnRELCZO8s2Q09RTRnBwU
         LVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040543; x=1763645343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oY71TIPYVN9PuTiZ3OlvZTDSV+me+lv0LSynZBsnDaM=;
        b=O9pw1emYeVXodjjII/Y8nORLsLYXE35MB3dUCqDf+PD+2gKo2P21MfdyLFYSrk5Pk4
         HQ76K+2PxFi7aOTGr5/H2dtOvHGORfNajG2R5L9gw7Ci66pwgctcPdC3HAkUl4bxg7Zd
         jXMI+Fd/UP2QnB9QzhtDy/Kic/+HNUpM2JNsEGuAJs6CWsyZTDJkXtK3KJ3M5TyRTTZ8
         RUeFplgBhObLC0B88e+y3/RTp07KAE7TO7RZIDy4e3fxJgInh5eH0lyJuMY6RCmMMlSE
         SGZBcHPMI/rFCNFBCjbcTTKL4umPGF3MqtbvHmVhq6oBM3NdE8QSg2a2WU2+oXrNYWj5
         u4vg==
X-Forwarded-Encrypted: i=1; AJvYcCWG/uzHO3XZHwDpayXoAuNs7MTpTYl00DFwpM3rCyIE3I9WTAaf1Ar1l2wTAmf2zWAeSM9U4UdvFeSLoN7C@vger.kernel.org
X-Gm-Message-State: AOJu0YwdTFl5jsbzoTanIUvh4lVd53cmIB7bgYhZDy6HWpWLp+HOTMV0
	qukMDMHWXHQcQVLk8WMD4HKF8m6u+U1n+W5P9k4Vgp9IgCY1Jx/aQWVc+TWfbFN7EhGbCk1QiP+
	CaOXlYnFQxNvetPcJO0hYV2ZChxDpG00=
X-Gm-Gg: ASbGncs6ywzZH/soEtU2sEzwkTDD14vR1PDtYhr6nZiyC+Yvu1h962SH1Bx7/QhArSe
	ip4I6NoTBa9rChvG0MAJaR1PoO1ITaOUkZF9i9gvRXMml4MGnuM4LtKRir0VcNfjNNtTHeIPKvJ
	jZiWgwPeKFrXkdmqQ9qytsa/uxs6xrp1cqhWHK/7qr6MfN+23JvpTWmHM4ZImHlTVmgtoogpHuy
	bzAMDEMUC2uT3XE934wcbXCe/sHQ/km1D62qtiltX/i6xu93wXm4hf8B/VZbikNfIODPuXF/MKn
	tvyMzdBUsqbtD+nYp8E=
X-Google-Smtp-Source: AGHT+IG6QRdFBuSfgkoabmXTvXE8ZnDE+eQzyviPPzlvtafhiPqXkvftCkuT4MQoh0Za7vLQNsP91nL7FaNQn+LD8Rw=
X-Received: by 2002:a05:6402:1cc1:b0:643:46cb:dad6 with SMTP id
 4fb4d7f45d1cf-64346cbdd85mr682950a12.19.1763040543274; Thu, 13 Nov 2025
 05:29:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org> <20251113-work-ovl-cred-guard-v1-15-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-15-fa9887f17061@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 13 Nov 2025 14:28:50 +0100
X-Gm-Features: AWmQ_bmfC3d1_ow-oZGvxLTAnQ7gAY9RNR8soroa1d8l0d8d2H5GDHsMtZAD7qM
Message-ID: <CAOQ4uxjGAz+WR0iseLLrMskseqGgQGEoVrJo1Jm_yFCnx=W3YA@mail.gmail.com>
Subject: Re: [PATCH RFC 15/42] ovl: return directly
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 2:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> No need for the goto anymore after we ported to cred guard.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---

The subject is too generic ;)
but I think this one should be squashed to prev patch

>  fs/overlayfs/inode.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 5fa6376f916b..00e1a47116d4 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -178,7 +178,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct=
 path *path,
>         type =3D ovl_path_real(dentry, &realpath);
>         err =3D ovl_real_getattr_nosec(sb, &realpath, stat, request_mask,=
 flags);
>         if (err)
> -               goto out;
> +               return err;
>
>         /* Report the effective immutable/append-only STATX flags */
>         generic_fill_statx_attr(inode, stat);
> @@ -204,7 +204,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct=
 path *path,
>                         err =3D ovl_real_getattr_nosec(sb, &realpath, &lo=
werstat,
>                                                      lowermask, flags);
>                         if (err)
> -                               goto out;
> +                               return err;
>
>                         /*
>                          * Lower hardlinks may be broken on copy up to di=
fferent
> @@ -258,7 +258,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct=
 path *path,
>                                                              &lowerdatast=
at,
>                                                              lowermask, f=
lags);
>                                 if (err)
> -                                       goto out;
> +                                       return err;
>                         } else {
>                                 lowerdatastat.blocks =3D
>                                         round_up(stat->size, stat->blksiz=
e) >> 9;
> @@ -286,7 +286,6 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct=
 path *path,
>         if (!is_dir && ovl_test_flag(OVL_INDEX, d_inode(dentry)))
>                 stat->nlink =3D dentry->d_inode->i_nlink;
>
> -out:
>         return err;
>  }
>
>
> --
> 2.47.3
>

