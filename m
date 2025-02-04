Return-Path: <linux-fsdevel+bounces-40692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB52EA26A40
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 03:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44CF164954
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 02:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620AD145B16;
	Tue,  4 Feb 2025 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="tx096NvQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01CA142E7C
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738637414; cv=none; b=hxHgpNNxCZNgUhY46coGGXAheFHY3e2I1J4bGi8K+mjdasGgbvObF6uxYp4Cnax0PHqB/k2oDMUJxeEOCTdGzIf3Q5FPFG6JTfdx8AHchx/3h9/uR2DdyognZYr9VN3ta61GsnZVo81/+LVm6PFi3QdUDHVxZFMaQu/PV/mKAEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738637414; c=relaxed/simple;
	bh=a/4dPfwimuygysPiFeAAPX5FA9FA5oLRFfesDyLq75s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG9MfJmztEbcujfDJ1z7uffShIXJbWs3bjrNyOo3qhm/s5iyvy0BaQ7rrkkSEDz3V/i4t5TvVQooMP5Q2/LilVwYV5cpNbM+fuYmZWbTja4kVN2l6rlr0oMs7+2WZExJiy+azYc/7CuFrQM67MsJcLmRYVzMky63KBhIxZX+zqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=tx096NvQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f9bd7c480eso584194a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 18:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738637412; x=1739242212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7C2oVqc8y98TDUj5uETh96/okBC18wzfttscQcZivI=;
        b=tx096NvQW/hKvTMIbV79VsQQpU4beOdysEU9nEPr5SWRCWQXTfkbK7sfQDfgW+bF2z
         s44RfDYU1QLZ6+IcFKQjhCxgq3N52rO1W+1ttVq7TNw37hfuUdbdHDLyjTAcm9lEVqMg
         dW0H6aF5xGU40Gqfr1gbJ+TjetmUQRDB3y1b1g/9e1raMjGgfW9frhks393vDllIPet/
         0YVQQkHRZPdflsuo6pSw7/kkIm8vh1yneLxsOFPfxWVFfaWebhTVureMT++77YV53tYp
         IU/WSCkgHbz34muwEB/5Dbn6Oc5WPKzBcjbMRt74ucc+mcNUxy94ql4DieB2Gd7RgsOi
         Epdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738637412; x=1739242212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7C2oVqc8y98TDUj5uETh96/okBC18wzfttscQcZivI=;
        b=dWUGKJoRbcIVK3MAdiitpkz5WGlJFFlk0MrtsJRLmXt5d9SmEXTkYyJRKNkpEwI6iq
         +C2s9Z3sHRVM25wps1ZByFR8H2Tex2Od3H60+H1rUukNwILYESMRpyRL9vWEujpIeIRL
         qQ2sPHxvkiHwOgk9e5kLMvitVKWrFztUUt3oAbWPGoJI1vYZlhEN5s//ysnVwWnXgzAR
         Bnh1GZlalteUGuZesMU0OkvPXbBHKCTw0T6cOQmqvmV5/CiW210X5ewqzRLa6Fe+42AM
         UdErl2e6/FHYxrJAb17FwkydXEvBPwcxDy05iOdCmWoaS2cejxmge+VeBRjVMkudSPYG
         FlnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCe9VwwZOTD475JMFJqMj2PToU+XiTW4Gj5gENsMWKOuVHB9dhZuxuw5cxznj9RfUez2mbE+DbGPazxCoC@vger.kernel.org
X-Gm-Message-State: AOJu0YwhcuaNwjMvST23da9tfnvqmdljTaDAyZrhucyI2lu1Fi0u1Fe6
	7b+U4GyhbvPRirx2BV01X+JcDFPvGnfE0czl4YlzzaMJiSol0XoXD6K1ug9HL3E=
X-Gm-Gg: ASbGncvUUBdXn7VPI4VV6Zuz2BH8EO5lQun2XhE7cfDSYy1Kg7vWms/I36A59Z344Ky
	lhmodkms8MTmqhlAC2dE1S1ffa0Q+8PCJz9XHpExeWgNYtkLnXoAbS4rTR/EpRi9uevDswWzZRC
	ArjV2X7l7hmFrToSLEbpv1D7i2gZ5UnJl3fXCYlZQQNfPWPTyP08lcQMVBTw/njguO/C1X79HCi
	12eaG+C1cnkknYnyRGF6qm9M3JZRVGUIdC+Swoti06MYDc6jDvhLs1WD1u2R3YL5N6WQgtZ6Rq9
	PuFDJUVY9a1aS+mg46XNgqiE9/i+6RvaTGBZF8Jk4/aPxGW5klxH1z0m
X-Google-Smtp-Source: AGHT+IEbu6lKgiSMu+12rH5y7oPnX/8rXLdh6wzR4AN94QF3xHqW0iTaIhx1St4DIxryEzddVufMHw==
X-Received: by 2002:a17:90b:2f50:b0:2ee:d024:e4fc with SMTP id 98e67ed59e1d1-2f83ac84521mr41724266a91.33.1738637411880;
        Mon, 03 Feb 2025 18:50:11 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bc97d25sm12249635a91.5.2025.02.03.18.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 18:50:11 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tf90q-0000000ELN8-2QqM;
	Tue, 04 Feb 2025 13:50:08 +1100
