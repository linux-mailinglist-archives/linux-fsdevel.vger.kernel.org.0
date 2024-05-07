Return-Path: <linux-fsdevel+bounces-18933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A368BEA8F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 19:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD11B228F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F19716C845;
	Tue,  7 May 2024 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0S248o8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E252FE570;
	Tue,  7 May 2024 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102966; cv=none; b=bKOADHRMcq5eu8csC2kWspXe0zs7yV9GByimna1/HeD+i9OWWS12vSCjPOKx602goDZDX+Bn2fh04n1eTbEx6zL079Ofj5fTwo+gDmtbklss3lLvgX0hh4e++tTsV63UL/Yzw61sYhqTbkpcwULxkyeLKlc4Gyid1/KJat2M7b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102966; c=relaxed/simple;
	bh=KzuPLDxblRhUgWu+o7vgcddTvikSweClUNGQqmHG6HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIPEiJFmRKpKRlBwOsQ9gNyIFYQ+0/S5DzJayRKfo3UFq0FUDkhGfGubbPEUAwmrs5cnffpRAHCxISgcL+lxfPmKUD1pSN55yKq9bDjY09dK7vVqXSdbeoZF/8Psi5Ba1pynzCK+vvD6WArTtsxPybsEPbleVw3PSdHW7tf8INM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0S248o8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ed0abbf706so23793285ad.2;
        Tue, 07 May 2024 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715102964; x=1715707764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDZ21BfhcAiLJodQpjNC/6yMxF3ELBdQ20+IdAkrnMs=;
        b=f0S248o8UneBtITuD4W0gmCstCm9rzwXoLqAvPYKoFmGia/rspGfGGsalO/UE32zNe
         aWgRRhySV+D/xB8D9ylZ90bS1yPjPV5mPED5pKLc8V4ew0aed9dpiPrUPPbpk13sh+w5
         8q9kdV51yPte/K9vDOsZhPkwvdjgM0sJvuCqp98C53G1h4+WuD5AeWXQ0Ix+y3zm84J9
         N8OgbT3Fj+A6QNlplKrO4HLVDjAn8/RhPSDAf3OsHk2BCjpDNMTCWLnmmbWXtRoYYx1F
         ECaVTPmeRHeNu5Fv/U5ltnYm/eqJ5hg1rZ4Qign49AU3/aMYDZHBQ9imLO3a2q7/Yw5y
         beCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715102964; x=1715707764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDZ21BfhcAiLJodQpjNC/6yMxF3ELBdQ20+IdAkrnMs=;
        b=OUZDqQy6cpoNTV9BikhVyCPTDHiWwFq4c32DOYq4H6X7aWvEm2WdBR9XEn+Y14OnH1
         EbMwHdh6oXS+yLeWn9xsfsFby+QcZuXOASTdP1VvtsE0eq3PKw9ueoXRvcWTj+JWFiF+
         xNeKGuVeHsA5n3qKpGmlYhwPvkyv5H4KN50+pS7wmvEk0KgjePffGUGdoo6BvbeJ6xON
         ubLVELXEe3VBQpzYV8aUZL8r8uhhOBlRlarqVi/0K2YIMWS9MwozjXknl2z0hyTDA9SR
         mkibpSaxtB+LpcT2IM5QlGqYDs/SfqfTBYwR0yYUulCwjyzaxczwmEy2RoCyntgpV3Yg
         w4QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd5VTD8fg1mbtycQcehos2PKAxHwGzIw0jiPjgzY4H03IGCyw4gk3Tnf20YL91lNxuvai+2ZBsXFOkdDQU9kKn2bJlCKr18kcfHo95cyNqGcIrIKSL30Zibvw5uRAX07pt0wdjzT2jFCdljQ+NG2hR1j/YltZGADH4ptrgfmIDl4UkNF9Oq7Ujml16/AQqjyr0jljDI9ac1uYcQTYZuqIC4x0=
