Return-Path: <linux-fsdevel+bounces-66526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F314C22703
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 22:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA45188AC2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E531A80D;
	Thu, 30 Oct 2025 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9gVow4Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0438F34D3B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860402; cv=none; b=ZorHOhWGMgDvWK9zvmhuLiEJ+29m9nDy5ZHBPuGm3wVGvzQH1ocF1dFdYxlsHBGR6iYYUnyIHtSVHSSCZedA4O36ziFjGzbU1w4pyyXk6/jf/roTodca5lK+z0TatEVHoczGAp8TXxpZ8AHPjAYv1ke6q5yWliDqddWkN8bi+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860402; c=relaxed/simple;
	bh=Un7q2VE5bBWMu9+bF1/DDuPDLvT9+CiXheIllChWZYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLxCq2RzcHyNImJfmCpHThEwfrEiK0F9dV1Ld3nTzy1Qrwbg74SdM/wbQHueGqQJlne2oVvH+Ju1PVHoWm7Ke7yUIXYBMsMNMe5DgvCq8CjkUul+ruHeWU0nWMVVj3+8lNSi+YlXe6Lo+4izf8sODMafUz8rMfBevg/l2I4r42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9gVow4Z; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c3d913b3bso2789420a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 14:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761860399; x=1762465199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Un7q2VE5bBWMu9+bF1/DDuPDLvT9+CiXheIllChWZYg=;
        b=l9gVow4ZwNZEUykKmLsbfgJEXkRM/dGHpifWnWjcgcIlKUk4R7kqjjTZ5LF5BTuhzA
         uLKHJDCZpLcVD+AH9Gsj+bZ8OCU+d7W9uEIDFSwjZCv6WpNY/ehv1fArZf+9cVzMubCd
         HqRf2rYRwwaOd63zqUWfakhLSMhi9OuSr0FrzlVahK9KgQlbWmE3pNqBbBvD2lFQpYuK
         M8KLXZbh2gNEeJadSB1QOj+zGMMLd+9rY3HEnMRs8IioxrVkvjsJJBDRknPnH9A/Qdh2
         gyqJQiJ1TH/dQC5HntBX32Ey5+d0U3/Huqf1FZ2BmrrbpT69MUL9srh7t9Iv7N7RLpVv
         ybyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860399; x=1762465199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Un7q2VE5bBWMu9+bF1/DDuPDLvT9+CiXheIllChWZYg=;
        b=F01V1GFPem7y2JgSWo8lSo6CuVkkBC3blNSxRTN0EhChOow0Hz3p0mvASiZ/O+z28g
         bPu1jc8WCZph5IdQ0xpbvFvgzgXFN8Myy/MZYneQdsPHXTK6TKTdJ4sqCq0MdafD2cEa
         PAGDmy2c2uXFta47WmHCzx0zkSIRCwdFOJSU/v2aDVNEGLkoA4qQ1YthVj9L0VlG/dZs
         PSHR9GtKD5rJF/fgJaBXtIgv4tSxhb5yoeztrMcZrXS+iRzqQlS6XuLpXj+W7V2HVOFO
         Rb4oyDOVYn7ZYAOcGeU4z0OMUvbu6frHVQqsMKB3OzuOIB7CHMO6oYnwGZbljDAgILMw
         YeYw==
X-Forwarded-Encrypted: i=1; AJvYcCVBQ6qhPzaRQKyGFuf1blKVS1mm59DzPCoO3i3Jvpxk7rQtrfmk0XmQROpNdc2DaKWOM6BJuVD2sWTaRRvl@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvd9hZG8qWTY8b76Kz+sVdSe4sB3qY5m+nf9piu5kkae71hgVk
	d8+l9th4U68nxupzFPaByDZzgUir2E4w7TvBxI78jhGz0PJAgMrqWzAUIzXchb1hZXA+qKDMQhv
	FlwzVLF7IBDdwG2jB0CCpClgPIX0xZDo=
