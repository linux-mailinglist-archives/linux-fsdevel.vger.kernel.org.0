Return-Path: <linux-fsdevel+bounces-64226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1296BDDDF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 11:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F246719C0687
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C7831B82F;
	Wed, 15 Oct 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aXJcYMH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0CA31B805
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521867; cv=none; b=RPhQ0xG7ERNDbFEQ2ZuQ7awb89QxnLqLOHZ3t9tYXGVIeQKNRZ4j1tg3PtaenDPpPdzIoFPrP4xQ4qPGK1mRLtBcZQsqULlAnle6LYS7TFjiPNjicSj35EMazLNpf5Tb+Q7bWaxCTx9ROkN7UPk0djP3D6F5ESWTDTT/vPgvwas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521867; c=relaxed/simple;
	bh=S+r37k3716aZbG2XBLl1dcrBNLGiHqP31cseayC3Gfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KoBybtunnAGAxh4ZJ7MyCB1MGUKYrR1gr5NAOYfQdWUmFo+h3yKV4h8S+HwDSK/PsAAHssUv77apReom5+3qi/Xp+LcVgAFsZ3LzyEhCqCq3Foipys28vJcZe2XUibQOMCIO1NF0oRuxEjMx/UwvCXRDGLGXHRbe/uWNphxeMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=aXJcYMH0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=C4xJMYQpX+/zmxD+4Pe0CbIs9zG4h5hVztlMbXOAjio=; b=aXJcYMH0r7S1JZt9/qI4w4/Bya
	VFszICcljAdgyE29DzJVR7PqHZdC1lmbsHMja6QrUHtg+ilhyIs7mC+qBwgRWHtFtU6mGcBGYP0VF
	Oco10SnQG4t35/qYjEINo6rzKfdRLuulHUN2CthCnvj+46MSKUnjbBQ9TFTxT1uSOczG8w0aGUi0m
	ChLR+bTgahsxgmWa58nZ8BtjdZlSD9pV8xU5JmFHkytNdGMH+EMSaeAcA3Ae/0o2TorccoEPLC9OU
	/Ht0xYC0uUeFfls3NuYE8qT6mls4srQxmC7sMlGIzxXfqeReRYN0aYtVLcCSamDzf4B41Rlc5NhTe
	Ot6t1Wjw==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v8y9q-009svO-Kj; Wed, 15 Oct 2025 11:50:58 +0200
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Joanne Koong
 <joannelkoong@gmail.com>,  linux-fsdevel@vger.kernel.org,  Gang He
 <dchg2000@gmail.com>
Subject: Re: [PATCH v3 6/6] fuse: {io-uring} Queue background requests on a
 different core
