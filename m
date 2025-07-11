Return-Path: <linux-fsdevel+bounces-54662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 451DDB0204C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 17:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8719816F184
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E610E2EA723;
	Fri, 11 Jul 2025 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD24POin"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9687D1552E0;
	Fri, 11 Jul 2025 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752247175; cv=none; b=eCc4o/pnYWfC8/tdm1ygTWhsx1t3lW41tQRKTFGHp7wUlyMO2i0+51QZnlUYBbTeQqHXZU5mVY0PYtKv2aU0WPNDuxTOgyjtOnCJOUKde4Ym1fLq2p3Tyw6qs2fHLeGx5LvIcXHEC074x5etXYA7C/6AWmMMc3txCDhjlohXsJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752247175; c=relaxed/simple;
	bh=H6PRdMETs9WfkrtyxZ6tOAgx6ngf8YBak9TCrKYdhvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqcAZcS8D/IHcJheapKRFyhDIwZSmKMVkRZ2/dGuCp4Zq3JysrZvEZds9T2e5L5laKUWdCxi6bAmdLcZwIJZrdx71+ctSw9aMvaDnrqFvh1RHKo527umi0eAuAKZARAm45zXKEx8W63pjt/2m/ot1VkkkeW+HQbt2Y7ElsJrGNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD24POin; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0d7b32322so355841166b.2;
        Fri, 11 Jul 2025 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752247172; x=1752851972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43s3Zf5sbN7meVuCdv71m2W/YBnDSo0JrFNR/OZwvj0=;
        b=QD24POinPAGwGi1rLOam6L0uGkEFueHvHWa4OKlPeJRLTm2GGoyn3ZzDE/Qobc1IIY
         seVW9RaAIqDCUXMGDGhYqqLXTvXLE2jnRudtrDvDazFAYZuZBZs6c4d/FQAyBRDD8p7Q
         ZOV86gW2+PZPLei7zVCbcK0R4FKHBV7cx/CAfV5GUxIVcSVO9lUX6UFlGT40tLJygjMg
         T7vRAA5p7T0Iq6Hd0SvVnau7nFY0jOsrLpChQbijHf5M5mRaWbCfKhTxea3oH07j37rD
         b6djojILMGC9hFU2mtU192LlaTL3zSmc9Gysiz1qrydNpgfIWzk5slVbLLbel6cdySPc
         XC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752247172; x=1752851972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43s3Zf5sbN7meVuCdv71m2W/YBnDSo0JrFNR/OZwvj0=;
        b=XbE4AiIg6vozb0K62M3WXKsrYHr5kHHXYMQ0/MmKm5ZMprBDHzXYv2PHh97LEkCIue
         sYkl0heV8RneQgZY5/let4fAZE6qGs5K9ANeR6JG0JoDcZp+LnAfw3L1BHrotxoT4xN/
         KWggNWUhpIU3Y6PhuDGNKC2PH5Ik5YTbQrWuZcfcXFG6JIe6pz7dk/RbjIEQPQ+OzDew
         sIUF3QbKhzNgcU+f10oS9sNCtoITPSzGJExbZFiqjfjrU/ag0+nMwHsD6ME95Mq7KQkH
         KgjruEAJNsCYjwUYwSJ/b574GWMg1MxgOhIswRcZMYS8FPQr7ZfI/vX4AtYRxmiExR/z
         C9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVRv/Hnb/xg21JxXMjV0fR80sA1O/IQPSiwnxmONzFxgPfF7t9aZawvdgF3csuTYZiCSc6TRPn6TazUgaUhwQ==@vger.kernel.org, AJvYcCXX7U830hP6N+c7BddymBZ/AMPrdG5JiAM9ZMKihBlIxJD+yYkvSYQjmDpOXQidPArHnC4u4OBcEiCknOf/@vger.kernel.org
