Return-Path: <linux-fsdevel+bounces-42553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD20A435E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 08:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A05179A14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 06:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58BE2580F4;
	Tue, 25 Feb 2025 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSfPA2US"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C9F25771
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740466787; cv=none; b=nTD/YPLu9AjhRWH+VlozHrEjpI/kRlNdZrAFlgyQjEtpu9gc4y7aLQYCyNNznnWgTB5ffOIDywM4vfVXyIKfaowT3XwoNpieopbQ9MdYhFiUd5KLoE9toV01tRkSweLoiTeF/ExRGetkYZDzeuxEze7/jPzqTcdlQqHtELzsz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740466787; c=relaxed/simple;
	bh=hiVxTRjEtLQpnz7tSP3FK/EOeEZkCUB4z92xoBo/gxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRHoJ9LwOgJyaqTDt4YgWml4ApKpN0HY5lC9q0RpCoHVidqNGshDKKNwD849ot41JjfTm2O0nBXqfmoVfjCx/3aTvWMcorTOzJ0YGxFsT0kUwhJ+CSLFKlsRNeCl7v69Z4zM7T/DK+f1MMimnDDFFPTR/pDMw9r4ReaZovt0Fyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSfPA2US; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220e0575f5bso114975ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 22:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740466785; x=1741071585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CgOsphjc6urasX+nPG+/OELAihhViRUMDPtMTtA3A4=;
        b=uSfPA2USrlhePGx6POYtXYfXjM/Vz2vMt5HT4IuPNhnb2ExFn42vwzIyeuDdGlrkQI
         3AwlR+NiaCLP5QJaBUztDisaTcR0wHRh7PbVI2qzx6nwOJ+eIOEYzbOGS2TtddlJWc9Y
         ntGxiFL0254B9ad38Hj/qX724NHoHJChOsOsC/kIS+JCmXTf+67CTqp0IBg0UnZMzv1C
         CJZXJN9YERPDpUjwMXn27y8RRk7AB5Ecjrc1GmKRZ3vwVZlB5lQk9iL925xAg/XN6mS3
         rvzp9PxWYPLsAeiVTIrGXcDYIQHbpKqgnEjgmH7MHNkHTqtoKFMKH1p5ZOT2p+wpWNQp
         v7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740466785; x=1741071585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CgOsphjc6urasX+nPG+/OELAihhViRUMDPtMTtA3A4=;
        b=WlLFKJLDuKKq0tzVzkMtVy3RPS/90SqhUeeiUHXvjj+hcPdJBEp4IhKVJj4lL/5GYn
         AxEXdIyE75/KQueJcu64cKqhqTsICngMtTr8kngsHVDxVvRLJHXuio1dLm9nrf9uGSAH
         JitNKCEeR7/HaaAq+SiPEq1Y2sZRq0fxRGWlgoIYUQKCnmU+c0Y4an3joZTiZ0dGqn21
         C3fyGBO7tvm8S/nqvvKoccteC1YpWlLkJN6LmLv7OcvRab6/zrQRAxXS4OeYgKS4+e8W
         VAdS5UUdQSE/oxi90Tr1+G0YfVsvX9D0/K1tsz1czJ7H84el4oe2odbjEIKHpEyDVhi2
         HP5w==
X-Forwarded-Encrypted: i=1; AJvYcCVbR0GybtXuHwU5jo0PbG5TGSrQjNJ51gwLp/9sarpdI5ruHSeECZxNxfu1hHmMkGinxk5xvObUXVE2pfon@vger.kernel.org
X-Gm-Message-State: AOJu0YxOCEEU2ZEJHz+OhN/xzzK2eR5i7FwM6klD/PLRTNFfu4zMxy/W
	RotwfhNpbKJNcmmo58v6mvE5SjHyRAqH/tAG5wFxsbQwqp0coejdn1NgsXgZUJR0YPAp227j8WU
	eIRF5kpUVWNeFYZb0ugqziyFLHrJysbTOWxc9
X-Gm-Gg: ASbGnctw/Hv9jxzobiR2M2aawSjaVKIZVoda082h9Hzm9tLi8wzlqI9FumLrr50Zw9s
	ZXGFlNSxaLsQ4zjy4IVvY4lhtmEJfSIycPzSbv4wm2mzCRyR3q7QARaktLmf7kbkHiuC808kSP9
	tIC1oXdxeDNxTBlbWIj9lB2lpr22pjtCH+9d4c0DTz
