Return-Path: <linux-fsdevel+bounces-54633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2403CB01B84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 14:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFE71CA291C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 12:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C09528E571;
	Fri, 11 Jul 2025 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMFgB+L9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6EC25761;
	Fri, 11 Jul 2025 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235762; cv=none; b=vBPufZksPoxWdjZk8mNdJId/HACzkAmipyWfYlUSF2qd860I+RRvjkw34wrL3FcrrJr8I4R5rCZkdYlwntoSAf3GHuMVAkoF5tsg4vjOhaQv/Ll6mxCmAhisHfnCKw0gmUtqOAPLhA2OBJs+e+F34tmZnURB1VHCU4YqtCbWW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235762; c=relaxed/simple;
	bh=G0GQ74vGgwQf+TQ3rDHz3iUbUViN7ZEwFojIl0rS/L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHIxH44gID/oozEy0pbjX9dY7rDC4ezctqtA/D8Po/2fOhYw+GnFwYz/7IvnQrrOjb3s3qn06D+kDBAXyFiaj4ExFui4ihVp3jGtFIbzpsJE1a486To4xg+PhD1j9M1Kr77K6RnZt4EBy+LeV1i9aqY2X+yBpnCkIS2RHQOiG1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMFgB+L9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c5b7cae8bso3237290a12.1;
        Fri, 11 Jul 2025 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752235759; x=1752840559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0XKiAUSdIAQAa04MdIVReKzNrvcidr6RKGPmDR90Yg=;
        b=SMFgB+L9+48amY7DyUBBlXSrP4NtX8nBKrN0WFysw5XbXbhIrcTuoMNi9hzDnqEu1B
         UOJzZ/fXM6NJ+r/BVNhhyrZQlBGRmsObs8mulJiMh23h0ciGVC2R7lEakDGL7xvYmKG6
         RFq48zmBqOyBidOOHnuarY28d+D6OEPTLlRlZqke2CmwFzBcPPTw6ajMXr1ueb++76Vz
         c6592ZyotRJpURHdenMiLvRLLEqezkRodtZ1ROJ2i9PUt7Sd3gv6bBVZYCp2N0PzofDt
         aPXE9DmbwCU9UMg7Yb4DCz6jpJtI6hEDJ4sVo5XzdJ0aMXg/PLWnEZxlElGRQi2h1Koy
         sZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752235759; x=1752840559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0XKiAUSdIAQAa04MdIVReKzNrvcidr6RKGPmDR90Yg=;
        b=JuHdP3w5a6UkZ/YBuDu2wTCli6fZj+mqgRYQJU9bTaw6uDHOZuunclQDSZbtB7pT98
         93XyzvG9nV0JA0z+v2vXRIdQSTX/wB3gOfpZmO+bja/vzkt1LpQ6cdfy0UGKjfg5H4qk
         X+/KPOGdmiI+GzORqIDt4OBTvyQPz1d8XyN7bibeA5HUrLeF8sK0MZ0dhOaAVhbRMeEw
         N0Pm1N3pKgZQIqNjC+S3LCTM4T/f5/BtdVcZqUH605tyX4x4pB0AxWzIkJ1AXNrOchTG
         BeaH5JA6oNhVK1Jaztskk8mRssrrFgL7+n6JEui6tZ9ZLFJ9D6OMeZv2TniqqpmAxNN5
         2kAg==
X-Forwarded-Encrypted: i=1; AJvYcCUqe9jEwPiCMlGRsN9JmlCi6cZclNkOfAmekQhE6947ZzVp5Gffh/ioXDzuctpuQGeB1UqfGtDQ+ZKNephK@vger.kernel.org, AJvYcCVcG4hSlK9yw9UzF53vPcAbCcnmDxZSMvDj+u+5WJgkxdvRpIWXzonWxcsbAnYz7Aj2rY3AekaDklTyXo3HKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyM3U1bBj52GUnGqau2xK9Zi9ihAqzHSBhO4oiDDmpaOMXXdM0a
	wYlzIM985TNkXT+ixJmPY0jmSY0HeCokTELi+JcE3G4XhNZ5Z6JS/E1Ijc/Pc5v5WgU9XjFWMJJ
	/z679XrKY/P8/bvpeplAytBfwd0ZG8kx5svROWV/xCQ==
X-Gm-Gg: ASbGncuVFp/kG0AbodlnGXhV4sRob5OKhlFP/6gWsgNWIFqSl/k+1NyFp3En2PUSed2
	qa+nlKAUUNejBONBbeuS4hvsaVR9ycNEcHlxJ8ng0Spg07Pc94yGpldiI6wMDsyoiGaQHUgwfrX
	KgcbojfmUlz2ZUr+pT5aZxcGp971XW2Se2f9pQ4GV0oh+851qWaG0rijPKY4C0mDBBPzFWmUerp
	Os7iI8E9J+5Z1R1sg==
X-Google-Smtp-Source: AGHT+IH/+pJxhTmcXSeDcmsn+ekfSJAoPsUfzFGaqJE1nMjB2V6ADgQGFfkjSGt+5XPp4DE4v4ZKEdeE1ZTvOp6VXsI=
X-Received: by 2002:a17:907:3e23:b0:ad5:a121:6ebc with SMTP id
 a640c23a62f3a-ae6fb7c8d52mr275624666b.0.1752235758684; Fri, 11 Jul 2025
 05:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-6-neil@brown.name>
In-Reply-To: <20250710232109.3014537-6-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 14:09:07 +0200
X-Gm-Features: Ac12FXxRlVMQ7b_bVQD43uuXBABsuSw6WbQWbIjMDuufCEQZo9mV-cJTqtLAEnc
Message-ID: <CAOQ4uxin1AKX8EUMcHCdTkv9u7OE=K3rW03sex1HbTJYn7h2Ag@mail.gmail.com>
Subject: Re: [PATCH 05/20] ovl: narrow locking in ovl_create_upper()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Drop the directory lock immediately after the ovl_create_real() call and
> take a separate lock later for cleanup in ovl_cleanup_unlocked() - if
> needed.
>
> This makes way for future changes where locks are taken on individual
> dentries rather than the whole directory.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/dir.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 144e1753d0c9..fa438e13e8b1 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -326,9 +326,9 @@ static int ovl_create_upper(struct dentry *dentry, st=
ruct inode *inode,
>                                     ovl_lookup_upper(ofs, dentry->d_name.=
name,
>                                                      upperdir, dentry->d_=
name.len),
>                                     attr);
> -       err =3D PTR_ERR(newdentry);
> +       inode_unlock(udir);
>         if (IS_ERR(newdentry))
> -               goto out_unlock;
> +               return PTR_ERR(newdentry);
>
>         if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
>             !ovl_allow_offline_changes(ofs)) {
> @@ -340,14 +340,12 @@ static int ovl_create_upper(struct dentry *dentry, =
struct inode *inode,
>         err =3D ovl_instantiate(dentry, inode, newdentry, !!attr->hardlin=
k, NULL);
>         if (err)
>                 goto out_cleanup;
> -out_unlock:
> -       inode_unlock(udir);
> -       return err;
> +       return 0;
>
>  out_cleanup:
> -       ovl_cleanup(ofs, udir, newdentry);
> +       ovl_cleanup_unlocked(ofs, upperdir, newdentry);
>         dput(newdentry);
> -       goto out_unlock;
> +       return err;
>  }
>

Thank you for getting rid of this goto chain!

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

