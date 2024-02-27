Return-Path: <linux-fsdevel+bounces-13008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFC386A23D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771ED1F22984
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 22:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F94150988;
	Tue, 27 Feb 2024 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2Y9e/9tS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D367145356
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071996; cv=none; b=rlRXUCjXz43go82NafZREOCtn0w1KanzFFYISSLJGTsdSUru47+Z+OVoQJ/l/t4R3nwEKX/fg2uVR6VynUvatXp3tUv8TzHxtRaJZNX3tnrymx512umMq2iusjO8/4mmfzfuHX26Ka7/XlacVVLC0KeGKX8x4vVdqFQmcNuU/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071996; c=relaxed/simple;
	bh=wpo57bVk4mgEQ/DBS09a5ktM9aTbmxBiHuyTU42Kmq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqxySAzOPdBEkJJw6G9dF1HnJaTyt/WcpeZRwYD77tuJjpepw0h2v+gzI6TyImiwOEhi8UEofrx//abdgI3/GaJO7m6fRV4kDYBmy514heqJNZ14+ogXTzTbLnxYt2QsF/QNR7CeiRDMvv4wtnsohQ4fQttcpw7fN5ko43lMSxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2Y9e/9tS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29acdf99d5aso1541066a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 14:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709071994; x=1709676794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L0nNAxmT7SCNE2zM946LYiElXOI86ooFfzrPhMaZ9VA=;
        b=2Y9e/9tSNXpVkIfx7Wm+1VjF2Idaa0nuaojDQour+Oq4Nh2qIHCfIoV4TdIZkDulCD
         CfDULgu7BZOW8FeprtHmvtgurl2KE0wBtf0p25MWAXeAcQ78XJhSTgEO7znXSE42vv1s
         mH2VkKIpGDBnL7Sx77K8pOZhaUKDfLpjngasTkwvXq21V7AMB3C06kQ4wVUtV0C8T8hv
         Gwa/h1JLysBMKGiT4Pf4xzqv3mNaq4naxN6Xpo4o1hDt81OWFdWxHdNX6KvWSXlLaHRG
         3cDQjfC4L9u2d1xr44eIOb7FrEq9GwY2PiBJp/LvyTao9Sh/yYhsvwVQiRM/4jFJnHD3
         ezcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071994; x=1709676794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0nNAxmT7SCNE2zM946LYiElXOI86ooFfzrPhMaZ9VA=;
        b=gR0Ata3gh4waYrpXukJNOZKTnTVrmHZGgnMU9Os0NL54NzEcTx1814h6z+3CPhWTa9
         8YB4T8rYr+o3zBTDK+GQVHUJtRzQlmaT2K4az6jFlexKqRx3O66V3rR6rDHKDpi5dkVn
         0/zo4x0ihZMBDaADdV1spfRjYY/1PD7ybWvm+Nh8rjsQ6e5rBvvQD0EK+hLW3JEYeWWX
         P2DMlvbBrd3IzIMOL/VyZUC27canyXnp9o5sbADU9kSxQs3vfNnQjAKbgaZHPlPy1UcR
         P23kQH0RKZ29eN8OQQkmEUHeLJ1+tePKaEAzSMxCUpnQY0lrsyLM3/IbiA69ZCVklxNB
         eYIw==
X-Forwarded-Encrypted: i=1; AJvYcCVTLqtTmx/Z4NEsKZOTigekiBczA67tylpcdG9uq4LwDRQo3v2u5Fd0P6NYXEDdI4ImV4FQHJKeK4WibDpmYgBMvyIk3vBYi8TnJW8Mwg==
X-Gm-Message-State: AOJu0YweVSsdKWqxQ8Dfqdu5xkjgfCT68lVtSXS9bPy0aJJcJDn5NRHS
	zI9nv+pywKn4lFUQFrVKaLwwTIatEMwEFqMkkzY683Mpd2bOGrQtRnyf39FeOmE=
X-Google-Smtp-Source: AGHT+IFEh8sFyjriVTBKiYgObPdXhLz0H2pYZasDxufUrdsPvoedI+GdQpptlkXlQRKWb+e1FUvYoA==
X-Received: by 2002:a17:90a:420b:b0:29a:4239:6893 with SMTP id o11-20020a17090a420b00b0029a42396893mr9212780pjg.6.1709071993640;
        Tue, 27 Feb 2024 14:13:13 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id gd23-20020a17090b0fd700b0029ab17eaa40sm36934pjb.3.2024.02.27.14.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:13:13 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rf5hB-00COAO-2A;
	Wed, 28 Feb 2024 09:13:05 +1100
Date: Wed, 28 Feb 2024 09:13:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <Zd5ecZbF5NACZpGs@dread.disaster.area>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>