X-Google-Smtp-Source: AGHT+IHNJlMDRVu6i2DidRO/pj6MNjJ2WCdc7o0+DOYTLnH2HJ0lWRSPhZVgGzMTzJpi/mBMNPn+RMdk8inIPC7L9mg=
X-Received: by 2002:a17:902:c40d:b0:220:c905:68a2 with SMTP id
 d9443c01a7336-22307a2c777mr2349005ad.5.1740466784455; Mon, 24 Feb 2025
 22:59:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <hep2a5d6k2kwth5klatzhl3ejbc6g2opqu6tyxyiohbpdyhvwp@lkg2wbb4zhy3>
 <3bd275ed-7951-4a55-9331-560981770d30@lucifer.local> <ivnv2crd3et76p2nx7oszuqhzzah756oecn5yuykzqfkqzoygw@yvnlkhjjssoz>
 <82fbe53b-98c4-4e55-9eeb-5a013596c4c6@lucifer.local> <CAC_TJvcnD731xyudgapjHx=dvVHY+cxoO1--2us7oo9TqA9-_g@mail.gmail.com>
 <4f0e3d28-008f-416a-9900-75b2355f1f66@lucifer.local>
In-Reply-To: <4f0e3d28-008f-416a-9900-75b2355f1f66@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 24 Feb 2025 22:59:31 -0800
X-Gm-Features: AWEUYZnXMJAbXfx9WxgWaplY4wxObeHPjrzb0j0I1dWnXAs_jKXgIXuyBQOQmIE
Message-ID: <CAC_TJvd_Z_a6YGpsxroF25g6b4+F3iGnyN=m507CR6BfMFPRhg@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead Behavior
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, David Hildenbrand <david@redhat.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Juan Yescas <jyescas@google.com>, 
	android-mm <android-mm@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	"Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:45=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Feb 24, 2025 at 01:36:50PM -0800, Kalesh Singh wrote:
> > On Mon, Feb 24, 2025 at 8:52=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Mon, Feb 24, 2025 at 05:31:16PM +0100, Jan Kara wrote:
> > > > On Mon 24-02-25 14:21:37, Lorenzo Stoakes wrote:
> > > > > On Mon, Feb 24, 2025 at 03:14:04PM +0100, Jan Kara wrote:
> > > > > > Hello!
> > > > > >
> > > > > > On Fri 21-02-25 13:13:15, Kalesh Singh via Lsf-pc wrote:
> > > > > > > Problem Statement
> > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > >
> > > > > > > Readahead can result in unnecessary page cache pollution for =
mapped
> > > > > > > regions that are never accessed. Current mechanisms to disabl=
e
> > > > > > > readahead lack granularity and rather operate at the file or =
VMA
> > > > > > > level. This proposal seeks to initiate discussion at LSFMM to=
 explore
> > > > > > > potential solutions for optimizing page cache/readahead behav=
ior.
> > > > > > >
> > > > > > >
> > > > > > > Background
> > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > >
> > > > > > > The read-ahead heuristics on file-backed memory mappings can
> > > > > > > inadvertently populate the page cache with pages correspondin=
g to
> > > > > > > regions that user-space processes are known never to access e=
.g ELF
> > > > > > > LOAD segment padding regions. While these pages are ultimatel=
y
> > > > > > > reclaimable, their presence precipitates unnecessary I/O oper=
ations,
> > > > > > > particularly when a substantial quantity of such regions exis=
ts.
> > > > > > >
> > > > > > > Although the underlying file can be made sparse in these regi=
ons to
> > > > > > > mitigate I/O, readahead will still allocate discrete zero pag=
es when
> > > > > > > populating the page cache within these ranges. These pages, w=
hile
> > > > > > > subject to reclaim, introduce additional churn to the LRU. Th=
is
> > > > > > > reclaim overhead is further exacerbated in filesystems that s=
upport
> > > > > > > "fault-around" semantics, that can populate the surrounding p=
ages=E2=80=99
> > > > > > > PTEs if found present in the page cache.
> > > > > > >
> > > > > > > While the memory impact may be negligible for large files con=
taining a
> > > > > > > limited number of sparse regions, it becomes appreciable for =
many
> > > > > > > small mappings characterized by numerous holes. This scenario=
 can
