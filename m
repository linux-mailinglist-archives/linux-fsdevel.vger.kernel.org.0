Return-Path: <linux-fsdevel+bounces-18964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BDA8BEFF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 00:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05281F235D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 22:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7467F476;
	Tue,  7 May 2024 22:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZI3TsfW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EF27C6CE;
	Tue,  7 May 2024 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122615; cv=none; b=dGkgt/4sOZIsguhUIhnrp1lKBMFxkDaRBfpd62mPptjL8900R8zsTqqbOZ+6CVIbd1WATpXdy2nDUgaiuV95riaAiMYpTJoh0Ul2d3B+Q9puL4zH3UQPGpLLAj2w4e1mixWI32UuFpp2oZCpGzilXllXGsTB9zDZ+h9Hcrw3bdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122615; c=relaxed/simple;
	bh=DB6CYs/TbJkmqwoHdEc+2KU22FBnkouhLCh1VKh1BZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMCw/mLDp2iE4kEd4U37jG4AzmSAgT5z6a58m2nLGm5B3DDhndpPJl6cpbmM2cNLU5Z8CTq6H57sFTZ8QlBQB8tjpe+7eCyuSiscifUmeiUZoAkcJgDgEy2YNc5UEj0yRsBW6eFhIqAJ0ylRV4Sp6P9q4hL9o/O9/dvvQEQimYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZI3TsfW; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b338460546so2813650a91.1;
        Tue, 07 May 2024 15:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715122613; x=1715727413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTnwlMlf1lxLsKUFf9+5oGGEtEWV0uSszkxhOIK2hYo=;
        b=dZI3TsfWaVoDvoxZjN6E5TOca8uE/2QNcdO/NdOZzFYfTjQjwMJboirZDXALBqIifm
         XRuvVYUy+9c2KIVtwER63sgzXoBSxp7vUEdSDQ5YY9iI6J6egBQcJe3+FaJEvwnZjBrV
         aSHF/JrRjswCwNxzf0eYqYBbdlpTgweiH55Kofw1xsM2qeMjTGszdMSR4UvDozssfukQ
         spYe1nqwwUbtFHEWIN6V1Ml9ks1bC58GzrMV5n4kJ6H9/Nb48qKQ4HqcIha1fWwehtAm
         bMgttaiFcVTI/nScwGAGOYIKCe+jCNL5z5IC9Qr9URVpR0H00bMmzUhlaQQk8neKeIqP
         R+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715122613; x=1715727413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTnwlMlf1lxLsKUFf9+5oGGEtEWV0uSszkxhOIK2hYo=;
        b=NMmQ4EuumuZoyIVaF3B5fgQ25FQewkXNXzc5MGFLFdoj8JJNnZCC3yFWgaBfSDSkoq
         HCdSvi6K+BMfZdL/B/ohDTUvfEv4RwOtnO3A0u/lcDh7W7r1gf6dLCOPDoU8pypH47dk
         HNEzfMJnoMVkYu5xU9zVEpufnV+utLyiv+B1TaNtcLRGT2WBqlrojcJQZlZquG/3cs/a
         loOsYt/Q1+2WCANoitvlX0NhKi6Aoq17ZFSSKFhZb1okTxnzD/rcCVM3GoFcTL2xSGtz
         aguhkKvChQ6QyjCGdH9gZ6elfB/N1Zx8QOEiuUq9K9uBg1UZoQKOvmOkLrsEonjman4S
         2Mrw==
X-Forwarded-Encrypted: i=1; AJvYcCUYOgDBgT1TXOqJWDnk1m7X2IcjsqeC29kEDjPVyR8Tn2DwYTsqYq65ZEi7yD+PHTGf69/QliTvQEuLrS8ZKATxT2ebu5SBz3BwqdC3JDPFlB73qus8H9yg8gZZaBOT+StRr7e6myZDC7/eQcyD6dEnG02MX1qHJBUB9RWvY9mITSXmBadt9/fsjfBGcfGRQ4ev6mxIuI/Phv/jJBCNbJdjuTI=
X-Gm-Message-State: AOJu0Yxdri5N4lT7KhXeZqW4X9BZkYqjbip2t8tdm1qZmxbvunt8mPQk
	CJAJsD7LkAHjPWyw/BjK9TdNdGUbIVpMaK0/8pmhYH9kjKISoNgHL2qR85SKPffWHtk0/0nwJTS
	YLDQGntCbS1+LQNTqLJSoSaNCGEE=
