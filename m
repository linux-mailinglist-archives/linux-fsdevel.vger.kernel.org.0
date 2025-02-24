Return-Path: <linux-fsdevel+bounces-42539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3AFA42F94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7363B130F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3122E1E7C0A;
	Mon, 24 Feb 2025 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DnIdH558"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15151E0DB3
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434119; cv=none; b=E0g2vYYS/HOfKrGUCXNAsTSUky/U3KbYORk4QDAvL5OXBcOW0n7ZEpwTil89nqlSDD2FDTMs5IzPh4OE0Yz6tJULiVdG74+nDo/l8QwbpJXCEnj3qhRJlobmiw08OeJGDMOkzL5UWnanBPElZu2JD0s5yE1d+Uk2MgnqZWN4F0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434119; c=relaxed/simple;
	bh=hjaZ8BgtB1vOcmuzLi9jYQhirO0yBZzYocA7Tf65ID8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoelrLLuZDxFlF6ozIoGGTyaVUhdEroNb7vg37Xa+BR6bR97b5sz7Mr3bSUmr7GEfHtyvccXq4EoVqrfLk+9V3stx/WZ1G5+bOYbc++WoCw9uGPTpZpsuqvymhIbVZ/E64rqqtyQIJo0ALMNVT9kxyiXyS0B4NoDeIbRHeJ+1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DnIdH558; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220e0575f5bso53755ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 13:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740434117; x=1741038917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORUQWl1+qmf87Ab9OuvOuiofe0nej11MhOUTmg2UX24=;
        b=DnIdH558sdIYncx4jutOLoj+s+uftbkfj/t2eCqBwlplk3a0+JLvJXNkFU3Axt0vvm
         RhBWaseCTMhMhJwEq7bB2I/wxVg32u+Loj7M7Q23TEi/HJ2rfjeB/XaZVh6/OuALbcX8
         X02pOKw7j67ONqK/mV66uWqpnLFTgC2XfCnNi+InpmdkUvJIrLUgBt/m0Z0RxBA57NVo
         7MxTvJtup6VVt6rQearHK+sLtUVefzC5vDdA5zVs2JyzBt/ZkFdfVOuJAche5Vj18jaG
         uslWVmSJ7fg+fY2Ykq2HoarKDGftcN6yKaedqgUcs5hjrkU48ETcLpQgZrPhtKQFLrh2
         0S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740434117; x=1741038917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORUQWl1+qmf87Ab9OuvOuiofe0nej11MhOUTmg2UX24=;
        b=n9gANV81zGpbrGVUIwQvLwaLRX0XagNRyHyeOKH0fQcArTGrwsDnvsOubOuzE/QeVj
         nubbU+3VnMo5nzkAeRKN7RKO/Hcpo1jclQhsrzbLq2N6uQvj0Fr7ydbbXD3qnGs0pTRM
         8zjne5RXfEnooXsLU3Gk+ZtA/tzKQZU+e5560gGShaIYZDhaA/4qveQmUAlJ9QcGjUPN
         fQGCfoKxiLxds/Tg/FugbJjA0cD/QUSJNvOT+IlQigz+by63H7eI/Q+U9NfdYi9ykb9t
         B4hewB4sIvna9Aa5yCGCkOxcb5GPmVMmSc0DYDgxqFRipCl7DmNdTgqgaEg7ocxtjz2C
         gxdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNkMHIP8pBsxgtzOmfmJSVt4t6l9F1cUl3p4PPuxy5L0kwafktA9pdPYO2NrnvDU4M5IsC24HXyzwzMGeF@vger.kernel.org
X-Gm-Message-State: AOJu0YyOiVcPMB8aC3XWWu31lGgQV5YYNBpDK4q+pyAm0vMm85tIIQZB
	d5udFRNkbDhmSXJDCZNTl8CBmK0iD7tLbcg+NaOXqMIPSFpgdOGMZH5Tg/OhjrwDsT+lkp/gXjT
	bg6VZnEahid8QS/J9M6g6kqqfocQiHRCYPfCS
X-Gm-Gg: ASbGncuMe2NsRE75ctD4GCjt2gewSeZHvSGrepN4HMwanWNOPhyydqx98t8gAB0DRs4
	PZY80l4dNnHiHtAEPHCmTD0OxOJJXxjg3xve/YUOJbm/6pVeDN5HVxf+7tOkMfsfYMZgmJzD8uA
	Ji+D7P7BleYQEIjL8/gyjPHw04wP4U3sVspNS+Gw==
