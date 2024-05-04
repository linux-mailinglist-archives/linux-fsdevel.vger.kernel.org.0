Return-Path: <linux-fsdevel+bounces-18741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E468BBE42
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 23:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182902821E8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 21:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93FE84D2D;
	Sat,  4 May 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViuPn8C1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6117578;
	Sat,  4 May 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714859449; cv=none; b=DIMJ7D+DVqU/sPTJOYBp6ATBQr1Z6k01fZU891auq31Jp2DQgVvTB0ouK+Pl4Uz1VXDLxBTMcF6XFkRsuIIwYJUkpKtBryA+D8wsfYtViEaVEfp1W8/5mJVotfRyw7XxCgh7P9v2sxKf/SxNAK8+g2hDzBAfb3FHhqwzdM7HXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714859449; c=relaxed/simple;
	bh=YdKGTjzi5rEE7CK6JG7leHSzP7OJ1x602zK/n6ZsKQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVL6Bt3XwqWrIaeXufr9aRWSV2x58LtUwsFXjKqs12fCxQFyKX8zUnFdzlj286DHHnNtluQhOB1TEr+DEEuxat14G3YN02f9aJqEmY9twa3NwhzTMsebuessGAW95JdWRxyW1BX/bz0lPDl5uE0gDwr+EQqe90RdxIFNzCbLB5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViuPn8C1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b433dd2566so524118a91.2;
        Sat, 04 May 2024 14:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714859446; x=1715464246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ejg0fu7/prBtogEiDQzPz1cjfahSixT9lFvA3m8FfAI=;
        b=ViuPn8C1tx4AynApdDa0OX9UksvG6TtyGChkRvth/2CSdnl99TNpFlGDDti9uG6G7i
         WSn49ieMGVTuWkUK9kXtdiy2cTrUTp4N1cWs8tiNZ1RIyFkSsiXaiVMqzv79Zzw4nVEe
         BaOHDXyyKfjwnxIZRxBP/dMRB66nkC1kbKnCL7N1FpBgoBMHKfIZ1qg47+JH/yN4/CHO
         0hCi5IOjz69qIg7oJsroqD/F2TNCbx0qQ1p6yU9X7jkV/Gq0clubXpLn4n1uLStC1zt/
         CasPwZy+9iCmCTYO4FyANW5Kz5V+RWJOf/UKyg77KWb4wPCmzLM6O/7odRTnfyw/3AXQ
         V2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714859446; x=1715464246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ejg0fu7/prBtogEiDQzPz1cjfahSixT9lFvA3m8FfAI=;
        b=A0MMikcAqRkvHdZaySLCkSq1S407s+ikth5L6LMPEb7EdqZ6lGtzUPs6eKWBQnFH26
         3bi9Lm3Va/Ee6yUTHvDbKhKypmHS8ixiFgNCYQMJkk4Oztj/gPIj09/yQ5Gq0qG3LTS1
         Ra+7OWkcRnnpWcHW9G5Mzzghg+hAesmx2sFwGkmyMpICTo+KQBcgiXPgDxOOMNRQnpuj
         DnwmTmx8ByOoXUlMqP6JBiDiCvkLgxkiJNFvqRzvfhne4mj5oHBIe8K+y5ldJj/ou2iN
         JhE8Jp5LasjDktEEdmgGE6tg+G1Ci1X8nz2zaHmDUJeXYA2Wgdf1f5OD3c6AQSqrCdxJ
         UzuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr7XLID8BAQRv7788gMFRMa1WECTR1DeESWnXjuk0Aq6xFhSW7aUE3ZJeiRsDlIGKwP4UtrjmXinYPivELmRHX2V53FMJn6RJuVKDl84jRRhVp3sp2ct+Ftw2EiKe2LjDqbZe0PTF17Qfv/0+4hUfMxj+LnOSJV5oUFwUVQS9RaI2bol4D7AWG+4hYD8ved+5pt7TomR7vDNIXghsT5LUmA9s=
