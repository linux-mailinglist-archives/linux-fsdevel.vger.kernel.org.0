Return-Path: <linux-fsdevel+bounces-45020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306F5A702F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E195E8454E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CE31F585F;
	Tue, 25 Mar 2025 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fb/yWQEC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77A199EAF
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910389; cv=none; b=JBzj5yeKrNYAbbR8MEyiSz/g3PGt8sDClwncpugeRJ3wv+rg9PLvDhgvRVhsUtJfEnXNeQ3ucTW5GB3Qy27fT7thyZzZbVGzbcZEbtn5BQHf7pWOQQSJ4Fq1eIdNsv6jk12QHUXaYh4sbhEuyjUxIj2qm2LVui2KBglPdK/6NcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910389; c=relaxed/simple;
	bh=mvsCn7sUzf5gZC7tZyC3+OYP4ixjXvgJxj7BoX2WPHQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bo7AG6k4ddZETQPOGpLkSFFswbxrz1WBDLNGDkb4uxc/NrKPKcDCWiY0wSB56qeLHYp272GVSpI4fM3Sn5PXaKWcXv6fFmrbfwwULBTLymhz3U4qjkCng1BwlzQZ5WC0618b2lz2mXgeVLEGAsWwoMtKhOt9D5XOtFe7A5RQwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fb/yWQEC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742910385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEixVZlgDtvXsNJJVSS/WZZohk0QEnKwwNmHA7U3U/s=;
	b=fb/yWQECbQ9X7PBAblDiisXr4fyNPLQvBG/ChapvSnvHHbfl5iFPBNAYao+Pk/MgzuLlCz
	uXdhvYX+7h7s+89bkgD/jEOTmzk+nxW4r3Oxf06XGQeKgiw1Lm4odMMtP6lzDjl0IjlM0N
	9zRCwtqd0LAmQnbm0LJxkYlZZ+AuyJQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-PpAbLfRHN3K_utUGIW3uPA-1; Tue, 25 Mar 2025 09:46:23 -0400
X-MC-Unique: PpAbLfRHN3K_utUGIW3uPA-1
X-Mimecast-MFC-AGG-ID: PpAbLfRHN3K_utUGIW3uPA_1742910382
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-54ac9c33f74so2788739e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 06:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742910382; x=1743515182;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEixVZlgDtvXsNJJVSS/WZZohk0QEnKwwNmHA7U3U/s=;
        b=wfhaH9v5H8b8ABbsdkHhuM48yj5E8ayYtUnm/a0GcmdnlmV96Q0AtcvPW3uzKCKoQQ
         uDuVwk5QiAPI+VDDYb9IWi06KOPlK41/6GE0Ueab/781uKVZ/RmHCNAfeLhFPNDOOxbo
         BzdspMSxBRxI4YFOobfXouICp2Bfqj3NTFg8ifixXCeje3CfG+4x6WzXZYeuTOtYHgx9
         HFTynf8vmtWpoQZudLFqiUhVMf35avmQzRMRFzMkcSLazT9FSdGA34nXdLyzIteSAUOn
         oW0yq6UsOqrLpIYWwLl+GUGMxOd7EBft1afuN0q5dKO7cOfEhe24PjZ+HzDbD9fPBKnr
         2vOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8m4YujJHDYys2hxjPOEZjqdZAQt1ektgmDexFnZofX56fMVZF8tuwqjEWrdzV8qOg1jkbcvs+FO68qxm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6AEIghnzNDUT5oRZSN5voQdUWel9Fam5rXKT8impvYwnuJfXn
	EhRPR+d/rUbnd/b+V2/JdQIYY5QcXopf9aQOo3toM56Lci2OImdGVu/vEX4836vPcPBzgXUey9z
	cv60ZekUTqT0QP9ru/ZnFQaXHi4zs2yQxMOxh3WTyDW0BXY3QfwLHIphXj3jvgp0=