X-Gm-Gg: ASbGncv6iq/Cl21FDpz2aIu95klmGJqK7/VU0MzOIsQ6RvOAMjRn4G9suR/kTbf3bIi
	5j6jugBiJGnNiFOVFKqO8vpyBqNYI8vziB7a4OE5RQEO1kkWSqqBLeotzH0zZ1Mw2WQbLx0gKiZ
	/idBwXzIFAsQLoIHO2y3JTt/RsAHlDN8h7j6Nn/VSdtPtWR+qW4mNDGr1Jipx3iqrevZrZeAr9e
	y1fvZSIJZCFZW7MNeNywb1QGEmZwjz7o5NcpNWeji6ao8KWnRbxvsoOpMmc5862r0xlzLqa2KcZ
	+7jK73kVx5TpwbA=
X-Google-Smtp-Source: AGHT+IGivTHuxgPZcQa4cCBLgM5kLxSC+JWSlWSFpHYQlDc5EdqGinLy/IF97I7fOc1TIWJwOMdylWlJmhsiHGzUZNM=
X-Received: by 2002:a05:6402:2711:b0:63c:33f8:f05e with SMTP id
 4fb4d7f45d1cf-64077018349mr791179a12.22.1761860399068; Thu, 30 Oct 2025
 14:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com> <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
 <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com> <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
In-Reply-To: <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 30 Oct 2025 22:39:46 +0100
X-Gm-Features: AWmQ_blVgA3zdng1SUEMEnvVT1kzBIJqYiHPFrsa5zFQqVfW0RDEFbr-ecEITls
Message-ID: <CAGudoHH817CKv0ts4dO08j5FOfEAWtvoBeoT06KarjzOh_U6ug@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 7:07=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ Adding Thomas, because he's been working on our x86 uaccess code,
> and I actually think we get this all wrong for access_ok() etc ]
>
> On Thu, 30 Oct 2025 at 09:35, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > I don't know if you are suggesting to make the entire thing fail to
> > compile if included for a module, or to transparently convert
> > runtime-optimized access into plain access.
> >
> > I presume the former.
>
> I think *including* it should be ok, because we have things like
> <asm/uaccess.h> - or your addition to <linux/fs.h> - that use it for
> core functionality that is then not supported for module use.
>
> Yeah, in a perfect world we'd have those things only in "internal"
> headers and people couldn't include them even by mistake, but that
> ends up being a pain.
>
> So I don't think your
>
> +#ifdef MODULE
> +#error "this functionality is not available for modules"
> +#endif
>
> model works, because I think it might be too painful to fix (but hey,
> maybe I'm wrong).
>

In my proposal the patch which messes with the namei cache address
would have the following in fs.h:
#ifndef MODULE
#include <asm/runtime-const.h>
#endif

As in, unless the kernel itself is being compiled, it would pretend
the runtime machinery does not even exist, which imo is preferable to
failing later at link time.

Then whatever functionality using runtime-const is straight up not
available and code insisting on providing something for modules anyway
is forced to provide an ifdefed implementation.

Ignoring the safety vs modules thing and back to the names_cachep
patch: the reported riscv build failure has proven problematic to fix.
Turns out mm.h includes mm_huge.h, which then includes fs.h(!). Adding
the runtime-const.h include into fs.h then results in compilation
failure on that platform as it depends on vmalloc-related symbols
which are only getting declared *after* fs.h gets included.

I tried to get rid of the fs.h inclusion in mm_huge.h, but that
uncovered a bunch of other build failures where code works only
because fs.h got sneaked in by someone else.

Given the level of bullshit here it may be it is just straight up
infeasible to include runtime-const.h in fs.h without major
rototoiling, which I'm not signing up for.

I wonder if it would make sense to bypass the problem by moving the
pathname handling routines to a different header -- might be useful in
its own right to slim down the kitchen sink that fs.h turned out to
be, but that's another bikeshed-y material.

I may end up just ditching this for the time being.

