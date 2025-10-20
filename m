Return-Path: <linux-fsdevel+bounces-64790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F235BBF3F63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 00:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C00E4F291F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B40931E0EF;
	Mon, 20 Oct 2025 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="F7968/TS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F97331D758
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761000397; cv=none; b=Ly4mq4LTxF6Y/gL+SDecnYQcBq0NaLiYSRbs7HpqDt7vhdxms8v5PLKGHizPs5U2kJQyqQQ79QAn5AITuw/jEVuwVrXvkVeg74uFGdzm/FBHjAcjupdzyhOIw2R1+lQrx+bNdtuCuhS/aI+R3DEv8CCtSL1dFPlHZScrv5Qyjpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761000397; c=relaxed/simple;
	bh=tg/WtCVAyCNywj42umEUEmZjcANyQLTq/nfy6UTS1k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOGmllkb+ZpRxvOxHEGxzdYVgeFMiYXAD/ohWHLhO0MOek18mmihnXLqRjgqhKtbtCoXNzyZy6omN8donW0HOkR65itwsUo3lDU/lGJBxY4mvY7nDH4ejAUG4SceTp7G75uE6mQVclidmr6bN6m/mHdv/SweWJ6Rlv7TMZkO1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=F7968/TS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-279e2554c8fso45811045ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761000394; x=1761605194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bUtWq6BwnjWVaI8PPEZSZXu56vepaxMGdapsduu3y9o=;
        b=F7968/TSCZ0GGMRJRndd+6JETozjQadJ4ZGoeaAD1kX+j1z/s/zQ1WuDkUQZJSNBKn
         DHT0g/56BH5LrNXmeUsuDbIZQE/4RdxU0eMgTo4yvO6y3y+vukthTBEXAsT9rvjwfFV/
         abkEN5hNiUkRc4wHyPBh80zC60JZTWC0UW1xQZ63m3Hw2UWqp8NJ8oYmBRjWbrL52C3a
         qbKfJ9TFFW9pvraGXvPtSvFHDfI+6cCHhOmajnyX917yptA6c0i5rwshexRcK3cV03ZF
         6DEOqwLmlL5SwZHBucwODinCOhtWjIBBWm0gn6xeFA6z/WMcKzyRPXUWoJv90gFsuLqb
         tRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761000394; x=1761605194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUtWq6BwnjWVaI8PPEZSZXu56vepaxMGdapsduu3y9o=;
        b=Ncn330d4nCSe+OXaSrMS72HqxD6QpsTU6BKOCQKHGPGQrf+aDN/NhFYD+PghC/dVXS
         Zz3kqcf2a8dxGDJaQTcp963AgZh6LHvrhauK4xR5M9hU0pSUbd4Bxzcfyzmc/98UqU5/
         GLmYq9i5lXBYS3RUL+9fpek1JJ9Toyys43JP1IFGqRtxTK0C1yQq32Q5T951ESSyk4CZ
         GR5mC2reUjjYiukHcg9pVstga4nd4IDLFgI+QssJR3NukCENo0pjD4J62C8MM4JJtvz7
         iMzytsKTRgvCWbSDpdVsIKbrvTUDrUKJMa2ljExYdaNmaZQQoaG+WAGlbP3OLgGxn/YS
         e3xw==
X-Forwarded-Encrypted: i=1; AJvYcCU/QOY7SuThLdWTXH4bzdMF8Jy7Yix2d1MYmvy6i4sobDZ2RyIQI0wohgDSarLgQUkZemh2oCiJYyVjdpTI@vger.kernel.org
X-Gm-Message-State: AOJu0YwGr0YTUlq8LFlN6BofKMPZl92ddpimyRBGLsgUvPxnwQPMKS5e
	Aj+sdxF7YQ/r76BnF7h391tfwPSw7BHGsmnd9jZSGuU225dXWDg92MEmIY/Odma4yok=
X-Gm-Gg: ASbGnctH1D3iyo8lt1+Sv7KDC18fAogrWhvqQLExn0aw5iLYM5MmqM7hZ/qNxKM0N3D
	+ChcuRcshg8ivx1dK7O1m90+pF1V0hKVEWLyyfJ/LNWmZBj118/cwcX8AlceYRPgr6UY6sp8f8l
	juUyzoBZiFZOhqRDqH9kqNSNShlTeLUGadgIMgtX/imH1haC+HE7HmfcXL9VdtfAdfrPHn0YtBH
	JrtmC12mYYX/csujyw2hWzGBDYaHyvXGFIv5+4NjYXCTrPY1rT8KL8svs4KskpU49yaoTc7D9CL
	GM2RLakSnRH5W54Ph7ddpN9svaAs6b/Wj7j8S5UvGUDNWAsh/cFqLugTuOfO9RE7VwCuNOPRQ1e
	1EeUKfvQlj1bhq6hW4gM8brAE3Gck2dGeesMWHV4HApxN0o7CdhiA7eBmwT9qlGq8YqN5lKrfly
	hfcODffZMkWscSPSuZdYYkCwHikxQIL889etVW2rPycEMrcZnUqNQ=
X-Google-Smtp-Source: AGHT+IFUIIz9u3gROHoyBrX9GrfKv6A6QBpIppZbYxVF4pPYqH4Q7yX35XtiJX79fRgqZ/TJvN1KGA==
X-Received: by 2002:a17:902:d4c4:b0:25b:f1f3:815f with SMTP id d9443c01a7336-290cb65f80emr187540085ad.58.1761000394302;
        Mon, 20 Oct 2025 15:46:34 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d594esm90846765ad.72.2025.10.20.15.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:46:33 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vAye6-0000000HVzd-2eTg;
	Tue, 21 Oct 2025 09:46:30 +1100
Date: Tue, 21 Oct 2025 09:46:30 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu,
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	clm@meta.com, amir73il@gmail.com, axboe@kernel.dk, hch@lst.de,
	ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net,
	wangyufei@vivo.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
Message-ID: <aPa7xozr7YbZX0W4@dread.disaster.area>
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com>
 <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>

On Tue, Oct 14, 2025 at 05:38:29PM +0530, Kundan Kumar wrote:
> Number of writeback contexts
> ============================
> We've implemented two interfaces to manage the number of writeback
> contexts:
> 1) Sysfs Interface: As suggested by Christoph, we've added a sysfs
>    interface to allow users to adjust the number of writeback contexts
>    dynamically.
> 2) Filesystem Superblock Interface: We've also introduced a filesystem
>    superblock interface to retrieve the filesystem-specific number of
>    writeback contexts. For XFS, this count is set equal to the
>    allocation group count. When mounting a filesystem, we automatically
>    increase the number of writeback threads to match this count.

This is dangerous. What happens when we mount a filesystem with
millions of AGs?


> Resolving the Issue with Multiple Writebacks
> ============================================
> For XFS, affining inodes to writeback threads resulted in a decline
> in IOPS for certain devices. The issue was caused by AG lock contention
> in xfs_end_io, where multiple writeback threads competed for the same
> AG lock.
> To address this, we now affine writeback threads to the allocation
> group, resolving the contention issue. In best case allocation happens
> from the same AG where inode metadata resides, avoiding lock contention.

Not necessarily. The allocator can (and will) select different AGs
for an inode as the file grows and the AGs run low on space. Once
they select a different AG for an inode, they don't tend to return
to the original AG because allocation targets are based on
contiguous allocation w.r.t. existing adjacent extents, not the AG
the inode is located in.

Indeed, if a user selects the inode32 mount option, there is
absolutely no relationship between the AG the inode is located in
and the AG it's data extents are allocated in. In these cases,
using the inode resident AG is guaranteed to end up with a random
mix of target AGs for the inodes queued in that AG.  Worse yet,
there may only be one AG that can have inodes allocated in it, so
all the writeback contexts for the other hundreds of AGs in the
filesystem go completely unused...

> Similar IOPS decline was observed with other filesystems under different
> workloads. To avoid similar issues, we have decided to limit
> parallelism to XFS only. Other filesystems can introduce parallelism
> and distribute inodes as per their geometry.

I suspect that the issues with XFS lock contention are related to
the fragmentation behaviour observed (see below) massively
increasing the frequency of allocation work for a given amount of
data being written rather than increasing writeback concurrency...

