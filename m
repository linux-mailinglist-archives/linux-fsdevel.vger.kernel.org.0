Return-Path: <linux-fsdevel+bounces-45194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCCBA74777
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 11:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8383B80BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 10:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984EE2192FC;
	Fri, 28 Mar 2025 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhKY5FsA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F696215179
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156528; cv=none; b=mVOxJ9rxTSgCpZdZaJ5j+nczZg2SaLLlCjMVlyFcXyc2Kv2Tvc5ACS/79kpWbXk2SkCdLr9Y+2q6HwrZKJCiQCNtlF18E5s99fnUY6BxhH4Bg2BqQwUl8cCVxZWi+2bACf9Zz3E47chfl3sk3yTRuu9aivQlzlVV3FAOGYsVIxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156528; c=relaxed/simple;
	bh=GY6LNEGp5wD1whntDXHz9uvTBUdWJ/TtAWYJRXfABv8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F/omPj3fAGYZCjwvns1Iuu1My2SlxzYkPD5szMqdPaWmAzdq9d8P7a+j487o6YyxYTd41IjBsSoDIOKa/YRS89Enoap4VaGVhLuWvo63zzsG/1MPLmTR88yKNIRHZ5zbCAhKcsFMfb+k1XkcSMoTUSn5c7klY6hjHLu1E0WNCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhKY5FsA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743156525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uexjHPHaHB6AaQa6ptS/Rgs1NBKyZtH2mQH7ip8uNcs=;
	b=BhKY5FsADjsnmFYZ/bsCEj0jg9aH3A/bqwW3Z+bq3ApV2An9sVVdAE7oORA9rwu8CULl72
	XGCJjHK7x8zsL+rRbOfHWgTygsFcSmMtQWaazR0oe/EoL3nWINDgarpD2U/Y71ZaWIEAly
	rvJWEQfGY94TdcLbcHbvqY0hwyW6I3Y=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-uiMaag8gMPe5qo0MHnCTMw-1; Fri, 28 Mar 2025 06:08:38 -0400
X-MC-Unique: uiMaag8gMPe5qo0MHnCTMw-1
X-Mimecast-MFC-AGG-ID: uiMaag8gMPe5qo0MHnCTMw_1743156517
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30bf67adf33so16410461fa.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 03:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743156517; x=1743761317;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uexjHPHaHB6AaQa6ptS/Rgs1NBKyZtH2mQH7ip8uNcs=;
        b=WON6sHa2OI2HN5M3OaMGic6lns0MCKL61C33UJD2tnJeHToJXrmDYmkrk+yNGiS2Uc
         VlGoA3LXd3FSFU9GruUYUKC/WKS1lWzhpsVrCxpeo1EFaH5HbCvWkk74FFoa0FUVIDwK
         A/GPpi+/EAC+8RgZMs3P4cXQpjPxFHto39If4KqfZVGR0lYsaLCTrxI56jh7GMPT3g1Q
         8R3lmP9+R19LyMu1EYxrbkavVSe4pOQn689vZi29SYONPKe22D5/z0GUK6IV/rLo+BON
         MgMYinm3EliCA19FZolbtuuVJMmW6XgzxECtNNJhnvSBrJa6PewGtl+EAqO2i94QyKm3
         wt5w==
X-Forwarded-Encrypted: i=1; AJvYcCUE02oAkcx7dL8n5Ce2eeDA5K7LGZyaQ/Fo7Sxw986BtWLvQJ0IqrBWZ2+HioDRxU+Reb7i31Cf4l0+eL+5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzll4qJSOojNV77T2rPYWmnfFJeU4X+s8dTKRLFLtf5L8E0BDGh
	m2pr9UHo8dty3VdmHLssROL/6/9YwgM63hYltuX8ysygcf/A7ENPMW0tCI16Ul58o79SHTXNAFS
	9rSFOAJFughw6XK69xOenTE6VQJFjNLVWkS0VA6igmfKX5nJrRw8gTHgo+08/5c0=
