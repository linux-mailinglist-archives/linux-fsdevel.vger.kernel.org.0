Return-Path: <linux-fsdevel+bounces-51516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B157AD7ADF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 21:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A215C3A3B13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 19:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D562989B2;
	Thu, 12 Jun 2025 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcfJLS/n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C2145948;
	Thu, 12 Jun 2025 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749755332; cv=none; b=Vc/32bqu+2RS5IxfgwQJMgxjncWlDK7ozI0Q4u4GqZND4390v5gOyg9ugjWJs7w0iBX4tYGxOY1qV4DhwsWrclN7a6TO2M897+aJXPqjxr1JHgNG6leE1+Rnt1Gi4G3ERNvdwq+oFmXvJby7NwzsxcnGHhrjfOBKMp731ckdBuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749755332; c=relaxed/simple;
	bh=lcfdF0Qmc3+U34PxxUmMIiGviPQGnjy3HUOTSOqe0uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGta0am0KNFtaiXf0FebiGZ5E8C7KMZkeUevBgxTx7XRn11pXlJgBgUDKkc8goMCqZeJwrqXFtV+O4cF8LKKgkklu/ujG7JNm61ULV5htHyq4ksPpQ9dEyXFo142SheYo8p/2B4i+QBkCgF19fDlcSkN7m+3xJck/kwI6lexwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcfJLS/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9589C4CEEA;
	Thu, 12 Jun 2025 19:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749755332;
	bh=lcfdF0Qmc3+U34PxxUmMIiGviPQGnjy3HUOTSOqe0uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gcfJLS/nzb45qfHk+2VdtECzCAlJwLtu3rEgMNlnl+2LggRFMDqH2MWiahQHQU/XB
	 yBRJiCzpRgiPLaXTtWkonvIBH8H70Fxff0bxcrSGo2VmZUgzQgCMZJpO4eqkBHGRzx
	 pIUss9bIV5rFLw8tzm0d7l/i0m3zudegkV3alKlXZkR+M///CYY9pogwJjKT817Kbf
	 kAWco1nJj+3haDMExV0VI0PkLngmlPJdTds3QvfW+lV+uwwwRfvngrpl9rX4jLPVdd
	 PR9n4u0V683U5duclGKQhZbIDT3LIsrt86j25hbLIz6xPg+PvqyMsysfulrY9/2xOl
	 mdDGovquUeibg==
Date: Thu, 12 Jun 2025 15:08:50 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, willy@infradead.org,
	jonathan.flynn@hammerspace.com, keith.mannthey@hammerspace.com
Subject: Re: [PATCH 0/6] NFSD: add enable-dontcache and initially use it to
 add DIO support
Message-ID: <aEslwqa9iMeZjjlV@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <7944f6aa-d797-4323-98dc-7ef7e388c69f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7944f6aa-d797-4323-98dc-7ef7e388c69f@oracle.com>

On Thu, Jun 12, 2025 at 09:46:12AM -0400, Chuck Lever wrote:
> On 6/10/25 4:57 PM, Mike Snitzer wrote:
> > The O_DIRECT performance win is pretty fantastic thanks to reduced CPU
> > and memory use, particularly for workloads with a working set that far
> > exceeds the available memory of a given server.  This patchset's
> > changes (though patch 5, patch 6 wasn't written until after
> > benchmarking performed) enabled Hammerspace to improve its IO500.org
> > benchmark result (as submitted for this week's ISC 2025 in Hamburg,
> > Germany) by 25%.
> > 
> > That 25% improvement on IO500 is owed to NFS servers seeing:
> > - reduced CPU usage from 100% to ~50%

Apples: 10 servers, 10 clients, 64 PPN (Processes Per Node):

> >   O_DIRECT:
> >   write: 51% idle, 25% system,   14% IO wait,   2% IRQ
> >   read:  55% idle,  9% system, 32.5% IO wait, 1.5% IRQ

Oranges: 6 servers, 6 clients, 128 PPN:

> >   buffered:
> >   write: 17.8% idle, 67.5% system,   8% IO wait,  2% IRQ
> >   read:  3.29% idle, 94.2% system, 2.5% IO wait,  1% IRQ
> 
> The IO wait and IRQ numbers for the buffered results appear to be
> significantly better than for O_DIRECT. Can you help us understand
> that? Is device utilization better or worse with O_DIRECT?

