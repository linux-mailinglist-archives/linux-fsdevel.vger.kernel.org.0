Return-Path: <linux-fsdevel+bounces-63461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF19BBDA33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 12:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45D504E9597
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 10:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DA1223DF9;
	Mon,  6 Oct 2025 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aHiZVhPh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6EB21FF4C
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745560; cv=none; b=D/DzSOv8Gc53ScW1HVimWg5f31lAM4klYczMV2B8raPpvS6BEx2mwTQfCQgz9K+szSHWin684PA6vlHWeFMClmBpo14j8obMBujL/uQ3/zbAAXJfly/IZ/jd00edFHMzpaIpiEne91RcCZxvmxj47c5cVIHtO1TqWkEz07pvF+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745560; c=relaxed/simple;
	bh=9SuLvqXp5Rqe8Zn/IZ51ZoY4q1XcLuZSSz+amGi+zao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rm2v2cEhdG3oIE/jbX+/D4uN6QLO0F77kK73ahxH+QVFHC12Y7Mc5GLsrDTMIFotFvWahvMuAK1RonySeIWqR/hT6sOlhUEz8m0vum87UfbJ+NR833oF3XcYZTIcCr/1DhOj0ZDCV4NPb08FUZ5PYszG9jNsE9ZDHY4Jxn8ZwsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=aHiZVhPh; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZjWb4WeVa/f58JMO+eDehY1CmNRwjiCtujkPNe2HBCQ=; b=aHiZVhPhWUiG8ucUBXjpKBaBg/
	vpaQLvhR8DHSqTEeLitgmF6T+oAyfd8ZgiNRgiW+YzcTsFzSpQqIOPYreCb4tJqP4p41xmvgyUbwf
	wMC6sztTDp0F6ZDUQw3d7oP+qA5KXQX7iP79+bHddG4t3LHP5UFuQFwCcatvCvUGAcrYl0Cx+Sd71
	B0BXdCszmBv/z0PSairTXHQaVnu5k50UZgzq0DqyLPY3MpQSqujz8F2V0oSV8xyzv0RP3IfowYVWW
	szKnuSENIeSmviZPeNOhD9sDwdDBpGCM5mR5mVdOHvlqj9W12CriMTsYB+gpSyVcT9kYwEnudq3bZ
	AkhCrkUQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v5hsG-005IxO-1z; Mon, 06 Oct 2025 11:51:20 +0200
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Ingo Molnar <mingo@redhat.com>,
  Peter Zijlstra <peterz@infradead.org>,  Juri Lelli
 <juri.lelli@redhat.com>,  Vincent Guittot <vincent.guittot@linaro.org>,
  Dietmar Eggemann <dietmar.eggemann@arm.com>,  Steven Rostedt
 <rostedt@goodmis.org>,  Ben Segall <bsegall@google.com>,  Mel Gorman
 <mgorman@suse.de>,  Valentin Schneider <vschneid@redhat.com>,  Joanne
 Koong <joannelkoong@gmail.com>,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] fuse: {io-uring} Use bitmaps to track registered
 queues
In-Reply-To: <20251003-reduced-nr-ring-queues_3-v2-3-742ff1a8fc58@ddn.com>
	(Bernd Schubert's message of "Fri, 03 Oct 2025 12:06:44 +0200")
References: <20251003-reduced-nr-ring-queues_3-v2-0-742ff1a8fc58@ddn.com>
	<20251003-reduced-nr-ring-queues_3-v2-3-742ff1a8fc58@ddn.com>
Date: Mon, 06 Oct 2025 10:51:19 +0100
Message-ID: <87ikgse4tk.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03 2025, Bernd Schubert wrote:

> Add per-CPU and per-NUMA node bitmasks to track which
> io-uring queues are registered.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev_uring.c   | 54 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/dev_uring_i.h |  9 +++++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 0f5ab27dacb66c9f5f10eac2713d9bd3eb4c26da..dacc07f5b5b1a48acefa27827=
9f851c3ae2b1489 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -18,6 +18,8 @@ MODULE_PARM_DESC(enable_uring,
>=20=20
>  #define FUSE_URING_IOV_SEGS 2 /* header and payload */
>=20=20
> +/* Number of queued fuse requests until a queue is considered full */
> +#define FUSE_URING_QUEUE_THRESHOLD 5

Nit: I guess this hunk can be removed from this patch as this constant is
never used and is removed in the next patch.

Cheers,
--=20
Lu=C3=ADs

>  bool fuse_uring_enabled(void)
>  {
> @@ -184,6 +186,18 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
>  	return false;
>  }
>=20=20
> +static void fuse_ring_destruct_q_masks(struct fuse_ring *ring)
> +{
> +	int node;
> +
> +	free_cpumask_var(ring->registered_q_mask);
> +	if (ring->numa_registered_q_mask) {
> +		for (node =3D 0; node < ring->nr_numa_nodes; node++)
> +			free_cpumask_var(ring->numa_registered_q_mask[node]);
> +		kfree(ring->numa_registered_q_mask);
> +	}
> +}
> +
>  void fuse_uring_destruct(struct fuse_conn *fc)
>  {
>  	struct fuse_ring *ring =3D fc->ring;
> @@ -215,11 +229,32 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>  		ring->queues[qid] =3D NULL;
>  	}
>=20=20
> +	fuse_ring_destruct_q_masks(ring);
>  	kfree(ring->queues);
>  	kfree(ring);
>  	fc->ring =3D NULL;
>  }
>=20=20
> +static int fuse_ring_create_q_masks(struct fuse_ring *ring)
> +{
> +	int node;
> +
> +	if (!zalloc_cpumask_var(&ring->registered_q_mask, GFP_KERNEL_ACCOUNT))
> +		return -ENOMEM;
> +
> +	ring->numa_registered_q_mask =3D kcalloc(
> +		ring->nr_numa_nodes, sizeof(cpumask_var_t), GFP_KERNEL_ACCOUNT);
> +	if (!ring->numa_registered_q_mask)
> +		return -ENOMEM;
> +	for (node =3D 0; node < ring->nr_numa_nodes; node++) {
> +		if (!zalloc_cpumask_var(&ring->numa_registered_q_mask[node],
> +					GFP_KERNEL_ACCOUNT))
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Basic ring setup for this connection based on the provided configurat=
ion
>   */
> @@ -229,11 +264,14 @@ static struct fuse_ring *fuse_uring_create(struct f=
use_conn *fc)
>  	size_t nr_queues =3D num_possible_cpus();
>  	struct fuse_ring *res =3D NULL;
>  	size_t max_payload_size;
> +	int err;
>=20=20
>  	ring =3D kzalloc(sizeof(*fc->ring), GFP_KERNEL_ACCOUNT);
>  	if (!ring)
>  		return NULL;
>=20=20
> +	ring->nr_numa_nodes =3D num_online_nodes();
> +
>  	ring->queues =3D kcalloc(nr_queues, sizeof(struct fuse_ring_queue *),
>  			       GFP_KERNEL_ACCOUNT);
>  	if (!ring->queues)
> @@ -242,6 +280,10 @@ static struct fuse_ring *fuse_uring_create(struct fu=
se_conn *fc)
>  	max_payload_size =3D max(FUSE_MIN_READ_BUFFER, fc->max_write);
>  	max_payload_size =3D max(max_payload_size, fc->max_pages * PAGE_SIZE);
>=20=20
> +	err =3D fuse_ring_create_q_masks(ring);
> +	if (err)
> +		goto out_err;
> +
>  	spin_lock(&fc->lock);
>  	if (fc->ring) {
>  		/* race, another thread created the ring in the meantime */
> @@ -261,6 +303,7 @@ static struct fuse_ring *fuse_uring_create(struct fus=
e_conn *fc)
>  	return ring;
>=20=20
>  out_err:
> +	fuse_ring_destruct_q_masks(ring);
>  	kfree(ring->queues);
>  	kfree(ring);
>  	return res;
> @@ -423,6 +466,7 @@ static void fuse_uring_log_ent_state(struct fuse_ring=
 *ring)
>  			pr_info(" ent-commit-queue ring=3D%p qid=3D%d ent=3D%p state=3D%d\n",
>  				ring, qid, ent, ent->state);
>  		}
> +
>  		spin_unlock(&queue->lock);
>  	}
>  	ring->stop_debug_log =3D 1;
> @@ -469,6 +513,7 @@ static void fuse_uring_async_stop_queues(struct work_=
struct *work)
>  void fuse_uring_stop_queues(struct fuse_ring *ring)
>  {
>  	int qid;
> +	int node;
>=20=20
>  	for (qid =3D 0; qid < ring->max_nr_queues; qid++) {
>  		struct fuse_ring_queue *queue =3D READ_ONCE(ring->queues[qid]);
> @@ -479,6 +524,11 @@ void fuse_uring_stop_queues(struct fuse_ring *ring)
>  		fuse_uring_teardown_entries(queue);
>  	}
>=20=20
> +	/* Reset all queue masks, we won't process any more IO */
> +	cpumask_clear(ring->registered_q_mask);
> +	for (node =3D 0; node < ring->nr_numa_nodes; node++)
> +		cpumask_clear(ring->numa_registered_q_mask[node]);
> +
>  	if (atomic_read(&ring->queue_refs) > 0) {
>  		ring->teardown_time =3D jiffies;
>  		INIT_DELAYED_WORK(&ring->async_teardown_work,
> @@ -982,6 +1032,7 @@ static void fuse_uring_do_register(struct fuse_ring_=
ent *ent,
>  	struct fuse_ring *ring =3D queue->ring;
>  	struct fuse_conn *fc =3D ring->fc;
>  	struct fuse_iqueue *fiq =3D &fc->iq;
> +	int node =3D cpu_to_node(queue->qid);
>=20=20
>  	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
>=20=20
> @@ -990,6 +1041,9 @@ static void fuse_uring_do_register(struct fuse_ring_=
ent *ent,
>  	fuse_uring_ent_avail(ent, queue);
>  	spin_unlock(&queue->lock);
>=20=20
> +	cpumask_set_cpu(queue->qid, ring->registered_q_mask);
> +	cpumask_set_cpu(queue->qid, ring->numa_registered_q_mask[node]);
> +
>  	if (!ring->ready) {
>  		bool ready =3D is_ring_ready(ring, queue->qid);
>=20=20
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 708412294982566919122a1a0d7f741217c763ce..35e3b6808b60398848965afd3=
091b765444283ff 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -115,6 +115,9 @@ struct fuse_ring {
>  	/* number of ring queues */
>  	size_t max_nr_queues;
>=20=20
> +	/* number of numa nodes */
> +	int nr_numa_nodes;
> +
>  	/* maximum payload/arg size */
>  	size_t max_payload_sz;
>=20=20
> @@ -125,6 +128,12 @@ struct fuse_ring {
>  	 */
>  	unsigned int stop_debug_log : 1;
>=20=20
> +	/* Tracks which queues are registered */
> +	cpumask_var_t registered_q_mask;
> +
> +	/* Tracks which queues are registered per NUMA node */
> +	cpumask_var_t *numa_registered_q_mask;
> +
>  	wait_queue_head_t stop_waitq;
>=20=20
>  	/* async tear down */
>
> --=20
> 2.43.0
>
>


