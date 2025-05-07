Return-Path: <linux-fsdevel+bounces-48430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E5BAAEE30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 23:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A443ADB5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 21:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5B528FFD0;
	Wed,  7 May 2025 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c587/yhQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E6828FA88;
	Wed,  7 May 2025 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746654617; cv=none; b=nftbXejwOHrSjXZa685fo1lOYFV2swNjsHs2DTG/D3OUYkT6jzeM/zBZLud4605ZPgpzJqKo/YROTRZwiXqzW/hZu1MnOYZHkG827Vhuv954VbjiBANhlXpcL2AYCy/R3PDO2Wz6a/q2JzoNEKXqtUu8VLZOwuEIMt7Yj5ut9BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746654617; c=relaxed/simple;
	bh=U1Bq1469yNv7erJEul5P+4Y4mH40ucnTgrnUKuCoPpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJmjePr0eHMozOPndPcFWCFzLDM245NFNrtXPgQPUhFa7OjNTmi2BofK8nLN6Gpg2Crw/r8p93WYj0FmrxRQeEkDhzss8NgpnbWiVnIINhtllIJJhv8/evLJRDbn7kFkwhQ9vWa7dKRPRuh5C4TwTrLNua+og4Jnam5vrh28Ce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c587/yhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EB0C4CEE2;
	Wed,  7 May 2025 21:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746654615;
	bh=U1Bq1469yNv7erJEul5P+4Y4mH40ucnTgrnUKuCoPpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c587/yhQ7XXLt62AyNX35sO+7BucK5gwgInhOrY6HpMH7xRCF76MmeLd5bzH4h+tB
	 bJFYsvrWNXgkTBoqExoXmtG4unBbIk9p3LXbOBW4GGa9cbzf+tLe/O/coerGgDqGdg
	 yALaGfoQE6sH1A7aDBbu2mdyWLN1NapW0RMAoqdgUGI+me4KnzjO1ZW5JzroV0Y5UC
	 8p6lPKttQorUECGCpW0kPLQFzdPwtusq5buuWmEf0mdob025ckW342XHZtaESRKaD/
	 SAFB9gMnRRIa1a3TP0vTy5OSz6Ce7bgW+VkSOC20M0Twbz9FUUnrDnX+cn4t3whk6Z
	 uEYERDB4jXc+Q==
Date: Wed, 7 May 2025 17:50:14 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@meta.com>,
	Anna Schumaker <anna@kernel.org>
Subject: Re: performance r nfsd with RWF_DONTCACHE and larger wsizes
Message-ID: <aBvVltbDKdHXMtLL@kernel.org>
References: <370dd4ae06d44f852342b7ee2b969fc544bd1213.camel@kernel.org>
 <aBqNtfPwFBvQCgeT@dread.disaster.area>
 <8039661b7a4c4f10452180372bd985c0440f1e1d.camel@kernel.org>
 <aBrKbOoj4dgUvz8f@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBrKbOoj4dgUvz8f@dread.disaster.area>

Hey Dave,

Thanks for providing your thoughts on all this.  More inlined below.

On Wed, May 07, 2025 at 12:50:20PM +1000, Dave Chinner wrote:
> On Tue, May 06, 2025 at 08:06:51PM -0400, Jeff Layton wrote:
> > On Wed, 2025-05-07 at 08:31 +1000, Dave Chinner wrote:
> > > On Tue, May 06, 2025 at 01:40:35PM -0400, Jeff Layton wrote:
> > > > FYI I decided to try and get some numbers with Mike's RWF_DONTCACHE
> > > > patches for nfsd [1]. Those add a module param that make all reads and
> > > > writes use RWF_DONTCACHE.
> > > > 
> > > > I had one host that was running knfsd with an XFS export, and a second
> > > > that was acting as NFS client. Both machines have tons of memory, so
> > > > pagecache utilization is irrelevant for this test.
> > > 
> > > Does RWF_DONTCACHE result in server side STABLE write requests from
> > > the NFS client, or are they still unstable and require a post-write
> > > completion COMMIT operation from the client to trigger server side
> > > writeback before the client can discard the page cache?
> > > 
> > 
> > The latter. I didn't change the client at all here (other than to allow
> > it to do bigger writes on the wire). It's just doing bog-standard
> > buffered I/O. nfsd is adding RWF_DONTCACHE to every write via Mike's
> > patch.
> 
> Ok, that wasn't clear that it was only server side RWF_DONTCACHE.
> 
> I have some more context from a different (internal) discussion
> thread about how poorly the NFSD read side performs with
> RWF_DONTCACHE compared to O_DIRECT. This is because there is massive
> page allocator spin lock contention due to all the concurrent reads
> being serviced.

