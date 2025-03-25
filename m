Return-Path: <linux-fsdevel+bounces-45025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA313A7037E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 15:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E52188B342
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4957D259CAC;
	Tue, 25 Mar 2025 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WR+5bgVO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DB8258CE3
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912219; cv=none; b=Ue4kLGFVKpxd/2CoBHTjCmYl5Usc1qOkuX4NtcCJ3fxxE0DJV5HW8ulEv7uGWlz7OLE73iMfsKK6B9UPoBSV7tujYQd/yYUXK44dbAXgMno4JB4A+d+BXodnUjHQFOiK2EkfDNwAyfXrTWIY57on+pDMkCN6Y0d//wGX7afjbfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912219; c=relaxed/simple;
	bh=Y5eE1rIMEADnDQWK0y2r97UiN/bXBQSPKYsKFOz3XfA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ANWff2WBsYlmOVYEYs01QOCUEdPuwgXUOURLuasfVLPsXWFcWV5ZRQmstfHx6MV0GjJcU7k00vzAtAwzrr79wnqxkyZkU2EKjlU/KiO3iKvm2CLY6CrH4kcl5B/msK3AkR4yX7Zj2k8cVSTCutmAt+mRjAUM1dCxpMrnZr7/OII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WR+5bgVO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742912217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45/I6IxC6x0pnYJDPbVx9XCfEi+sVbejqMmT9HH/Vi0=;
	b=WR+5bgVOHyVbPZOEDd4ix4SWO9UMH0StTepLqxRqycVaYeWLJgLzdojERRLIu1UxF2Qud8
	d8qIASVkYie+d8+77EeB8OAKiFbT7RAD9wphSDVQuPasSF38eBJaBrDJ8ORTpK625pucQd
	OC+hQuaeJi8euydksyXFEqqHEgREc1k=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-a_J8Sx2HO4eBgFZYEEbLPw-1; Tue, 25 Mar 2025 10:16:54 -0400
X-MC-Unique: a_J8Sx2HO4eBgFZYEEbLPw-1
X-Mimecast-MFC-AGG-ID: a_J8Sx2HO4eBgFZYEEbLPw_1742912213
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-30bfd1faeeaso26434101fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 07:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742912213; x=1743517013;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=45/I6IxC6x0pnYJDPbVx9XCfEi+sVbejqMmT9HH/Vi0=;
        b=AozK992afYxx5xN+pCnmass6VuJONTbWh7TbsaSeA4J7NrScfEWiGxoPKU4CpmvWff
         amVR/57L7s6+XZGAQbKOzPFLcXWbcOOggvs/vJOC8FVRnmQrPa+ZNgfemWQZcL5K6BHd
         F8p5XB68i1JqEQSsqLsZHqaRCfzfN7BafxMBE88x/tCadWDErM9Pg6//hxhL5ZJ37Vc+
         jyA7kSzfwpCiXx9Ebfuv94LJrKiLKtJ+03mT5uXirdoxgDmChB/GUcuEPJJZDn5wWdAi
         czzGpXJbK0kQijLw9NMfV1jtgzVhG/MBOfXKOe+ZwFhby+GJkiFfmPtPC2gLvPWqlKPq
         TwDA==
X-Forwarded-Encrypted: i=1; AJvYcCX6nYKPVNHUPw7W163DtdznHaAuzBa7vXiSJy0km19VlNrEpo9pj6HQVLmx+/ND10nZLGjBiM4DJ8veqcu8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1267Mu5LXjLGi70QLNy3LR7AmiD0H5uYj68V8UcwlJa9FMT/N
	wwz1s6rNoDaQu8XsandAIiqLL5wjJoGdCSv9l40DqFARPTnSJNmVXijB1NopWRn3yD3NvkjJ3i1
	+1HZ2J1GhDbMMbI2q+pW1tyB/srhpuFbYlAkVkpzQIH2fQG1kdHT+lLXsdtBa2jE=
X-Gm-Gg: ASbGncvK0P7Ke7c0yyhXWoHEwy54YrxPsR+O1UQyO5LX8LFMwjbVCMg/xVWi38+ORmM
	59WsnsdWzFJACFHDAS/3SQH9yxEj/VmZoMu2g7b/Eh0SdN7ms/OwMSwMkN3nkEN8Q0qkdJHhH0i
	y1E8mlSrM6WLHWJeJLw5goWnd2GpExlzRLVwYFI/iYI3nGuaAeLkC3jhDoQTa6s+srjHVQAXO8H
	Iiwqog/edZhWnw82O1HYQTchjc5uHOwFFf0vZ5SF6jY2OSUooG0ku1uNZZMPDsdkhJRO3s3VJPX
	lEvGWQQRCtWXGhhZFfn0SFgW1QHvR/jxlXMp894dnQmRzGM0l1I4Q2g=
X-Received: by 2002:a05:6512:1255:b0:549:4ab7:7221 with SMTP id 2adb3069b0e04-54ad650bab5mr6157720e87.50.1742912212870;
        Tue, 25 Mar 2025 07:16:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbd1oJg5Hf2XSgCFH72HX2QAdZGMVBPBMNE5aNqWKSeQBEeP18y+tSN1jDYNb2/KVvmKgi4g==
