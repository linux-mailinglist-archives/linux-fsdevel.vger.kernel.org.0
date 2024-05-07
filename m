Return-Path: <linux-fsdevel+bounces-18871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CFF8BDA80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 07:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E603282902
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 05:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5412A6BFA2;
	Tue,  7 May 2024 05:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhvsX8Fn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D6381C4;
	Tue,  7 May 2024 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715058430; cv=none; b=RYjrclG1wDyzfk3bt+aL265L0u8mapEIYh/D3RtDbqcib3lthKl+x8EU4I1xttG7m+WI1/SxkT3i1rQryoIE9YBPbszxlnT9NFtoJKVTvbMnY3iJqfGtpm0XTM0KRNk6l3WdKp/d4vvJuIT3SGmGck3hfedJpzn1QgM5b6OibgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715058430; c=relaxed/simple;
	bh=uWQxqjs6kfqAnNXz7BtR6USEjXO0E3uBp/EeYliL4HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNLf0HgyqSisy3a0sUkir3UzgYjLZOLOLWU80hOp6wD7UZHaKxI41elTSEKSNlcZD+j+WcmfPl6b0FUwL2WmiozK3qJR0mqtHf0mVmj66TKby2D/bfzPzH18lJWAzd/05abBQMYc+h5KYphKAK5vrDSfUxSy3b2hFmN4z9j65+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhvsX8Fn; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a2da57ab3aso2109131a91.3;
        Mon, 06 May 2024 22:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715058428; x=1715663228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8vbZJ5UPiifYuspMMKBbXeF72Brhg4ICn1NMDsG3XQ=;
        b=HhvsX8FnLmXAld2ITq6UoIYYvVP/4vl2/88nftgcGJpcW1C9YxIBvAxtpHFvddaLTL
         L2JJkbo3GwV4bFrlUmhKyFerkN7Ee14r8WGiOSzfSeLEV1/PgqXxt3GCv81/+txv3EVl
         Y0qzwf0HiYOmYFijblRcXy5+f3ja9y+Vy3UfBkzEJmfv608aJlpIMvyq03rOTJkbSghJ
         mtKtj1EhoupWc+s/gEQcNoEnXUNn0kidtjtIvjW9yRhEny5u/J76wHKwB2kbXDTzWRkd
         CLYHYKDpvlgij2gOdQg1rLHJg0TgdPvlp32yngDDUkbxNw6zIPQTjyVlUgWLxxcDPMWo
         HA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715058428; x=1715663228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8vbZJ5UPiifYuspMMKBbXeF72Brhg4ICn1NMDsG3XQ=;
        b=KBqwV+fxl+7QzjIm2vZX2QUkBe6RmHP8UC+sCLKFyU6rtf8KVKN7yqxgB25ENrBQR4
         SMP7DWX2zHusoWjMhWwbVE2M4Bfoyc5Y12a+sk4RcvogDidsWDR0tldTXm7DLuhduBK8
         DixYzyQkJtjfEmwvpIpDobMgbuqO9gGdbMUaVlCa2QCks1uX84jshXvyso4vlJHpr8OV
         +UEeUAylG+OHoBWaRWglA3Tow/RSZqL+1wtPv2HMmnvujOea9QwL70sDuJsILajuaCNN
         JzbGpSRowGaFkzpV7MEBEqlYcGa1Zup5EF9mtoxHnCA58JOieseGRMZYnEhRiod20P3f
         TBsg==
X-Forwarded-Encrypted: i=1; AJvYcCWgt292lKAbUx6DpxjoVSEjkDBvPurDVFvIN3Nl9TwTH+00Zai+9MpVO4yCZ+Q1hR00YuUch40cLNN9GiFDKswEh3Zq3Vi1ppH5Sa5HUFLsI7/6KEHxDIdW5vSoqHm/DVcPSOBPUFk5GnjceVwFCrjP0YNkZI7ehxeVkTLPAJKE/XaiofYCsXWSYQu3E8mU4Sy74W/uKGXwggu+YRVEh5UBtQ4=
X-Gm-Message-State: AOJu0YzoY8gPMFmgEIGTfr6CS2Ebk3uoLAR0zr8Uf9o2xTflxsPk5BuM
	NZUqwzpyd45Ikquvxo7jsNyvC1kbqBBJhWLnclikxEwhGeHKeRQrL+xlqKG/A0+2M29Cg0cQ1NS
	beT7wRThxcsVF1dRjLkN6DCvSnDk=