In-Reply-To: <20251013-reduced-nr-ring-queues_3-v3-6-6d87c8aa31ae@ddn.com>
	(Bernd Schubert's message of "Mon, 13 Oct 2025 19:10:02 +0200")
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
	<20251013-reduced-nr-ring-queues_3-v3-6-6d87c8aa31ae@ddn.com>
Date: Wed, 15 Oct 2025 10:50:58 +0100
Message-ID: <87jz0w8pdp.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13 2025, Bernd Schubert wrote:

> Running background IO on a different core makes quite a difference.
>
> fio --directory=3D/tmp/dest --name=3Diops.\$jobnum --rw=3Drandread \
> --bs=3D4k --size=3D1G --numjobs=3D1 --iodepth=3D4 --time_based\
> --runtime=3D30s --group_reporting --ioengine=3Dio_uring\
>  --direct=3D1
>
> unpatched
>    READ: bw=3D272MiB/s (285MB/s), 272MiB/s-272MiB/s ...
> patched
>    READ: bw=3D760MiB/s (797MB/s), 760MiB/s-760MiB/s ...
>
> With --iodepth=3D8
>
> unpatched
>    READ: bw=3D466MiB/s (489MB/s), 466MiB/s-466MiB/s ...
> patched
>    READ: bw=3D966MiB/s (1013MB/s), 966MiB/s-966MiB/s ...
> 2nd run:
>    READ: bw=3D1014MiB/s (1064MB/s), 1014MiB/s-1014MiB/s ...
>
> Without io-uring (--iodepth=3D8)
>    READ: bw=3D729MiB/s (764MB/s), 729MiB/s-729MiB/s ...
>
> Without fuse (--iodepth=3D8)
>    READ: bw=3D2199MiB/s (2306MB/s), 2199MiB/s-2199MiB/s ...
>
> (Test were done with
> <libfuse>/example/passthrough_hp -o allow_other --nopassthrough  \
> [-o io_uring] /tmp/source /tmp/dest
> )
>
> Additional notes:
>
> With FURING_NEXT_QUEUE_RETRIES=3D0 (--iodepth=3D8)
>    READ: bw=3D903MiB/s (946MB/s), 903MiB/s-903MiB/s ...
>
> With just a random qid (--iodepth=3D8)
>    READ: bw=3D429MiB/s (450MB/s), 429MiB/s-429MiB/s ...
>
> With --iodepth=3D1
> unpatched
>    READ: bw=3D195MiB/s (204MB/s), 195MiB/s-195MiB/s ...
> patched
>    READ: bw=3D232MiB/s (243MB/s), 232MiB/s-232MiB/s ...
>
> With --iodepth=3D1 --numjobs=3D2
> unpatched
>    READ: bw=3D966MiB/s (1013MB/s), 966MiB/s-966MiB/s ...
> patched
>    READ: bw=3D1821MiB/s (1909MB/s), 1821MiB/s-1821MiB/s ...
>
> With --iodepth=3D1 --numjobs=3D8
> unpatched
>    READ: bw=3D1138MiB/s (1193MB/s), 1138MiB/s-1138MiB/s ...
> patched
>    READ: bw=3D1650MiB/s (1730MB/s), 1650MiB/s-1650MiB/s ...
> fuse without io-uring
>    READ: bw=3D1314MiB/s (1378MB/s), 1314MiB/s-1314MiB/s ...
> no-fuse
>    READ: bw=3D2566MiB/s (2690MB/s), 2566MiB/s-2566MiB/s ...
>
> In summary, for async requests the core doing application IO is busy
> sending requests and processing IOs should be done on a different core.
> Spreading the load on random cores is also not desirable, as the core
> might be frequency scaled down and/or in C1 sleep states. Not shown here,
> but differnces are much smaller when the system uses performance govenor
> instead of schedutil (ubuntu default). Obviously at the cost of higher
> system power consumption for performance govenor - not desirable either.
>
> Results without io-uring (which uses fixed libfuse threads per queue)
> heavily depend on the current number of active threads. Libfuse uses
> default of max 10 threads, but actual nr max threads is a parameter.
> Also, no-fuse-io-uring results heavily depend on, if there was already
> running another workload before, as libfuse starts these threads
> dynamically - i.e. the more threads are active, the worse the
> performance.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev_uring.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 46 insertions(+), 7 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index aca71ce5632efd1d80e3ac0ad4e81ac1536dbc47..f35dd98abfe6407849fec5584=
7c6b3d186383803 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -23,6 +23,7 @@ MODULE_PARM_DESC(enable_uring,
>  #define FURING_Q_LOCAL_THRESHOLD 2
>  #define FURING_Q_NUMA_THRESHOLD (FURING_Q_LOCAL_THRESHOLD + 1)
>  #define FURING_Q_GLOBAL_THRESHOLD (FURING_Q_LOCAL_THRESHOLD * 2)
> +#define FURING_NEXT_QUEUE_RETRIES 2

Some bikeshedding:

Maybe that's just me, but I associate the names above (FURING_*) to 'fur'
-- the action of making 'fur'.  I'm not sure that verb even exists, but my
brain makes me dislike those names :-)

But I'm not a native speaker, and I don't have any other objection to
those names rather than "I don't like fur!" so feel free to ignore me. :-)

