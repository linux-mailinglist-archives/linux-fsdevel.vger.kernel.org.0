Return-Path: <linux-fsdevel+bounces-20995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BB48FBFFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 01:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA5F1C20A40
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 23:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAC014EC5D;
	Tue,  4 Jun 2024 23:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="PF5JQpZv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD214E2CB
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 23:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544305; cv=none; b=nNKQ5FiGiLRGJc1BlveK0zC/fLK71Jv1eU02OpwmMwXBRlL+xGGKnG0O5mCj9yxOSfiydMALQ7xJV4OkfV2w8ayHCa3ENg82oYmB9APyHUMkyji5m8CL6tR3H343P+V/lCIw71PNqCBDpmFYhhd7aerImLNp3QPSA/NgNPaPv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544305; c=relaxed/simple;
	bh=ca+wPik1uOiAzqp5kmKAVjchH0HdPECP6GFtThndtPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3xp5LVxNgbAHXzcus0y0Nto+lyjy/dR1xhl49Mmou3oS3x++d+5OP08E09H7Gq4RPeUc60vXZyRj+y/YqtkIXKdQjThaKDogr+SKIg4/5XlDr4MvN98VXlwvz2uTT9wSrRyp7a8IwcCyieK0S7aCqv4k0SMJ9fLqGQoLKYfUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=PF5JQpZv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f6342c5faaso13783135ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 16:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1717544302; x=1718149102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N0aCZBQtCU83mtJ7BQNmsemGUrA8Pwn3mZJbsHt/hUM=;
        b=PF5JQpZvpS1wNAP4XFsEIJFVgRj0QkMBw7fkTmyMt8zebhS9zfqccFFFGR6ZCTE1fp
         KN673JL3b92gDyA7qtxGe2jAPd9dZ4Q5QoRMPiPtOBIspFE5hW4f2aebQpIkjtioSDSA
         RWtn2ObZ7H0pwceKmJM0OA8mYGvncUm3YD9WvBnk7RzRcEIqoZcsZ5HQMNXEE+Q8zrS4
         fMP93R2BUYDZ/+UDoDPArWPiffa/smll1JQiE8jjg30jBY/lnEshsNOK5CITpXXvGY0A
         OI6V570x4QdugSqa3+s7tNR02maHww7TOmD7OCclC5gwk5O9nsSxRwk4DzXfD50v+959
         fMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717544302; x=1718149102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0aCZBQtCU83mtJ7BQNmsemGUrA8Pwn3mZJbsHt/hUM=;
        b=epD7SKcO4pkbo0dNWxQvAILSmCn6LHxSLi+GBGvFtyQ1bTZxc3ssfO/OWHl/pE6CXc
         Yo+7nB11XNXHpKjDsoaXENze7Y7IOohMvlhCTIcWSQ0JS95XrJGIy0NSbKOiUZFv5FYZ
         4f7RKZ2cg1OJkviFnYfwEeW06wsaBopAlZcY/bHdcibAsw/LhfGaetpYvYF9SL1R8jbY
         FlbSQfQXWmw3d6z67TSnQY5OEsjV2ohryXUh1j0uhZA2qA3GEMef7OA00mtp8Xc7Yw9u
         goyOOuhJG87mFMPGAZxySDofneqdRQ1Qy47DjWIcSD+R63VohfklU3RBM2jyglmaT2J+
         o0uw==
X-Forwarded-Encrypted: i=1; AJvYcCVjYUs5NNYU/jdFHnpAAyh2IPPC1NbIjbBRHw1QQmo+wna65TjZ2AVadI+lozXB+fw9PrhJFrIrb/l0R3GOgkN6se53j9Bm0kYoOjgqNg==
X-Gm-Message-State: AOJu0YwomYuQ1RjHbjjEWEvu8qHXynNJlBaY1+4yCG7/PliaymwjB9j3
	BezBN3YFTh/Odlct1mALtDxd2XmJXIsHvQxpAOIAG2wPHy6oUhBn9vHYm/gpGh0=
X-Google-Smtp-Source: AGHT+IEKmRhZJswXWNpPWzjD5VxSqHIUYsSj148xPMfo2/HFBa3XHAJNKZNKM0XpWv5O7SYcklEy5g==
X-Received: by 2002:a17:902:f545:b0:1f6:91a1:88a0 with SMTP id d9443c01a7336-1f6a5a26f3amr12387925ad.35.1717544302135;
        Tue, 04 Jun 2024 16:38:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ddac9sm91405275ad.173.2024.06.04.16.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 16:38:21 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sEdjO-004YyF-0a;
	Wed, 05 Jun 2024 09:38:18 +1000