X-Google-Smtp-Source: AGHT+IFD2nGYIfCipzppGDiFEkV4+NiE2aSKDcClvItcMNd5qPoMJaIJZAfcZPUNRTtOmBzuB230k9rZWkU3ViIjutE=
X-Received: by 2002:a17:90a:fe06:b0:2a2:f284:5196 with SMTP id
 98e67ed59e1d1-2b616aeba34mr828573a91.45.1715122613323; Tue, 07 May 2024
 15:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-6-andrii@kernel.org>
 <2024050404-rectify-romp-4fdb@gregkh> <CAEf4BzaUgGJVqw_yWOXASHManHQWGQV905Bd-wiaHj-mRob9gw@mail.gmail.com>
 <CAP-5=fWPig8-CLLBJ_rb3D6eNAKVY7KX_n_HcpGqL7gfe-=XXg@mail.gmail.com>
 <CAEf4Bzab+sRQ8pzNYxh1BOgjhDF4yCkqcHxy5YZAyT-jef7Acw@mail.gmail.com>
 <CAP-5=fXv59EmyM7FNnwAp0JjAZjtYhCj3b3FTH7KsHL=k8C6oQ@mail.gmail.com>
 <CAEf4BzbdGJzMuRgGJE72VFquXL37rS9Ti__wx4f_+kt3yetkEg@mail.gmail.com>
 <CAEf4BzYykUsN_Z92cXAh_9+fmN-bzr7xOEBe2v_5xDoXRhijmg@mail.gmail.com> <CAM9d7cg4ErddXRXJWg7sAgSY=wzej8e4SO6NhsXJNDj69DyqCw@mail.gmail.com>
In-Reply-To: <CAM9d7cg4ErddXRXJWg7sAgSY=wzej8e4SO6NhsXJNDj69DyqCw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 15:56:40 -0700
Message-ID: <CAEf4BzZTRU9CGrcAysLKCCbjUvJZPFaLA122MVo_zKgk8pAUSA@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: a simple benchmark tool for
 /proc/<pid>/maps APIs
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 3:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, May 7, 2024 at 10:29=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, May 6, 2024 at 10:06=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, May 6, 2024 at 11:43=E2=80=AFAM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > On Mon, May 6, 2024 at 11:32=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Sat, May 4, 2024 at 10:09=E2=80=AFPM Ian Rogers <irogers@googl=
e.com> wrote:
> > > > > >
> > > > > > On Sat, May 4, 2024 at 2:57=E2=80=AFPM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > On Sat, May 4, 2024 at 8:29=E2=80=AFAM Greg KH <gregkh@linuxf=
oundation.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, May 03, 2024 at 05:30:06PM -0700, Andrii Nakryiko w=
rote:
> > > > > > > > > Implement a simple tool/benchmark for comparing address "=
resolution"
> > > > > > > > > logic based on textual /proc/<pid>/maps interface and new=
 binary
> > > > > > > > > ioctl-based PROCFS_PROCMAP_QUERY command.
> > > > > > > >
> > > > > > > > Of course an artificial benchmark of "read a whole file" vs=
. "a tiny
> > > > > > > > ioctl" is going to be different, but step back and show how=
 this is
> > > > > > > > going to be used in the real world overall.  Pounding on th=
is file is
> > > > > > > > not a normal operation, right?
> > > > > > > >
> > > > > > >
> > > > > > > It's not artificial at all. It's *exactly* what, say, blazesy=
m library
> > > > > > > is doing (see [0], it's Rust and part of the overall library =
API, I
> > > > > > > think C code in this patch is way easier to follow for someon=
e not
> > > > > > > familiar with implementation of blazesym, but both implementa=
tions are
> > > > > > > doing exactly the same sequence of steps). You can do it even=
 less