X-Gm-Message-State: AOJu0YzVUtyIsPmieml8anT5W6pTOYdCLQ7tOKlLnLRBDHRFoj8Qft+/
	BT8/A5uMA9sIbAGEwYEEbF8NUYqoIpa2ZaRMN0HAQoVvBn494Gje+lXJQhjl/KJHiNvcZWtYE3p
	QecWuA49cFIWu3dDyrXODhsV9qRY=
X-Google-Smtp-Source: AGHT+IHUyaZnlpJw7nJ4YjUhgV2JhTbjZvtjSBxEMvt+FIIIYjTcMP8F76B4Efs97DgOKIKE6zAI2tAIf1wA1Fy747o=
X-Received: by 2002:a17:90a:588a:b0:2b3:28df:96b1 with SMTP id
 98e67ed59e1d1-2b61639ffb6mr268408a91.7.1715102964093; Tue, 07 May 2024
 10:29:24 -0700 (PDT)
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
 <CAP-5=fXv59EmyM7FNnwAp0JjAZjtYhCj3b3FTH7KsHL=k8C6oQ@mail.gmail.com> <CAEf4BzbdGJzMuRgGJE72VFquXL37rS9Ti__wx4f_+kt3yetkEg@mail.gmail.com>
In-Reply-To: <CAEf4BzbdGJzMuRgGJE72VFquXL37rS9Ti__wx4f_+kt3yetkEg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 10:29:11 -0700
Message-ID: <CAEf4BzYykUsN_Z92cXAh_9+fmN-bzr7xOEBe2v_5xDoXRhijmg@mail.gmail.com>
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

On Mon, May 6, 2024 at 10:06=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 6, 2024 at 11:43=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Mon, May 6, 2024 at 11:32=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sat, May 4, 2024 at 10:09=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > On Sat, May 4, 2024 at 2:57=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Sat, May 4, 2024 at 8:29=E2=80=AFAM Greg KH <gregkh@linuxfound=
ation.org> wrote:
> > > > > >
> > > > > > On Fri, May 03, 2024 at 05:30:06PM -0700, Andrii Nakryiko wrote=
:
> > > > > > > Implement a simple tool/benchmark for comparing address "reso=
lution"
> > > > > > > logic based on textual /proc/<pid>/maps interface and new bin=
ary
> > > > > > > ioctl-based PROCFS_PROCMAP_QUERY command.
> > > > > >
> > > > > > Of course an artificial benchmark of "read a whole file" vs. "a=
 tiny
> > > > > > ioctl" is going to be different, but step back and show how thi=
s is
> > > > > > going to be used in the real world overall.  Pounding on this f=
ile is
> > > > > > not a normal operation, right?
> > > > > >
> > > > >
> > > > > It's not artificial at all. It's *exactly* what, say, blazesym li=
brary
> > > > > is doing (see [0], it's Rust and part of the overall library API,=
 I
> > > > > think C code in this patch is way easier to follow for someone no=
t
> > > > > familiar with implementation of blazesym, but both implementation=
s are
> > > > > doing exactly the same sequence of steps). You can do it even les=
s
> > > > > efficiently by parsing the whole file, building an in-memory look=
up
> > > > > table, then looking up addresses one by one. But that's even slow=
er
> > > > > and more memory-hungry. So I didn't even bother implementing that=
, it
> > > > > would put /proc/<pid>/maps at even more disadvantage.
> > > > >
> > > > > Other applications that deal with stack traces (including perf) w=
ould
> > > > > be doing one of those two approaches, depending on circumstances =
and
> > > > > level of sophistication of code (and sensitivity to performance).
> > > >
> > > > The code in perf doing this is here:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/tools/perf/util/synthetic-events.c#n440
> > > > The code is using the api/io.h code:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/tools/lib/api/io.h
> > > > Using perf to profile perf it was observed time was spent allocatin=
g
> > > > buffers and locale related activities when using stdio, so io is a
> > > > lighter weight alternative, albeit with more verbose code than fsca=
nf.
> > > > You could add this as an alternate /proc/<pid>/maps reader, we have=
 a