Date: Wed, 5 Jun 2024 09:38:18 +1000
From: Dave Chinner <david@fromorbit.com>
To: Brian Foster <bfoster@redhat.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org, hch@infradead.org, brauner@kernel.org,
	chandanbabu@kernel.org, jack@suse.cz, willy@infradead.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 1/8] iomap: zeroing needs to be pagecache aware
Message-ID: <Zl+lanp0K1N7yCcG@dread.disaster.area>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-2-yi.zhang@huaweicloud.com>
 <ZlxRz9LPNuoOZOtl@bfoster>
 <cc7e0a68-185f-a3e0-d60a-989b8b014608@huaweicloud.com>
 <Zl3VPA5mVUP4iC3R@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl3VPA5mVUP4iC3R@bfoster>

On Mon, Jun 03, 2024 at 10:37:48AM -0400, Brian Foster wrote:
> On Mon, Jun 03, 2024 at 05:07:02PM +0800, Zhang Yi wrote:
> > On 2024/6/2 19:04, Brian Foster wrote:
> > > On Wed, May 29, 2024 at 05:51:59PM +0800, Zhang Yi wrote:
> > >> From: Dave Chinner <dchinner@redhat.com>
> > >>
> > >> Unwritten extents can have page cache data over the range being
> > >> zeroed so we can't just skip them entirely. Fix this by checking for
> > >> an existing dirty folio over the unwritten range we are zeroing
> > >> and only performing zeroing if the folio is already dirty.
> > >>
> > >> XXX: how do we detect a iomap containing a cow mapping over a hole
> > >> in iomap_zero_iter()? The XFS code implies this case also needs to
> > >> zero the page cache if there is data present, so trigger for page
> > >> cache lookup only in iomap_zero_iter() needs to handle this case as
> > >> well.
> > >>
> > >> Before:
> > >>
> > >> $ time sudo ./pwrite-trunc /mnt/scratch/foo 50000
> > >> path /mnt/scratch/foo, 50000 iters
> > >>
> > >> real    0m14.103s
> > >> user    0m0.015s
> > >> sys     0m0.020s
> > >>
> > >> $ sudo strace -c ./pwrite-trunc /mnt/scratch/foo 50000
> > >> path /mnt/scratch/foo, 50000 iters
> > >> % time     seconds  usecs/call     calls    errors syscall
> > >> ------ ----------- ----------- --------- --------- ----------------
> > >>  85.90    0.847616          16     50000           ftruncate
> > >>  14.01    0.138229           2     50000           pwrite64
> > >> ....
> > >>
> > >> After:
> > >>
> > >> $ time sudo ./pwrite-trunc /mnt/scratch/foo 50000
> > >> path /mnt/scratch/foo, 50000 iters
> > >>
> > >> real    0m0.144s
> > >> user    0m0.021s
> > >> sys     0m0.012s
> > >>
> > >> $ sudo strace -c ./pwrite-trunc /mnt/scratch/foo 50000
> > >> path /mnt/scratch/foo, 50000 iters
> > >> % time     seconds  usecs/call     calls    errors syscall
> > >> ------ ----------- ----------- --------- --------- ----------------
> > >>  53.86    0.505964          10     50000           ftruncate
> > >>  46.12    0.433251           8     50000           pwrite64
> > >> ....
> > >>
> > >> Yup, we get back all the performance.
> > >>
> > >> As for the "mmap write beyond EOF" data exposure aspect
> > >> documented here:
> > >>
> > >> https://lore.kernel.org/linux-xfs/20221104182358.2007475-1-bfoster@redhat.com/
> > >>
> > >> With this command:
> > >>
> > >> $ sudo xfs_io -tfc "falloc 0 1k" -c "pwrite 0 1k" \
> > >>   -c "mmap 0 4k" -c "mwrite 3k 1k" -c "pwrite 32k 4k" \
> > >>   -c fsync -c "pread -v 3k 32" /mnt/scratch/foo
> > >>
> > >> Before:
> > >>
> > >> wrote 1024/1024 bytes at offset 0
> > >> 1 KiB, 1 ops; 0.0000 sec (34.877 MiB/sec and 35714.2857 ops/sec)
> > >> wrote 4096/4096 bytes at offset 32768
> > >> 4 KiB, 1 ops; 0.0000 sec (229.779 MiB/sec and 58823.5294 ops/sec)
> > >> 00000c00:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
> > >> XXXXXXXXXXXXXXXX
> > >> 00000c10:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
> > >> XXXXXXXXXXXXXXXX
> > >> read 32/32 bytes at offset 3072
> > >> 32.000000 bytes, 1 ops; 0.0000 sec (568.182 KiB/sec and 18181.8182
> > >>    ops/sec
> > >>
> > >> After:
> > >>
> > >> wrote 1024/1024 bytes at offset 0
> > >> 1 KiB, 1 ops; 0.0000 sec (40.690 MiB/sec and 41666.6667 ops/sec)
> > >> wrote 4096/4096 bytes at offset 32768
> > >> 4 KiB, 1 ops; 0.0000 sec (150.240 MiB/sec and 38461.5385 ops/sec)
> > >> 00000c00:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >> ................
> > >> 00000c10:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >> ................
> > >> read 32/32 bytes at offset 3072
> > >> 32.000000 bytes, 1 ops; 0.0000 sec (558.036 KiB/sec and 17857.1429
> > >>    ops/sec)
> > >>
> > >> We see that this post-eof unwritten extent dirty page zeroing is
> > >> working correctly.
> > >>
> > > 
> > > I've pointed this out in the past, but IIRC this implementation is racy
> > > vs. reclaim. Specifically, relying on folio lookup after mapping lookup
> > > doesn't take reclaim into account, so if we look up an unwritten mapping
> > > and then a folio flushes and reclaims by the time the scan reaches that
> > > offset, it incorrectly treats that subrange as already zero when it
> > > actually isn't (because the extent is actually stale by that point, but
> > > the stale extent check is skipped).
> > > 
> > 
> > Hello, Brian!
> > 
> > I'm confused, how could that happen? We do stale check under folio lock,
> > if the folio flushed and reclaimed before we get&lock that folio in
> > iomap_zero_iter()->iomap_write_begin(), the ->iomap_valid() would check
> > this stale out and zero again in the next iteration. Am I missing
> > something?
> > 
> 
> Hi Yi,
> 
> Yep, that is my understanding of how the revalidation thing works in
> general as well. The nuance in this particular case is that no folio
> exists at the associated offset. Therefore, the reval is skipped in
> iomap_write_begin(), iomap_zero_iter() skips over the range as well, and
> the operation carries on as normal.
>> 
> Have you tried the test sequence above? I just retried on latest master
> plus this series and it still trips for me. I haven't redone the low
> level analysis, but in general what this is trying to show is something
> like the following...
> 
> Suppose we start with an unwritten block on disk with a dirty folio in
> cache:
> 
> - iomap looks up the extent and finds the unwritten mapping.
> - Reclaim kicks in and writes back the page and removes it from cache.