X-Gm-Gg: ASbGnctKlAtYPrIW+B9J4UVLsi7M7Jq3wCKj3hE4aqtG2tnUMEVQd964Dh9bHK63eGx
	061NOGhoSYGB9b0UHvHXlDRK6aWHe0+jkBXmG9oSqua37suwmRRn7NhNzN1e+QRP05mFkQ8FPpH
	ZevMeLbqsaXV36OO+KqRPjioPfxTm1rZ273H0h0gXbldaP+8631PgEtTrtq28dpiANVsrZoDo+G
	r3GiLFrhcC5pv3P+0IzT2/aBXlquyIcT6MRjzDGipXnKITflZ/MUncM6euBfpwD3KRCbFPuTBBi
	6Dr4FOyJa+rgFRJueFAJjTO03M26N8FokcIdm4MYW49fHQFJkNDglsU=
X-Received: by 2002:a2e:be27:0:b0:30d:c4c3:eafa with SMTP id 38308e7fff4ca-30dd439309fmr7972511fa.7.1743156517027;
        Fri, 28 Mar 2025 03:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKN7MpSkYfaqsK+bopt1EUqDawYJWOWT1t2Mj7wA9dhUaXFx/N4035wBULqQpXCsHogYYIjw==
X-Received: by 2002:a2e:be27:0:b0:30d:c4c3:eafa with SMTP id 38308e7fff4ca-30dd439309fmr7972351fa.7.1743156516610;
        Fri, 28 Mar 2025 03:08:36 -0700 (PDT)
Received: from [192.168.68.107] (c-85-226-167-233.bbcust.telenor.se. [85.226.167.233])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2acf881sm3054901fa.51.2025.03.28.03.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 03:08:36 -0700 (PDT)
Message-ID: <3b87c2ef6b50c40dae62dbd062ca542308767cb1.camel@redhat.com>
Subject: Re: [PATCH v2 5/5] ovl: don't require "metacopy=on" for "verity"
From: Alexander Larsson <alexl@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Date: Fri, 28 Mar 2025 11:08:33 +0100
In-Reply-To: <CAJfpegvvRBgYHpuOUuunurwN0Nad+OUdjNOdLw6d1C0kEAg5PQ@mail.gmail.com>
References: <20250325104634.162496-1-mszeredi@redhat.com>
	 <20250325104634.162496-6-mszeredi@redhat.com>
	 <CAOQ4uxgif5FZNqp7NtP+4EqRW1W0xp+zXPFj=DDG3ztxCswv_Q@mail.gmail.com>
	 <CAJfpegvvRBgYHpuOUuunurwN0Nad+OUdjNOdLw6d1C0kEAg5PQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-03-26 at 11:24 +0100, Miklos Szeredi wrote:
> On Tue, 25 Mar 2025 at 12:35, Amir Goldstein <amir73il@gmail.com>
> wrote:
>=20
> > > --- a/fs/overlayfs/params.c
> > > +++ b/fs/overlayfs/params.c
> > > @@ -846,8 +846,8 @@ int ovl_fs_params_verify(const struct
> > > ovl_fs_context *ctx,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 config->uuid =3D OVL_UUID_NULL;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Resolve verity -> metacopy d=
ependency */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (config->verity_mode && !con=
fig->metacopy) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Resolve verity -> metacopy d=
ependency (unless used
> > > with userxattr) */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (config->verity_mode && !con=
fig->metacopy && !config-
> > > >userxattr) {
> >=20
> > This is very un-intuitive to me.
> >=20
> > Why do we need to keep the dependency verity -> metacopy with
> > trusted xattrs?
>=20
> Yeah, now it's clear that metacopy has little to do with the data
> redirect feature that verity was added for.
>=20
> I don't really understand the copy-up logic around verity=3Drequire,
> though.=C2=A0 Why does that not return EIO like open?

If a lowerdir file doesn't have fsverity enabled, there is no struct
fsverity_info, so no digest available to use. This means we cannot make
a verity-enforced redirect to it.=C2=A0

This is not an VERITY_REQUIRE failure, those are when we find a
redirect with a missing digest xattr, but in this case the lower file
is a real data file, not a redirect.

Note: This actually happens in composefs. We don't use redirect for
tiny files (smaller than the redirect xattrs would be), instead we
embed them directly in the EROFS image.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a lonely Jewish vampire hunter on a search for his missing sister.
She's a man-hating Buddhist socialite trying to make a difference in a=20
man's world. They fight crime!=20


