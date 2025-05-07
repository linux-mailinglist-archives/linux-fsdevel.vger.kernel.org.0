Return-Path: <linux-fsdevel+bounces-48314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B591AAD399
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 04:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BF11B68058
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 02:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B164A19DF6A;
	Wed,  7 May 2025 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="19R+PBnz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C82C156C40
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746586227; cv=none; b=bUnQjlF8ILLswaDMI+YhWHb/nLhxo3MfI0JDBxf8UnaGxODUbcE5rVl5TU9Pu0CSB8GUNZKDToA9MJaPN9GBxbSI0ANQB+WBstCu9Hx0THU8B43OtMr506ecoR87hAqRWx6sOPk2hRXxD3vtlM45plFwjiSZYm3u9mlUpPgTGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746586227; c=relaxed/simple;
	bh=BeWV/oNiOE8sxj4Gqj7VlY26VRDoYmy5uy8yx8heWmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q59OrtmnWMGQ4qkzLnFUJOlQWEBLfOCf4DPmQQLED2JeGytjd0qYG2uBqGHKRxKX2pCgbV+0O4BCuq6VFdsZXB8WZZg6QTgz2H5F93k7vuALx7gCeD4YT7xan4SoaIYGTLcmAlbBLpSv9A69gIQ7QGz318Mk706ObXRKR3y6O0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=19R+PBnz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736aaeed234so5611576b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 May 2025 19:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1746586224; x=1747191024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDNKJ2rzkyvWW3IORE/LMhU0gk9KkMrqoB+Cecr6OSE=;
        b=19R+PBnz46ybrH1I8kAKXIl6q1/XLc+JP2nKZ1JCt60SFyMhRAK7Wu4yNYSYipquMd
         hj3wkbNEtpu1Ww8Lq7K852Js2tZrPpgaD4pVSklfX+xu4F42U1JIRJZudDjnKT7gh3IH
         S7525Vn0aDByny+CHIHdSZONNK5MDznOOj84Koj6eMWtjBVb/tHSNRiPrxBZ4YOtDOa/
         u9TL33+Sjpw6f+cMghUZFvV+yK11jQCyUlJH6WZHe1A+IoF502Yr2fD2WbI2PWDBJ7wZ
         sjifNIzpN10+AmH/GqSODbjDDBjZZxxW48MaX3I0jh6F/XoIGkpbOJTryahJkJCJMpzS
         mqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746586224; x=1747191024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDNKJ2rzkyvWW3IORE/LMhU0gk9KkMrqoB+Cecr6OSE=;
        b=dVbNiFStls3NsdUWUoKnkmA+bzkxiTgRlCwKgvqUl1aAXMxRXBk+BurG/pwT0fh4K3
         rXgycniGcoDIvo89RglI37NqKAJimhVhguC9CUITHsfApsWhhwg9hLO84Pgtoozm39Z9
         vp2fF1pydqwTsyfdue0eYW0bNrqkk+XLpDmOdBoMrrL3OQEqLsT3fWeaV5dy15HKJPpw
         V02daOs62Vnjp5kewfiLbcL5GVVOz5Aw6xvYh3+nkQQrNRIsJy1QKrmPMEr35/pF6BBI
         wuTkgGmOZWLKkcSMTFY9d7ueDMXDlGNFEEnGmy7WbQVuy2Xj002QeD5FZNknc1R/uV/e
         JFpQ==
X-Gm-Message-State: AOJu0Yxtc4sk7e3ygJiA+yioDR5snIffWEIPyrjnptiVBPIID1Bacv9e
	0XnBmVAMMKHGrLFSDovGVNBv5pZJSgTs6zkpOUSlvqkg3ID0Tw27Bvbx++DlETQ653RAPTY9OGA
	B
X-Gm-Gg: ASbGnctiA4HsxjjVuoZBvJsypF5Pnjrv9Ra/Vbp0096DR+H9g8x9DMbY2ojmoxTJga6
	9GINvVbaFJPeCTbcAD+wOC6GCI8GiygJWLfXw4tn1x5X4KkQSbPuCEp2sZalGPgp8XhoIh46nhA
	PEEKT6tRiOGX0aHc2s0qJGL3XP9rh2Rl9OAI0LVuo/ctCy7e4hZJr1rASvggVJAsvFbNs5+FaCQ
	KNbHCoS1OZ8AXURphZE3596JVsk1VhdtZLSstp0hql1xFQiPO+kU4TM4QchSjS+sGBWA4fge53L
	Z0qj03KiwOYghg9Qpc95bKmhH26Zy8WKIth28oaPtABcMPNcEYUkHNF9r/M1g9QJLeTwStt85HZ
	KyCHzBHHCfi6kQA==
