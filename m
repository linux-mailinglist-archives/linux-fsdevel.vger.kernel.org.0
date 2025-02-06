Return-Path: <linux-fsdevel+bounces-41120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D371AA2B371
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 21:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E7E1887194
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 20:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738CD1D7E4F;
	Thu,  6 Feb 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbPhZA9b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F992155757;
	Thu,  6 Feb 2025 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738874058; cv=none; b=uCveIvw/WQgsqpT6E9l2SCgSNMWWkxj9SbOvgaGNofF5yks+BSpkpZSy91KHpBc87gZ9Fo1/kRsSZleqEsAVWDw9qtTYYCwM2TAf21/e3px0+cE01dsKEd+qXnaVN3osbf+WjyD1s26Lk3Y2BM8QCEoWt7MCI5kKHBmhDV87d7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738874058; c=relaxed/simple;
	bh=oqiFVOKTgLGK5IlWs+5QuSuiN1dRojbtmAdK2ulzLig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMcYC/QMexQG7MOV+k3kIWg3uTwoGGMzXAVJ1PSZJDXONRIboAMkgRUq17VnzW4HKZYivoB5kqPmMT7/HJsqIEWDHSThpv0D1furQjQybSQ3n2OKmTwtkwqK2Q4zSyTVf3tNX6+hu+SkIuolkoiVFWDmjwZxpxqCCEeftil/Lpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbPhZA9b; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dc75f98188so2538196a12.2;
        Thu, 06 Feb 2025 12:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738874054; x=1739478854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryjLasjPJHbQOeRTAhgEOuh33Ov07HZLps/T4GjAVqY=;
        b=EbPhZA9bUeWGlsifUxVLxQV50wYP5ldlHaPC3hzBdftuJrzQ57DIw/1Aalcn9opQWi
         dmPG3KpAKnBzqUi++Lsr5XSlG94SuNapMUUVr0OQi2QmVPnW62q3iXeIGqnuSvbPOrNK
         jPNdvIUhphPNGlGe2atZOAHhl1gaIrB0omaFfG3mNGVeLXRm+JTYXybNHwaYnPXCQc/e
         esMKEreDY6E+mwcynch32f9qjxO9jt3Z8iQRnTrzdGNhvflen7zPNjeigr0dEcHriVn3
         f3XeN1RyElKrAyAm39SaLnueCGvG/Xa/vBZS2iNwWNQ5rpmRS58n0pRFJKVkMfSRtUuY
         ydXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738874054; x=1739478854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryjLasjPJHbQOeRTAhgEOuh33Ov07HZLps/T4GjAVqY=;
        b=WKE7B/WJyEaUP8p5BO9Uqicyok61bRE/U21ttQcSzlq1uV2eNRHOlvC+xKFI4kzLWn
         EqfcgloZPz8Wd3akeYULFh4WvyJ3XKmHSJy9JpERTfBZFaIv4YDHPmWIAQ/bCnv0lq3B
         cwWvhX3Fux+6dGklgHK83X3ZwVzKido7ZmadiAMAtflyeh5pLuv39YaDkTd/P+4DKRsr
         KB24rBN6Tj+BRd0Lo+KapgDH6+yWDMNYBXg61aBr4mrc8e800sMXOg2/mmCcNXnRELqK
         My6sCRvMUekVpvNvq4RYHdoJD8DnPfKdBGzB9b7NTJj++BNWu9lllIZin1nDCHmGql1o
         ynyw==
X-Forwarded-Encrypted: i=1; AJvYcCU9GUyW5o3qqFBp3wUcF61ZMCG8Fbz5lrVk1GW0BESQ2WWc182mkPpGgj3r+Wf8QRfEXx/aDwrPQxcLkU9c@vger.kernel.org, AJvYcCVDaY9y0fYvnuDD6lZGLGmrvj14/gKZENfTAO88+9jWD3kPuXhc5Bu34pq0CBiqqFXgmIpTRF3ATxuh9gCPrw==@vger.kernel.org, AJvYcCWyHSajS3/SJPDwxJmqvVXm2mANs8bykl5Kfx7mMPpSsMKXhUSV5+9kl/LdCSRjodoyGwIFOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIYIryfy0Ao2WxthaI/9m2Jou0GlJ4gqu9L1LLTrEYUSJMVi9b
	OsT8UvHQOcpN51Rbg9Pyw98/aKhRrMmA7/ZAk8hDyBXHsaI5vDzmupOLdTZk1uBNJ/wiG4NOQ2k
	c7wI31NPV6DCI/gGWj3tznngzaqPZWx1RjUA=
