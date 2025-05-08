Return-Path: <linux-fsdevel+bounces-48435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F238CAAF0C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 03:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68043B9F45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 01:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CDF1B4F0A;
	Thu,  8 May 2025 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="MRQ1IyOp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC66F4E2
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 01:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746669055; cv=none; b=O+wWeiKWRSY6EX6WhG2b8L941W8SQ02dU2D2A+H2RnNSb0uebDjv6PieSmm2VdyArI+3g9i0SKlBwqxTh3OJFHYxLYxitAK6n6mFbLV/yAg1TMIbPsbuCBOwuQTMbqAYtIrA7mO8isHnbfx1W5f+7EBVN8ETwVIVAC0ypiixbDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746669055; c=relaxed/simple;
	bh=GAr+xAjVqMCTT3nP6Y6WGlb8Kargwr6G2YhC7E1fv5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOlRGZz/eJZCM3RKOckdXwxRO878rbWfNSD+IeDaj1K3qqYBE5kazt+9BzM7km1QFflnk12F0GOEeOq+2Fu65mdG0sSr4UYBzVHnEqUtAx4QyjWQegOrVVywMbqBpAF4L3PNGn23nbCTbiC+7ZqeZvt4YRIq7mWt1ZSPPeHGJjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=MRQ1IyOp; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af51596da56so320006a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 18:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1746669051; x=1747273851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfpAEmYfYIc7AtnRvwJbXO85quh0S5H3KLAKIFlkzjs=;
        b=MRQ1IyOpbMqzcPFwHTdse93CFdhx7V3dlrkDQrPwYkUzwQs300Hum7lKdLii7PO/K7
         yzEeNIw1ogKnnP3ery0e1tamm/fcLMRZLlwAGNEsgA5IEoYI4li3zpbvDi/GBB50IohW
         5Sxc3soONErytW4IPJTGa1Whk9neVG5oJmENou/2y0m9OW3OLJel4vnFiPINx1BFOnPf
         nYVC2gLgDSP9G47BMUA4jDGXSLyhcipkOLcr+gkOEal5OkxfR4J2YuhTrEhZ23wJMlwG
         z4HAHa5daWnrVXEe3z7UiPj8y+twQo2e/195tF801QfqPyMnivxmNAqfEYWnlLHnGLsx
         AapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746669051; x=1747273851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfpAEmYfYIc7AtnRvwJbXO85quh0S5H3KLAKIFlkzjs=;
        b=ZDe3QwWtDnj4+6ESvu3mlIpwd1VAqiH98irUjBlmUxptQQ6ba38WVk+vrGqFWvtul+
         D9rdPf6lsPENLd+AZ+pF55s8CZt1OCp/U/RC93g3YPi3ypJHidBVKhX7rMxjpaoTq5LG
         Nn1KKNeL0GAzz4EWcTjmGuTYu85PwWkd3bUz/ndtAuojzoAIV1Mr3fAJlyIBwC2ylUH9
         1W76IeFSitAuSZwNIhPA+I4XWVhn+tLtofCgnFMH2T4jQfDdD0psMY4W/PVI3lyM0j+t
         EvUcoF/bpvcmCINDXhCAaue9axLe10YjZd0Sq2N3Z+YrtIEKTVhjWy9Bbz7+BQTNvOYb
         IjDw==
X-Forwarded-Encrypted: i=1; AJvYcCX1iIU2NUlv8mvYdArtHvnVeLxc/KZW7UpuGItxvZimrmkPGPpEjGQK/f+ID5xdk9Iqf3V9GImj25g7dWlr@vger.kernel.org
X-Gm-Message-State: AOJu0YxWkiUd9djo36RKu5fzsbNF2tKZZt3PBLw9y6UkvlX9diqOWZIV
	MFgjCnKVGqUQbO0vLuLrdJ8HoHqtjNwETBXw6EMjTHz33rUmqZbs+ws6cfly1VLwkNxMcAdoxq1
	/
X-Gm-Gg: ASbGncuXuW5B5dOhn40yY9YCLmv0YzP5pKTQON+l+m9yiq0FSEepI7RXoN4y7JwKJ4q
	eORa/5l8bNBHotGF7pty7Gqe/5sr/IyCofo3SX8j3m0kKUFflO9N+Q30zyDeg05FRf6Nx0ixvoA
	0W51Sj/i53I96cH4vEGiPQTtUGnupL6cmwBJFRpQXSWPv5LyY29BGuQFaTr/caatKwlk36Op9OG
	Yo/gVhRC/mbSdzCLhFfmXcajs3XJCv5NfiBOgpMHkllxZPM8gZJBlQ9RGTEstYh8eOKs2LobaAn
	n4D/pa5VreMU16wptyzBiQrg4dleptckrBPy3qno+6RD14019TdvyDKyhYKBeP3OyE9Wesn9rJg
	Dx1g9f0qRSdWZjoOryVIJLkB2
X-Google-Smtp-Source: AGHT+IF+bbkMxlz1VcogJpzRGuR+rHH4uhWm8E6xaXb7FZHjS4o/dYV+UAcTlCURGVrDaYivlIcTbQ==
X-Received: by 2002:a17:90b:4c10:b0:2fe:7f40:420a with SMTP id 98e67ed59e1d1-30b3a674f85mr2180792a91.17.1746669051555;
        Wed, 07 May 2025 18:50:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4d54febsm958269a91.23.2025.05.07.18.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 18:50:50 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uCqPQ-00000000kT1-0mb3;
	Thu, 08 May 2025 11:50:48 +1000