X-Gm-Message-State: AOJu0Yz7+750Xv0A05+NVJRRg46twpMGTiEux2yMMKtN0O4GUrQXxfm1
	z4TA/H77ty9AqEqIuFtwNtNRwXlpNdMaoX3yG6YZ6cM5P1qBis5sMtPdaRilYnGB59cBkmPJNYO
	2KXMePdJuuDEU2azz3USD/hFgjUo=
X-Google-Smtp-Source: AGHT+IHufq2onia8j4Kt0i/U4oeahwMO2ZeZFVGtraQRjJx8+yzYRusR/7EPfenzaVH8uhK1idzM391R+qa29hzcraQ=
X-Received: by 2002:a17:90b:534e:b0:2b4:fcfd:780e with SMTP id
 su14-20020a17090b534e00b002b4fcfd780emr559092pjb.49.1714859445735; Sat, 04
 May 2024 14:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-3-andrii@kernel.org>
 <2024050439-janitor-scoff-be04@gregkh>
In-Reply-To: <2024050439-janitor-scoff-be04@gregkh>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 4 May 2024 14:50:31 -0700
Message-ID: <CAEf4BzZ6CaMrqRR1Rah7=HnTpU5-zw5HUnSH9NWCzAZZ55ZXFQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 8:28=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, May 03, 2024 at 05:30:03PM -0700, Andrii Nakryiko wrote:
> > /proc/<pid>/maps file is extremely useful in practice for various tasks
> > involving figuring out process memory layout, what files are backing an=
y
> > given memory range, etc. One important class of applications that
> > absolutely rely on this are profilers/stack symbolizers. They would
> > normally capture stack trace containing absolute memory addresses of
> > some functions, and would then use /proc/<pid>/maps file to file
> > corresponding backing ELF files, file offsets within them, and then
> > continue from there to get yet more information (ELF symbols, DWARF
> > information) to get human-readable symbolic information.
> >
> > As such, there are both performance and correctness requirement
> > involved. This address to VMA information translation has to be done as
> > efficiently as possible, but also not miss any VMA (especially in the
> > case of loading/unloading shared libraries).
> >
> > Unfortunately, for all the /proc/<pid>/maps file universality and
> > usefulness, it doesn't fit the above 100%.
>
> Is this a new change or has it always been this way?
>

Probably always has been this way. My first exposure to profiling and
stack symbolization was about 7 years ago, and already then
/proc/<pid>/maps was the only way to do this, and not a 100% fit even
then.

> > First, it's text based, which makes its programmatic use from
> > applications and libraries unnecessarily cumbersome and slow due to the
> > need to do text parsing to get necessary pieces of information.
>
> slow in what way?  How has it never been noticed before as a problem?

It's just inherently slower to parse text to fish out a bunch of
integers (vma_start address, offset, inode+dev and file paths are
typical pieces needed to "normalize" captured stack trace addresses).
It's not too bad in terms of programming and performance for
scanf-like APIs, but without scanf, you are dealing with splitting by
whitespaces and tons of unnecessary string allocations.

It was noticed, I think people using this for profiling/symbolization
are not necessarily well versed in kernel development and they just
get by with what kernel provides.

>
> And exact numbers are appreciated please, yes open/read/close seems
> slower than open/ioctl/close, but is it really overall an issue in the
> real world for anything?
>
> Text apis are good as everyone can handle them, ioctls are harder for
> obvious reasons.

Yes, and acknowledged the usefulness of text-based interface. But it's
my (and other people I've talked with that had to deal with these
textual interfaces) opinion that using binary interfaces are far
superior when it comes to *programmatic* usage (i.e., from
C/C++/Rust/whatever languages directly). Textual is great for bash
scripts and human debugging, of course.

>
> > Second, it's main purpose is to emit all VMAs sequentially, but in
> > practice captured addresses would fall only into a small subset of all
> > process' VMAs, mainly containing executable text. Yet, library would
> > need to parse most or all of the contents to find needed VMAs, as there
> > is no way to skip VMAs that are of no use. Efficient library can do the
> > linear pass and it is still relatively efficient, but it's definitely a=
n
> > overhead that can be avoided, if there was a way to do more targeted
> > querying of the relevant VMA information.
>
> I don't understand, is this a bug in the current files?  If so, why not
> just fix that up?
>