X-Gm-Gg: ASbGncsdoZ1lz0e7Zaqm1kXYm6S4Oqaqvypbtaqp0Wpxln80SlCIbuV6AwOn0Tavo7t
	B9tBV7xIMYYBxUvw1he8SOsBjZLVT6YrDtE6a6NagOovIjc7FX/cIAm0sn5ImNSYPhSmAw8iC
X-Google-Smtp-Source: AGHT+IGcLW2fGHCuS9KbvLrh0K0P84zzIEhsF/mLbQXzTwGdCOvMq9+eAxhSuSmuKugNubTuElD1rSAsnIm8JabxSUo=
X-Received: by 2002:a05:6402:51cf:b0:5dc:57a5:c414 with SMTP id
 4fb4d7f45d1cf-5de45088202mr808221a12.30.1738874054214; Thu, 06 Feb 2025
 12:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHFLnmp3tQHOwUAFBKxrno=ejxHmJXta=sTxVMtN9L1T9w@mail.gmail.com>
 <956b43574bcb149579ecac7a3ab98ad29dddc275.camel@kernel.org>
In-Reply-To: <956b43574bcb149579ecac7a3ab98ad29dddc275.camel@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 6 Feb 2025 21:34:02 +0100
X-Gm-Features: AWEUYZlNUdZw7sUCztW2JxsHnXY0Yl-f4pykpOS6BOMBOYK7tE-HfpiSpucXiUQ
Message-ID: <CAGudoHGqYKTM979s13SAP7fukeAd4NHGTMsxnRWN7A5BpYaCzw@mail.gmail.com>
Subject: Re: audit_reusename in getname_flags
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	audit@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 9:24=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Thu, 2025-02-06 at 20:07 +0100, Mateusz Guzik wrote:
> > You added it in:
> > commit 7ac86265dc8f665cc49d6e60a125e608cd2fca14
> > Author: Jeff Layton <jlayton@kernel.org>
> > Date:   Wed Oct 10 15:25:28 2012 -0400
> >
> >     audit: allow audit code to satisfy getname requests from its names_=
list
> >
> > Do I read correctly this has no user-visible impact, but merely tries
> > to shave off some memory usage in case of duplicated user bufs?
> >
> > This is partially getting in the way of whacking atomics for filename
> > ref management (but can be worked around).
> >
> > AFAIU this change is not all *that* beneficial in its own right, so
> > should not be a big deal to whack it regardless of what happens with
> > refs? Note it would also remove some branches in the common case as
> > normally audit either has dummy context or there is no match anyway.
>
>
> (cc'ing audit folks and mailing list)
>
> IIRC, having duplicate audit_names records can cause audit to emit
> extra name records in this loop in audit_log_exit():
>
>         list_for_each_entry(n, &context->names_list, list) {
>                 if (n->hidden)
>                         continue;
>                 audit_log_name(context, n, NULL, i++, &call_panic);
>         }
>
>
> ...which is something you probably want to avoid.

Well in this case I would argue the current code is buggy, unless I'm
misunderstanding something.

audit_log_name in particular logs:
  1550 =E2=94=82       if (n->ino !=3D AUDIT_INO_UNSET)
  1551 =E2=94=82               audit_log_format(ab, " inode=3D%lu dev=3D%02=
x:%02x
mode=3D%#ho ouid=3D%u ogid=3D%u rdev=3D%02x
  1552 =E2=94=82                                n->ino,
  1553 =E2=94=82                                MAJOR(n->dev),
  1554 =E2=94=82                                MINOR(n->dev),
  1555 =E2=94=82                                n->mode,
  1556 =E2=94=82                                from_kuid(&init_user_ns, n-=
>uid),
  1557 =E2=94=82                                from_kgid(&init_user_ns, n-=
>gid),
  1558 =E2=94=82                                MAJOR(n->rdev),
  1559 =E2=94=82                                MINOR(n->rdev));

As in it grabs the properties of the found inode.

Suppose the 2 lookups of the same path name found 2 different inodes
as someone was mucking with the filesystem at the same time.

Then this is going to *fail* to record the next inode.

So if any dedup is necessary, it should be done by audit when logging imo.

--=20
Mateusz Guzik <mjguzik gmail.com>

