Return-Path: <linux-fsdevel+bounces-45019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342EAA702DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A1084300D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB08925A35B;
	Tue, 25 Mar 2025 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGXeei5w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699B0259CA8
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910271; cv=none; b=MMhs//Od98/bN+vsQyVVCkWA4kFMqTX1KhtErRc7nElI4QR9FLqxWMK6IFmuD3bV9YJpI3NCOsYfi/dNcebokhwhtTMFnl+xisgwXgSsn9be5Jyh7itPUh6LuAi0ggd8kVHy1EKYk7VV8JjesdQlu8ABT/juKBGmR/v9MdNc2Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910271; c=relaxed/simple;
	bh=vUGhTHCiM39ua8g4of6+OOOZoPSb2wLkprROoEpfjZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UWi/HSbFuI/25OYH0ZZUCpW8ZWmCRSkVbI0DBO9+urX0c7RPcqNXSpZlHceOfbXFmMrOKiICwhw8wgjeIkgSeYhtFMHY0PkzsFOIr/a6Z0XIUPJJjHYqABAdc361MNpXpyTvoqJgMJI0oXzdmQcNM/mR+ynWyiv1OJLL0ZD/Erw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGXeei5w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742910268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uFpFgvH2gBwTf8TolffHal+9Kdrk4IrE8NXo0kJf/w=;
	b=UGXeei5wZQh5Mk8bG7aui6WY26RFkB6tQhafid01SKtLGlIncarVR6LNH6YxQbqJ+hJRtB
	DF8joPJuF9aLSmF7amBt0n6NFFE8mJN97m01E5zrcmekLhFXvb6Ppli33y3M6jkj0vqXsP
	inBC8fGRqPjS22IizhQNgdOSWbx/fn4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-hO6c80TcNdOrPQZ0fRrurw-1; Tue, 25 Mar 2025 09:44:27 -0400
X-MC-Unique: hO6c80TcNdOrPQZ0fRrurw-1
X-Mimecast-MFC-AGG-ID: hO6c80TcNdOrPQZ0fRrurw_1742910265
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30c2e219d47so29556411fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 06:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742910265; x=1743515065;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uFpFgvH2gBwTf8TolffHal+9Kdrk4IrE8NXo0kJf/w=;
        b=UzkFpB71CtlVpBlevOIk/FxvLX9NUKZ/b5q6zfnQNOfgcna8sAj3Q8TkOG0vgHOQdk
         jAwLcbFBk3gLl3pS3yClG5y0WW5mz8q6Guqrx0wIZuQvvxioBdxl45P+akmqwSMI65fG
         iT19bUhnMUTwndJInvH+7tgr3T0USpAEXc4m4F0vbQ9QNGEldGd20EVP0LLAtZUpx8E+
         G5sh0rneJKxIGBNeurKcYIRacw2spVj3N58KFR5KWIsTNharaULfLxNL+qJE63ZfvsnC
         uQ4kxcXWXMylmQB0X9Kptwb66GrB28egkkiyA7a6bHt8aNIaLmkwOOq7vMU2cVXjFmzW
         zl9w==
X-Forwarded-Encrypted: i=1; AJvYcCU5NVE6XvTDMzclWxePhvmr0tMSRxsv7R+rLKhqgIVqJLuaUuoOWXINzaGCsb91JAVR8auzqTWW17IEWsum@vger.kernel.org
X-Gm-Message-State: AOJu0YyorNSdBxjGfA+WUFcq9ioJTMVC2HWoHgf64vt2aNoiwbt0lDoJ
	j2UFDzzXVAowjA1i+yNgAl9EJCSClpnrdXz02VARbuVAijiQSB6NKutEpXVb50baemDWp7gWSme
	TVBiKBjN2k0uwqguQA6Svoq69kESXmUSNl/zy4IXdQv8aLCXb8cTjvD2xp1SsndI=
X-Gm-Gg: ASbGncvENvaP0Y9TBgX1gb85a5tUFUFtDAgFTtmvvhkxpEVef1QLmgxPxkqhrBV1Gbh
	DcMB01lZdPBTGCTfANwX/EodQg+AqdU007Gs+km7i4X8Rryahx2RkDpSQqnLSMpMHlqS0p+rWiq
	7XBoXQDL+oBEKNLd+y8LSo3B8knm7R9/LfzPzcBbieiAatQZEk3ysZIjbBZPL9VIqD8W6svokUp
	TifP1YJ98ItIaSzrrCD5n8OJw2CaYVK4gRDnkqx8db07nuBpRLsKL/zdy1D+bYrjnXwzcSd/V3u
	bBWZNCq02ULDKZNBuHxbaNnxitGHmaChbTO1u5QC3jnwvc8PWlkvIMc=