To be pedantic, reclaim doesn't write folios back - we haven't done
that for the best part of a decade on XFS. We don't even have a
->writepage method for reclaim to write back pages anymore.

Hence writeback has to come from background flusher threads hitting
that specific folio, then IO completion running and converting the
unwritten extent, then reclaim hitting that folio, all while the
zeroing of the current iomap is being walked and zeroed.

That makes it an extremely rare and difficult condition to hit. Yes,
it's possible, but it's also something we can easily detect. So as
long as detection is low cost, the cost of resolution when such a
rare event is detected isn't going to be noticed by anyone.

>   The underlying block is no longer unwritten (current mapping is now
>   stale).
> - iomap_zero_iter() processes the associated offset. iomap_get_folio()
>   clears FGP_CREAT, no folio is found.

Actually, this is really easy to fix - we simply revalidate the
mapping at this point rather than just skipping the folio range. If
the mapping has changed because it's now written, the zeroing code
backs out and gets a new mapping that reflects the changed state of
this range.

However, with the above cost analysis in mind, a lower overhead
common case alternative might be to only revalidate the mapping at
->iomap_end() time. If the mapping has changed while zeroing, we
return -EBUSY/-ESTALE and that triggers the zeroing to restart from
the offset at the beginning of the "stale" iomap.  The runtime cost
is one extra mapping revalidation call per mapping, and the
resolution cost is refetching and zeroing the range of a single
unwritten iomap.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