X-Google-Smtp-Source: AGHT+IFAM800oZs0C/eJ1P3cMlWok7tZILFqoggT8WBvqwPZpgKR5NcQf22rSGrrOVlF/RjmmtswVA==
X-Received: by 2002:a05:6a00:8c02:b0:732:5164:3cc with SMTP id d2e1a72fcca58-7409cfb0befmr2040456b3a.19.1746586224548;
        Tue, 06 May 2025 19:50:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059020fe7sm10166976b3a.102.2025.05.06.19.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 19:50:23 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uCUrU-00000000Lod-1GA9;
	Wed, 07 May 2025 12:50:20 +1000
Date: Wed, 7 May 2025 12:50:20 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@meta.com>,
	Anna Schumaker <anna@kernel.org>
Subject: Re: performance r nfsd with RWF_DONTCACHE and larger wsizes
Message-ID: <aBrKbOoj4dgUvz8f@dread.disaster.area>
References: <370dd4ae06d44f852342b7ee2b969fc544bd1213.camel@kernel.org>
 <aBqNtfPwFBvQCgeT@dread.disaster.area>
 <8039661b7a4c4f10452180372bd985c0440f1e1d.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8039661b7a4c4f10452180372bd985c0440f1e1d.camel@kernel.org>

On Tue, May 06, 2025 at 08:06:51PM -0400, Jeff Layton wrote:
> On Wed, 2025-05-07 at 08:31 +1000, Dave Chinner wrote:
> > On Tue, May 06, 2025 at 01:40:35PM -0400, Jeff Layton wrote:
> > > FYI I decided to try and get some numbers with Mike's RWF_DONTCACHE
> > > patches for nfsd [1]. Those add a module param that make all reads and
> > > writes use RWF_DONTCACHE.
> > > 
> > > I had one host that was running knfsd with an XFS export, and a second
> > > that was acting as NFS client. Both machines have tons of memory, so
> > > pagecache utilization is irrelevant for this test.
> > 
> > Does RWF_DONTCACHE result in server side STABLE write requests from
> > the NFS client, or are they still unstable and require a post-write
> > completion COMMIT operation from the client to trigger server side
> > writeback before the client can discard the page cache?
> > 
> 
> The latter. I didn't change the client at all here (other than to allow
> it to do bigger writes on the wire). It's just doing bog-standard
> buffered I/O. nfsd is adding RWF_DONTCACHE to every write via Mike's
> patch.

Ok, that wasn't clear that it was only server side RWF_DONTCACHE.

I have some more context from a different (internal) discussion
thread about how poorly the NFSD read side performs with
RWF_DONTCACHE compared to O_DIRECT. This is because there is massive
page allocator spin lock contention due to all the concurrent reads
being serviced.

The buffered write path locking is different, but I suspect
something similar is occurring and I'm going to ask you to confirm
it...

> > > I tested sequential writes using the fio-seq_write.fio test, both with
> > > and without the module param enabled.
> > > 
> > > These numbers are from one run each, but they were pretty stable over
> > > several runs:
> > > 
> > > # fio /usr/share/doc/fio/examples/fio-seq-write.fio
> > 
> > $ cat /usr/share/doc/fio/examples/fio-seq-write.fio
> > cat: /usr/share/doc/fio/examples/fio-seq-write.fio: No such file or directory
> > $
> > 
> > What are the fio control parameters of the IO you are doing? (e.g.
> > is this single threaded IO, does it use the psync, libaio or iouring
> > engine, etc)
> > 
> 
> 
> ; fio-seq-write.job for fiotest
> 
> [global]
> name=fio-seq-write
> filename=fio-seq-write
> rw=write
> bs=256K
> direct=0
> numjobs=1
> time_based
> runtime=900
> 
> [file1]
> size=10G
> ioengine=libaio
> iodepth=16

Ok, so we are doing AIO writes on the client side, so we have ~16
writes on the wire from the client at any given time.

This also means they are likely not being received by the NFS server
in sequential order, and the NFS server is going to be processing
roughly 16 write RPCs to the same file concurrently using
RWF_DONTCACHE IO.

These are not going to be exactly sequential - the server side IO
pattern to the filesystem is quasi-sequential, with random IOs being
out of order and leaving temporary holes in the file until the OO
write is processed.

XFS should handle this fine via the speculative preallocation beyond
EOF that is triggered by extending writes (it was designed to
mitigate the fragmentation this NFS behaviour causes). However, we
should always keep in mind that while client side IO is sequential,
what the server is doing to the underlying filesystem needs to be
treated as "concurrent IO to a single file" rather than "sequential
IO".