X-Received: by 2002:a05:6512:1255:b0:549:4ab7:7221 with SMTP id 2adb3069b0e04-54ad650bab5mr6157699e87.50.1742912212309;
        Tue, 25 Mar 2025 07:16:52 -0700 (PDT)
Received: from [192.168.68.107] (c-85-226-167-233.bbcust.telenor.se. [85.226.167.233])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7e062dsm18980611fa.30.2025.03.25.07.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:16:51 -0700 (PDT)
Message-ID: <74c0a4e4c19b4d86f6533a9f5e2ad3992254a0c3.camel@redhat.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
From: Alexander Larsson <alexl@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Giuseppe Scrivano
 <gscrivan@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi
 <mszeredi@redhat.com>, 	linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Colin Walters	 <walters@redhat.com>
Date: Tue, 25 Mar 2025 15:16:51 +0100
In-Reply-To: <CAJfpegtvPW6tTfGbOUtW3GMe8UxX2Laqjopb1oSoUNgBWNUe9g@mail.gmail.com>
References: <20250210194512.417339-1-mszeredi@redhat.com>
	 <20250210194512.417339-3-mszeredi@redhat.com>
	 <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
	 <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
	 <CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
	 <CAJfpegs1hKDGne7c3q4zs+O5Z4p=X3PK8yFXhyCY2iAjs4orig@mail.gmail.com>
	 <1b196080679851d7731c0f4662d07640d483be4e.camel@redhat.com>
	 <87frj1fd3b.fsf@redhat.com>
	 <CAJfpegtvPW6tTfGbOUtW3GMe8UxX2Laqjopb1oSoUNgBWNUe9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-25 at 14:42 +0100, Miklos Szeredi wrote:
> On Tue, 25 Mar 2025 at 14:34, Giuseppe Scrivano <gscrivan@redhat.com>
> wrote:
> >=20
> > Alexander Larsson <alexl@redhat.com> writes:
> >=20
> > > On Tue, 2025-03-25 at 11:57 +0100, Miklos Szeredi wrote:
> > > > On Tue, 11 Feb 2025 at 13:01, Amir Goldstein
> > > > <amir73il@gmail.com>
> > > > wrote:
> > > > > Looking closer at ovl_maybe_validate_verity(), it's actually
> > > > > worse - if you create an upper without metacopy above
> > > > > a lower with metacopy, ovl_validate_verity() will only check
> > > > > the metacopy xattr on metapath, which is the uppermost
> > > > > and find no md5digest, so create an upper above a metacopy
> > > > > lower is a way to avert verity check.
> > > > >=20
> > > > > So I think lookup code needs to disallow finding metacopy
> > > > > in middle layer and need to enforce that also when upper is
> > > > > found
> > > > > via index.
> > > >=20
> > > > So I think the next patch does this: only allow following a
> > > > metacopy
> > > > redirect from lower to data.
> > > >=20
> > > > It's confusing to call this metacopy, as no copy is performed.=C2=
=A0
> > > > We
> > > > could call it data-redirect.=C2=A0 Mixing data-redirect with real
> > > > meta-
> > > > copy
> > > > is of dubious value, and we might be better to disable it even
> > > > in the
> > > > privileged scenario.
> > > >=20
> > > > Giuseppe, Alexander, AFAICS the composefs use case employs
> > > > data-redirect only and not metacopy, right?
> > >=20
> > > The most common usecase is to get a read-only image, say for
> > > /usr. However, sometimes (for example with containers) we have a
> > > writable upper layer too. I'm not sure how important metacopy is
> > > for
> > > that though, it is more commonly used to avoid duplicating things
> > > between e.g. the container image layers. Giuseppe?
> >=20
> > for the composefs use case we don't need metacopy, but if it is
> > possible
> > it would be nice to have metacopy since idmapped mounts do not work
> > yet
> > in a user namespace.=C2=A0 So each time we run a container in a
> > different
> > mapping we need a fully copy of the image which would be faster
> > with
> > metacopy.
>=20
> Okay, so there is a usecase for compose + metacopy.
>=20
> Problem seems to be that this negatively affects the security of the
> setup, because the digest is now stored on the unverified upper
> layer.
> Am I misunderstanding this?

Can you explain the exact security model here. The end user should not
be able to arbitrary change the redirect xattr to bypass permission
checks in the lower via the overlayfs mount directly. So, is the worry
that the upper dir is stored somewhere accessible to the end-user for
direct modification? Is there also a worry that you can write directly
to the lower layers?

Anyway, In the example above couldn't podman just create the metacopyup
layer manually and then pass it as a regular lower dir, then we don't
need metacopy in the upper?

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a shy ninja sorceror on the hunt for the last specimen of a great=20
and near-mythical creature. She's a plucky cat-loving magician's=20
assistant operating on the wrong side of the law. They fight crime!=20


