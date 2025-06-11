Return-Path: <linux-fsdevel+bounces-51319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BE4AD561E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 14:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592E43A63A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BDE286433;
	Wed, 11 Jun 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFMKbHy0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9188283C8C;
	Wed, 11 Jun 2025 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646523; cv=none; b=Rw5ddkNWuyOZ9PnPGo2z1pMs6vwBSOW8zn+OdqK+u4suX01rO/vUoYDkoyc84gbgb7CMqI2uQLySMjQ1nFz0HfzOOz7vAPbiY1YHdKt28G5HTluhoCiJOyq8Gc0g74JlEcROLPXrpeCuDr1cgm7iAUXFzPbGnxbeXCbjrF9V6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646523; c=relaxed/simple;
	bh=gFVLNaXy50JFUU/l5LL5RCwINIS9m5MvpU/EuFaA50c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WuVfpLo2aM/RE7y5F8yO3NkwTanLU4/SpnMVjxxXV4+m1lIWlJj76XOoOMVuGKo9A1+9TEpOj1o//ji71aTmn+xkhU4xPPIHkhrIbV3DgVulsJMpChcHmgluot59z3F4blqvaPDFdshv68tL7VRvBv7jv4MOmUqlKGDqcTBGpT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFMKbHy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0790FC4CEEE;
	Wed, 11 Jun 2025 12:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749646522;
	bh=gFVLNaXy50JFUU/l5LL5RCwINIS9m5MvpU/EuFaA50c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tFMKbHy0XjDdkv7Wcs2NGFEyZ49ZfbhLoKQh5bKh6GtX3I9fpgc/ZG5ueMTGujgfc
	 orxVVzuSJTjJtcMvspEednDFQDsdpQqTRQKgH2/GBpaFF6iVoTvTjipLDNWTSOzfyg
	 K3Rgi5stEkbwp2+SEy+/FVT7pjEwF0oeek9l74ooLq6ma96bL/uwmkiiIlTCbnsgNp
	 fZQaKPhJHD5oboHiN+7mPVXDCmtxdnA7odcrPa7asmpO63Sizcb03zEsB5wR20gNNp
	 I2FnV0qh9FljI5NtI02A9cDQUTJhjpBMaYerQfRuzczqYBHLVvGJsMWPL9S4CXNy6Z
	 m4nIzp2eFdFsw==
Message-ID: <54acf3548634f5a46fa261fc2ab3fdbf86938c1c.camel@kernel.org>
Subject: Re: [PATCH 0/6] NFSD: add enable-dontcache and initially use it to
 add DIO support
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jens Axboe
	 <axboe@kernel.dk>
Date: Wed, 11 Jun 2025 08:55:20 -0400
In-Reply-To: <20250610205737.63343-1-snitzer@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-10 at 16:57 -0400, Mike Snitzer wrote:
> Hi,
>=20
> This series introduces 'enable-dontcache' to NFSD's debugfs interface,
> once enabled NFSD will selectively make use of O_DIRECT when issuing
> read and write IO:
> - all READs will use O_DIRECT (both aligned and misaligned)
> - all DIO-aligned WRITEs will use O_DIRECT (useful for SUNRPC RDMA)
> - misaligned WRITEs currently continue to use normal buffered IO
>=20
> Q: Why not actually use RWF_DONTCACHE (yet)?
> A:=20
> If IO can is properly DIO-aligned, or can be made to be, using
> O_DIRECT is preferred over DONTCACHE because of its reduced CPU and
> memory usage.  Relative to NFSD using RWF_DONTCACHE for misaligned
> WRITEs, I've briefly discussed with Jens that follow-on dontcache work
> is needed to justify falling back to actually using RWF_DONTCACHE.
> Specifically, Hammerspace benchmarking has confirmed as Jeff Layton
> suggested at Bakeathon, we need dontcache to be enhanced to not
> immediately dropbehind when IO completes -- because it works against
> us (due to RMW needing to read without benefit of cache), whereas
> buffered IO enables misaligned IO to be more performant. Jens thought
> that delayed dropbehind is certainly doable but that he needed to
> reason through it further (so timing on availability is TBD). As soon
> as it is possible I'll happily switch NFSD's misaligned write IO
> fallback from normal buffered IO to actually using RWF_DONTCACHE.
>=20

To be clear, my concern with *_DONTCACHE is this bit in
generic_write_sync():

        } else if (iocb->ki_flags & IOCB_DONTCACHE) {                      =
                        =20
                struct address_space *mapping =3D iocb->ki_filp->f_mapping;=
                          =20
                                                                           =
                        =20
                filemap_fdatawrite_range_kick(mapping, iocb->ki_pos - count=
,                       =20
                                              iocb->ki_pos - 1);           =
                        =20
        }                                                                  =
                        =20
                                                                           =
                        =20
I understand why it was done, but it means that we're kicking off
writeback for small ranges after every write. I think we'd be better
served by allowing for a little batching, and just kick off writeback
(maybe even for the whole inode) after a short delay. IOW, I agree with
Dave Chinner that we need some sort of writebehind window.

The dropbehind part (where we drop it from the pagecache after
writeback completes) is fine, IMO.

