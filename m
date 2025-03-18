Return-Path: <linux-fsdevel+bounces-44334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C358A67860
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 16:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7602F7AB468
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 15:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD48C20FAA8;
	Tue, 18 Mar 2025 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9gwtEEl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D720F07A;
	Tue, 18 Mar 2025 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313108; cv=none; b=BSlBiI4V+iPI7wUkqXhk69nEzgyS4CrOfZ2XZSXx8UvblUuyZJYDQ5vUU8JHzDeJFEGhN6Ev8ACQkeHjVvsE1JhImaKvf1O8b8Wc/k+ZIgL1gixJ1EUtnsOAwFNQfM+raZdae4R9uNZ8wwLSApzAdeuzVkUCyXFHpA3j+TtsBrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313108; c=relaxed/simple;
	bh=3IUzgW0tqmvBtDPQEnXyodqPaV1/XSemXMh7OodnVNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaNHPceErXBV/EoLshhVZHBXOYMzqRYreQ7iTNe4B77Arw93gLfe8QXsiWogSJ0nzFgTcaOGectoJVlgdXKt6P7Jji+7Lu3gIr//RwAWK4Dma31+HNw+V/HxO3CnQsbYR3BXOxyw3cKGP/amx8auqkHPVZFF+QtuSX6RxPTh/r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9gwtEEl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso219275766b.0;
        Tue, 18 Mar 2025 08:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742313100; x=1742917900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQsfpXrf/4c4YQpb8eNn6gMWmckTaNQ66mxt9z5Ef4E=;
        b=E9gwtEElyso6PZ/HIK0pKB6sfZISNou8ITo7h5uRZZh64tHLnJvXJe4JGYG4J/fWvo
         zB7pfudsVDW5FqrEhXDZu9Qzw0j81MbpV9FQs/SNC1gM15vmoOSm3a9Yos+JnG5z5Ok1
         yesHNPVv90+2QK7HhmGOPAw0YyCr0RPGprz46iHQf6oTa9p2Qbco4W+vASKDSoPEbxLH
         7oHvxQAOD7N9aqdO9+zGsiY7neR3Zrembw1DsA1/nNinKJw2RFjAMk2arpOXyPEZ822b
         9dxDqY7uDKEGPg0eCVxp6JGMC8e7wvdr51CfxDABKS/f1dMlfJAB4VLRImGVyxgLBqe/
         8Lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742313100; x=1742917900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQsfpXrf/4c4YQpb8eNn6gMWmckTaNQ66mxt9z5Ef4E=;
        b=cNrS5qfTrJcrshGgH32pvJm/3rukLYe6VItRVK+FIztLgHiLE6gXHeP1QPkcz8QPNf
         YbUDZ6HLRYJmp4iddcO6oatfTmU2wH/tXOnWGpkwxdDouL2lwEGAcSLj1gUMJ1EnbVU7
         LSZ9/SbJjSTaiM2mTjOVf8YdBr7M0r4flMCXkAnbu+XFNfXeugeR1VGfFIhXRJl2xUEr
         z0xDTYMTiEqXq/HZ8tFb70N91fSVWKzigzydhwlU199qmZIwmH9yfb1fuCHGKOMpy1iq
         Y3Q17BowXT4DfbNtoYnWT7jAcJbh/28/6T0i1fWVMBlIXAwLRjxYdRSz6WeWOTTDkBl+
         ZZJg==
X-Forwarded-Encrypted: i=1; AJvYcCUqLPxM8bT72/nVjV/6S9UVz+Rx5WHTdWhokpgz6HJdkxMeCvr5kxAyUoj0gywQja3arKsode7irfo3Qvq1@vger.kernel.org, AJvYcCXNizgZymjGEdomWbL7WzKNMzLZ+Nr5MZv7GqO7poEfuDq9Pi3ClGA6N0pyvSZn7FdVITiPscNCdtRYt9UQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6EHeD2L3RnKBJuA+LHZ9WN1qW6TdNTAbKjopkZRbcFHtye5Vz
	5aGduC4NoLOZZW+MXk86nnw/ut8BiLxlfnBYw0V79g7OiV43Y93n2IhsjdKCQyKzqd6ilPCebQt
	soCdobsNoR52KAh861l5gOcO5Lyw=
