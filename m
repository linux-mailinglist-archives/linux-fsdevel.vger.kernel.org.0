Return-Path: <linux-fsdevel+bounces-68268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F9BC57B15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 887D834A406
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC4A1B87C0;
	Thu, 13 Nov 2025 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAsBu8BO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DB12D1F1
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040784; cv=none; b=XUmt7KjCAa3uiWZDoBvhkX6ngXKWd/jK/DIsVmqSR+uIbDATcm/eG/aash8gjQzKtOIXispp1+vy2RIreRqYUsLOh+MQNixleqc1v/v/B/ydBob/RUbD7Pf5wxAyiFnb4TsvOZ2vuhahZqKX1GSBaXy6zjCnlavx1iWz6FL/ceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040784; c=relaxed/simple;
	bh=PWdWtpMwm7TK04XxRu0ZWopcsf9EJ+150nhJ8g682Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrO/we3+qvdJdPu7O0BPFmwIq4JLVF/rBqtxZDxeETZMivuMNY0xb/4n1I90fhKhiwBS0q29Lr+btwWAyX+QYlUm8lHGtrsvQ288eLWrFjIgGPHgEagZBbk9T6J4GMnPFgPNRxg8fHn8QbYXYcAlyxyXN6Ov585pI4FHku8L3No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAsBu8BO; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so1466479a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 05:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763040781; x=1763645581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8LGqwMAvQKE3C9UxWHGkwnvKdBLEoTQWuCK/v1mU08=;
        b=OAsBu8BOrOHMKkotWz7ZQhQNQm6yBcK7y8MGEqmW4H4ZvkXGCp8dPulCN/9gwIJx+p
         ZDIQoW00c4mVDafMeO+iHWhi4CRh4/5Wwu7KuXD9IMCdfKEXNTavmMiZV94ycqeTy5DR
         9C+lKGZA3yIovCGPPS4qIELCSUVl//+g9vW1QU+lABbaI0+zvBDTU6XaO1e97HUKXHM9
         UizEpUv3xYG0TQtOlDhLbJQtmDnQzlFNe5bv07DoFhY4avhzMXI05TFtVyLfaPj9yHZc
         ReO5eKjhY+TyVuHiixGojzZs93HhVLkVGTNY2Fp3Tt1vegGFIog4Ps4StLpIp1k5HKjQ
         6Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040781; x=1763645581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E8LGqwMAvQKE3C9UxWHGkwnvKdBLEoTQWuCK/v1mU08=;
        b=qfLfga1ojE3TlzatwpLztlmNZFTBwt7AqneoHujY9QZi1I/lIRuTHO2sxf3snANXOk
         ABPacSDOTZ1Ce3PBn7L5gssgFkJibw40Q7s5jz17LZ14NkRGABCuQFT9MirmufbMHTJf
         RKU5CaSt2JHYysWZWTEGk/B/ooaT2mWiRdCbxLvw/ISliKwxqbAYah6HFajiaJuipE5o
         lN4pQEBIUcNU/q+YuZsQ6l7VpB73V7NMJrWPrRrxzT2AEnXyOBC+IpHKPiZxQt5U3eI/
         /1GiLkicbj3ka9Z6AibCxD014A5OmUcMNJPabLSs4J6lVzK/Uk2clkZ7kPRH0Hhy1Uyp
         nq7g==
X-Forwarded-Encrypted: i=1; AJvYcCV5bHc5njl+XwpDhtChhr/seEpvSwcTyR9Dye9dzQEfBDPNo/jsOGM4qc9P+1lTjKudGS1DL/YDv6CWFOGk@vger.kernel.org
X-Gm-Message-State: AOJu0YzFNmZU1kcEWl/7P9567Foy8zmHa7cX3PIrHrlFpRnWkxMYh8nn
	ip/bRSr+jI9hA95UIZj5Q1TjMQXW4VZdkibWIk+pmKvivz7tx62amW30or6cvJAuq9qmsPlkSYk
	v4xa6nA3567867F/5w6EdPaxAhZbR/ZM=
