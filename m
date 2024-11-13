Return-Path: <linux-fsdevel+bounces-34708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 870109C7ED2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 00:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3F0B23847
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 23:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C5918D621;
	Wed, 13 Nov 2024 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAIpascb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D05B17C
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 23:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731540768; cv=none; b=RWqmf4cV7TVC82QM4ylLBx7N903s8pC8s2lPyXsvAtfyYP1EV3JDxBpNp9QDyk2BMzR2Xs63vYj4A72mO/Pjl5fPnJdoLpMGPlxg9dLxYUiiDSJUB0YmP0jCJSPlq0C9xg8i+DSCLh7ZuijAaecHLMCvkSJZgIe7ddfuaL2bcNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731540768; c=relaxed/simple;
	bh=5v0z0RZ7azwCJh7knNyb53D+Rr38paL4Cqfyky5M3r8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ae+GRc6vWsuJxVqn5y+LiOZZkalDgVSYd1T9vqq+xsDpcVA5ViTIwd8QnmyIe718YX2eZJPy7JYe6HIBxkCCn1XIZv6fTc2rXLLEHlgWh4JTHjGDHKNEr7EdYXv5TWgK2+egBCE3s2ZtneXLrqd37fUWdn3ajorPeGMo6O1XYK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAIpascb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ca388d242so79782745ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 15:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731540765; x=1732145565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uTdUAECq+CtjKVt4lgB+veHtw+zGn6+CLgEFY+NSyi4=;
        b=gAIpascbg6gh9ozx2zSaGKrvvDkfHNYZ7xQMxOy8A5nSnYzUYytmRrhNSj8qanQGct
         W91WI5GLa/x5o0AFSyNhijNh4SVEr12olw2BcV/TbloamlcRSQEewJ1gKbpOG0DcrQ+6
         /V1XrHWMckafoSfZiepAoo8bGO/xKbZwZh6NubLSuMJKeFD8LCeZcRFajAqtfFo7Sz52
         rLx09sxHAJicwFNpoiXUujKXwiyU+g0/Eu/SlQP38Mt2PMcD6w+Zv+dz19B8qReNPXGh
         VXLiE13qUHBCg8eZq0tjvJhn/VGfQkRr0uBE6iEQpvn4fGC6zChOwdAnLX2+G4/plYxf
         LkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731540765; x=1732145565;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTdUAECq+CtjKVt4lgB+veHtw+zGn6+CLgEFY+NSyi4=;
        b=m1W6+97TuIhIorEWwnNrJQRc6sfUKL80wXp7/e4lIoj0bca1QPfcIXTjCklwdbJYH0
         yQm6ZLukBWMYQyTgNQM1Lu353nJtvdjttXBTGltsgA+RbXLrgh0FhuRNoPVZP4hO5Qdq
         LL0OK0BdbIEjjpq9nzqt9TEbaKGS0v3MKRWg16PttkKXKQ90o6GKc/EKQJS/I3hEQZuS
         6gh7MYXvyr++3rqA5JCoXU4ytvWTn8T5FDUyBuw6+781rkECV/SX4+GtZr7ypMMQp+qU
         vLW0B27lwnxO9YjY+Nby/tprGSboQuF5G7vHWUofNiAdTKpxVZWu9gved08IjodkQ0hb
         2fHg==
X-Forwarded-Encrypted: i=1; AJvYcCVJTf+OHsPz1x5MhMwmtuFV9WFn+y44EWft+ylIM61jFhgTf7p9hBFF2VY5zob/xz/heQvhMxX88bEL69aX@vger.kernel.org
X-Gm-Message-State: AOJu0YydyAhwVY9Sf1nJIpYOCMcHbVxptMgiAZBKuD6+O5/62VVMicPC
	9wPPmjwR55SRRgDxv7P8T6EiZt4vPGvI/O+/JbhzEeyOuXNKNWqbG4mtHasp
X-Google-Smtp-Source: AGHT+IFFzcICfb9N8gQggQGq1jmiucB7Uy4NC6ZmyZfMRs4qLXEYndGg+8KwFkASWQtQEkxSu0IRgQ==
X-Received: by 2002:a17:902:e807:b0:20b:a9f3:796d with SMTP id d9443c01a7336-211c5090429mr1784615ad.44.1731540765394;
        Wed, 13 Nov 2024 15:32:45 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc3f3asm115824435ad.3.2024.11.13.15.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 15:32:44 -0800 (PST)