X-Gm-Gg: ASbGnctUYTXrGPxu93OI4lx110Ce6mzdfGX1ZVgiSrVi88xAjTZOZgosecfSoLUG5i4
	Kl2kzGshIGiHJaZA8AJH1fwPtHc1qF4dwR2h1CcN0tZZvIDFkysOY8l6LCOvO8GuI6yhv6nae7c
	ifkfmtYDAZahfCkCN4T+ZABqXCmJXityLkWu101nP1i3+LgDyqDwTnMlhtWrXatPzgqS0t5mwwv
	iXw0PbMnCX8HV/9gZWhvGfjY3hF0TXEf1TEWpnrxQGxdM3mNWWpbnHh8G2pDPrO/EmV2DFJ8wad
	KAzyrLNKxiq6BB6ufclNpY5b+sgX2+3s3mI+vGokCbhw+iViBQ/Juss=
X-Received: by 2002:a05:6512:10d4:b0:549:50da:7ac4 with SMTP id 2adb3069b0e04-54acfadccdbmr7278154e87.18.1742910381990;
        Tue, 25 Mar 2025 06:46:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH03BeLa7nfAfLGIO6qa0QnyqiUOxR+c1gvqRXPZVP2aONtaG11sBdpFI1PQfly/DqPJhYz4g==
X-Received: by 2002:a05:6512:10d4:b0:549:50da:7ac4 with SMTP id 2adb3069b0e04-54acfadccdbmr7278138e87.18.1742910381495;
        Tue, 25 Mar 2025 06:46:21 -0700 (PDT)
Received: from [192.168.68.107] (c-85-226-167-233.bbcust.telenor.se. [85.226.167.233])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6508158sm1505271e87.185.2025.03.25.06.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:46:20 -0700 (PDT)
Message-ID: <5cd880ed009985cb2c85cd5f755e72cc6b595f25.camel@redhat.com>
Subject: Re: [PATCH v2 4/5] ovl: relax redirect/metacopy requirements for
 lower -> data redirect
From: Alexander Larsson <alexl@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Giuseppe Scrivano <gscrivan@redhat.com>
Date: Tue, 25 Mar 2025 14:46:18 +0100
In-Reply-To: <20250325104634.162496-5-mszeredi@redhat.com>
References: <20250325104634.162496-1-mszeredi@redhat.com>
	 <20250325104634.162496-5-mszeredi@redhat.com>
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
> Allow the special case of a redirect from a lower layer to a data
> layer
> without having to turn on metacopy.=C2=A0 This makes the feature work wit=
h
> userxattr, which in turn allows data layers to be usable in user
> namespaces.
>=20
> Minimize the risk by only enabling redirect from a single lower layer
> to a
> data layer iff a data layer is specified.=C2=A0 The only way to access a
> data
> layer is to enable this, so there's really no reason no to enable
> this.
>=20
> This can be used safely if the lower layer is read-only and the
> user.overlay.redirect xattr cannot be modified.
>=20
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Alexander Larsson <alexl@redhat.com>

