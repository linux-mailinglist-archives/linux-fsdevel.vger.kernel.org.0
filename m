Return-Path: <linux-fsdevel+bounces-18864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86228BD648
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 22:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0825A1C21858
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 20:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6762215B54C;
	Mon,  6 May 2024 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7Lo4B0F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F32BAE5;
	Mon,  6 May 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027709; cv=none; b=AJNRT1ViOevta6dHtr175NdSncdytL6zRlGKd3U8wkaPShfw225AXQQOJZaTaG0tGUCvb1cVAfhLWbSvdLJzKgSum5+Pld4lsWROG25U+V0plqZwLpXGMlLsz7+vAAPHAflWSnTnHZYDv0mPqy9JatirSPSJxykYF7oXeIbbV1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027709; c=relaxed/simple;
	bh=2J6q6pee6c+RhPyheJbTp0seb82usaTe/jFdcBygloQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhplaxM9XQDoMLKvo52awb1Ek94hsuiJXy9rstWQeisEnMX2OqezAXhIQy3exsfhZ7oiHMo+qAHu/9pZ9maUK4Q2g1zMNLxr0ODClkCjXp71yFnAgxkUHFKqpF1dLlvPHdmgQYGJhBfRHJ89eFFCER88cNrzkhwYPCXBCZiL/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7Lo4B0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BF0C116B1;
	Mon,  6 May 2024 20:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715027709;
	bh=2J6q6pee6c+RhPyheJbTp0seb82usaTe/jFdcBygloQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7Lo4B0FSYjHcCM/Bsy/vgbwfnsYFN1u8xq6hhk1tF2raIeVRu7efrKPanTu5Yn1h
	 NjYWiHho9RWdhZTBnQOG0SzTY39KDPg4/pP4ZqLZHde0Yyuc57THzyFOghopzYiHFw
	 YrP8o9I3qyMKwCoLCbBdV4IpLTBIIaqLvf9C5CXzfQICcpBjWPG1/Vj0wbzfHnYpZd
	 BAPA99lYtXDJGphEKGjdpGFOuCOmJkwTcTy1KaeDYermM33/4dFCg7eyUgXap8D/DE
	 xJN6P0+FTiracyjBpkwN/6lWdk6nwb8ld2iO8wYsfPybc6wPjqGlBWMbd2tGLk0skj
	 0OV6KwMUfMV8w==
Date: Mon, 6 May 2024 17:35:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-mm@kvack.org,
	Daniel =?iso-8859-1?Q?M=FCller?= <deso@posteo.net>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 2/5] fs/procfs: implement efficient VMA querying API for
 /proc/<pid>/maps
Message-ID: <Zjk--KLSjdg2kpic@x1>
References: <20240504003006.3303334-1-andrii@kernel.org>
 <20240504003006.3303334-3-andrii@kernel.org>
 <2024050439-janitor-scoff-be04@gregkh>
 <CAEf4BzZ6CaMrqRR1Rah7=HnTpU5-zw5HUnSH9NWCzAZZ55ZXFQ@mail.gmail.com>
 <ZjjiFnNRbwsMJ3Gj@x1>
 <CAEf4BzZJPY0tfLtvFA4BpQr71wO7iz-1-q16cENOAbuT1EX_og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZJPY0tfLtvFA4BpQr71wO7iz-1-q16cENOAbuT1EX_og@mail.gmail.com>

On Mon, May 06, 2024 at 11:41:43AM -0700, Andrii Nakryiko wrote:
> On Mon, May 6, 2024 at 6:58 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > On Sat, May 04, 2024 at 02:50:31PM -0700, Andrii Nakryiko wrote:
> > > On Sat, May 4, 2024 at 8:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > On Fri, May 03, 2024 at 05:30:03PM -0700, Andrii Nakryiko wrote:
> > > > > Note also, that fetching VMA name (e.g., backing file path, or special
> > > > > hard-coded or user-provided names) is optional just like build ID. If
> > > > > user sets vma_name_size to zero, kernel code won't attempt to retrieve
> > > > > it, saving resources.
> >
> > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > > > Where is the userspace code that uses this new api you have created?
> >
> > > So I added a faithful comparison of existing /proc/<pid>/maps vs new
> > > ioctl() API to solve a common problem (as described above) in patch
> > > #5. The plan is to put it in mentioned blazesym library at the very
> > > least.
> > >
> > > I'm sure perf would benefit from this as well (cc'ed Arnaldo and
> > > linux-perf-user), as they need to do stack symbolization as well.
> >
> > At some point, when BPF iterators became a thing we thought about, IIRC
> > Jiri did some experimentation, but I lost track, of using BPF to
> > synthesize PERF_RECORD_MMAP2 records for pre-existing maps, the layout
> > as in uapi/linux/perf_event.h:
> >
> >         /*
> >          * The MMAP2 records are an augmented version of MMAP, they add
> >          * maj, min, ino numbers to be used to uniquely identify each mapping
> >          *
> >          * struct {
> >          *      struct perf_event_header        header;
> >          *
> >          *      u32                             pid, tid;
> >          *      u64                             addr;
> >          *      u64                             len;
> >          *      u64                             pgoff;
> >          *      union {
> >          *              struct {
> >          *                      u32             maj;
> >          *                      u32             min;
> >          *                      u64             ino;
> >          *                      u64             ino_generation;
> >          *              };
> >          *              struct {
> >          *                      u8              build_id_size;
> >          *                      u8              __reserved_1;
> >          *                      u16             __reserved_2;
> >          *                      u8              build_id[20];
> >          *              };
> >          *      };
> >          *      u32                             prot, flags;
> >          *      char                            filename[];
> >          *      struct sample_id                sample_id;
> >          * };
> >          */
> >         PERF_RECORD_MMAP2                       = 10,
> >
> >  *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
> >
> > As perf.data files can be used for many purposes we want them all, so we
> 
> ok, so because you want them all and you don't know which VMAs will be
> useful or not, it's a different problem. BPF iterators will be faster
> purely due to avoiding binary -> text -> binary conversion path, but
> other than that you'll still retrieve all VMAs.

