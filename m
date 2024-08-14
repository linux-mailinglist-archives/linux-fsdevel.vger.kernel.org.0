Return-Path: <linux-fsdevel+bounces-25939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 810169520B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 19:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BAE1F228DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25FB1BBBCD;
	Wed, 14 Aug 2024 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M49s2hGM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0288E2E3E5;
	Wed, 14 Aug 2024 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655210; cv=none; b=Sll5asXUQ1eFKT9Od3XACNyOd5V7di5PD6I4pkIw0IVLuDbETJzHAtUx1ndPoBP1fnJvV3A3l+O3hQemjSgX9otbb1KSoWTU4fApi9dtKX4dXV558CD35DUKzV6mujG2NDWtz8SYNaU2w3CyB1SwTqNNu+yzMKcCGmhYmSZRoyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655210; c=relaxed/simple;
	bh=V+40J9S744Lv5XukuH5ORTMLHPUB/QUXM1e3ATNzDKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FoSUySBYwNxsp7TljDY3FvxTHCe233t1rNs6hSTmsXmAbrFYh0L8aef5AqM2m3xswsZKnEQKA2wnFTre8Px8OnwEiA/bEjlJApPtENOFOAGpK08CFkUbuDuG4i11DrO2kiDk+nN9YW8OxXpgdNNg6HG7lvh3iJ6PbElO9/ZqF9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M49s2hGM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3bd8784d3so293891a91.3;
        Wed, 14 Aug 2024 10:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723655208; x=1724260008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJyDGOa9e890VyGR7m4SBs+qeXxTLNl9Z80pbaWVlzk=;
        b=M49s2hGM5BLbuYw4kN55ry4gtLrJ+85q8wCuZiCdHr6dtBYRxK3lQI1OGW3SM8mESC
         eRIy+5whepLQW+hQ7kxKyQN5cXBgb44njv5zP9Su6FRr2M/WyevnnGcLbNPuE0glV0Hx
         CRsVJ4EREml7KhvKtPsUkiKlAc3XN/RL09hZqjWhh33lTNk6RX7jDSwisu2b7iNPNQ1P
         Y4A/AuAy9UPXJnXP+xR7jc64UoewG42wGe4HJTcmipc2y6fVTxogWHNsm2ZOpdFv4ip9
         wsFKC6PeVV/cjzYgNeGdiM3qlcTiTo+atBj9omrVphrlh4H9pCTSfS4aOoHgEultuCE2
         Wdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723655208; x=1724260008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJyDGOa9e890VyGR7m4SBs+qeXxTLNl9Z80pbaWVlzk=;
        b=AVRDnXZXFyoCwYK78uBjCVMJlob4ovcLqwEGRjvHghU3Y1c+oxWfL1iUEXqdqj3wKu
         OQzeP2XgmY8RXhJGuu6vA9sh5RbdZqWO785vowLWlp0KD6LbH4yKZWN16P9bJ6P9y/9Z
         S6guN5G31NA6vvdxY/h2NgSqtxDEI0oxS/c0G1es5720GQrdd3P7XXne7aFPmcp9Jwpa
         hpbFQ9FI8gkbI1xa/1Vw4mveQooN37odxp+NtDN32rOUn29Y5PlG+Au8fnrJ3vrkhgG7
         Fl+ohTDUXpQ2ClMb4nWeESyW1LEHTWg5kM6xIxe428FJZDBz8lgSC5ttPX4YUaeX2njb
         31yA==
X-Forwarded-Encrypted: i=1; AJvYcCUWS04IBgepUX40SMGBbwVHNUX2YZU3YPoSnweczVynNuTWIqBcSNLrucHmApWEgEjhsWIHy9FnYTB3bamIt4MM6HetGStyVmy7v/orNTGYmM5uwZbIH107WaU+jlH1AtdN+cwF01S5u0Wqi/jsd7lwDyEoue7YtWS25Q==
X-Gm-Message-State: AOJu0YzOKau8wNzj8HDCWdDDVQPYjEqv8Doh7rtA19+EbH0ej9YDhc2Q
	n8aIfJdunkesQMkR0nsUWwJnemicn1xaz9MTC9XoFEHU23KZqO1YI6Zd1bdEinO2/XImSU9Zkxk
	Ix9gNdeNvS+f5xnmRIPfJZVbf/D8=
X-Google-Smtp-Source: AGHT+IFpxEFJerNQMdeR4Yo2U8OoEA6DbLNV577OSQZ/EXCkbDWO6HwvzyTFK0iPB1fUKU8OpDK7ocp4RpFKERZ05Gw=
X-Received: by 2002:a17:90a:9f97:b0:2c7:ab00:f605 with SMTP id
 98e67ed59e1d1-2d3aab43bb0mr3709604a91.20.1723655208070; Wed, 14 Aug 2024
 10:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813002932.3373935-1-andrii@kernel.org> <20240813002932.3373935-2-andrii@kernel.org>
 <CAG48ez1oUas3ZMsDdJSxbZoFK0xfsLFiEZjJmOryzkURPPBeBA@mail.gmail.com>
 <CAEf4BzZa9Rkm=MAOOF58K444NAfiRry2Y1DDgPYaB48x6yEdbw@mail.gmail.com> <CAG48ez0QdmjJua8V4RPhs2WmuGGhD++H-e2vacfP1=2jVgCy+w@mail.gmail.com>
