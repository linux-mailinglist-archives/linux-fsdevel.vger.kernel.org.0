Return-Path: <linux-fsdevel+bounces-51349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96139AD5DB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 20:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD22162B6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB3227BF80;
	Wed, 11 Jun 2025 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utVzX9dE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CCD28369D;
	Wed, 11 Jun 2025 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664927; cv=none; b=ktPFH7awl1kkYwqIUK4siO5U7zIEVAqfZLjZruCHxYhCXQcg3DB2a+0IXpNS9LvcvWFGALmsZBHos0zPQASMmzQhdW7X+6VvxTDcaUd/TZB3R32BifKtRJfPan0aCl6ks17kTJtzS5/64yozNYt4WqUMKr4Kd4CWwReGqa5fLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664927; c=relaxed/simple;
	bh=oK07qNHHtHnEZOHYEFp2pLAZLrm+2OvIpgclbYz0RiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2RstvQfkFmgjv24H+ugT7Ujey15i/xtYdfdCUtblX41b7NUNAaEcO6d9nq7JyV7JZWoQBLpJMoX0ypXNfZe1dwvXM0NHA+GUyZ76m1OSqYOt1zyLSJDUzbedyitPxLbvscuFkVpR8IUkxz85zJcfk3gPLcg3YKWs1LIgHvgLjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utVzX9dE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE013C4CEEA;
	Wed, 11 Jun 2025 18:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749664927;
	bh=oK07qNHHtHnEZOHYEFp2pLAZLrm+2OvIpgclbYz0RiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=utVzX9dE26DRCTqCb6ouSwqWjK43MAtsRplcwJhfyoXYm6an7DKOYXBJCH5ifiXd1
	 eZZmLvwtfpwlmXoctWeD3SXOBikOUEUfgoMjo1Tm1NbTOg70VXzHXEHJJQH9mtrWwf
	 jtgup6WmnShL8G8xhE8hANmghas86xQTl7Gi37MEzovwfewOC/ULgcT/wQu2WhW4ME
	 ldNQFKrfBjMfC2ZIJ2pTF6uCgw0jsTQe3KSzklB86TyiEkcO9Lh1kVBve3b3OjGqCy
	 UDPXWkFj8mPyxt5kiyYmgUhtcPvhtWyuMYnAc5BeKP5RqZXinLgNIx0wgW3aSOgmZx
	 iZLyDZ7CYYcrw==
Date: Wed, 11 Jun 2025 14:02:05 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/6] NFSD: add enable-dontcache and initially use it to
 add DIO support
Message-ID: <aEnEnTEYaQ07XOb5@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <9f96291b-3a87-47db-a037-c1d996ea37c0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f96291b-3a87-47db-a037-c1d996ea37c0@oracle.com>