But not using tons of syscalls to parse text data from /proc.
 
> You can still do the same full VMA iteration with this new API, of
> course, but advantages are probably smaller as you'll be retrieving a
> full set of VMAs regardless (though it would be interesting to compare
> anyways).

sure, I can't see how it would be faster, but yeah, interesting to see
what is the difference.
 
> > setup a meta data perf file descriptor to go on receiving the new mmaps
> > while we read /proc/<pid>/maps, to reduce the chance of missing maps, do
> > it in parallel, etc:
> >
> > ⬢[acme@toolbox perf-tools-next]$ perf record -h 'event synthesis'
> >
> >  Usage: perf record [<options>] [<command>]
> >     or: perf record [<options>] -- <command> [<options>]
> >
> >         --num-thread-synthesize <n>
> >                           number of threads to run for event synthesis
> >         --synth <no|all|task|mmap|cgroup>
> >                           Fine-tune event synthesis: default=all
> >
> > ⬢[acme@toolbox perf-tools-next]$
> >
> > For this specific initial synthesis of everything the plan, as mentioned
> > about Jiri's experiments, was to use a BPF iterator to just feed the
> > perf ring buffer with those events, that way userspace would just
> > receive the usual records it gets when a new mmap is put in place, the
> > BPF iterator would just feed the preexisting mmaps, as instructed via
> > the perf_event_attr for the perf_event_open syscall.
> >
> > For people not wanting BPF, i.e. disabling it altogether in perf or
> > disabling just BPF skels, then we would fallback to the current method,
> > or to the one being discussed here when it becomes available.
> >
> > One thing to have in mind is for this iterator not to generate duplicate
> > records for non-pre-existing mmaps, i.e. we would need some generation
> > number that would be bumped when asking for such pre-existing maps
> > PERF_RECORD_MMAP2 dumps.
> 
> Looking briefly at struct vm_area_struct, it doesn't seems like the
> kernel maintains any sort of generation (at least not at
> vm_area_struct level), so this would be nice to have, I'm sure, but

Yeah, this would be something specific to the "retrieve me the list of
VMAs" bulky thing, i.e. the kernel perf code (or the BPF that would
generate the PERF_RECORD_MMAP2 records by using a BPF vma iterator)
would bump the generation number and store it to the VMA in
perf_event_mmap() so that the iterator doesn't consider it, as it is a
new mmap that is being just sent to whoever is listening, and the perf
tool that put in place the BPF program to iterate is listening.

> isn't really related to adding this API. Once the kernel does have

Well, perf wants to enumerate pre-existing mmaps _and_ after that
finishes to know about new mmaps, so we need to know a way to avoid
having the BPF program enumerating pre-existing maps sending
PERF_RECORD_MMAP2 for maps perf already knows about via a regular
PERF_RECORD_MMAP2 sent when a new mmap is put in place.

So there is an overlap where perf (or any other tool wanting to
enumerate all pre-existing maps and new ones) can receive info for the
same map from the enumerator and from the existing mechanism generating
PERF_RECORD_MMAP2 records.

- Arnaldo

> this "VMA generation" counter, it can be trivially added to this
> binary interface (which can't be said about /proc/<pid>/maps,
> unfortunately).
> 
> >
> > > It will be up to other similar projects to adopt this, but we'll
> > > definitely get this into blazesym as it is actually a problem for the
> >
> > At some point looking at plugging blazesym somehow with perf may be
> > something to consider, indeed.
> 
> In the above I meant direct use of this new API in perf code itself,
> but yes, blazesym is a generic library for symbolization that handles
> ELF/DWARF/GSYM (and I believe more formats), so it indeed might make
> sense to use it.
> 
> >
> > - Arnaldo
> >
> > > abovementioned Oculus use case. We already had to make a tradeoff (see
> > > [2], this wasn't done just because we could, but it was requested by
> > > Oculus customers) to cache the contents of /proc/<pid>/maps and run
> > > the risk of missing some shared libraries that can be loaded later. It
> > > would be great to not have to do this tradeoff, which this new API
> > > would enable.
> > >
> > >   [2] https://github.com/libbpf/blazesym/commit/6b521314126b3ae6f2add43e93234b59fed48ccf
> > >
> 
> [...]

