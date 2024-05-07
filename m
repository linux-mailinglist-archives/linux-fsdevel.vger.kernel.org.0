Return-Path: <linux-fsdevel+bounces-18928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0E98BE96F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189131C237F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDE554BDA;
	Tue,  7 May 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRUQJpYE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED3D3E48F;
	Tue,  7 May 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099827; cv=none; b=QxdfuW7arm1sXLCyy7DqnUs3Yv+MU/DS8yxLVEtGGYHYuZJfaMfL+xHK8hfhSN8q3RfNPYrCCJAzAA0oMu5ZBBRoVJaUfFTogrOm3JyLkop7N7crnFYQHxMpR5rS/+o589h0BOL1eMy/rd6LaSk7hdHG+Zz1nED4KLFODicLp/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099827; c=relaxed/simple;
	bh=qGfJvnfpxxK0Cnb6ZWI/3YT+WlFz4LPSpjpA2+r7j5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKG6Jt5J44DO9UGxygcOiGCRgCA6GAe4evqjdQ+szyssJz+vLpDJ4lRKnrCm2lb3ANEtc9lfgc8L4GipD0kA78pIPME9dMmYegCno6XLiBCQw29ARF59eDsLUMhPHkq9+a9EXKrAXwAmUlg/jrq1jvlqqUMqG3ThZqrrAF4ZMD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRUQJpYE; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6001399f22bso2490251a12.0;
        Tue, 07 May 2024 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715099825; x=1715704625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4OwR2TgrDTiiCg6OQZ7l2+opI9M0Uh+nYNlleYZodA=;
        b=HRUQJpYEOVWwbv92ztTsKj20wkRvBjaj70s6Kr+tHRFgOYHd1dwamdvo7oQ243zRph
         7cSU3KQEWAyunpo4b55PPF6Vgn7fnLQatDHdYgGEMTtxhnkFHmOO2ibwn+PAoVpfX5Ix
         spK4rnJvmLyzcmDpBStanPG3RYghP3voozGl4UkC4a/EgnGQZ32j8rkZ2kBOenZIpYl/
         8QIK9gt7y7e960baYQI9zx2xgqb7KsUY19zXIKPSHbPZZilhCm8e/jgG5VxpH7xxjALm
         8QD8B8VyODLpC9zpTRwmQ3cEFeu4/Tx1QivCOy3vIZ6nONCq4QQaeFBBpEM/w/SSUXdY
         SeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099825; x=1715704625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4OwR2TgrDTiiCg6OQZ7l2+opI9M0Uh+nYNlleYZodA=;
        b=aLGWJhoqBMKqkLH6qUfgyj9RInmzKeJQpY1KHRUNZ8Vl2iujcsHycCIgN2KwQOQfBN
         +plpTsL4YC810fg1v2fCVIHtivG+TjdbFSyfCpWvADeCpcfL/v45BEBKAEnVfeEhTKD0
         lrXvtforHtUoaQR0TQCsXHEJDPDCKCH7/JsWv6XHDP4ihGEU5ickh9OQh7LDeAhpCpI6
         nM0IxMYbzN3jKbaFRG2167IKeCTIHDeZa9xtMpru9BhfHlbKz3s81YJtk+1w08rV4lSd
         wf8IwpDNzR6KtxOeI/0sbvQld0su6YIMl51IBEyTB51MZmP8GHocELaKM6q/shZc9ZeC
         oeBg==
X-Forwarded-Encrypted: i=1; AJvYcCUeIRQQ/mqn2L8BblA09mmeSo34SyB3KYxvMrMWHAuAFwLArVjDRpBrS7W0egwuMiKdZVcwZBplEUbikBkfxRy8MCVMn2nwyM8QqNP8A1gYpMKThyTRR35zuU3tGZkCaTKGnP0HQmO/+ZY9po8kwKwx4XrHR9iWzOk1Ewxyh4E/CGLk/t+JKs0kWgCRSvegFgpuz8a0ot65oBtEklgL0BE77rA=
X-Gm-Message-State: AOJu0Yx4Q5HR8962YA1WN8CJp6Tx7C/8C3giqpLtIsmr91+CJfdrVM58
	Bc/4vyQx+uJOiXoNSF7eUNVpCMENmNK9T4DmyEi1wsZPPFtDWJjzYVh4HIMDQv6QzppnAtLG2hT
	gQ0nvt1sQpZRoG3NuJdPhF63uzSk=