> ---
> =C2=A0Documentation/filesystems/overlayfs.rst |=C2=A0 7 ++++++
> =C2=A0fs/overlayfs/namei.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 32 =
++++++++++++++---------
> --
> =C2=A0fs/overlayfs/params.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 -=
---
> =C2=A03 files changed, 25 insertions(+), 19 deletions(-)
>=20
> diff --git a/Documentation/filesystems/overlayfs.rst
> b/Documentation/filesystems/overlayfs.rst
> index 6245b67ae9e0..5d277d79cf2f 100644
> --- a/Documentation/filesystems/overlayfs.rst
> +++ b/Documentation/filesystems/overlayfs.rst
> @@ -429,6 +429,13 @@ Only the data of the files in the "data-only"
> lower layers may be visible
> =C2=A0when a "metacopy" file in one of the lower layers above it, has a
> "redirect"
> =C2=A0to the absolute path of the "lower data" file in the "data-only"
> lower layer.
> =C2=A0
> +Instead of explicitly enabling "metacopy=3Don" it is sufficient to
> specify at
> +least one data-only layer to enable redirection of data to a data-
> only layer.
> +In this case other forms of metacopy are rejected.=C2=A0 Note: this way
> data-only
> +layers may be used toghether with "userxattr", in which case careful
> attention
> +must be given to privileges needed to change the
> "user.overlay.redirect" xattr
> +to prevent misuse.
> +
> =C2=A0Since kernel version v6.8, "data-only" lower layers can also be
> added using
> =C2=A0the "datadir+" mount options and the fsconfig syscall from new moun=
t
> api.
> =C2=A0For example::
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index da322e9768d1..f9dc71b70beb 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -1042,6 +1042,7 @@ struct dentry *ovl_lookup(struct inode *dir,
> struct dentry *dentry,
> =C2=A0	char *upperredirect =3D NULL;
> =C2=A0	bool nextredirect =3D false;
> =C2=A0	bool nextmetacopy =3D false;
> +	bool check_redirect =3D (ovl_redirect_follow(ofs) || ofs-
> >numdatalayer);
> =C2=A0	struct dentry *this;
> =C2=A0	unsigned int i;
> =C2=A0	int err;
> @@ -1053,7 +1054,7 @@ struct dentry *ovl_lookup(struct inode *dir,
> struct dentry *dentry,
> =C2=A0		.is_dir =3D false,
> =C2=A0		.opaque =3D false,
> =C2=A0		.stop =3D false,
> -		.last =3D ovl_redirect_follow(ofs) ? false :
> !ovl_numlower(poe),
> +		.last =3D check_redirect ? false : !ovl_numlower(poe),
> =C2=A0		.redirect =3D NULL,
> =C2=A0		.metacopy =3D 0,
> =C2=A0	};
> @@ -1141,7 +1142,7 @@ struct dentry *ovl_lookup(struct inode *dir,
> struct dentry *dentry,
> =C2=A0			goto out_put;
> =C2=A0		}
> =C2=A0
> -		if (!ovl_redirect_follow(ofs))
> +		if (!check_redirect)
> =C2=A0			d.last =3D i =3D=3D ovl_numlower(poe) - 1;
> =C2=A0		else if (d.is_dir || !ofs->numdatalayer)
> =C2=A0			d.last =3D lower.layer->idx =3D=3D
> ovl_numlower(roe);
> @@ -1222,21 +1223,24 @@ struct dentry *ovl_lookup(struct inode *dir,
> struct dentry *dentry,
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> -	/* Defer lookup of lowerdata in data-only layers to first
> access */
> +	/*
> +	 * Defer lookup of lowerdata in data-only layers to first
> access.
> +	 * Don't require redirect=3Dfollow and metacopy=3Don in this
> case.
> +	 */
> =C2=A0	if (d.metacopy && ctr && ofs->numdatalayer &&
> d.absolute_redirect) {
> =C2=A0		d.metacopy =3D 0;
> =C2=A0		ctr++;
> -	}
> -
> -	if (nextmetacopy && !ofs->config.metacopy) {
> -		pr_warn_ratelimited("refusing to follow metacopy
> origin for (%pd2)\n", dentry);
> -		err =3D -EPERM;
> -		goto out_put;
> -	}
> -	if (nextredirect && !ovl_redirect_follow(ofs)) {
> -		pr_warn_ratelimited("refusing to follow redirect for
> (%pd2)\n", dentry);
> -		err =3D -EPERM;
> -		goto out_put;
> +	} else {
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
> =C2=A0	}
> =C2=A0
> =C2=A0	/*
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index 1115c22deca0..54468b2b0fba 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -1000,11 +1000,6 @@ int ovl_fs_params_verify(const struct
> ovl_fs_context *ctx,
> =C2=A0		 */
> =C2=A0	}
> =C2=A0
> -	if (ctx->nr_data > 0 && !config->metacopy) {
> -		pr_err("lower data-only dirs require metacopy
> support.\n");
> -		return -EINVAL;
> -	}
> -
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a one-legged overambitious farmboy who hides his scarred face
behind=20
a mask. She's a psychotic communist mercenary who don't take no shit
from=20
nobody. They fight crime!=20