X-Google-Smtp-Source: AGHT+IEUyR02mxt0JV+b4xA7aH7wa2PZeBe0ZDag7SKT17YAp7s+plpQiP5IZn6DxvMtgUl5m8jImq5AjsoAwp4YJ3k=
X-Received: by 2002:a17:902:d486:b0:215:7ced:9d67 with SMTP id
 d9443c01a7336-22307aab8dbmr1121245ad.24.1740434116807; Mon, 24 Feb 2025
 13:55:16 -0800 (PST)
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
In-Reply-To: <CAC_TJvcnD731xyudgapjHx=dvVHY+cxoO1--2us7oo9TqA9-_g@mail.gmail.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 24 Feb 2025 13:55:05 -0800
X-Gm-Features: AWEUYZnaGxYnmo8Z6dtC-_J_4mhbctdbL0AklEvRlknqCJp6PJ70delpG6aN3_Q
Message-ID: <CAC_TJvfH2uqm-XNmcGav8v7Rq1BwNrm7dC_mPbPXhMMGqnzLaA@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead Behavior
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, David Hildenbrand <david@redhat.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Juan Yescas <jyescas@google.com>, 
	android-mm <android-mm@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	"Cc: Android Kernel" <kernel-team@android.com>, david@fromorbit.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 1:36=E2=80=AFPM Kalesh Singh <kaleshsingh@google.co=
m> wrote:
>
> On Mon, Feb 24, 2025 at 8:52=E2=80=AFAM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Mon, Feb 24, 2025 at 05:31:16PM +0100, Jan Kara wrote:
> > > On Mon 24-02-25 14:21:37, Lorenzo Stoakes wrote:
> > > > On Mon, Feb 24, 2025 at 03:14:04PM +0100, Jan Kara wrote:
> > > > > Hello!
> > > > >
> > > > > On Fri 21-02-25 13:13:15, Kalesh Singh via Lsf-pc wrote:
> > > > > > Problem Statement
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > >
> > > > > > Readahead can result in unnecessary page cache pollution for ma=
pped
> > > > > > regions that are never accessed. Current mechanisms to disable
> > > > > > readahead lack granularity and rather operate at the file or VM=
A
> > > > > > level. This proposal seeks to initiate discussion at LSFMM to e=
xplore
> > > > > > potential solutions for optimizing page cache/readahead behavio=
r.
> > > > > >
> > > > > >
> > > > > > Background
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > >
> > > > > > The read-ahead heuristics on file-backed memory mappings can
> > > > > > inadvertently populate the page cache with pages corresponding =
to
> > > > > > regions that user-space processes are known never to access e.g=
 ELF
> > > > > > LOAD segment padding regions. While these pages are ultimately
> > > > > > reclaimable, their presence precipitates unnecessary I/O operat=
ions,
> > > > > > particularly when a substantial quantity of such regions exists=
.
> > > > > >
> > > > > > Although the underlying file can be made sparse in these region=
s to
> > > > > > mitigate I/O, readahead will still allocate discrete zero pages=
 when
