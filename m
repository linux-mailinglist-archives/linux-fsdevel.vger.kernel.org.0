Return-Path: <linux-fsdevel+bounces-44949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC529A6F1A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96F516AC9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 11:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9AF1EFF85;
	Tue, 25 Mar 2025 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkfkorWK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD8F1E7C28
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901521; cv=none; b=Kj7R9YUMbBRT9oBnv03aHPDgPsBzu2kdAm4hQlTLDDvcDpyS9sxks2BwpsaGmPB9j6W5aFPivMmwMGH8iuOuyGW9WxAV3pMpelTUTuAfVCmZKpk+KFartaAhqB5YfjSEWk6B9cXCXl0iF+IPfWJ/ULe3RxPIuBpiL4C1YcZnWbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901521; c=relaxed/simple;
	bh=4jpQ9O+Mm2ay45C7PHlPJfLQut0Dpac7zKp+/HTmrqI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CCPbgFCJ2fYRUqF6sndd6AWw/HsN3KcCtJMZWVyHdA1vR44yeQV5BZ/4pPy0frZSN5xnR0DDHSc6cFtbokurf9cl6wsgTt7QYJS03d3CiGUkfT/xlFLXLI1f23Xk/3x7ZMVCVzv5IHKRtisMZr9Fj5m/KIYDpLuwJEXwgrm+5YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RkfkorWK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742901518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azyksyM59CObgIbjB5KdlQwEi6gUMHF1D6Q1zjjdoDI=;
	b=RkfkorWKGouzeiuXUFOcAvmNfMv2+j6zpZYjBjIlwI5mS/FY7xUrowi3DoJPdwibw3Cd5z
	y/8v0pEdwgm9nt6cr0Wp7PpumYYj31gbi0cclOBd3aebgVe23m59V2w59Ik1uevBmrkbW5
	y8jA2W8n30ElBzAY9bphRSnrdVlH9q8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-4rRN1x9rMeK24dDYpO8DYg-1; Tue, 25 Mar 2025 07:18:37 -0400
X-MC-Unique: 4rRN1x9rMeK24dDYpO8DYg-1
X-Mimecast-MFC-AGG-ID: 4rRN1x9rMeK24dDYpO8DYg_1742901516
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30bf93818e3so21813441fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 04:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742901515; x=1743506315;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azyksyM59CObgIbjB5KdlQwEi6gUMHF1D6Q1zjjdoDI=;
        b=lz52nvmlGBO4iOrztsfSrntFYBnTDBP9tBatElrAwwf2mGZ95jW4hVPjMHuKR8hzNR
         uTRcl/ty7Os6cvOyhoybVHgSO1AQbAConG6jh55pmvv24oZGqTrFBG4QWvms7vSFydce
         Iy9xPoZ0/1DgfDYGbL4cV0BMuEKab7HK96tNPQQcMNOUr+gCg1fOFOL/LR00/5LGW2DP
         tsw/oeQ+Q5AgiUyBjL+e3gbh1eUiH8znD2vmXFuhWrCPER5cjZolXVfxFPy1USmEnzQO
         7Qb3/nOjIZr/OfWFYO61Bn+Rp3/6onW23pfcS8MMrNNpkHx5uIdpjP1fNA0wYK5mo8Dm
         Wfqw==
X-Forwarded-Encrypted: i=1; AJvYcCVUx0hFAusi/RxdHCMQ/pLTyb19EfJJPHcq9s8O6Ryu4kEgMtXys3PHgO7+hU8tbTNt2jILUgP5lcjDDdgG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw0Us85Q5wGMjBO4QO8+M47D6RR9FlBD9HW9Ft6+LXRqzDywKR
	l7gJkisont+nT3xQmOSp4wmb2NHX2wbhBMiXLN09LX5j0H6mRvS0+nbNpW++fNX4ls9is0r9VSv
	tWL3S6ocdoWy5KWJ+7BEdo9ZRm2ztdT4oLeE7wqvPOGNdeFqx/jn23krXrz2Q+T8=
