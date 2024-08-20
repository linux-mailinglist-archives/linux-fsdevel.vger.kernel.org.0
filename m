Return-Path: <linux-fsdevel+bounces-26361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB759585FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 13:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C821F22357
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8C618E75D;
	Tue, 20 Aug 2024 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmToania"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB2018C02C;
	Tue, 20 Aug 2024 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153900; cv=none; b=KWK/me/ZpSaIml0RkBi8MrYlvelcvVYhxhMGlsgeUhSMIw2H91FHCTl0fUDGr/yuzFWNdMObpzW6mFzKcu6axOCz7WT2k/2CcvBhduuwwjJybaKm1IOTwAHZWigox7sqWGgotUY3xlIBDE9+YBrEpEPIxfSEouWuaeK4IWGotK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153900; c=relaxed/simple;
	bh=auY618kVeN3lcHBM/vI3e64WtYz7qzd55L7vbK/m3HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXRPDNNJtVzlgHgliJYCXqz+6T0+PnQtGXs1YcQD5pObvyJqBAcpK5VTZzga8+BUlnpSrOWRaA3N6yPb0fj4izT0WycOWHVzbMl1E5QDNI9MGMoIVB02b3wXRM9E1qyqoLk82dR0yjPfy9Ag85wKUk96202Er1dHmTPnVlDVkSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmToania; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso8197370a12.1;
        Tue, 20 Aug 2024 04:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724153897; x=1724758697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heGOSoslQzCK2Xpt765McX5y60tfHu8OmZwKXsu+TP4=;
        b=kmToania4lTbo8TWv/IuWVN8rFFalLkfd5yXJhwNtq15Ni/yedsCJ2z6Ko2fKGWQ0b
         S1QyXb+OXr6ODDKQE1Mcp17nHMJo8Po/IrfFrqB05hxlHP6YW2LspJj1SwZtk5M7jREu
         m13XhmFmaDV9/+ZeRCdub9MbdgF+baWUXvpUtN+2yK8XqlYU4c2P0E6nc9MumPvLu6yP
         z+3sCQyY84IOt10ib6WiKuhjYRBsn3M1TQSyyKpJejQhWnamfZBfFdGl3z3w2qoLfKSF
         +oJJwMPNT3ArAanvX4JOVyEvcIifE84FiWLFZI62uETnk2N78u+yqfN2aTgzfycyEsw1
         5PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724153897; x=1724758697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heGOSoslQzCK2Xpt765McX5y60tfHu8OmZwKXsu+TP4=;
        b=b+xt3Kliitzl3Aq/1q9mrkjtD+mUtHFqhT4ltc+e706rVeTn90lgin/kk/eb//umEr
         kEP9SDOUUKrSCP9FYZVtZibnoLay/01tNnNqI/TJImMe4ughGPwMLqCE+XbJoiDy63bE
         nf+1h30U3JirYOn4PlglKQDIhXIY8OrzMDZFg2tAwZfYsbnN6O4BNitULAwGHPI0la3I
         YmfH+8H2zy9BszEuviXGIhv1VeYqjHqIrzO2fhBz9d6kxidZSf3M49pOOTiWtgIxSlG4
         npf3fa7AJULIQZIA9t3w+sg/V1crFk9PbcMA1/UuN8Tt8pshUi2XCayyMDX0rzCYWvlA
         g/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOc7iat7BxdqK1h8XtgBHOXhcEhIMfftAlSKDshe/WK7OeJ7IvUAgXl1UWK+/tYMRS7328jvvMG0swfcQL@vger.kernel.org, AJvYcCVLe1i7XkxXRN3fNkEhnncmU3Z0V2cMafe8kEBCXL5FKGnhDs3TpqvR2R5ZjtkogwQjHA6Bq1ILU9x36mt7@vger.kernel.org
X-Gm-Message-State: AOJu0YyuSZ8QJnngHq1qNOmnpqkDfSiITwfKeZxwDEf9Tlb4Uip9wGbO
	Tp0u+4DEmT7ZTPKuiBjmWH57cGR54x4SJd0vj/p5k37ZJvVDs+AqO1QHb0ruX36veqAergX36fW
	A6GEwr5dCqSrzTXX6Zt3JlFUGhRidLA==
X-Google-Smtp-Source: AGHT+IGmZdRfYTIrXN6NdUXbPnyG0MknZGKzBRaMDrgwJlt23Ozu98f0nUId3+MtgEsZVQKp0DfdTT8QspvcONCpfY4=
X-Received: by 2002:a17:907:96a4:b0:a83:7ecb:1d1f with SMTP id
 a640c23a62f3a-a8392a03bc1mr976259866b.46.1724153897227; Tue, 20 Aug 2024
 04:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHFJe0X-OD42cWrgTObq=G_AZnqCHWPPGawy0ur1b84HGw@mail.gmail.com>
 <20240807062300.GU5334@ZenIV> <20240807063350.GV5334@ZenIV>
 <CAGudoHH29otD9u8Eaxhmc19xuTK2yBdQH4jW11BoS4BzGqkvOw@mail.gmail.com>
 <20240807070552.GW5334@ZenIV> <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
 <20240807075218.GX5334@ZenIV> <CAGudoHE1dPb4m=FsTPeMBiqittNOmFrD-fJv9CmX8Nx8_=njcQ@mail.gmail.com>
 <CAGudoHFm07iqjhagt-SRFcWsnjqzOtVD4bQC86sKBFEFQRt3kA@mail.gmail.com>
 <20240807124348.GY5334@ZenIV> <20240807203814.GA5334@ZenIV>
In-Reply-To: <20240807203814.GA5334@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 20 Aug 2024 13:38:05 +0200
Message-ID: <CAGudoHHF-j5kLQpbkaFUUJYLKZiMcUUOFMW1sRtx9Y=O9WC4qw@mail.gmail.com>
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

do you plan to submit this to next?

anything this is waiting for?

my quick skim suggests this only needs more testing (and maybe a review)

On Wed, Aug 7, 2024 at 10:38=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Aug 07, 2024 at 01:43:48PM +0100, Al Viro wrote:
> > On Wed, Aug 07, 2024 at 11:50:50AM +0200, Mateusz Guzik wrote:
> >
> > > tripping ip:
> > > vfs_tmpfile+0x162/0x230:
> > > fsnotify_parent at include/linux/fsnotify.h:81
> > > (inlined by) fsnotify_file at include/linux/fsnotify.h:131
> > > (inlined by) fsnotify_open at include/linux/fsnotify.h:401
> > > (inlined by) vfs_tmpfile at fs/namei.c:3781
> >
> > Try this for incremental; missed the fact that finish_open() is
> > used by ->tmpfile() instances, not just ->atomic_open().
> >
> > Al, crawling back to sleep...
>
> I _really_ hate ->atomic_open() calling conventions; FWIW, I suspect
> that in the current form this series is OK, but only because none
> of the existing instances call finish_open() on a preexisting
> aliases found by d_splice_alias().  And control flow in the
> instances (especially the cleanup paths) is bloody awful...
>
> We never got it quite right, and while the previous iterations of
> the calling conventions for that methods had been worse, it's still
> nasty in the current form ;-/
>
> Oh, well - review of those has been long overdue.



--=20
Mateusz Guzik <mjguzik gmail.com>