> > > > > > populating the page cache within these ranges. These pages, whi=
le
> > > > > > subject to reclaim, introduce additional churn to the LRU. This
> > > > > > reclaim overhead is further exacerbated in filesystems that sup=
port
> > > > > > "fault-around" semantics, that can populate the surrounding pag=
es=E2=80=99
> > > > > > PTEs if found present in the page cache.
> > > > > >
> > > > > > While the memory impact may be negligible for large files conta=
ining a
> > > > > > limited number of sparse regions, it becomes appreciable for ma=
ny
> > > > > > small mappings characterized by numerous holes. This scenario c=
an
> > > > > > arise from efforts to minimize vm_area_struct slab memory footp=
rint.
> > > > >
>
> Hi Jan, Lorenzo, thanks for the comments.
>
> > > > > OK, I agree the behavior you describe exists. But do you have som=
e
> > > > > real-world numbers showing its extent? I'm not looking for some a=
rtificial
> > > > > numbers - sure bad cases can be constructed - but how big practic=
al problem
> > > > > is this? If you can show that average Android phone has 10% of th=
ese
> > > > > useless pages in memory than that's one thing and we should be lo=
oking for
> > > > > some general solution. If it is more like 0.1%, then why bother?
> > > > >
>
> Once I revert a workaround that we currently have to avoid
> fault-around for these regions (we don't have an out of tree solution
> to prevent the page cache population); our CI which checks memory
> usage after performing some common app user-journeys; reports
> regressions as shown in the snippet below. Note, that the increases
> here are only for the populated PTEs (bounded by VMA) so the actual
> pollution is theoretically larger.
>
> Metric: perfetto_media.extractor#file-rss-avg
> Increased by 7.495 MB (32.7%)
>
> Metric: perfetto_/system/bin/audioserver#file-rss-avg
> Increased by 6.262 MB (29.8%)
>
> Metric: perfetto_/system/bin/mediaserver#file-rss-max
> Increased by 8.325 MB (28.0%)
>
> Metric: perfetto_/system/bin/mediaserver#file-rss-avg
> Increased by 8.198 MB (28.4%)
>
> Metric: perfetto_media.extractor#file-rss-max
> Increased by 7.95 MB (33.6%)
>
> Metric: perfetto_/system/bin/incidentd#file-rss-avg
> Increased by 0.896 MB (20.4%)
>
> Metric: perfetto_/system/bin/audioserver#file-rss-max
> Increased by 6.883 MB (31.9%)
>
> Metric: perfetto_media.swcodec#file-rss-max
> Increased by 7.236 MB (34.9%)
>
> Metric: perfetto_/system/bin/incidentd#file-rss-max
> Increased by 1.003 MB (22.7%)
>
> Metric: perfetto_/system/bin/cameraserver#file-rss-avg
> Increased by 6.946 MB (34.2%)
>
> Metric: perfetto_/system/bin/cameraserver#file-rss-max
> Increased by 7.205 MB (33.8%)
>
> Metric: perfetto_com.android.nfc#file-rss-max
> Increased by 8.525 MB (9.8%)
>
> Metric: perfetto_/system/bin/surfaceflinger#file-rss-avg
> Increased by 3.715 MB (3.6%)
>
> Metric: perfetto_media.swcodec#file-rss-avg
> Increased by 5.096 MB (27.1%)
>
> [...]
>
> The issue is widespread across processes because in order to support
> larger page sizes Android has a requirement that the ELF segments are
> at-least 16KB aligned, which lead to the padding regions (never
> accessed).
>
> > > > > > Limitations of Existing Mechanisms
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > > >
> > > > > > fadvise(..., POSIX_FADV_RANDOM, ...): disables read-ahead for t=
he
> > > > > > entire file, rather than specific sub-regions. The offset and l=
ength
> > > > > > parameters primarily serve the POSIX_FADV_WILLNEED [1] and
> > > > > > POSIX_FADV_DONTNEED [2] cases.
> > > > > >
> > > > > > madvise(..., MADV_RANDOM, ...): Similarly, this applies on the =
entire
> > > > > > VMA, rather than specific sub-regions. [3]
> > > > > > Guard Regions: While guard regions for file-backed VMAs circumv=
ent
> > > > > > fault-around concerns, the fundamental issue of unnecessary pag=
e cache
> > > > > > population persists. [4]
> > > > >
> > > > > Somewhere else in the thread you complain about readahead extendi=
ng past
> > > > > the VMA. That's relatively easy to avoid at least for readahead t=
riggered
> > > > > from filemap_fault() (i.e., do_async_mmap_readahead() and
> > > > > do_sync_mmap_readahead()). I agree we could do that and that seem=
s as a
> > > > > relatively uncontroversial change. Note that if someone accesses =
the file
> > > > > through standard read(2) or write(2) syscall or through different=
 memory
> > > > > mapping, the limits won't apply but such combinations of access a=
re not
> > > > > that common anyway.
> > > >
> > > > Hm I'm not sure sure, map elf files with different mprotect(), or m=
protect()
> > > > different portions of a file and suddenly you lose all the readahea=
d for the
> > > > rest even though you're reading sequentially?
> > >
> > > Well, you wouldn't loose all readahead for the rest. Just readahead w=
on't
> > > preread data underlying the next VMA so yes, you get a cache miss and=
 have
> > > to wait for a page to get loaded into cache when transitioning to the=
 next
> > > VMA but once you get there, you'll have readahead running at full spe=
ed
> > > again.
> >
> > I'm aware of how readahead works (I _believe_ there's currently a
> > pre-release of a book with a very extensive section on readahead writte=
n by
> > somebody :P).
> >
> > Also been looking at it for file-backed guard regions recently, which i=
s
> > why I've been commenting here specifically as it's been on my mind late=
ly,
> > and also Kalesh's interest in this stems from a guard region 'scenario'
> > (hence my cc).
> >
> > Anyway perhaps I didn't phrase this well - my concern is whether this m=
ight
> > impact performance in real world scenarios, such as one where a VMA is
> > mapped then mprotect()'d or mmap()'d in parts causing _separate VMAs_ o=
f
> > the same file, in sequential order.
> >
> > From Kalesh's LPC talk, unless I misinterpreted what he said, this is
> > precisely what he's doing? I mean we'd not be talking here about mmap()
> > behaviour with readahead otherwise.
> >
> > Granted, perhaps you'd only _ever_ be reading sequentially within a
> > specific VMA's boundaries, rather than going from one to another (exclu=
ding
> > PROT_NONE guards obviously) and that's very possible, if that's what yo=
u
> > mean.
> >
> > But otherwise, surely this is a thing? And might we therefore be imposi=
ng
> > unnecessary cache misses?
> >
> > Which is why I suggest...
> >
> > >
> > > So yes, sequential read of a memory mapping of a file fragmented into=
 many
