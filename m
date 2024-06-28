Return-Path: <linux-fsdevel+bounces-22801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D55891C96D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 01:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300BD1C2283B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 23:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FC7824A1;
	Fri, 28 Jun 2024 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHMml38v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E30626CB;
	Fri, 28 Jun 2024 23:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719615841; cv=none; b=lIkgHIu7uI8gbL/N7+fJxEYIgjcMSdz+Z+OOg1DOrFq1RAtqj827jpSDzbklxubn9A+LHlLuxn31+l/OD3J4XtDCx5RUOXQqREhvaIypwlUGbs0PWlnpc5XAmfLzbp9ovbag4hXs/frRyKL00eS7hGVH2KRV9W65gYjP4RsK2N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719615841; c=relaxed/simple;
	bh=wZfauyp79Jdmtph/xEdmahuQwGRjmdF6s7bdzha4HeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9OTqxhch4ekARsSoEUuX9k/SaNiaIePYVzS+0yLr5Z0MoXh2rroCqs/HOU0Py1iAuWKMbxTKG0IdVUQ1Um79Uv+yqAD98x7QppjR+PoOLlEQY5YKyTeb4/pUyiWLdpLfih8QUh0R934sluiAffwQkv8jdBx4uxMlpwFMJBwgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHMml38v; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c927152b4bso794829a91.2;
        Fri, 28 Jun 2024 16:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719615839; x=1720220639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZfauyp79Jdmtph/xEdmahuQwGRjmdF6s7bdzha4HeE=;
        b=nHMml38vSx6sGryhOqsVXkGfFt4rkE5m+6z6LWGYrJGMug5GHcf2j3BRGgx5oxMkm6
         7aSQS7YPpVisoK2Rdzt2P+G9Qi5EEq+2PgbF3Y9IMEAndC+dM9gclXTBUcX49RWC8xZv
         Fh/GbdC72OVn+zk2OvuycYJgUWdzzn7RioF9Dp2VSqOXSAGzp982WepO9mObZMw/7j9i
         sDQUJw2vz63E9macAlXiR/SgTFD4gTnKDHfxU7eW1trLzUJU2jkPlXQjrC2iWTRexbY9
         rUZPkWECbBAmOERPZVVkMs6RVUW9dTzR0O4gy0DmxsvwmKFgqbmIYW4nNFp3wt8EfHoO
         t8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719615839; x=1720220639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZfauyp79Jdmtph/xEdmahuQwGRjmdF6s7bdzha4HeE=;
        b=Nfmf74qNCwnlVd7S1KmgixzvtRoHI7CVT68kruNTv3PNOvX55VLYNHbgeO1/lT5PQ9
         bVNafNoZOlmL4b86M/BnAhSLOjraUgPe7rj6xLmhV4RBcyJS6ArRHE687JdDH+lt2Cp1
         k+1lOoQ7EeorhcdSL0bIJO+LoRtNfJY7YkbAjroUDV7bJJEzBvHMiDc1Fa730priKvfL
         uSfJnmc1xrIspPkXqgQPMsFCYup5hLUIccCWPkqRrvwABBPm8s65dUBV7bqsceuS8gaC
         AXgxWlN4JimU3B8TjiYXzOKsePVxu0Id32Lx60fYjTPPi8C417BllGBS7HyNeUR0Qz3c
         ef6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/ZXHwbsv7Srk3FCezlYAeV3n1R4BQRD5jFB54SItnplIOFLtxK5a87opazp7saPWE2URg8ilNDAyiYChZRHK5qUb8ftoiiNLJl9WU5tbB/3cuc1HYU07HsQqHOBBQ/oBIKqAgEG/J5aEYsSORTWBY6PqSUSSIwQMS6UX5Y3ETNA==
X-Gm-Message-State: AOJu0YzabO4l8fsUwk6GGPxYIFLeLO1KRjqsl9RpEiweURyPPMuXiC/G
	Q0C3lJeX4WnxDwLb5OylFkSc+IvkIMIVPp540slP5K4naFVb3wcS64ojxo8d00LIlWTu28ww7V+
	oRUw3G0rv82xl8oWiuYLwhodWEiQ=
X-Google-Smtp-Source: AGHT+IGQJATCcwut6IdbTB0yrcfOAh393EyBxn430jIUYzX/w6k1wH1j5dkfojeHwptNnJVG2CWfMoITxzCs1HlsK64=
X-Received: by 2002:a17:90a:7447:b0:2c7:aba6:d32f with SMTP id
 98e67ed59e1d1-2c861267638mr16266664a91.22.1719615839179; Fri, 28 Jun 2024
 16:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627170900.1672542-1-andrii@kernel.org> <20240627170900.1672542-4-andrii@kernel.org>
 <878qyqyorq.fsf@linux.intel.com> <CAEf4BzZHOhruFGinsRoPLtOsCzbEJyf2hSW=-F67hEHhvAsNZQ@mail.gmail.com>
 <Zn86IUVaFh7rqS2I@tassilo>
In-Reply-To: <Zn86IUVaFh7rqS2I@tassilo>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Jun 2024 16:03:47 -0700
Message-ID: <CAEf4Bzb3CnCKZi-kZ21F=qM0BHvJnexgajP0mHanRfEOzzES6A@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] fs/procfs: add build ID fetching to PROCMAP_QUERY API
To: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com, 
	rppt@kernel.org, adobriyan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 3:33=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> > Yep, makes sense. I'm currently reworking this whole lib/buildid.c
> > implementation to remove all the restrictions on data being in the
> > first page only, and making it work in a faultable context more
> > reliably. I can audit the code for TOCTOU issues and incorporate your
> > feedback. I'll probably post the patch set next week, will cc you as
> > well.
>
> Please also add checks that the mapping is executable, to
> close the obscure "can check the first 4 bytes of every mapped
> file is ELF\0" hole.
>
> But it will still need the hardening because mappings from
> ld.so are not EBUSY for writes.

I'm a bit confused. Two things:

1) non-executable file-backed VMA still has build ID associated with
it. Note, build ID is extracted from the backing file's content, not
from VMA itself. The part of ELF file that contains build ID isn't
necessarily mmap()'ed at all

2) What sort of exploitation are we talking about here? it's not
enough for backing file to have correct 4 starting bytes (0x7f"ELF"),
we still have to find correct PT_NOTE segment, and .note.gnu.build-id
section within it, that has correct type (3) and key name "GNU".

I'm trying to understand what we are protecting against here.
Especially that opening /proc/<pid>/maps already requires
PTRACE_MODE_READ permissions anyways (or pid should be self).

>
> -Andi

