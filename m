Return-Path: <linux-fsdevel+bounces-42535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69829A42F47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5575B173B51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1146D1DE3D1;
	Mon, 24 Feb 2025 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZti58RT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A648C469D
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433024; cv=none; b=YUN/pF8QSrlNOMaXFuZQ13x1HvrkEbshEL3Fa5MYWp9VAA2DlauHiulpVk5eMOmLSQzG7hqYTCk0KYeK2xcNoaX/ZlOS/WbwjPAgSgnHzw96teKMF8NG8fRH6QGSWeWhz0alrdIccGQkqeGpyWtxtAPNInpXv8djCLQrw++LWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433024; c=relaxed/simple;
	bh=o8Zjb6OXMmSq+kbQzgXMUlUqhAnN74G5e+mktGVC0Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bm8gLcMOah1HcqIPTrse1V41F29vT37qxjdtBqOwVLGTSBElx63WrSdBbxGE4S2KZQnrYwXWZLlFOROXA40VY4UmUlEaRKB9tkIALcWEeKQb9Nx5SXYb1HAV6cnAfGkz/SZIIJcM6X+iURbuUCZ/3sySpWwgrjNnmkYCKse+eXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZti58RT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22117c396baso12845ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 13:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740433022; x=1741037822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ovUBpG7aXXwkDBC/a6KtafoC5cGlW0QFjL4aakiGwk=;
        b=uZti58RThwwHwkYksZ0aTkUaENTXPuY5754LcK9NsLE66XK23TkO7tqojUaZhXlByz
         +HyGwrWWCQnqle7h4Nd+nXGXaXejeI36OD2Uq+PtjRH8iu3J3+zKDFswUTxAKfk8V6PT
         xDhwt2J/4YekwZAsVr1Z7qwf4CImYiFpqvmX3hHjcT4nhVQW+1aab3Bhx+gzjXSgGPFp
         /tJF9e11TwHjr0LXeAJcQyvnRysutHjs+HMoKyO6YNwJ4o2AhdurRfet4AR9w+2jcXMp
         DPkA9VU8IbVTOHcgvQg7eAJJyw8MxBs2W41Fozj+hsH9cwpDX8Wojjp1Tj11JSNpZCPd
         UO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433022; x=1741037822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ovUBpG7aXXwkDBC/a6KtafoC5cGlW0QFjL4aakiGwk=;
        b=iYiRJukUANM7vGJWV/rNJ/Nk/OSaTnEXWaz4ezkoOYqGJeUNRcAam2SSKU8yJYQyiv
         62P8/kXQv8p5xLYYLPgXmn9+XNTBBB7I4inavk3AcoCT9vJ8jnB9shXhqWfGti2QE6n4
         3hAXwI99B8O9e4bhgpUm3IXTHgElMx5sLXTPGT62KIXuW9JmtzvVH7xir9oeX1VrtoY1
         8IdGNOnp1R3zK+sJ4pKAwKWKChvTHZIzKTHmwBLt6u1GcIjDwIKWLmMAud55wWGjixDD
         JbuaoqhIJefdrNpc1krbGt0bk3oSoXASqqdOPTEFTT/RS2AXkOtRt87dBqdz0f/bzJsn
         3U9w==
X-Forwarded-Encrypted: i=1; AJvYcCUyHmPrlAjIzX1aSMwmlWr/kq6wfeWN0ScSYrGgWk1ioW5wlKS05hcQGNnk0TN9KaheUPTVEKV/hWC94w1V@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5qtb/s6MZEVsp3/vaRPLtQIL1I2CRqeqrS40Z4v/JzP1LG4nn
	jGMkh0EjlfPugOC0NBlwduqposc9GWSZwFEYpfGnaFSszVbK1kRizW31JCS0J/lCHkbYAzdBCe+
	lZ9XYagLFqObcNPAqe+NLgFC4SIkIBLBaXoqp
X-Gm-Gg: ASbGncswvq3YrsGwpWmZuB4NwBEDwUxbOQXI+ivKUiaYfuKHXma5kyWwCUq3cIpKpo2
	WYsHY/dRxhIZVeWbx5kl8kkCbTCABH2EnK5b0shT7ud02cb47vFecMkU2VWp24jO/Tq3DyWvsVz
	Zss2NnI/YftBgalJn0m/+X/j2MNv/3lafYpF4zXA==