X-Google-Smtp-Source: AGHT+IHJgrwGB4ntGMYQujEHAZAA3qer5jlfBLoOJ9WIa4Ibk405hMwVEWVotrCPoLmMIPRvDSQO5cKYoauW1OsRePs=
X-Received: by 2002:a17:90a:d14f:b0:2b2:bccc:5681 with SMTP id
 98e67ed59e1d1-2b6169e3210mr75104a91.33.1715099825278; Tue, 07 May 2024
 09:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-3-andrii@kernel.org>
 <2024050439-janitor-scoff-be04@gregkh> <CAEf4BzZ6CaMrqRR1Rah7=HnTpU5-zw5HUnSH9NWCzAZZ55ZXFQ@mail.gmail.com>
 <ZjjiFnNRbwsMJ3Gj@x1> <CAEf4BzZJPY0tfLtvFA4BpQr71wO7iz-1-q16cENOAbuT1EX_og@mail.gmail.com>
 <Zjk--KLSjdg2kpic@x1>
In-Reply-To: <Zjk--KLSjdg2kpic@x1>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 09:36:52 -0700
Message-ID: <CAEf4BzZfOkw-mep-ox+1q29GTDoNeRAr0p6++7gEkCNn1Cph-g@mail.gmail.com>
Subject: Re: [PATCH 2/5] fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 1:35=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Mon, May 06, 2024 at 11:41:43AM -0700, Andrii Nakryiko wrote:
> > On Mon, May 6, 2024 at 6:58=E2=80=AFAM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > >
> > > On Sat, May 04, 2024 at 02:50:31PM -0700, Andrii Nakryiko wrote:
> > > > On Sat, May 4, 2024 at 8:28=E2=80=AFAM Greg KH <gregkh@linuxfoundat=
ion.org> wrote:
> > > > > On Fri, May 03, 2024 at 05:30:03PM -0700, Andrii Nakryiko wrote:
> > > > > > Note also, that fetching VMA name (e.g., backing file path, or =
special
> > > > > > hard-coded or user-provided names) is optional just like build =
ID. If
> > > > > > user sets vma_name_size to zero, kernel code won't attempt to r=
etrieve
> > > > > > it, saving resources.
> > >
> > > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> > > > > Where is the userspace code that uses this new api you have creat=
ed?
> > >
> > > > So I added a faithful comparison of existing /proc/<pid>/maps vs ne=
w
> > > > ioctl() API to solve a common problem (as described above) in patch
> > > > #5. The plan is to put it in mentioned blazesym library at the very
> > > > least.
> > > >
> > > > I'm sure perf would benefit from this as well (cc'ed Arnaldo and
> > > > linux-perf-user), as they need to do stack symbolization as well.
> > >
> > > At some point, when BPF iterators became a thing we thought about, II=
RC
> > > Jiri did some experimentation, but I lost track, of using BPF to
> > > synthesize PERF_RECORD_MMAP2 records for pre-existing maps, the layou=
t
> > > as in uapi/linux/perf_event.h:
> > >
> > >         /*
> > >          * The MMAP2 records are an augmented version of MMAP, they a=
dd
> > >          * maj, min, ino numbers to be used to uniquely identify each=
 mapping
> > >          *
> > >          * struct {
> > >          *      struct perf_event_header        header;
> > >          *
> > >          *      u32                             pid, tid;
> > >          *      u64                             addr;
> > >          *      u64                             len;
> > >          *      u64                             pgoff;
> > >          *      union {
> > >          *              struct {
> > >          *                      u32             maj;
> > >          *                      u32             min;
> > >          *                      u64             ino;
> > >          *                      u64             ino_generation;
> > >          *              };
> > >          *              struct {
> > >          *                      u8              build_id_size;
> > >          *                      u8              __reserved_1;
> > >          *                      u16             __reserved_2;
> > >          *                      u8              build_id[20];
> > >          *              };
> > >          *      };
> > >          *      u32                             prot, flags;
> > >          *      char                            filename[];
> > >          *      struct sample_id                sample_id;
> > >          * };
> > >          */
> > >         PERF_RECORD_MMAP2                       =3D 10,
> > >
> > >  *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
> > >
> > > As perf.data files can be used for many purposes we want them all, so=
 we
> >
> > ok, so because you want them all and you don't know which VMAs will be
> > useful or not, it's a different problem. BPF iterators will be faster
> > purely due to avoiding binary -> text -> binary conversion path, but
> > other than that you'll still retrieve all VMAs.
>
> But not using tons of syscalls to parse text data from /proc.

