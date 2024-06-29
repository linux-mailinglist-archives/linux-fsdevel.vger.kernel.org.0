Return-Path: <linux-fsdevel+bounces-22812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE2291CDFE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 17:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5860B21A36
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C4E84E04;
	Sat, 29 Jun 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOp0G1Yh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAFE4C99;
	Sat, 29 Jun 2024 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719676003; cv=none; b=eCfofqkLGSEIG4J442td0iQbP2Od+BZ3466ix6YEALQLCK4FoZJcFYKCtwNOz/bwBIY/b0tS5F4iMrRhSJ+RO1QWfTagLYZHFOWx6Qtd6R2LUIFVV7ONdO6T0H/v4GD+cID3MllDKpCxnWj32uUjXfRgMl0A2zuPO7kHf9oar1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719676003; c=relaxed/simple;
	bh=ZX/Fr2GG+f3Tr28+Bp97Ng1eJPwPkR/Iv8DVs/sK3/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kkc6WZMbXW6c/PNse0U7RVTggp68yoVoHD1BU8mX1Nsad7LiczuAjZGShmj4NCcz8Om/RZxSiTuesoy7U4OHfNlJr4wT9bp2LvhAb7dzwTbgnnzw0Pmcbj3iBAOFf4oW53mcTfhplTn0mGb3O34wS60UFKsjZQa0/VGsRQ+0YHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOp0G1Yh; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d203d4682so1957896a12.0;
        Sat, 29 Jun 2024 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719676000; x=1720280800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44Cpv3XYckCPGkyVl+MpWLq2gwCEyPJbFnnXibasCpk=;
        b=MOp0G1Yha2/rZRK4MtVfZMFKzxcpcq11Svao61OUoMb4WoFAoZjT9ZenfbL/ovKQDR
         jfjhKHrtbjprWFLoeG/gr95fM33cfrxBBH0yNf2O6JP2W+NyzuZ9Fw4+AX1UE21X4na4
         1oSsfdZ7KikuV7NXPOjrXda+qliVWbnF49TGIj7beP7PYcR4P6Bb5vgflHpA1R7V6lhA
         pxkbhzidzXkQBkRbtq9gzJR8Hnv+zE43i6lJrBdbLyCcHzQdP6+BMJQR1SWqpQ6HvMFv
         g3zQdW01FW+7Q+EXTmu/O2szWSf8yggGf48/s3uUpXyKga1f9OSW5ommN7Obh/HhRaVv
         23aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719676000; x=1720280800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44Cpv3XYckCPGkyVl+MpWLq2gwCEyPJbFnnXibasCpk=;
        b=gforjF94l6XROpfBYRL+FpVxQQVchLHbTWfYKEW/8dpP/JXGzqlwyLhDE2mwideC0p
         sLyRPpIXh+JSNHuSlM+SLcACAz4qxOqUiojO5zip9dbtyhBogKB1cDaENbdWSo+Y+bbP
         yyIhIrb6iSt58aDH/RJZDdWRYd8V0VQQyh1fkVop15Yx+DRweWhfjgDSaLJHHFeEnkCI
         W+OxR+BwjKzah2xTL/SXAAEc/iM7fREd7BpU7Db4tg3qQ0tTIwsAydpNCZTapBGUAnuw
         Aw6EzNTUv32SDXRVgIGXRg2snR/UFl73L8F65mL+I0kII3RrxoAWKyGdCan3lF3XnzGf
         fd8w==
X-Forwarded-Encrypted: i=1; AJvYcCXhuy9z3pz0mZileRsDd2/cPcGJhroQq9bmOIK0VNSd3brCadog0uI6GsD4Pz3Oho97hjwc5KhIqQPJKeCgA0mQuWyeuTrfGYTz6wpr2JR1nSaSvyk9zyTLxAKyOu2iNvWAh0j2flPXq2xXKQ==
X-Gm-Message-State: AOJu0YyF+5za9W79AcrXZtyju1kF0psIu18Kl4w8XSGHnWSqCiuKqLXQ
	M2QoxsaVaaZxmwqoe4WOmnAOMknt3UhTkd4wsmfUEHrxDj7gw39L2QsqfBuBv1Rx/hxyJeqgZof
	7ByXNinsoPjncYEcZxihrL1gP0ns=