On Wed, Jun 11, 2025 at 10:16:39AM -0400, Chuck Lever wrote:
> On 6/10/25 4:57 PM, Mike Snitzer wrote:
> > Hi,
> > 
> > This series introduces 'enable-dontcache' to NFSD's debugfs interface,
> > once enabled NFSD will selectively make use of O_DIRECT when issuing
> > read and write IO:
> > - all READs will use O_DIRECT (both aligned and misaligned)
> > - all DIO-aligned WRITEs will use O_DIRECT (useful for SUNRPC RDMA)
> > - misaligned WRITEs currently continue to use normal buffered IO
> > 
> > Q: Why not actually use RWF_DONTCACHE (yet)?
> > A: 
> > If IO can is properly DIO-aligned, or can be made to be, using
> > O_DIRECT is preferred over DONTCACHE because of its reduced CPU and
> > memory usage.  Relative to NFSD using RWF_DONTCACHE for misaligned
> > WRITEs, I've briefly discussed with Jens that follow-on dontcache work
> > is needed to justify falling back to actually using RWF_DONTCACHE.
> > Specifically, Hammerspace benchmarking has confirmed as Jeff Layton
> > suggested at Bakeathon, we need dontcache to be enhanced to not
> > immediately dropbehind when IO completes -- because it works against
> > us (due to RMW needing to read without benefit of cache), whereas
> > buffered IO enables misaligned IO to be more performant. Jens thought
> > that delayed dropbehind is certainly doable but that he needed to
> > reason through it further (so timing on availability is TBD). As soon
> > as it is possible I'll happily switch NFSD's misaligned write IO
> > fallback from normal buffered IO to actually using RWF_DONTCACHE.
> > 
> > Continuing with what this patchset provides:
> > 
> > NFSD now uses STATX_DIOALIGN and STATX_DIO_READ_ALIGN to get and store
> > DIO alignment attributes from underlying filesystem in associated
> > nfsd_file.  This is done when the nfsd_file is first opened for a
> > regular file.
> > 
> > A new RWF_DIRECT flag is added to include/uapi/linux/fs.h to allow
> > NFSD to use O_DIRECT on a per-IO basis.
> > 
> > If enable-dontcache=1 then RWF_DIRECT will be set for all READ IO
> > (even if the IO is misaligned, thanks to expanding the read to be
> > aligned for use with DIO, as suggested by Jeff and Chuck at the NFS
> > Bakeathon held recently in Ann Arbor).
> > 
> > NFSD will also set RWF_DIRECT if a WRITE's IO is aligned relative to
> > DIO alignment (both page and disk alignment).  This works quite well
> > for aligned WRITE IO with SUNRPC's RDMA transport as-is, because it
> > maps the WRITE payload into aligned pages. But more work is needed to
> > be able to leverage O_DIRECT when SUNRPC's regular TCP transport is
> > used. I spent quite a bit of time analyzing the existing xdr_buf code
> > and NFSD's use of it.  Unfortunately, the WRITE payload gets stored in
> > misaligned pages such that O_DIRECT isn't possible without a copy
> > (completely defeating the point).  I'll reply to this cover letter to
> > start a subthread to discuss how best to deal with misaligned write
> > IO (by association with Hammerspace, I'm most interested in NFS v3).
> > 
> > Performance benefits of using O_DIRECT in NFSD:
> > 
> > Hammerspace's testbed was 10 NFS servers connected via 800Gbit
> > RDMA networking (mlx5_core), each with 1TB of memory, 48 cores (2 NUMA
> > nodes) and 8 ScaleFlux NVMe devices (each with two 3.5TB namespaces.
> > Theoretical max for reads per NVMe device is 14GB/s, or ~7GB/s per
> > namespace).
> > 
> > And 10 client systems each running 64 IO threads.
> > 
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
> >   O_DIRECT:
> >   write: 51% idle, 25% system,   14% IO wait,   2% IRQ
> >   read:  55% idle,  9% system, 32.5% IO wait, 1.5% IRQ
> >   buffered:
> >   write: 17.8% idle, 67.5% system,   8% IO wait,  2% IRQ
> >   read:  3.29% idle, 94.2% system, 2.5% IO wait,  1% IRQ
> > 
> > - reduced memory usage from just under 100% (987GiB for reads, 978GiB
> >   for writes) to only ~244 MB for cache+buffer use (for both reads and
> >   writes).
> >   - buffered would tip-over due to kswapd and kcompactd struggling to
> >     find free memory during reclaim.
> > 
> > - increased NVMe throughtput when comparing O_DIRECT vs buffered:
> >   O_DIRECT: 8-10 GB/s for writes, 9-11.8 GB/s for reads
> >   buffered: 8 GB/s for writes,    4-5 GB/s for reads
> > 
> > - abiliy to support more IO threads per client system (from 48 to 64)
> > 
> > The performance improvement highlight of the numerous individual tests
> > in the IO500 collection of benchamrks was in the IOR "easy" test:
> > 
> > Write:
> > O_DIRECT: [RESULT]      ior-easy-write     420.351599 GiB/s : time 869.650 seconds
> > CACHED:   [RESULT]      ior-easy-write     368.268722 GiB/s : time 413.647 seconds
> > 
> > Read: 
> > O_DIRECT: [RESULT]      ior-easy-read     446.790791 GiB/s : time 818.219 seconds
> > CACHED:   [RESULT]      ior-easy-read     284.706196 GiB/s : time 534.950 seconds
> > 
> > It is suspected that patch 6 in this patchset will improve IOR "hard"
> > read results. The "hard" name comes from the fact that it performs all
> > IO using a mislaigned blocksize of 47008 bytes (which happens to be
> > the IO size I showed ftrace output for in the 6th patch's header).
> > 
> > All review and discussion is welcome, thanks!
> > Mike
> > 
> > Mike Snitzer (6):
> >   NFSD: add the ability to enable use of RWF_DONTCACHE for all IO
> >   NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
> >   NFSD: pass nfsd_file to nfsd_iter_read()
> >   fs: introduce RWF_DIRECT to allow using O_DIRECT on a per-IO basis
> >   NFSD: leverage DIO alignment to selectively issue O_DIRECT reads and writes
> >   NFSD: issue READs using O_DIRECT even if IO is misaligned
> > 
> >  fs/nfsd/debugfs.c          |  39 +++++++++++++
> >  fs/nfsd/filecache.c        |  32 +++++++++++
> >  fs/nfsd/filecache.h        |   4 ++
> >  fs/nfsd/nfs4xdr.c          |   8 +--
> >  fs/nfsd/nfsd.h             |   1 +
> >  fs/nfsd/trace.h            |  37 +++++++++++++
> >  fs/nfsd/vfs.c              | 111 ++++++++++++++++++++++++++++++++++---
> >  fs/nfsd/vfs.h              |  17 +-----
> >  include/linux/fs.h         |   2 +-
> >  include/linux/sunrpc/svc.h |   5 +-
> >  include/uapi/linux/fs.h    |   5 +-
> >  11 files changed, 231 insertions(+), 30 deletions(-)
> > 
> 
> 
> Hey Mike!
> 
> There's a lot to digest here!

For sure.  Thanks for working through it.  My hope is it resonates and
is meaningful to digest *after* reading through my lede-burying cover
letter *and* the patches themselves.  Let it wash over you.

It only adds 200 lines of change, folding patches might reduce
weirdness.  How best to sequence and fold changes will be useful
feedback.

> A few general comments:
> 
> - Since this isn't a series that you intend I should apply immediately
> to nfsd-next, let's mark subsequent postings with "RFC".

Yeah, my first posting should've been RFC.

But I'd be in favor of working with urgency so that by v6.16-rc4/5 you
and Jeff are fine with it for the 6.17 merge window.
 
> - Before diving into the history and design, your cover letter should
> start with a clear problem statement. What are you trying to fix? I
> think that might be what Christoph is missing in his comment on 5/6.
> Maybe it's in the cover letter now, but it reads to me like the lede is
> buried.

Yeah, I struggled/struggle to distill sweeping work with various
talking points down into a concise and natural flow.  Probably should
taken my cover letter and fed it to some AI. ;)

> - In addition to the big iron results, I'd like to see benchmark results
> for small I/O workloads, and workloads with slower persistent storage,
> and workloads on slower network fabrics (ie, TCP).

It is opt-in so thankfully every class of usecase doesn't need to be
something I've covered personally.  I'd welcome others to discover how
this work impacts their workload of choice.

But yeah, TCP with virt systems in the lab is what I developed against
for quite a while.  It exposed that write IO is never aligned, so I
eventually put that to one side because the initial target use was on
a cluster with more capable RDMA network.

Thanks,
Mike

