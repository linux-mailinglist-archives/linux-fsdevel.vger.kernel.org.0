Return-Path: <linux-fsdevel+bounces-57951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B91DB26F60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 20:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B281882F7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 18:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DD423B63E;
	Thu, 14 Aug 2025 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqu/2FVy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D61227B9F;
	Thu, 14 Aug 2025 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197664; cv=none; b=Se5H4y7koYwbv1475ZXc3DQYvrPvf4/XiHK3d7lbKsrC9Dooa0K88ML0iV0Kfj3daOyy6XaIX3flXPioob90fp2UVPnx2OjyCF7p0GDzGhwNo+e25cWwszssUNImFu7qzPE8TqpF7U6k8iuech29KnLRQmorHmLUmLEA/iuEFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197664; c=relaxed/simple;
	bh=tggz2+GmBG4xBPdyVi8HYEMsQK+lBxfBlXLrkbqzFpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdqyvHSd8eXOmIWVItT8IwohYQu/VAc9R/xffgpWXa9YSC3noWWP0oE+otIG62VZO44bLgQs/huPAysXA2+FHHZs5n3aym/BFPsmIFMYCSDwFKyUSl/h4cYficQuX2viJ4LWFyNpCua5F5Yw26h8Q5C/m15fKFjaiJY7nt4KPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqu/2FVy; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7a0550cso214401466b.2;
        Thu, 14 Aug 2025 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755197661; x=1755802461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5RguQAEZjn9f2hOjKQrmC+1X6fHs478ln+1RiZBuL4=;
        b=mqu/2FVyfrb8dRZI2W3d20RGyXuexPzjBpgBo1XOtd3iO6SCQCGtNYQNM3MjMvaOYU
         yZCYDuneP8e+K/Ryit7xNQjya/o1d1JYCtuyEeTxIselhID0/82eLEi5TvOZSorj0wee
         qwN2+N9TKK9G6dSlcT8gxi+hv/p3RGzshGOQlGtolL/i1jbm9EnOHtVvtLL3SxvhMvcK
         A5rkmkzhnLYnWRrNVLz5CYQlh3g0j7ggLFNw5OSB4O5eupFIAQ84h2GFWSjKNMXZzcCl
         nXrmpZguZqItjsA3xqwBEVdREnbUc5ZTBfwzXrsy54Q3grQR1EL7mFV5onGOgavRjGVr
         5K5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755197661; x=1755802461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5RguQAEZjn9f2hOjKQrmC+1X6fHs478ln+1RiZBuL4=;
        b=rob2Z96vCTpTvRxQFXnCYKG0UvKyBca5nCwQMVafY9G0MCfm4adjopOgDoxvnOsm6H
         2IkppmBKAbEcONKbL0Q7RLyMfYb5fRHyUDE4wgly6Gsw7HxiRI1lcaiNB8bpSsPzAHVL
         sidJuvntqdPm1gBVfAgrxbj9IRogsj/DL3QoNGeWlgYqa9BYAxLO5wSUBy4UzBp7oBFx
         msA6R7c4gYTs3ku/QOCK536XfrZmHdhpYsi9eXKt6g3oxcADTIn59meNtXi4exUDUv2g
         VzvD60q1BX08nw+iYl7wXnIGpragy+1QEfPXl1NCDbkseGk3nzrQqOeDx3Xe/PB/VwG5
         ksTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb6syY+DR9KtDRe0QFW/X+WrW5d+GiGRNJD4eFq53Re/gX1PeKvhzr4eXhvBf4xdCUATdaLrNw3RSRU5yhkQ==@vger.kernel.org, AJvYcCVnh3tlc8883uKda2MwHJx+Mo9V1RYBorhmAOS0uM2ID7rkJF+AIY9gdvbZsnkET7RsmtKW+4mlgb7hKElF@vger.kernel.org, AJvYcCWQOhEGkJN4rWVIJxtMEY+ULx/B68spqz8nhZkWBXARgcXdGOVdbEe9idQi4NVL5j6MyEr1XWQhbB+bzC5h@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7t2tHn6x24kV2imcx5i1PcdyNoQZj7pqR98EC1Hi1ZIFrYZ8
	Kp3mQOiKBVYFhRru9y/P5Evs6uQsi0TtIFOjZERh7pn+atmBoN2/jRxr7644KLU484gtN8SmI/c
	I105k5lB0ElACdf/kbHI3F8fxFx9vx7o=
X-Gm-Gg: ASbGnctjhVK3FfBDgWu/PanJmsNrz0Oxhh+UrNQWtXLzhJu9wKnsh/8C64YAKugnXHu
	l0pR0DSoRLQvQf58c4fJ83wdrHQmaL4L5qaNsjih6PuXGO9AkNqiGF9mtZx97cTB4MjUPrKOzvh
	c+K2z7F9WSlMmvWFFbWeLgR03ksYCZHU8drdc8fcbuNvxgqnwILVPPWcuw0fU34Et2Uum1eGBkA
	Khhzk8=
X-Google-Smtp-Source: AGHT+IEuokzxyAX4467XWcBtpl1YzVW89X7lfLdrDPNZ76oXgfod1/bfbyAUT2upv/ekSkmgsjEVtWdXX6pKFwm9zOs=
X-Received: by 2002:a17:906:d555:b0:afa:1b05:69c3 with SMTP id
 a640c23a62f3a-afcbe24701bmr340732866b.47.1755197660800; Thu, 14 Aug 2025
 11:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com> <20250814-tonyk-overlayfs-v5-8-c5b80a909cbd@igalia.com>
In-Reply-To: <20250814-tonyk-overlayfs-v5-8-c5b80a909cbd@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 20:54:09 +0200
X-Gm-Features: Ac12FXxskQaFpte7u50qMgk9eRo6WKhS2AuvFF2sXn9jvwK5SYnQyfdmt_znwtw
Message-ID: <CAOQ4uxg6HDTCNKzp=wTKP4CaLVojzZNb61Wp4xgikYZiWK1TMQ@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] ovl: Check for casefold consistency when creating
 new dentries
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 7:22=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> In a overlayfs with casefold enabled, all new dentries should have
> casefold enabled as well. Check this at ovl_create_real().
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v4:
> - Add pr_warn()
>
> Changes from v3:
> - New patch
> ---
>  fs/overlayfs/dir.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 70b8687dc45e8e33079c865ae302ac58464224a6..88e888ed8696363d6cde39817=
f6c21e795f0760a 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -187,6 +187,12 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, s=
truct dentry *parent,
>                         /* mkdir is special... */
>                         newdentry =3D  ovl_do_mkdir(ofs, dir, newdentry, =
attr->mode);
>                         err =3D PTR_ERR_OR_ZERO(newdentry);
> +                       /* expect to inherit casefolding from workdir/upp=
erdir */
> +                       if (!err && ofs->casefold !=3D ovl_dentry_casefol=
ded(newdentry)) {
> +                               pr_warn_ratelimited("dentry wrong casefol=
d inheritance");

pr_warn_ratelimited("wrong inherited casefold (%pd2)\n", newdentry);

No need to report.
I can fix that on commit.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>


Thanks,
Amir.