X-Google-Smtp-Source: AGHT+IEB8vQbtVs+3K7IpXxE9aS+S0ebnjARauIth7zOTQsKYLVCTGe39Yqo8hcl7fuF+7QLXoq2DOEb7xuVPYELUqE=
X-Received: by 2002:a17:90b:38c4:b0:2b4:e4d2:e6f0 with SMTP id
 nn4-20020a17090b38c400b002b4e4d2e6f0mr3870255pjb.45.1715058428309; Mon, 06
 May 2024 22:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-6-andrii@kernel.org>
 <2024050404-rectify-romp-4fdb@gregkh> <CAEf4BzaUgGJVqw_yWOXASHManHQWGQV905Bd-wiaHj-mRob9gw@mail.gmail.com>
 <CAP-5=fWPig8-CLLBJ_rb3D6eNAKVY7KX_n_HcpGqL7gfe-=XXg@mail.gmail.com>
 <CAEf4Bzab+sRQ8pzNYxh1BOgjhDF4yCkqcHxy5YZAyT-jef7Acw@mail.gmail.com> <CAP-5=fXv59EmyM7FNnwAp0JjAZjtYhCj3b3FTH7KsHL=k8C6oQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXv59EmyM7FNnwAp0JjAZjtYhCj3b3FTH7KsHL=k8C6oQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 May 2024 22:06:56 -0700
Message-ID: <CAEf4BzbdGJzMuRgGJE72VFquXL37rS9Ti__wx4f_+kt3yetkEg@mail.gmail.com>
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

On Mon, May 6, 2024 at 11:43=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, May 6, 2024 at 11:32=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, May 4, 2024 at 10:09=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Sat, May 4, 2024 at 2:57=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Sat, May 4, 2024 at 8:29=E2=80=AFAM Greg KH <gregkh@linuxfoundat=
ion.org> wrote:
> > > > >
> > > > > On Fri, May 03, 2024 at 05:30:06PM -0700, Andrii Nakryiko wrote:
> > > > > > Implement a simple tool/benchmark for comparing address "resolu=
tion"
> > > > > > logic based on textual /proc/<pid>/maps interface and new binar=
y
> > > > > > ioctl-based PROCFS_PROCMAP_QUERY command.
> > > > >
> > > > > Of course an artificial benchmark of "read a whole file" vs. "a t=
iny
> > > > > ioctl" is going to be different, but step back and show how this =
is
> > > > > going to be used in the real world overall.  Pounding on this fil=
e is
> > > > > not a normal operation, right?
> > > > >
> > > >
> > > > It's not artificial at all. It's *exactly* what, say, blazesym libr=
ary
> > > > is doing (see [0], it's Rust and part of the overall library API, I
> > > > think C code in this patch is way easier to follow for someone not
> > > > familiar with implementation of blazesym, but both implementations =
are
> > > > doing exactly the same sequence of steps). You can do it even less
> > > > efficiently by parsing the whole file, building an in-memory lookup
> > > > table, then looking up addresses one by one. But that's even slower
> > > > and more memory-hungry. So I didn't even bother implementing that, =
it
> > > > would put /proc/<pid>/maps at even more disadvantage.
> > > >
> > > > Other applications that deal with stack traces (including perf) wou=
ld
> > > > be doing one of those two approaches, depending on circumstances an=
d
> > > > level of sophistication of code (and sensitivity to performance).
> > >
> > > The code in perf doing this is here:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/perf/util/synthetic-events.c#n440
> > > The code is using the api/io.h code:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/lib/api/io.h
> > > Using perf to profile perf it was observed time was spent allocating
> > > buffers and locale related activities when using stdio, so io is a
> > > lighter weight alternative, albeit with more verbose code than fscanf=
.
> > > You could add this as an alternate /proc/<pid>/maps reader, we have a
> > > similar benchmark in `perf bench internals synthesize`.
> > >
> >
> > If I add a new implementation using this ioctl() into
> > perf_event__synthesize_mmap_events(), will it be tested from this
> > `perf bench internals synthesize`? I'm not too familiar with perf code
> > organization, sorry if it's a stupid question. If not, where exactly
> > is the code that would be triggered from benchmark?
>
> Yes it would be triggered :-)