X-Received: by 2002:a2e:bc04:0:b0:30c:201a:149a with SMTP id 38308e7fff4ca-30d7e2aab8bmr68047521fa.25.1742910265307;
        Tue, 25 Mar 2025 06:44:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw3uhbkWkgY9gk6y+UldcTEdHo6SsepuvsubGwOVEr3yo+wB19zaRaKWh2NVeURzoKmS0ieg==
X-Received: by 2002:a2e:bc04:0:b0:30c:201a:149a with SMTP id 38308e7fff4ca-30d7e2aab8bmr68047391fa.25.1742910264816;
        Tue, 25 Mar 2025 06:44:24 -0700 (PDT)
Received: from [192.168.68.107] (c-85-226-167-233.bbcust.telenor.se. [85.226.167.233])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d9131a3sm18190261fa.110.2025.03.25.06.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:44:24 -0700 (PDT)
Message-ID: <d3eee00ba034dd04df964d28025504436bec6055.camel@redhat.com>
Subject: Re: [PATCH v2 3/5] ovl: make redirect/metacopy rejection consistent
From: Alexander Larsson <alexl@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Giuseppe Scrivano <gscrivan@redhat.com>
Date: Tue, 25 Mar 2025 14:44:23 +0100
In-Reply-To: <20250325104634.162496-4-mszeredi@redhat.com>
References: <20250325104634.162496-1-mszeredi@redhat.com>
	 <20250325104634.162496-4-mszeredi@redhat.com>
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
> When overlayfs finds a file with metacopy and/or redirect attributes
> and
> the metacopy and/or redirect features are not enabled, then it
> refuses to
> act on those attributes while also issuing a warning.
>=20
> There was a slight inconsistency of only warning on an upper metacopy
> if it
> found the next file on the lower layer, while always warning for
> metacopy
> found on a lower layer.
>=20
> Fix this inconsistency and make the logic more straightforward,
> paving the
> way for following patches to change when dataredirects are allowed.
>=20
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Alexander Larsson <alexl@redhat.com>