It's not a bug, I think /proc/<pid>/maps was targeted to describe
*entire* address space, but for profiling and symbolization needs we
need to find only a small subset of relevant VMAs. There is nothing
wrong with existing implementation, it's just not a 100% fit for the
more specialized "let's find relevant VMAs for this set of addresses"
problem.

> And again "efficient" need to be quantified.

You probably saw patch #5 where I solve exactly the same problem in
two different ways. And the problem is typical for symbolization: you
are given a bunch of addresses within some process, we need to find
files they belong to and what file offset they are mapped to. This is
then used to, for example, match them to ELF symbols representing
functions.

>
> > Another problem when writing generic stack trace symbolization library
> > is an unfortunate performance-vs-correctness tradeoff that needs to be
> > made.
>
> What requirement has caused a "generic stack trace symbolization
> library" to be needed at all?  What is the problem you are trying to
> solve that is not already solved by existing tools?

Capturing stack trace is a very common part, especially for BPF-based
tools and applications. E.g., bpftrace allows one to capture stack
traces for some "interesting events" (whatever that is, some kernel
function call, user function call, perf event, there is tons of
flexibility). Stack traces answer "how did we get here", but it's just
an array of addresses, which need to be translated to something that
humans can make sense of.

That's what the symbolization library is helping with. This process is
multi-step, quite involved, hard to get right with a good balance of
efficiency, correctness and fullness of information (there is always a
choice of doing simplistic symbolization using just ELF symbols, or
much more expensive but also fuller symbolization using DWARF
information, which gives also file name + line number information, can
symbolize inlined functions, etc).

One such library is blazesym ([0], cc'ed Daniel, who's working on it),
which is developed by Meta for both internal use in our fleet-wide
profiler, and is also in the process of being integrated into bpftrace
(to improve bpftrace's current somewhat limited symbolization approach
based on BCC). There is also a non-Meta project (I believe Datadog)
that is using it for its own needs.

Symbolization is quite a common task, that's highly non-trivial.

  [0] https://github.com/libbpf/blazesym

>
> > Library has to make a decision to either cache parsed contents of
> > /proc/<pid>/maps for service future requests (if application requests t=
o
> > symbolize another set of addresses, captured at some later time, which
> > is typical for periodic/continuous profiling cases) to avoid higher
> > costs of needed to re-parse this file or caching the contents in memory
> > to speed up future requests. In the former case, more memory is used fo=
r
> > the cache and there is a risk of getting stale data if application
> > loaded/unloaded shared libraries, or otherwise changed its set of VMAs
> > through additiona mmap() calls (and other means of altering memory
> > address space). In the latter case, it's the performance hit that comes
> > from re-opening the file and re-reading/re-parsing its contents all ove=
r
> > again.
>
> Again, "performance hit" needs to be justified, it shouldn't be much
> overall.

I'm not sure how to answer whether it's much or not. Can you be a bit
more specific on what you'd like to see?

But I want to say that sensitivity to any overhead differs a lot
depending on specifics. As general rule, we try to minimize any
resource usage of the profiler/symbolizer itself on the host that is
being profiled, to minimize the disruption of the production workload.
So anything that can be done to optimize any part of the overall
profiling process is a benefit.

But while for big servers tolerance might be higher in terms of
re-opening and re-parsing a bunch of text files, we also have use
cases on much less powerful and very performance sensitive Oculus VR
devices, for example. There, any extra piece of work is scrutinized,
so having to parse text on those relatively weak devices does add up.
Enough to spend effort to optimize text parsing in blazesym's Rust
code (see [1] for recent improvements).

  [1] https://github.com/libbpf/blazesym/pull/643/commits/b89b91b42b994b135=
a0079bf04b2319c0054f745

>
> > This patch aims to solve this problem by providing a new API built on
> > top of /proc/<pid>/maps. It is ioctl()-based and built as a binary
> > interface, avoiding the cost and awkwardness of textual representation
> > for programmatic use.
>
> Some people find text easier to handle for programmatic use :)