X-Google-Smtp-Source: AGHT+IH8NCIj9SCFClHFTnFwLMnrLzDic2Ccz9m4WjpdNcQoEurRQdFS7ZDxIfEL6ks4Tqa3nlThnSuiSjbf94Y32Mk=
X-Received: by 2002:a17:906:ca8a:b0:a72:80b8:ba64 with SMTP id
 a640c23a62f3a-a751441f02emr72114966b.25.1719675999790; Sat, 29 Jun 2024
 08:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622154904.3774273-1-yu.ma@intel.com> <20240622154904.3774273-2-yu.ma@intel.com>
 <20240625115257.piu47hzjyw5qnsa6@quack3> <20240625125309.y2gs4j5jr35kc4z5@quack3>
 <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com> <20240626115427.d3x7g3bf6hdemlnq@quack3>
 <CAGudoHEkw=cRG1xFHU02YjkM2+MMS2vkY_moZ2QUjAToEzbR3g@mail.gmail.com>
 <20240627-laufschuhe-hergibt-8158b7b6b206@brauner> <32ac6edc-62b4-405d-974f-afe1e718114d@intel.com>
 <CAGudoHE5ROsy_hZB9uZjcjko0+=DbsUtBkmX9D1K1RG1GWrNbg@mail.gmail.com>
 <20240628091237.o5slz77tpwb5kdwj@quack3> <7482d788-3431-4d74-b16c-030160792a9e@intel.com>
In-Reply-To: <7482d788-3431-4d74-b16c-030160792a9e@intel.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 29 Jun 2024 17:46:27 +0200
Message-ID: <CAGudoHEyVxKQo1OvLh=AqVNPAW_+BKK9dcK0Jqqms4t-hC-RYQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
To: "Ma, Yu" <yu.ma@intel.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk, 
	edumazet@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com, 
	tim.c.chen@intel.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

How about you post a working version of the patchset, even if it only
looks at 0-63 and we are going to massage it afterwards.

On Sat, Jun 29, 2024 at 5:41=E2=80=AFPM Ma, Yu <yu.ma@intel.com> wrote:
>
>
> On 6/28/2024 5:12 PM, Jan Kara wrote:
> > On Thu 27-06-24 21:59:12, Mateusz Guzik wrote:
> >> On Thu, Jun 27, 2024 at 8:27=E2=80=AFPM Ma, Yu <yu.ma@intel.com> wrote=
:
> >>> 2. For fast path implementation, the essential and simple point is to
> >>> directly return an available bit if there is free bit in [0-63]. I'd
> >>> emphasize that it does not only improve low number of open fds (even =
it
> >>> is the majority case on system as Honza agreed), but also improve the
> >>> cases that lots of fds open/close frequently with short task (as per =
the
> >>> algorithm, lower bits will be prioritized to allocate after being
> >>> recycled). Not only blogbench, a synthetic benchmark, but also the
> >>> realistic scenario as claimed in f3f86e33dc3d("vfs: Fix pathological
> >>> performance case for __alloc_fd()"), which literally introduced this
> >>> 2-levels bitmap searching algorithm to vfs as we see now.
> >> I don't understand how using next_fd instead is supposed to be inferio=
r.
> >>
> >> Maybe I should clarify that by API contract the kernel must return the
> >> lowest free fd it can find. To that end it maintains the next_fd field
> >> as a hint to hopefully avoid some of the search work.
> >>
> >> In the stock kernel the first thing done in alloc_fd is setting it as
> >> a starting point:
> >>          fdt =3D files_fdtable(files);
> >>          fd =3D start;
> >>          if (fd < files->next_fd)
> >>                  fd =3D files->next_fd;
> >>
> >> that is all the calls which come here with 0 start their search from
> >> next_fd position.
> > Yup.
> >
> >> Suppose you implemented the patch as suggested by me and next_fd fits
> >> the range of 0-63. Then you get the benefit of lower level bitmap
> >> check just like in the patch you submitted, but without having to
> >> first branch on whether you happen to be in that range.
> >>
> >> Suppose next_fd is somewhere higher up, say 80. With your general
> >> approach the optimization wont be done whatsoever or it will be
> >> attempted at the 0-63 range when it is an invariant it finds no free
> >> fds.
> >>
> >> With what I'm suggesting the general idea of taking a peek at the
> >> lower level bitmap can be applied across the entire fd space. Some
> >> manual mucking will be needed to make sure this never pulls more than
> >> one cacheline, easiest way out I see would be to align next_fd to
> >> BITS_PER_LONG for the bitmap search purposes.
> > Well, all you need to do is to call:
> >
> >       bit =3D find_next_zero_bit(fdt->open_fds[start / BITS_PER_LONG],
> >                                BITS_PER_LONG, start & (BITS_PER_LONG-1)=
);
> >       if (bit < BITS_PER_LONG)
> >               return bit + (start & ~(BITS_PER_LONG - 1));
> >
> >
> > in find_next_fd(). Not sure if this is what you meant by aligning next_=
fd
> > to BITS_PER_LONG...
> >
> >                                                               Honza
>
> So the idea here is to take a peek at the word contains next_fd, return
> directly if get free bit there. Not sure about the efficiency here if
> open/close fd frequently and next_fd is distributed very randomly. Just
> give a quick try for this part of code, seems kernel failed to boot
> up=F0=9F=98=B3, kind of out of expectation ...
>


--=20
Mateusz Guzik <mjguzik gmail.com>