>=20=20
>  bool fuse_uring_enabled(void)
>  {
> @@ -1302,12 +1303,15 @@ static struct fuse_ring_queue *fuse_uring_best_qu=
eue(const struct cpumask *mask,
>  /*
>   * Get the best queue for the current CPU
>   */
> -static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ri=
ng)
> +static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ri=
ng,
> +						    bool background)
>  {
>  	unsigned int qid;
>  	struct fuse_ring_queue *local_queue, *best_numa, *best_global;
>  	int local_node;
>  	const struct cpumask *numa_mask, *global_mask;
> +	int retries =3D 0;
> +	int weight =3D -1;
>=20=20
>  	qid =3D task_cpu(current);
>  	if (WARN_ONCE(qid >=3D ring->max_nr_queues,
> @@ -1315,16 +1319,50 @@ static struct fuse_ring_queue *fuse_uring_get_que=
ue(struct fuse_ring *ring)
>  		      ring->max_nr_queues))
>  		qid =3D 0;
>=20=20
> -	local_queue =3D READ_ONCE(ring->queues[qid]);
>  	local_node =3D cpu_to_node(qid);
>  	if (WARN_ON_ONCE(local_node > ring->nr_numa_nodes))
>  		local_node =3D 0;
>=20=20
> -	/* Fast path: if local queue exists and is not overloaded, use it */
> -	if (local_queue &&
> -	    READ_ONCE(local_queue->nr_reqs) <=3D FURING_Q_LOCAL_THRESHOLD)
> +	local_queue =3D READ_ONCE(ring->queues[qid]);
> +
> +retry:
> +	/*
> +	 * For background requests, try next CPU in same NUMA domain.
> +	 * I.e. cpu-0 creates async requests, cpu-1 io processes.
> +	 * Similar for foreground requests, when the local queue does not
> +	 * exist - still better to always wake the same cpu id.
> +	 */
> +	if (background || !local_queue) {
> +		numa_mask =3D ring->numa_registered_q_mask[local_node];
> +
> +		if (weight =3D=3D -1)
> +			weight =3D cpumask_weight(numa_mask);
> +
> +		if (weight =3D=3D 0)
> +			goto global;
> +
> +		if (weight > 1) {
> +			int idx =3D (qid + 1) % weight;
> +
> +			qid =3D cpumask_nth(idx, numa_mask);
> +		} else {
> +			qid =3D cpumask_first(numa_mask);
> +		}
> +
> +		local_queue =3D READ_ONCE(ring->queues[qid]);
> +		if (WARN_ON_ONCE(!local_queue))
> +			return NULL;
> +	}
> +
> +	if (READ_ONCE(local_queue->nr_reqs) <=3D FURING_Q_NUMA_THRESHOLD)
>  		return local_queue;
>=20=20
> +	if (retries < FURING_NEXT_QUEUE_RETRIES && weight > retries + 1) {
> +		retries++;
> +		local_queue =3D NULL;
> +		goto retry;
> +	}
> +

I wonder if this retry loop is really useful.  If I understand this
correctly, we're doing a busy loop, hoping for a better queue to become
available.  But if the system is really busy doing IO this retry loop will
most of the times fail and will fall back to the next option -- only once
in a while we will get a better one.

Do you have evidence that this could be helpful?  Or am I misunderstanding
the purpose of this retry loop?

Cheers,
--=20
Lu=C3=ADs

>=20
>  	/* Find best NUMA-local queue */
>  	numa_mask =3D ring->numa_registered_q_mask[local_node];
>  	best_numa =3D fuse_uring_best_queue(numa_mask, ring);
> @@ -1334,6 +1372,7 @@ static struct fuse_ring_queue *fuse_uring_get_queue=
(struct fuse_ring *ring)
>  	    READ_ONCE(best_numa->nr_reqs) <=3D FURING_Q_NUMA_THRESHOLD)
>  		return best_numa;
>=20=20
> +global:
>  	/* NUMA queues above threshold, try global queues */
>  	global_mask =3D ring->registered_q_mask;
>  	best_global =3D fuse_uring_best_queue(global_mask, ring);
> @@ -1368,7 +1407,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *=
fiq, struct fuse_req *req)
>  	int err;
>=20=20
>  	err =3D -EINVAL;
> -	queue =3D fuse_uring_get_queue(ring);
> +	queue =3D fuse_uring_get_queue(ring, false);
>  	if (!queue)
>  		goto err;
>=20=20
> @@ -1412,7 +1451,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>  	struct fuse_ring_queue *queue;
>  	struct fuse_ring_ent *ent =3D NULL;
>=20=20
> -	queue =3D fuse_uring_get_queue(ring);
> +	queue =3D fuse_uring_get_queue(ring, true);
>  	if (!queue)
>  		return false;
>=20=20
>
> --=20
> 2.43.0
>