> > > > similar benchmark in `perf bench internals synthesize`.
> > > >
> > >
> > > If I add a new implementation using this ioctl() into
> > > perf_event__synthesize_mmap_events(), will it be tested from this
> > > `perf bench internals synthesize`? I'm not too familiar with perf cod=
e
> > > organization, sorry if it's a stupid question. If not, where exactly
> > > is the code that would be triggered from benchmark?
> >
> > Yes it would be triggered :-)
>
> Ok, I don't exactly know how to interpret the results (and what the
> benchmark is doing), but numbers don't seem to be worse. They actually
> seem to be a bit better.
>
> I pushed my code that adds perf integration to [0]. That commit has
> results, but I'll post them here (with invocation parameters).
> perf-ioctl is the version with ioctl()-based implementation,
> perf-parse is, logically, text-parsing version. Here are the results
> (and see my notes below the results as well):
>
> TEXT-BASED
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> # ./perf-parse bench internals synthesize
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 80.311 usec (+- 0.077 usec)
>   Average num. events: 32.000 (+- 0.000)
>   Average time per event 2.510 usec
>   Average data synthesis took: 84.429 usec (+- 0.066 usec)
>   Average num. events: 179.000 (+- 0.000)
>   Average time per event 0.472 usec
>
> # ./perf-parse bench internals synthesize
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 79.900 usec (+- 0.077 usec)
>   Average num. events: 32.000 (+- 0.000)
>   Average time per event 2.497 usec
>   Average data synthesis took: 84.832 usec (+- 0.074 usec)
>   Average num. events: 180.000 (+- 0.000)
>   Average time per event 0.471 usec
>
> # ./perf-parse bench internals synthesize --mt -M 8
> # Running 'internals/synthesize' benchmark:
> Computing performance of multi threaded perf event synthesis by
> synthesizing events on CPU 0:
>   Number of synthesis threads: 1
>     Average synthesis took: 36338.100 usec (+- 406.091 usec)
>     Average num. events: 14091.300 (+- 7.433)
>     Average time per event 2.579 usec
>   Number of synthesis threads: 2
>     Average synthesis took: 37071.200 usec (+- 746.498 usec)
>     Average num. events: 14085.900 (+- 1.900)
>     Average time per event 2.632 usec
>   Number of synthesis threads: 3
>     Average synthesis took: 33932.300 usec (+- 626.861 usec)
>     Average num. events: 14085.900 (+- 1.900)
>     Average time per event 2.409 usec
>   Number of synthesis threads: 4
>     Average synthesis took: 33822.700 usec (+- 506.290 usec)
>     Average num. events: 14099.200 (+- 8.761)
>     Average time per event 2.399 usec
>   Number of synthesis threads: 5
>     Average synthesis took: 33348.200 usec (+- 389.771 usec)
>     Average num. events: 14085.900 (+- 1.900)
>     Average time per event 2.367 usec
>   Number of synthesis threads: 6
>     Average synthesis took: 33269.600 usec (+- 350.341 usec)
>     Average num. events: 14084.000 (+- 0.000)
>     Average time per event 2.362 usec
>   Number of synthesis threads: 7
>     Average synthesis took: 32663.900 usec (+- 338.870 usec)
>     Average num. events: 14085.900 (+- 1.900)
>     Average time per event 2.319 usec
>   Number of synthesis threads: 8
>     Average synthesis took: 32748.400 usec (+- 285.450 usec)
>     Average num. events: 14085.900 (+- 1.900)
>     Average time per event 2.325 usec
>
> IOCTL-BASED
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> # ./perf-ioctl bench internals synthesize
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 72.996 usec (+- 0.076 usec)
>   Average num. events: 31.000 (+- 0.000)
>   Average time per event 2.355 usec
>   Average data synthesis took: 79.067 usec (+- 0.074 usec)
>   Average num. events: 178.000 (+- 0.000)
>   Average time per event 0.444 usec
>
> # ./perf-ioctl bench internals synthesize
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 73.921 usec (+- 0.073 usec)
>   Average num. events: 31.000 (+- 0.000)
>   Average time per event 2.385 usec
>   Average data synthesis took: 80.545 usec (+- 0.070 usec)
>   Average num. events: 178.000 (+- 0.000)
>   Average time per event 0.453 usec
>
> # ./perf-ioctl bench internals synthesize --mt -M 8
> # Running 'internals/synthesize' benchmark:
> Computing performance of multi threaded perf event synthesis by
> synthesizing events on CPU 0:
>   Number of synthesis threads: 1
>     Average synthesis took: 35609.500 usec (+- 428.576 usec)
>     Average num. events: 14040.700 (+- 1.700)
>     Average time per event 2.536 usec
>   Number of synthesis threads: 2
>     Average synthesis took: 34293.800 usec (+- 453.811 usec)
>     Average num. events: 14040.700 (+- 1.700)
>     Average time per event 2.442 usec
>   Number of synthesis threads: 3
>     Average synthesis took: 32385.200 usec (+- 363.106 usec)
>     Average num. events: 14040.700 (+- 1.700)
>     Average time per event 2.307 usec
>   Number of synthesis threads: 4
>     Average synthesis took: 33113.100 usec (+- 553.931 usec)
>     Average num. events: 14054.500 (+- 11.469)
>     Average time per event 2.356 usec
>   Number of synthesis threads: 5
>     Average synthesis took: 31600.600 usec (+- 297.349 usec)
>     Average num. events: 14012.500 (+- 4.590)
>     Average time per event 2.255 usec
>   Number of synthesis threads: 6
>     Average synthesis took: 32309.900 usec (+- 472.225 usec)
>     Average num. events: 14004.000 (+- 0.000)
>     Average time per event 2.307 usec
>   Number of synthesis threads: 7
>     Average synthesis took: 31400.100 usec (+- 206.261 usec)
>     Average num. events: 14004.800 (+- 0.800)
>     Average time per event 2.242 usec
>   Number of synthesis threads: 8
>     Average synthesis took: 31601.400 usec (+- 303.350 usec)
>     Average num. events: 14005.700 (+- 1.700)
>     Average time per event 2.256 usec
>
> I also double-checked (using strace) that it does what it is supposed
> to do, and it seems like everything checks out. Here's text-based
> strace log:
>
> openat(AT_FDCWD, "/proc/35876/task/35876/maps", O_RDONLY) =3D 3
> read(3, "00400000-0040c000 r--p 00000000 "..., 8192) =3D 3997
> read(3, "7f519d4d3000-7f519d516000 r--p 0"..., 8192) =3D 4025
> read(3, "7f519dc3d000-7f519dc44000 r-xp 0"..., 8192) =3D 4048
> read(3, "7f519dd2d000-7f519dd2f000 r--p 0"..., 8192) =3D 4017
> read(3, "7f519dff6000-7f519dff8000 r--p 0"..., 8192) =3D 2744
> read(3, "", 8192)                       =3D 0
> close(3)                                =3D 0
>
>
> BTW, note how the kernel doesn't serve more than 4KB of data, even
> though perf provides 8KB buffer (that's to Greg's question about
> optimizing using bigger buffers, I suspect without seq_file changes,
> it won't work).
>
> And here's an abbreviated log for ioctl version, it has lots more (but
> much faster) ioctl() syscalls, given it dumps everything:
>
> openat(AT_FDCWD, "/proc/36380/task/36380/maps", O_RDONLY) =3D 3
> ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50) =3D=
 0
> ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50) =3D=
 0
>
>  ... 195 ioctl() calls in total ...
>
> ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50) =3D=
 0
> ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50) =3D=
 0
> ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50) =3D=
 0
> ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50)
> =3D -1 ENOENT (No such file or directory)
> close(3)                                =3D 0
>
>
> So, it's not the optimal usage of this API, and yet it's still better
> (or at least not worse) than text-based API.
>

In another reply to Arnaldo on patch #2 I mentioned the idea of
allowing to iterate only file-backed VMAs (as it seems like what
symbolizers would only care about, but I might be wrong here). So I
tried that quickly, given it's a trivial addition to my code. See
results below (it is slightly faster, but not much, because most of
VMAs in that benchmark seem to be indeed file-backed anyways), just
for completeness. I'm not sure if that would be useful/used by perf,
so please let me know.

As I mentioned above, it's not radically faster in this perf
benchmark, because we still request about 170 VMAs (vs ~195 if we
iterate *all* of them), so not a big change. The ratio will vary
depending on what the process is doing, of course. Anyways, just for
completeness, I'm not sure if I have to add this "filter" to the
actual implementation.

# ./perf-filebacked bench internals synthesize
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 65.759 usec (+- 0.063 usec)
  Average num. events: 30.000 (+- 0.000)
  Average time per event 2.192 usec
  Average data synthesis took: 73.840 usec (+- 0.080 usec)
  Average num. events: 153.000 (+- 0.000)
  Average time per event 0.483 usec

