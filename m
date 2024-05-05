Return-Path: <linux-fsdevel+bounces-18750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB068BBF53
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 07:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80AB1F21589
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 05:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD88524F;
	Sun,  5 May 2024 05:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXewCOpK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0CA1878
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 05:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714886791; cv=none; b=e9/C5OkzN9jfHQxJXUSNbaz5AKyN1UjJMkBDUooFuYsXg+6qZLegjtxmHJxfabkbpIo+/W/bP1FayUHZdysJxdRbVNkfeOzHihlMGX6a/Qy4OAqD0wyHNsQfuoaM8xplYfbVbKdcYEJdMIB6gtBlbNBPv4W2LomuWLnlLzx0B7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714886791; c=relaxed/simple;
	bh=aIicpjFZ9Th/Wo46DDLxYWOsLnOy7PMn1pzOwCFTXwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ywsu4Ot765k8NxzliOwA03rDCmshSiwiaairMu+JnTBznM0Xse3uj624zDcSoosrGSNktRudMnS6JMIqMiNE3K+jc/H2s4EFMca0Qn2GUZjqKM+LqPjf1YpU9xxHC1PVczeT2a849+yJBYd+7UAffyE22n0EHoKbVZ+0lNcDngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXewCOpK; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-436ed871225so221141cf.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 22:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714886788; x=1715491588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eb/EPhjcbAC4KAB4gdgqUAeq8oCgWvlhJ9vOj/P63R8=;
        b=DXewCOpK9oHYpbuYDG7+0MOuSEZFOin+bFs7/Qrh9T1cue1SRIf5xKwClhK6kCrh06
         FOCz7/50MQtDa60hmkakTMjIyVQKV8TyfQShDp2VAT4mqKbF/TFbm97WoPiak6a6+328
         jjDGW2xvdHQplrZB0XsFBSQLl4dww6yyGVYMxO4mzacl9B7RjMVUhEzIpbcg58aYEXwW
         4y8RlbyAjEqI7DOJd6rU+HsDER4SGY+o4vvsT+dXKKYvRbi0POHOZjxxEQeerr0RMcny
         e3EJUlwBrU/Zfv49JDT/OiXavUSoFUgzyegALAeC0SkAjuLNSX79IjMDMxlstD0EzzkI
         YPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714886788; x=1715491588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eb/EPhjcbAC4KAB4gdgqUAeq8oCgWvlhJ9vOj/P63R8=;
        b=FhtijoJRiWTsgihV2p/wuxa6v8OHCYVZfOVe8YUS+vZ4CdvTSKTXmn64Vp+llYxt8C
         HW+ddJ3r13njl9qyyqloLsebEr459ZOeZ123urqfzMafz5JDtBY4hUgSddIIl6GE97LZ
         GgbbyiPnQS1w64TZhCLjocKN53O6xKkG16a71nhcbBPQbFb3Gdw1aoi6wUW9ZsdmEuk4
         9Si5gFksSXXgZSHZpn3BDWXUWveZP51q2GjEgOlwaJlRSAKpsPcvzRnx9Q+taurrj+HV
         LCtImwx8WHkdyf68dNqjwtpoEW5wxIXsJmLHdKY8xkBU4QD3r+9QmGzVEM8Hw97BGQme
         qxTw==
X-Gm-Message-State: AOJu0Yzs3SwrSiJEXCcEIIwg/FKoznWVwR8Sc6jfiESaAIhV3mkncVvr
	QJoWehIrm7NyYZXfDuumS89Wwg7NFjJx8IWlvbFad18/XuDdCg+xJd6p12ZHaPGyFiaP5EEq7tL
	WVfknkYfMywSWa1kF949NWfA6TkjTKqrJqhsZ