> ---
> =C2=A0fs/overlayfs/namei.c | 67 +++++++++++++++++++++++++++++------------=
-
> --
> =C2=A01 file changed, 44 insertions(+), 23 deletions(-)
>=20
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index be5c65d6f848..da322e9768d1 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -1040,6 +1040,8 @@ struct dentry *ovl_lookup(struct inode *dir,
> struct dentry *dentry,
> =C2=A0	struct inode *inode =3D NULL;
> =C2=A0	bool upperopaque =3D false;
> =C2=A0	char *upperredirect =3D NULL;
> +	bool nextredirect =3D false;
> +	bool nextmetacopy =3D false;
> =C2=A0	struct dentry *this;
> =C2=A0	unsigned int i;
> =C2=A0	int err;
> @@ -1087,8 +1089,10 @@ struct dentry *ovl_lookup(struct inode *dir,
> struct dentry *dentry,
> =C2=A0			if (err)
> =C2=A0				goto out_put_upper;
> =C2=A0
> -			if (d.metacopy)
> +			if (d.metacopy) {
> =C2=A0				uppermetacopy =3D true;
> +				nextmetacopy =3D true;
> +			}
> =C2=A0			metacopy_size =3D d.metacopy;
> =C2=A0		}
> =C2=A0
> @@ -1099,6 +1103,7 @@ struct dentry *ovl_lookup(struct inode *dir,
> struct dentry *dentry,
> =C2=A0				goto out_put_upper;
> =C2=A0			if (d.redirect[0] =3D=3D '/')
> =C2=A0				poe =3D roe;
> +			nextredirect =3D true;
> =C2=A0		}
> =C2=A0		upperopaque =3D d.opaque;
> =C2=A0	}
> @@ -1113,6 +1118,29 @@ struct dentry *ovl_lookup(struct inode *dir,
> struct dentry *dentry,
> =C2=A0	for (i =3D 0; !d.stop && i < ovl_numlower(poe); i++) {
> =C2=A0		struct ovl_path lower =3D ovl_lowerstack(poe)[i];
> =C2=A0
> +		/*
> +		 * Following redirects/metacopy can have security
> consequences:
> +		 * it's like a symlink into the lower layer without
> the
> +		 * permission checks.
> +		 *
> +		 * This is only a problem if the upper layer is
> untrusted (e.g
> +		 * comes from an USB drive).=C2=A0 This can allow a non-
> readable file
> +		 * or directory to become readable.
> +		 *
> +		 * Only following redirects when redirects are
> enabled disables
> +		 * this attack vector when not necessary.
> +		 */
> +		if (nextmetacopy && !ofs->config.metacopy) {
> +			pr_warn_ratelimited("refusing to follow
> metacopy origin for (%pd2)\n", dentry);
> +			err =3D -EPERM;
> +			goto out_put;
> +		}
> +		if (nextredirect && !ovl_redirect_follow(ofs)) {
> +			pr_warn_ratelimited("refusing to follow
> redirect for (%pd2)\n", dentry);
> +			err =3D -EPERM;
> +			goto out_put;
> +		}
> +
> =C2=A0		if (!ovl_redirect_follow(ofs))
> =C2=A0			d.last =3D i =3D=3D ovl_numlower(poe) - 1;
> =C2=A0		else if (d.is_dir || !ofs->numdatalayer)
> @@ -1126,12 +1154,8 @@ struct dentry *ovl_lookup(struct inode *dir,
> struct dentry *dentry,
> =C2=A0		if (!this)
> =C2=A0			continue;
> =C2=A0
> -		if ((uppermetacopy || d.metacopy) && !ofs-
> >config.metacopy) {
> -			dput(this);
> -			err =3D -EPERM;
> -			pr_warn_ratelimited("refusing to follow
> metacopy origin for (%pd2)\n", dentry);
> -			goto out_put;
> -		}
> +		if (d.metacopy)
> +			nextmetacopy =3D true;
> =C2=A0
> =C2=A0		/*
> =C2=A0		 * If no origin fh is stored in upper of a merge
> dir, store fh
> @@ -1185,22 +1209,8 @@ struct dentry *ovl_lookup(struct inode *dir,
> struct dentry *dentry,
> =C2=A0			ctr++;
> =C2=A0		}
> =C2=A0
> -		/*
> -		 * Following redirects can have security
> consequences: it's like
> -		 * a symlink into the lower layer without the
> permission checks.
> -		 * This is only a problem if the upper layer is
> untrusted (e.g
> -		 * comes from an USB drive).=C2=A0 This can allow a non-
> readable file
> -		 * or directory to become readable.
> -		 *
> -		 * Only following redirects when redirects are
> enabled disables
> -		 * this attack vector when not necessary.
> -		 */
> -		err =3D -EPERM;
> -		if (d.redirect && !ovl_redirect_follow(ofs)) {
> -			pr_warn_ratelimited("refusing to follow
> redirect for (%pd2)\n",
> -					=C2=A0=C2=A0=C2=A0 dentry);
> -			goto out_put;
> -		}
> +		if (d.redirect)
> +			nextredirect =3D true;
> =C2=A0
> =C2=A0		if (d.stop)
> =C2=A0			break;
> @@ -1218,6 +1228,17 @@ struct dentry *ovl_lookup(struct inode *dir,
> struct dentry *dentry,
> =C2=A0		ctr++;
> =C2=A0	}
> =C2=A0
> +	if (nextmetacopy && !ofs->config.metacopy) {
> +		pr_warn_ratelimited("refusing to follow metacopy
> origin for (%pd2)\n", dentry);
> +		err =3D -EPERM;
> +		goto out_put;
> +	}
> +	if (nextredirect && !ovl_redirect_follow(ofs)) {
> +		pr_warn_ratelimited("refusing to follow redirect for
> (%pd2)\n", dentry);
> +		err =3D -EPERM;
> +		goto out_put;
> +	}
> +
> =C2=A0	/*
> =C2=A0	 * For regular non-metacopy upper dentries, there is no
> lower
> =C2=A0	 * path based lookup, hence ctr will be zero. If a dentry is
> found

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a witless guerilla astronaut with a mysterious suitcase handcuffed
to his arm. She's a mistrustful communist journalist with an incredible
destiny. They fight crime!=20