X-Gm-Gg: ASbGncvjFAghxT9Ozqc7MkNYw1pGvGzWJjrSMKlB+YfOL6WUEtviTHd12hdkLH3Do6w
	wWXOjgT6ScEUkERWUk6rGhycAurDSYnCYVqw4cOK0raXhLxpJBVID/t5pcIVxpmUPdb87zdD1MQ
	idb6S/hPtaUiUk3yQfksVNzsVxsNYjJWT+YttRYOPwc6B6cVgzUuJVQzllxUilOMk8nkjWqOFYl
	FV7gZXWS0d1M1pM6H52u6aM72G/+g+YiX/AZSpraEiQ9KaTqO2CrgNSMq6UAzb+JTmFlu/5Jj9J
	Eo0KB0p9r2046ZnNqNMyqFgOFN6coIuk39Qjz3vBJTY9JwHC/cTkF5A=
X-Received: by 2002:a05:6512:b94:b0:549:38d5:8853 with SMTP id 2adb3069b0e04-54ad64806c4mr6070393e87.17.1742901515455;
        Tue, 25 Mar 2025 04:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjtqbIwHYGNHuo5x5tBm7yBI388Ux/gW6yDNSQ2502EOTzLexuBiPH1BhQoZiGL60kI8j0fw==
X-Received: by 2002:a05:6512:b94:b0:549:38d5:8853 with SMTP id 2adb3069b0e04-54ad64806c4mr6070378e87.17.1742901514964;
        Tue, 25 Mar 2025 04:18:34 -0700 (PDT)
Received: from [192.168.68.107] (c-85-226-167-233.bbcust.telenor.se. [85.226.167.233])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54af7116e55sm144919e87.159.2025.03.25.04.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:18:33 -0700 (PDT)
Message-ID: <1b196080679851d7731c0f4662d07640d483be4e.camel@redhat.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
From: Alexander Larsson <alexl@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>,
 Colin Walters <walters@redhat.com>
Date: Tue, 25 Mar 2025 12:18:32 +0100
In-Reply-To: <CAJfpegs1hKDGne7c3q4zs+O5Z4p=X3PK8yFXhyCY2iAjs4orig@mail.gmail.com>
References: <20250210194512.417339-1-mszeredi@redhat.com>
	 <20250210194512.417339-3-mszeredi@redhat.com>
	 <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
	 <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
	 <CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
	 <CAJfpegs1hKDGne7c3q4zs+O5Z4p=X3PK8yFXhyCY2iAjs4orig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-25 at 11:57 +0100, Miklos Szeredi wrote:
> On Tue, 11 Feb 2025 at 13:01, Amir Goldstein <amir73il@gmail.com>
> wrote:
> > Looking closer at ovl_maybe_validate_verity(), it's actually
> > worse - if you create an upper without metacopy above
> > a lower with metacopy, ovl_validate_verity() will only check
> > the metacopy xattr on metapath, which is the uppermost
> > and find no md5digest, so create an upper above a metacopy
> > lower is a way to avert verity check.
> >=20
> > So I think lookup code needs to disallow finding metacopy
> > in middle layer and need to enforce that also when upper is found
> > via index.
>=20
> So I think the next patch does this: only allow following a metacopy
> redirect from lower to data.
>=20
> It's confusing to call this metacopy, as no copy is performed.=C2=A0 We
> could call it data-redirect.=C2=A0 Mixing data-redirect with real meta-
> copy
> is of dubious value, and we might be better to disable it even in the
> privileged scenario.
>=20
> Giuseppe, Alexander, AFAICS the composefs use case employs
> data-redirect only and not metacopy, right?

The most common usecase is to get a read-only image, say for
/usr.=C2=A0However, sometimes (for example with containers) we have a
writable upper layer too. I'm not sure how important metacopy is for
that though, it is more commonly used to avoid duplicating things
between e.g. the container image layers. Giuseppe?

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's an impetuous guerilla werewolf fleeing from a secret government=20
programme. She's an elegant insomniac socialite with a flame-thrower.=20
They fight crime!=20


