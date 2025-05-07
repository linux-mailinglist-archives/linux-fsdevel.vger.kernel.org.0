Return-Path: <linux-fsdevel+bounces-48330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABE1AAD6C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 09:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB8A3B0E17
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 07:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD9221480B;
	Wed,  7 May 2025 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzDpBCyU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEFE213E9E;
	Wed,  7 May 2025 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746601550; cv=none; b=l+dORrH+56fRdjWc/9rn6JhUo/4wi6ONTPe9uDk61XfimZK6DJt7Shfke24nl7MllN3rhgpOcxI0mGZZ58YlVLcLrdrRj3pfEy8OP2YIfT+lxFzDte1AlhsuvL3p2a/RzGCO2hNmRwVwusjXxfcShvsRZcN/SDuSuaTUzD2Bfx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746601550; c=relaxed/simple;
	bh=DG0KPZ4QdR9bks8772omkMX/R6zKp+X/sa+BK0sQ9WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6FynvDn7qXTQpxgqjNCYfIPgu8lsDNHTVODih4fEplpFoDRZS78wfHB+lZWPpnA1wcdB/Pqcngg6DhLWO7UmS/wgbn1CpyyFaPCfm8mMPVVUhUxfvoDG6rl+Qa9mIBgnzdQ5rZ8OgC0ziQe9xSq5q6q8HINt3xhEtf3G+2cPPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzDpBCyU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-225477548e1so68873765ad.0;
        Wed, 07 May 2025 00:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746601548; x=1747206348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z8MJm7QOEEE4G0g7EZK8uH2bldZDsOGk1jOk5w4WeA=;
        b=MzDpBCyUhvpY9WNz4ahi2wkPWW7JH2t8juKK8QDxWyJIo8aJnadiWJIa6+lXuq4Lck
         /jP+bZROgTnc3gYsg0xpSmCGVSm69cJlHM8CAv23aUeA0Dn2VkrVsSvsMRPfSpHFyjBe
         97sPIFFKNQUXcV3b4/Xjn+Dtnmky+z8F2bECbymTCWjIXsmJN7KYIDKIjsBRaNa1xMvN
         Ry2rWVDiLLfaSnC8JzMrrTGEwh2z7s6+uA3GX4mlDbWgUOr/6aYbl418fFu617wGStPR
         xS2ZDTcBFZU++InjP3G6Oef7av/cyWP8f2gPzCcH9299jxKOzm/l1okxI1/JIM9qQ9dQ
         LqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746601548; x=1747206348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z8MJm7QOEEE4G0g7EZK8uH2bldZDsOGk1jOk5w4WeA=;
        b=a4rKuWGq0IDUlc5EACvpSIhcUZaESvRRWAYR0TDez5hrBHBLWvolRWrv+8n+NqENed
         J0/aY1SfBuwQWf0XZCNjyRBdBOzAk9dSHyptOO8swv7GSWCnoG+xK19Jrmv2G+N0LmBg
         GQ4n/B0SEltkTBF/COqkvXfooOM3xeyAhlLRvIa5LHttt27wcM4cOl0tiHzFoVMukK0c
         q30pi0Va2uUahzSfgcfTCI0bG8PCntoGJVe7sqbA5/Vq9UjX5MJhuo5Dp/rLCcCRDNU8
         /svAvX2LFho6fdYgoGKQMJiD8lX+8prWX5jkWw1vxt5KV3CAHJ2stFAL0TugVUAREEme
         htzw==
X-Forwarded-Encrypted: i=1; AJvYcCUu9cv4CKsbPhAXDANJ27lUbzvvjRGrQkfV0vdQz2u5IbVTsqY0gvcsMt/OjpN2jLT0wR83+4XApDY=@vger.kernel.org, AJvYcCV7CueFxTzLt/9/5WCH7KYDepNT+4YBum62D728B/HWJczAL/WQ0K7UYRJbKkcrlKcBwv+eZFgc67hviu7Hzw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy0Wk08G8f2IyBs3p+dg+C4feZIOuexEAonA3lVc07y90QmpJD
	tG0zGhBwwkT9RSpDOxDDoJoTGkqaACEGTGq+YsEoV4EXFPDdrWpw
X-Gm-Gg: ASbGncu953MbxhvyJBpnIov+kRIKYEm9FMGD9ZDP5G2Qdn+gegZKnLV1r/cidzd6dSa
	DNgnzyNEXFPKHM7e3MW3pR7i67DWIVvxnsjlMQ7SiQgWVZYMYAE5A/0w/MgfDfgDZk+IXSH4GVr
	0TqLWugev134diTfLuS82Hg+Zdh6wo/+MBd3kmoS2ia05tkWFzLWTCvkK9bx9NTX57XRhnUKnx9
	FIa7fz2LrDEJcNWMsWY9tktB6P/P+NmBMqgO17hL19mjwJKY4t6SEgMhevZhJHt+3WEDe1tUmzx
	IJK3HAiBbl9aRmxpybW6UpYXVJVAamZ1JznltazcuOWbWdSRPvk=