Ok, I don't exactly know how to interpret the results (and what the
benchmark is doing), but numbers don't seem to be worse. They actually
seem to be a bit better.

I pushed my code that adds perf integration to [0]. That commit has
results, but I'll post them here (with invocation parameters).
perf-ioctl is the version with ioctl()-based implementation,
perf-parse is, logically, text-parsing version. Here are the results
(and see my notes below the results as well):

TEXT-BASED
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

# ./perf-parse bench internals synthesize
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 80.311 usec (+- 0.077 usec)
  Average num. events: 32.000 (+- 0.000)
  Average time per event 2.510 usec
  Average data synthesis took: 84.429 usec (+- 0.066 usec)
  Average num. events: 179.000 (+- 0.000)
  Average time per event 0.472 usec

# ./perf-parse bench internals synthesize
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 79.900 usec (+- 0.077 usec)
  Average num. events: 32.000 (+- 0.000)
  Average time per event 2.497 usec
  Average data synthesis took: 84.832 usec (+- 0.074 usec)
  Average num. events: 180.000 (+- 0.000)
  Average time per event 0.471 usec

# ./perf-parse bench internals synthesize --mt -M 8
# Running 'internals/synthesize' benchmark:
Computing performance of multi threaded perf event synthesis by
synthesizing events on CPU 0:
  Number of synthesis threads: 1
    Average synthesis took: 36338.100 usec (+- 406.091 usec)
    Average num. events: 14091.300 (+- 7.433)
    Average time per event 2.579 usec
  Number of synthesis threads: 2
    Average synthesis took: 37071.200 usec (+- 746.498 usec)
    Average num. events: 14085.900 (+- 1.900)
    Average time per event 2.632 usec
  Number of synthesis threads: 3
    Average synthesis took: 33932.300 usec (+- 626.861 usec)
    Average num. events: 14085.900 (+- 1.900)
    Average time per event 2.409 usec
  Number of synthesis threads: 4
    Average synthesis took: 33822.700 usec (+- 506.290 usec)
    Average num. events: 14099.200 (+- 8.761)
    Average time per event 2.399 usec
  Number of synthesis threads: 5
    Average synthesis took: 33348.200 usec (+- 389.771 usec)
    Average num. events: 14085.900 (+- 1.900)
    Average time per event 2.367 usec
  Number of synthesis threads: 6
    Average synthesis took: 33269.600 usec (+- 350.341 usec)
    Average num. events: 14084.000 (+- 0.000)
    Average time per event 2.362 usec
  Number of synthesis threads: 7
    Average synthesis took: 32663.900 usec (+- 338.870 usec)
    Average num. events: 14085.900 (+- 1.900)
    Average time per event 2.319 usec
  Number of synthesis threads: 8
    Average synthesis took: 32748.400 usec (+- 285.450 usec)
    Average num. events: 14085.900 (+- 1.900)
    Average time per event 2.325 usec

IOCTL-BASED
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# ./perf-ioctl bench internals synthesize
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 72.996 usec (+- 0.076 usec)
  Average num. events: 31.000 (+- 0.000)
  Average time per event 2.355 usec
  Average data synthesis took: 79.067 usec (+- 0.074 usec)
  Average num. events: 178.000 (+- 0.000)
  Average time per event 0.444 usec

# ./perf-ioctl bench internals synthesize
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 73.921 usec (+- 0.073 usec)
  Average num. events: 31.000 (+- 0.000)
  Average time per event 2.385 usec
  Average data synthesis took: 80.545 usec (+- 0.070 usec)
  Average num. events: 178.000 (+- 0.000)
  Average time per event 0.453 usec

