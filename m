Return-Path: <linux-fsdevel+bounces-51194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A073CAD4435
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 22:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CBC83A58F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 20:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD922676C2;
	Tue, 10 Jun 2025 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJUKg+Sk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C64685;
	Tue, 10 Jun 2025 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589059; cv=none; b=PFUHI+OphN+2V42lfjZ4J4S1QbuJSTosgFfsTecbUWrCY3AOP6nZwIdoteiLWyHDeuh3ct/xk39onpf3kWrqgIilJvP8clGmaKPsxpdRE3Tl9ULAAzjVWZ3MQFXYEst1rSBTGgQJAp6hfYA+4BlSkNksv3HvS6K6M+yGQmn+0dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589059; c=relaxed/simple;
	bh=cpUV0skup8f2YNrtjlgMuSJZt6XE7ICObZOyoF/dS0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOn+MoH73F4Nnbt7S39wOQcC2OIi+fSCmeIBrG6cqCIHT5zUiKU5b0C4Zbfltk+drGT+4O7fmMKjf6iuR4ipL4UC6hWpgepMkE3j+51FqUeCG9NK5kkjysZT1ifXwk21crmFu/tI5VBYWZp7KGrjdTJHHau7XTfoGO9CGae7fBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJUKg+Sk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F54C4CEF0;
	Tue, 10 Jun 2025 20:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749589058;
	bh=cpUV0skup8f2YNrtjlgMuSJZt6XE7ICObZOyoF/dS0U=;
	h=From:To:Cc:Subject:Date:From;
	b=hJUKg+SkaUxPBlWBHidGo3yFehRuz8ZfgUqeClPWMAB6y+Z/WtfY5K7IIfFHe/HWF
	 ItYuVAhsEotLyR3JIoNyUYR89sgyLfoTkxjqprq/sWsgqt4CHDFN2HRL5c0uFVuFAs
	 kj7fiZGgowxbBa5P/ce/aHRz9QeTxp+EvVFcdGHNhHfsHd49DsftHM+3mPeGhHnruO
	 yx0+FRwjE+HVpaOuyO75iNEcmt4lhq/dasFhv59/xHeAguIhI+ep2zkmJdGIjUgiop
	 LbcOsj575PDsiJar0x3ilAbO5929LgTEszM13XIvrIYPpzRxilVPqrILo0dkJPQKna
	 je/LOq4Uxq4Tg==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/6] NFSD: add enable-dontcache and initially use it to add DIO support
Date: Tue, 10 Jun 2025 16:57:31 -0400
Message-ID: <20250610205737.63343-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series introduces 'enable-dontcache' to NFSD's debugfs interface,
once enabled NFSD will selectively make use of O_DIRECT when issuing
read and write IO:
- all READs will use O_DIRECT (both aligned and misaligned)
- all DIO-aligned WRITEs will use O_DIRECT (useful for SUNRPC RDMA)
- misaligned WRITEs currently continue to use normal buffered IO

Q: Why not actually use RWF_DONTCACHE (yet)?
A: 
If IO can is properly DIO-aligned, or can be made to be, using
O_DIRECT is preferred over DONTCACHE because of its reduced CPU and
memory usage.  Relative to NFSD using RWF_DONTCACHE for misaligned
WRITEs, I've briefly discussed with Jens that follow-on dontcache work
is needed to justify falling back to actually using RWF_DONTCACHE.
Specifically, Hammerspace benchmarking has confirmed as Jeff Layton
suggested at Bakeathon, we need dontcache to be enhanced to not
immediately dropbehind when IO completes -- because it works against
us (due to RMW needing to read without benefit of cache), whereas
buffered IO enables misaligned IO to be more performant. Jens thought
that delayed dropbehind is certainly doable but that he needed to
reason through it further (so timing on availability is TBD). As soon
as it is possible I'll happily switch NFSD's misaligned write IO
fallback from normal buffered IO to actually using RWF_DONTCACHE.

Continuing with what this patchset provides:

NFSD now uses STATX_DIOALIGN and STATX_DIO_READ_ALIGN to get and store
DIO alignment attributes from underlying filesystem in associated
nfsd_file.  This is done when the nfsd_file is first opened for a
regular file.

A new RWF_DIRECT flag is added to include/uapi/linux/fs.h to allow
NFSD to use O_DIRECT on a per-IO basis.

If enable-dontcache=1 then RWF_DIRECT will be set for all READ IO
(even if the IO is misaligned, thanks to expanding the read to be
aligned for use with DIO, as suggested by Jeff and Chuck at the NFS
Bakeathon held recently in Ann Arbor).