It was a post-mortum data analysis fail: when I worked with others
(Jon and Keith, cc'd) to collect performance data for use in my 0th
header (above) we didn't have buffered IO performance data from the
full IO500-scale benchmark (10 servers, 10 clients).  I missed that
the above married apples and oranges until you noticed something
off...

Sorry about that.  We don't currently have the full 10 nodes
available, so Keith re-ran IOR "easy" testing with 6 nodes to collect
new data.

NOTE his run was with much larger PPN (128 instead of 64) coupled with
reduction of both the number of client and server nodes (from 10 to 6)
used.

Here is CPU usage for one of the server nodes while running IOR "easy" 
with 128 PPN on each of 6 clients, against 6 servers:

- reduced CPU usage from 100% to ~56% for read and 71.6% for Write
  O_DIRECT:
  write: 28.4% idle, 50% system,   13% IO wait,   2% IRQ
  read:    44% idle, 11% system,   39% IO wait, 1.8% IRQ
  buffered:
  write:   17% idle, 68.4% system, 8.5% IO wait,   2% IRQ
  read:  3.51% idle, 94.5% system,   0% IO wait, 0.6% IRQ

And associated NVMe performance:

- increased NVMe throughtput when comparing O_DIRECT vs buffered:
  O_DIRECT: 10.5 GB/s for writes, 11.6 GB/s for reads
  buffered: 7.75-8 GB/s for writes, 4 GB/s before tip over but 800MB/s after for reads 

("tipover" is when reclaim starts to dominate due to inability to
efficiently find free pages so kswapd and kcompactd burn a lot of
resources).

And again here is the associated 6 node IOR easy NVMe performance in
graph form: https://original.art/NFSD_direct_vs_buffered_IO.jpg

> > - reduced memory usage from just under 100% (987GiB for reads, 978GiB
> >   for writes) to only ~244 MB for cache+buffer use (for both reads and
> >   writes).
> >   - buffered would tip-over due to kswapd and kcompactd struggling to
> >     find free memory during reclaim.

This memory usage data is still the case with the 6 server testbed.

> > - increased NVMe throughtput when comparing O_DIRECT vs buffered:
> >   O_DIRECT: 8-10 GB/s for writes, 9-11.8 GB/s for reads
> >   buffered: 8 GB/s for writes,    4-5 GB/s for reads

And again, here is the end result for the IOR easy benchmark:

From Hammerspace's 10 node IO500 reported summary of IOR easy result:
Write:
O_DIRECT: [RESULT]      ior-easy-write     420.351599 GiB/s : time 869.650 seconds
CACHED:   [RESULT]      ior-easy-write     368.268722 GiB/s : time 413.647 seconds

Read: 
O_DIRECT: [RESULT]      ior-easy-read     446.790791 GiB/s : time 818.219 seconds
CACHED:   [RESULT]      ior-easy-read     284.706196 GiB/s : time 534.950 seconds

From Hammerspace's 6 node run, IOR's summary output format (as opposed
to IO500 reported summary from above 10 node result):

Write:
IO mode:  access    bw(MiB/s)  IOPS       Latency(s)  block(KiB) xfer(KiB)  open(s)    wr/rd(s)   close(s)   total(s)   iter
--------  ------    ---------  ----       ----------  ---------- ---------  --------   --------   --------   --------   ----
O_DIRECT  write     348132     348133     0.002035    278921216  1024.00    0.040978   600.89     384.04     600.90     0   
CACHED    write     295579     295579     0.002416    278921216  1024.00    0.051602   707.73     355.27     707.73     0   

IO mode:  access    bw(MiB/s)  IOPS       Latency(s)  block(KiB) xfer(KiB)  open(s)    wr/rd(s)   close(s)   total(s)   iter
--------  ------    ---------  ----       ----------  ---------- ---------  --------   --------   --------   --------   ----
O_DIRECT  read      347971     347973     0.001928    278921216  1024.00    0.017612   601.17     421.30     601.17     0   
CACHED    read      60653      60653      0.006894    278921216  1024.00    0.017279   3448.99    2975.23    3448.99    0   

> > - ability to support more IO threads per client system (from 48 to 64)
> 
> This last item: how do you measure the "ability to support more
> threads"? Is there a latency curve that is flatter? Do you see changes
> in the latency distribution and the number of latency outliers?

Mainly in the context of the IOR benchmark's result, we can see that
increasing PPN becomes detrimental because the score doesn't improve
or gets worse.

> My general comment here is kind of in the "related or future work"
> category. This is not an objection, just thinking out loud.
> 
> But, can we get more insight into specifically where the CPU
> utilization reduction comes from? Is it lock contention? Is it
> inefficient data structure traversal? Any improvement here benefits
> everyone, so that should be a focus of some study.

Buffered IO just commands more resources than O_DIRECT for workloads
with a working set that exceeds system memory.

Each of the 6 servers has 1TiB of memory.

So for the above 6 client 128 PPN IOT "easy" run, each client thread
is writing and then reading 266 GiB.  That creates an aggregate
working set of 199.50 TiB

The 199.50 TiB working set dwarfs the servers' aggregate 6 TiB of
memory.  Being able to drive each of the 8 NVMe in each server as
efficiently as possible is critical.

As you can see from the above NVMe performance above O_DIRECT is best.

> If the memory utilization is a problem, that sounds like an issue with
> kernel systems outside of NFSD, or perhaps some system tuning can be
> done to improve matters. Again, drilling into this and trying to improve
> it will benefit everyone.

Yeah, there is an extensive iceberg level issue with buffered IO and
MM (reclaim's use of kswapd and kcompactd to find free pages) that
underpins the justifcation for RWF_DONTCACHE being developed and
merged.  I'm not the best person to speak to all the long-standing
challenges (Willy, Dave, Jens, others would be better).

> These results do point to some problems, clearly. Whether NFSD using
> direct I/O is the best solution is not obvious to me yet.

All solutions are on the table.  O_DIRECT just happens to be the most
straight-forward to work through at this point.

Dave Chinner's feeling that O_DIRECT a much better solution than
RWF_DONTCACHE for NFSD certainly helped narrow my focus too, from:
https://lore.kernel.org/linux-nfs/aBrKbOoj4dgUvz8f@dread.disaster.area/

"The nfs client largely aligns all of the page caceh based IO, so I'd
think that O_DIRECT on the server side would be much more performant
than RWF_DONTCACHE. Especially as XFS will do concurrent O_DIRECT
writes all the way down to the storage....."

(Dave would be correct about NFSD's page alignment if RDMA used, but
obviously not the case if TCP used due to SUNRPC TCP's WRITE payload
being received into misaligned pages).

Thanks,
Mike

