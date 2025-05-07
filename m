Return-Path: <linux-fsdevel+bounces-48310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 581F6AAD1D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 02:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAFE77B3393
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 00:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AB629A0;
	Wed,  7 May 2025 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk3MN9+b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C145623;
	Wed,  7 May 2025 00:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746576414; cv=none; b=BVZv0nJc78bPBfmmKxlhL1dBheISKPI8j+RO86egNzeuzvwlQyb6UPmXICa72d06PDwkdI34/BttYuvzONtLyA3GdxX8mPjoRq4MRUtvU2BjK+YI65FYGGn6yl5LdQTXE4A+wEK1QJfs38UEb3ITL+KQnOV9AEFHNsDFFMdLKGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746576414; c=relaxed/simple;
	bh=Up31LBLuTDys2yDLiDe+MkKJLJdnOgrUgt7tjzyHyxQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lidnGac3koY7xgVPvyMihJ4Vsgvz5UYbdUYRAxsg/t0YN/vvG/ay4pOrkrVS4m99Bghf1aM2yixWPxCA3rtQcLX7ydAAr8gRdEXZcbKy6G+AX0DdAp1/9E7GuKyJ81NHM7khCy5YQgkNghAEpZMq1Q6LPPeSgksqlURXPpsIUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk3MN9+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AC5C4CEE4;
	Wed,  7 May 2025 00:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746576413;
	bh=Up31LBLuTDys2yDLiDe+MkKJLJdnOgrUgt7tjzyHyxQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Qk3MN9+bhfWQi4EjwjOb61V9FdHjEpEoiv3mCPPvRKSw6KYgiWOer/JpqfgOtfsfB
	 Rp3Qay+Ojzj8sGQ1JskMhViX4tb3581ndnV7lPxZD7ImmusbT6D0PrBhGH1UrqNxhK
	 e6p7+0mekSWWUYbJVv163Z+qCTxUqVV39inMBPWCPpdRCY3vCndq7z0bRm4zZ8VsBn
	 mc/KouauEJCt/7c4pkSXFWKyGfZKtkW5X9khex9vuGxkNqrVAqQnDYz7H4dVLGZe/N
	 t6Go+sKo1F3Jv3yt2vFPTRzD+ys7hBEafInoTZT0YDZJMKZUxUUoewQZfoM/zzxJA+
	 aQB6TocGQ7YoA==
Message-ID: <8039661b7a4c4f10452180372bd985c0440f1e1d.camel@kernel.org>
Subject: Re: performance r nfsd with RWF_DONTCACHE and larger wsizes
From: Jeff Layton <jlayton@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, Chuck Lever	
 <chuck.lever@oracle.com>, Mike Snitzer <snitzer@kernel.org>, Trond
 Myklebust	 <trondmy@hammerspace.com>, Jens Axboe <axboe@kernel.dk>, Chris
 Mason	 <clm@meta.com>, Anna Schumaker <anna@kernel.org>
Date: Tue, 06 May 2025 20:06:51 -0400
In-Reply-To: <aBqNtfPwFBvQCgeT@dread.disaster.area>
References: <370dd4ae06d44f852342b7ee2b969fc544bd1213.camel@kernel.org>
	 <aBqNtfPwFBvQCgeT@dread.disaster.area>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-07 at 08:31 +1000, Dave Chinner wrote:
> On Tue, May 06, 2025 at 01:40:35PM -0400, Jeff Layton wrote:
> > FYI I decided to try and get some numbers with Mike's RWF_DONTCACHE
> > patches for nfsd [1]. Those add a module param that make all reads and
> > writes use RWF_DONTCACHE.
> >=20
> > I had one host that was running knfsd with an XFS export, and a second
> > that was acting as NFS client. Both machines have tons of memory, so
> > pagecache utilization is irrelevant for this test.
>=20
> Does RWF_DONTCACHE result in server side STABLE write requests from
> the NFS client, or are they still unstable and require a post-write
> completion COMMIT operation from the client to trigger server side
> writeback before the client can discard the page cache?
>=20

