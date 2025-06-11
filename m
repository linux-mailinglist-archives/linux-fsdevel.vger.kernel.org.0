Return-Path: <linux-fsdevel+bounces-51327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CBBAD5868
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 16:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0776D1BC4C11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 14:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EA929B213;
	Wed, 11 Jun 2025 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfSHsSaz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FDF28C855;
	Wed, 11 Jun 2025 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651494; cv=none; b=CpX4cuS1btVwYk7xhQrXqP0662AuZiiu/q6Y2XmmSs2fPjLGrnqMohwjW7K4a2tl3fkqj1CfTjYmzI4UuK37jCv6lcXFSkThP2YOXIyXctC+h+QGOJc7W22WqtpMz9Qp7C6n5lvh2UAUAkqFJ6guQtWWfHHUrpoYnjh3M4uU4wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651494; c=relaxed/simple;
	bh=lQ5H38hc2yWWodWSuje7NKKY2ujQtmIDJ1T3piilQ3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3Z1MGHdDGUQDpy9Ah4tJdi819c+5HUD6P8GbaBBVSF2nsv33eT8m79g0folw3s6Tqz7kwPVKsGKzyx9KMCOhhz1rFUJpYBy5ccjSBxViyMcugv9VWHt3uff5QUobtbpOt5K6Z4/U0QTGQC0nV1Sejg97gpX2EsuQd7hht32jXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfSHsSaz; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32addf54a00so48052601fa.1;
        Wed, 11 Jun 2025 07:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749651491; x=1750256291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JHyDDVL96PT69+HIUFTlQwzyTVvaxPDQBDHlKvb0lw=;
        b=cfSHsSaziohxAORUBJWsJ3VhdhDK80i7gVXEJBdgTax8Vzk9H4n1m+gVt1LGEE2uq9
         SSyCMlhB0/ybEKoNJuWN5ed40cInJCTUtbmcrtZJ1Z3x+rG6n1r3RRAUkf+pkh8Mm4pc
         PT1wMIKupgRO3Rw/Dy9hNQeSiwCXzaOQ9AoWOACrw+W8ekCQ3P6+V5sNB8Gnsa1NVh75
         LuWnmKf8VThSuQAhTzjcFyzDokX2u3SzKA13EUAEYwM/FLHXwHeJGVwj2XOCTMoci8wp
         ZXxmQw5tAwKUUZTsqoTAuVHfM15CwyEnI+Rp1aMv1bzCdz61ZA49nt2MSjHXXoMDIgLd
         YI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651491; x=1750256291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JHyDDVL96PT69+HIUFTlQwzyTVvaxPDQBDHlKvb0lw=;
        b=gz5f6MIQn1MdWpRkEraC7/Wsz9wJ6OHjLaFSBB1k2fGhnawlI+hyX2MXV/VAxuWPlL
         CJVfwCh5hLFTiQKNKis08n9FMt/Hxv1uw03mF/NNeLA9FetytRhKEv3pSso+fWXkvOm5
         B6ADmcJgSQtzdcHMk2gWLGjNDKncG6dB14YTPNYDdLjX7ll2TT421Ct0t1KeO7jj6vvl
         7k1XCOL+fqTCK/lnwr3DY1d3n1dn0wrIlbiyqAnCF0JeAcfR5fvUe977VQeRx3qCtvSa
         NbK4PGGQSK1FgJFYAVe1sKXQfj2d2BdzP6sZKzI9Dd6N1NYIrceax36EGPCnCoFqB7en
         cWDw==
X-Forwarded-Encrypted: i=1; AJvYcCW/Ebx7iZuHwApnf3dtPPOukyWvcbtwAKMItS8/RmNdBdZSK5wsrbLtr2H966Q4EYcD//0BqkpD9zRPYCYm@vger.kernel.org, AJvYcCWJiLblyGaCZXN11l0CHjeJhgEcyex1x6Rw7jUYdudGuN3bwUojRyyHhZkdMKrmGsBNMLNdXQ87ToCShAIT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2xdApu4Gq6FuDKMlxeolQ3vui2OUdlenVvcg3fmUUTbWWjvsG
	R/cgx9w4iUXwdSX9MuUHsTe++yIpyjqnsioVCcg56GPrBeBMXlQDjkcqj664xPEMI1gWx9iDjRZ
	wL/5FCJoaWHs2aq5snCeUrO/WRXjxxLtSYL/H1a8=
