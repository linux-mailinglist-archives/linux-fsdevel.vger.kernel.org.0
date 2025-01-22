Return-Path: <linux-fsdevel+bounces-39822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED21A18C89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 08:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7DF3A40F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 07:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF371BBBE0;
	Wed, 22 Jan 2025 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANhyS+DL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D1F1A8F98
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737529503; cv=none; b=ljkgGQcawJQbHXX6607mTZinRgRFa+fnRycQRGRRa6QWu+sD6RSaBKLuTxSvXTGLrz3Dsi7rI3qC5nteAvSR1WlsuvwH8/c0c//2mjcbWDJ64a5PobaWOfEt6lUZgWLfSjL9EDMb17+wxVmQcZzYrp3qcx2tJsle/nzMJmEjp3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737529503; c=relaxed/simple;
	bh=SepRTFyzhEa+It8CZ55IbyNJXQWemUh+0llvd7Zi6CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfKKbXsOiwCJJwXy/plyrAvk+y6I39l6igtd9YbPogXt4miwTTxYVfFRARVjTwbidbn5/8fnU6fYlCK4mU6/dAh+e9H/p987x5/fw+maQ4mdQB+pSmzqjd9V3+VPKRJ8+RONzR1X/OGGpPWB4YDL3Q9ERGhIWoIoEJfRR64i+m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANhyS+DL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so12063785a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 23:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737529500; x=1738134300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SepRTFyzhEa+It8CZ55IbyNJXQWemUh+0llvd7Zi6CI=;
        b=ANhyS+DLQZlES5ALTMPeDnknUPLThcltt44iCAu4QNcWeQsYcGP6hPRn23uEKoy7yJ
         D6SFSPJidI7d/ngKbu/s58GW0x+HMu7jRnXbPJjc+1D7kJBC2Y9t/zN5SXkKj28N6pjb
         AeLc8OtxYSk0SJFhDhxHzLN7Ajs2qP1bIizIitLe3s436PNYkymx+Mz/n9c/FfAA6vaU
         1T+3fO4YCiFLGJo0rRAl47zUviEMdfvXe/2XK/zRv7w2erR4cW8/acVIGZpOx2H4Q3uC
         fuhS/zi8R+dz2SiDD6JQge3zGX9U3lgSAwAqdyUoa/zY0XUvgkIMjaryRgh5vnoce9cn
         y/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737529500; x=1738134300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SepRTFyzhEa+It8CZ55IbyNJXQWemUh+0llvd7Zi6CI=;
        b=fsoEcUMsGwP0scEpuytudhyucDf3mSmaoVCacJKo1YDleBC4RqI3Gt/Eq2sBTf+9vS
         3r7don+6su4KJmLhqnPP/Nb/fUl9CiycDTbEEqFWPfQ8XnrrvSH+bt8WoNoiidTyn4e/
         LrigAH/U66Ve/VZdYpIF/ED6asGofGFZtN9fk8Pqa0g61tWeUqRLWHDJF+l3CGrMVrgp
         muNvtBREDKlH78UJIH0fdxURQTCFXKgf6Ht4cmLVu1ECfp3YCdXVlH0IZpz9IxjqODDc
         BHXuSZpGCOSnpRlbDqWLFr6TkHhwPwYsqVN73p/oVO3TzevIQ9Z73HL7jUioOyPylu1E
         QEKw==
X-Gm-Message-State: AOJu0Ywh0B8A3rQaTTp8ncNZ5MWIe3gcSkpv/0P561n3SuXWBJcTuCr3
	r1zzl0/XCbvRUTSfLqrXLsKYPHQa/aikRzntsOkY3Nn8CDvgpw0P+H/IjS5/NCa++WRbsUq7G35
	ADZEmJ87v3Sf0AcrjfhhzUvjCJrc=
X-Gm-Gg: ASbGncsMcWH6BqHVX0ubmxDLj1I7ht70Rd/fKlxK18zoUQwvpKJkiqGTlj0sHN2+vJ2
	7vthLC7RdhSNg7hOmM7RelUe8F19vGQvawNE/PEBzW1SSoo7inao=
