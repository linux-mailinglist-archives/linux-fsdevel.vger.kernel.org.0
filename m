Return-Path: <linux-fsdevel+bounces-18854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7D98BD4BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 20:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4AFB239CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 18:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9808158D8B;
	Mon,  6 May 2024 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7i+8GA+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6B1E4A6;
	Mon,  6 May 2024 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715020918; cv=none; b=A0Qp+5ImvF5vFEFHvAT9F1d4XGYsqc2r9OtZdlxzIXf+mZTFg52wM4QMdfFkwRWKuYZMJRkkw0KiGNu37/VWzEhWjGTupqNef/WuuXQASJKHe012Pmg46SWBLnaxUpWFgkVx3SfVpiIaZ6NE3G4OH80BKL887ojbdkhB677xUjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715020918; c=relaxed/simple;
	bh=tCKuk3qiNlN7CQiFoVHXwNs6NO9F2MdMtkXvWzlMPFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G44iMEJtPjd+Ug+3LFN/0s+7Yk/s9XuOtxqKYhjyHK7qme1ycPo8ib0RFpRUYui5nhmAnaOuFwSfvCJIsnFsbqYkRVuyPBtCaufcYg3LGFkYwNyL2RgP6PfXEmClobzol9vG/Jl9tafVHFs8bMYNyhL89ing7UoUZ5yGe6cfkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7i+8GA+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b27c532e50so1563537a91.2;
        Mon, 06 May 2024 11:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715020916; x=1715625716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDT08fGLSf2RPyvvgFwElfxPpKeZ2KDPZFIEHKmSIzs=;
        b=V7i+8GA+JJSItd0504xSx/TGhtTKXuh1YY39xfiv6iJ9rswcbdDMiXMBM9+ulXwXKW
         OPnOcwEAp5s02mOwsOUWjxSWYIMLKz7r5SUBHettq0z+OKWh/FpMRJAZQWPwd6NRBc0R
         wWjvrCTHidoP1CgSy3J/bfGTGmK1M/WWaBfJf2aGrvxWf/1j5oTLnHN/a1aZpNrLwqrV
         vNFSfD0l17ok4tdCc+ZBQKpPHd0QcH3ITNUn5ZCsVuabklKT5DCkAuNg3LmgjrlK7/cW
         VvxbV4x1pK2wfvGl12K0o6MalotVXUMxqgEr76rBsxLsqC/whh4B8o9KjlpcqlATZEre
         akyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715020916; x=1715625716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDT08fGLSf2RPyvvgFwElfxPpKeZ2KDPZFIEHKmSIzs=;
        b=Vz3za6mbK2Q8A1wSdo07dfrfxN/F+PtbIAQ+Cw9MAS7yVFvWs0EvDEIdoUkhA89JO8
         feMOV+GYXRNjQkiq9Lpxw6FEPtUDkPqhtLE4sXCqo3OLumzm9GRaHWYtSMgs6azbxhyN
         PsbX6e0Bhq8d6DoQ5p07l0pHGr/3Cd3ow7K/PRtdhXatS3tplYxxjzJC/uatFoVuQNfj
         JDF6wyQEMsAJEKaHtliApXUQyiHnPXC8YUUN5JpH859+ccvSMJe6z/pSxRSjRezE+TNk
         MxmwppeSeD6HZB0GeuFXBbMiY0Cmhgy8QIq3Zv5pXQY0ag1m3WPujov5TuehDKjktaxb
         zDdw==
X-Forwarded-Encrypted: i=1; AJvYcCWfeskKqJvkkOqqPxnBb2+qvgWFWlkZf3vtIsjJvlSaodMLDXO3g8dyjJcQ9x86AuPkRkcZ/eqwHeWlp8vyRkpjmUqiYLyP04wn4cvjCLlpEO+kuh4ctUPt/NkHeu8muES3SBMn09BmdxFF15rsaCGoVpZw/cMuQYd+R+KNthl0AVFUXJE4nr/m/S6ycOAxwElwmOo8jUKOccnhvf7ev3WB5N4=
X-Gm-Message-State: AOJu0Yyyr1GPX7fZTseVW6xr6+D4mp+2jZHjYXka9+ZFBj+ucJzrnpye
	fQq9aXijvrewB03oFVhYKLeEC1YMRmzjB7GefctL2MdyNUFrDE76iFREi7QwRSxRzCLOjG/yZnC
	rHo3brbQk+oL1mTyV8P8pnV1KzPc=
X-Google-Smtp-Source: AGHT+IEq8YJ8t3nZxov6z/S/yodKgD4MkoqlfVjkFRMcrQLNqghPuv506Yqi8eDx0lXPNLzjdJtrkfZWZUjCuGvHfnI=
X-Received: by 2002:a17:90b:1058:b0:2b1:e314:a5e6 with SMTP id
 gq24-20020a17090b105800b002b1e314a5e6mr10307940pjb.7.1715020915838; Mon, 06
 May 2024 11:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-3-andrii@kernel.org>
 <2024050439-janitor-scoff-be04@gregkh> <CAEf4BzZ6CaMrqRR1Rah7=HnTpU5-zw5HUnSH9NWCzAZZ55ZXFQ@mail.gmail.com>
 <ZjjiFnNRbwsMJ3Gj@x1>
