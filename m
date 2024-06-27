Return-Path: <linux-fsdevel+bounces-22623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1684491A679
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 14:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CA6284C91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 12:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7448158A37;
	Thu, 27 Jun 2024 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anue5/zB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54781581F9;
	Thu, 27 Jun 2024 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490827; cv=none; b=RsoWMRWwz0/PYVnfTwmAVkzwEScmm09k5l0ycbD5H37aL/JcHJsontezj+ATMmgNqZfsBaakxBPD1BOMNmyXkoQL9pX5X7smpTs5KvCDFtLdoZloJ+zdgAuvZAqUXF7GFD4cEaGwO9XecNaPqJtRIG5C9ew2cNqWVFA7mqNMnRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490827; c=relaxed/simple;
	bh=PUiC+p80y1527E72vWRjZZNVADRcn5j2khxOYSvQAJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/fBXdAH9/LFaEe983xLDtWoq5YOkMRAwLEUSYe1T7/o10WBfDzfsgDRQHJkDQWs7DfEXjzXMip4bzNRPtDaP0xA5ty5r0Is8PAG6o0b8BBv+VJJnJgTeWUAwOUB9zt5UqyjcWLP7nqRZl/a7RM8S1eXW4F2emDKo/4FnHqkW0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anue5/zB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00b97so1624414a12.0;
        Thu, 27 Jun 2024 05:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719490823; x=1720095623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfPAvEEoOhqlNc3o5XSKpPKNsQK+jNCsk3UKc8ZzX2E=;
        b=anue5/zB2FK5jLm7L0co5tXzZzSO8q3cgXbp3yagkR+kjiEG2LQmdTzpCFsgCqOmq5
         H/2cdBFIYo3zgk1iixEz9DFJalwxJ3U7/aabnUa92hmeEcoFqPPsRJQYqnv/PQFZOyGz
         3e1B8irLFDNAKG6y1Phc7UsIyPX0AcwOTwv99nciTEYO9MDGTjec9Q35P1aE9trTMhm3
         1gI+ojja2kwXJojNFER6pe2U7QUKQ6Pf9gIuHrBg/fXsNGcZBMg2/i9VQOObwjsg0Uij
         TKkSy4yM/iaIEbgccQ/CIlXK1VpN6MWj/JpvYsqQD8Rlq0COy4F+vKvgPHiTw1wRUkIg
         KhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719490823; x=1720095623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfPAvEEoOhqlNc3o5XSKpPKNsQK+jNCsk3UKc8ZzX2E=;
        b=ViVe7N2GmPEPqURjZds9bnhjPCgqviQeQaz+OYRsrc9fmzwjI1qkEliJ0xsAiQrEBh
         J50ConH+9L7XorUUIXri+x1wzQmprkVzU7GTEcwh6uuJ34S9cn3IQVOnkgzLfyaAtiaO
         5ZIRPga1b7zHeYqhK5XoLFsY2je4Mb+XHVGqysQQqLv60JOdnELceSvdemS8WoaQEmDo
         K+L2CkGuZ+o3fEW3ZKxt0z0EGtu0ECLkw0tCrbgbOOvgluhnRuNV5QdcA4LiI00FUlRX
         /7G2iwqNV665CaGKhsR1HHjGgj1c9mij631tjgHDYKLak9Jg5DtILz8v6tsIiUkl4YKS
         b/KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHFlD7CBs3QyKsQMdUMcKO3Wg6F+1361bb2L97K5LhqcCF/Wb0aIqH/dnJ+A3+x2m1x8UkFmwWAX1a130Jv45KuDDqVmqiHAYjLZUKTf6jMSjd8v6R3m/kmr4FEIhXW2JfonYUep2ek4JK2w==
X-Gm-Message-State: AOJu0YwQQWUaNNjNWfx/PPFS7RXK72THubc+fcFKQxQzQCDMe9B5CZFs
	tkb9atPqYPyxAcIlBrMJBTIbLIgf8rD+9KkKu8xDKol7mMFoWxYz6hN3he0qQ4anEo71+T5Rh/L
	Gd1MEVVX5lHzr/OlNlgffoympkekklTMmm+Q=