X-Google-Smtp-Source: AGHT+IHjg/kawkl0Vw3fEvxTPLLPr2rtHnl1MvpsWv/jSMd6+wa7L5JgxZ4vRCPwQHOzx12XTAx7ymOks9heap38OAw=
X-Received: by 2002:a05:6402:2554:b0:5d9:f8d3:6e6b with SMTP id
 4fb4d7f45d1cf-5db7d3550e0mr18058115a12.22.1737529499338; Tue, 21 Jan 2025
 23:04:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPbsSE6vngGRM6UvKT3kvWpZmj2eg7yXUMu6Ow5PykdC7s7dBQ@mail.gmail.com>
 <dnoyvsmdp7o6vgolrehhogqdki2rwj5fl3jmxh632kifbej6wc@5tzkshyj4rd5> <CAPbsSE5xJNVrqNugqD7Ox8FxT28kK49SBDFiRN84Dcn=DWzP9w@mail.gmail.com>
In-Reply-To: <CAPbsSE5xJNVrqNugqD7Ox8FxT28kK49SBDFiRN84Dcn=DWzP9w@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 22 Jan 2025 08:04:47 +0100
X-Gm-Features: AbW1kvbah3aRmS09JNdvIL_5kocqT_VAqGenRo7oYLmgF3SnsEwNQb126Yzxzpo
Message-ID: <CAGudoHHWhUOcBNUu8WboxGFrb7nyBuRCruJ6=xT5DPaJ_xyd=A@mail.gmail.com>
Subject: Re: Mutex free Pipes
To: Nick Renner <nr2185@nyu.edu>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 3:27=E2=80=AFAM Nick Renner <nr2185@nyu.edu> wrote:
>
> On Tue, Jan 21, 2025 at 3:34=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> > Most of the time when something was done it is either because it's a ba=
d
> > idea or (more likely) nobody sat down to do it.
> Ok thanks for this. Realistically seeing if theres a real answer here
> was the main hope of my post, but I'm assuming you're probably correct
> here.
>

Whether things work out or not I definitely encourage you to keep digging.

Worst case scenario you had some fun, best case you made pipes on Linux fas=
ter.

> My understanding of kfifo is that read and write operations have to be
> locked at their respective end when there is more than one reader or
> writer, but the data structure doesn't have to be globally locked.
> This could be accomplished with spinlocks for both ends similar to use
> in kfifo_in_spinlocked etc. Pipes already keep track of the number of
> readers or writers, and could use the non-spinlocked path in SPSC
> situations. My assumption is that a majority of pipe usage is in SPSC
> situations so allowing for this much faster version seems desirable.
>

I was under the mistaken assumption you were looking to make this
fully lockless (because of "mutex free") and then I made a poor job
commenting.

So let me try to straighten this out.

I can confirm:
1. you can make a fifo work with respective locks for readers and writers.
2. vast majority of the time there is at most one thread writing and
one thread reading.

On top of that I can also confirm that contention on the mutex is a
significant part of the overhead.

Thus patching it up is most welcome.

So where is the "but"?

First a short remark that apart from what happens when there is both a
reader and a writer active at the same time, in the current code there
is a significant performance loss from single-threaded standpoint. I
poked around some months back, there are things which can be done to
reduce the total overhead and lock hold time (and thus contention)
while retaining the current scheme. The crux being whatever the rework
it must not be slower single-threaded, and it preferably be faster.

Now to the point: in contrast to a regular fifo, the area backing the
total capacity of the pipe is not necessarily fully allocated -- it is
being backed by page-sized buffers allocated and freed as needed.

I think the default capacity is 64K. Only ever using what's needed
(rounded up to a multiple of page size) saves memory for most pipes
and I presume this property will have to stay.

Sample problem this poses for the lockless approach: after finishing
up a buffer, the reader will need to free it, but this needs to be
synchronized against a writer which may just happen to have started
writing there.

It may be there is a trivial solution which does not partially defeat
the point and slow down single-threaded operation, but as is I don't
see it (but then again I did not seriously dig into it).

This is not the entire story (and I'm not an expert on Linux pipes),
but hopefully showcases the gist of the problem as I see it.

That said, per what I mentioned above, drilling here is warranted for
sure, I'm just not at all confident the proposed approach will do the
trick.

Good luck & have fun :)
--=20
Mateusz Guzik <mjguzik gmail.com>