X-Gm-Gg: ASbGncump5gXjfyl74pisdrZiVrFUSg5fIpCuk7/nV246/emK8mKmcsp29p21Joe5+7
	0/ef9BX0/LQTs2nm+4lR5WsNmwZsa+n1tL5ym/atXOmf6qVF11kVjC9sj1Zbxvo+P6WCLLa2tJQ
	TkxbSfunopd6Lt7LlXc0hMNx0dVg==
X-Google-Smtp-Source: AGHT+IFjG8edwwuf2mEVeTcyHLZb3BYe7dhVljkptYUqPN1fOMiWWxKawFj8Wyt+UhG++lSQFRDFKNY1P6+HUcVXn7o=
X-Received: by 2002:a17:907:d92:b0:ac1:da09:5d32 with SMTP id
 a640c23a62f3a-ac3301d979bmr1912910866b.6.1742313099481; Tue, 18 Mar 2025
 08:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-4-hch@lst.de>
 <ptwb6urnzbov545jsndxa4d324ezvor5vutbcev64dwauibwaj@kammuj4pbi45>
In-Reply-To: <ptwb6urnzbov545jsndxa4d324ezvor5vutbcev64dwauibwaj@kammuj4pbi45>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 18 Mar 2025 16:51:27 +0100
X-Gm-Features: AQ5f1JoIV3Ekgoa3AyaPQZviu6xh4y3D7_TilsaK7QfN_pG3EjUXa6A87nuBb0M
Message-ID: <CAGudoHEW=MmNLQSnvZ3MJy0KAnGuKKNGevOccd2LdiuUWcb0Yg@mail.gmail.com>
Subject: Re: [PATCH 3/8] lockref: use bool for false/true returns
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 4:25=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Wed, Jan 15, 2025 at 10:46:39AM +0100, Christoph Hellwig wrote:
> > Replace int used as bool with the actual bool type for return values th=
at
> > can only be true or false.
> >
> [snip]
>
> > -int lockref_get_not_zero(struct lockref *lockref)
> > +bool lockref_get_not_zero(struct lockref *lockref)
> >  {
> > -     int retval;
> > +     bool retval =3D false;
> >
> >       CMPXCHG_LOOP(
> >               new.count++;
> >               if (old.count <=3D 0)
> > -                     return 0;
> > +                     return false;
> >       ,
> > -             return 1;
> > +             return true;
> >       );
> >
> >       spin_lock(&lockref->lock);
> > -     retval =3D 0;
> >       if (lockref->count > 0) {
> >               lockref->count++;
> > -             retval =3D 1;
> > +             retval =3D true;
> >       }
> >       spin_unlock(&lockref->lock);
> >       return retval;
>
> While this looks perfectly sane, it worsens codegen around the atomic
> on x86-64 at least with gcc 13.3.0. It bisected to this commit and
> confirmed top of next-20250318 with this reverted undoes it.
>
> The expected state looks like this:
>        f0 48 0f b1 13          lock cmpxchg %rdx,(%rbx)
>        75 0e                   jne    ffffffff81b33626 <lockref_get_not_d=
ead+0x46>
>
> However, with the above patch I see:
>        f0 48 0f b1 13          lock cmpxchg %rdx,(%rbx)
>        40 0f 94 c5             sete   %bpl
>        40 84 ed                test   %bpl,%bpl
>        74 09                   je     ffffffff81b33636 <lockref_get_not_d=
ead+0x46>
>
> This is not the end of the world, but also really does not need to be
> there.
>
> Given that the patch is merely a cosmetic change, I would suggest I gets
> dropped.

fwiw I confirmed clang does *not* have the problem, I don't know about gcc =
14.

Maybe I'll get around to testing it, but first I'm gonna need to carve
out the custom asm into a standalone testcase.

Regardless, 13 suffering the problem is imo a good enough reason to
whack the change.

--=20
Mateusz Guzik <mjguzik gmail.com>