X-Google-Smtp-Source: AGHT+IGs5iHY+9ry+lEEOEo9o06dXO9jofNUW39apTX33QTSxPUBgPykVHcd3XP0qaM7FxNdwyTyzGgqf0AOSYenyqw=
X-Received: by 2002:a17:903:2350:b0:215:f0c6:4dbf with SMTP id
 d9443c01a7336-22307a60dc8mr1132485ad.14.1740433021713; Mon, 24 Feb 2025
 13:37:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <hep2a5d6k2kwth5klatzhl3ejbc6g2opqu6tyxyiohbpdyhvwp@lkg2wbb4zhy3>
 <3bd275ed-7951-4a55-9331-560981770d30@lucifer.local> <ivnv2crd3et76p2nx7oszuqhzzah756oecn5yuykzqfkqzoygw@yvnlkhjjssoz>
 <82fbe53b-98c4-4e55-9eeb-5a013596c4c6@lucifer.local>
In-Reply-To: <82fbe53b-98c4-4e55-9eeb-5a013596c4c6@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 24 Feb 2025 13:36:50 -0800
X-Gm-Features: AWEUYZlbolcbx1VrCX_xO5f3h30r1v1r_coxBnQqXW6iT4NYdoUMUja41NjS_Do
Message-ID: <CAC_TJvcnD731xyudgapjHx=dvVHY+cxoO1--2us7oo9TqA9-_g@mail.gmail.com>
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

On Mon, Feb 24, 2025 at 8:52=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Feb 24, 2025 at 05:31:16PM +0100, Jan Kara wrote:
> > On Mon 24-02-25 14:21:37, Lorenzo Stoakes wrote:
> > > On Mon, Feb 24, 2025 at 03:14:04PM +0100, Jan Kara wrote:
> > > > Hello!
> > > >
> > > > On Fri 21-02-25 13:13:15, Kalesh Singh via Lsf-pc wrote:
> > > > > Problem Statement
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > Readahead can result in unnecessary page cache pollution for mapp=
ed
> > > > > regions that are never accessed. Current mechanisms to disable
> > > > > readahead lack granularity and rather operate at the file or VMA
> > > > > level. This proposal seeks to initiate discussion at LSFMM to exp=
lore
> > > > > potential solutions for optimizing page cache/readahead behavior.
> > > > >
> > > > >
> > > > > Background
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > The read-ahead heuristics on file-backed memory mappings can
> > > > > inadvertently populate the page cache with pages corresponding to
> > > > > regions that user-space processes are known never to access e.g E=
LF
> > > > > LOAD segment padding regions. While these pages are ultimately
> > > > > reclaimable, their presence precipitates unnecessary I/O operatio=
ns,
> > > > > particularly when a substantial quantity of such regions exists.
> > > > >
> > > > > Although the underlying file can be made sparse in these regions =
to
> > > > > mitigate I/O, readahead will still allocate discrete zero pages w=
hen
> > > > > populating the page cache within these ranges. These pages, while
> > > > > subject to reclaim, introduce additional churn to the LRU. This
> > > > > reclaim overhead is further exacerbated in filesystems that suppo=
rt
> > > > > "fault-around" semantics, that can populate the surrounding pages=
=E2=80=99
> > > > > PTEs if found present in the page cache.
> > > > >
> > > > > While the memory impact may be negligible for large files contain=
ing a
> > > > > limited number of sparse regions, it becomes appreciable for many
> > > > > small mappings characterized by numerous holes. This scenario can
> > > > > arise from efforts to minimize vm_area_struct slab memory footpri=
nt.
> > > >

Hi Jan, Lorenzo, thanks for the comments.

> > > > OK, I agree the behavior you describe exists. But do you have some
> > > > real-world numbers showing its extent? I'm not looking for some art=
ificial
> > > > numbers - sure bad cases can be constructed - but how big practical=
 problem
> > > > is this? If you can show that average Android phone has 10% of thes=
e
> > > > useless pages in memory than that's one thing and we should be look=
ing for
> > > > some general solution. If it is more like 0.1%, then why bother?
> > > >

Once I revert a workaround that we currently have to avoid
fault-around for these regions (we don't have an out of tree solution
to prevent the page cache population); our CI which checks memory
usage after performing some common app user-journeys; reports
regressions as shown in the snippet below. Note, that the increases
here are only for the populated PTEs (bounded by VMA) so the actual
pollution is theoretically larger.

Metric: perfetto_media.extractor#file-rss-avg
Increased by 7.495 MB (32.7%)

Metric: perfetto_/system/bin/audioserver#file-rss-avg
Increased by 6.262 MB (29.8%)

