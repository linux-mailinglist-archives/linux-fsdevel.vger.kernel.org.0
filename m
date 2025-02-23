Return-Path: <linux-fsdevel+bounces-42351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD25A40CDE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 06:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC3217C54D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 05:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424BF1D5AB5;
	Sun, 23 Feb 2025 05:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDqaOaiP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204B9B64A
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 05:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740289391; cv=none; b=Rc0qh4+Z0DusptOO0lzJGml2m4w7kyLJSvSzuxxsdLNtScnIeEx5/CKCd7/vamagq6g6GiLJzIo+Ue+AeHe3fkHTwHY1LCcHHaLfEudSKoAtOtTXF5A0YG7TAL7Se5GoA8dZA9Oq7K/MxLli5qNHjXYwRUzBEBOKgdlHgPSYHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740289391; c=relaxed/simple;
	bh=6uSMMC69UbJvzk8LRrmfA3b1eww5Lh/EtC5lrkNDmyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abED84jvZ5ojdFbmGkFs+YwCs+NkdMIm9cbPWYZcGlgpjatERAEtFVHT9PjOu9/h9cXcC3hPbxg7VIT4xWE4sO6TfHKH3JGqrFa1rW+b1VyPhWcV6CUzPjGG+1r+k85BTXd6HDCF8sSFKPUPFGmvq24iOXsTlClYVQgcvjbNgPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDqaOaiP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220e0575f5bso159825ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2025 21:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740289389; x=1740894189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE3d3sbh+bWtijwrCKbuEh5XHpX6xdGOFtmzdPzct/c=;
        b=eDqaOaiP70V2BfA/wQlMrkcf4vfDpMUbqteHCf494BGA3iQMsxbEKZGpYV4OA5NY+P
         C/XgU5fR5urwvg95l0aZG/BdIiSo262RL8+6lEL7V5QjygrasD0SwPe8iQ4A7cJCSLSs
         qGQ+fsMS46AolUXzzEntB8hNfoIhL2hVFoR5AKcNUp0v72zVReTHtY1Q6/DWJ+yJJvIU
         YVKSfojLz4Y12yMv8mdJOezH+Ygtr1HFlSr0YhtBQEaT0Dfihu2SMvtJujRhVQAdyiFC
         H72N3VQn7gk3RpZbYFH2kGoNowPjWVakjFN8V8a4OQTHk4ZHFpGoIhZHIgbgI3weXw/x
         V2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740289389; x=1740894189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BE3d3sbh+bWtijwrCKbuEh5XHpX6xdGOFtmzdPzct/c=;
        b=KeWp25wIhrbrNOm9/rYtTS2sGqIPP7ie+vcgTgFl/NNEIpWqNI2Ykna8xpTYj21Cks
         gkXht/tfcEBTyVj/eCz97XaHn4TIFmRGBmWP70or7h6oHm8jo+Q0RaGCOf2ubQVp8obn
         Uw+8UUXc0VXOAw0+VAhpB5B7ChcJ0i6J6OkqAZPscEjcVVO7bpjElOG0aYnjO45CFfWa
         dbsnxXQUiR9Wy17qJ/xlz7JTqzWj0NhXGSE55fhFkEzlzIVyNbonKB0Q28R5v2DkIv7E
         LNv4JWq4zdjQ87wF8LsUTcGmfOtS6WXGmnHseUkFBdHkJiY6TAY9f29CucRiPD60Twvj
         Wj0g==
X-Forwarded-Encrypted: i=1; AJvYcCUr1M4VythMs5waDusWcSr3zGd0LaHbX6aWDGQURUc1V61TshWYMn2YQeCZKjAUHMQyMsiCJ4JwDQfGzRb0@vger.kernel.org
X-Gm-Message-State: AOJu0YyY+hsWCqBktkb+z8RQB4VvcPSgSfBQPkWG72+Mjb8ywt3GHaQV
	ymOtMaQ18dTYLlV/6hzIXLMsf44em43YsnqVnFYWakgR+SiiLyyAov2raleKVVxoRzqJxcgyNVv
	VnCnGEe71SCurLs9F1R7cw0cY2IG4Lp6GK+25