> > > VMAs will be somewhat slower. My impression is such use is rare (sequ=
ential
> > > readers tend to use read(2) rather than mmap) but I could be wrong.
> > >
> > > > What about shared libraries with r/o parts and exec parts?
> > > >
> > > > I think we'd really need to do some pretty careful checking to ensu=
re this
> > > > wouldn't break some real world use cases esp. if we really do mostl=
y
> > > > readahead data from page cache.
> > >
> > > So I'm not sure if you are not conflating two things here because the=
 above
> > > sentence doesn't make sense to me :). Readahead is the mechanism that
> > > brings data from underlying filesystem into the page cache. Fault-aro=
und is
> > > the mechanism that maps into page tables pages present in the page ca=
che
> > > although they were not possibly requested by the page fault. By "do m=
ostly
> > > readahead data from page cache" are you speaking about fault-around? =
That
> > > currently does not cross VMA boundaries anyway as far as I'm reading
> > > do_fault_around()...
> >
> > ...that we test this and see how it behaves :) Which is literally all I
> > am saying in the above. Ideally with representative workloads.
> >
> > I mean, I think this shouldn't be a controversial point right? Perhaps
> > again I didn't communicate this well. But this is all I mean here.
> >
> > BTW, I understand the difference between readahead and fault-around, yo=
u can
> > run git blame on do_fault_around() if you have doubts about that ;)
> >
> > And yes fault around is constrained to the VMA (and actually avoids
> > crossing PTE boundaries).
> >
> > >
> > > > > Regarding controlling readahead for various portions of the file =
- I'm
> > > > > skeptical. In my opinion it would require too much bookeeping on =
the kernel
> > > > > side for such a niche usecache (but maybe your numbers will show =
it isn't
> > > > > such a niche as I think :)). I can imagine you could just complet=
ely
> > > > > turn off kernel readahead for the file and do your special readah=
ead from
> > > > > userspace - I think you could use either userfaultfd for triggeri=
ng it or
> > > > > new fanotify FAN_PREACCESS events.
> > > >
>
> Something like this would be ideal for the use case where uncompressed
> ELF files are mapped directly from zipped APKs without extracting
> them. (I don't have any real world number for this case atm). I also
> don't know if the cache miss on the subsequent VMAs has significant
> overhead in practice ... I'll try to collect some data for this.
>
> > > > I'm opposed to anything that'll proliferate VMAs (and from what Kal=
esh
> > > > says, he is too!) I don't really see how we could avoid having to d=
o that
> > > > for this kind of case, but I may be missing something...
> > >
> > > I don't see why we would need to be increasing number of VMAs here at=
 all.
> > > With FAN_PREACCESS you get notification with file & offset when it's
> > > accessed, you can issue readahead(2) calls based on that however you =
like.
> > > Similarly you can ask for userfaults for the whole mapped range and h=
andle
> > > those. Now thinking more about this, this approach has the downside t=
hat
> > > you cannot implement async readahead with it (once PTE is mapped to s=
ome
> > > page it won't trigger notifications either with FAN_PREACCESS or with
> > > UFFD). But with UFFD you could at least trigger readahead on minor fa=
ults.
> >
> > Yeah we're talking past each other on this, sorry I missed your point a=
bout
> > fanotify there!
> >
> > uffd is probably not reasonably workable given overhead I would have
> > thought.
> >
> > I am really unaware of how fanotify works so I mean cool if you can fin=
d a
> > solution this way, awesome :)
> >
> > I'm just saying, if we need to somehow retain state about regions which
> > should have adjusted readahead behaviour at a VMA level, I can't see ho=
w
> > this could be done without VMA fragmentation and I'd rather we didn't.
> >
> > If we can avoid that great!
>
> Another possible way we can look at this: in the regressions shared
> above by the ELF padding regions, we are able to make these regions
> sparse (for *almost* all cases) -- solving the shared-zero page
> problem for file mappings, would also eliminate much of this overhead.
> So perhaps we should tackle this angle? If that's a more tangible
> solution ?
>
> From the previous discussions that Matthew shared [7], it seems like
> Dave proposed an alternative to moving the extents to the VFS layer to
> invert the IO read path operations [8]. Maybe this is a move
> approachable solution since there is precedence for the same in the
> write path?
>
> [7] https://lore.kernel.org/linux-fsdevel/Zs97qHI-wA1a53Mm@casper.infrade=
ad.org/
> [8] https://lore.kernel.org/linux-fsdevel/ZtAPsMcc3IC1VaAF@dread.disaster=
.area/

+ cc: Dave Chinner

>
> Thanks,
> Kalesh
> >
> > >
> > >                                                               Honza
> > > --
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR

