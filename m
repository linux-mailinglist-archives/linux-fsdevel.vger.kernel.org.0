Return-Path: <linux-fsdevel+bounces-63459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F325BBD854
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 11:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98553B9C26
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 09:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C49B2135AD;
	Mon,  6 Oct 2025 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eOUo9vJm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD80212546
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744458; cv=none; b=gKNrOJ21Qqn+PTuHjVq5x3oACFfkDncfpsO18nhgZQv3KyYEbWFPx3FiZCK0qcTBJ1Zir/LDBBXLr3th7/MieoFzPXdN05QFhSq4YmlScweqy4zyGNZrKD/0zd39OQceUuBCTalpe30hhDW7EDVnqzAANG7Wmde5Razux4rf3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744458; c=relaxed/simple;
	bh=akNrM7++aRw9u4eBDhm9xCnL/bK//DLcxj/PeLViLTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hPeeOvgC9Lv96yTizCs+pEp9u6WHU8BdPloNIb/kXP82Sj5MPba/77uZDNQNmZABoOD6zksCqMfX2sl5mldIOWlWowcBtCODF+ihpcHKCLgo8JISYC7Kyk6eH14uBK9ygYaRVmxhCSDPqVFbFucB3420mI0gc/l16ShbFV33Rb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eOUo9vJm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uG57dcu+vI3dyGnXVF4SS6xUmbdA5xvT+PrmlV09mR4=; b=eOUo9vJmbu3/1RIl106E+MjBMr
	G2/pQeU/QMnYG3GDaUmt9EMFoDdwAa1ljB06IDYx5H/j1hugqTIopR9poJtrdB5q+WdliweJbCTa9
	0vzOh4ZbYbxOGFkUoTcokpczt6d3FMfBmaS2NNEsiArRLwfx/jNA8KjpEOmTwKIVXjeaCWIgx0j8Q
	WHiMIPRVt9Mk3UbK0bsZGqjxw3Xy6Eze1vaeCf1f/UNLvG4y8Z0tk7XUEO07IzVdI6dQH0ivjEOkq
	Fawm6k9MjVbgldjGk0jNk0DnV6OlBPzz47ByPriWHWFrUVDve6/Bogz0N9/CYNY4CHUbWU3q48oqc
	siq/Br6Q==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v5hup-005J1l-9M; Mon, 06 Oct 2025 11:53:59 +0200
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Ingo Molnar <mingo@redhat.com>,
  Peter Zijlstra <peterz@infradead.org>,  Juri Lelli
 <juri.lelli@redhat.com>,  Vincent Guittot <vincent.guittot@linaro.org>,
  Dietmar Eggemann <dietmar.eggemann@arm.com>,  Steven Rostedt
 <rostedt@goodmis.org>,  Ben Segall <bsegall@google.com>,  Mel Gorman
 <mgorman@suse.de>,  Valentin Schneider <vschneid@redhat.com>,  Joanne
 Koong <joannelkoong@gmail.com>,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] fuse: {io-uring} Queue background requests on a
 different core