> > > > > > > arise from efforts to minimize vm_area_struct slab memory foo=
tprint.
> > > > > >
> >
> > Hi Jan, Lorenzo, thanks for the comments.
> >
> > > > > > OK, I agree the behavior you describe exists. But do you have s=
ome
> > > > > > real-world numbers showing its extent? I'm not looking for some=
 artificial
> > > > > > numbers - sure bad cases can be constructed - but how big pract=
ical problem
> > > > > > is this? If you can show that average Android phone has 10% of =
these
> > > > > > useless pages in memory than that's one thing and we should be =
looking for
> > > > > > some general solution. If it is more like 0.1%, then why bother=
?
> > > > > >
> >
> > Once I revert a workaround that we currently have to avoid
> > fault-around for these regions (we don't have an out of tree solution
> > to prevent the page cache population); our CI which checks memory
> > usage after performing some common app user-journeys; reports
> > regressions as shown in the snippet below. Note, that the increases
> > here are only for the populated PTEs (bounded by VMA) so the actual
> > pollution is theoretically larger.
>
> Hm fault-around populates these duplicate zero pages? I guess it would
> actually. I'd be curious to hear about this out-of-tree patch, and I wond=
er how
> upstreamable it might be? :)

Let's say it's a hack I'd prefer not to post on the list :) It's very
particular to our use case so great to find a generic solution that
everyone can benefit from.

>
> >
> > Metric: perfetto_media.extractor#file-rss-avg
> > Increased by 7.495 MB (32.7%)
> >
> > Metric: perfetto_/system/bin/audioserver#file-rss-avg
> > Increased by 6.262 MB (29.8%)
> >
> > Metric: perfetto_/system/bin/mediaserver#file-rss-max
> > Increased by 8.325 MB (28.0%)
> >
> > Metric: perfetto_/system/bin/mediaserver#file-rss-avg
> > Increased by 8.198 MB (28.4%)
> >
> > Metric: perfetto_media.extractor#file-rss-max
> > Increased by 7.95 MB (33.6%)
> >
> > Metric: perfetto_/system/bin/incidentd#file-rss-avg
> > Increased by 0.896 MB (20.4%)
> >
> > Metric: perfetto_/system/bin/audioserver#file-rss-max
> > Increased by 6.883 MB (31.9%)
> >
> > Metric: perfetto_media.swcodec#file-rss-max
> > Increased by 7.236 MB (34.9%)
> >
> > Metric: perfetto_/system/bin/incidentd#file-rss-max
> > Increased by 1.003 MB (22.7%)
> >
> > Metric: perfetto_/system/bin/cameraserver#file-rss-avg
> > Increased by 6.946 MB (34.2%)
> >
> > Metric: perfetto_/system/bin/cameraserver#file-rss-max
> > Increased by 7.205 MB (33.8%)
> >
> > Metric: perfetto_com.android.nfc#file-rss-max
> > Increased by 8.525 MB (9.8%)
> >
> > Metric: perfetto_/system/bin/surfaceflinger#file-rss-avg
> > Increased by 3.715 MB (3.6%)
> >
> > Metric: perfetto_media.swcodec#file-rss-avg
> > Increased by 5.096 MB (27.1%)
>
> Yikes yeah.
>
> >
> > [...]
> >
> > The issue is widespread across processes because in order to support
> > larger page sizes Android has a requirement that the ELF segments are
> > at-least 16KB aligned, which lead to the padding regions (never
> > accessed).
>
> Again I wonder if the _really_ important problem here is this duplicate z=
ero
> page proliferation?
>

Initially I didn't want to bias the discussion to only working for
sparse files, since there could be never-accessed file backed regions
that are not necessarily sparse (guard regions?). But the major issue
/ use case in this thread, yes it suffices to solve the zero page
problem. Perhaps the other issues mentioned can be revisited
separately if/when we have some real world numbers as Jan suggested.

> As Matthew points out, fixing this might be quite involved, but this isn'=
t
> pushing back on doing so, it's good to fix things even if it's hard :>)
>
> >
> > > > > > > Limitations of Existing Mechanisms
> > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > > > >
> > > > > > > fadvise(..., POSIX_FADV_RANDOM, ...): disables read-ahead for=
 the
