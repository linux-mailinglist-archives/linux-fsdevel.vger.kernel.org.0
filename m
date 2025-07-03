Return-Path: <linux-fsdevel+bounces-53767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 539C5AF6A4B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 08:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 517847A4AD5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 06:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A9A293B7F;
	Thu,  3 Jul 2025 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xACxaZEt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11437291C06
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751524108; cv=none; b=QzSBxpUdzZoQQT9VLfqoE1r7SXv95abE/mjIEQv21naL4RXErmCEHk6rR5zDSXntGqIAjOAtXT6WDABUjb2i+KlMdEXzKlJk9A5mI6jH//6E6pwVqe/wod1LjA/6lMN4UI6eD4bxVzYA3298gSxbEq8GqCm2evXgBhBbuXyHcMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751524108; c=relaxed/simple;
	bh=MO59kQdKIQ3jRqDULHDpVDumKyq+YbjeeZVE+XaSpoE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KCMdJMUbHMdTnDEsHJWqvBNWlHKdVSJWNy+63C6DbJHGxsRzQAhfrYUqA/fye2uLdiNdSLDExOX/vAzMLKJuVGYY8kgtrqvEwq38pE9JIHt12fUz0IBAWT3ZakwKuo8WVGoRESuvdsEhGj0YUyW1ZWT3CsNO/Jbo5dA0sWx6akY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xACxaZEt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a54690d369so4963896f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 23:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751524104; x=1752128904; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MO59kQdKIQ3jRqDULHDpVDumKyq+YbjeeZVE+XaSpoE=;
        b=xACxaZEtZzNddQVaa69kh/phyWzwSRWQdUHdNE5V+SqhMVH2BpcAWZkmwfrX8rCIh/
         6kirOdzkO33H4dimHfcc7LNDuSf4u1ErTsT2eION8QZS2uSmUju8kholZu51b18MmUzU
         RnJYhc2Ppxb3VNMlDUxNZSDQmISKWm3Y8GxbRdjbkYnUSKWWI8ZpHiKIDUoqyFXmCW2h
         uVgr4L/HIuUlSFsfakqR2wsjWZA1/LfU5rlGEnLhbEuLdRS1JMIHao/mbmFX3uN5kLns
         pEfMwIICqPvR/Qz4j7WdxGV/Vg75yTIHrYzQbKCTgQlv2I0oPDWEp81E1HoT3Hoba3Qj
         UorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751524104; x=1752128904;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MO59kQdKIQ3jRqDULHDpVDumKyq+YbjeeZVE+XaSpoE=;
        b=sxqL+MjJi+24RjZVbejAKVyynyKw5vYhnR95EZka/IZN+MZ9VHeuwlSt7oH7/lwh7Q
         zzQICQuKXl8heAIFtREkRuHohKawAVla06RkdzFB5CjrgbB3fkae2wdb5vpUY5CjqQFY
         t2OkiFHk9NryJ98ss52KzyYdvs57xS7IC8qxnjHqfZc10eRVwI30z9ndegJVw0gx63ZL
         tEu4AAZWUHRnAvPD3ie+M4TvTIfRqyc/fxMKrz8MJV4sjDINqCBw65zCALKf1nSfEMC/
         xcfs4NEODMyf5uKjm9K92fFMz8r/ibNYU2aL4+ODw3rcNOWT/wXlXgpWKgs8yQ2v0L3N
         P30Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmorlvwTh2yU8+dE9JzQGXoDeF8U42OCNX14eS/s2mOFnRij4g0Stfw/ZD2VXv8B5Vo369IJX8CrgMeB+h@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/jnPlJNJLckiBZt8tSA5imtoPG5ri7qr27hATW4s8LLdljQs
	0wsEuGMHGSq3vqRB2iwAyhprxVXTgkMbQZbDm1G7eXLWgNEojoliW6hmxWLU4239uVc=
X-Gm-Gg: ASbGncsHtEYVykqgFXR37jJVyIZXI7xCeAYmDhgyvVfZ/FSjpJouIbvAW2XULkh7tt0
	vYjP2vtrI1feBm6clwbgdeQn/OCuNqdl/YmzhFJ9QAC/fQTF4yvQmJB6NYcVnmyK4einYk3MrNR
	6BuCTqv7YkK4PIG3ZYfbkb4fzk0WSb0nfmAAOw3wkyr2lTLjKZ7WF2FbFSnBnDgKUJfm1QKIv+t
	EA/AwsoVbTGn6Hrn6LBZUOdQtLw6OR9GFqwVrcldV8W6yVVyH/XvbMMHw8zQZIc3xzlvpv+PlKr
	0Q0GBWP5/k5SduL+D3bgMGEuHnsDF5NSnwI6P5LhzVAJZenASc2IDZPyBw/JJyMvFZwMGxp31e6
	p
X-Google-Smtp-Source: AGHT+IF5h/wZ6d5NNeUR6agDG/7PLqUPnsk7I84b3H4DX8EaAsYMBom8LuJRN2UToI44f6ice+Jz5g==
X-Received: by 2002:a05:6000:703:b0:3a4:f6ba:51c8 with SMTP id ffacd0b85a97d-3b1fe5c082fmr4402569f8f.14.1751524104371;
        Wed, 02 Jul 2025 23:28:24 -0700 (PDT)
Received: from [10.1.1.59] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a997b1ecsm17126905e9.11.2025.07.02.23.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 23:28:23 -0700 (PDT)
Message-ID: <e3a974d1f7fd1ed2a631d3ddf46eceec3a386615.camel@linaro.org>
Subject: Re: [PATCH v3 bpf-next 1/4] kernfs: remove iattr_mutex
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com,
 andrii@kernel.org, 	eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, 	viro@zeniv.linux.org.uk,
 jack@suse.cz, kpsingh@kernel.org, 	mattbobrowski@google.com,
 amir73il@gmail.com, gregkh@linuxfoundation.org, 	tj@kernel.org,
 daan.j.demeyer@gmail.com, Will McVicker <willmcvicker@google.com>,  Peter
 Griffin <peter.griffin@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, kernel-team@android.com
Date: Thu, 03 Jul 2025 07:28:22 +0100
In-Reply-To: <20250702-hochmoderne-abklatsch-af9c605b57b2@brauner>
References: <20250623063854.1896364-1-song@kernel.org>
	 <20250623063854.1896364-2-song@kernel.org>
	 <78b13bcdae82ade95e88f315682966051f461dde.camel@linaro.org>
	 <20250702-hochmoderne-abklatsch-af9c605b57b2@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-02 at 14:17 +0200, Christian Brauner wrote:
> I'm folding:
>=20
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index 3c293a5a21b1..457f91c412d4 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -142,9 +142,9 @@ ssize_t kernfs_iop_listxattr(struct dentry *dentry, c=
har *buf, size_t size)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kernfs_node *kn =3D ker=
nfs_dentry_node(dentry);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kernfs_iattrs *attrs;
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attrs =3D kernfs_iattrs_noalloc(kn)=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attrs =3D kernfs_iattrs(kn);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!attrs)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return -ENODATA;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return -ENOMEM;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return simple_xattr_list(d_ino=
de(dentry), &attrs->xattrs, buf, size);
> =C2=A0}
>=20
> which brings it back to the old behavior.

Yes, that makes sense and works for me too.

Thanks Christian!