X-Gm-Gg: ASbGncsk6FoSHz0vq+wA7vDoaolUZpq6rGuAtMfKWaRIhptVIewirFN/RByW0DlDM2T
	UTB+8bEIgT7T7/gyH+CBklSE/ER474r4BluW2VLuVTAkgcrc7Ks/LJ2nfMARujHiyJ43qetDAKZ
	ixvwMecN38re9EOvbv2vWxXyj3s2hyCK9thLMuUy3vHvRjbAOiV39f4JJlvqMX/2RhZpBWrhIVM
	rusWA==
X-Google-Smtp-Source: AGHT+IEw99JZ3Ni2MxwdgIFYpOqtbrPsWWAib83ZR7Rw9sZS3Aa6YYdAkawHMQmcsqGznXxBoTb+QwWK6QtF+QGgKHM=
X-Received: by 2002:a05:651c:221f:b0:32a:74db:fe73 with SMTP id
 38308e7fff4ca-32b21de3f22mr11802421fa.28.1749651490434; Wed, 11 Jun 2025
 07:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607082844.8779-1-pranav.tyagi03@gmail.com>
 <202506092053.827AD89DC5@keescook> <decv7f4drznbeoyjjm7ixlsgmu7ust4fltwwlnbltdjcvmhtbk@5qreij76z7jn>
In-Reply-To: <decv7f4drznbeoyjjm7ixlsgmu7ust4fltwwlnbltdjcvmhtbk@5qreij76z7jn>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Wed, 11 Jun 2025 19:47:58 +0530
X-Gm-Features: AX0GCFu4sDFJ8r-fSsh6QpnCWFxzSyxmgew_3nZ6MvQ-4CtPA9tGvltGmTDudag
Message-ID: <CAH4c4jKD1TdpyfUXxvz1F_-ONTbKC=4z2V0iH4rGCBgYv0-Kxg@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf: use check_mul_overflow() for size calc
To: Jan Kara <jack@suse.cz>
Cc: Kees Cook <kees@kernel.org>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 1:29=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 09-06-25 21:04:36, Kees Cook wrote:
> > On Sat, Jun 07, 2025 at 01:58:44PM +0530, Pranav Tyagi wrote:
> > > Use check_mul_overflow() to safely compute the total size of ELF prog=
ram
> > > headers instead of relying on direct multiplication.
> > >
> > > Directly multiplying sizeof(struct elf_phdr) with e_phnum risks integ=
er
> > > overflow, especially on 32-bit systems or with malformed ELF binaries
> > > crafted to trigger wrap-around. If an overflow occurs, kmalloc() coul=
d
> > > allocate insufficient memory, potentially leading to out-of-bound
> > > accesses, memory corruption or security vulnerabilities.
> > >
> > > Using check_mul_overflow() ensures the multiplication is performed
> > > safely and detects overflows before memory allocation. This change ma=
kes
> > > the function more robust when handling untrusted or corrupted binarie=
s.
> > >
> > > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > > Link: https://github.com/KSPP/linux/issues/92
> > > ---
> > >  fs/binfmt_elf.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > > index a43363d593e5..774e705798b8 100644
> > > --- a/fs/binfmt_elf.c
> > > +++ b/fs/binfmt_elf.c
> > > @@ -518,7 +518,10 @@ static struct elf_phdr *load_elf_phdrs(const str=
uct elfhdr *elf_ex,
> > >
> > >     /* Sanity check the number of program headers... */
> > >     /* ...and their total size. */
> > > -   size =3D sizeof(struct elf_phdr) * elf_ex->e_phnum;
> >
> > size is unsigned int, which has a maximum value of 4,294,967,295.
> >
> > elf_ex->e_phnum is a u16 (2 bytes) and will not be changing:
> >
> > $ pahole -C elf64_hdr */fs/binfmt_elf.o
> > struct elf64_hdr {
> >       ...
> >         Elf64_Half                 e_phnum;              /*    56     2=
 */
> >       ...
>
> Ah, what confused me was that I somehow thought Elf64_Half is u32 without
> checking it's definition which clearly shows its actually u16. Thanks for
> checking it! You're right that the patch is pointless then.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Hi,

I understand that the patch is actually pointless. I am still
new to kernel dev and learnt a lot from your comments. I will keep
this in mind while sending patches in the future.

Regards

Pranav Tyagi