> Continuing with what this patchset provides:
>=20
> NFSD now uses STATX_DIOALIGN and STATX_DIO_READ_ALIGN to get and store
> DIO alignment attributes from underlying filesystem in associated
> nfsd_file.  This is done when the nfsd_file is first opened for a
> regular file.
>=20
> A new RWF_DIRECT flag is added to include/uapi/linux/fs.h to allow
> NFSD to use O_DIRECT on a per-IO basis.
>=20
> If enable-dontcache=3D1 then RWF_DIRECT will be set for all READ IO
> (even if the IO is misaligned, thanks to expanding the read to be
> aligned for use with DIO, as suggested by Jeff and Chuck at the NFS
> Bakeathon held recently in Ann Arbor).
>=20
> NFSD will also set RWF_DIRECT if a WRITE's IO is aligned relative to
> DIO alignment (both page and disk alignment).  This works quite well
> for aligned WRITE IO with SUNRPC's RDMA transport as-is, because it
> maps the WRITE payload into aligned pages. But more work is needed to
> be able to leverage O_DIRECT when SUNRPC's regular TCP transport is
> used. I spent quite a bit of time analyzing the existing xdr_buf code
> and NFSD's use of it.  Unfortunately, the WRITE payload gets stored in
> misaligned pages such that O_DIRECT isn't possible without a copy
> (completely defeating the point).  I'll reply to this cover letter to
> start a subthread to discuss how best to deal with misaligned write
> IO (by association with Hammerspace, I'm most interested in NFS v3).
>=20

Tricky problem. svc_tcp_recvfrom() just slurps the whole RPC into the
rq_pages array. To get alignment right, you'd probably have to do the
receive in a much more piecemeal way.

Basically, you'd need to decode as you receive chunks of the message,
and look out for WRITEs, and then set it up so that their payloads are
received with proper alignment.

Anyway, separate thread to discuss that sounds good.
=20
> Performance benefits of using O_DIRECT in NFSD:
>=20
> Hammerspace's testbed was 10 NFS servers connected via 800Gbit
> RDMA networking (mlx5_core), each with 1TB of memory, 48 cores (2 NUMA
> nodes) and 8 ScaleFlux NVMe devices (each with two 3.5TB namespaces.
> Theoretical max for reads per NVMe device is 14GB/s, or ~7GB/s per
> namespace).
>=20
> And 10 client systems each running 64 IO threads.
>=20
> The O_DIRECT performance win is pretty fantastic thanks to reduced CPU
> and memory use, particularly for workloads with a working set that far
> exceeds the available memory of a given server.  This patchset's
> changes (though patch 5, patch 6 wasn't written until after
> benchmarking performed) enabled Hammerspace to improve its IO500.org
> benchmark result (as submitted for this week's ISC 2025 in Hamburg,
> Germany) by 25%.
>=20
> That 25% improvement on IO500 is owed to NFS servers seeing:
> - reduced CPU usage from 100% to ~50%
>   O_DIRECT:
>   write: 51% idle, 25% system,   14% IO wait,   2% IRQ
>   read:  55% idle,  9% system, 32.5% IO wait, 1.5% IRQ
>   buffered:
>   write: 17.8% idle, 67.5% system,   8% IO wait,  2% IRQ
>   read:  3.29% idle, 94.2% system, 2.5% IO wait,  1% IRQ
>=20
> - reduced memory usage from just under 100% (987GiB for reads, 978GiB
>   for writes) to only ~244 MB for cache+buffer use (for both reads and
>   writes).
>   - buffered would tip-over due to kswapd and kcompactd struggling to
>     find free memory during reclaim.
>=20
> - increased NVMe throughtput when comparing O_DIRECT vs buffered:
>   O_DIRECT: 8-10 GB/s for writes, 9-11.8 GB/s for reads
>   buffered: 8 GB/s for writes,    4-5 GB/s for reads
>=20
> - abiliy to support more IO threads per client system (from 48 to 64)
>=20
> The performance improvement highlight of the numerous individual tests
> in the IO500 collection of benchamrks was in the IOR "easy" test:
>=20
> Write:
> O_DIRECT: [RESULT]      ior-easy-write     420.351599 GiB/s : time 869.65=
0 seconds
> CACHED:   [RESULT]      ior-easy-write     368.268722 GiB/s : time 413.64=
7 seconds
>=20
> Read:=20
> O_DIRECT: [RESULT]      ior-easy-read     446.790791 GiB/s : time 818.219=
 seconds
> CACHED:   [RESULT]      ior-easy-read     284.706196 GiB/s : time 534.950=
 seconds
>=20

Wow!

> It is suspected that patch 6 in this patchset will improve IOR "hard"
> read results. The "hard" name comes from the fact that it performs all
> IO using a mislaigned blocksize of 47008 bytes (which happens to be
> the IO size I showed ftrace output for in the 6th patch's header).
>=20
> All review and discussion is welcome, thanks!
> Mike
>=20
> Mike Snitzer (6):
>   NFSD: add the ability to enable use of RWF_DONTCACHE for all IO
>   NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
>   NFSD: pass nfsd_file to nfsd_iter_read()
>   fs: introduce RWF_DIRECT to allow using O_DIRECT on a per-IO basis
>   NFSD: leverage DIO alignment to selectively issue O_DIRECT reads and wr=
ites
>   NFSD: issue READs using O_DIRECT even if IO is misaligned
>=20
>  fs/nfsd/debugfs.c          |  39 +++++++++++++
>  fs/nfsd/filecache.c        |  32 +++++++++++
>  fs/nfsd/filecache.h        |   4 ++
>  fs/nfsd/nfs4xdr.c          |   8 +--
>  fs/nfsd/nfsd.h             |   1 +
>  fs/nfsd/trace.h            |  37 +++++++++++++
>  fs/nfsd/vfs.c              | 111 ++++++++++++++++++++++++++++++++++---
>  fs/nfsd/vfs.h              |  17 +-----
>  include/linux/fs.h         |   2 +-
>  include/linux/sunrpc/svc.h |   5 +-
>  include/uapi/linux/fs.h    |   5 +-
>  11 files changed, 231 insertions(+), 30 deletions(-)

--=20
Jeff Layton <jlayton@kernel.org>