> > > > > > > entire file, rather than specific sub-regions. The offset and=
 length
> > > > > > > parameters primarily serve the POSIX_FADV_WILLNEED [1] and
> > > > > > > POSIX_FADV_DONTNEED [2] cases.
> > > > > > >
> > > > > > > madvise(..., MADV_RANDOM, ...): Similarly, this applies on th=
e entire
> > > > > > > VMA, rather than specific sub-regions. [3]
> > > > > > > Guard Regions: While guard regions for file-backed VMAs circu=
mvent
> > > > > > > fault-around concerns, the fundamental issue of unnecessary p=
age cache
> > > > > > > population persists. [4]
> > > > > >
> > > > > > Somewhere else in the thread you complain about readahead exten=
ding past
> > > > > > the VMA. That's relatively easy to avoid at least for readahead=
 triggered
> > > > > > from filemap_fault() (i.e., do_async_mmap_readahead() and
> > > > > > do_sync_mmap_readahead()). I agree we could do that and that se=
ems as a
> > > > > > relatively uncontroversial change. Note that if someone accesse=
s the file
> > > > > > through standard read(2) or write(2) syscall or through differe=
nt memory
> > > > > > mapping, the limits won't apply but such combinations of access=
 are not
> > > > > > that common anyway.
> > > > >
> > > > > Hm I'm not sure sure, map elf files with different mprotect(), or=
 mprotect()
> > > > > different portions of a file and suddenly you lose all the readah=
ead for the
> > > > > rest even though you're reading sequentially?
> > > >
> > > > Well, you wouldn't loose all readahead for the rest. Just readahead=
 won't
> > > > preread data underlying the next VMA so yes, you get a cache miss a=
nd have
> > > > to wait for a page to get loaded into cache when transitioning to t=
he next
> > > > VMA but once you get there, you'll have readahead running at full s=
peed
> > > > again.
> > >
> > > I'm aware of how readahead works (I _believe_ there's currently a
> > > pre-release of a book with a very extensive section on readahead writ=
ten by
> > > somebody :P).
> > >
> > > Also been looking at it for file-backed guard regions recently, which=
 is
> > > why I've been commenting here specifically as it's been on my mind la=
tely,
> > > and also Kalesh's interest in this stems from a guard region 'scenari=
o'
> > > (hence my cc).
> > >
> > > Anyway perhaps I didn't phrase this well - my concern is whether this=
 might
> > > impact performance in real world scenarios, such as one where a VMA i=
s
> > > mapped then mprotect()'d or mmap()'d in parts causing _separate VMAs_=
 of
> > > the same file, in sequential order.
> > >
> > > From Kalesh's LPC talk, unless I misinterpreted what he said, this is
> > > precisely what he's doing? I mean we'd not be talking here about mmap=
()
> > > behaviour with readahead otherwise.
> > >
> > > Granted, perhaps you'd only _ever_ be reading sequentially within a
> > > specific VMA's boundaries, rather than going from one to another (exc=
luding
> > > PROT_NONE guards obviously) and that's very possible, if that's what =
you
> > > mean.
> > >
> > > But otherwise, surely this is a thing? And might we therefore be impo=
sing
> > > unnecessary cache misses?
> > >
> > > Which is why I suggest...
> > >
> > > >
> > > > So yes, sequential read of a memory mapping of a file fragmented in=
to many
> > > > VMAs will be somewhat slower. My impression is such use is rare (se=
quential
> > > > readers tend to use read(2) rather than mmap) but I could be wrong.
> > > >
> > > > > What about shared libraries with r/o parts and exec parts?
> > > > >
> > > > > I think we'd really need to do some pretty careful checking to en=
sure this
> > > > > wouldn't break some real world use cases esp. if we really do mos=
tly
> > > > > readahead data from page cache.
> > > >
> > > > So I'm not sure if you are not conflating two things here because t=
he above
> > > > sentence doesn't make sense to me :). Readahead is the mechanism th=
at
> > > > brings data from underlying filesystem into the page cache. Fault-a=
round is
> > > > the mechanism that maps into page tables pages present in the page =
cache
> > > > although they were not possibly requested by the page fault. By "do=
 mostly
> > > > readahead data from page cache" are you speaking about fault-around=
? That
> > > > currently does not cross VMA boundaries anyway as far as I'm readin=
g
> > > > do_fault_around()...
> > >
> > > ...that we test this and see how it behaves :) Which is literally all=
 I
> > > am saying in the above. Ideally with representative workloads.
> > >
> > > I mean, I think this shouldn't be a controversial point right? Perhap=
s
> > > again I didn't communicate this well. But this is all I mean here.
> > >
> > > BTW, I understand the difference between readahead and fault-around, =
you can
> > > run git blame on do_fault_around() if you have doubts about that ;)
> > >
> > > And yes fault around is constrained to the VMA (and actually avoids
> > > crossing PTE boundaries).
> > >
> > > >
> > > > > > Regarding controlling readahead for various portions of the fil=
e - I'm
> > > > > > skeptical. In my opinion it would require too much bookeeping o=
n the kernel
> > > > > > side for such a niche usecache (but maybe your numbers will sho=
w it isn't
> > > > > > such a niche as I think :)). I can imagine you could just compl=
etely
> > > > > > turn off kernel readahead for the file and do your special read=
ahead from
> > > > > > userspace - I think you could use either userfaultfd for trigge=
ring it or
> > > > > > new fanotify FAN_PREACCESS events.
> > > > >
> >
> > Something like this would be ideal for the use case where uncompressed
> > ELF files are mapped directly from zipped APKs without extracting
> > them. (I don't have any real world number for this case atm). I also
> > don't know if the cache miss on the subsequent VMAs has significant
> > overhead in practice ... I'll try to collect some data for this.
> >
> > > > > I'm opposed to anything that'll proliferate VMAs (and from what K=
alesh
> > > > > says, he is too!) I don't really see how we could avoid having to=
 do that
> > > > > for this kind of case, but I may be missing something...
> > > >
> > > > I don't see why we would need to be increasing number of VMAs here =
at all.
> > > > With FAN_PREACCESS you get notification with file & offset when it'=
s
> > > > accessed, you can issue readahead(2) calls based on that however yo=
u like.
> > > > Similarly you can ask for userfaults for the whole mapped range and=
 handle
> > > > those. Now thinking more about this, this approach has the downside=
 that
> > > > you cannot implement async readahead with it (once PTE is mapped to=
 some
> > > > page it won't trigger notifications either with FAN_PREACCESS or wi=
th
> > > > UFFD). But with UFFD you could at least trigger readahead on minor =
faults.
> > >
> > > Yeah we're talking past each other on this, sorry I missed your point=
 about
> > > fanotify there!
> > >
> > > uffd is probably not reasonably workable given overhead I would have
> > > thought.
> > >
> > > I am really unaware of how fanotify works so I mean cool if you can f=
ind a
> > > solution this way, awesome :)
> > >
> > > I'm just saying, if we need to somehow retain state about regions whi=
ch
> > > should have adjusted readahead behaviour at a VMA level, I can't see =
how
> > > this could be done without VMA fragmentation and I'd rather we didn't=
.
> > >
> > > If we can avoid that great!
> >
> > Another possible way we can look at this: in the regressions shared
> > above by the ELF padding regions, we are able to make these regions
> > sparse (for *almost* all cases) -- solving the shared-zero page
> > problem for file mappings, would also eliminate much of this overhead.
> > So perhaps we should tackle this angle? If that's a more tangible
> > solution ?
>
> To me it seems we are converging on this as at least part of the solution=
.
>
> >
> > From the previous discussions that Matthew shared [7], it seems like
> > Dave proposed an alternative to moving the extents to the VFS layer to
> > invert the IO read path operations [8]. Maybe this is a move
> > approachable solution since there is precedence for the same in the
> > write path?
> >
> > [7] https://lore.kernel.org/linux-fsdevel/Zs97qHI-wA1a53Mm@casper.infra=
dead.org/
> > [8] https://lore.kernel.org/linux-fsdevel/ZtAPsMcc3IC1VaAF@dread.disast=
er.area/
> >
> > Thanks,
> > Kalesh
> > >
> > > >
> > > >                                                               Honza
> > > > --
> > > > Jan Kara <jack@suse.com>
> > > > SUSE Labs, CR
>
> Overall I think we can conclude - this is a topic of interest to people f=
or
> LSF :)

Yes I'd love to discuss this more with all the relevant folks in person :)

Thanks,
Kalesh

