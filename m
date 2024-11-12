Return-Path: <linux-fsdevel+bounces-34397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981D69C503E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 123DBB26A94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 08:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0352720ADDE;
	Tue, 12 Nov 2024 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="wvuzIg+l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B612D1ABEB0
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398559; cv=none; b=B8X59UFW1pkVqsDkFYnq8VYHWir7XuvWHnU/u2MFMqNCovGeksXiv9A3XAtEDcCAj4R3dveObd3aAdPpaDHT9bZuYFWrHForra6Yl7+3+HVGg8IUzT8BW0d6OwBfgILRymY2SgcJMDaSFECGcjrBi3XXoPSuGUwMl7NVbbZu+Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398559; c=relaxed/simple;
	bh=zTQs4iNYqrYTQArW/fssiFnJaC4arl24n5g3YvT3h9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fifrKggJ7gYUxhhMgI3wmGHtv+8eBa41KDUFEh8+Bfa+BLg3Czlyy/0kd+jWABhTJPVtnPfdGApPUOyPe1/1xzLBfg+1bYbD1qSmAX4i9TJ7TTzXsLoD38CA1vVX82ZbbvXJ5xOiXliVLHRhKVNaSSnpljR9OgXNJdnhKgtQBJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=wvuzIg+l; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e30fb8cb07so4137406a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 00:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1731398557; x=1732003357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uS5sz2JrbxVWrFAMlEwTsUEhH2M/8tFpm8+HfNM8G+A=;
        b=wvuzIg+lBY0vBcqKLe27w48ucELFJU5/acrz4KJTIvx+CnVg0qNXvWY4luHK2JEOiZ
         kJmFIXqaTiKGkuGYVbCXhEvtyyLQ/IlqwJXC7DEZJCEYrv9FXVoHaAeePfLtNRdQkMBS
         NpWGElPGLUwg6SYd3fGY1K0JKqlpfBQ7/zF6VZwD5ggPRQM79rU5vcsUsVv/KdzVTWTf
         aLFGvswi3l9d60bMeMukzA5xiNobiKvFY51vMkEc3yH8CFUM3GkS3L5RXrcUDyvT4lmw
         d3YD0P4OS8UL/ljgRjsvHEnCvFu4KFj60SPeIkceKTlVDRALN/fjIfTOGaY5mdt/9sRd
         sBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731398557; x=1732003357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uS5sz2JrbxVWrFAMlEwTsUEhH2M/8tFpm8+HfNM8G+A=;
        b=F2IbUcBDU2uHzuBaDCoBs27nrGuIV240Lnd03884YjMHn8Sz/LxHYQKIhfetzSUwJ/
         9qJeo9oKQVEbiLnfs5umleGdKBA5jCSBBUhLrV4eBWXaFShfyp8r/B+XL5F44uRbkXn9
         UpE4IMyTajU8iM8bO2X+hwPjtlujP/LKzV4xNHeG2I0w1oV5z+WTnCVkPu0aux7o2/uV
         VIWnxHNf4iMCgatJBFYJ70zh5fqJ+BzQK9Kbb7jPGr36SXXJsBO0jRI2FDhCbBE7/cVf
         VJJW5aobGVj5XpcAHp45oH4m+lc8U5WR2KTvYcrHF2tfHlJb/ZqC1wv90ng2HVfWycyh
         tk0g==
X-Forwarded-Encrypted: i=1; AJvYcCUXDR+zGCVaVm+GprnGCk/uJz05KMy985HjJrEwjOrlkvvUS2r99aOlnPnIIoD49g4ylfZzlf6cH8+fNLB2@vger.kernel.org
X-Gm-Message-State: AOJu0YzBufwtxaHE0I3oaIUj0BqUYnDvhysZ3r+FFRD519RqdIxxoLGt
	SVKA1luhfMm/Td2f6XVT7dc90r8FuIqr4U6J5uyF+3UbK9+D8rojJDuHJd4VRh1Zqd2lAApQtzK
	G
X-Google-Smtp-Source: AGHT+IFdASJjKkBSve/9sR6y2nL3MjtIZ6Y0Rsyru0XowgMfxn2lqyfKHrnIxIhR4ebg9IkWdeg66w==
X-Received: by 2002:a17:90a:ec86:b0:2e1:d5c9:1bc4 with SMTP id 98e67ed59e1d1-2e9e4aa8a19mr2404697a91.7.1731398557043;
        Tue, 12 Nov 2024 00:02:37 -0800 (PST)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a4f97b2sm12006946a91.8.2024.11.12.00.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 00:02:36 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1tAlr7-00DYAE-1V;
	Tue, 12 Nov 2024 19:02:33 +1100
Date: Tue, 12 Nov 2024 19:02:33 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 10/16] mm/filemap: make buffered writes work with
 RWF_UNCACHED
Message-ID: <ZzMLmYNQFzw9Xywv@dread.disaster.area>
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-11-axboe@kernel.dk>
 <ZzKn4OyHXq5r6eiI@dread.disaster.area>
 <0487b852-6e2b-4879-adf1-88ba75bdecc0@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0487b852-6e2b-4879-adf1-88ba75bdecc0@kernel.dk>