X-Gm-Gg: ASbGncvZAg5jo+c7j+6dBNSe3lVDxO5lia+n1RXFAga55/TCVNgmtHYTqOVxD9rheGe
	SlubKym0OEOwzrbIoOvdkpnCIit3bK6ObBdTQ1R/+trdC5ekHghKbROxoA9omjgtimPubrxNTeP
	GNWCefmGD6x0YuI/08ZZHFvz8eDQ+cWKyyxFTrfsC/
X-Google-Smtp-Source: AGHT+IFENuwOSb+LOW0klyGvDARo4xHeFfqo8zrMIfmCtGX+JlK2PAUhzDUJEUg2PdpsEKRrDhLGyYs3NBSu6Wf50Ms=
X-Received: by 2002:a17:903:2345:b0:20c:f40e:6ec3 with SMTP id
 d9443c01a7336-221b9dd9268mr2103715ad.22.1740289389097; Sat, 22 Feb 2025
 21:43:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <dsvx2hyrdnv7smcrgpicqirwsmq5mcmbl7dbwmrx7dobrnxpbh@nxdhmkszdzyk> <CAC_TJvepQjR03qa-9C+kL4Or4COUFjZevv+-0gTUFYgNdquq-Q@mail.gmail.com>
In-Reply-To: <CAC_TJvepQjR03qa-9C+kL4Or4COUFjZevv+-0gTUFYgNdquq-Q@mail.gmail.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Sat, 22 Feb 2025 21:42:57 -0800
X-Gm-Features: AWEUYZk0wXUzGb8s7E_Tpr2DHpHdR7EE_8xj4LDHXPI7jfHnofpLwcCPCsHGebs
Message-ID: <CAC_TJvf1MbSJnmKEvbyZxBBd2i5V6zZxDXvzxWH2ag1CgJMKZg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead Behavior
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Juan Yescas <jyescas@google.com>, android-mm <android-mm@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 9:36=E2=80=AFPM Kalesh Singh <kaleshsingh@google.co=
m> wrote:
>
> On Sat, Feb 22, 2025 at 10:03=E2=80=AFAM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Fri, Feb 21, 2025 at 01:13:15PM -0800, Kalesh Singh wrote:
> > > Hi organizers of LSF/MM,
> > >
> > > I realize this is a late submission, but I was hoping there might
> > > still be a chance to have this topic considered for discussion.
> > >
> > > Problem Statement
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Readahead can result in unnecessary page cache pollution for mapped
> > > regions that are never accessed. Current mechanisms to disable
> > > readahead lack granularity and rather operate at the file or VMA
> > > level. This proposal seeks to initiate discussion at LSFMM to explore
> > > potential solutions for optimizing page cache/readahead behavior.
> > >
> > >
> > > Background
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > The read-ahead heuristics on file-backed memory mappings can
> > > inadvertently populate the page cache with pages corresponding to
> > > regions that user-space processes are known never to access e.g ELF
> > > LOAD segment padding regions. While these pages are ultimately
> > > reclaimable, their presence precipitates unnecessary I/O operations,
> > > particularly when a substantial quantity of such regions exists.
> > >
> > > Although the underlying file can be made sparse in these regions to
> > > mitigate I/O, readahead will still allocate discrete zero pages when
> > > populating the page cache within these ranges. These pages, while
> > > subject to reclaim, introduce additional churn to the LRU. This
> > > reclaim overhead is further exacerbated in filesystems that support
> > > "fault-around" semantics, that can populate the surrounding pages=E2=
=80=99
> > > PTEs if found present in the page cache.
> > >
> > > While the memory impact may be negligible for large files containing =
a
> > > limited number of sparse regions, it becomes appreciable for many
> > > small mappings characterized by numerous holes. This scenario can
> > > arise from efforts to minimize vm_area_struct slab memory footprint.
> > >
> > > Limitations of Existing Mechanisms
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > >
> > > fadvise(..., POSIX_FADV_RANDOM, ...): disables read-ahead for the
> > > entire file, rather than specific sub-regions. The offset and length
> > > parameters primarily serve the POSIX_FADV_WILLNEED [1] and
> > > POSIX_FADV_DONTNEED [2] cases.
> > >
> > > madvise(..., MADV_RANDOM, ...): Similarly, this applies on the entire
> > > VMA, rather than specific sub-regions. [3]
> > > Guard Regions: While guard regions for file-backed VMAs circumvent
> > > fault-around concerns, the fundamental issue of unnecessary page cach=
e
> > > population persists. [4]
> >
> Hi Kent. Thanks for taking a look at this.
>
> > What if we introduced something like
> >
> > madvise(..., MADV_READAHEAD_BOUNDARY, offset)
> >
> > Would that be sufficient? And would a single readahead boundary offset
> > suffice?
>
> I like the idea of having boundaries. In this particular example the
> single boundary suffices, though I think we=E2=80=99ll need to support
> multiple (see below).
>
> One requirement that we=E2=80=99d like to meet is that the solution doesn=
=E2=80=99t
> cause VMA splits, to avoid additional slab usage, so perhaps fadvise()
> is better suited to this?
>
> Another behavior of =E2=80=9Cmmap readahead=E2=80=9D is that it doesn=E2=
=80=99t really respect
> VMA (start, end) boundaries:
>
> The below demonstrates readahead past the end of the mapped region of the=
 file:
