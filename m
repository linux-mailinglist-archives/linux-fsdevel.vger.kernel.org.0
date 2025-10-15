Return-Path: <linux-fsdevel+bounces-64229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75685BDE362
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 13:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CB53BE73E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 11:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC5931D398;
	Wed, 15 Oct 2025 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jooJp/Q/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C0831C571
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526325; cv=none; b=TPUhO2HvIknppw5YP+ytwTfEDVngRK/vGLSR/ztjb1I3rP/ymgu62zUVE0dexAPw+94i21Z0gVCoXpGeR/++xxZIhIuqrqxKKz+eAnwXVaORtnSxd8gMw3+kpVcnKDrqsAHzyDlVXWlvdd1zqUhMuD1TcE9VVoxhuwDtkDx84u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526325; c=relaxed/simple;
	bh=E8X0bAwEL3TRMOp9bJugjpKF8gcUTiSQJlLEbw3nGn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W644srM0/n1p0cq74QE1K8db3XWorEmwjUshQCLQBJfouAIJptAeo5G+CvgdApfQ+SZu4VMaloLEPlbJdYVp3cEA1chylOE/9M4v+XCrjc01JDOhVNZ5B52dfSMsQiNheEElw4U3L3W678jMAY0tJBQfFb9GcORe0ECU9DqJY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jooJp/Q/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ISy995E/NrxWDs1k40usNcKnHZHjV9kWpKZ1uJ5ohNs=; b=jooJp/Q/s3UBBMyxYea44aj1WL
	nJrvoSGzeuAqtY4DPkV+RtzmlxOcgD2pDBZ31cGg+98IiPXZ6PmP4xBB+8hkF0F01jjXhWPXRMqZE
	QY9SjJ74DkboviG1unOE0YzjVDoDOolAzpjVSxC6K25dy0vJnYlbRrki/oihxv5NB34q2M7ZjZ6k4
	FcVZNAyg1MAIQu9o/DF1XkbbyFDQbEnzZ5QRtud3mD3CBOjWUKdzAJ4wpO73tjc1H3IdTSr2ejcYT
	uLQB0cDFHP8kyqsJxSZ6/YLaKQZCrVhT6hf1tHPO7qhd0U+1sD0uNzkLMGxLLx5m1AiXQJaXsruWf
	pp8xaXtA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v8zJj-009urt-OX; Wed, 15 Oct 2025 13:05:15 +0200
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Joanne Koong
 <joannelkoong@gmail.com>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  Gang He <dchg2000@gmail.com>
Subject: Re: [PATCH v3 6/6] fuse: {io-uring} Queue background requests on a
 different core
In-Reply-To: <5e3b8848-2049-4321-82e7-2dec658d6936@ddn.com> (Bernd Schubert's
	message of "Wed, 15 Oct 2025 10:27:44 +0000")
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
	<20251013-reduced-nr-ring-queues_3-v3-6-6d87c8aa31ae@ddn.com>
	<87jz0w8pdp.fsf@igalia.com>
	<5e3b8848-2049-4321-82e7-2dec658d6936@ddn.com>
Date: Wed, 15 Oct 2025 12:05:10 +0100
Message-ID: <87frbk8ly1.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15 2025, Bernd Schubert wrote:

> On 10/15/25 11:50, Luis Henriques wrote:
>> On Mon, Oct 13 2025, Bernd Schubert wrote:
>>=20
>>> Running background IO on a different core makes quite a difference.
>>>
>>> fio --directory=3D/tmp/dest --name=3Diops.\$jobnum --rw=3Drandread \
>>> --bs=3D4k --size=3D1G --numjobs=3D1 --iodepth=3D4 --time_based\
>>> --runtime=3D30s --group_reporting --ioengine=3Dio_uring\
>>>  --direct=3D1
>>>
>>> unpatched
>>>    READ: bw=3D272MiB/s (285MB/s), 272MiB/s-272MiB/s ...
>>> patched
>>>    READ: bw=3D760MiB/s (797MB/s), 760MiB/s-760MiB/s ...
>>>
>>> With --iodepth=3D8
>>>
>>> unpatched
>>>    READ: bw=3D466MiB/s (489MB/s), 466MiB/s-466MiB/s ...
>>> patched
>>>    READ: bw=3D966MiB/s (1013MB/s), 966MiB/s-966MiB/s ...
>>> 2nd run:
>>>    READ: bw=3D1014MiB/s (1064MB/s), 1014MiB/s-1014MiB/s ...
>>>
>>> Without io-uring (--iodepth=3D8)
>>>    READ: bw=3D729MiB/s (764MB/s), 729MiB/s-729MiB/s ...
>>>
>>> Without fuse (--iodepth=3D8)
>>>    READ: bw=3D2199MiB/s (2306MB/s), 2199MiB/s-2199MiB/s ...
>>>
>>> (Test were done with
>>> <libfuse>/example/passthrough_hp -o allow_other --nopassthrough  \
>>> [-o io_uring] /tmp/source /tmp/dest
>>> )
>>>
>>> Additional notes:
>>>
>>> With FURING_NEXT_QUEUE_RETRIES=3D0 (--iodepth=3D8)
>>>    READ: bw=3D903MiB/s (946MB/s), 903MiB/s-903MiB/s ...
>>>
>>> With just a random qid (--iodepth=3D8)
>>>    READ: bw=3D429MiB/s (450MB/s), 429MiB/s-429MiB/s ...
>>>
>>> With --iodepth=3D1
>>> unpatched
>>>    READ: bw=3D195MiB/s (204MB/s), 195MiB/s-195MiB/s ...
>>> patched
>>>    READ: bw=3D232MiB/s (243MB/s), 232MiB/s-232MiB/s ...
>>>
>>> With --iodepth=3D1 --numjobs=3D2
>>> unpatched
>>>    READ: bw=3D966MiB/s (1013MB/s), 966MiB/s-966MiB/s ...
>>> patched
>>>    READ: bw=3D1821MiB/s (1909MB/s), 1821MiB/s-1821MiB/s ...
>>>
>>> With --iodepth=3D1 --numjobs=3D8
>>> unpatched
>>>    READ: bw=3D1138MiB/s (1193MB/s), 1138MiB/s-1138MiB/s ...
>>> patched
>>>    READ: bw=3D1650MiB/s (1730MB/s), 1650MiB/s-1650MiB/s ...
>>> fuse without io-uring
>>>    READ: bw=3D1314MiB/s (1378MB/s), 1314MiB/s-1314MiB/s ...
>>> no-fuse
>>>    READ: bw=3D2566MiB/s (2690MB/s), 2566MiB/s-2566MiB/s ...
>>>
>>> In summary, for async requests the core doing application IO is busy
>>> sending requests and processing IOs should be done on a different core.
>>> Spreading the load on random cores is also not desirable, as the core
>>> might be frequency scaled down and/or in C1 sleep states. Not shown her=
e,
>>> but differnces are much smaller when the system uses performance govenor
>>> instead of schedutil (ubuntu default). Obviously at the cost of higher
>>> system power consumption for performance govenor - not desirable either.
>>>
>>> Results without io-uring (which uses fixed libfuse threads per queue)
>>> heavily depend on the current number of active threads. Libfuse uses
>>> default of max 10 threads, but actual nr max threads is a parameter.
>>> Also, no-fuse-io-uring results heavily depend on, if there was already
>>> running another workload before, as libfuse starts these threads
>>> dynamically - i.e. the more threads are active, the worse the
>>> performance.
>>>
>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>> ---
>>>  fs/fuse/dev_uring.c | 53 +++++++++++++++++++++++++++++++++++++++++++++=
+-------
>>>  1 file changed, 46 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>> index aca71ce5632efd1d80e3ac0ad4e81ac1536dbc47..f35dd98abfe6407849fec55=
847c6b3d186383803 100644
>>> --- a/fs/fuse/dev_uring.c
>>> +++ b/fs/fuse/dev_uring.c
>>> @@ -23,6 +23,7 @@ MODULE_PARM_DESC(enable_uring,
>>>  #define FURING_Q_LOCAL_THRESHOLD 2
>>>  #define FURING_Q_NUMA_THRESHOLD (FURING_Q_LOCAL_THRESHOLD + 1)
>>>  #define FURING_Q_GLOBAL_THRESHOLD (FURING_Q_LOCAL_THRESHOLD * 2)
>>> +#define FURING_NEXT_QUEUE_RETRIES 2
>>=20
>> Some bikeshedding:
>>=20
>> Maybe that's just me, but I associate the names above (FURING_*) to 'fur'
>> -- the action of making 'fur'.  I'm not sure that verb even exists, but =
my
>> brain makes me dislike those names :-)
>>=20
>> But I'm not a native speaker, and I don't have any other objection to
>> those names rather than "I don't like fur!" so feel free to ignore me. :=
-)
>
> I had initially called it "FUSE_URING", but it seemed to be a bit long.
> I can change back to that or maybe you have a better short name in your
> mind (as usual the hardest part is to find good variable names)?