The latter. I didn't change the client at all here (other than to allow
it to do bigger writes on the wire). It's just doing bog-standard
buffered I/O. nfsd is adding RWF_DONTCACHE to every write via Mike's
patch.

> > I tested sequential writes using the fio-seq_write.fio test, both with
> > and without the module param enabled.
> >=20
> > These numbers are from one run each, but they were pretty stable over
> > several runs:
> >=20
> > # fio /usr/share/doc/fio/examples/fio-seq-write.fio
>=20
> $ cat /usr/share/doc/fio/examples/fio-seq-write.fio
> cat: /usr/share/doc/fio/examples/fio-seq-write.fio: No such file or direc=
tory
> $
>=20
> What are the fio control parameters of the IO you are doing? (e.g.
> is this single threaded IO, does it use the psync, libaio or iouring
> engine, etc)
>=20


; fio-seq-write.job for fiotest

[global]
name=3Dfio-seq-write
filename=3Dfio-seq-write
rw=3Dwrite
bs=3D256K
direct=3D0
numjobs=3D1
time_based
runtime=3D900

[file1]
size=3D10G
ioengine=3Dlibaio
iodepth=3D16


> > wsize=3D1M:
> >=20
> > Normal:      WRITE: bw=3D1034MiB/s (1084MB/s), 1034MiB/s-1034MiB/s (108=
4MB/s-1084MB/s), io=3D910GiB (977GB), run=3D901326-901326msec
> > DONTCACHE:   WRITE: bw=3D649MiB/s (681MB/s), 649MiB/s-649MiB/s (681MB/s=
-681MB/s), io=3D571GiB (613GB), run=3D900001-900001msec
> >=20
> > DONTCACHE with a 1M wsize vs. recent (v6.14-ish) knfsd was about 30%
> > slower. Memory consumption was down, but these boxes have oodles of
> > memory, so I didn't notice much change there.
>=20
> So what is the IO pattern that the NFSD is sending to the underlying
> XFS filesystem?
>=20
> Is it sending 1M RWF_DONTCACHE buffered IOs to XFS as well (i.e. one
> buffered write IO per NFS client write request), or is DONTCACHE
> only being used on the NFS client side?
>=20

It's should be sequential I/O, though the writes would be coming in
from different nfsd threads. nfsd just does standard buffered I/O. The
WRITE handler calls nfsd_vfs_write(), which calls vfs_write_iter().
With the module parameter enabled, it also adds RWF_DONTCACHE.

DONTCACHE is only being used on the server side. To be clear, the
protocol doesn't support that flag (yet), so we have no way to project
DONTCACHE from the client to the server (yet). This is just early
exploration to see whether DONTCACHE offers any benefit to this
workload.

> > I wonder if we need some heuristic that makes generic_write_sync() only
> > kick off writeback immediately if the whole folio is dirty so we have
> > more time to gather writes before kicking off writeback?
>=20
> You're doing aligned 1MB IOs - there should be no partially dirty
> large folios in either the client or the server page caches.
>=20

Interesting. I wonder what accounts for the slowdown with 1M writes? It
seems likely to be related to the more aggressive writeback with
DONTCACHE enabled, but it'd be good to understand this.

> That said, this is part of the reason I asked about both whether the
> client side write is STABLE and  whether RWF_DONTCACHE on
> the server side. i.e. using either of those will trigger writeback
> on the serer side immediately; in the case of the former it will
> also complete before returning to the client and not require a
> subsequent COMMIT RPC to wait for server side IO completion...
>=20

I need to go back and sniff traffic to be sure, but I'm fairly certain
the client is issuing regular UNSTABLE writes and following up with a
later COMMIT, at least for most of them. The occasional STABLE write
might end up getting through, but that should be fairly rare.

--=20
Jeff Layton <jlayton@kernel.org>