# ./perf-ioctl bench internals synthesize --mt -M 8
# Running 'internals/synthesize' benchmark:
Computing performance of multi threaded perf event synthesis by
synthesizing events on CPU 0:
  Number of synthesis threads: 1
    Average synthesis took: 35609.500 usec (+- 428.576 usec)
    Average num. events: 14040.700 (+- 1.700)
    Average time per event 2.536 usec
  Number of synthesis threads: 2
    Average synthesis took: 34293.800 usec (+- 453.811 usec)
    Average num. events: 14040.700 (+- 1.700)
    Average time per event 2.442 usec
  Number of synthesis threads: 3
    Average synthesis took: 32385.200 usec (+- 363.106 usec)
    Average num. events: 14040.700 (+- 1.700)
    Average time per event 2.307 usec
  Number of synthesis threads: 4
    Average synthesis took: 33113.100 usec (+- 553.931 usec)
    Average num. events: 14054.500 (+- 11.469)
    Average time per event 2.356 usec
  Number of synthesis threads: 5
    Average synthesis took: 31600.600 usec (+- 297.349 usec)
    Average num. events: 14012.500 (+- 4.590)
    Average time per event 2.255 usec
  Number of synthesis threads: 6
    Average synthesis took: 32309.900 usec (+- 472.225 usec)
    Average num. events: 14004.000 (+- 0.000)
    Average time per event 2.307 usec
  Number of synthesis threads: 7
    Average synthesis took: 31400.100 usec (+- 206.261 usec)
    Average num. events: 14004.800 (+- 0.800)
    Average time per event 2.242 usec
  Number of synthesis threads: 8
    Average synthesis took: 31601.400 usec (+- 303.350 usec)
    Average num. events: 14005.700 (+- 1.700)
    Average time per event 2.256 usec

I also double-checked (using strace) that it does what it is supposed
to do, and it seems like everything checks out. Here's text-based
strace log:

openat(AT_FDCWD, "/proc/35876/task/35876/maps", O_RDONLY) =3D 3
read(3, "00400000-0040c000 r--p 00000000 "..., 8192) =3D 3997
read(3, "7f519d4d3000-7f519d516000 r--p 0"..., 8192) =3D 4025
read(3, "7f519dc3d000-7f519dc44000 r-xp 0"..., 8192) =3D 4048
read(3, "7f519dd2d000-7f519dd2f000 r--p 0"..., 8192) =3D 4017
read(3, "7f519dff6000-7f519dff8000 r--p 0"..., 8192) =3D 2744
read(3, "", 8192)                       =3D 0
close(3)                                =3D 0


BTW, note how the kernel doesn't serve more than 4KB of data, even
though perf provides 8KB buffer (that's to Greg's question about
optimizing using bigger buffers, I suspect without seq_file changes,
it won't work).

And here's an abbreviated log for ioctl version, it has lots more (but
much faster) ioctl() syscalls, given it dumps everything:

openat(AT_FDCWD, "/proc/36380/task/36380/maps", O_RDONLY) =3D 3
ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50) =3D 0
ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50) =3D 0

 ... 195 ioctl() calls in total ...

ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50) =3D 0
ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50) =3D 0
ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50) =3D 0
ioctl(3, _IOC(_IOC_READ|_IOC_WRITE, 0x9f, 0x1, 0x60), 0x7fff6b603d50)
=3D -1 ENOENT (No such file or directory)
close(3)                                =3D 0


So, it's not the optimal usage of this API, and yet it's still better
(or at least not worse) than text-based API.

  [0] https://github.com/anakryiko/linux/commit/0841fe675ed30f5605c5b228e18=
f5612ea253b35

>
> Thanks,
> Ian
>
> > > Thanks,
> > > Ian
> > >
> > > >   [0] https://github.com/libbpf/blazesym/blob/ee9b48a80c0b4499118a1=
e8e5d901cddb2b33ab1/src/normalize/user.rs#L193
> > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >

