Return-Path: <linux-fsdevel+bounces-68475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 258ACC5CF20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 12:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07FFD353EAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AA93101C5;
	Fri, 14 Nov 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNK46nwF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277E831065A
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121193; cv=none; b=K4/OjJiCsq89V87975trPjs6T8d4m7Jwmmo1woH+e3JsIlPFyp0WorUOVth9wXN74UC57RhirzdzHS4dhUf0HujRfxRAJWilitRqSgnO15ILdO2Jmuw7GXcBl8VT/OE1rbAyv/juaYGt07eEbo97OCFhgG7FjOHh9GJBj2Mcmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121193; c=relaxed/simple;
	bh=tCwBw4AnF2vtIl9rSeHRKWGJE+A+XndJ29JaC2CBIps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja2ciRls5eMaXO8SojfimOg7bIl/tCDi2IVUen/IVb3k16fbG+6+qo2gj87wh6kqNh9hCEBW3lx+7C60fh83mu8v3VeTm7ocdDBMTN1E569g24J583IMD+Jvx6+LWPj4nWezM0/pYYLQYPqtMfSJH9kr3iOra/yz5zysmuiCZNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNK46nwF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso3280837a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 03:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763121190; x=1763725990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksUowDiMBBw0jAf3Vm8E59fNicG0SGTHjGTGP1KX/Rc=;
        b=jNK46nwFz076NcnM8Kw/MYbGa0ePwD8HKqOPj4mn1tSDkIP0VkY7fBp50a4I0uZBdr
         UACnW2ct5H0O4hYOzyS5kJOUCgg+o92FBdgJkWq7DRlJ3Kc7XGQMii4eCT3A1Bp1hkTU
         qinmVtgAAvEX1c4d4sftmIiXpuIqVYT9ApT3eJfi7KTLlYs4EolCWR3zndMpCS/8Mhgz
         B2OhiedvC+OufyR+U5zdXmNG86s6qGBbcBrBcpxPIfauONoWv2G3Yz1XHoV4T5eGMcvK
         u9yY/merK3TuiEwRRyN9qcfBY2BAVWfuUosNja+DdEU/KW/97KibzY1k2MF78F9J5Kng
         9Ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763121190; x=1763725990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ksUowDiMBBw0jAf3Vm8E59fNicG0SGTHjGTGP1KX/Rc=;
        b=JDxagA5QpHaJZN9QBouTFOZ/BacSKS1REiKIMLUKiYgl22AH0V9Ji8geubZJ/CgkMl
         BQTmeNz/ScFofIs03KqVIfFhj6w5U4+gp5Lj63oVienDtCtoBfkAaqlLB149tMWjKTn5
         aUYKW9T5Oo2BDVDeVW9KUZX7lW5Iqa9C4CZX89rQ2H2PIgkZhkijr5PDl+kg0pEnsfJ0
         WzA5i/HMbH6PVDUoiB1CQ+A09aJIWsYVkXuR/GCsF9Mn/4vvs2uruVjIqm7gWeq92iaJ
         0J5DdLBGw4ReMr/tPqiZ89VMChbnj4QTFfrb8uWAJapT3V40w6CPc++f0ZFKym268Auu
         0QEw==
X-Forwarded-Encrypted: i=1; AJvYcCVZpag6MKZjhrRWWDUClbhR/eEYfrtT0nYeNhnByUwNoqyFMSuLH1eBB5q/+okUWOjBDi8zkxyfA17AIYhF@vger.kernel.org
X-Gm-Message-State: AOJu0YzjF6y3fDVn26qxttGZLIJNT5kKV3WH7fVklV+2yOpXyst/rDQ5
	sMrWabK9iQdHCGC9pANPMHt/MWbeMdBCaEmejI7wK+5NVyPNzOtAjJaxBCtfufo/OOZt1OzqirK
	jG/u9wQRKDWba2KNlXL5YFe/11EYfXuU=