In-Reply-To: <ZjjiFnNRbwsMJ3Gj@x1>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 May 2024 11:41:43 -0700
Message-ID: <CAEf4BzZJPY0tfLtvFA4BpQr71wO7iz-1-q16cENOAbuT1EX_og@mail.gmail.com>
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

On Mon, May 6, 2024 at 6:58=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Sat, May 04, 2024 at 02:50:31PM -0700, Andrii Nakryiko wrote:
> > On Sat, May 4, 2024 at 8:28=E2=80=AFAM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > > On Fri, May 03, 2024 at 05:30:03PM -0700, Andrii Nakryiko wrote:
> > > > Note also, that fetching VMA name (e.g., backing file path, or spec=
ial
> > > > hard-coded or user-provided names) is optional just like build ID. =
If
> > > > user sets vma_name_size to zero, kernel code won't attempt to retri=
eve
> > > > it, saving resources.
>
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> > > Where is the userspace code that uses this new api you have created?
>
> > So I added a faithful comparison of existing /proc/<pid>/maps vs new
> > ioctl() API to solve a common problem (as described above) in patch
> > #5. The plan is to put it in mentioned blazesym library at the very
> > least.
> >
> > I'm sure perf would benefit from this as well (cc'ed Arnaldo and
> > linux-perf-user), as they need to do stack symbolization as well.
>
> At some point, when BPF iterators became a thing we thought about, IIRC
> Jiri did some experimentation, but I lost track, of using BPF to
> synthesize PERF_RECORD_MMAP2 records for pre-existing maps, the layout
> as in uapi/linux/perf_event.h:
>
>         /*
>          * The MMAP2 records are an augmented version of MMAP, they add
>          * maj, min, ino numbers to be used to uniquely identify each map=
ping
>          *
>          * struct {
>          *      struct perf_event_header        header;
>          *
>          *      u32                             pid, tid;
>          *      u64                             addr;
>          *      u64                             len;
>          *      u64                             pgoff;
>          *      union {
>          *              struct {
>          *                      u32             maj;
>          *                      u32             min;
>          *                      u64             ino;
>          *                      u64             ino_generation;
>          *              };
>          *              struct {
>          *                      u8              build_id_size;
>          *                      u8              __reserved_1;
>          *                      u16             __reserved_2;
>          *                      u8              build_id[20];
>          *              };
>          *      };
>          *      u32                             prot, flags;
>          *      char                            filename[];
>          *      struct sample_id                sample_id;
>          * };
>          */
>         PERF_RECORD_MMAP2                       =3D 10,
>
>  *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
>
> As perf.data files can be used for many purposes we want them all, so we

ok, so because you want them all and you don't know which VMAs will be
useful or not, it's a different problem. BPF iterators will be faster
purely due to avoiding binary -> text -> binary conversion path, but
other than that you'll still retrieve all VMAs.

You can still do the same full VMA iteration with this new API, of
course, but advantages are probably smaller as you'll be retrieving a
full set of VMAs regardless (though it would be interesting to compare
anyways).

> setup a meta data perf file descriptor to go on receiving the new mmaps
> while we read /proc/<pid>/maps, to reduce the chance of missing maps, do
> it in parallel, etc:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ perf record -h 'event synthesis'
>
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
>
>         --num-thread-synthesize <n>
>                           number of threads to run for event synthesis
>         --synth <no|all|task|mmap|cgroup>
>                           Fine-tune event synthesis: default=3Dall
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> For this specific initial synthesis of everything the plan, as mentioned
> about Jiri's experiments, was to use a BPF iterator to just feed the
> perf ring buffer with those events, that way userspace would just
> receive the usual records it gets when a new mmap is put in place, the
> BPF iterator would just feed the preexisting mmaps, as instructed via
> the perf_event_attr for the perf_event_open syscall.
>
> For people not wanting BPF, i.e. disabling it altogether in perf or
> disabling just BPF skels, then we would fallback to the current method,
> or to the one being discussed here when it becomes available.
>
> One thing to have in mind is for this iterator not to generate duplicate
> records for non-pre-existing mmaps, i.e. we would need some generation
> number that would be bumped when asking for such pre-existing maps
> PERF_RECORD_MMAP2 dumps.

Looking briefly at struct vm_area_struct, it doesn't seems like the
kernel maintains any sort of generation (at least not at
vm_area_struct level), so this would be nice to have, I'm sure, but
isn't really related to adding this API. Once the kernel does have
this "VMA generation" counter, it can be trivially added to this
binary interface (which can't be said about /proc/<pid>/maps,
unfortunately).

>
> > It will be up to other similar projects to adopt this, but we'll
> > definitely get this into blazesym as it is actually a problem for the
>
> At some point looking at plugging blazesym somehow with perf may be
> something to consider, indeed.

In the above I meant direct use of this new API in perf code itself,
but yes, blazesym is a generic library for symbolization that handles
ELF/DWARF/GSYM (and I believe more formats), so it indeed might make
sense to use it.

>
> - Arnaldo
>
> > abovementioned Oculus use case. We already had to make a tradeoff (see
> > [2], this wasn't done just because we could, but it was requested by
> > Oculus customers) to cache the contents of /proc/<pid>/maps and run
> > the risk of missing some shared libraries that can be loaded later. It
> > would be great to not have to do this tradeoff, which this new API
> > would enable.
> >
> >   [2] https://github.com/libbpf/blazesym/commit/6b521314126b3ae6f2add43=
e93234b59fed48ccf
> >

[...]