NFSD will also set RWF_DIRECT if a WRITE's IO is aligned relative to
DIO alignment (both page and disk alignment).  This works quite well
for aligned WRITE IO with SUNRPC's RDMA transport as-is, because it
maps the WRITE payload into aligned pages. But more work is needed to
be able to leverage O_DIRECT when SUNRPC's regular TCP transport is
used. I spent quite a bit of time analyzing the existing xdr_buf code
and NFSD's use of it.  Unfortunately, the WRITE payload gets stored in
misaligned pages such that O_DIRECT isn't possible without a copy
(completely defeating the point).  I'll reply to this cover letter to
start a subthread to discuss how best to deal with misaligned write
IO (by association with Hammerspace, I'm most interested in NFS v3).

Performance benefits of using O_DIRECT in NFSD:

Hammerspace's testbed was 10 NFS servers connected via 800Gbit
RDMA networking (mlx5_core), each with 1TB of memory, 48 cores (2 NUMA
nodes) and 8 ScaleFlux NVMe devices (each with two 3.5TB namespaces.
Theoretical max for reads per NVMe device is 14GB/s, or ~7GB/s per
namespace).

And 10 client systems each running 64 IO threads.

The O_DIRECT performance win is pretty fantastic thanks to reduced CPU
and memory use, particularly for workloads with a working set that far
exceeds the available memory of a given server.  This patchset's
changes (though patch 5, patch 6 wasn't written until after
benchmarking performed) enabled Hammerspace to improve its IO500.org
benchmark result (as submitted for this week's ISC 2025 in Hamburg,
Germany) by 25%.

That 25% improvement on IO500 is owed to NFS servers seeing:
- reduced CPU usage from 100% to ~50%
  O_DIRECT:
  write: 51% idle, 25% system,   14% IO wait,   2% IRQ
  read:  55% idle,  9% system, 32.5% IO wait, 1.5% IRQ
  buffered:
  write: 17.8% idle, 67.5% system,   8% IO wait,  2% IRQ
  read:  3.29% idle, 94.2% system, 2.5% IO wait,  1% IRQ

- reduced memory usage from just under 100% (987GiB for reads, 978GiB
  for writes) to only ~244 MB for cache+buffer use (for both reads and
  writes).
  - buffered would tip-over due to kswapd and kcompactd struggling to
    find free memory during reclaim.

- increased NVMe throughtput when comparing O_DIRECT vs buffered:
  O_DIRECT: 8-10 GB/s for writes, 9-11.8 GB/s for reads
  buffered: 8 GB/s for writes,    4-5 GB/s for reads

- abiliy to support more IO threads per client system (from 48 to 64)

The performance improvement highlight of the numerous individual tests
in the IO500 collection of benchamrks was in the IOR "easy" test:

Write:
O_DIRECT: [RESULT]      ior-easy-write     420.351599 GiB/s : time 869.650 seconds
CACHED:   [RESULT]      ior-easy-write     368.268722 GiB/s : time 413.647 seconds

Read: 
O_DIRECT: [RESULT]      ior-easy-read     446.790791 GiB/s : time 818.219 seconds
CACHED:   [RESULT]      ior-easy-read     284.706196 GiB/s : time 534.950 seconds

It is suspected that patch 6 in this patchset will improve IOR "hard"
read results. The "hard" name comes from the fact that it performs all
IO using a mislaigned blocksize of 47008 bytes (which happens to be
the IO size I showed ftrace output for in the 6th patch's header).

All review and discussion is welcome, thanks!
Mike

Mike Snitzer (6):
  NFSD: add the ability to enable use of RWF_DONTCACHE for all IO
  NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
  NFSD: pass nfsd_file to nfsd_iter_read()
  fs: introduce RWF_DIRECT to allow using O_DIRECT on a per-IO basis
  NFSD: leverage DIO alignment to selectively issue O_DIRECT reads and writes
  NFSD: issue READs using O_DIRECT even if IO is misaligned

 fs/nfsd/debugfs.c          |  39 +++++++++++++
 fs/nfsd/filecache.c        |  32 +++++++++++
 fs/nfsd/filecache.h        |   4 ++
 fs/nfsd/nfs4xdr.c          |   8 +--
 fs/nfsd/nfsd.h             |   1 +
 fs/nfsd/trace.h            |  37 +++++++++++++
 fs/nfsd/vfs.c              | 111 ++++++++++++++++++++++++++++++++++---
 fs/nfsd/vfs.h              |  17 +-----
 include/linux/fs.h         |   2 +-
 include/linux/sunrpc/svc.h |   5 +-
 include/uapi/linux/fs.h    |   5 +-
 11 files changed, 231 insertions(+), 30 deletions(-)

-- 
2.44.0