In-Reply-To: <20251003-reduced-nr-ring-queues_3-v2-6-742ff1a8fc58@ddn.com>
	(Bernd Schubert's message of "Fri, 03 Oct 2025 12:06:47 +0200")
References: <20251003-reduced-nr-ring-queues_3-v2-0-742ff1a8fc58@ddn.com>
	<20251003-reduced-nr-ring-queues_3-v2-6-742ff1a8fc58@ddn.com>
Date: Mon, 06 Oct 2025 10:53:58 +0100
Message-ID: <87frbwe4p5.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03 2025, Bernd Schubert wrote:

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
>  fs/fuse/dev_uring.c | 61 +++++++++++++++++++++++++++++++++++++++++++----=
------
>  1 file changed, 50 insertions(+), 11 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index f5946bb1bbea930522921d49c04e047c70d21ee2..296592fe3651926ab4982b8d8=
0694b3dac8bbffa 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -22,6 +22,7 @@ MODULE_PARM_DESC(enable_uring,
>  #define FURING_Q_LOCAL_THRESHOLD 2
>  #define FURING_Q_NUMA_THRESHOLD (FURING_Q_LOCAL_THRESHOLD + 1)
>  #define FURING_Q_GLOBAL_THRESHOLD (FURING_Q_LOCAL_THRESHOLD * 2)
> +#define FURING_NEXT_QUEUE_RETRIES 2
>=20=20
>  bool fuse_uring_enabled(void)
>  {
> @@ -1262,7 +1263,8 @@ static void fuse_uring_send_in_task(struct io_uring=
_cmd *cmd,
>   *  (Michael David Mitzenmacher, 1991)
>   */
>  static struct fuse_ring_queue *fuse_uring_best_queue(const struct cpumas=
k *mask,
> -						     struct fuse_ring *ring)
> +						     struct fuse_ring *ring,
> +						     bool background)
>  {
>  	unsigned int qid1, qid2;
>  	struct fuse_ring_queue *queue1, *queue2;
> @@ -1277,9 +1279,14 @@ static struct fuse_ring_queue *fuse_uring_best_que=
ue(const struct cpumask *mask,
>  	}
>=20=20
>  	/* Get two different queues using optimized bounded random */
> -	qid1 =3D cpumask_nth(get_random_u32_below(weight), mask);
> +
> +	do {
> +		qid1 =3D cpumask_nth(get_random_u32_below(weight), mask);
> +	} while (background && qid1 =3D=3D task_cpu(current));
>  	queue1 =3D READ_ONCE(ring->queues[qid1]);
>=20=20
> +	return queue1;

Hmmm?  I guess this was left from some local testing, right?

Cheers,
--=20
Lu=C3=ADs


> +
>  	do {
>  		qid2 =3D cpumask_nth(get_random_u32_below(weight), mask);
>  	} while (qid2 =3D=3D qid1);
> @@ -1298,12 +1305,14 @@ static struct fuse_ring_queue *fuse_uring_best_qu=
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
>=20=20
>  	qid =3D task_cpu(current);
>  	if (WARN_ONCE(qid >=3D ring->max_nr_queues,
> @@ -1311,16 +1320,44 @@ static struct fuse_ring_queue *fuse_uring_get_que=
ue(struct fuse_ring *ring)
>  		      ring->max_nr_queues))
>  		qid =3D 0;
>=20=20
> -	local_queue =3D READ_ONCE(ring->queues[qid]);
>  	local_node =3D cpu_to_node(qid);
>=20=20
> -	/* Fast path: if local queue exists and is not overloaded, use it */
> -	if (local_queue && local_queue->nr_reqs <=3D FURING_Q_LOCAL_THRESHOLD)
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
> +		int weight =3D cpumask_weight(numa_mask);
> +
> +		if (weight > 0) {
> +			int idx =3D (qid + 1) % weight;
> +
> +			qid =3D cpumask_nth(idx, numa_mask);
> +		} else {
> +			qid =3D cpumask_first(numa_mask);
> +		}
> +
> +		local_queue =3D READ_ONCE(ring->queues[qid]);
> +	}
> +
> +	if (local_queue && local_queue->nr_reqs <=3D FURING_Q_NUMA_THRESHOLD)
>  		return local_queue;
>=20=20
> +	if (retries < FURING_NEXT_QUEUE_RETRIES) {
> +		retries++;
> +		local_queue =3D NULL;
> +		goto retry;
> +	}
> +
>  	/* Find best NUMA-local queue */
>  	numa_mask =3D ring->numa_registered_q_mask[local_node];
> -	best_numa =3D fuse_uring_best_queue(numa_mask, ring);
> +	best_numa =3D fuse_uring_best_queue(numa_mask, ring, background);
>=20=20
>  	/* If NUMA queue is under threshold, use it */
>  	if (best_numa && best_numa->nr_reqs <=3D FURING_Q_NUMA_THRESHOLD)
> @@ -1328,7 +1365,7 @@ static struct fuse_ring_queue *fuse_uring_get_queue=
(struct fuse_ring *ring)
>=20=20
>  	/* NUMA queues above threshold, try global queues */
>  	global_mask =3D ring->registered_q_mask;
> -	best_global =3D fuse_uring_best_queue(global_mask, ring);
> +	best_global =3D fuse_uring_best_queue(global_mask, ring, background);
>=20=20
>  	/* Might happen during tear down */
>  	if (!best_global)
> @@ -1338,8 +1375,10 @@ static struct fuse_ring_queue *fuse_uring_get_queu=
e(struct fuse_ring *ring)
>  	if (best_global->nr_reqs <=3D FURING_Q_GLOBAL_THRESHOLD)
>  		return best_global;
>=20=20
> +	return best_global;
> +
>  	/* Fall back to best available queue */
> -	return best_numa ? best_numa : best_global;
> +	// return best_numa ? best_numa : best_global;
>  }
>=20=20
>  static void fuse_uring_dispatch_ent(struct fuse_ring_ent *ent)
> @@ -1360,7 +1399,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *=
fiq, struct fuse_req *req)
>  	int err;
>=20=20
>  	err =3D -EINVAL;
> -	queue =3D fuse_uring_get_queue(ring);
> +	queue =3D fuse_uring_get_queue(ring, false);
>  	if (!queue)
>  		goto err;
>=20=20
> @@ -1405,7 +1444,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
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
>