# ./perf-filebacked bench internals synthesize
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 66.245 usec (+- 0.059 usec)
  Average num. events: 30.000 (+- 0.000)
  Average time per event 2.208 usec
  Average data synthesis took: 70.627 usec (+- 0.074 usec)
  Average num. events: 153.000 (+- 0.000)
  Average time per event 0.462 usec

# ./perf-filebacked bench internals synthesize --mt -M 8
# Running 'internals/synthesize' benchmark:
Computing performance of multi threaded perf event synthesis by
synthesizing events on CPU 0:
  Number of synthesis threads: 1
    Average synthesis took: 33477.500 usec (+- 556.102 usec)
    Average num. events: 10125.700 (+- 1.620)
    Average time per event 3.306 usec
  Number of synthesis threads: 2
    Average synthesis took: 30473.700 usec (+- 221.933 usec)
    Average num. events: 10127.000 (+- 0.000)
    Average time per event 3.009 usec
  Number of synthesis threads: 3
    Average synthesis took: 29775.200 usec (+- 315.212 usec)
    Average num. events: 10128.700 (+- 0.667)
    Average time per event 2.940 usec
  Number of synthesis threads: 4
    Average synthesis took: 29477.100 usec (+- 621.258 usec)
    Average num. events: 10129.000 (+- 0.000)
    Average time per event 2.910 usec
  Number of synthesis threads: 5
    Average synthesis took: 29777.900 usec (+- 294.710 usec)
    Average num. events: 10144.700 (+- 11.597)
    Average time per event 2.935 usec
  Number of synthesis threads: 6
    Average synthesis took: 27774.700 usec (+- 357.569 usec)
    Average num. events: 10158.500 (+- 14.710)
    Average time per event 2.734 usec
  Number of synthesis threads: 7
    Average synthesis took: 27437.200 usec (+- 233.626 usec)
    Average num. events: 10135.700 (+- 2.700)
    Average time per event 2.707 usec
  Number of synthesis threads: 8
    Average synthesis took: 28784.600 usec (+- 477.630 usec)
    Average num. events: 10133.000 (+- 0.000)
    Average time per event 2.841 usec

>   [0] https://github.com/anakryiko/linux/commit/0841fe675ed30f5605c5b228e=
18f5612ea253b35
>
> >
> > Thanks,
> > Ian
> >
> > > > Thanks,
> > > > Ian
> > > >
> > > > >   [0] https://github.com/libbpf/blazesym/blob/ee9b48a80c0b4499118=
a1e8e5d901cddb2b33ab1/src/normalize/user.rs#L193
> > > > >
> > > > > > thanks,
> > > > > >
> > > > > > greg k-h
> > > > >