> > > > > > > efficiently by parsing the whole file, building an in-memory =
lookup
> > > > > > > table, then looking up addresses one by one. But that's even =
slower
> > > > > > > and more memory-hungry. So I didn't even bother implementing =
that, it
> > > > > > > would put /proc/<pid>/maps at even more disadvantage.
> > > > > > >
> > > > > > > Other applications that deal with stack traces (including per=
f) would
> > > > > > > be doing one of those two approaches, depending on circumstan=
ces and
> > > > > > > level of sophistication of code (and sensitivity to performan=
ce).
> > > > > >
> > > > > > The code in perf doing this is here:
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tree/tools/perf/util/synthetic-events.c#n440
> > > > > > The code is using the api/io.h code:
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tree/tools/lib/api/io.h
> > > > > > Using perf to profile perf it was observed time was spent alloc=
ating
> > > > > > buffers and locale related activities when using stdio, so io i=
s a
> > > > > > lighter weight alternative, albeit with more verbose code than =
fscanf.
> > > > > > You could add this as an alternate /proc/<pid>/maps reader, we =
have a
> > > > > > similar benchmark in `perf bench internals synthesize`.
> > > > > >
> > > > >
> > > > > If I add a new implementation using this ioctl() into
> > > > > perf_event__synthesize_mmap_events(), will it be tested from this
> > > > > `perf bench internals synthesize`? I'm not too familiar with perf=
 code