I don't disagree, but pretty much everyone I discussed having to deal
with text-based kernel APIs are pretty uniformly in favor of
binary-based interfaces, if they are available.

But note, I'm not proposing to deprecate or remove text-based
/proc/<pid>/maps. And the main point of this work is not so much
binary vs text, as more selecting "point-based" querying capability as
opposed to the "iterate everything" approach of /proc/<pid>/maps.

>
> > It's designed to be extensible and
> > forward/backward compatible by including user-specified field size and
> > using copy_struct_from_user() approach. But, most importantly, it allow=
s
> > to do point queries for specific single address, specified by user. And
> > this is done efficiently using VMA iterator.
>
> Ok, maybe this is the main issue, you only want one at a time?

Yes. More or less, I need "a few" that cover a captured set of addresses.

>
> > User has a choice to pick either getting VMA that covers provided
> > address or -ENOENT if none is found (exact, least surprising, case). Or=
,
> > with an extra query flag (PROCFS_PROCMAP_EXACT_OR_NEXT_VMA), they can
> > get either VMA that covers the address (if there is one), or the closes=
t
> > next VMA (i.e., VMA with the smallest vm_start > addr). The later allow=
s
> > more efficient use, but, given it could be a surprising behavior,
> > requires an explicit opt-in.
> >
> > Basing this ioctl()-based API on top of /proc/<pid>/maps's FD makes
> > sense given it's querying the same set of VMA data. All the permissions
> > checks performed on /proc/<pid>/maps opening fit here as well.
> > ioctl-based implementation is fetching remembered mm_struct reference,
> > but otherwise doesn't interfere with seq_file-based implementation of
> > /proc/<pid>/maps textual interface, and so could be used together or
> > independently without paying any price for that.
> >
> > There is one extra thing that /proc/<pid>/maps doesn't currently
> > provide, and that's an ability to fetch ELF build ID, if present. User
> > has control over whether this piece of information is requested or not
> > by either setting build_id_size field to zero or non-zero maximum buffe=
r
> > size they provided through build_id_addr field (which encodes user
> > pointer as __u64 field).
> >
> > The need to get ELF build ID reliably is an important aspect when
> > dealing with profiling and stack trace symbolization, and
> > /proc/<pid>/maps textual representation doesn't help with this,
> > requiring applications to open underlying ELF binary through
> > /proc/<pid>/map_files/<start>-<end> symlink, which adds an extra
> > permissions implications due giving a full access to the binary from
> > (potentially) another process, while all application is interested in i=
s
> > build ID. Giving an ability to request just build ID doesn't introduce
> > any additional security concerns, on top of what /proc/<pid>/maps is
> > already concerned with, simplifying the overall logic.
> >
> > Kernel already implements build ID fetching, which is used from BPF
> > subsystem. We are reusing this code here, but plan a follow up changes
> > to make it work better under more relaxed assumption (compared to what
> > existing code assumes) of being called from user process context, in
> > which page faults are allowed. BPF-specific implementation currently
> > bails out if necessary part of ELF file is not paged in, all due to
> > extra BPF-specific restrictions (like the need to fetch build ID in
> > restrictive contexts such as NMI handler).
> >
> > Note also, that fetching VMA name (e.g., backing file path, or special
> > hard-coded or user-provided names) is optional just like build ID. If
> > user sets vma_name_size to zero, kernel code won't attempt to retrieve
> > it, saving resources.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Where is the userspace code that uses this new api you have created?

So I added a faithful comparison of existing /proc/<pid>/maps vs new
ioctl() API to solve a common problem (as described above) in patch
#5. The plan is to put it in mentioned blazesym library at the very
least.

I'm sure perf would benefit from this as well (cc'ed Arnaldo and
linux-perf-user), as they need to do stack symbolization as well.