In-Reply-To: <CAG48ez0QdmjJua8V4RPhs2WmuGGhD++H-e2vacfP1=2jVgCy+w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 14 Aug 2024 10:06:35 -0700
Message-ID: <CAEf4Bzb+OyoMqLku0qK0-UFpFjpkWVvb2MeSedFFfWAq4erLkg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 01/10] lib/buildid: harden build ID parsing logic
To: Jann Horn <jannh@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 9:14=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Aug 14, 2024 at 1:21=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Tue, Aug 13, 2024 at 1:59=E2=80=AFPM Jann Horn <jannh@google.com> wr=
ote:
> > >
> > > On Tue, Aug 13, 2024 at 2:29=E2=80=AFAM Andrii Nakryiko <andrii@kerne=
l.org> wrote:
> > > > Harden build ID parsing logic, adding explicit READ_ONCE() where it=
's
> > > > important to have a consistent value read and validated just once.
> > > >
> > > > Also, as pointed out by Andi Kleen, we need to make sure that entir=
e ELF
> > > > note is within a page bounds, so move the overflow check up and add=
 an
> > > > extra note_size boundaries validation.
> > > >
> > > > Fixes tag below points to the code that moved this code into
> > > > lib/buildid.c, and then subsequently was used in perf subsystem, ma=
king
> > > > this code exposed to perf_event_open() users in v5.12+.
> > >
> > > Sorry, I missed some things in previous review rounds:
> > >
> > > [...]
> > > > @@ -18,31 +18,37 @@ static int parse_build_id_buf(unsigned char *bu=
ild_id,
> > > [...]
> > > >                 if (nhdr->n_type =3D=3D BUILD_ID &&
> > > > -                   nhdr->n_namesz =3D=3D sizeof("GNU") &&
> > > > -                   !strcmp((char *)(nhdr + 1), "GNU") &&
> > > > -                   nhdr->n_descsz > 0 &&
> > > > -                   nhdr->n_descsz <=3D BUILD_ID_SIZE_MAX) {
> > > > -                       memcpy(build_id,
> > > > -                              note_start + note_offs +
> > > > -                              ALIGN(sizeof("GNU"), 4) + sizeof(Elf=
32_Nhdr),
> > > > -                              nhdr->n_descsz);
> > > > -                       memset(build_id + nhdr->n_descsz, 0,
> > > > -                              BUILD_ID_SIZE_MAX - nhdr->n_descsz);
> > > > +                   name_sz =3D=3D note_name_sz &&
> > > > +                   strcmp((char *)(nhdr + 1), note_name) =3D=3D 0 =
&&
> > >
> > > Please change this to something like "memcmp((char *)(nhdr + 1),
> > > note_name, note_name_sz) =3D=3D 0" to ensure that we can't run off th=
e end
> > > of the page if there are no null bytes in the rest of the page.
> >
> > I did switch this to strncmp() at some earlier point, but then
> > realized that there is no point because note_name is controlled by us
> > and will ensure there is a zero at byte (note_name_sz - 1). So I don't
> > think memcmp() buys us anything.
>
> There are two reasons why using strcmp() here makes me uneasy.
>
>
> First: We're still operating on shared memory that can concurrently chang=
e.
>
> Let's say strcmp is implemented like this, this is the generic C
> implementation in the kernel (which I think is the implementation
> that's used for x86-64):
>
> int strcmp(const char *cs, const char *ct)
> {
>         unsigned char c1, c2;
>
>         while (1) {
>                 c1 =3D *cs++;
>                 c2 =3D *ct++;
>                 if (c1 !=3D c2)
>                         return c1 < c2 ? -1 : 1;
>                 if (!c1)
>                         break;
>         }
>         return 0;
> }
>
> No READ_ONCE() or anything like that - it's not designed for being
> used on concurrently changing memory.
>
> And let's say you call it like strcmp(<shared memory>, "GNU"), and
> we're now in the fourth iteration. If the compiler decides to re-fetch
> the value of "c1" from memory for each of the two conditions, then it
> could be that the "if (c1 !=3D c2)" sees c1=3D'\0' and c2=3D'\0', so the
> condition evaluates as false; but then at the "if (!c1)", the value in
> memory changed, and we see c1=3D'A'. So now in the next round, we'll be
> accessing out-of-bounds memory behind the 4-byte string constant
> "GNU".
>
> So I don't think strcmp() on memory that can concurrently change is allow=
ed.
>
> (It actually seems like the generic memcmp() is also implemented
> without READ_ONCE(), maybe we should change that...)
>
>
> Second: You are assuming that if one side of the strcmp() is at most
> four bytes long (including null terminator), then strcmp() also won't
> access more than 4 bytes of the other string, even if that string does
> not have a null terminator at index 4. I don't think that's part of
> the normal strcmp() API contract.

Ok, I'm convinced, all fair points. I'll switch to memcmp(), there is
no downside to that anyways.

