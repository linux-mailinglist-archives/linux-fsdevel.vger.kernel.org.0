Return-Path: <linux-fsdevel+bounces-18856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADAD8BD4E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 20:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978DB1C21A93
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 18:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54DC1591E5;
	Mon,  6 May 2024 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT5ujKr3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C3F1586DB;
	Mon,  6 May 2024 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021509; cv=none; b=hbNRk9Gbgv6LedBViU7JDKozB7Fn8SRdSuOkdEjlEpPKYRs2hAvQKYJjJSZBU4iNNcfPRLa+bcJvfAel/yE3z1hLb/FEQ6ZGqfRq1wFGnibjbr+vW+S7EZfhJlnbLrK2EgmYVZNm6dtyxmqMwOHGUtSXVlTuW+QmrCXBuUlzwHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021509; c=relaxed/simple;
	bh=1KQ4Pn+yoB6PBBPN4ya2Y5yJYGn51e6uVPcXD8xSJo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8HmbZCU6NVcu0cCO5EI1s7HZ7Hns5qUe932VgAEfOsU7PdOMg1X/oUGQwgYsL0gfy0HDbU9O/sYQ30zbFzUy2HMEolXJRPiv6PFZlPxoPaccnVcuAQIPW5tH1UHl0+0edMfiXd84JqdrrtzyPXz/MG2vKKKPWGnErzJ5Y5wnFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT5ujKr3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ab1ddfded1so2052499a91.1;
        Mon, 06 May 2024 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715021507; x=1715626307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJYCFU1qR3U70oabFLkUOdKlCf4CgRflsuk19nnPjCE=;
        b=TT5ujKr3Cr0Nc8BmRTvw25nPW4I++FBh4Ebd9gOVVM7iNyi3iS6XTO+9WmbLJwGXkZ
         RsdCDq/kbIebUFOVh6Xv0zxZTiD3aiuta6+u8/LStpRdoIgStnPaFaSbzYO8UM/lQntk
         O/p2Vp/OKJUrqlxLNAU/nhJL96mat1fXaeR8eunEuknFY5slUZsO6Edq2dgK8zNYGFBx
         0/6e1XiOw/fDULoiKhg6kJkdNGsxLL07Ld2HFjGr0fXK/yAEvZDXke9yIcCSjwRT7DAH
         UORxMrsZlxwqISPL7suSAXAUvUjDmS/ie9n7f0FRs3clHcprzXczoWHfTC+FRNzIUuFJ
         2zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715021507; x=1715626307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJYCFU1qR3U70oabFLkUOdKlCf4CgRflsuk19nnPjCE=;
        b=EYRo2UXAnw3xpmoyZQ/y9A2RCdLij3LQ/HAdqMo3xvlXZBPhdf//TlUIV8dy+idM2+
         qJTzacTpWeBzulHugoqBXkiS9eWYiIGZ/AajqI7+DEk9yl0YYlsndtsGG3/CBc3Lmntb
         Evv8AozE8UEccqBTDHzmswk5sk2ceqlmijMGSn/2xUasNRms2Wdhaee2SSX4yE5ncnG1
         SlWjvuoISAnun93YRgHZ5dqDWKuhV4YGumZpecyZXUywE5YGx6qctdkPucyFbRBugQyS
         RH/s4TkPW+0CKcD6viZ4CQ4ti1dxztukSQW8eZmolCY9koSPnDchkFxhuJv2MpVm7e2J
         Eobw==
X-Forwarded-Encrypted: i=1; AJvYcCUJDDDKulwvvIkxQW+v+4r8LA5c+s2gcjsVfOUk/8bvyzfk1YIqTs+ybEap1L0xy520jzT+XINKp+HiJ6HJ5cd0YmuCD5maY+zpC9pp0exVwnc1hABDB7/HrI5cuewZYG2dWpx1uY/k886oaOnK6RfAlIPaI9AFQrPdmMP9VqEfcdTwTuyWGFjHrrDFKQIP47/ti9YkGRlQ+FyFQihgzbKRb2o=
X-Gm-Message-State: AOJu0YwmGMNbmBiyVuElCBxgyBTa25yr33yHD9Ymt0nCI5QvJzUgJhS1
	Dkl9veaX8q1BWMr8EpWrGxfA9SqtMT5JvrWtYuewRuG6oxOB0bozIaRONgh4xWpI48PSoTPBKML
	6CRhfMnt37Nk6xlToqfG3EYkvBXEikQ==