It will be up to other similar projects to adopt this, but we'll
definitely get this into blazesym as it is actually a problem for the
abovementioned Oculus use case. We already had to make a tradeoff (see
[2], this wasn't done just because we could, but it was requested by
Oculus customers) to cache the contents of /proc/<pid>/maps and run
the risk of missing some shared libraries that can be loaded later. It
would be great to not have to do this tradeoff, which this new API
would enable.

  [2] https://github.com/libbpf/blazesym/commit/6b521314126b3ae6f2add43e932=
34b59fed48ccf

>
> > ---
> >  fs/proc/task_mmu.c      | 165 ++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/fs.h |  32 ++++++++
> >  2 files changed, 197 insertions(+)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 8e503a1635b7..cb7b1ff1a144 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/pkeys.h>
> >  #include <linux/minmax.h>
> >  #include <linux/overflow.h>
> > +#include <linux/buildid.h>
> >
> >  #include <asm/elf.h>
> >  #include <asm/tlb.h>
> > @@ -375,11 +376,175 @@ static int pid_maps_open(struct inode *inode, st=
ruct file *file)
> >       return do_maps_open(inode, file, &proc_pid_maps_op);
> >  }
> >
> > +static int do_procmap_query(struct proc_maps_private *priv, void __use=
r *uarg)
> > +{
> > +     struct procfs_procmap_query karg;
> > +     struct vma_iterator iter;
> > +     struct vm_area_struct *vma;
> > +     struct mm_struct *mm;
> > +     const char *name =3D NULL;
> > +     char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf =3D NULL;
> > +     __u64 usize;
> > +     int err;
> > +
> > +     if (copy_from_user(&usize, (void __user *)uarg, sizeof(usize)))
> > +             return -EFAULT;
> > +     if (usize > PAGE_SIZE)
>
> Nice, where did you document that?  And how is that portable given that
> PAGE_SIZE can be different on different systems?

I'm happy to document everything, can you please help by pointing
where this documentation has to live?

This is mostly fool-proofing, though, because the user has to pass
sizeof(struct procfs_procmap_query), which I don't see ever getting
close to even 4KB (not even saying about 64KB). This is just to
prevent copy_struct_from_user() below to do too much zero-checking.

>
> and why aren't you checking the actual structure size instead?  You can
> easily run off the end here without knowing it.

See copy_struct_from_user(), it does more checks. This is a helper
designed specifically to deal with use cases like this where kernel
struct size can change and user space might be newer or older.
copy_struct_from_user() has a nice documentation describing all these
nuances.

>
> > +             return -E2BIG;
> > +     if (usize < offsetofend(struct procfs_procmap_query, query_addr))
> > +             return -EINVAL;
>
> Ok, so you have two checks?  How can the first one ever fail?

Hmm.. If usize =3D 8, copy_from_user() won't fail, usize > PAGE_SIZE
won't fail, but this one will fail.

The point of this check is that user has to specify at least first
three fields of procfs_procmap_query (size, query_flags, and
query_addr), because without those the query is meaningless.
>
>
> > +     err =3D copy_struct_from_user(&karg, sizeof(karg), uarg, usize);

and this helper does more checks validating that the user either has a
shorter struct (and then zero-fills the rest of kernel-side struct) or
has longer (and then the longer part has to be zero filled). Do check
copy_struct_from_user() documentation, it's great.

> > +     if (err)
> > +             return err;
> > +
> > +     if (karg.query_flags & ~PROCFS_PROCMAP_EXACT_OR_NEXT_VMA)
> > +             return -EINVAL;
> > +     if (!!karg.vma_name_size !=3D !!karg.vma_name_addr)
> > +             return -EINVAL;
> > +     if (!!karg.build_id_size !=3D !!karg.build_id_addr)
> > +             return -EINVAL;
>
> So you want values to be set, right?

Either both should be set, or neither. It's ok for both size/addr
fields to be zero, in which case it indicates that the user doesn't
want this part of information (which is usually a bit more expensive
to get and might not be necessary for all the cases).

>
> > +
> > +     mm =3D priv->mm;
> > +     if (!mm || !mmget_not_zero(mm))
> > +             return -ESRCH;
>
> What is this error for?  Where is this documentned?

I copied it from existing /proc/<pid>/maps checks. I presume it's
guarding the case when mm might be already put. So if the process is
gone, but we have /proc/<pid>/maps file open?

>
> > +     if (mmap_read_lock_killable(mm)) {
> > +             mmput(mm);
> > +             return -EINTR;
> > +     }
> > +
> > +     vma_iter_init(&iter, mm, karg.query_addr);
> > +     vma =3D vma_next(&iter);
> > +     if (!vma) {
> > +             err =3D -ENOENT;
> > +             goto out;
> > +     }
> > +     /* user wants covering VMA, not the closest next one */
> > +     if (!(karg.query_flags & PROCFS_PROCMAP_EXACT_OR_NEXT_VMA) &&
> > +         vma->vm_start > karg.query_addr) {
> > +             err =3D -ENOENT;
> > +             goto out;
> > +     }
> > +
> > +     karg.vma_start =3D vma->vm_start;
> > +     karg.vma_end =3D vma->vm_end;
> > +
> > +     if (vma->vm_file) {
> > +             const struct inode *inode =3D file_user_inode(vma->vm_fil=
e);
> > +
> > +             karg.vma_offset =3D ((__u64)vma->vm_pgoff) << PAGE_SHIFT;
> > +             karg.dev_major =3D MAJOR(inode->i_sb->s_dev);
> > +             karg.dev_minor =3D MINOR(inode->i_sb->s_dev);
>
> So the major/minor is that of the file superblock?  Why?

Because inode number is unique only within given super block (and even
then it's more complicated, e.g., btrfs subvolumes add more headaches,
I believe). inode + dev maj/min is sometimes used for cache/reuse of
per-binary information (e.g., pre-processed DWARF information, which
is *very* expensive, so anything that allows to avoid doing this is
helpful).

>
> > +             karg.inode =3D inode->i_ino;
>
> What is userspace going to do with this?
>

See above.

> > +     } else {
> > +             karg.vma_offset =3D 0;
> > +             karg.dev_major =3D 0;
> > +             karg.dev_minor =3D 0;
> > +             karg.inode =3D 0;
>
> Why not set everything to 0 up above at the beginning so you never miss
> anything, and you don't miss any holes accidentally in the future.
>

Stylistic preference, I find this more explicit, but I don't care much
one way or another.

> > +     }
> > +
> > +     karg.vma_flags =3D 0;
> > +     if (vma->vm_flags & VM_READ)
> > +             karg.vma_flags |=3D PROCFS_PROCMAP_VMA_READABLE;
> > +     if (vma->vm_flags & VM_WRITE)
> > +             karg.vma_flags |=3D PROCFS_PROCMAP_VMA_WRITABLE;
> > +     if (vma->vm_flags & VM_EXEC)
> > +             karg.vma_flags |=3D PROCFS_PROCMAP_VMA_EXECUTABLE;
> > +     if (vma->vm_flags & VM_MAYSHARE)
> > +             karg.vma_flags |=3D PROCFS_PROCMAP_VMA_SHARED;
> > +

[...]

> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 45e4e64fd664..fe8924a8d916 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -393,4 +393,36 @@ struct pm_scan_arg {
> >       __u64 return_mask;
> >  };
> >
> > +/* /proc/<pid>/maps ioctl */
> > +#define PROCFS_IOCTL_MAGIC 0x9f
>
> Don't you need to document this in the proper place?

I probably do, but I'm asking for help in knowing where. procfs is not
a typical area of kernel I'm working with, so any pointers are highly
appreciated.

>
> > +#define PROCFS_PROCMAP_QUERY _IOWR(PROCFS_IOCTL_MAGIC, 1, struct procf=
s_procmap_query)
> > +
> > +enum procmap_query_flags {
> > +     PROCFS_PROCMAP_EXACT_OR_NEXT_VMA =3D 0x01,
> > +};
> > +
> > +enum procmap_vma_flags {
> > +     PROCFS_PROCMAP_VMA_READABLE =3D 0x01,
> > +     PROCFS_PROCMAP_VMA_WRITABLE =3D 0x02,
> > +     PROCFS_PROCMAP_VMA_EXECUTABLE =3D 0x04,
> > +     PROCFS_PROCMAP_VMA_SHARED =3D 0x08,
>
> Are these bits?  If so, please use the bit macro for it to make it
> obvious.
>

Yes, they are. When I tried BIT(1), it didn't compile. I chose not to
add any extra #includes to this UAPI header, but I can figure out the
necessary dependency and do BIT(), I just didn't feel like BIT() adds
much here, tbh.

> > +};
> > +
> > +struct procfs_procmap_query {
> > +     __u64 size;
> > +     __u64 query_flags;              /* in */
>
> Does this map to the procmap_vma_flags enum?  if so, please say so.

no, procmap_query_flags, and yes, I will

>
> > +     __u64 query_addr;               /* in */
> > +     __u64 vma_start;                /* out */
> > +     __u64 vma_end;                  /* out */
> > +     __u64 vma_flags;                /* out */
> > +     __u64 vma_offset;               /* out */
> > +     __u64 inode;                    /* out */
>
> What is the inode for, you have an inode for the file already, why give
> it another one?

This is inode of vma's backing file, same as /proc/<pid>/maps' file
column. What inode of file do I already have here? You mean of
/proc/<pid>/maps itself? It's useless for the intended purposes.

>
> > +     __u32 dev_major;                /* out */
> > +     __u32 dev_minor;                /* out */
>
> What is major/minor for?

This is the same information as emitted by /proc/<pid>/maps,
identifies superblock of vma's backing file. As I mentioned above, it
can be used for caching per-file (i.e., per-ELF binary) information
(for example).

>
> > +     __u32 vma_name_size;            /* in/out */
> > +     __u32 build_id_size;            /* in/out */
> > +     __u64 vma_name_addr;            /* in */
> > +     __u64 build_id_addr;            /* in */
>
> Why not document this all using kerneldoc above the structure?

Yes, sorry, I slacked a bit on adding this upfront. I knew we'll be
figuring out the best place and approach, and so wanted to avoid
documentation churn.

Would something like what we have for pm_scan_arg and pagemap APIs
work? I see it added a few simple descriptions for pm_scan_arg struct,
and there is Documentation/admin-guide/mm/pagemap.rst. Should I add
Documentation/admin-guide/mm/procmap.rst (admin-guide part feels off,
though)? Anyways, I'm hoping for pointers where all this should be
documented. Thank you!

>
> anyway, I don't like ioctls, but there is a place for them, you just
> have to actually justify the use for them and not say "not efficient
> enough" as that normally isn't an issue overall.

I've written a demo tool in patch #5 which performs real-world task:
mapping addresses to their VMAs (specifically calculating file offset,
finding vma_start + vma_end range to further access files from
/proc/<pid>/map_files/<start>-<end>). I did the implementation
faithfully, doing it in the most optimal way for both APIs. I showed
that for "typical" (it's hard to specify what typical is, of course,
too many variables) scenario (it was data collected on a real server
running real service, 30 seconds of process-specific stack traces were
captured, if I remember correctly). I showed that doing exactly the
same amount of work is ~35x times slower with /proc/<pid>/maps.

Take another process, another set of addresses, another anything, and
the numbers will be different, but I think it gives the right idea.

But I think we are overpivoting on text vs binary distinction here.
It's the more targeted querying of VMAs that's beneficial here. This
allows applications to not cache anything and just re-query when doing
periodic or continuous profiling (where addresses are coming in not as
one batch, as a sequence of batches extended in time).

/proc/<pid>/maps, for all its usefulness, just can't provide this sort
of ability, as it wasn't designed to do that and is targeting
different use cases.

And then, a new ability to request reliable (it's not 100% reliable
today, I'm going to address that as a follow up) build ID is *crucial*
for some scenarios. The mentioned Oculus use case, the need to fully
access underlying ELF binary just to get build ID is frowned upon. And
for a good reason. Profiler only needs build ID, which is no secret
and not sensitive information. This new (and binary, yes) API allows
to add this into an API without breaking any backwards compatibility.

>
> thanks,
>
> greg k-h