> 
> IOPS and throughput
> ===================
> With the affinity to allocation group we see significant improvement in
> XFS when we write to multiple files in different directories(AGs).
> 
> Performance gains:
>   A) Workload 12 files each of 1G in 12 directories(AGs) - numjobs = 12
>     - NVMe device BM1743 SSD

So, 80-100k random 4kB write IOPS, ~2GB/s write bandwidth.

>         Base XFS                : 243 MiB/s
>         Parallel Writeback XFS  : 759 MiB/s  (+212%)

As such, the baseline result doesn't feel right - it doesn't match
my experience with concurrent sequential buffered write workloads on
SSDs. My expectation is that they'd get close to device bandwidth or
run out of copy-in CPU at somewhere over 3GB/s.

So what are you actually doing to get these numbers? What is the
benchmark (CLI and conf files details, please!), what is the
mkfs.xfs output, and how many CPUs/RAM do you have on the machines
you are testing?  i.e. please document them sufficiently so that
other people can verify your results.

Also, what is the raw device performance and how close to that are
we getting through the filesystem?

>     - NVMe device PM9A3 SSD

130-180k random 4kB write IOPS, ~4GB/s write bandwidth. So roughly
double the physical throughput of the BM1743, and ....

>         Base XFS                : 368 MiB/s
>         Parallel Writeback XFS  : 1634 MiB/s  (+344%)

.... it gets roughly double the physical throughput of the BM1743.

This doesn't feel like a writeback concurrency limited workload -
this feels more like a device IOPS and IO depth limited workload.

>   B) Workload 6 files each of 20G in 6 directories(AGs)  - numjobs = 6
>     - NVMe device BM1743 SSD
>         Base XFS                : 305 MiB/s
>         Parallel Writeback XFS  : 706 MiB/s  (+131%)
> 
>     - NVMe device PM9A3 SSD
>         Base XFS                : 315 MiB/s
>         Parallel Writeback XFS  : 990 MiB/s  (+214%)
> 
> Filesystem fragmentation
> ========================
> We also see that there is no increase in filesystem fragmentation
> Number of extents per file:

Are these from running the workload on a freshly made (i.e. just run
mkfs.xfs, mount and run benchmark) filesystem, or do you reuse the
same fs for all tests?

>   A) Workload 6 files each 1G in single directory(AG)   - numjobs = 1
>         Base XFS                : 17
>         Parallel Writeback XFS  : 17

Yup, this implies a sequential write workload....

>   B) Workload 12 files each of 1G to 12 directories(AGs)- numjobs = 12
>         Base XFS                : 166593
>         Parallel Writeback XFS  : 161554

which implies 144 files, and so over 1000 extents per file. Which
means about 1MB per extent and is way, way worse than it should be
for sequential write workloads.

> 
>   C) Workload 6 files each of 20G to 6 directories(AGs) - numjobs = 6
>         Base XFS                : 3173716
>         Parallel Writeback XFS  : 3364984

36 files, 720GB and 3.3m extents, which is about 100k extents per
file for an average extent size of 200kB. That would explain why it
performed roughly the same on both devices - they both have similar
random 128kB write IO performance...

But that fragmentation pattern is bad and shouldn't be occurring fro
sequential writes. Speculative EOF preallocation should be almost
entirely preventing this sort of fragmentation for concurrent
sequential write IO and so we should be seeing extent sizes of at
least hundreds of MBs for these file sizes.

i.e. this feels to me like you test is triggering some underlying
delayed allocation defeat mechanism that is causing physical
writeback IO sizes to collapse. This turns what should be a
bandwitdh limited workload running at full device bandwidth into an
IOPS and IO depth limited workload.

In adding writeback concurrency to this situation, it enables
writeback to drive deeper IO queues and so extract more small IO
performance from the device, thereby showing better performance for
the wrokload. The issue is that baseline writeback performance is
way below where I think it should be for the given IO workload (IIUC
the workload being run, hence questions about benchmarks, filesystem
configs and test hardware).

Hence while I certainly agree that writeback concurrency is
definitely needed, I think that the results you are getting here are
a result of some other issue that writeback concurrency is
mitigating. The underlying fragmentation issue needs to be
understood (and probably solved) before we can draw any conclusions
about the performance gains that concurrent writeback actually
provides on these workloads and devices...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