On Tue, Feb 27, 2024 at 05:07:30AM -0500, Kent Overstreet wrote:
> On Fri, Feb 23, 2024 at 03:59:58PM -0800, Luis Chamberlain wrote:
> > Part of the testing we have done with LBS was to do some performance
> > tests on XFS to ensure things are not regressing. Building linux is a
> > fine decent test and we did some random cloud instance tests on that and
> > presented that at Plumbers, but it doesn't really cut it if we want to
> > push things to the limit though. What are the limits to buffered IO
> > and how do we test that? Who keeps track of it?
> > 
> > The obvious recurring tension is that for really high performance folks
> > just recommend to use birect IO. But if you are stress testing changes
> > to a filesystem and want to push buffered IO to its limits it makes
> > sense to stick to buffered IO, otherwise how else do we test it?
> > 
> > It is good to know limits to buffered IO too because some workloads
> > cannot use direct IO.  For instance PostgreSQL doesn't have direct IO
> > support and even as late as the end of last year we learned that adding
> > direct IO to PostgreSQL would be difficult.  Chris Mason has noted also
> > that direct IO can also force writes during reads (?)... Anyway, testing
> > the limits of buffered IO limits to ensure you are not creating
> > regressions when doing some page cache surgery seems like it might be
> > useful and a sensible thing to do .... The good news is we have not found
> > regressions with LBS but all the testing seems to beg the question, of what
> > are the limits of buffered IO anyway, and how does it scale? Do we know, do
> > we care? Do we keep track of it? How does it compare to direct IO for some
> > workloads? How big is the delta? How do we best test that? How do we
> > automate all that? Do we want to automatically test this to avoid regressions?
> > 
> > The obvious issues with some workloads for buffered IO is having a
> > possible penality if you are not really re-using folios added to the
> > page cache. Jens Axboe reported a while ago issues with workloads with
> > random reads over a data set 10x the size of RAM and also proposed
> > RWF_UNCACHED as a way to help [0]. As Chinner put it, this seemed more
> > like direct IO with kernel pages and a memcpy(), and it requires
> > further serialization to be implemented that we already do for
> > direct IO for writes. There at least seems to be agreement that if we're
> > going to provide an enhancement or alternative that we should strive to not
> > make the same mistakes we've done with direct IO. The rationale for some
> > workloads to use buffered IO is it helps reduce some tail latencies, so
> > that's something to live up to.
> > 
> > On that same thread Christoph also mentioned the possibility of a direct
> > IO variant which can leverage the cache. Is that something we want to
> > move forward with?
> > 
> > Chris Mason also listed a few other desirables if we do:
> > 
> > - Allowing concurrent writes (xfs DIO does this now)
> 
> AFAIK every filesystem allows concurrent direct writes, not just xfs,
> it's _buffered_ writes that we care about here.

We could do concurrent buffered writes in XFS - we would just use
the same locking strategy as direct IO and fall back on folio locks
for copy-in exclusion like ext4 does.

The real question is how much of userspace will that break, because
of implicit assumptions that the kernel has always serialised
buffered writes?

> I just pushed a patch to my CI for buffered writes without taking the
> inode lock - for bcachefs. It'll be straightforward, but a decent amount
> of work, to lift this to the VFS, if people are interested in
> collaborating.

Yeah, XFS would just revert to shared inode locking - we still need
the inode lock for things like truncate/fallocate exlusion.

> https://evilpiepirate.org/git/bcachefs.git/log/?h=bcachefs-buffered-write-locking
> 
> The approach is: for non extending, non appending writes, see if we can
> pin the entire range of the pagecache we're writing to; fall back to
> taking the inode lock if we can't.

XFS just falls back to exclusive locking if the file needs
extending.

> If we do a short write because of a page fault (despite previously
> faulting in the userspace buffer), there is no way to completely prevent
> torn writes an atomicity breakage; we could at least try a trylock on
> the inode lock, I didn't do that here.

As soon as we go for concurrent writes, we give up on any concept of
atomicity of buffered writes (esp. w.r.t reads), so this really
doesn't matter at all.

> For lifting this to the VFS, this needs
>  - My darray code, which I'll be moving to include/linux/ in the 6.9
>    merge window
>  - My pagecache add lock - we need this for sychronization with hole
>    punching and truncate when we don't have the inode lock.
>  - My vectorized buffered write path lifted to filemap.c, which means we
>    need some sort of vectorized replacement for .write_begin and
>    .write_end

I don't think we need any of that - I think you're over complicating
it. As long as the filesystems has a mechanism that works for
concurrent DIO writes, they can just reuse that for concurrent
buffered writes....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