X-Gm-Gg: ASbGncuTLfSeRiMZLd4ZJ2YRd1/3F/UI+Kp3cJRjEMLEjy6wszvaJ3WizT+dNRqCiCC
	wUyHnDRYJiuPEqIPpDSM1fdeTFUV6J+7FthUCLlI0fw4VUOZ4QeX57c8/Q5F90ehjp1lmveC6b2
	UPiS+bpHuq8XPIYHhqiDaeId5GciboYGXtbiyXabbgdQ9pQI9JwmIgeTQ1aeOgZfTiAgzjHz/34
	9dcfgavWgNx7/XTtgML4lYn1IpjX0tZLDLT2dZ6QlmmxNocI96snzcA5RtQAntSyX6zjvYmjuzl
	1tdB49HzwJnhiVm/fwlaFsqHZgAorw==
X-Google-Smtp-Source: AGHT+IEaxOVDhsc9jZw1RYkKWH1/DrDjRSkatluW7LrAZDlgm9qz3UetakvQdTrECJNNy1tI8420S4+sCqsaHLVeMDw=
X-Received: by 2002:a05:6402:42c1:b0:63c:533f:4b25 with SMTP id
 4fb4d7f45d1cf-6431a4d60aemr6052357a12.15.1763040780787; Thu, 13 Nov 2025
 05:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org> <20251113-work-ovl-cred-guard-v1-25-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-25-fa9887f17061@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 13 Nov 2025 14:32:49 +0100
X-Gm-Features: AWmQ_bllksn6y4glJIYhv-nklVzF7xmCVMWq03fTJp1rH6xOsLLGpbql0Ta6TgE
Message-ID: <CAOQ4uxhehyGUYS1rSs=8Qo9PHuHAR6S=WkY28r4o+jAjZ6UObw@mail.gmail.com>
Subject: Re: [PATCH RFC 25/42] ovl: port ovl_check_whiteout() to cred guard
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 2:03=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Use the scoped ovl cred guard.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/overlayfs/readdir.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 1e9792cc557b..ba345ceb4559 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -350,26 +350,22 @@ static int ovl_check_whiteouts(const struct path *p=
ath, struct ovl_readdir_data
>  {
>         int err =3D 0;
>         struct dentry *dentry, *dir =3D path->dentry;
> -       const struct cred *old_cred;
>
> -       old_cred =3D ovl_override_creds(rdd->dentry->d_sb);

I think that ovl_override_creds() here can be dropped.

The only caller ovl_dir_read() must be called with mounted_creds
because it is also calling ovl_path_open() and iterate_dir(realfile

Thanks,
Amir.

> -
> -       while (rdd->first_maybe_whiteout) {
> -               struct ovl_cache_entry *p =3D
> -                       rdd->first_maybe_whiteout;
> -               rdd->first_maybe_whiteout =3D p->next_maybe_whiteout;
> -               dentry =3D lookup_one_positive_killable(mnt_idmap(path->m=
nt),
> -                                                     &QSTR_LEN(p->name, =
p->len),
> -                                                     dir);
> -               if (!IS_ERR(dentry)) {
> -                       p->is_whiteout =3D ovl_is_whiteout(dentry);
> -                       dput(dentry);
> -               } else if (PTR_ERR(dentry) =3D=3D -EINTR) {
> -                       err =3D -EINTR;
> -                       break;
> +       with_ovl_creds(rdd->dentry->d_sb) {
> +               while (rdd->first_maybe_whiteout) {
> +                       struct ovl_cache_entry *p =3D rdd->first_maybe_wh=
iteout;
> +                       rdd->first_maybe_whiteout =3D p->next_maybe_white=
out;
> +                       dentry =3D lookup_one_positive_killable(mnt_idmap=
(path->mnt),
> +                                                             &QSTR_LEN(p=
->name, p->len), dir);
> +                       if (!IS_ERR(dentry)) {
> +                               p->is_whiteout =3D ovl_is_whiteout(dentry=
);
> +                               dput(dentry);
> +                       } else if (PTR_ERR(dentry) =3D=3D -EINTR) {
> +                               err =3D -EINTR;
> +                               break;
> +                       }
>                 }
>         }
> -       ovl_revert_creds(old_cred);
>
>         return err;
>  }
>
> --
> 2.47.3
>