On Mon, Nov 11, 2024 at 06:27:46PM -0700, Jens Axboe wrote:
> On 11/11/24 5:57 PM, Dave Chinner wrote:
> > On Mon, Nov 11, 2024 at 04:37:37PM -0700, Jens Axboe wrote:
> >> If RWF_UNCACHED is set for a write, mark new folios being written with
> >> uncached. This is done by passing in the fact that it's an uncached write
> >> through the folio pointer. We can only get there when IOCB_UNCACHED was
> >> allowed, which can only happen if the file system opts in. Opting in means
> >> they need to check for the LSB in the folio pointer to know if it's an
> >> uncached write or not. If it is, then FGP_UNCACHED should be used if
> >> creating new folios is necessary.
> >>
> >> Uncached writes will drop any folios they create upon writeback
> >> completion, but leave folios that may exist in that range alone. Since
> >> ->write_begin() doesn't currently take any flags, and to avoid needing
> >> to change the callback kernel wide, use the foliop being passed in to
> >> ->write_begin() to signal if this is an uncached write or not. File
> >> systems can then use that to mark newly created folios as uncached.
> >>
> >> Add a helper, generic_uncached_write(), that generic_file_write_iter()
> >> calls upon successful completion of an uncached write.
> > 
> > This doesn't implement an "uncached" write operation. This
> > implements a cache write-through operation.
> 
> It's uncached in the sense that the range gets pruned on writeback
> completion.

That's not the definition of "uncached". Direct IO is, by
definition, "uncached" because it bypasses the cache and is not
coherent with the contents of the cache.

This IO, however, is moving the data coherently through the cache
(both on read and write).  The cached folios are transient - i.e.
-temporarily resident- in the cache whilst the IO is in progress -
but this behaviour does not make it "uncached IO".

Calling it "uncached IO " is simply wrong from any direction I look
at it....

> For write-through, I'd consider that just the fact that it
> gets kicked off once dirtied rather than wait for writeback to get
> kicked at some point.
> 
> So I'd say write-through is a subset of that.

I think the post-IO invalidation that these IOs do is largely
irrelevant to how the page cache processes the write. Indeed,
from userspace, the functionality in this patchset would be
implemented like this:

oneshot_data_write(fd, buf, len, off)
{
	/* write into page cache */
	pwrite(fd, buf, len, off);

	/* force the write through the page cache */
	sync_file_range(fd, off, len, SYNC_FILE_RANGE_WRITE | SYNC_FILE_RANGE_WAIT_AFTER);

	/* Invalidate the single use data in the cache now it is on disk */
	posix_fadvise(fd, off, len, POSIX_FADV_DONTNEED);
}

Allowing the application to control writeback and invalidation
granularity is a much more flexible solution to the problem here;
when IO is sequential, delayed allocation will be allowed to ensure
large contiguous extents are created and that will greatly reduce
file fragmentation on XFS, btrfs, bcachefs and ext4. For random
writes, it'll submit async IOs in batches...

Given that io_uring already supports sync_file_range() and
posix_fadvise(), I'm wondering why we need an new IO API to perform
this specific write-through behaviour in a way that is less flexible
than what applications can already implement through existing
APIs....

> > the same problems you are trying to work around in this series
> > with "uncached" writes.
> > 
> > IOWS, what we really want is page cache write-through as an
> > automatic feature for buffered writes.
> 
> I don't know who "we" is here - what I really want is for the write to
> get kicked off, but also reclaimed as part of completion. I don't want
> kswapd to do that, as it's inefficient.

"we" as in the general cohort of filesystem and mm
developers who interact closely with the page cache all the time.
There was a fair bit of talk about writethrough and other
transparent page cache IO path improvements at LSFMM this year.

> > That also gives us a common place for adding cache write-through
> > trigger logic (think writebehind trigger logic similar to readahead)
> > and this is also a place where we could automatically tag mapping
> > ranges for reclaim on writeback completion....
> 
> I appreciate that you seemingly like the concept, but not that you are
> also seemingly trying to commandeer this to be something else. Unless
> you like the automatic reclaiming as well, it's not clear to me.

I'm not trying to commandeer anything.

Having thought about it more, I think this new API is unneccesary
for custom written applications to perform fine grained control of
page cache residency of one-shot data. We already have APIs that
allow applications to do exactly what this patchset is doing. rather
than choosing to modify whatever benchmark being used to use
existing APIs, a choice was made to modify both the applicaiton and
the kernel to implement a whole new API....

I think that was the -wrong choice-.

I think this partially because the kernel modifications are don't
really help further us towards the goal of transparent mode
switching in the page cache.

Read-through should be a mode that the readahead control activates,
not be something triggered by a special read() syscall flag. We
already have access patterns and fadvise modes guiding this.
Write-through should be controlled in a similar way.

And making the data being read and written behave as transient page
caceh objects should be done via an existing fadvise mode, too,
because the model you have implemented here exactly matches the 
definition of FADV_NOREUSE:

	POSIX_FADV_NOREUSE
              The specified data will be accessed only once.

Having a new per-IO flag that effectively collides existing
control functionality into a single inflexible API bit doesn't
really make a whole lot of sense to me.

IOWs, I'm not questioning whether we need rw-through modes and/or
IO-transient residency for page cache based IO - it's been on our
radar for a while. I'm more concerned that the chosen API in this
patchset is a poor one as it cannot replace any of the existing
controls we already have for these sorts of application directed
page cache manipulations...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