> > > wsize=1M:
> > > 
> > > Normal:      WRITE: bw=1034MiB/s (1084MB/s), 1034MiB/s-1034MiB/s (1084MB/s-1084MB/s), io=910GiB (977GB), run=901326-901326msec
> > > DONTCACHE:   WRITE: bw=649MiB/s (681MB/s), 649MiB/s-649MiB/s (681MB/s-681MB/s), io=571GiB (613GB), run=900001-900001msec
> > > 
> > > DONTCACHE with a 1M wsize vs. recent (v6.14-ish) knfsd was about 30%
> > > slower. Memory consumption was down, but these boxes have oodles of
> > > memory, so I didn't notice much change there.
> > 
> > So what is the IO pattern that the NFSD is sending to the underlying
> > XFS filesystem?
> > 
> > Is it sending 1M RWF_DONTCACHE buffered IOs to XFS as well (i.e. one
> > buffered write IO per NFS client write request), or is DONTCACHE
> > only being used on the NFS client side?
> > 
> 
> It's should be sequential I/O, though the writes would be coming in
> from different nfsd threads. nfsd just does standard buffered I/O. The
> WRITE handler calls nfsd_vfs_write(), which calls vfs_write_iter().
> With the module parameter enabled, it also adds RWF_DONTCACHE.

Ok, so buffered writes (even with RWF_DONTCACHE) are not processed
concurrently by XFS - there's an exclusive lock on the inode that
will be serialising all the buffered write IO.

Given that most of the work that XFS will be doing during the write
will not require releasing the CPU, there is a good chance that
there is spin contention on the i_rwsem from the 15 other write
waiters.

That may be a contributing factor to poor performance, so kernel
profiles from the NFS server for both the normal buffered write path
as well as the RWF_DONTCACHE buffered write path. Having some idea
of the total CPU usage of the nfsds during the workload would also
be useful.

> DONTCACHE is only being used on the server side. To be clear, the
> protocol doesn't support that flag (yet), so we have no way to project
> DONTCACHE from the client to the server (yet). This is just early
> exploration to see whether DONTCACHE offers any benefit to this
> workload.

The nfs client largely aligns all of the page caceh based IO, so I'd
think that O_DIRECT on the server side would be much more performant
than RWF_DONTCACHE. Especially as XFS will do concurrent O_DIRECT
writes all the way down to the storage.....

> > > I wonder if we need some heuristic that makes generic_write_sync() only
> > > kick off writeback immediately if the whole folio is dirty so we have
> > > more time to gather writes before kicking off writeback?
> > 
> > You're doing aligned 1MB IOs - there should be no partially dirty
> > large folios in either the client or the server page caches.
> 
> Interesting. I wonder what accounts for the slowdown with 1M writes? It
> seems likely to be related to the more aggressive writeback with
> DONTCACHE enabled, but it'd be good to understand this.

What I suspect is that block layer IO submission latency has
increased significantly  with RWF_DONTCACHE and that is slowing down
the rate at which it can service buffered writes to a single file.

The difference between normal buffered writes and RWF_DONTCACHE is
that the write() context will marshall the dirty folios into bios
and submit them to the block layer (via generic_write_sync()). If
the underlying device queues are full, then the bio submission will
be throttled to wait for IO completion.

At this point, all NFSD write processing to that file stalls. All
the other nfsds are blocked on the i_rwsem, and that can't be
released until the holder is released by the block layer throttling.
Hence any time the underlying device queue fills, nfsd processing of
incoming writes stalls completely.

When doing normal buffered writes, this IO submission stalling does
not occur because there is no direct writeback occurring in the
write() path.

Remember the bad old days of balance_dirty_pages() doing dirty
throttling by submitting dirty pages for IO directly in the write()
context? And how much better buffered write performance and write()
submission latency became when we started deferring that IO to the
writeback threads and waiting on completions?

We're essentially going back to the bad old days with buffered
RWF_DONTCACHE writes. Instead of one nicely formed background
writeback stream that can be throttled at the block layer without
adversely affecting incoming write throughput, we end up with every
write() context submitting IO synchronously and being randomly
throttled by the block layer throttle....

There are a lot of reasons the current RWF_DONTCACHE implementation
is sub-optimal for common workloads. This IO spraying and submission
side throttling problem
is one of the reasons why I suggested very early on that an async
write-behind window (similar in concept to async readahead winodws)
would likely be a much better generic solution for RWF_DONTCACHE
writes. This would retain the "one nicely formed background
writeback stream" behaviour that is desirable for buffered writes,
but still allow in rapid reclaim of DONTCACHE folios as IO cleans
them...

> > That said, this is part of the reason I asked about both whether the
> > client side write is STABLE and  whether RWF_DONTCACHE on
> > the server side. i.e. using either of those will trigger writeback
> > on the serer side immediately; in the case of the former it will
> > also complete before returning to the client and not require a
> > subsequent COMMIT RPC to wait for server side IO completion...
> > 
> 
> I need to go back and sniff traffic to be sure, but I'm fairly certain
> the client is issuing regular UNSTABLE writes and following up with a
> later COMMIT, at least for most of them. The occasional STABLE write
> might end up getting through, but that should be fairly rare.

Yeah, I don't think that's an issue given that only the server side
is using RWF_DONTCACHE. The COMMIT will effectively just be a
journal and/or device cache flush as all the dirty data has already
been written back to storage....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