X-Google-Smtp-Source: AGHT+IHUCuh5MCL4HivLFIEUU8PAZ5xNKwbc3jbpnxvyJnZmxUy6rlnIubbWPjNgeUkkQLRn4ZF6m3s29tesf53SNBA=
X-Received: by 2002:a17:90a:930c:b0:2a1:f586:d203 with SMTP id
 p12-20020a17090a930c00b002a1f586d203mr8530578pjo.41.1715021506858; Mon, 06
 May 2024 11:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-3-andrii@kernel.org>
 <2024050439-janitor-scoff-be04@gregkh> <CAEf4BzZ6CaMrqRR1Rah7=HnTpU5-zw5HUnSH9NWCzAZZ55ZXFQ@mail.gmail.com>
 <ZjjiFnNRbwsMJ3Gj@x1> <CAM9d7cgvCB8CBFGhMB_-4tCm6+jzoPBNg4CR7AEyMNo8pF9QKg@mail.gmail.com>
In-Reply-To: <CAM9d7cgvCB8CBFGhMB_-4tCm6+jzoPBNg4CR7AEyMNo8pF9QKg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 May 2024 11:51:34 -0700
Message-ID: <CAEf4Bzb8E7wzwBn+cx-XAW0ofEqemeuZoawHTFoTc-jK1azasA@mail.gmail.com>
Subject: Re: [PATCH 2/5] fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 11:05=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Mon, May 6, 2024 at 6:58=E2=80=AFAM Arnaldo Carvalho de Melo <acme@ker=
nel.org> wrote:
> >
> > On Sat, May 04, 2024 at 02:50:31PM -0700, Andrii Nakryiko wrote:
> > > On Sat, May 4, 2024 at 8:28=E2=80=AFAM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> > > > On Fri, May 03, 2024 at 05:30:03PM -0700, Andrii Nakryiko wrote:
> > > > > Note also, that fetching VMA name (e.g., backing file path, or sp=
ecial
> > > > > hard-coded or user-provided names) is optional just like build ID=
. If
> > > > > user sets vma_name_size to zero, kernel code won't attempt to ret=
rieve
> > > > > it, saving resources.
> >
> > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > > > Where is the userspace code that uses this new api you have created=
?
> >
> > > So I added a faithful comparison of existing /proc/<pid>/maps vs new
> > > ioctl() API to solve a common problem (as described above) in patch
> > > #5. The plan is to put it in mentioned blazesym library at the very
> > > least.
> > >
> > > I'm sure perf would benefit from this as well (cc'ed Arnaldo and
> > > linux-perf-user), as they need to do stack symbolization as well.
>
> I think the general use case in perf is different.  This ioctl API is gre=
at
> for live tracing of a single (or a small number of) process(es).  And
> yes, perf tools have those tracing use cases too.  But I think the
> major use case of perf tools is system-wide profiling.

The intended use case is also a system-wide profiling, but I haven't
heard that opening a file per process is a big bottleneck or a
limitation, tbh.

>
> For system-wide profiling, you need to process samples of many
> different processes at a high frequency.  Now perf record doesn't
> process them and just save it for offline processing (well, it does
> at the end to find out build-ID but it can be omitted).
>
> Doing it online is possible (like perf top) but it would add more
> overhead during the profiling.  And we cannot move processing
> or symbolization to the end of profiling because some (short-
> lived) tasks can go away.

We do have some setups where we install a BPF program that monitors
process exit and mmap() events and emits (proactively) VMA
information. It's not applicable everywhere, and in some setups (like
Oculus case) we just accept that short-lived processes will be missed
at the expense of less interruption, simpler and less privileged
"agents" doing profiling and address resolution logic.

So the problem space, as can be seen, is pretty vast and varied, and
there is no single API that would serve all the needs perfectly.

>
> Also it should support perf report (offline) on data from a
> different kernel or even a different machine.

We fetch build ID (and resolve file offset) and offload actual
symbolization to a dedicated fleet of servers, whenever possible. We
don't yet do it for kernel stack traces, but we are moving in this
direction (and there are their own problems with /proc/kallsyms being
text-based, listing everything, and pretty big all in itself; but
that's a separate topic).

>
> So it saves the memory map of processes and symbolizes
> the stack trace with it later.  Of course it needs to be updated
> as the memory map changes and that's why it tracks mmap
> or similar syscalls with PERF_RECORD_MMAP[2] records.
>
> A problem with this approach is to get the initial state of all
> (or a target for non-system-wide mode) existing processes.
> We call it synthesizing, and read /proc/PID/maps to generate
> the mmap records.
>
> I think the below comment from Arnaldo talked about how
> we can improve the synthesizing (which is sequential access
> to proc maps) using BPF.

Yep. We can also benchmark using this new ioctl() to fetch a full set
of VMAs, it might still be good enough.

>
> Thanks,
> Namhyung
>

[...]

