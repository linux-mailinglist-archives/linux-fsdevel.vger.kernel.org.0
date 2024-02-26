Return-Path: <linux-fsdevel+bounces-12796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF168674B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40FDA1C24D87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E71604CE;
	Mon, 26 Feb 2024 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="CqmnKmCI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ADF604C9
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950172; cv=none; b=DYcEhudkn4GzaECNiDJy5FFUi3kpCvx+2IYRHw+nOrYyXdHCcVEJvw4z+7u7EhDW+Y6o4GMZeq9apvGLNp5n6+XajJzY5SyaqcxYg4im7n9R+lO7hDBLJ1DNbIxIhpy2ebofRBTltFnIdzgACEzEhAnEOL6fXjOb8GE0HNEuNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950172; c=relaxed/simple;
	bh=V1FJz4OKlZW19GmuM1sZ3PQ+NtvxoTBz/H5lbnymIRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfqX3wllRerwfhg89AwnQhPuDGtbeBSrM2pAyKOa9/TirOMtKxJiJ1RCOf0jUG3eXB5YgnKUhIEv9sora+SFAsEKLhTMuFg+GiKCKRoieDTlp40Lz3ldfXOc30WPQy69dwhSFiqCtowGYSu1CNvrDZJfjC2T+detJAEWyYJUzo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=CqmnKmCI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc49afb495so23681385ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 04:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708950170; x=1709554970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UeKmln7ls50YshP4IH8J5sCT9ly5i9tLfWS9qKuD79Q=;
        b=CqmnKmCIjxNsgHOG+Rt0GqZtJ8zLFICZXzr93nOIThp1dGlRmDqvkmynQOU8vjYzic
         u09BV99uR8ofHuh9jqDRSVRpN58owiZPwoiuIsW6DI4LbbzmZKG4Uw1Gii623eq0qV15
         dQ0QcSh4L8HcjlC1+Ob80Ywq0XXMvrSJ1Q/Q5pwqMT2ffMT0WIfhig0eCn/HjrLXEvCs
         8PDHjtistmRFyC9kSsa9Lw75ZH/GdkW5OehlG2SAYGXXp9kyqvx3moRAYU6SbHAV/5pH
         E5QsVcwG35BepwO5WdgfpJPRHKjwPMhk52XhBPPSadOV6TPfliRgXN0qdwZxp4wdJ/9q
         pDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708950170; x=1709554970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeKmln7ls50YshP4IH8J5sCT9ly5i9tLfWS9qKuD79Q=;
        b=j1wRm0shcgD0SYbfIVMWMJ2gv0xCgYwGHfcHhe6pNsliBwUB43jIkkpkNegPYSYqdm
         wzkrESfReYBJJLYMegZJv+qC5cX1Y9GINgdFWBWdgVMK5SkD4gM8lh9uo1xC09C5eLtb
         oaNI8TMnEX3mD44qKgTDorAOEoFDKgeTF/tLSGxJw4NBtwKX3brBOV2GDlMVkMT9/vDN
         if/RkWvoAiEr4vz6gOb4CWChZDN+4l4G6nHtYAgyJ6a6wUu4bXTXag8a5QxVa9+ueavs
         t4AjJOykWWPClRXyP/0fHwYlLXoQLaZ4NArMQvVp0/E6RjUe8FTv+vxYHxRVFwNmFZ0k
         VWQg==
X-Forwarded-Encrypted: i=1; AJvYcCXyHbg8Y1uspAie2gDozruAROJr3ffMMlXffT4azH9SeGv3QvgzWqMzJ69Gntl0I2IEq9EBIRDRhBCu2kqxaxOHG9WDwNk4BSO8M9uXew==
X-Gm-Message-State: AOJu0Yy9KApWaJhgHbuYgkomQd2DF8+SKhg/BEYHyRaXiuUYYdfydNxS
	Zan3aAVpDkVj8Cq5/8OEuJFJNWclQeSlNUFTS8nA2ISb0Tqj3cR3XEsuHjEm0Lw=
