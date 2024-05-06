Return-Path: <linux-fsdevel+bounces-18860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847788BD506
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 20:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7AAE1C219D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 18:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E2B158DD4;
	Mon,  6 May 2024 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAJtPzHF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65C158DB4;
	Mon,  6 May 2024 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021927; cv=none; b=tIvmPS+b7RiA6NpcXiLQXRsi9kemKXyCDJMFFu139JL/oJwhNe9ljedehx29dqVrCYAIIoFL9qv8gI0WKat6TNzmohVXpa5FzvQ6PvyfaYVe+bOvABjk/Ux//cXwxmFSDNg3EmJuRP+qVTmNasJsBhMk83xo4rkqt3RwYchnzSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021927; c=relaxed/simple;
	bh=nlwG+Tb6q/4wSpvjYYQjeMN3/8gpH1KVmUrCsOT0Oqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+IHMw7/pksCcfbgJ8p8al/socETD431sHRv1UUoiC4GS5c8STqoFI7da7m/QfFoPC06CvvRNuwP3XsZ4sZteKt0W0WJE3AoqTFn4aqvmS7kyo9pdgNxoX6wmxcpMNsg+++bpzgdMzp+PQKubAicUsGHZgUqnOK6mlLrbxlhPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAJtPzHF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e651a9f3ffso10045645ad.1;
        Mon, 06 May 2024 11:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715021925; x=1715626725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBmUGkhhD9gkT1EUET4z6SRcZE4ycm2GQWxqwdHtioQ=;
        b=TAJtPzHF3ZlXtdLM36sGiNngyDNCun9T55i44VfsuvApMXhAe1HPrVvWj8HQknEoBR
         pkOFg6jLp5O1rlG1b7TNezfOJXLHu7EUeq9UcvFq0Irb7elwPP0sA0kEftQVG1q2TyIt
         HOs/ydVFm9V7nMpdmiXGXz/H2uGeIPxoMpl+ksBtEtKf2ASMaijlALpD7tRiRrRWf3+q
         OKWaEkYt/qS2wmsknB/d5CRHyJ5USnRlJemqudHZ3f7RIN85xeFbwjwYVFcbc0oYulaK
         uotwtyrw3+CbNr640ew6ViFWbA6X22kGkYCCIH30/GVdF5XHjINPpLYtM226oa1N1hCp
         QIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715021925; x=1715626725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBmUGkhhD9gkT1EUET4z6SRcZE4ycm2GQWxqwdHtioQ=;
        b=uonBnPSt4dTLSt0xTKZKJ/O6YHE8Doih603DGibyy2zZem2lohTPoYWSsOvbmOorIB
         08SgunpVqGkjOUplXgbji46n4J6RBOeJIlJioCQ8umCBsy/rWHHnTZwJJUYuUeRApsrE
         Jen5XPB8EIsME+xdrtBH7gkJ3SqlLECLsGJawhlKJVGAGe7CFW2TpUGJ1XS1St4d3ofx
         eDi+gwRv1dhX61bW6Ys7DzifGwGkJaF3KJQxFFZNQv+Uj3St690Dmd9x2GZFQqPb703L
         9zza1hFP2PhhCqHYlDM9axIJBWLhlzGzddXewzn5NeFlCw9DlH5Wcy77E86v/u6DcZ9v
         uORA==
X-Forwarded-Encrypted: i=1; AJvYcCVRWoxD1z8HdXHqIoL1tuT3SGqWefSyl/m3MDSgBWWQUM/hICkOg8Ll5931MqKbof84t7GylQGQTYFHheN8jWjUt9tWMxchMCfiqadYdhF2YHl0081wYFx1KhL56tbkPMLtA3sfauqt4kJ8ZGtr7P4aYL5FgtyNHiZEBh9O1fsvtQ==
X-Gm-Message-State: AOJu0YxLaql3d/zZm6s2PKZHOcx7UvFjqMqHa8TX+TVgHhn2fM8ldMe3
	mnGCUPMVVEnK6S5+zRvIJCAcIwAyZFlXGDaPC6S/Wqa4I0k0S9ZluiEkKAIQ6WdPL1ATeZL3NXq
	3QxJ/jvbW2FESuzPzQFgwFjyBF+o=
X-Google-Smtp-Source: AGHT+IG2o1N2ycMIv9uEIIuEDq3uzONEVpRTFGB3VtW6olbmTd0XdQVumNZTfLPBdE5tJb2lg7+V4RRFAAwYOxwBVO0=
X-Received: by 2002:a17:90a:2c4e:b0:2b5:4ee8:e5e8 with SMTP id
 p14-20020a17090a2c4e00b002b54ee8e5e8mr2886874pjm.16.1715021925228; Mon, 06
 May 2024 11:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <CAP-5=fV+K9-ggiaPR7xTVP2p=enLZf0ARBcjb4QG+7kv-00q7w@mail.gmail.com>
