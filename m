Return-Path: <linux-fsdevel+bounces-34639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB2D9C7061
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC20281824
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 13:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF6C1DF726;
	Wed, 13 Nov 2024 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkzHYeSK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72DA1E4A9
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731503876; cv=none; b=lFxHAgyRgEENL6L8NuZEvscs+chvrz1qw669nT+SLER+mFCUsBolIpsIuFvJ3OdbNINNFDgCsZhGgAmAp8laXYGQHtgcvbzatxRG3TFfwO7hJz7u7gSM6PIN+k8mtjZwJxKnKbK28cAqNr/XkatoD7BnPpIdVmU5dbeuly9GrbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731503876; c=relaxed/simple;
	bh=AKYo4A2nw8lI3I1Yy7OytypcgetK7yBRSiUZIN4j7JA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhxUcMSP5c2Aw2p+DTeWRALJMMg15vW2uKQTZ+yDPScayBucy4paITQw97lw12rq9VqnwEB35ZCU0QWkm10e3sicvRX/5dLvIz1JSHdAtQskXDmdCQ5eIzXYMHse2aHlEVuCNXNcXojX9e+5kpYIwgbtgCM1es489RTK6SPgsgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkzHYeSK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21145812538so63409415ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 05:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731503874; x=1732108674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GASOn7QbrM9ZEmoRoXiZ13AI8Ncr2uZ/48itT1ixPSo=;
        b=RkzHYeSKNP5rW4OfzSUKnj98POMH91Gg4BPrpIp+ZAzjzvys5iwK/3Mrc1Klc30Tfe
         4s/s8eCs6Z83PIqrNrpUSRRWm2vlo8nnlngCQfyp5r3wrGsZYDcdgtUj8wfVG6lY/BhK
         xmRHso3aAkodZoV4K2oPqQZFj2jnb+ibAceNGL36xKGzGQXTkdXcXTv59iGwOC6egYG3
         MVU7bxSTmGbnIkXq284HTgHsGpiPUgj1TcCUaGxBgS3fViwPI0pW0pa3KO9p+2Owr65k
         S2oi7ZIfi7GV/8RtxYChLtuHTmWg/bN5jwJHU5vbsBUGrMC+xNccvAixYXpqd6oYHJAH
         Gm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731503874; x=1732108674;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GASOn7QbrM9ZEmoRoXiZ13AI8Ncr2uZ/48itT1ixPSo=;
        b=QLjYbMMQchflRdCCTed6awEFJWstSM07gKeUWR+ZfigrmqyzdMeUiLX4ciza/kK+VW
         QpbJiPz0BcKoubm8znhNJpDb9P016cR+LJym2avHOwOhW6Did5+Sd0GJeKK/4vm2/Zue
         +wpOiLntlcm5HW8wvUcx4NiQ9wa/UqhC0n7xYuxBnBRPAN1OJMfQpd2XrGnTHv06v0hE
         MsC1I+0ruaWFyQZ2WejmkYJKDcO2lSrMSiGF87pVdbZyfPQ9hq8zEQnYB3lXWBOVvyka
         jm1vKeUF9whV6rJh36i7adA1Vh6aFBZUZDW9Zsf5M783S9h4QCVoNsCoPn953kWzowGO
         2w9g==
X-Forwarded-Encrypted: i=1; AJvYcCX1kFygnvMZ9HG4XkR/CNIvdd2c9bs6vet6Wfk28Q0fLv45SS1dX9AEBMN/NozntIlOfrNKMR6H0NyEE8a1@vger.kernel.org
X-Gm-Message-State: AOJu0YwvvUyHk/TBwwnSRSHQdB5zoGQRIt/Cjx+MHqrxJm51p01J3EAp
	9WL+nn2FxK+RntkCCrhJRnJUsm+9xJQ6iVN6mho1372PivQCLA7T
X-Google-Smtp-Source: AGHT+IFkQjy5RcuzRtl+x2005T/fhBQQsWhUH09XQKI+0v0sV3eMr4pYS4nOBNx708rEayi0aGK5hA==
X-Received: by 2002:a17:902:e5c6:b0:20b:57f0:b38b with SMTP id d9443c01a7336-21183c97540mr294341675ad.19.1731503873799;
        Wed, 13 Nov 2024 05:17:53 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5d7a6sm109808345ad.215.2024.11.13.05.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 05:17:52 -0800 (PST)
Date: Wed, 13 Nov 2024 22:17:49 +0900
Message-ID: <m2o72jff2a.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: geert@linux-m68k.org
Cc: johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	ebiederm@xmission.com,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
In-Reply-To: <CAMuHMdVRB46fyFKjZn3Zw2bb8_mqZasqh-J7vse-GQkA3_OQDg@mail.gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
	<ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
	<CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
	<m2pln0f6mm.wl-thehajime@gmail.com>
	<CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
	<8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net>
	<f262fb8364037899322b63906b525b13dc4546c2.camel@sipsolutions.net>
	<CAMuHMdVRB46fyFKjZn3Zw2bb8_mqZasqh-J7vse-GQkA3_OQDg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Hello,

thanks for the inputs Geert, Johannes,

On Wed, 13 Nov 2024 19:27:08 +0900,
Geert Uytterhoeven wrote:
>=20
> Hi Johannes,
>=20
> On Wed, Nov 13, 2024 at 9:37=E2=80=AFAM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
> > On Wed, 2024-11-13 at 09:36 +0100, Johannes Berg wrote:
> > > On Wed, 2024-11-13 at 09:19 +0100, Geert Uytterhoeven wrote:
> > > >
> > > > > > > -       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA=
) && !MMU)
> > > > > > > +       depends on ARM || ((M68K || RISCV || SUPERH || UML ||=
 XTENSA) && !MMU)
> > > > > >
> > > > > > s/UML/X86/?
> > > > >
> > > > > I guess the fdpic loader can be used to X86, but this patchset on=
ly
> > > > > adds UML to be able to select it.  I intended to add UML into nom=
mu
> > > > > family.
> > > >
> > > > While currently x86-nommu is supported for UML only, this is really
> > > > x86-specific. I still hope UML will get support for other architect=
ures
> > > > one day, at which point a dependency on UML here will become wrong.=
..
> > > >
> > >
> > > X86 isn't set for UML, X64_32 and X64_64 are though.
> > >
> > > Given that the no-MMU UM support even is 64-bit only, that probably
> > > should then really be (UML && X86_64).
> > >
> > > But it already has !MMU, so can't be selected otherwise, and it seems
> > > that non-X86 UML
> >
> > ... would require far more changes in all kinds of places, so not sure
> > I'd be too concerned about it here.
>=20
> OK, up to you...

Indeed, this particular patch [02/13] intends to support the fdpic
loader under the condition 1) x86_64 ELF binaries (w/ PIE), 2) on UML,
3) and with) !MMU configured.  Given that situation, the strict check
should be like:

   depends on ARM || ((M68K || RISCV || SUPERH || (UML && X86_64) || XTENSA=
) && !MMU)

(as Johannes mentioned).

on the other hand, the fdpic loader works (afaik) on MMU environment so,

   depends on ARM || (UML && X86_64) || ((M68K || RISCV || SUPERH || XTENSA=
) && !MMU)

should also works, but this might be too broad for this patchset (and
not sure if this makes a new use case).

anyway, thank you for the comment.
# I really wanted to have comments from nommu folks.

-- Hajime