Metric: perfetto_/system/bin/mediaserver#file-rss-max
Increased by 8.325 MB (28.0%)

Metric: perfetto_/system/bin/mediaserver#file-rss-avg
Increased by 8.198 MB (28.4%)

Metric: perfetto_media.extractor#file-rss-max
Increased by 7.95 MB (33.6%)

Metric: perfetto_/system/bin/incidentd#file-rss-avg
Increased by 0.896 MB (20.4%)

Metric: perfetto_/system/bin/audioserver#file-rss-max
Increased by 6.883 MB (31.9%)

Metric: perfetto_media.swcodec#file-rss-max
Increased by 7.236 MB (34.9%)

Metric: perfetto_/system/bin/incidentd#file-rss-max
Increased by 1.003 MB (22.7%)

Metric: perfetto_/system/bin/cameraserver#file-rss-avg
Increased by 6.946 MB (34.2%)

Metric: perfetto_/system/bin/cameraserver#file-rss-max
Increased by 7.205 MB (33.8%)

Metric: perfetto_com.android.nfc#file-rss-max
Increased by 8.525 MB (9.8%)

Metric: perfetto_/system/bin/surfaceflinger#file-rss-avg
Increased by 3.715 MB (3.6%)

Metric: perfetto_media.swcodec#file-rss-avg
Increased by 5.096 MB (27.1%)

[...]

The issue is widespread across processes because in order to support
larger page sizes Android has a requirement that the ELF segments are
at-least 16KB aligned, which lead to the padding regions (never
accessed).

> > > > > Limitations of Existing Mechanisms
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > fadvise(..., POSIX_FADV_RANDOM, ...): disables read-ahead for the
> > > > > entire file, rather than specific sub-regions. The offset and len=
gth
> > > > > parameters primarily serve the POSIX_FADV_WILLNEED [1] and
> > > > > POSIX_FADV_DONTNEED [2] cases.
> > > > >
> > > > > madvise(..., MADV_RANDOM, ...): Similarly, this applies on the en=
tire
> > > > > VMA, rather than specific sub-regions. [3]
> > > > > Guard Regions: While guard regions for file-backed VMAs circumven=
t
> > > > > fault-around concerns, the fundamental issue of unnecessary page =
cache
> > > > > population persists. [4]
> > > >
> > > > Somewhere else in the thread you complain about readahead extending=
 past
> > > > the VMA. That's relatively easy to avoid at least for readahead tri=
ggered
> > > > from filemap_fault() (i.e., do_async_mmap_readahead() and
> > > > do_sync_mmap_readahead()). I agree we could do that and that seems =
as a
> > > > relatively uncontroversial change. Note that if someone accesses th=
e file
> > > > through standard read(2) or write(2) syscall or through different m=
emory
> > > > mapping, the limits won't apply but such combinations of access are=
 not
> > > > that common anyway.
> > >
> > > Hm I'm not sure sure, map elf files with different mprotect(), or mpr=
otect()
> > > different portions of a file and suddenly you lose all the readahead =
for the
> > > rest even though you're reading sequentially?
> >
> > Well, you wouldn't loose all readahead for the rest. Just readahead won=
't
> > preread data underlying the next VMA so yes, you get a cache miss and h=
ave
> > to wait for a page to get loaded into cache when transitioning to the n=
ext
> > VMA but once you get there, you'll have readahead running at full speed
> > again.
>
> I'm aware of how readahead works (I _believe_ there's currently a
> pre-release of a book with a very extensive section on readahead written =
by
> somebody :P).
>
> Also been looking at it for file-backed guard regions recently, which is
> why I've been commenting here specifically as it's been on my mind lately=
,
> and also Kalesh's interest in this stems from a guard region 'scenario'
> (hence my cc).
>
> Anyway perhaps I didn't phrase this well - my concern is whether this mig=
ht
> impact performance in real world scenarios, such as one where a VMA is
> mapped then mprotect()'d or mmap()'d in parts causing _separate VMAs_ of
> the same file, in sequential order.
>
> From Kalesh's LPC talk, unless I misinterpreted what he said, this is
> precisely what he's doing? I mean we'd not be talking here about mmap()
> behaviour with readahead otherwise.
>
> Granted, perhaps you'd only _ever_ be reading sequentially within a
> specific VMA's boundaries, rather than going from one to another (excludi=
ng
> PROT_NONE guards obviously) and that's very possible, if that's what you
> mean.
>
> But otherwise, surely this is a thing? And might we therefore be imposing
> unnecessary cache misses?
>
> Which is why I suggest...
>
> >
> > So yes, sequential read of a memory mapping of a file fragmented into m=
any
> > VMAs will be somewhat slower. My impression is such use is rare (sequen=
tial
> > readers tend to use read(2) rather than mmap) but I could be wrong.
> >
> > > What about shared libraries with r/o parts and exec parts?
> > >
> > > I think we'd really need to do some pretty careful checking to ensure=
 this