In-Reply-To: <CAP-5=fV+K9-ggiaPR7xTVP2p=enLZf0ARBcjb4QG+7kv-00q7w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 May 2024 11:58:32 -0700
Message-ID: <CAEf4Bza+XwjaO0qs1a-5jN5xX11wP2jJRGoM4_HFphiF_NSD2w@mail.gmail.com>
Subject: Re: [PATCH 0/5] ioctl()-based API to query VMAs from /proc/<pid>/maps
To: Ian Rogers <irogers@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 10:26=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, May 3, 2024 at 5:30=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > Implement binary ioctl()-based interface to /proc/<pid>/maps file to al=
low
> > applications to query VMA information more efficiently than through tex=
tual
> > processing of /proc/<pid>/maps contents. See patch #2 for the context,
> > justification, and nuances of the API design.
> >
> > Patch #1 is a refactoring to keep VMA name logic determination in one p=
lace.
> > Patch #2 is the meat of kernel-side API.
> > Patch #3 just syncs UAPI header (linux/fs.h) into tools/include.
> > Patch #4 adjusts BPF selftests logic that currently parses /proc/<pid>/=
maps to
> > optionally use this new ioctl()-based API, if supported.
> > Patch #5 implements a simple C tool to demonstrate intended efficient u=
se (for
> > both textual and binary interfaces) and allows benchmarking them. Patch=
 itself
> > also has performance numbers of a test based on one of the medium-sized
> > internal applications taken from production.
> >
> > This patch set was based on top of next-20240503 tag in linux-next tree=
.
> > Not sure what should be the target tree for this, I'd appreciate any gu=
idance,
> > thank you!
> >
> > Andrii Nakryiko (5):
> >   fs/procfs: extract logic for getting VMA name constituents
> >   fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps
> >   tools: sync uapi/linux/fs.h header into tools subdir
> >   selftests/bpf: make use of PROCFS_PROCMAP_QUERY ioctl, if available
> >   selftests/bpf: a simple benchmark tool for /proc/<pid>/maps APIs
>
> I'd love to see improvements like this for the Linux perf command.
> Some thoughts:
>
>  - Could we do something scalability wise better than a file
> descriptor per pid? If a profiler is running in a container the cost
> of many file descriptors can be significant, and something that
> increases as machines get larger. Could we have a /proc/maps for all
> processes?

It's probably not a question to me, as it seems like an entirely
different set of APIs. But it also seems a bit convoluted to mix
together information about many address spaces.

As for the cost of FDs, I haven't run into this limitation, and it
seems like the trend in Linux in general is towards "everything is a
file". Just look at pidfd, for example.

Also, having a fd that can be queries has an extra nice property. For
example, opening /proc/self/maps (i.e., process' own maps file)
doesn't require any extra permissions, and then it can be transferred
to another trusted process that would do address
resolution/symbolization. In practice right now it's unavoidable to
add extra caps/root permissions to the profiling process even if the
only thing that it needs is contents of /proc/<pid>/maps (and the use
case is as benign as symbol resolution). Not having an FD for this API
would make this use case unworkable.

>
>  - Something that is broken in perf currently is that we can race
> between reading /proc and opening events on the pids it contains. For
> example, perf top supports a uid option that first scans to find all
> processes owned by a user then tries to open an event on each process.
> This fails if the process terminates between the scan and the open
> leading to a frequent:
> ```
> $ sudo perf top -u `id -u`
> The sys_perf_event_open() syscall returned with 3 (No such process)
> for event (cycles:P).
> ```
> It would be nice for the API to consider cgroups, uids and the like as
> ways to get a subset of things to scan.

This seems like putting too much into an API, tbh. It feels like
mapping cgroupos/uids to their processes is its own way and if we
don't have efficient APIs to do this, we should add it. But conflating
it into "get VMAs from this process" seems wrong to me.

>
>  - Some what related, the mmap perf events give data after the mmap
> call has happened. As VMAs get merged this can lead to mmap perf
> events looking like the memory overlaps (for jits using anonymous
> memory) and we lack munmap/mremap events.

Is this related to "VMA generation" that Arnaldo mentioned? I'd
happily add it to the new API, as it's easily extensible, if the
kernel already maintains it. If not, then it should be a separate work
to discuss whether kernel *should* track this information.

>
> Jiri Olsa has looked at improvements in this area in the past.
>
> Thanks,
> Ian
>
> >  fs/proc/task_mmu.c                            | 290 +++++++++++---
> >  include/uapi/linux/fs.h                       |  32 ++
> >  .../perf/trace/beauty/include/uapi/linux/fs.h |  32 ++
> >  tools/testing/selftests/bpf/.gitignore        |   1 +
> >  tools/testing/selftests/bpf/Makefile          |   2 +-
> >  tools/testing/selftests/bpf/procfs_query.c    | 366 ++++++++++++++++++
> >  tools/testing/selftests/bpf/test_progs.c      |   3 +
> >  tools/testing/selftests/bpf/test_progs.h      |   2 +
> >  tools/testing/selftests/bpf/trace_helpers.c   | 105 ++++-
> >  9 files changed, 763 insertions(+), 70 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/procfs_query.c
> >
> > --
> > 2.43.0
> >
> >