>
> sudo sync && sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches' &&
> ./pollute_page_cache.sh
>
> Creating sparse file of size 25 pages
> Apparent Size: 100K
> Real Size: 0
> Number cached pages: 0
> Reading first 5 pages via mmap...
> Mapping and reading pages: [0, 6) of file 'myfile.txt'
> Number cached pages: 25
>
> Similarly the readahead can bring in pages before the start of the
> mapped region. I believe this is due to mmap =E2=80=9Cread-around=E2=80=
=9D [6]:

I missed the reference to read-around in previous response:

[6] https://github.com/torvalds/linux/blob/v6.13-rc3/mm/filemap.c#L3195-L32=
04

>
> sudo sync && sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches' &&
> ./pollute_page_cache.sh
>
> Creating sparse file of size 25 pages
> Apparent Size: 100K
> Real Size: 0
> Number cached pages: 0
> Reading last 5 pages via mmap...
> Mapping and reading pages: [20, 25) of file 'myfile.txt'
> Number cached pages: 25
>
> I=E2=80=99m not sure what the historical use cases for readahead past the=
 VMA
> boundaries are; but at least in some scenarios this behavior is not
> desirable. For instance, many apps mmap uncompressed ELF files
> directly from a page-aligned offset within a zipped APK as a space
> saving and security feature. The read ahead and read around behaviors
> lead to unrelated resources from the zipped APK populated in the page
> cache. I think in this case we=E2=80=99ll need to have more than a single
> boundary per file.
>
> A somewhat related but separate issue is that currently distinct pages
> are allocated in the page cache when reading sparse file holes. I
> think at least in the case of reading this should be avoidable.
>
> sudo sync && sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches' &&
> ./pollute_page_cache.sh
>
> Creating sparse file of size 1GB
> Apparent Size: 977M
> Real Size: 0
> Number cached pages: 0
> Meminfo Cached:          9078768 kB
> Reading 1GB of holes...
> Number cached pages: 250000
> Meminfo Cached:         10117324 kB
>
> (10117324-9078768)/4 =3D 259639 =3D ~250000 pages # (global counter =3D s=
ome noise)
>
> --Kalesh

