Return-Path: <linux-fsdevel+bounces-18853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8558BD4A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 20:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500FB1C21782
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102FA158A33;
	Mon,  6 May 2024 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEl2qo+L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284E98494;
	Mon,  6 May 2024 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715020369; cv=none; b=UgS80VrlrRASO0Wg27rVvssNvZVmBomDoSjmmCX+EiPIliVJTMzK2e5Z1teaB4K8oTgXdlIrtJ7P7S5bBhLWq1xd6hBozKg7H0r6VD6+P4AGT4Q3ZEV0Gme9cy1sOY3RV+lnJrqK09YZMVFhs7se82qxzvA7sqyjAvlsU/cRNgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715020369; c=relaxed/simple;
	bh=zK0tJtE8Qwifs0bj8uWzm4v/Ta1W+47RyvVvaGZ/ylE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ij+GlWgyFMw/FK3LXIRATOeJZWgA1xWibV41l/xVU0D4NQTNrconh+8oOIDppk4OWPdLcstx8+f2un0gQYXoQ5Qb2jxUabsdprUZ7NwhUGndKK3OmiF8Nsc3tuD+Oiv3MZTMIxgXw8bnrRU9PnMmKzho37AtQPj+cv+e01lxteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEl2qo+L; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so2117511b3a.2;
        Mon, 06 May 2024 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715020367; x=1715625167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCnGUjyDFMi8EW+NvbJBnt5l36BUMcYyNMVKvBRKCsU=;
        b=jEl2qo+L4uSDAB1DQBEZgYRLl/FaHY26xlIxkdziPx9sAjb8EQ5h4L3Dde1kmA05ji
         6YczsfiWkFWTEOG9BYFJRdE4r6FMAtRQgI7dnmXSGsIs5dev+/w0a95TuH+GlPPK54OM
         SxpvNXdT4gjl00P2F/mVT31AunjEUmEOm0M+74XzHosos9BrvOaM+f5ixKR0p8vEiw80
         xvETlBy+2vI1HottnVbkdoBcNBCZ4tqp0xkDyEPVb2M2fOMr9YzsugvO8pT0R6UQYaih
         h2QtzMU3xomvA70uqGZQq5HvJiPJ46TUwRWLfo0PCtxENR4OItVQiiyvVehdg1WlgVUa
         Cb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715020367; x=1715625167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCnGUjyDFMi8EW+NvbJBnt5l36BUMcYyNMVKvBRKCsU=;
        b=aYx22eI3Tp9O8wHYEwLPCQKOLlx5xVbtrM+HP1YUiRT5fw03wGuTWVHIYPSduMAmnN
         6TD6W1G9X1l8z1cJJEHdms1A204RaAPBFPTPOnP14hLzTCVZ9Mi07J0FnUwD77fR4MDA
         4MxjH+5hSdd5yIjheJUglM5mBGzrmcC0VkmQqSioaUL13zbJU5pZpaWmH/DdqITJLjcS
         Uv+6UrRraWLzXcNfX2pZCHDM2fIcDVjRLqRWb7ONmxEjOUHqWEXfj1NVRT+MRqx3ZbU5
         owkX8DKDrTqAQTOsWbY7jZGfBeM4LJI8dyShqQhTzIBKPcb/ukiT/f8LcFEj4pdyF0pt
         cXTw==
X-Forwarded-Encrypted: i=1; AJvYcCVbN2u5vD+9bCCIdNjae+J66MjSUHvRGORf6TXSWyAnZyOTpOWKneXlbT11lv/0bgBur2YCA/BtzLIBnZNkeiohFUX9bfvF5AF0pqijOOYo/y6NRSMZZaEL1M0nN1sW8XfuzRcBFyvqFOHTcx67zktK8trxXXU0ELyMFLRcWThI5s1diLRs9Su+nSL6Y06FHvpzOyRi2Ujy0UvmCGrUR82odDI=
X-Gm-Message-State: AOJu0YyEsZZBwa4PWm2CKG7dA3oPqgu4Ge4fXAKmFvPE9wJzxiWBSqp6
	AtMi+RDgZ6Ex1V/TsDKzEnnkNJPuD8W1Vs7AEwXliq0FUU8QQUcL0iGOO9236uhAEVfX4ky6DsC
	48chFVfW24/VFMzb2h8lkNmbOqTbZEK+I
X-Google-Smtp-Source: AGHT+IG3j78+ZZWbY8RuPjt4sUUymX2YmHn1yU88bJqyP4vfirxgCWiddw4JNF/BoBb32TkkOsr9N5Jk9j0lstDSQ7I=
X-Received: by 2002:a05:6a20:43ac:b0:1af:66aa:783f with SMTP id
 i44-20020a056a2043ac00b001af66aa783fmr14502635pzl.30.1715020367293; Mon, 06
 May 2024 11:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-6-andrii@kernel.org>
 <2024050404-rectify-romp-4fdb@gregkh> <CAEf4BzaUgGJVqw_yWOXASHManHQWGQV905Bd-wiaHj-mRob9gw@mail.gmail.com>
 <CAP-5=fWPig8-CLLBJ_rb3D6eNAKVY7KX_n_HcpGqL7gfe-=XXg@mail.gmail.com>
In-Reply-To: <CAP-5=fWPig8-CLLBJ_rb3D6eNAKVY7KX_n_HcpGqL7gfe-=XXg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 May 2024 11:32:35 -0700
Message-ID: <CAEf4Bzab+sRQ8pzNYxh1BOgjhDF4yCkqcHxy5YZAyT-jef7Acw@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: a simple benchmark tool for
 /proc/<pid>/maps APIs
To: Ian Rogers <irogers@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 10:09=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Sat, May 4, 2024 at 2:57=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, May 4, 2024 at 8:29=E2=80=AFAM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Fri, May 03, 2024 at 05:30:06PM -0700, Andrii Nakryiko wrote:
> > > > Implement a simple tool/benchmark for comparing address "resolution=
"
> > > > logic based on textual /proc/<pid>/maps interface and new binary
> > > > ioctl-based PROCFS_PROCMAP_QUERY command.
> > >
> > > Of course an artificial benchmark of "read a whole file" vs. "a tiny
> > > ioctl" is going to be different, but step back and show how this is
> > > going to be used in the real world overall.  Pounding on this file is
> > > not a normal operation, right?
> > >
> >
> > It's not artificial at all. It's *exactly* what, say, blazesym library
> > is doing (see [0], it's Rust and part of the overall library API, I
> > think C code in this patch is way easier to follow for someone not
> > familiar with implementation of blazesym, but both implementations are
> > doing exactly the same sequence of steps). You can do it even less
> > efficiently by parsing the whole file, building an in-memory lookup
> > table, then looking up addresses one by one. But that's even slower
> > and more memory-hungry. So I didn't even bother implementing that, it
> > would put /proc/<pid>/maps at even more disadvantage.
> >
> > Other applications that deal with stack traces (including perf) would
> > be doing one of those two approaches, depending on circumstances and
> > level of sophistication of code (and sensitivity to performance).
>
> The code in perf doing this is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/perf/util/synthetic-events.c#n440
> The code is using the api/io.h code:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/lib/api/io.h
> Using perf to profile perf it was observed time was spent allocating
> buffers and locale related activities when using stdio, so io is a
> lighter weight alternative, albeit with more verbose code than fscanf.
> You could add this as an alternate /proc/<pid>/maps reader, we have a
> similar benchmark in `perf bench internals synthesize`.
>

If I add a new implementation using this ioctl() into
perf_event__synthesize_mmap_events(), will it be tested from this
`perf bench internals synthesize`? I'm not too familiar with perf code
organization, sorry if it's a stupid question. If not, where exactly
is the code that would be triggered from benchmark?

> Thanks,
> Ian
>
> >   [0] https://github.com/libbpf/blazesym/blob/ee9b48a80c0b4499118a1e8e5=
d901cddb2b33ab1/src/normalize/user.rs#L193
> >
> > > thanks,
> > >
> > > greg k-h
> >