X-Google-Smtp-Source: AGHT+IHFhd+cs46iLz3SBHDRw3Wf98YLTh6F6lbcU0dVNPeuKoNVztc/l+iGffTanWCumdTfnXVZkA==
X-Received: by 2002:a17:902:e812:b0:1dc:b261:6eb5 with SMTP id u18-20020a170902e81200b001dcb2616eb5mr234541plg.2.1708950170243;
        Mon, 26 Feb 2024 04:22:50 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id kl8-20020a170903074800b001db86c48221sm3807708plb.22.2024.02.26.04.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:22:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rea0M-00BkQd-39;
	Mon, 26 Feb 2024 23:22:47 +1100
Date: Mon, 26 Feb 2024 23:22:46 +1100
From: Dave Chinner <david@fromorbit.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <ZdyClieRnxeng9Ku@dread.disaster.area>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdkxfspq3urnrM6I@bombadil.infradead.org>

On Fri, Feb 23, 2024 at 03:59:58PM -0800, Luis Chamberlain wrote:
> I recently ran a different type of simple test, focused on sequantial writes
> to fill capacity, with write workload essentially matching your RAM, so
> having parity with your RAM. Technically in the case of max size that I
> tested the writes were just *slightly* over the RAM, that's a minor
> technicality given I did other tests with similar sizes which showed similar
> results... This test should be possible to reproduce then if you have more
> than enough RAM to spare. In this case the system uses 1 TiB RAM, using
> pmem to avoid drive variance / GC / and other drive shenanigans.
> 
> So pmem grub setup:
> 
> memmap=500G!4G memmap=3G!504G
> 
> As noted earlier, surely, DIO / DAX is best for pmem (and I actually get
> a difference between using just DIO and DAX, but that digresses), but
> when one is wishing to test buffered IO on purpose it makes sense to do
> this. Yes, we can test tmpfs too... but I believe that topic will be
> brought up at LSFMM separately.  The delta with DIO and buffered IO on
> XFS is astronomical:
> 
>   ~86 GiB/s on pmem DIO on xfs with 64k block size, 1024 XFS agcount on x86_64
>      Vs
>  ~ 7,000 MiB/s with buffered IO

You're not testing apples to apples.

Buffered writes to the same superblock serialise on IO submission,
not write() calls, so it doesn't matter how much concurrency you
have in write() syscalls. That is, streaming buffered write
throughput is entirely limited by the number of IOs that 
the bdi flusher thread can submit.

For ext4, XFS and btrfs, delayed allocation means that this
writeback thread is also doing extent allocation for all IO, and
hence the single writeback thread for buffered writes is the
performance limiting factor for them.

It doesn't matter how fast you can copy in to the kernel, it can
only drain as fast as it can submit IO. As soon as this writeback
thread is CPU bound, incoming buffered write()s will be throttle
back to the rate at which memory can be cleaned by the writeback
thread.

Direct IO doesn't have this limitation - it's an orange in
comparison because IO is always submitted by the task that does the
write() syscall. Hence it inherently scales out to the limit of the
underlying hardware and it is not limited by the throughput of a
single CPU like page cache writeback is.

If you wonder why people are saying "issue sync_file_range()
periodically" to improved buffered write throughput, it's because it
moves the async writeback submission for that inode out of the
single background writeback thread and into task context where IO
submission can be trivially parallelised. Just like direct IO....

IOWs, the issue you are demonstrating is the inherent limitations in
single threaded write-behind cache flushing, and the solution to
that specific bottleneck is to enable concurrent writeback
submission from the same file and/or superblock via various
available manual mechanisms.

An automatic way of doing this for large streaming writes is switch
from write-behind to near-write-through, such that the majority of
write IO is submitted asynchronously from the write() syscall. Think
of how readahead from read() context pulls in data that is likely to
be needed soon - sequential writes should trigger similar behaviour
where we do async write-behind of the previous write()s in the
context of the current write. Track a sequential write window like
we do readahead, and trigger async writeback for such streaming
writes from the write() context...

That doesn't solve the huge tarball problem where we create millions
of small files in a couple of seconds, then have to wait for
single threaded writeback to drain them to the storage at 50,000
files/s. We can create files and get the data into the cache far
faster and with way more concurrency than the page cache can push
the data back to the storage itself.

IOWs, the problems with page cache write throughput really have
nothing to do with write() scalability, folios or filesystem block
sizes. The fundamental problem is single-threaded writeback IO
submission and that throttling incoming writes to whatever speed
it runs at when CPU bound....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