Yeah, the only alternative would be to either drop 'FUSE' or 'URING' from
the name: FUSE_Q_LOCAL_THRESHOLD or URING_Q_LOCAL_THRESHOLD.  But as I
said: this is plain bikeshedding.  If no one else complains about these
definitions, just leave them as-is.

>>>=20=20
>>>  bool fuse_uring_enabled(void)
>>>  {
>>> @@ -1302,12 +1303,15 @@ static struct fuse_ring_queue *fuse_uring_best_=
queue(const struct cpumask *mask,
>>>  /*
>>>   * Get the best queue for the current CPU
>>>   */
>>> -static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *=
ring)
>>> +static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *=
ring,
>>> +						    bool background)
>>>  {
>>>  	unsigned int qid;
>>>  	struct fuse_ring_queue *local_queue, *best_numa, *best_global;
>>>  	int local_node;
>>>  	const struct cpumask *numa_mask, *global_mask;
>>> +	int retries =3D 0;
>>> +	int weight =3D -1;
>>>=20=20
>>>  	qid =3D task_cpu(current);
>>>  	if (WARN_ONCE(qid >=3D ring->max_nr_queues,
>>> @@ -1315,16 +1319,50 @@ static struct fuse_ring_queue *fuse_uring_get_q=
ueue(struct fuse_ring *ring)
>>>  		      ring->max_nr_queues))
>>>  		qid =3D 0;
>>>=20=20
>>> -	local_queue =3D READ_ONCE(ring->queues[qid]);
>>>  	local_node =3D cpu_to_node(qid);
>>>  	if (WARN_ON_ONCE(local_node > ring->nr_numa_nodes))
>>>  		local_node =3D 0;
>>>=20=20
>>> -	/* Fast path: if local queue exists and is not overloaded, use it */
>>> -	if (local_queue &&
>>> -	    READ_ONCE(local_queue->nr_reqs) <=3D FURING_Q_LOCAL_THRESHOLD)
>>> +	local_queue =3D READ_ONCE(ring->queues[qid]);
>>> +
>>> +retry:
>>> +	/*
>>> +	 * For background requests, try next CPU in same NUMA domain.
>>> +	 * I.e. cpu-0 creates async requests, cpu-1 io processes.
>>> +	 * Similar for foreground requests, when the local queue does not
>>> +	 * exist - still better to always wake the same cpu id.
>>> +	 */
>>> +	if (background || !local_queue) {
>>> +		numa_mask =3D ring->numa_registered_q_mask[local_node];
>>> +
>>> +		if (weight =3D=3D -1)
>>> +			weight =3D cpumask_weight(numa_mask);
>>> +
>>> +		if (weight =3D=3D 0)
>>> +			goto global;
>>> +
>>> +		if (weight > 1) {
>>> +			int idx =3D (qid + 1) % weight;
>>> +
>>> +			qid =3D cpumask_nth(idx, numa_mask);
>>> +		} else {
>>> +			qid =3D cpumask_first(numa_mask);
>>> +		}
>>> +
>>> +		local_queue =3D READ_ONCE(ring->queues[qid]);
>>> +		if (WARN_ON_ONCE(!local_queue))
>>> +			return NULL;
>>> +	}
>>> +
>>> +	if (READ_ONCE(local_queue->nr_reqs) <=3D FURING_Q_NUMA_THRESHOLD)
>>>  		return local_queue;
>>>=20=20
>>> +	if (retries < FURING_NEXT_QUEUE_RETRIES && weight > retries + 1) {
>>> +		retries++;
>>> +		local_queue =3D NULL;
>>> +		goto retry;
>>> +	}
>>> +
>>=20
>> I wonder if this retry loop is really useful.  If I understand this
>> correctly, we're doing a busy loop, hoping for a better queue to become
>> available.  But if the system is really busy doing IO this retry loop wi=
ll
>> most of the times fail and will fall back to the next option -- only once
>> in a while we will get a better one.
>>=20
>> Do you have evidence that this could be helpful?  Or am I misunderstandi=
ng
>> the purpose of this retry loop?
>
> Yeah, I got better results with the retry, because using random queues
> really doesn't work well - wakes up cores on random queues and wakes and
> doesn't accumulate on the same queue - doesn't make use of the ring
> advantage. So random should be avoided, if possible. Also, the more
> queues the system has, the worse the results with the plain random
> fallback. I can provide some numbers later on today.

From my side, there's no need to provide numbers -- I'm happy with your
answer.  I just thought that looping could be more expensive than just
picking whatever queue was selected, because in the end that would likely
be the end result anyway.  But I haven't tested it and I understand that
this design can definitely have impact in big systems.

Cheers,
--=20
Lu=C3=ADs

