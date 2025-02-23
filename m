Return-Path: <linux-fsdevel+bounces-42350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26070A40CD8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 06:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B5B3BDF96
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 05:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB7E194A45;
	Sun, 23 Feb 2025 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4iEUKLDU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612D9EEB5
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740289023; cv=none; b=km41slmySvN9SHVvDRgkdrUIxzi6nY7nynU9rJNJtKsqBIBwMhufZ5ldxzt+lrgtEEouSlNtpN5mjEYI/yhQOB+Fat6dfoThaDWl+XOqLsd4sNZaImKkyA9F0HklM2rVMQL4kXuUV3JPHyPYyGrxoQiFng20UXYCt/jKPF2St6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740289023; c=relaxed/simple;
	bh=IbJ6XLBMroszC+e+xIsn1cVQempr53hIv+ETTrUy5qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3L3nbwncWILniDRP1ZMoqLRVft5Fi1CMND2OzWMazCyJskUgt+PntMM2wAD3T/VAfKw0zfddMBptgoq+fvblkXzZnIplkE0XC5vAiQwdGEAKdv5OvRTYfgiwBj9cjkfs4FiJeGpCYjEK/1B8FEeuFQs7L+TRtq+J8gqZ7MxoWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4iEUKLDU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-221ac1f849fso120095ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2025 21:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740289020; x=1740893820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2U1cZZtP1t5fw8vCFeBScYJcRg8hJmMQWNMS+Dse9lI=;
        b=4iEUKLDUD59F00/ekLL30iWy1t1yhne3+WNA2xYWsaCanV3GZSBjMiV+1lATyPX66v
         sxz5uLbDh5LLyErh8MQUggRvCGxk4t1iXVLkDi1Uv2j7mGPkOl9wenKVy5SKR1Rp1ldh
         mOIjng5M3HjUkimSP1xJyYmQyjHyrK8k4BavFEyUj9yjdOt+7er/LJp73Kt1q/m9iqw/
         V9GsFTnht2YP86aj4OQSCvdV3CBQCDs+4HiTN6u7sm1QeElm7yqcMpq/jVhBtAFt4M/z
         hi5+urJnPZp0oD0ZqzzAuj4TLSBuDceW9NGrCEz4qG8drcDbem3oSAzlFdkbAJ0uLrwG
         e5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740289020; x=1740893820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2U1cZZtP1t5fw8vCFeBScYJcRg8hJmMQWNMS+Dse9lI=;
        b=rkbOjjW1XgyC55xuZA8WsgkcXyhlUFIGEt4MXuYxzPZPDHYxwmZbfbtpgigIBjvvvZ
         N/Yl+NnxkOGE9F7LUoAlnvh+Omcl1AQ2++Px5hAG+TEvtJJzbhifLHszBPVcVH1UhPKd
         rRqi1hB1x7TPq6qdMf4ka7HMDcla5gdPV7pUtzgVtgVrJnIWdPRzFCjelE4ZMy99Rho6
         r8UIV4WIfoRYmzl2qbGXHo3kvlUg6f+t7AUeqkAjx5g9ifJgjxOaDjozYU0n0VRZFZ9L
         Tidr7BGVFc0jA0kLJlf+cechjHBSPJweSCkZALa3ZZK2hp/ok/dWEKIsESETegfglfqO
         8lnw==
X-Forwarded-Encrypted: i=1; AJvYcCVdbsavPqqPbADMD9Dmgb+kCkf8/l8yiBw+538tB5k8RM5GeyW8VYtifyjPYuqvLirmynQQ3ixNv0jpvp85@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9EkePsA4Hj4jPZJiEu+wy2GC/MNleVRwoT6ZNV53oEC8XCf5R
	xImdT4pyxUWAjZfaGQKJ0U1FdtvLPH7dPYRspkRBKMLNAeRTONNHtGZREbp2dlt1rCvIdDUaLh3
	bVqTxC8/6ic8Va+m62BbKhzId4dd84F1fAMng
X-Gm-Gg: ASbGnctFCmvr8kVtr5ZdH2YzOypCtCDhHg6o6y0G8JzoMPVmre+BtYje20iZZCo66jh
	+8Dl/yyypkHDc3acsSFOuyF3B5xTHgl5Y5Q47auaVb5CXnTKfDU/9F1oQZ9fPFd8eNalKOroqYT
	f5S+SYb/E7qM3oqeK1Zr8T3hUCI9+NC8ZWectSbvSc
X-Google-Smtp-Source: AGHT+IFIKbq1ZrWpsHRtayDZ0KfGBGkVAAKZRW+Pi04rJ3Pc64qMYRildOJsLXGEroFjwjKZZCA/xaVjzJgLEvyBkNY=
X-Received: by 2002:a17:903:2345:b0:20c:f40e:6ec3 with SMTP id
 d9443c01a7336-221b9dd9268mr2099625ad.22.1740289020058; Sat, 22 Feb 2025
 21:37:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <dsvx2hyrdnv7smcrgpicqirwsmq5mcmbl7dbwmrx7dobrnxpbh@nxdhmkszdzyk>
