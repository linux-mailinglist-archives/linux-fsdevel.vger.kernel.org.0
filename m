Return-Path: <linux-fsdevel+bounces-40346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB404A2266B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 23:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDE71885112
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 22:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015651A8F97;
	Wed, 29 Jan 2025 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="tVoupXV0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737761FC8
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738191111; cv=none; b=sRTCaHC5wrOqmZ6MSYUnBYCYh7PFLJ1bpAA6iFf/2Ux5Kl3pmSzBFvXTprvjrzts5BGaDc4tj0yiSOCXVXdFHwzX12AYrXQS8lAOw6FytSfaL8RzkUZyS+NDnG8BWrVgjGiXX/cy3vm3DOoCbzDXuEjGjbWYrRYv/zjG0mqE2z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738191111; c=relaxed/simple;
	bh=8R54uij/jN5iUIesVBKs2OcapsaJq3c2VULyhoI1t1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amAzGyK5oBjL8Oo48PALyW769B27VeBcLCvZz09Ct30VyanPcLtB2INS4ALf8JQQmZRl2bPvr7S32C0wHvy2sYQJUPME27FAD7LoBdvhXDAmR3dDnGwp4tft8evAzdHYFap+8I3ZCUO4vw/fsmsL3l1UbfbNASeHYJW5zCqeaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=tVoupXV0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21c2f1b610dso3783105ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 14:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738191109; x=1738795909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gdA3SF6gQNAs06i6iNYN/iuwcc83pq3fxX701ndED2U=;
        b=tVoupXV0KUmBgJ0fYXKcfdcyzpJJjrx50dhACI6nKu0fx5VOxtdm/BN6A92FJcNVkp
         C/lHeuPWo3chcPxRHFqI3WjyluJJrK4HzeXO1nr0AwKYVmhxUlA16LXsZUPX8c6l2hPy
         iQ27Q++5Ufucow8WcOD+gNEhlelQj9k+e9wlWdo2IahdJjsvVA77nX2eNhKnVStU61Pe
         D9GyR1yqUh0H7yzP4xW9hNQVz+iPGaWK/6M9Rw0KhoI7Q8h+ew3gpjurHl7GY7v0wOCf
         TwDy7zxSG83XvXEb1jrCBJCPumObCRQyrFdOIetCKD6P7XJQuBAVJESlsuyQBtaojsU5
         DNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738191109; x=1738795909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdA3SF6gQNAs06i6iNYN/iuwcc83pq3fxX701ndED2U=;
        b=KtC3gsnqcht/QsXGd84KnObVsWbx+lxVsLnW17HdxjTAFDv8+sq6LUGWlAnsiATAGv
         xt36gB7S4D3L0BFHAxocIN+rdj7C22aN7Q3FeqSGCCuma40MqUgK6MQBns55KyMs6Dwd
         HO1NhDXBoZD/FplaPkIvKFRqvjFONKHr7mQxWRoqS8uWVyyVMFAe6KyqfARSMC7zMEXS
         5fIO4BcKJqpn1jgUj9rIdFrVNhMsFwauf7rikNZxoMfJMoZE82EtW4hle1Dpqx6fzG/K
         ILJoL1aSfpwGM0gvxvK2PSIBcSgEpZLzBHeLKNe4ajx243/OsSGeyyBcu0gfBOiL5pSR
         rReA==
X-Forwarded-Encrypted: i=1; AJvYcCVmkxCS7KtuEcYWW/1vcro+TonmQbsCoW/6uQDueELgP8Wnrv8u+/JnMhkEoRRjzepDcU8zqUo22NFvgi1W@vger.kernel.org
X-Gm-Message-State: AOJu0YwynyBhioeXdV/jpZ5u+Cr2avps90/ciW/EzJX8yrDwAZ3I7Gds
	JcgneU7f6rMPWWBmk953hjEgcdTzU96nyKGtVh3WpcYrsHC2ZbqDBywuSgkzTkc=
