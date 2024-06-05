Return-Path: <linux-fsdevel+bounces-21035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036798FC9A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 13:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3E6284E75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 11:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79ED1922E9;
	Wed,  5 Jun 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+UYPUTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720A4146017
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585477; cv=none; b=K0FYrIEqQwFyQQgQwUDC+L5Di9btGRmLqU1DkwLvIyMzkU1dC97wkOiLsYe5b/1UBVYfofPPiq7kF7EP63wTxqo8VNMGyLLkrQyFEXPX4S0sqchGxrDR93Iw1B5K+YH1DOJrpRMF/Aaa+7+vd1ByKPIV/+cO4tCegTOS2aclHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585477; c=relaxed/simple;
	bh=aacbWcBdmej5VM/1HQcinIqRHUX3BrAjJvVP8miwrcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asy5vLphOeZoaVgtRigaz4enQnl5ds0SoaeJLOieaT65nMxyT1DdbbDZxGOZxGlShaO3ogQXAa9lu/OuYnP3hCBluCeaCMjTTT2NP4bECbfZU2T2XwLx3x+z3GbMAJHjpQ+uBbweiVENjPWF+v0VdsG47juX96QAOuYcXpmkrNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+UYPUTm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717585473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERhPWPhucZxJF11EopTAywzmhEWvAHMOqkMcgq9R5o8=;
	b=i+UYPUTmlq8NgurG6kArzxoTHFfkpk3Q+3q9OZyP/FKz18vTSGBkXYtMWMFXxv+H1dcAkn
	e2vK8ppiOY8iC+JRrvIo976WoxmKb407WekA3/YGQ08kQtXmVLJV2VIjhNq/63FLZzMPwe
	GvvfDOuni/X1efNQ9SIA2tnxD3sodzw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-kS3eThQCOW-jNDUfnSoyIw-1; Wed,
 05 Jun 2024 07:04:29 -0400
X-MC-Unique: kS3eThQCOW-jNDUfnSoyIw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CADD1955D9A;
	Wed,  5 Jun 2024 11:04:27 +0000 (UTC)
Received: from localhost (unknown [10.39.195.133])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B9E11955F79;
	Wed,  5 Jun 2024 11:04:25 +0000 (UTC)
Date: Wed, 5 Jun 2024 07:04:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Cc: "mszeredi@redhat.com" <mszeredi@redhat.com>,
	Idan Zach <izach@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"vgoyal@redhat.com" <vgoyal@redhat.com>,
	Oren Duer <oren@nvidia.com>, Yoray Zack <yorayz@nvidia.com>
Subject: Re: [PATCH] fuse: cleanup request queuing towards virtiofs
Message-ID: <20240605110423.GA135899@fedora.redhat.com>
References: <20240529155210.2543295-1-mszeredi@redhat.com>
 <20240529183231.GC1203999@fedora.redhat.com>
 <02a56c0d80c2fab16b7d3b536727ff6865aded40.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nmOucSGHiJiHzIv5"
Content-Disposition: inline
In-Reply-To: <02a56c0d80c2fab16b7d3b536727ff6865aded40.camel@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


--nmOucSGHiJiHzIv5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 10:40:44AM +0000, Peter-Jan Gootzen wrote:
> On Wed, 2024-05-29 at 14:32 -0400, Stefan Hajnoczi wrote:
> > On Wed, May 29, 2024 at 05:52:07PM +0200, Miklos Szeredi wrote:
> > > Virtiofs has its own queing mechanism, but still requests are first
> > > queued
> > > on fiq->pending to be immediately dequeued and queued onto the
> > > virtio
> > > queue.
> > >=20
> > > The queuing on fiq->pending is unnecessary and might even have some
> > > performance impact due to being a contention point.
> > >=20
> > > Forget requests are handled similarly.
> > >=20
> > > Move the queuing of requests and forgets into the fiq->ops->*.
> > > fuse_iqueue_ops are renamed to reflect the new semantics.
> > >=20
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > ---
> > > =A0fs/fuse/dev.c=A0=A0=A0=A0=A0=A0 | 159 ++++++++++++++++++++++++----=
-------------
> > > ---
> > > =A0fs/fuse/fuse_i.h=A0=A0=A0 |=A0 19 ++----
> > > =A0fs/fuse/virtio_fs.c |=A0 41 ++++--------
> > > =A03 files changed, 106 insertions(+), 113 deletions(-)
> >=20
> > This is a little scary but I can't think of a scenario where directly
> > dispatching requests to virtqueues is a problem.
> >=20
> > Is there someone who can run single and multiqueue virtiofs
> > performance
> > benchmarks?
> >=20
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> I ran some tests and experiments on the patch (on top of v6.10-rc2) with
> our multi-queue capable virtio-fs device. No issues were found.
>=20
> Experimental system setup (which is not the fastest possible setup nor
> the most optimized setup!):
> # Host:
>    - Dell PowerEdge R7525
>    - CPU: 2x AMD EPYC 7413 24-Core
>    - VM: QEMU KVM with 24 cores, vCPUs locked to the NUMA nodes on which
> the DPU is attached. VFIO-pci device to passthrough the DPU.          =20
> Running a default x86_64 ext4 buildroot with fio installed.
> # Virtio-fs device:
>    - BlueField-3 DPU
>    - CPU: ARM Cortex-A78AE, 16 cores
>    - One thread per queue, each busy polling on one request queue
>    - Each queue is 1024 descriptors deep
> # Workload (deviations are specified in the table):
>    - fio 3.34
>    - sequential read
>    - ioengine=3Dio_uring, single 4GiB file, iodepth=3D128, bs=3D256KiB,  =
 =20
> runtime=3D30s, ramp_time=3D10s, direct=3D1
>    - T is the number of threads (numjobs=3DT with thread=3D1)
>    - Q is the number of request queues
>=20
> | Workload           | Before patch | After patch |
> | ------------------ | ------------ | ----------- |
> | T=3D1 Q=3D1            | 9216MiB/s    | 9201MiB/s   |
> | T=3D2 Q=3D2            | 10.8GiB/s    | 10.7GiB/s   |
> | T=3D4 Q=3D4            | 12.6GiB/s    | 12.2GiB/s   |
> | T=3D8 Q=3D8            | 19.5GiB/s    | 19.7GiB/s   |
> | T=3D16 Q=3D1           | 9451MiB/s    | 9558MiB/s   |
> | T=3D16 Q=3D2           | 13.5GiB/s    | 13.4GiB/s   |
> | T=3D16 Q=3D4           | 11.8GiB/s    | 11.4GiB/s   |
> | T=3D16 Q=3D8           | 11.1GiB/s    | 10.8GiB/s   |
> | T=3D24 Q=3D24          | 26.5GiB/s    | 26.5GiB/s   |
> | T=3D24 Q=3D24 24 files | 26.5GiB/s    | 26.6GiB/s   |
> | T=3D24 Q=3D24 4k       | 948MiB/s     | 955MiB/s    |
>=20
> Averaging out those results, the difference is within a reasonable
> margin of a error (less than 1%). So in this setup's
> case we see no difference in performance.
> However if the virtio-fs device was more optimized, e.g. if it didn't
> copy the data to its memory, then the bottleneck could possibly be on
> the driver-side and this patch could show some benefit at those higher
> message rates.
>=20
> So although I would have hoped for some performance increase already
> with this setup, I still think this is a good patch and a logical
> optimization for high performance virtio-fs devices that might show a
> benefit in the future.
>=20
> Tested-by: Peter-Jan Gootzen <pgootzen@nvidia.com>
> Reviewed-by: Peter-Jan Gootzen <pgootzen@nvidia.com>

Thank you!

Stefan


--nmOucSGHiJiHzIv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZgRjcACgkQnKSrs4Gr
c8iyCggAhkhXMzDotyA6BkP9KLtvG2AhuoWCtTHYJGxlK2Pn3zREK1/ZJBRzCOD1
U+5Cgc+XkDThFmX7yTO5FDuXl/af/e4r1mxYV7a7mXH7o8bU1j5YtmiaDh0b7mWJ
TDmpzZukIp+dMuW8SgUuf4JQKSDal3NioybeZ+69l95RIKfFL4wOxX/tNrcAtDZj
69yYFXNuND/k1knDUXieodeU8zIh0AA32ym7WgVeJ1yFBWnv1phxxRxijWQoc+4I
EA7xgnJlLLwgK9xsUor48i/8oSmgltg4hAKB4M4sf+Buguy9ar7jSHcNzMkDIsN5
nRCXsFy17X+R46IZtTjGjPabatbrmg==
=Oh6C
-----END PGP SIGNATURE-----

--nmOucSGHiJiHzIv5--