> > > > > organization, sorry if it's a stupid question. If not, where exac=
tly
> > > > > is the code that would be triggered from benchmark?
> > > >
> > > > Yes it would be triggered :-)
> > >
> > > Ok, I don't exactly know how to interpret the results (and what the
> > > benchmark is doing), but numbers don't seem to be worse. They actuall=
y
> > > seem to be a bit better.
> > >
> > > I pushed my code that adds perf integration to [0]. That commit has
> > > results, but I'll post them here (with invocation parameters).
> > > perf-ioctl is the version with ioctl()-based implementation,
> > > perf-parse is, logically, text-parsing version. Here are the results
> > > (and see my notes below the results as well):
> > >
> > > TEXT-BASED
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > # ./perf-parse bench internals synthesize
> > > # Running 'internals/synthesize' benchmark:
> > > Computing performance of single threaded perf event synthesis by
> > > synthesizing events on the perf process itself:
> > >   Average synthesis took: 80.311 usec (+- 0.077 usec)
> > >   Average num. events: 32.000 (+- 0.000)
> > >   Average time per event 2.510 usec
> > >   Average data synthesis took: 84.429 usec (+- 0.066 usec)
> > >   Average num. events: 179.000 (+- 0.000)
> > >   Average time per event 0.472 usec
> > >
> > > # ./perf-parse bench internals synthesize
> > > # Running 'internals/synthesize' benchmark:
> > > Computing performance of single threaded perf event synthesis by
> > > synthesizing events on the perf process itself:
> > >   Average synthesis took: 79.900 usec (+- 0.077 usec)
> > >   Average num. events: 32.000 (+- 0.000)
> > >   Average time per event 2.497 usec
> > >   Average data synthesis took: 84.832 usec (+- 0.074 usec)
> > >   Average num. events: 180.000 (+- 0.000)
> > >   Average time per event 0.471 usec
> > >
> > > # ./perf-parse bench internals synthesize --mt -M 8
> > > # Running 'internals/synthesize' benchmark:
> > > Computing performance of multi threaded perf event synthesis by
> > > synthesizing events on CPU 0:
> > >   Number of synthesis threads: 1
> > >     Average synthesis took: 36338.100 usec (+- 406.091 usec)
> > >     Average num. events: 14091.300 (+- 7.433)
> > >     Average time per event 2.579 usec
> > >   Number of synthesis threads: 2
> > >     Average synthesis took: 37071.200 usec (+- 746.498 usec)
> > >     Average num. events: 14085.900 (+- 1.900)
> > >     Average time per event 2.632 usec
> > >   Number of synthesis threads: 3
> > >     Average synthesis took: 33932.300 usec (+- 626.861 usec)
> > >     Average num. events: 14085.900 (+- 1.900)
> > >     Average time per event 2.409 usec
> > >   Number of synthesis threads: 4
> > >     Average synthesis took: 33822.700 usec (+- 506.290 usec)
> > >     Average num. events: 14099.200 (+- 8.761)
> > >     Average time per event 2.399 usec
> > >   Number of synthesis threads: 5
> > >     Average synthesis took: 33348.200 usec (+- 389.771 usec)
> > >     Average num. events: 14085.900 (+- 1.900)
> > >     Average time per event 2.367 usec
> > >   Number of synthesis threads: 6
> > >     Average synthesis took: 33269.600 usec (+- 350.341 usec)
> > >     Average num. events: 14084.000 (+- 0.000)
> > >     Average time per event 2.362 usec
> > >   Number of synthesis threads: 7
> > >     Average synthesis took: 32663.900 usec (+- 338.870 usec)
> > >     Average num. events: 14085.900 (+- 1.900)
> > >     Average time per event 2.319 usec
> > >   Number of synthesis threads: 8
> > >     Average synthesis took: 32748.400 usec (+- 285.450 usec)
> > >     Average num. events: 14085.900 (+- 1.900)
> > >     Average time per event 2.325 usec
> > >
> > > IOCTL-BASED
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > # ./perf-ioctl bench internals synthesize
> > > # Running 'internals/synthesize' benchmark:
> > > Computing performance of single threaded perf event synthesis by
> > > synthesizing events on the perf process itself:
> > >   Average synthesis took: 72.996 usec (+- 0.076 usec)
> > >   Average num. events: 31.000 (+- 0.000)
> > >   Average time per event 2.355 usec
> > >   Average data synthesis took: 79.067 usec (+- 0.074 usec)
> > >   Average num. events: 178.000 (+- 0.000)
> > >   Average time per event 0.444 usec
> > >
> > > # ./perf-ioctl bench internals synthesize
> > > # Running 'internals/synthesize' benchmark:
> > > Computing performance of single threaded perf event synthesis by
> > > synthesizing events on the perf process itself:
> > >   Average synthesis took: 73.921 usec (+- 0.073 usec)
> > >   Average num. events: 31.000 (+- 0.000)
> > >   Average time per event 2.385 usec
> > >   Average data synthesis took: 80.545 usec (+- 0.070 usec)
> > >   Average num. events: 178.000 (+- 0.000)
> > >   Average time per event 0.453 usec
> > >
> > > # ./perf-ioctl bench internals synthesize --mt -M 8
> > > # Running 'internals/synthesize' benchmark:
> > > Computing performance of multi threaded perf event synthesis by
> > > synthesizing events on CPU 0:
> > >   Number of synthesis threads: 1
> > >     Average synthesis took: 35609.500 usec (+- 428.576 usec)
> > >     Average num. events: 14040.700 (+- 1.700)
> > >     Average time per event 2.536 usec
> > >   Number of synthesis threads: 2
> > >     Average synthesis took: 34293.800 usec (+- 453.811 usec)
> > >     Average num. events: 14040.700 (+- 1.700)
> > >     Average time per event 2.442 usec
> > >   Number of synthesis threads: 3
> > >     Average synthesis took: 32385.200 usec (+- 363.106 usec)
> > >     Average num. events: 14040.700 (+- 1.700)
> > >     Average time per event 2.307 usec
> > >   Number of synthesis threads: 4
> > >     Average synthesis took: 33113.100 usec (+- 553.931 usec)
> > >     Average num. events: 14054.500 (+- 11.469)
> > >     Average time per event 2.356 usec
> > >   Number of synthesis threads: 5
> > >     Average synthesis took: 31600.600 usec (+- 297.349 usec)
> > >     Average num. events: 14012.500 (+- 4.590)
> > >     Average time per event 2.255 usec
> > >   Number of synthesis threads: 6
> > >     Average synthesis took: 32309.900 usec (+- 472.225 usec)
> > >     Average num. events: 14004.000 (+- 0.000)
> > >     Average time per event 2.307 usec
> > >   Number of synthesis threads: 7
> > >     Average synthesis took: 31400.100 usec (+- 206.261 usec)
> > >     Average num. events: 14004.800 (+- 0.800)
> > >     Average time per event 2.242 usec
> > >   Number of synthesis threads: 8
> > >     Average synthesis took: 31601.400 usec (+- 303.350 usec)
> > >     Average num. events: 14005.700 (+- 1.700)
> > >     Average time per event 2.256 usec
> > >
> > > I also double-checked (using strace) that it does what it is supposed
> > > to do, and it seems like everything checks out. Here's text-based
> > > strace log:
> > >
> > > openat(AT_FDCWD, "/proc/35876/task/35876/maps", O_RDONLY) =3D 3
> > > read(3, "00400000-0040c000 r--p 00000000 "..., 8192) =3D 3997
> > > read(3, "7f519d4d3000-7f519d516000 r--p 0"..., 8192) =3D 4025
> > > read(3, "7f519dc3d000-7f519dc44000 r-xp 0"..., 8192) =3D 4048
> > > read(3, "7f519dd2d000-7f519dd2f000 r--p 0"..., 8192) =3D 4017
> > > read(3, "7f519dff6000-7f519dff8000 r--p 0"..., 8192) =3D 2744
> > > read(3, "", 8192)                       =3D 0
> > > close(3)                                =3D 0
> > >
> > >
> > > BTW, note how the kernel doesn't serve more than 4KB of data, even
> > > though perf provides 8KB buffer (that's to Greg's question about
> > > optimizing using bigger buffers, I suspect without seq_file changes,
> > > it won't work).
> > >
> > > And here's an abbreviated log for ioctl version, it has lots more (bu=
t
> > > much faster) ioctl() syscalls, given it dumps everything:
> > >
> > > openat(AT_FDCWD, "/proc/36380/task/36380/maps", O_RDONLY) =3D 3
> > > ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50)=
 =3D 0
> > > ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50)=
 =3D 0
> > >
> > >  ... 195 ioctl() calls in total ...
> > >
> > > ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50)=
 =3D 0
> > > ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50)=
 =3D 0
> > > ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50)=
 =3D 0
> > > ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50)
> > > =3D -1 ENOENT (No such file or directory)
> > > close(3)                                =3D 0
> > >
> > >
> > > So, it's not the optimal usage of this API, and yet it's still better
> > > (or at least not worse) than text-based API.
>
> It's surprising that more ioctl is cheaper than less read and parse.

I encourage you to try this locally, just in case I missed something
([0]). But it does seem this way. I have mitigations and retpoline
off, so syscall switch is pretty fast (under 0.5 microsecond).

  [0] https://github.com/anakryiko/linux/tree/procfs-proc-maps-ioctl
>
> > >
> >
> > In another reply to Arnaldo on patch #2 I mentioned the idea of
> > allowing to iterate only file-backed VMAs (as it seems like what
> > symbolizers would only care about, but I might be wrong here). So I
>
> Yep, I think it's enough to get file-backed VMAs only.
>

Ok, I guess I'll keep this functionality for v2 then, it's a pretty
trivial extension to existing logic.

>
> > tried that quickly, given it's a trivial addition to my code. See
> > results below (it is slightly faster, but not much, because most of
> > VMAs in that benchmark seem to be indeed file-backed anyways), just
> > for completeness. I'm not sure if that would be useful/used by perf,
> > so please let me know.
>
> Thanks for doing this.  It'd be useful as it provides better synthesizing
> performance.  The startup latency of perf record is a problem, I need
> to take a look if it can be improved more.
>
> Thanks,
> Namhyung
>
>
> >
> > As I mentioned above, it's not radically faster in this perf
> > benchmark, because we still request about 170 VMAs (vs ~195 if we
> > iterate *all* of them), so not a big change. The ratio will vary
> > depending on what the process is doing, of course. Anyways, just for
> > completeness, I'm not sure if I have to add this "filter" to the
> > actual implementation.
> >
> > # ./perf-filebacked bench internals synthesize
> > # Running 'internals/synthesize' benchmark:
> > Computing performance of single threaded perf event synthesis by
> > synthesizing events on the perf process itself:
> >   Average synthesis took: 65.759 usec (+- 0.063 usec)
> >   Average num. events: 30.000 (+- 0.000)
> >   Average time per event 2.192 usec
> >   Average data synthesis took: 73.840 usec (+- 0.080 usec)
> >   Average num. events: 153.000 (+- 0.000)
> >   Average time per event 0.483 usec
> >
> > # ./perf-filebacked bench internals synthesize
> > # Running 'internals/synthesize' benchmark:
> > Computing performance of single threaded perf event synthesis by
> > synthesizing events on the perf process itself:
> >   Average synthesis took: 66.245 usec (+- 0.059 usec)
> >   Average num. events: 30.000 (+- 0.000)
> >   Average time per event 2.208 usec
> >   Average data synthesis took: 70.627 usec (+- 0.074 usec)
> >   Average num. events: 153.000 (+- 0.000)
> >   Average time per event 0.462 usec
> >
> > # ./perf-filebacked bench internals synthesize --mt -M 8
> > # Running 'internals/synthesize' benchmark:
> > Computing performance of multi threaded perf event synthesis by
> > synthesizing events on CPU 0:
> >   Number of synthesis threads: 1
> >     Average synthesis took: 33477.500 usec (+- 556.102 usec)
> >     Average num. events: 10125.700 (+- 1.620)
> >     Average time per event 3.306 usec
> >   Number of synthesis threads: 2
> >     Average synthesis took: 30473.700 usec (+- 221.933 usec)
> >     Average num. events: 10127.000 (+- 0.000)
> >     Average time per event 3.009 usec
> >   Number of synthesis threads: 3
> >     Average synthesis took: 29775.200 usec (+- 315.212 usec)
> >     Average num. events: 10128.700 (+- 0.667)
> >     Average time per event 2.940 usec
> >   Number of synthesis threads: 4
> >     Average synthesis took: 29477.100 usec (+- 621.258 usec)
> >     Average num. events: 10129.000 (+- 0.000)
> >     Average time per event 2.910 usec
> >   Number of synthesis threads: 5
> >     Average synthesis took: 29777.900 usec (+- 294.710 usec)
> >     Average num. events: 10144.700 (+- 11.597)
> >     Average time per event 2.935 usec
> >   Number of synthesis threads: 6
> >     Average synthesis took: 27774.700 usec (+- 357.569 usec)
> >     Average num. events: 10158.500 (+- 14.710)
> >     Average time per event 2.734 usec
> >   Number of synthesis threads: 7
> >     Average synthesis took: 27437.200 usec (+- 233.626 usec)
> >     Average num. events: 10135.700 (+- 2.700)
> >     Average time per event 2.707 usec
> >   Number of synthesis threads: 8
> >     Average synthesis took: 28784.600 usec (+- 477.630 usec)
> >     Average num. events: 10133.000 (+- 0.000)
> >     Average time per event 2.841 usec
> >
> > >   [0] https://github.com/anakryiko/linux/commit/0841fe675ed30f5605c5b=
228e18f5612ea253b35
> > >
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > > Thanks,
> > > > > > Ian
> > > > > >
> > > > > > >   [0] https://github.com/libbpf/blazesym/blob/ee9b48a80c0b449=
9118a1e8e5d901cddb2b33ab1/src/normalize/user.rs#L193
> > > > > > >
> > > > > > > > thanks,
> > > > > > > >
> > > > > > > > greg k-h
> > > > > > >
> >