X-Google-Smtp-Source: AGHT+IG45EJPY9aLpaA4mWOBTXCnsVZU256/yGDIhUKOOVmavzVmB5PbQY4tSVJ5Ujy2FzrTLZ1Vbw==
X-Received: by 2002:a17:902:e742:b0:220:cb1a:da5 with SMTP id d9443c01a7336-22e5ece1dd3mr39581575ad.40.1746601547581;
        Wed, 07 May 2025 00:05:47 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e630dfb61sm7384855ad.143.2025.05.07.00.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 00:05:46 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 64E67423E4D9; Wed, 07 May 2025 14:05:44 +0700 (WIB)
Date: Wed, 7 May 2025 14:05:44 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: chenlinxuan@uniontech.com, Miklos Szeredi <miklos@szeredi.hu>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: Re: [PATCH 2/2] docs: filesystems: add fuse-passthrough.rst
Message-ID: <aBsGSOtlJyARt5tR@archie.me>
References: <20250507-fuse-passthrough-doc-v1-0-cc06af79c722@uniontech.com>
 <20250507-fuse-passthrough-doc-v1-2-cc06af79c722@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1he+shXJXTIyn9jI"
Content-Disposition: inline
In-Reply-To: <20250507-fuse-passthrough-doc-v1-2-cc06af79c722@uniontech.com>


--1he+shXJXTIyn9jI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 01:16:42PM +0800, Chen Linxuan via B4 Relay wrote:
> ---
>  Documentation/filesystems/fuse-passthrough.rst | 139 +++++++++++++++++++=
++++++

Add the docs to Documentation/filesystems/index.rst toctree.

> +FUSE (Filesystem in Userspace) passthrough is a feature designed to impr=
ove the
> +performance of FUSE filesystems for I/O operations. Typically, FUSE oper=
ations
> +involve communication between the kernel and a userspace FUSE daemon, wh=
ich can
> +introduce overhead. Passthrough allows certain operations on a FUSE file=
 to
"incur overhead."
> +bypass the userspace daemon and be executed directly by the kernel on an
> +underlying "backing file".
> +
> +This is achieved by the FUSE daemon registering a file descriptor (point=
ing to
> +the backing file on a lower filesystem) with the FUSE kernel module. The=
 kernel
> +then receives an identifier (`backing_id`) for this registered backing f=
ile.
                               (``backing_id``)
> +When a FUSE file is subsequently opened, the FUSE daemon can, in its res=
ponse to
> +the ``OPEN`` request, include this ``backing_id`` and set the
> +``FOPEN_PASSTHROUGH`` flag. This establishes a direct link for specific
> +operations.

> <snipped>...

> +The ``CAP_SYS_ADMIN`` requirement acts as a safeguard against these issu=
es,
> +restricting this powerful capability to trusted processes. As noted in t=
he
> +kernel code (``fs/fuse/passthrough.c`` in ``fuse_backing_open()``):

I don't see any comments in fuse_backing_open() besides TODO. Perhaps the
sentence can be removed?

> +
> +Discussions suggest that exposing information about these backing files,=
 perhaps
> +through a dedicated interface under ``/sys/fs/fuse/connections/``, could=
 be a
> +step towards relaxing this capability. This would be analogous to how
> +``io_uring`` exposes its "fixed files", which are also visible via ``fdi=
nfo``
> +and accounted under the registering user's ``RLIMIT_NOFILE``.

Where are pointers (links) to discussions? These can be added to the docs.

> +As a general principle for new kernel features that allow userspace to i=
nstruct
> +the kernel to perform direct operations on its behalf based on user-prov=
ided
> +file descriptors, starting with a higher privilege requirement (like
> +``CAP_SYS_ADMIN``) is a conservative and common security practice. This =
allows
> +the feature to be used and tested while further security implications are
> +evaluated and addressed. As Amir Goldstein mentioned in one of the discu=
ssions,
> +there was "no proof that this is the only potential security risk" when =
the
> +initial privilege checks were put in place.

Discussion links please.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--1he+shXJXTIyn9jI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaBsGQwAKCRD2uYlJVVFO
o14vAP9z6UbpIgMGBxsVnCjCqJvWjc98hEDIRQG9rl7EV5CnnAEA3sV2azSp6PUf
0mI5fO9wM0NlYTuu2g8dLC+yD99NEgc=
=nNoh
-----END PGP SIGNATURE-----

--1he+shXJXTIyn9jI--