X-Google-Smtp-Source: AGHT+IF3Ih0kBarK1vQ38L5gWHqqfPJPR/YBqRJqemKxAXKc6yKtlejb9rsU1Qqbk9DjpFo85XLpqFhIJEd9edEUylo=
X-Received: by 2002:a17:907:104c:b0:a6f:59dc:4ed2 with SMTP id
 a640c23a62f3a-a7245b6dc4bmr799923566b.12.1719490822798; Thu, 27 Jun 2024
 05:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614163416.728752-1-yu.ma@intel.com> <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-2-yu.ma@intel.com> <20240625115257.piu47hzjyw5qnsa6@quack3>
 <20240625125309.y2gs4j5jr35kc4z5@quack3> <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com>
 <20240626115427.d3x7g3bf6hdemlnq@quack3> <690de703aeee089f86beca5cb90d3d43dcd7df56.camel@linux.intel.com>
 <3d553b6571eaa878e4ce68898113d73c9c1ed87d.camel@linux.intel.com> <20240627120922.khxiy5xjxlnnyhiy@quack3>
In-Reply-To: <20240627120922.khxiy5xjxlnnyhiy@quack3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 27 Jun 2024 14:20:10 +0200
Message-ID: <CAGudoHH3QuUfuD5aSGxTFhZqXzce6i1Be2XfEvfRKQ5qG8NDxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
To: Jan Kara <jack@suse.cz>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, "Ma, Yu" <yu.ma@intel.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, edumazet@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com, 
	tim.c.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 2:09=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 26-06-24 09:52:50, Tim Chen wrote:
> > On Wed, 2024-06-26 at 09:43 -0700, Tim Chen wrote:
> > > On Wed, 2024-06-26 at 13:54 +0200, Jan Kara wrote:
> > > >
> > > >
> > > > Indeed, thanks for correcting me! next_fd is just a lower bound for=
 the
> > > > first free fd.
> > > >
> > > > > The conditions
> > > > > should either be like it is in patch or if (!start && !test_bit(0=
,
> > > > > fdt->full_fds_bits)), the latter should also have the bitmap load=
ing cost,
> > > > > but another point is that a bit in full_fds_bits represents 64 bi=
ts in
> > > > > open_fds, no matter fd >64 or not, full_fds_bits should be loaded=
 any way,
> > > > > maybe we can modify the condition to use full_fds_bits ?
> > > >
> > > > So maybe I'm wrong but I think the biggest benefit of your code com=
pared to
> > > > plain find_next_fd() is exactly in that we don't have to load full_=
fds_bits
> > > > into cache. So I'm afraid that using full_fds_bits in the condition=
 would
> > > > destroy your performance gains. Thinking about this with a fresh he=
ad how
> > > > about putting implementing your optimization like:
> > > >
> > > > --- a/fs/file.c
> > > > +++ b/fs/file.c
> > > > @@ -490,6 +490,20 @@ static unsigned int find_next_fd(struct fdtabl=
e *fdt, unsigned int start)
> > > >         unsigned int maxbit =3D maxfd / BITS_PER_LONG;
> > > >         unsigned int bitbit =3D start / BITS_PER_LONG;
> > > >
> > > > +       /*
> > > > +        * Optimistically search the first long of the open_fds bit=
map. It
> > > > +        * saves us from loading full_fds_bits into cache in the co=
mmon case
> > > > +        * and because BITS_PER_LONG > start >=3D files->next_fd, w=
e have quite
> > > > +        * a good chance there's a bit free in there.
> > > > +        */
> > > > +       if (start < BITS_PER_LONG) {
> > > > +               unsigned int bit;
> > > > +
> > > > +               bit =3D find_next_zero_bit(fdt->open_fds, BITS_PER_=
LONG, start);
> > >
> > > Say start is 31 (< BITS_PER_LONG)
> > > bit found here could be 32 and greater than start.  Do we care if we =
return bit > start?
> >
> > Sorry, I mean to say that we could find a bit like 30 that is less than
> > start instead of the other way round.
>
> Well, I propose calling find_next_zero_bit() with offset set to 'start' s=
o
> it cannot possibly happen that the returned bit number is smaller than
> start... But maybe I'm missing something?
>

You gate it with " if (start < BITS_PER_LONG)" which only covers the
small initital range, while I'm arguing this should work for any fd.

--=20
Mateusz Guzik <mjguzik gmail.com>