In terms of syscall *count* you win with 4KB text reads, there are
fewer syscalls because of this 4KB-based batching. But the cost of
syscall + amount of user-space processing is a different matter. My
benchmark in perf (see patch #5 discussion) suggests that even with
more ioctl() syscalls, perf would win here.

But I also realized that what you really need (I think, correct me if
I'm wrong) is only file-backed VMAs, because all the other ones are
not that useful for symbolization. So I'm adding a minimal change to
my code to allow the user to specify another query flag to only return
file-backed VMAs. I'm going to try it with perf code and see how that
helps. I'll post results in patch #5 thread, once I have them.

>
> > You can still do the same full VMA iteration with this new API, of
> > course, but advantages are probably smaller as you'll be retrieving a
> > full set of VMAs regardless (though it would be interesting to compare
> > anyways).
>
> sure, I can't see how it would be faster, but yeah, interesting to see
> what is the difference.

see patch #5 thread, seems like it's still a bit faster

>
> > > setup a meta data perf file descriptor to go on receiving the new mma=
ps
> > > while we read /proc/<pid>/maps, to reduce the chance of missing maps,=
 do
> > > it in parallel, etc:
> > >
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$ perf record -h 'event synthe=
sis'
> > >
> > >  Usage: perf record [<options>] [<command>]
> > >     or: perf record [<options>] -- <command> [<options>]
> > >
> > >         --num-thread-synthesize <n>
> > >                           number of threads to run for event synthesi=
s
> > >         --synth <no|all|task|mmap|cgroup>
> > >                           Fine-tune event synthesis: default=3Dall
> > >
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$
> > >
> > > For this specific initial synthesis of everything the plan, as mentio=
ned
> > > about Jiri's experiments, was to use a BPF iterator to just feed the
> > > perf ring buffer with those events, that way userspace would just
> > > receive the usual records it gets when a new mmap is put in place, th=
e
> > > BPF iterator would just feed the preexisting mmaps, as instructed via
> > > the perf_event_attr for the perf_event_open syscall.
> > >
> > > For people not wanting BPF, i.e. disabling it altogether in perf or
> > > disabling just BPF skels, then we would fallback to the current metho=
d,
> > > or to the one being discussed here when it becomes available.
> > >
> > > One thing to have in mind is for this iterator not to generate duplic=
ate
> > > records for non-pre-existing mmaps, i.e. we would need some generatio=
n
> > > number that would be bumped when asking for such pre-existing maps
> > > PERF_RECORD_MMAP2 dumps.
> >
> > Looking briefly at struct vm_area_struct, it doesn't seems like the
> > kernel maintains any sort of generation (at least not at
> > vm_area_struct level), so this would be nice to have, I'm sure, but
>
> Yeah, this would be something specific to the "retrieve me the list of
> VMAs" bulky thing, i.e. the kernel perf code (or the BPF that would
> generate the PERF_RECORD_MMAP2 records by using a BPF vma iterator)
> would bump the generation number and store it to the VMA in
> perf_event_mmap() so that the iterator doesn't consider it, as it is a
> new mmap that is being just sent to whoever is listening, and the perf
> tool that put in place the BPF program to iterate is listening.

Ok, we went on *so many* tangents in emails on this patch set :) Seems
like there are a bunch of perf-specific improvements possible which
are completely irrelevant to the API I'm proposing. Let's please keep
them separate (and you, perf folks, should propose them upstream),
it's getting hard to see what this patch set is actually about with
all the tangential emails.

>
> > isn't really related to adding this API. Once the kernel does have
>
> Well, perf wants to enumerate pre-existing mmaps _and_ after that
> finishes to know about new mmaps, so we need to know a way to avoid
> having the BPF program enumerating pre-existing maps sending
> PERF_RECORD_MMAP2 for maps perf already knows about via a regular
> PERF_RECORD_MMAP2 sent when a new mmap is put in place.
>
> So there is an overlap where perf (or any other tool wanting to
> enumerate all pre-existing maps and new ones) can receive info for the
> same map from the enumerator and from the existing mechanism generating
> PERF_RECORD_MMAP2 records.
>
> - Arnaldo
>
> > this "VMA generation" counter, it can be trivially added to this
> > binary interface (which can't be said about /proc/<pid>/maps,
> > unfortunately).
> >
> > >
> > > > It will be up to other similar projects to adopt this, but we'll
> > > > definitely get this into blazesym as it is actually a problem for t=
he
> > >
> > > At some point looking at plugging blazesym somehow with perf may be
> > > something to consider, indeed.
> >
> > In the above I meant direct use of this new API in perf code itself,
> > but yes, blazesym is a generic library for symbolization that handles
> > ELF/DWARF/GSYM (and I believe more formats), so it indeed might make
> > sense to use it.
> >
> > >
> > > - Arnaldo
> > >
> > > > abovementioned Oculus use case. We already had to make a tradeoff (=
see
> > > > [2], this wasn't done just because we could, but it was requested b=
y
> > > > Oculus customers) to cache the contents of /proc/<pid>/maps and run
> > > > the risk of missing some shared libraries that can be loaded later.=
 It
> > > > would be great to not have to do this tradeoff, which this new API
> > > > would enable.
> > > >
> > > >   [2] https://github.com/libbpf/blazesym/commit/6b521314126b3ae6f2a=
dd43e93234b59fed48ccf
> > > >
> >
> > [...]