X-Gm-Gg: ASbGncsysDTBSVNgOON6XwbuPwxon0ookoOOCvAlKAAryi9bL7DIuJ5AJ3HxKTIFGFl
	6evF43QWU9bM9+0K2QJHFjcJ7yrd2VMocaylpET/VEGwglnCXxD9694KtlDBVWfzE5v1sX24pvX
	/jlLDFAxoDCk9DkazopbJPXuhBi6YlChobZrJVHRm4g8uIpNAbAc5Msprun7mevKJ2Un9+RlqZr
	gENkJSqf9J/psbBVfZe/c1YKMW+G6LwyVI2fCu7eThN57Q+/HLnLQWUNBi5YHsiuJTaCB//6zMU
	1Tk4vZa7eA7dOLprrFG5Lur913+lvCtGf9GBXuzfDX4oODyFEpiXJM/20L34KMn3As4=
X-Google-Smtp-Source: AGHT+IEzjQs5XZtyAiwb3Yq2ePZlDwgh93j0WicwmhEOLkB/9GHcRitPgqlAj2mZjc7b/EeuVA3r0w==
X-Received: by 2002:a17:903:22ce:b0:216:56c7:98a7 with SMTP id d9443c01a7336-21dd7df5fb7mr77862605ad.53.1738191108637;
        Wed, 29 Jan 2025 14:51:48 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3303f8csm1097505ad.206.2025.01.29.14.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 14:51:47 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tdGuN-0000000CBHR-05cQ;
	Thu, 30 Jan 2025 09:51:43 +1100
Date: Thu, 30 Jan 2025 09:51:43 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	anuj20.g@samsung.com, mcgrof@kernel.org, joshi.k@samsung.com,
	axboe@kernel.dk, clm@meta.com, hch@lst.de, willy@infradead.org,
	gost.dev@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <Z5qw_1BOqiFum5Dn@dread.disaster.area>
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com>
 <20250129102627.161448-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129102627.161448-1-kundan.kumar@samsung.com>

On Wed, Jan 29, 2025 at 03:56:27PM +0530, Kundan Kumar wrote:
> Greetings everyone,
> 
> Anuj and I would like to present our proposal for implementing parallel
> writeback at LSF/MM. This approach could address the writeback performance
> issue discussed by Luis last year [1].
> 
> Currently, the pagecache writeback is executed in a single-threaded manner.
> Inodes are added to the dirty list, and the delayed writeback is scheduled.
> The single-threaded writeback then iterates through the dirty list and performs
> the writeback operations.
> 
> We have developed a prototype implementation of parallel writeback, where we
> have made the writeback process per-CPU-based. The b_io, b_dirty, b_dirty_time,
> and b_more_io lists have also been modified to be per-CPU. When an inode needs
> to be added to the b_dirty list, we select the next CPU (in a round-robin
> fashion) and schedule the per-CPU writeback work on the selected CPU.

My own experiments and experience tell me that per-cpu is not
the right architecture for expanding writeback concurrency.

The actual writeback parallelism that can be acheived is determined
by the underlying filesystem architecture and geometry, not the CPU
layout of the machine.

I think some background info on writeback concurrency is also
necessary before we go any further.

If we go back many years to before we had the current
write throttling architecture, we go back to an age where balance_dirty_pages()
throttled by submitting foreground IO itself. It was throttled by
the block layer submission queue running out of slots rather than
any specific performance measurement. Under memory pressure, this
lead highly concurrent dispatch of dirty pages, but very poor
selection of dirty inodes/pages to dispatch. The result was that
this foreground submission would often dispatch single page IOs,
and issue tens of them concurrently across all user processes that
were trying to write data. IOWs, throttling caused "IO breakdown"
where the IO pattern ended up being small random IO exactly when
we need to perform bulk cleaning of dirty pages. We needed bulk
page cleaning throughput, not random dirty page shootdown.

When we moved to "writeback is only done by the single BDI flusher
thread" architecture, we significantly improved system behaviour
under heavy load because writeback now had a tight focus issuing IO
from a single inode at a time as efficiently as possible. i.e.  when
we had large sequential dirty file regions, the writeback IO was all
large sequential IO, and that didn't get chopped up by another
hundred processes issuing IO from random other inodes at the same
time.

IOWs, having too much parallelism in writeback for the underlying
storage and/or filesystem can be far more harmful to system
performance under load than having too little parallelism to drive
the filesystem/hardware to it's maximum performance.

This is an underlying constraint that everyone needs to understand
before discussing writeback concurrency changes: excessive
writeback concurrency can result in worse outcomes than having no
writeback concurrency under sustained heavy production loads....