X-Gm-Message-State: AOJu0YzLlp6HTznzTRrV6wAwXBE3XDiRPb9Go2+mOsWVTa2+vi2FP1rT
	WIKoBxXvEdTiVno5EJ1MTOlaAyBUeIktHmxrcVtZFAznEhXSSXRleLedndRWakhWTDK6O0UDHjA
	aS2WOZwOna456qb450yskBCyQae3uvI4=
X-Gm-Gg: ASbGncsqReB2y/UorEARXRglFbu+6VAqUCx8dfh16MnbQM3u1Ha4dUnecLzPA2PgK8V
	jfjXKC46ITxJ9Q3s5MlXQIAkdtLKdcWuxdxpT9LGfRKFQdEac6s3imTrattA+10EyI/iRlatrHZ
	cWVo8gP75BSyrc7qzrTMCe2O+6zU4xWD+iwc4zlWYGRSCEvclNaOT8/roxqy1/lrjUyQWogdl8W
	ETbKFo=
X-Google-Smtp-Source: AGHT+IHnc0diKX5c5qW3t56ApqIuvBNiUNCKJNP06F/PrsU0Zy/kuVf5iW8cOx9/wb1XelPyBj9zo7LD4riEALDTK/o=
X-Received: by 2002:a17:907:fdcc:b0:ae0:e123:605f with SMTP id
 a640c23a62f3a-ae6fc219d10mr363648966b.39.1752247171582; Fri, 11 Jul 2025
 08:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-18-neil@brown.name>
In-Reply-To: <20250710232109.3014537-18-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 17:19:19 +0200
X-Gm-Features: Ac12FXxyZ4zqc_LVAKTPDbPXIdvQzyg2Q3huZWbcZEEv83iA82_JOMTwpzBSuZo
Message-ID: <CAOQ4uxgHAun6Z3q_adGSs0GqE+WpZfYCpXejuC3DrUS9mF2rwQ@mail.gmail.com>
Subject: Re: [PATCH 17/20] ovl: narrow locking in ovl_whiteout()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
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
> ---
>  fs/overlayfs/dir.c       | 49 +++++++++++++++++++++-------------------
>  fs/overlayfs/ovl_entry.h |  1 +
>  fs/overlayfs/params.c    |  2 ++
>  3 files changed, 29 insertions(+), 23 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 086719129be3..fd89c25775bd 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -84,41 +84,44 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs=
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
> -                       pr_warn("Failed to link whiteout - disabling whit=
eout inode sharing(nlink=3D%u, err=3D%i)\n",
> -                               ofs->whiteout->d_inode->i_nlink, err);
> -                       ofs->no_shared_whiteout =3D true;
> +               if (!IS_ERR(whiteout)) {
> +                       err =3D ovl_do_link(ofs, ofs->whiteout, wdir, whi=
teout);
> +                       if (err) {
> +                               dput(whiteout);
> +                               whiteout =3D ERR_PTR(err);
> +                       }
>                 }
> -               dput(whiteout);
> +               inode_unlock(wdir);
> +               if (!IS_ERR(whiteout) || PTR_ERR(whiteout) !=3D -EMLINK)
> +                       return whiteout;

+               if (!IS_ERR(whiteout))
+                       return whiteout;

> +
> +               pr_warn("Failed to link whiteout - disabling whiteout ino=
de sharing(nlink=3D%u, err=3D%i)\n",
> +                       ofs->whiteout->d_inode->i_nlink, err);
> +               ofs->no_shared_whiteout =3D true;

Logic was changed.
The above pr_warn and no_shared_whiteout =3D true and for the case of
PTR_ERR(whiteout) !=3D -EMLINK

>         }
>         whiteout =3D ofs->whiteout;
>         ofs->whiteout =3D NULL;

The outcome is the same with all errors - we return and reset
ofs->whiteout, but with EMLINK this is expected and not a warning
with other errors unexpected and warning and we do not try again
to hardlink to singleton whiteout.

Thanks,
Amir.