Date: Thu, 8 May 2025 11:50:48 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@meta.com>,
	Anna Schumaker <anna@kernel.org>
Subject: Re: performance r nfsd with RWF_DONTCACHE and larger wsizes
Message-ID: <aBwN-Iz3hJTAKpzS@dread.disaster.area>
References: <370dd4ae06d44f852342b7ee2b969fc544bd1213.camel@kernel.org>
 <aBqNtfPwFBvQCgeT@dread.disaster.area>
 <8039661b7a4c4f10452180372bd985c0440f1e1d.camel@kernel.org>
 <aBrKbOoj4dgUvz8f@dread.disaster.area>
 <aBvVltbDKdHXMtLL@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBvVltbDKdHXMtLL@kernel.org>

On Wed, May 07, 2025 at 05:50:14PM -0400, Mike Snitzer wrote:
> Hey Dave,
> 
> Thanks for providing your thoughts on all this.  More inlined below.
> 
> On Wed, May 07, 2025 at 12:50:20PM +1000, Dave Chinner wrote:
> > On Tue, May 06, 2025 at 08:06:51PM -0400, Jeff Layton wrote:
> > > On Wed, 2025-05-07 at 08:31 +1000, Dave Chinner wrote:
> > > > What are the fio control parameters of the IO you are doing? (e.g.
> > > > is this single threaded IO, does it use the psync, libaio or iouring
> > > > engine, etc)
> > > > 
> > > 
> > > 
> > > ; fio-seq-write.job for fiotest
> > > 
> > > [global]
> > > name=fio-seq-write
> > > filename=fio-seq-write
> > > rw=write
> > > bs=256K
> > > direct=0
> > > numjobs=1
> > > time_based
> > > runtime=900
> > > 
> > > [file1]
> > > size=10G
> > > ioengine=libaio
> > > iodepth=16
> >
> > Ok, so we are doing AIO writes on the client side, so we have ~16
> > writes on the wire from the client at any given time.
> 
> Jeff's workload is really underwhelming given he is operating well
> within available memory (so avoiding reclaim, etc).  As such this test
> is really not testing what RWF_DONTCACHE is meant to address (and to
> answer Chuck's question of "what do you hope to get from
> RWF_DONTCACHE?"): the ability to reach steady state where even if
> memory is oversubscribed the network pipes and NVMe devices are as
> close to 100% utilization as possible.

Right.

However, one of the things that has to be kept in mind is that we
don't have 100% of the CPU dedicated to servicing RWF_DONTCACHE IO
like the fio microbenchmarks have.

Applications are going to take a chunk of CPU time to
create/marshall/process the data that we we are doing IO on, so any
time we spend on doing IO is less time that the applications have to
do their work. If you can saturate the storage without saturating
CPUs, then RWF_DONTCACHE should allow that steady state to be
maintained indefinitely.

However, RWF_DONTCACHE does not remove the data copy overhead of
buffered IO, whilst it adds IO submission overhead to each IO. Hence
it will require more CPU time to saturate the storage devices than
normal buffered IO. If you've got CPU to spare, great. If you don't,
then overall performance will be reduced.

> > This also means they are likely not being received by the NFS server
> > in sequential order, and the NFS server is going to be processing
> > roughly 16 write RPCs to the same file concurrently using
> > RWF_DONTCACHE IO.
> > 
> > These are not going to be exactly sequential - the server side IO
> > pattern to the filesystem is quasi-sequential, with random IOs being
> > out of order and leaving temporary holes in the file until the OO
> > write is processed.
> > 
> > XFS should handle this fine via the speculative preallocation beyond
> > EOF that is triggered by extending writes (it was designed to
> > mitigate the fragmentation this NFS behaviour causes). However, we
> > should always keep in mind that while client side IO is sequential,
> > what the server is doing to the underlying filesystem needs to be
> > treated as "concurrent IO to a single file" rather than "sequential
> > IO".
> 
> Hammerspace has definitely seen that 1MB IO coming off the wire is
> fragmented by the time it XFS issues it to underlying storage; so much
> so that IOPs bound devices (e.g. AWS devices that are capped at ~10K
> IOPs) are choking due to all the small IO.

That should not happen in the general case. Can you start a separate
thread to triage the issue so we can try to understand why that is
happening?

> So yeah, minimizing the fragmentation is critical (and largely *not*
> solved at this point... hacks like sync mount from NFS client or using
> O_DIRECT at the client, which sets sync bit, helps reduce the
> fragmentation but as soon as you go full buffered the N=16+ IOs on the
> wire will fragment each other).

Fragmentation mitigation for NFS server IO is generally only
addressable at the filesystem level - it's not really something you
can mitigate at the NFS server or client.

> Do you recommend any particular tuning to help XFS's speculative
> preallocation work for many competing "sequential" IO threads?

I can suggest lots of things, but without knowing the IO pattern,
the fragmentation pattern, the filesystem state, what triggers the
fragmentation, etc, I'd just be guessing as to which knob might make
the problem go away (hence the request to separate that out).

-Dave.
-- 
Dave Chinner
david@fromorbit.com