> With the per-CPU threads handling the writeback, we have observed a significant
> increase in IOPS. Here is a test and comparison between the older writeback and
> the newer parallel writeback, using XFS filesystem:
> https://github.com/kundanthebest/parallel_writeback/blob/main/README.md

What kernel is that from?

> In our tests, we have found that with this implementation the buffered I/O
> IOPS surpasses the DIRECT I/O. We have done very limited testing with NVMe
> (Optane) and PMEM.

Buffered IO often goes faster than direct for these workloads
because the buffered IO is aggregated in memory to much larger, less
random sequential IOs at writeback time.  Writing the data in fewer,
larger, better ordered IOs is almost always faster (at both the
filesystem and storage hardware layers) than a pure 4kB random IO
submission pattern.

i.e. with enough RAM, this random write workload using buffered IO
is pretty much guaranteed to outperform direct IO regardless of the
underlying writeback concurrency.

> There are a few items that we would like to discuss:
> 
> During the implementation, we noticed several ways in which the writeback IOs
> are throttled:
> A) balance_dirty_pages
> B) writeback_chunk_size
> C) wb_over_bg_thresh
> Additionally, there are delayed writeback executions in the form of
> dirty_writeback_centisecs and dirty_expire_centisecs.
>
> With the introduction of per-CPU writeback, we need to determine the
> appropriate way to adjust the throttling and delayed writeback settings.

Yup, that's kinda my point - residency of the dirty data set in the
page cache influences throughput in a workload like this more than
writeback parallelism does.

> Lock contention:
> We have observed that the writeback list_lock and the inode->i_lock are the
> locks that are most likely to cause contention when we make the thread per-CPU.

You clearly aren't driving the system hard enough with small IOs. :)

Once you load up the system with lots of small files (e.g.  with
fsmark to create millions of 4kB files concurrently) and use
flush-on-close writeback semantics to drive writeback IO submission
concurrency, the profiles are typically dominated by folio
allocation and freeing in the page cache and XFS journal free space
management (i.e. transaction reservation management around timestamp
updates, block allocation and unwritten extent conversion.)

That is, writeback parallelism in XFS is determined by the
underlying allocation parallelism of the filesystem and journal
size/throughput because it uses delayed allocation (same goes for
ext4 and btrfs). In the case of XFS, allocation parallelism is
determined by the filesytem geometry - the number of allocation
groups created at mkfs time.

So if you have 4 allocation groups (AGs) in XFS (typical default for
small filesystems), then you can only be doing 4 extent allocation
operations at once. Hence it doesn't matter how many concurrent
writeback contexts the system has, the filesystem will limit
concurrency in many workloads to just 4. i.e. the filesystem
geometry determines writeback concurrency, not the number of CPUs in
the system.

Not every writeback will require allocation in XFS (specualtive
delalloc beyond EOF greatly reduces this overhead) but when you have
hundreds of thousands of small files that each require allocation
(e.g. cloning or untarring a large source tree), then writeback has
a 1:1 ratio between per-inode writeback and extent allocation. This
is the case where filesystem writeback concurrency really matters...

> Our next task will be to convert the writeback list_lock to a per-CPU lock.
> Another potential improvement could be to assign a specific CPU to an inode.

As I mentioned above, per-cpu writeback doesn't seem like the right
architecture to me.

IMO, we need writeback to be optimised for is asynchronous IO
dispatch through each filesystems; our writeback IOPS problems in
XFS largely stem from the per-IO cpu overhead of block allocation in
the filesystems (i.e. delayed allocation).

Because of the way we do allocation locality in XFS, we always try
to allocate data extents in the same allocation group as the inode
is located.  Hence if we have a writeback context per AG, and we
always know what AG an inode is located in, we always know which
writeback context is should belong to.

Hence what a filesystem like XFS needs is the ability to say to the
writeback infrastructure "I need N writeback contexts" and then have
the ability to control which writeback context an inode is attached
to.

A writeback context would be an entirely self contained object with
dirty lists, locks to protect the lists, a (set of) worker threads
that does the writeback dispatch, etc.

Then the VFS will naturally write back all the inodes in a given AG
indepedently to the inodes in any other AG, and there will be almost
no serialisation on allocation or IO submission between writeback
contexts. And there won't be any excessive writeback concurrency at
the filesystem layer so contention problems during writeback go
away, too.

IOWs, for XFS we really don't want CPU aligned writeback lists, we
want filesystem geometry aligned writeback contexts...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