That discussion started with: its a very chaotic workload "read a
bunch of large files that cause memory to be oversubscribed 2.5x
across 8 servers".  Many knfsd threads (~240) per server handling 1MB
IO to 8 XFS on NVMe.. (so 8 servers, each with 8 NVMe devices).

For others' benefit here is the flamegraph for this heavy
nfsd.nfsd_dontcache=Y read workload as seen on 1 of the 8 servers:
https://original.art/dontcache_read.svg

Dave offered this additional analysis:
"the flame graph indicates massive lock contention in the page
allocator (i.e. on the page free lists). There's a chunk of time in
data copying (copy_page_to_iter), but 70% of the CPU usage looks to be
page allocator spinlock contention."

All this causes RWF_DONTCACHE reads to be considerably slower than
normal buffered reads (only getting 40-66% of normal buffered reads,
worse read performance occurs when the system is less loaded).  How
knfsd is handling the IO seems to be contributing to the 100% cpu
usage.  If fio is used (with pvsync2 and uncached=1) directly to a
single XFS then CPU is ~50%.

(Jeff: not following why you were seeing EOPNOTSUPP for RWF_DONTCACHE
reads, is that somehow due to the rsize/wsize patches from Chuck?
RWF_DONTCACHE reads work with my patch you quoted as "[1]").

> The buffered write path locking is different, but I suspect
> something similar is occurring and I'm going to ask you to confirm
> it...

With knfsd to XFS on NVMe, favorable difference for RWF_DONTCACHE
writes is that despite also seeing 100% CPU usage, due to lock
contention et al, RWF_DONTCACHE does perform 0-54% better compared to
normal buffered writes that exceed the system's memory by 2.5x
(largest gains seen with most extreme load).

Without RWF_DONTCACHE the system gets pushed to reclaim and the
associated work really hurts.

As tested with knfsd we've been generally unable to see the
reduced CPU usage that is documented in Jens' commit headers:
  for reads:  https://git.kernel.org/linus/8026e49bff9b
  for writes: https://git.kernel.org/linus/d47c670061b5
But as mentioned above, eliminating knfsd and testing XFS directly
with fio does generally reflect what Jens documented.

So more work needed to address knfsd RWF_DONTCACHE inefficiencies.

> > > > I tested sequential writes using the fio-seq_write.fio test, both with
> > > > and without the module param enabled.
> > > > 
> > > > These numbers are from one run each, but they were pretty stable over
> > > > several runs:
> > > > 
> > > > # fio /usr/share/doc/fio/examples/fio-seq-write.fio
> > > 
> > > $ cat /usr/share/doc/fio/examples/fio-seq-write.fio
> > > cat: /usr/share/doc/fio/examples/fio-seq-write.fio: No such file or directory
> > > $
> > > 
> > > What are the fio control parameters of the IO you are doing? (e.g.
> > > is this single threaded IO, does it use the psync, libaio or iouring
> > > engine, etc)
> > > 
> > 
> > 
> > ; fio-seq-write.job for fiotest
> > 
> > [global]
> > name=fio-seq-write
> > filename=fio-seq-write
> > rw=write
> > bs=256K
> > direct=0
> > numjobs=1
> > time_based
> > runtime=900
> > 
> > [file1]
> > size=10G
> > ioengine=libaio
> > iodepth=16
>
> Ok, so we are doing AIO writes on the client side, so we have ~16
> writes on the wire from the client at any given time.