X-Google-Smtp-Source: AGHT+IG/zlrczb1H5X6lo6ctQdhFV8VmRyTeunZU4W3zP3ofbT54pBnHB9dhcXJHuB/0kmY7mhPIE4g+wjaH12P2Sn4=
X-Received: by 2002:a05:622a:1305:b0:43a:2e2b:eec with SMTP id
 d75a77b69052e-43d030b28f1mr2462581cf.2.1714886787525; Sat, 04 May 2024
 22:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org>
In-Reply-To: <20240504003006.3303334-1-andrii@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sat, 4 May 2024 22:26:16 -0700
Message-ID: <CAP-5=fV+K9-ggiaPR7xTVP2p=enLZf0ARBcjb4QG+7kv-00q7w@mail.gmail.com>
Subject: Re: [PATCH 0/5] ioctl()-based API to query VMAs from /proc/<pid>/maps
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 5:30=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Implement binary ioctl()-based interface to /proc/<pid>/maps file to allo=
w
> applications to query VMA information more efficiently than through textu=
al
> processing of /proc/<pid>/maps contents. See patch #2 for the context,
> justification, and nuances of the API design.
>
> Patch #1 is a refactoring to keep VMA name logic determination in one pla=
ce.
> Patch #2 is the meat of kernel-side API.
> Patch #3 just syncs UAPI header (linux/fs.h) into tools/include.
> Patch #4 adjusts BPF selftests logic that currently parses /proc/<pid>/ma=
ps to
> optionally use this new ioctl()-based API, if supported.
> Patch #5 implements a simple C tool to demonstrate intended efficient use=
 (for
> both textual and binary interfaces) and allows benchmarking them. Patch i=
tself
> also has performance numbers of a test based on one of the medium-sized
> internal applications taken from production.
>
> This patch set was based on top of next-20240503 tag in linux-next tree.
> Not sure what should be the target tree for this, I'd appreciate any guid=
ance,
> thank you!
>
> Andrii Nakryiko (5):
>   fs/procfs: extract logic for getting VMA name constituents
>   fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps
>   tools: sync uapi/linux/fs.h header into tools subdir
>   selftests/bpf: make use of PROCFS_PROCMAP_QUERY ioctl, if available
>   selftests/bpf: a simple benchmark tool for /proc/<pid>/maps APIs

I'd love to see improvements like this for the Linux perf command.
Some thoughts:

 - Could we do something scalability wise better than a file
descriptor per pid? If a profiler is running in a container the cost
of many file descriptors can be significant, and something that
increases as machines get larger. Could we have a /proc/maps for all
processes?

 - Something that is broken in perf currently is that we can race
between reading /proc and opening events on the pids it contains. For
example, perf top supports a uid option that first scans to find all
processes owned by a user then tries to open an event on each process.
This fails if the process terminates between the scan and the open
leading to a frequent:
```
$ sudo perf top -u `id -u`
The sys_perf_event_open() syscall returned with 3 (No such process)
for event (cycles:P).
```
It would be nice for the API to consider cgroups, uids and the like as
ways to get a subset of things to scan.

 - Some what related, the mmap perf events give data after the mmap
call has happened. As VMAs get merged this can lead to mmap perf
events looking like the memory overlaps (for jits using anonymous
memory) and we lack munmap/mremap events.

Jiri Olsa has looked at improvements in this area in the past.

Thanks,
Ian

>  fs/proc/task_mmu.c                            | 290 +++++++++++---
>  include/uapi/linux/fs.h                       |  32 ++
>  .../perf/trace/beauty/include/uapi/linux/fs.h |  32 ++
>  tools/testing/selftests/bpf/.gitignore        |   1 +
>  tools/testing/selftests/bpf/Makefile          |   2 +-
>  tools/testing/selftests/bpf/procfs_query.c    | 366 ++++++++++++++++++
>  tools/testing/selftests/bpf/test_progs.c      |   3 +
>  tools/testing/selftests/bpf/test_progs.h      |   2 +
>  tools/testing/selftests/bpf/trace_helpers.c   | 105 ++++-
>  9 files changed, 763 insertions(+), 70 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/procfs_query.c
>
> --
> 2.43.0
>
>

