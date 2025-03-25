Return-Path: <linux-fsdevel+bounces-45021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8D1A702FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5225E3B7D71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CC11F55EF;
	Tue, 25 Mar 2025 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArXh+vNJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3732E338B
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910492; cv=none; b=RAVkXlFXleFSezmbjIAZcP5af5f2CGLq9x8Ep97AW74ZzH0+xrSr/R/I0eyJEZSVyH3LthPaAGrQoHnFFcDn1xZHtdwfwS3FkQNNMoTF+s9uhLQmcYUSxpnNghPKWK/5fzQ/NKSw/l2v/cHNs1wPSA3c+Lzj1oG6R6zr/KZljas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910492; c=relaxed/simple;
	bh=Pkdftas30ZShBg4l6Fi+mXHRJROMo4U7jhhKneT8skw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A+kFhHrwY3NuWZzrzglvSjCMSBMLOOEf1jAg9ISgqfS9Lk4sOfWmQHZKVVYwLRJcZJ7RSRMJrz+9c3BfKdWL7xGMfiIESnpwRBX9p9hjaGtSE5hUsGJDudEVZFg+yR7Nb4gU2cjo9i9p2ux+EBwaacpLjhY3yYhhltNvJUE9yyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArXh+vNJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742910488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwNB0f7ZLvku/rEGzLbGjcHUh2U4BlBrHXQprEvt544=;
	b=ArXh+vNJmq3jRt98xLxFha7xz3jZ/VnY4EPVyQL3GpOqNtIYwGb+gpi2CTLfNslf18/dLh
	0jUBPamx+SUIxsPNi/H0IPX/fMlFpdDITy8VSHKOPreNhHZFAj95cFxclBkvYwPz3J0h5Y
	aVB+F6a2gXxq/Xe7KKQR7U/VMS5c5Ys=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-pYmLZ7NBMOitoitSoLBJ-w-1; Tue, 25 Mar 2025 09:48:07 -0400
X-MC-Unique: pYmLZ7NBMOitoitSoLBJ-w-1
X-Mimecast-MFC-AGG-ID: pYmLZ7NBMOitoitSoLBJ-w_1742910486
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-54991f28058so1830690e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 06:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742910485; x=1743515285;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zwNB0f7ZLvku/rEGzLbGjcHUh2U4BlBrHXQprEvt544=;
        b=rJPX1Z3ckTQ+o1qFYq9xgq85cpnvlY0Gs0LaHhCmAnddoANrAVVB2so02/woOjGuTE
         QDPjsXXdi/YYFv1X9ejQ1CTXcrWCJE8JzG3BkTNx6o24l5TkSEtQzubNAAQWKnCYNl28
         Au8H/UVD4Ri+k7kE1OM/jkl34yazZR14zPMgJDDU94KlY0K5/bwCSyztyXT4btBNsd5p
         H4XM5EUyypnTOq2mzAs2Df4vvx3BxviBR7D/uYwzZnDbK/TdKdjNh7g90Hinpo05fEw7
         BOPTjr/f/Dr0fsVS544k00lDVejmV5gPHqVBtc1Mhnxu9zrKE0vybhdrrS683ePmsrng
         twng==
X-Forwarded-Encrypted: i=1; AJvYcCWSFigtjWf0r42mYrF6RWdgb+ntg0W5tbOFjtwUHUiM9n634WEOKhpt5k9uk69G2evlpipzaElvgms5M0Q1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbg/lMJvnlPS8Al0k5JyZq/okS7zgbjXzQJM8KSAC9cZ1xE4KL
	iYbs3XMLmgp5OcuxyDnmidOVVl4+QTbJqlRkZ5eiStyS9VIHSx5NFXfZNSlb5G3EJiL+cpORJJr
	pu1Qy5itA/VzpnCSP4RZGLGoDpe2KVHPl5lzzegUOHH60WyelYTfFXLFnVhaYZ5c=
X-Gm-Gg: ASbGnctpjrwXioBkqqRuHRkvWSxEqmpusSLHlcTVTWVeNSmpv2Po8T1oZtfgMo/bgX4
	1apCEYyEii2T0dCdFTVIpQxfkrw/d+2lXUq7yuqUVkKlHob12GmU2pvJs3NDgXR3I1DVoV8xqHt
	5v85H0nLBVLdOFjYMlzMPKw4y55zCkTkO60PEYgwlZ/QpZ/+XUbJxUHeLKIFGzmAZMutBBSqLL3
	a2Q5GKqgewud/Yv36aqokptPKQ4g2jiMvL08Ls0vyul0XRyXJBsJjP8KNkA747WD65YY2XTUoRO
	8JdqvecDG4uptqzVQYcqGtEWuRJNfdD8Is+v/5ZpDhvuhtoDzpx/H5k=
X-Received: by 2002:a05:6512:3b98:b0:545:576:cbd2 with SMTP id 2adb3069b0e04-54ad6479e3bmr5053461e87.10.1742910485348;
        Tue, 25 Mar 2025 06:48:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvdCrdMiEvpP0NY6Hc3+DywbRwRGczY4mNKveBdL6tYRBc+n8ZuqjW9TSj92f/C27iWoRsAQ==
X-Received: by 2002:a05:6512:3b98:b0:545:576:cbd2 with SMTP id 2adb3069b0e04-54ad6479e3bmr5053453e87.10.1742910484874;
        Tue, 25 Mar 2025 06:48:04 -0700 (PDT)
Received: from [192.168.68.107] (c-85-226-167-233.bbcust.telenor.se. [85.226.167.233])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646893dsm1503845e87.44.2025.03.25.06.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:48:03 -0700 (PDT)
Message-ID: <acc20a3215e0b4b7945f57cc1fb22c0f102997ed.camel@redhat.com>
Subject: Re: [PATCH v2 5/5] ovl: don't require "metacopy=on" for "verity"
From: Alexander Larsson <alexl@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Giuseppe Scrivano <gscrivan@redhat.com>
Date: Tue, 25 Mar 2025 14:48:01 +0100
In-Reply-To: <20250325104634.162496-6-mszeredi@redhat.com>
References: <20250325104634.162496-1-mszeredi@redhat.com>
	 <20250325104634.162496-6-mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-25 at 11:46 +0100, Miklos Szeredi wrote:
> Allow the "verity" mount option to be used with "userxattr" data-only
> layer(s).
>=20
> Previous patches made sure that with "userxattr" metacopy only works
> in the
> lower -> data scenario.
>=20
> In this scenario the lower (metadata) layer must be secured against
> tampering, in which case the verity checksums contained in this layer
> can
> ensure integrity of data even in the case of an untrusted data layer.
>=20
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Alexander Larsson <alexl@redhat.com>

This works well enough for composefs, but I agree with Amir that once
we start allowing redirects into data-only lowers, even with
metacopy=3D0, then we could at least allow verity=3Don.

> ---
> =C2=A0fs/overlayfs/params.c | 11 +++--------
> =C2=A01 file changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index 54468b2b0fba..8ac0997dca13 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -846,8 +846,8 @@ int ovl_fs_params_verify(const struct
> ovl_fs_context *ctx,
> =C2=A0		config->uuid =3D OVL_UUID_NULL;
> =C2=A0	}
> =C2=A0
> -	/* Resolve verity -> metacopy dependency */
> -	if (config->verity_mode && !config->metacopy) {
> +	/* Resolve verity -> metacopy dependency (unless used with
> userxattr) */
> +	if (config->verity_mode && !config->metacopy && !config-
> >userxattr) {
> =C2=A0		/* Don't allow explicit specified conflicting
> combinations */
> =C2=A0		if (set.metacopy) {
> =C2=A0			pr_err("conflicting options:
> metacopy=3Doff,verity=3D%s\n",
> @@ -945,7 +945,7 @@ int ovl_fs_params_verify(const struct
> ovl_fs_context *ctx,
> =C2=A0	}
> =C2=A0
> =C2=A0
> -	/* Resolve userxattr -> !redirect && !metacopy && !verity
> dependency */
> +	/* Resolve userxattr -> !redirect && !metacopy dependency */
> =C2=A0	if (config->userxattr) {
> =C2=A0		if (set.redirect &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 config->redirect_mode !=3D OVL_REDIRECT_NOFOLL=
OW)
> {
> @@ -957,11 +957,6 @@ int ovl_fs_params_verify(const struct
> ovl_fs_context *ctx,
> =C2=A0			pr_err("conflicting options:
> userxattr,metacopy=3Don\n");
> =C2=A0			return -EINVAL;
> =C2=A0		}
> -		if (config->verity_mode) {
> -			pr_err("conflicting options:
> userxattr,verity=3D%s\n",
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ovl_verity_mode(config));
> -			return -EINVAL;
> -		}
> =C2=A0		/*
> =C2=A0		 * Silently disable default setting of redirect and
> metacopy.
> =C2=A0		 * This shall be the default in the future as well:
> these

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's an oversexed soccer-playing filmmaker possessed of the uncanny=20
powers of an insect. She's a foxy nymphomaniac mercenary on the trail
of=20
a serial killer. They fight crime!=20