X-Gm-Gg: ASbGncv8gB80S8XksrBE95uIhpEQ3VDJddJWPpp1cTNtnmPgC3bIXjLj8MEo9J6Dm3z
	ofhbpejT2uvpTvgXxF8H7GC7jTJIhxv3X0JiTR9a4lo3WQ1ihxUN4rjltrbCKdi9NYufdKmETmN
	KhS36scMNAgJnBgzLxBd6GaasrUfb5t61+eVUfO8k7u9WgJdsPDfaaDEOQWvRBi7SOqMfml5jb7
	p4qsx3DWWVSB1/fuiguPJkmv/EIIxhpL43GF5UvmrCMtKVST/xq+T/v5MJfSwOgto1EiqfUWpwD
	p+9NIAKdL8xtFQBf5ZnN8Y4mIE08Vg==
X-Google-Smtp-Source: AGHT+IFkNCbCK3wtGpbvZ8sWyqGdvw8H6M3hi3GmiaEXmGlh4THeFELMo16lZrrcznsxz7tUwsSSgqFG6UbMZJsfjjE=
X-Received: by 2002:a05:6402:13c8:b0:63b:f67b:3782 with SMTP id
 4fb4d7f45d1cf-64350e9e7b4mr2686740a12.27.1763121190367; Fri, 14 Nov 2025
 03:53:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
 <20251114-work-ovl-cred-guard-prepare-v1-3-4fc1208afa3d@kernel.org>
In-Reply-To: <20251114-work-ovl-cred-guard-prepare-v1-3-4fc1208afa3d@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 14 Nov 2025 12:52:58 +0100
X-Gm-Features: AWmQ_bmj3WV3e9oB_pc-wmTp-eN0ihrkNcdAYjq3ylUYQU-O6HjG8yRlK0U2GcQ
Message-ID: <CAOQ4uxhB2am_xAGugZvAiuEx7ud+8QGPJBwcA+M+LmRvWC-nsA@mail.gmail.com>
Subject: Re: [PATCH 3/6] ovl: reflow ovl_create_or_link()
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 11:15=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Reflow the creation routine in preparation of porting it to a guard.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/overlayfs/dir.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index a276eafb5e78..ff30a91e07f8 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -644,14 +644,23 @@ static const struct cred *ovl_setup_cred_for_create=
(struct dentry *dentry,
>         return override_cred;
>  }
>
> +static int do_ovl_create_or_link(struct dentry *dentry, struct inode *in=
ode,
> +                                struct ovl_cattr *attr)

Trying to avert the bikesheding over do_ovl_ helper name...

> +{
> +       if (!ovl_dentry_is_whiteout(dentry))
> +               return ovl_create_upper(dentry, inode, attr);
> +
> +       return ovl_create_over_whiteout(dentry, inode, attr);
> +}
> +
>  static int ovl_create_or_link(struct dentry *dentry, struct inode *inode=
,
>                               struct ovl_cattr *attr, bool origin)
>  {
>         int err;
> -       const struct cred *new_cred __free(put_cred) =3D NULL;
>         struct dentry *parent =3D dentry->d_parent;
>
>         scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
> +               const struct cred *new_cred __free(put_cred) =3D NULL;
>                 /*
>                  * When linking a file with copy up origin into a new par=
ent, mark the
>                  * new parent dir "impure".
> @@ -662,7 +671,6 @@ static int ovl_create_or_link(struct dentry *dentry, =
struct inode *inode,
>                                 return err;
>                 }
>
> -               if (!attr->hardlink) {
>                 /*
>                  * In the creation cases(create, mkdir, mknod, symlink),
>                  * ovl should transfer current's fs{u,g}id to underlying
> @@ -676,16 +684,15 @@ static int ovl_create_or_link(struct dentry *dentry=
, struct inode *inode,
>                  * create a new inode, so just use the ovl mounter's
>                  * fs{u,g}id.
>                  */
> +
> +               if (attr->hardlink)
> +                       return do_ovl_create_or_link(dentry, inode, attr)=
;
> +

^^^ This looks like an optimization (don't setup cred for hardlink).
Is it really an important optimization that is worth complicating the code =
flow?
What if we just drop the optimization instead?
Would that creak anything?

Thanks,
Amir.

