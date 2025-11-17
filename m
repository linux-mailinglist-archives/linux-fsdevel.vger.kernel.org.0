Return-Path: <linux-fsdevel+bounces-68698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 220DBC6365C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E7754EDF3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03132324B34;
	Mon, 17 Nov 2025 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gA72PwZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D229286897
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763373335; cv=none; b=h5Ra/AWBlmruqhIh4VWvqxnhJRWSyF9aBe7vshJNtCsAqcg8CC6kqdclv1amPiE1qBIRY08WqOsrXDTythtuF5u4oLO0NwgxMg2+1lYoip+soRniwVKccVIlvfsJfEA/KY3fhuIECea+DJVh53FyG142zhyuJ1juGJJBscco8tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763373335; c=relaxed/simple;
	bh=mbfqgMlgAZGEp1MTsFHP9p0GINPHMCO4aTwfngB/Kmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvAR58PIlZKUiEZPVr1kond5YD+garoiTHRu2ZyXHQlocHvbYzmWv3lykIzRjKh+xCUc71bbHRAv7tQRGPAf0EgcWO3ouVnTdXDle930c5prqMdF69deDSat/teMdTA8IwJyX8BdE8FJvg0PF3vd8fQk9P9M0Iafp2tgBrO/5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gA72PwZi; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so6694728a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 01:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763373332; x=1763978132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaM20/LebyWp7KNDcj2dnq1btlcS+CDQ9mPs7xg6lq4=;
        b=gA72PwZiqsmmQ54blHlX0l4JB/YlIsWQ/J0GtFtW+lu6FBW3U3qv7Y/65TBieD1N8/
         SieRUGMfjVluB5NMHjl34UbCDFxPqHjM6ImRgx1g7UJy/uf+WOkTTcaDEDBA7k5hALuV
         6ah0KFdQL1yaqDYj65rzlpynkaq/8SqqCvma79yxHBzn2I6uQkSdYHXbgAmqgYwrHXbd
         X9/htT1vavAGZ6w84b5C5PG8moXvfmIdb4WeReYCy1U0x+qqutUWke90BK8TfNoZwDaS
         il0AgMtt0H3TIEsJnTpmwrW6FvtcRecxNt8ybwHdHzzLFoPR9YZ1CG1ZGBf88+3W1lJG
         k4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763373332; x=1763978132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kaM20/LebyWp7KNDcj2dnq1btlcS+CDQ9mPs7xg6lq4=;
        b=naCS5EQy98UT8vEHPChhKMhfuVjcq27vQOSLUf0vMPWpLQySMpgRj9Il1GgBTbjQCu
         2JG//YQ+18358WqUph+bOzKcHSH6WLWzppgW0zaeUE+TIntRTaEQMut7nUjfXqCIOZ/E
         eZdsrYjZ+vpNzY0jVrBH/Jgehszcy6yt1HAls63MQkBNEcxUq/FMbsTalrZFK3SKcb/E
         4BVKEFa+5WxqkU/NDhJ6dOxCRrOjXt4UizAaqkjgihuaFPDBactEi70qSlnjOvejuldg
         Pd7BKHPPIKejajeUEN+ESk9FJ5Ju7BY76uVmoXvS/VqAnLQKMzoHg3BQPPvljf9mUuHE
         eKew==
X-Forwarded-Encrypted: i=1; AJvYcCXrREJ8u62VeUjnf0wVa8GY4Ht2I9QRCLy6nhmSfhyU1DWh9+Xq2IZQBhakNqwK+ku+n7FUg7HuxSP2RY3y@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/tmM3Z8kBWsCPtYP77TL4GMgCI0GvlijuuQwLzlSW1i0VNGlQ
	BNpGfUBSFrn2Yn1G5MfaKFpAjRtLLTLavFQuDbixlYuhUUlEDitZmGM3EDWMguHjCwx3i+CgcW4
	/un5lWGjPVvioGmz5jMj2p4ReUxvPuns=
X-Gm-Gg: ASbGncvekFnxyz59kd29T1dbw2Ve2ywJ7BvQF0FBv3c/r0GfyZL+KGdNbtqReyCoXFu
	yXDb4yRv/HAYIp1GBcJ7dEYGm8Wez08EGva2ZXlIRbuFb39uF12bX0LP/7C4R7TKvSJhURcfRqp
	PH37Glo5QAjWVvCSBz0kQeowKYlt7a32HJrMU3ub4tvW91v5ncIS+qvgET4ChAEPoQic9lBmQnd
	FRoH/6V968BdGHKyVvHL+NU5E8vbZr4Bv2Tu1W6QNZ88IK7QdqMJ1mtuBBJxyg8wGZBwFqmq092
	rC08doDpLHLiEmugLQ==
X-Google-Smtp-Source: AGHT+IFOzQhT+umUUhEWEDUzuJIovDuUNO/O/raziapLXfMFVK7nryiKwf2fSS/oKvTZPuD8Def+UvAJhdPaZfP5ZC4=
X-Received: by 2002:a05:6402:5188:b0:63c:66b5:bbbf with SMTP id
 4fb4d7f45d1cf-64350e76061mr11447399a12.20.1763373331702; Mon, 17 Nov 2025
 01:55:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117-work-ovl-cred-guard-prepare-v2-0-bd1c97a36d7b@kernel.org>
 <20251117-work-ovl-cred-guard-prepare-v2-5-bd1c97a36d7b@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-prepare-v2-5-bd1c97a36d7b@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 17 Nov 2025 10:55:20 +0100
X-Gm-Features: AWmQ_bmvfkdb1mmo-rGl_lHW_kxSD_AM6Svdg9h8eCI97ENz8trjfvjbKCc5JKk
Message-ID: <CAOQ4uxiUWs+ZG5ce7M+oXuj-xg8+wKeRMcJngtG3E4ApVa4KHA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] ovl: port ovl_create_or_link() to new
 ovl_override_creator_creds cleanup guard
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:35=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> This clearly indicates the double-credential override and makes the code
> a lot easier to grasp with one glance.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/overlayfs/dir.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 1bb311a25303..cb474b649ed2 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -657,10 +657,9 @@ static int ovl_create_or_link(struct dentry *dentry,=
 struct inode *inode,
>                               struct ovl_cattr *attr, bool origin)
>  {
>         int err;
> -       const struct cred *new_cred __free(put_cred) =3D NULL;
>         struct dentry *parent =3D dentry->d_parent;
>
> -       scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
> +       with_ovl_creds(dentry->d_sb) {
>                 /*
>                  * When linking a file with copy up origin into a new par=
ent, mark the
>                  * new parent dir "impure".
> @@ -688,12 +687,12 @@ static int ovl_create_or_link(struct dentry *dentry=
, struct inode *inode,
>                 if (attr->hardlink)
>                         return do_ovl_create_or_link(dentry, inode, attr)=
;
>
> -               new_cred =3D ovl_setup_cred_for_create(dentry, inode, att=
r->mode, old_cred);
> -               if (IS_ERR(new_cred))
> -                       return PTR_ERR(new_cred);
> -
> +               scoped_class(ovl_override_creator_creds, cred, dentry, in=
ode, attr->mode) {
> +                       if (IS_ERR(cred))
> +                               return PTR_ERR(cred);
>                         return do_ovl_create_or_link(dentry, inode, attr)=
;
>                 }
> +       }
>         return err;
>  }
>
>
> --
> 2.47.3
>