Jeff's workload is really underwhelming given he is operating well
within available memory (so avoiding reclaim, etc).  As such this test
is really not testing what RWF_DONTCACHE is meant to address (and to
answer Chuck's question of "what do you hope to get from
RWF_DONTCACHE?"): the ability to reach steady state where even if
memory is oversubscribed the network pipes and NVMe devices are as
close to 100% utilization as possible.

> This also means they are likely not being received by the NFS server
> in sequential order, and the NFS server is going to be processing
> roughly 16 write RPCs to the same file concurrently using
> RWF_DONTCACHE IO.
> 
> These are not going to be exactly sequential - the server side IO
> pattern to the filesystem is quasi-sequential, with random IOs being
> out of order and leaving temporary holes in the file until the OO
> write is processed.
> 
> XFS should handle this fine via the speculative preallocation beyond
> EOF that is triggered by extending writes (it was designed to
> mitigate the fragmentation this NFS behaviour causes). However, we
> should always keep in mind that while client side IO is sequential,
> what the server is doing to the underlying filesystem needs to be
> treated as "concurrent IO to a single file" rather than "sequential
> IO".

Hammerspace has definitely seen that 1MB IO coming off the wire is
fragmented by the time it XFS issues it to underlying storage; so much
so that IOPs bound devices (e.g. AWS devices that are capped at ~10K
IOPs) are choking due to all the small IO.

So yeah, minimizing the fragmentation is critical (and largely *not*
solved at this point... hacks like sync mount from NFS client or using
O_DIRECT at the client, which sets sync bit, helps reduce the
fragmentation but as soon as you go full buffered the N=16+ IOs on the
wire will fragment each other).

Do you recommend any particular tuning to help XFS's speculative
preallocation work for many competing "sequential" IO threads?  Like
would having 32 AG allow for 32 speculative preallocation engines?  Or
is it only possible to split across AG for different inodes?
(Sorry, I really do aim to get more well-versed with XFS... its only
been ~17 years that it has featured in IO stacks I've had to
engineer, ugh...).

> > > > wsize=1M:
> > > > 
> > > > Normal:      WRITE: bw=1034MiB/s (1084MB/s), 1034MiB/s-1034MiB/s (1084MB/s-1084MB/s), io=910GiB (977GB), run=901326-901326msec
> > > > DONTCACHE:   WRITE: bw=649MiB/s (681MB/s), 649MiB/s-649MiB/s (681MB/s-681MB/s), io=571GiB (613GB), run=900001-900001msec
> > > > 
> > > > DONTCACHE with a 1M wsize vs. recent (v6.14-ish) knfsd was about 30%
> > > > slower. Memory consumption was down, but these boxes have oodles of
> > > > memory, so I didn't notice much change there.
> > > 
> > > So what is the IO pattern that the NFSD is sending to the underlying
> > > XFS filesystem?
> > > 
> > > Is it sending 1M RWF_DONTCACHE buffered IOs to XFS as well (i.e. one
> > > buffered write IO per NFS client write request), or is DONTCACHE
> > > only being used on the NFS client side?
> > > 
> > 
> > It's should be sequential I/O, though the writes would be coming in
> > from different nfsd threads. nfsd just does standard buffered I/O. The
> > WRITE handler calls nfsd_vfs_write(), which calls vfs_write_iter().
> > With the module parameter enabled, it also adds RWF_DONTCACHE.
> 
> Ok, so buffered writes (even with RWF_DONTCACHE) are not processed
> concurrently by XFS - there's an exclusive lock on the inode that
> will be serialising all the buffered write IO.
> 
> Given that most of the work that XFS will be doing during the write
> will not require releasing the CPU, there is a good chance that
> there is spin contention on the i_rwsem from the 15 other write
> waiters.
> 
> That may be a contributing factor to poor performance, so kernel
> profiles from the NFS server for both the normal buffered write path
> as well as the RWF_DONTCACHE buffered write path. Having some idea
> of the total CPU usage of the nfsds during the workload would also
> be useful.
> 
> > DONTCACHE is only being used on the server side. To be clear, the
> > protocol doesn't support that flag (yet), so we have no way to project
> > DONTCACHE from the client to the server (yet). This is just early
> > exploration to see whether DONTCACHE offers any benefit to this
> > workload.
> 
> The nfs client largely aligns all of the page caceh based IO, so I'd
> think that O_DIRECT on the server side would be much more performant
> than RWF_DONTCACHE. Especially as XFS will do concurrent O_DIRECT
> writes all the way down to the storage.....

Yes.  We really need to add full-blown O_DIRECT support to knfsd.  And
Hammerspace wants me to work on it ASAP.  But I welcome all the help I
can get, I have ideas but look forward to discussing next week at
Bakeathon and/or in this thread...

The first hurdle is coping with the head and/or tail of IO being
misaligned relative to the underlying storage's logical_block_size.
Need to cull off misaligned IO and use RWF_DONTCACHE for those but
O_DIRECT for the aligned middle is needed.

I aim to deal with that for NFS LOCALIO first (NFS client issues
IO direct to XFS, bypassing knfsd) and then reuse it for knfsd's
O_DIRECT support.

> > > > I wonder if we need some heuristic that makes generic_write_sync() only
> > > > kick off writeback immediately if the whole folio is dirty so we have
> > > > more time to gather writes before kicking off writeback?
> > > 
> > > You're doing aligned 1MB IOs - there should be no partially dirty
> > > large folios in either the client or the server page caches.
> > 
> > Interesting. I wonder what accounts for the slowdown with 1M writes? It
> > seems likely to be related to the more aggressive writeback with
> > DONTCACHE enabled, but it'd be good to understand this.
> 
> What I suspect is that block layer IO submission latency has
> increased significantly  with RWF_DONTCACHE and that is slowing down
> the rate at which it can service buffered writes to a single file.
> 
> The difference between normal buffered writes and RWF_DONTCACHE is
> that the write() context will marshall the dirty folios into bios
> and submit them to the block layer (via generic_write_sync()). If
> the underlying device queues are full, then the bio submission will
> be throttled to wait for IO completion.
> 
> At this point, all NFSD write processing to that file stalls. All
> the other nfsds are blocked on the i_rwsem, and that can't be
> released until the holder is released by the block layer throttling.
> Hence any time the underlying device queue fills, nfsd processing of
> incoming writes stalls completely.
> 
> When doing normal buffered writes, this IO submission stalling does
> not occur because there is no direct writeback occurring in the
> write() path.
> 
> Remember the bad old days of balance_dirty_pages() doing dirty
> throttling by submitting dirty pages for IO directly in the write()
> context? And how much better buffered write performance and write()
> submission latency became when we started deferring that IO to the
> writeback threads and waiting on completions?
> 
> We're essentially going back to the bad old days with buffered
> RWF_DONTCACHE writes. Instead of one nicely formed background
> writeback stream that can be throttled at the block layer without
> adversely affecting incoming write throughput, we end up with every
> write() context submitting IO synchronously and being randomly
> throttled by the block layer throttle....
> 
> There are a lot of reasons the current RWF_DONTCACHE implementation
> is sub-optimal for common workloads. This IO spraying and submission
> side throttling problem
> is one of the reasons why I suggested very early on that an async
> write-behind window (similar in concept to async readahead winodws)
> would likely be a much better generic solution for RWF_DONTCACHE
> writes. This would retain the "one nicely formed background
> writeback stream" behaviour that is desirable for buffered writes,
> but still allow in rapid reclaim of DONTCACHE folios as IO cleans
> them...

I recall you voicing this concern and nobody really seizing on it.
Could be that Jens is open changing the RWF_DONTCACHE implementation
if/when more proof is made for the need?

> > > That said, this is part of the reason I asked about both whether the
> > > client side write is STABLE and  whether RWF_DONTCACHE on
> > > the server side. i.e. using either of those will trigger writeback
> > > on the serer side immediately; in the case of the former it will
> > > also complete before returning to the client and not require a
> > > subsequent COMMIT RPC to wait for server side IO completion...
> > > 
> > 
> > I need to go back and sniff traffic to be sure, but I'm fairly certain
> > the client is issuing regular UNSTABLE writes and following up with a
> > later COMMIT, at least for most of them. The occasional STABLE write
> > might end up getting through, but that should be fairly rare.
> 
> Yeah, I don't think that's an issue given that only the server side
> is using RWF_DONTCACHE. The COMMIT will effectively just be a
> journal and/or device cache flush as all the dirty data has already
> been written back to storage....

FYI, most of Hammerspace RWF_DONTCACHE testing has been using O_DIRECT
for client IO and nfsd.nfsd_dontcache=Y on the server.

Thanks for the interesting discussion!
Mike