Date: Thu, 14 Nov 2024 08:32:40 +0900
Message-ID: <m2msi2g15z.wl-thehajime@gmail.com>
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
	linux-fsdevel@vger.kernel.org,
	gerg@linux-m68k.org,
	dalias@libc.org
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
In-Reply-To: <CAMuHMdXKAz0bxBGrbbHD6haeCbhYh=pCb4stox1fOifCvyCwpw@mail.gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
	<ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
	<CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
	<m2pln0f6mm.wl-thehajime@gmail.com>
	<CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
	<8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net>
	<f262fb8364037899322b63906b525b13dc4546c2.camel@sipsolutions.net>
	<CAMuHMdVRB46fyFKjZn3Zw2bb8_mqZasqh-J7vse-GQkA3_OQDg@mail.gmail.com>
	<m2o72jff2a.wl-thehajime@gmail.com>
	<CAMuHMdXKAz0bxBGrbbHD6haeCbhYh=pCb4stox1fOifCvyCwpw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


On Wed, 13 Nov 2024 22:55:02 +0900,
Geert Uytterhoeven wrote:
> On Wed, Nov 13, 2024 at 2:17=E2=80=AFPM Hajime Tazaki <thehajime@gmail.co=
m> wrote:
> > On Wed, 13 Nov 2024 19:27:08 +0900,
> > Geert Uytterhoeven wrote:
> > > On Wed, Nov 13, 2024 at 9:37=E2=80=AFAM Johannes Berg <johannes@sipso=
lutions.net> wrote:
> > > > On Wed, 2024-11-13 at 09:36 +0100, Johannes Berg wrote:
> > > > > On Wed, 2024-11-13 at 09:19 +0100, Geert Uytterhoeven wrote:
> > > > > >
> > > > > > > > > -       depends on ARM || ((M68K || RISCV || SUPERH || XT=
ENSA) && !MMU)
> > > > > > > > > +       depends on ARM || ((M68K || RISCV || SUPERH || UM=
L || XTENSA) && !MMU)
> > > > > > > >
> > > > > > > > s/UML/X86/?
> > > > > > >
> > > > > > > I guess the fdpic loader can be used to X86, but this patchse=
t only
> > > > > > > adds UML to be able to select it.  I intended to add UML into=
 nommu
> > > > > > > family.
> > > > > >
> > > > > > While currently x86-nommu is supported for UML only, this is re=
ally
> > > > > > x86-specific. I still hope UML will get support for other archi=
tectures
> > > > > > one day, at which point a dependency on UML here will become wr=
ong...
> > > > > >
> > > > >
> > > > > X86 isn't set for UML, X64_32 and X64_64 are though.
> > > > >
> > > > > Given that the no-MMU UM support even is 64-bit only, that probab=
ly
> > > > > should then really be (UML && X86_64).
> > > > >
> > > > > But it already has !MMU, so can't be selected otherwise, and it s=
eems
> > > > > that non-X86 UML
> > > >
> > > > ... would require far more changes in all kinds of places, so not s=
ure
> > > > I'd be too concerned about it here.
> > >
> > > OK, up to you...
> >
> > Indeed, this particular patch [02/13] intends to support the fdpic
> > loader under the condition 1) x86_64 ELF binaries (w/ PIE), 2) on UML,
> > 3) and with) !MMU configured.  Given that situation, the strict check
> > should be like:
> >
> >    depends on ARM || ((M68K || RISCV || SUPERH || (UML && X86_64) || XT=
ENSA) && !MMU)
> >
> > (as Johannes mentioned).
> >
> > on the other hand, the fdpic loader works (afaik) on MMU environment so,
> >
> >    depends on ARM || (UML && X86_64) || ((M68K || RISCV || SUPERH || XT=
ENSA) && !MMU)
> >
> > should also works, but this might be too broad for this patchset (and
> > not sure if this makes a new use case).
>=20
> AFAIK that depends on the architecture's MMU context structure, cfr.
> the comment in commit 782f4c5c44e7d99d ("m68knommu: allow elf_fdpic
> loader to be selected"), which restricts it to nommu on m68k.  If it
> does work on X86_64, you can drop the dependency on UML, and we're
> (almost) back to my initial comment ;-)

I checked and it doesn't work as-is with (UML_X86_64 && MMU).
restricting nommu with UML might be a good to for this patch.

even if it works, I would like to focus on UML && !MMU for this patch
series since I wish to make the (initial) patchset as small as
possible.  If we would like to make it broadly available on x86, that
would be a different patch.

> > anyway, thank you for the comment.
> > # I really wanted to have comments from nommu folks.
>=20
> I've added some in CC...

Thanks,

-- Hajime