Date: Tue, 4 Feb 2025 13:50:08 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	anuj20.g@samsung.com, mcgrof@kernel.org, joshi.k@samsung.com,
	axboe@kernel.dk, clm@meta.com, hch@lst.de, willy@infradead.org,
	gost.dev@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <Z6GAYFN3foyBlUxK@dread.disaster.area>
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com>
 <20250129102627.161448-1-kundan.kumar@samsung.com>
 <Z5qw_1BOqiFum5Dn@dread.disaster.area>
 <20250131093209.6luwm4ny5kj34jqc@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131093209.6luwm4ny5kj34jqc@green245>

On Fri, Jan 31, 2025 at 03:02:09PM +0530, Kundan Kumar wrote:
> > IOWs, having too much parallelism in writeback for the underlying
> > storage and/or filesystem can be far more harmful to system
> > performance under load than having too little parallelism to drive
> > the filesystem/hardware to it's maximum performance.
> 
> With increasing speed of devices we would like to improve the performance of
> buffered IO as well. This will help the applications(DB, AI/ML) using buffered
> I/O. If more parallelism is causing side effect, we can reduce it using some
> factor like:
> 1) writeback context per NUMA node.

I doubt that will create enough concurrency for a typical small
server or desktop machine that only has a single NUMA node but has a
couple of fast nvme SSDs in it.

> 2) Fixed number of writeback contexts, say min(10, numcpu).
> 3) NUMCPU/N number of writeback contexts.

These don't take into account the concurrency available from
the underlying filesystem or storage.

That's the point I was making - CPU count has -zero- relationship to
the concurrency the filesystem and/or storage provide the system. It
is fundamentally incorrect to base decisions about IO concurrency on
the number of CPU cores in the system.

Same goes for using NUMA nodes, a fixed minimum, etc.

> 4) Writeback context based on FS geometry like per AG for XFS, as per your
>   suggestion.

Leave the concurrency and queue affinity selection up to the
filesystem.  If they don't specify anything, then we remain with a
single queue and writeback thread.

> > i.e. with enough RAM, this random write workload using buffered IO
> > is pretty much guaranteed to outperform direct IO regardless of the
> > underlying writeback concurrency.
> 
> We tested making sure RAM is available for both buffered and direct IO. On a
> system with 32GB RAM we issued 24GB IO through 24 jobs on a PMEM device.
> 
> fio --directory=/mnt --name=test --bs=4k --iodepth=1024 --rw=randwrite \
> --ioengine=io_uring --time_based=1 -runtime=120 --numjobs=24 --size=1G \
> --direct=1 --eta-interval=1 --eta-newline=1 --group_reporting
> 
> We can see the results which show direct IO exceed buffered IO by big margin.
> 
> BW (MiB/s)         buffered dontcache %improvement  direct  %improvement
> randwrite (bs=4k)    3393    5397	 59.06%	    9315      174.53%

DIO is faster on PMEM because it only copies the data once
(i.e. user to PMEM) whilst buffered IO copies the data twice (user
to page cache to PMEM). The IO has exactly the same CPU overhead
regardless of in-memory page cache aggregation for buffered IO
because IO cpu usage is dominated by the data copy overhead.

Throughput benchmarks on PMEM are -always- CPU and memory bandwidth
bound doing synchronous data copying.  PMEM benchamrks may respond
to CPU count based optimisations, but that should not be taken as
"infrastructure needs to be CPU-count optimised.

This is why it is fundamentally wrong to use PMEM for IO
infrastructure optimisation: the behaviour it displays is completely
different to pretty much all other types of IO device we support.
PMEM is a niche, and it performs very poorly compared to a handful
of NVMe SSDs being driven by the same CPUs...

> > IMO, we need writeback to be optimised for is asynchronous IO
> > dispatch through each filesystems; our writeback IOPS problems in
> > XFS largely stem from the per-IO cpu overhead of block allocation in
> > the filesystems (i.e. delayed allocation).
> 
> This is a good idea, but it means we will not be able to paralellize within
> an AG.

The XFS allocation concurrency model scales out across AGs, not
within AGs. If we need writeback concurrency within an AG (e.g. for
pure overwrite concurrency) then we want async dispatch worker
threads per writeback queue, not multiple writeback queues per
AG....

> I will spend some time to build a POC with per AG writeback context, and
> compare it with per-cpu writeback performance and extent fragmentation. Other
> filesystems using delayed allocation will also need a similar scheme.

The two are not exclusive like you seem to think they are.

If you want to optimise your filesystem geometry for CPU count based
concurrency, then on XFS all you need to do is this:

# mkfs.xfs -d concurrency=nr_cpus /dev/pmem0

mkfs will then create a geometry that has sufficient concurrency for
the number of CPUs in the host system.  Hence we end up with -all-
in-memory and on-disk filesystem structures on that PMEM device
being CPU count optimised, not just writeback.

Writeback is just a small part of a much larger system, and we
already optimise filesystem and IO concurrency via filesystem
geometry.  Writeback needs to work within those same controls we
already provide users with.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