In-Reply-To: <dsvx2hyrdnv7smcrgpicqirwsmq5mcmbl7dbwmrx7dobrnxpbh@nxdhmkszdzyk>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Sat, 22 Feb 2025 21:36:48 -0800
X-Gm-Features: AWEUYZm8XPbV39YsnKhfI-c5mFXvM8q-woByZlAG_2DR_tNyaEYsyTbRI13zBYI
Message-ID: <CAC_TJvepQjR03qa-9C+kL4Or4COUFjZevv+-0gTUFYgNdquq-Q@mail.gmail.com>
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

On Sat, Feb 22, 2025 at 10:03=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Fri, Feb 21, 2025 at 01:13:15PM -0800, Kalesh Singh wrote:
> > Hi organizers of LSF/MM,
> >
> > I realize this is a late submission, but I was hoping there might
> > still be a chance to have this topic considered for discussion.
> >
> > Problem Statement
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Readahead can result in unnecessary page cache pollution for mapped
> > regions that are never accessed. Current mechanisms to disable
> > readahead lack granularity and rather operate at the file or VMA
> > level. This proposal seeks to initiate discussion at LSFMM to explore
> > potential solutions for optimizing page cache/readahead behavior.
> >
> >
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The read-ahead heuristics on file-backed memory mappings can
> > inadvertently populate the page cache with pages corresponding to
> > regions that user-space processes are known never to access e.g ELF
> > LOAD segment padding regions. While these pages are ultimately
> > reclaimable, their presence precipitates unnecessary I/O operations,
> > particularly when a substantial quantity of such regions exists.
> >
> > Although the underlying file can be made sparse in these regions to
> > mitigate I/O, readahead will still allocate discrete zero pages when
> > populating the page cache within these ranges. These pages, while
> > subject to reclaim, introduce additional churn to the LRU. This
> > reclaim overhead is further exacerbated in filesystems that support
> > "fault-around" semantics, that can populate the surrounding pages=E2=80=
=99
> > PTEs if found present in the page cache.
> >
> > While the memory impact may be negligible for large files containing a
> > limited number of sparse regions, it becomes appreciable for many
> > small mappings characterized by numerous holes. This scenario can
> > arise from efforts to minimize vm_area_struct slab memory footprint.
> >
> > Limitations of Existing Mechanisms
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >
> > fadvise(..., POSIX_FADV_RANDOM, ...): disables read-ahead for the
> > entire file, rather than specific sub-regions. The offset and length
> > parameters primarily serve the POSIX_FADV_WILLNEED [1] and
> > POSIX_FADV_DONTNEED [2] cases.
> >
> > madvise(..., MADV_RANDOM, ...): Similarly, this applies on the entire
> > VMA, rather than specific sub-regions. [3]
> > Guard Regions: While guard regions for file-backed VMAs circumvent
> > fault-around concerns, the fundamental issue of unnecessary page cache
> > population persists. [4]
>
Hi Kent. Thanks for taking a look at this.

> What if we introduced something like
>
> madvise(..., MADV_READAHEAD_BOUNDARY, offset)
>
> Would that be sufficient? And would a single readahead boundary offset
> suffice?

I like the idea of having boundaries. In this particular example the
single boundary suffices, though I think we=E2=80=99ll need to support
multiple (see below).

One requirement that we=E2=80=99d like to meet is that the solution doesn=
=E2=80=99t
cause VMA splits, to avoid additional slab usage, so perhaps fadvise()
is better suited to this?

Another behavior of =E2=80=9Cmmap readahead=E2=80=9D is that it doesn=E2=80=
=99t really respect
VMA (start, end) boundaries:

The below demonstrates readahead past the end of the mapped region of the f=
ile:

sudo sync && sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches' &&
./pollute_page_cache.sh

Creating sparse file of size 25 pages
Apparent Size: 100K
Real Size: 0
Number cached pages: 0
Reading first 5 pages via mmap...
Mapping and reading pages: [0, 6) of file 'myfile.txt'
Number cached pages: 25

Similarly the readahead can bring in pages before the start of the
mapped region. I believe this is due to mmap =E2=80=9Cread-around=E2=80=9D =
[6]:

sudo sync && sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches' &&
./pollute_page_cache.sh

Creating sparse file of size 25 pages
Apparent Size: 100K
Real Size: 0
Number cached pages: 0
Reading last 5 pages via mmap...
Mapping and reading pages: [20, 25) of file 'myfile.txt'
Number cached pages: 25

I=E2=80=99m not sure what the historical use cases for readahead past the V=
MA
boundaries are; but at least in some scenarios this behavior is not
desirable. For instance, many apps mmap uncompressed ELF files
directly from a page-aligned offset within a zipped APK as a space
saving and security feature. The read ahead and read around behaviors
lead to unrelated resources from the zipped APK populated in the page
cache. I think in this case we=E2=80=99ll need to have more than a single
boundary per file.

A somewhat related but separate issue is that currently distinct pages
are allocated in the page cache when reading sparse file holes. I
think at least in the case of reading this should be avoidable.

sudo sync && sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches' &&
./pollute_page_cache.sh

Creating sparse file of size 1GB
Apparent Size: 977M
Real Size: 0
Number cached pages: 0
Meminfo Cached:          9078768 kB
Reading 1GB of holes...
Number cached pages: 250000
Meminfo Cached:         10117324 kB

(10117324-9078768)/4 =3D 259639 =3D ~250000 pages # (global counter =3D som=
e noise)

--Kalesh