> > > wouldn't break some real world use cases esp. if we really do mostly
> > > readahead data from page cache.
> >
> > So I'm not sure if you are not conflating two things here because the a=
bove
> > sentence doesn't make sense to me :). Readahead is the mechanism that
> > brings data from underlying filesystem into the page cache. Fault-aroun=
d is
> > the mechanism that maps into page tables pages present in the page cach=
e
> > although they were not possibly requested by the page fault. By "do mos=
tly
> > readahead data from page cache" are you speaking about fault-around? Th=
at
> > currently does not cross VMA boundaries anyway as far as I'm reading
> > do_fault_around()...
>
> ...that we test this and see how it behaves :) Which is literally all I
> am saying in the above. Ideally with representative workloads.
>
> I mean, I think this shouldn't be a controversial point right? Perhaps
> again I didn't communicate this well. But this is all I mean here.
>
> BTW, I understand the difference between readahead and fault-around, you =
can
> run git blame on do_fault_around() if you have doubts about that ;)
>
> And yes fault around is constrained to the VMA (and actually avoids
> crossing PTE boundaries).
>
> >
> > > > Regarding controlling readahead for various portions of the file - =
I'm
> > > > skeptical. In my opinion it would require too much bookeeping on th=
e kernel
> > > > side for such a niche usecache (but maybe your numbers will show it=
 isn't
> > > > such a niche as I think :)). I can imagine you could just completel=
y
> > > > turn off kernel readahead for the file and do your special readahea=
d from
> > > > userspace - I think you could use either userfaultfd for triggering=
 it or
> > > > new fanotify FAN_PREACCESS events.
> > >

Something like this would be ideal for the use case where uncompressed
ELF files are mapped directly from zipped APKs without extracting
them. (I don't have any real world number for this case atm). I also
don't know if the cache miss on the subsequent VMAs has significant
overhead in practice ... I'll try to collect some data for this.

> > > I'm opposed to anything that'll proliferate VMAs (and from what Kales=
h
> > > says, he is too!) I don't really see how we could avoid having to do =
that
> > > for this kind of case, but I may be missing something...
> >
> > I don't see why we would need to be increasing number of VMAs here at a=
ll.
> > With FAN_PREACCESS you get notification with file & offset when it's
> > accessed, you can issue readahead(2) calls based on that however you li=
ke.
> > Similarly you can ask for userfaults for the whole mapped range and han=
dle
> > those. Now thinking more about this, this approach has the downside tha=
t
> > you cannot implement async readahead with it (once PTE is mapped to som=
e
> > page it won't trigger notifications either with FAN_PREACCESS or with
> > UFFD). But with UFFD you could at least trigger readahead on minor faul=
ts.
>
> Yeah we're talking past each other on this, sorry I missed your point abo=
ut
> fanotify there!
>
> uffd is probably not reasonably workable given overhead I would have
> thought.
>
> I am really unaware of how fanotify works so I mean cool if you can find =
a
> solution this way, awesome :)
>
> I'm just saying, if we need to somehow retain state about regions which
> should have adjusted readahead behaviour at a VMA level, I can't see how
> this could be done without VMA fragmentation and I'd rather we didn't.
>
> If we can avoid that great!

Another possible way we can look at this: in the regressions shared
above by the ELF padding regions, we are able to make these regions
sparse (for *almost* all cases) -- solving the shared-zero page
problem for file mappings, would also eliminate much of this overhead.
So perhaps we should tackle this angle? If that's a more tangible
solution ?

From the previous discussions that Matthew shared [7], it seems like
Dave proposed an alternative to moving the extents to the VFS layer to
invert the IO read path operations [8]. Maybe this is a move
approachable solution since there is precedence for the same in the
write path?

[7] https://lore.kernel.org/linux-fsdevel/Zs97qHI-wA1a53Mm@casper.infradead=
.org/
[8] https://lore.kernel.org/linux-fsdevel/ZtAPsMcc3IC1VaAF@dread.disaster.a=
rea/

Thanks,
Kalesh
>
> >
> >                                                               Honza
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR

