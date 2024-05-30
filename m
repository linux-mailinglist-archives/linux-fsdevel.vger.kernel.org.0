Return-Path: <linux-fsdevel+bounces-20567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D178D52B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 21:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E1D1C22C69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 19:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD6C13DB9F;
	Thu, 30 May 2024 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Ajr8q45a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC67A433CA
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717098963; cv=none; b=Dws1J4Ev0TdouI9bj+TFuWo4cHsgt9HMYO+iymKpNTaazH9WlvYoKvkbG0ZS1lO0u4pcb5FlgljX8hT8Cm602xnBZ2PQ6QL8Sa7J4QoeRDxJCOkE9rcokDH4yG0R+p7k8dDETxajEy8ldkATvxlQQLVio4/1UdTAkwP3U0n1dpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717098963; c=relaxed/simple;
	bh=6KoI2OvAdLbieg34QfKAAuzzt+dbg314DhZy8XJZuPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJvmG7a4bNUq/c4RcCiv8Wz41OpwfXUL6G92s5iwmwXZbnzc9T2/yHEkTAM4UN5xtVMDpG08Z63JVfa9f7AKNHhZqm8/6ig95KjRLb/neUw63c6JDGDRvnVSlWWvSlvaWeE2dMljYR0++EF3KpSR2i62wEmOmE6eoCbH+4BD2tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Ajr8q45a; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ab975abb24so6393366d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 12:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717098960; x=1717703760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RrkGvBbkoAMGIA+s1K2c8GfplMz1f19PUi4hLqicdZI=;
        b=Ajr8q45aMQViDIiBZVNvVN5GxPXIVk2jg9bY1ZIzgwmKpQVYxvktH8sl1f0h5aF1TM
         yJyJv/hYPu5FVsow+VeLiRoU2SrSEaZfvcAvXlGoP/zs1HoDaPSu5WdELXGzU0x0USKS
         gV06ADFjf0PYwwHyqiV28lthST2wokBdQF2gAZIdBIb9g+zi8r2Ec9XmFk2P1otccA4y
         JjL6OQk8PX0OgnWjzCKUI2GzHoyYRH+VyD/vDUYLVHuuKufBDAiP1B+qZFBBNBKRNFAD
         WURBc+b4c3gt7ILbp++6d4B0XeUcVMoT6+pMORAy6arw9Ra2R37gt8kHCO/APow03bR8
         7DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717098960; x=1717703760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrkGvBbkoAMGIA+s1K2c8GfplMz1f19PUi4hLqicdZI=;
        b=OY9aaWitMTvCl/svZl92rcSmV9gK/cd4wX93CuoszKd+/yOZ75/35O6g6mz34c2MH2
         HtzUZWV0PaMOw/WwW9ee32wCfJOyV4+oU51E6myz2qVvf0rUDfbG+FJQuubFuMgo7HJF
         vtYzu5vHorD9RoPBFmpQMIWrDx5sGYA7dcx3QgrXiQAYm0EHKq1h7x6yjXlESaHkyBYV
         8kqVhN5gBqcFZhXu76PfdhYJje87Me95nRF+jG3zZKbCNz92b/wYZ4Pq5C0cxlU1tMQ1
         UOD5Td698XVmhd/DT6UcpSTFxjW39FCw1UXxEDC1iLEFwkTxU2mx5CLMEltDVjeoc5Pr
         pHKg==
X-Forwarded-Encrypted: i=1; AJvYcCU3WjnrxXrAxktqBdMcvSBlNihFw87ALY3WtiSKsh3vf20TY6UOtkRvB8j4rFnmgifirjpDGe8+WvbeocT8N0NF3iDWCVlwyduXgLQiAA==
X-Gm-Message-State: AOJu0YxUvL5vDSdflMnL1QRW33Mi/sdWlu+Nie9k07St2IfqR6K4DJql
	FiAL6qoM0iF2sA7SaEh6DzhD+LqHNedZLgl0Q0u6SgwSlWnit1n3KQgynuvOOPg=
X-Google-Smtp-Source: AGHT+IE8FRa+ddOubAQnxhvqV9E4UKbHLhKi60v0PTN8DB872qglM+LECyHoYMfPOAui6wUU6BFuiw==
X-Received: by 2002:a0c:fac3:0:b0:6ae:1a96:3ec8 with SMTP id 6a1803df08f44-6ae1a963ee1mr23892666d6.53.1717098960401;
        Thu, 30 May 2024 12:56:00 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b417b16sm1246666d6.111.2024.05.30.12.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 12:56:00 -0700 (PDT)
Date: Thu, 30 May 2024 15:55:59 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm
Subject: Re: [PATCH RFC v2 10/19] fuse: {uring} Handle SQEs - register
 commands
Message-ID: <20240530195559.GB2210558@perftesting>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-10-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-10-d149476b1d65@ddn.com>

On Wed, May 29, 2024 at 08:00:45PM +0200, Bernd Schubert wrote:
> This adds basic support for ring SQEs (with opcode=IORING_OP_URING_CMD).
> For now only FUSE_URING_REQ_FETCH is handled to register queue entries.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev.c             |   1 +
>  fs/fuse/dev_uring.c       | 267 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/dev_uring_i.h     |  12 +++
>  include/uapi/linux/fuse.h |  33 ++++++
>  4 files changed, 313 insertions(+)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index cd5dc6ae9272..05a87731b5c3 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2510,6 +2510,7 @@ const struct file_operations fuse_dev_operations = {
>  	.compat_ioctl   = compat_ptr_ioctl,
>  #if IS_ENABLED(CONFIG_FUSE_IO_URING)
>  	.mmap		= fuse_uring_mmap,
> +	.uring_cmd	= fuse_uring_cmd,
>  #endif
>  };
>  EXPORT_SYMBOL_GPL(fuse_dev_operations);
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 2c0ccb378908..48b1118b64f4 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -31,6 +31,27 @@
>  #include <linux/topology.h>
>  #include <linux/io_uring/cmd.h>
>  
> +static void fuse_ring_ring_ent_unset_userspace(struct fuse_ring_ent *ent)
> +{
> +	clear_bit(FRRS_USERSPACE, &ent->state);
> +	list_del_init(&ent->list);
> +}
> +
> +/* Update conn limits according to ring values */
> +static void fuse_uring_conn_cfg_limits(struct fuse_ring *ring)
> +{
> +	struct fuse_conn *fc = ring->fc;
> +
> +	WRITE_ONCE(fc->max_pages, min_t(unsigned int, fc->max_pages,
> +					ring->req_arg_len / PAGE_SIZE));
> +
> +	/* This not ideal, as multiplication with nr_queue assumes the limit
> +	 * gets reached when all queues are used, but a single threaded
> +	 * application might already do that.
> +	 */
> +	WRITE_ONCE(fc->max_background, ring->nr_queues * ring->max_nr_async);
> +}
> +
>  /*
>   * Basic ring setup for this connection based on the provided configuration
>   */
> @@ -329,3 +350,249 @@ int fuse_uring_queue_cfg(struct fuse_ring *ring,
>  	return 0;
>  }
>  
> +/*
> + * Put a ring request onto hold, it is no longer used for now.
> + */
> +static void fuse_uring_ent_avail(struct fuse_ring_ent *ring_ent,
> +				 struct fuse_ring_queue *queue)
> +	__must_hold(&queue->lock)

Sorry I'm just now bringing this up, but I'd love to see a

lockdep_assert_held(<whatever lock>);

in every place where you use __must_hold, so I get a nice big warning when I'm
running stuff.  I don't always run sparse, but I always test with lockdep on,
and that'll help me notice problems.

> +{
> +	struct fuse_ring *ring = queue->ring;
> +
> +	/* unsets all previous flags - basically resets */
> +	pr_devel("%s ring=%p qid=%d tag=%d state=%lu async=%d\n", __func__,
> +		 ring, ring_ent->queue->qid, ring_ent->tag, ring_ent->state,
> +		 ring_ent->async);
> +
> +	if (WARN_ON(test_bit(FRRS_USERSPACE, &ring_ent->state))) {
> +		pr_warn("%s qid=%d tag=%d state=%lu async=%d\n", __func__,
> +			ring_ent->queue->qid, ring_ent->tag, ring_ent->state,
> +			ring_ent->async);
> +		return;
> +	}
> +
> +	WARN_ON_ONCE(!list_empty(&ring_ent->list));
> +
> +	if (ring_ent->async)
> +		list_add(&ring_ent->list, &queue->async_ent_avail_queue);
> +	else
> +		list_add(&ring_ent->list, &queue->sync_ent_avail_queue);
> +
> +	set_bit(FRRS_WAIT, &ring_ent->state);
> +}
> +
> +/*
> + * fuse_uring_req_fetch command handling
> + */
> +static int fuse_uring_fetch(struct fuse_ring_ent *ring_ent,
> +			    struct io_uring_cmd *cmd, unsigned int issue_flags)
> +__must_hold(ring_ent->queue->lock)
> +{
> +	struct fuse_ring_queue *queue = ring_ent->queue;
> +	struct fuse_ring *ring = queue->ring;
> +	int ret = 0;
> +	int nr_ring_sqe;
> +
> +	/* register requests for foreground requests first, then backgrounds */
> +	if (queue->nr_req_sync >= ring->max_nr_sync) {
> +		queue->nr_req_async++;
> +		ring_ent->async = 1;
> +	} else
> +		queue->nr_req_sync++;

IIRC the style guidelines say if you use { in any part of the if, you've got to
use them for all of it.  But that may just be what we do in btrfs.  Normally I
wouldn't nit about it but I have comments elsewhere for this patch.

> +
> +	fuse_uring_ent_avail(ring_ent, queue);
> +
> +	if (queue->nr_req_sync + queue->nr_req_async > ring->queue_depth) {
> +		/* should be caught by ring state before and queue depth
> +		 * check before
> +		 */
> +		WARN_ON(1);
> +		pr_info("qid=%d tag=%d req cnt (fg=%d async=%d exceeds depth=%zu",
> +			queue->qid, ring_ent->tag, queue->nr_req_sync,
> +			queue->nr_req_async, ring->queue_depth);
> +		ret = -ERANGE;
> +	}
> +
> +	if (ret)
> +		goto out; /* erange */

This can just be

if (whatever) {
	WARN_ON_ONCE(1);
	return -ERANGE;
}

instead of the goto out thing.

> +
> +	WRITE_ONCE(ring_ent->cmd, cmd);
> +
> +	nr_ring_sqe = ring->queue_depth * ring->nr_queues;
> +	if (atomic_inc_return(&ring->nr_sqe_init) == nr_ring_sqe) {
> +		fuse_uring_conn_cfg_limits(ring);
> +		ring->ready = 1;
> +	}
> +
> +out:
> +	return ret;

And this can just be return 0 here with the above change.

> +}
> +
> +static struct fuse_ring_queue *
> +fuse_uring_get_verify_queue(struct fuse_ring *ring,
> +			    const struct fuse_uring_cmd_req *cmd_req,
> +			    unsigned int issue_flags)
> +{
> +	struct fuse_conn *fc = ring->fc;
> +	struct fuse_ring_queue *queue;
> +	int ret;
> +
> +	if (!(issue_flags & IO_URING_F_SQE128)) {
> +		pr_info("qid=%d tag=%d SQE128 not set\n", cmd_req->qid,
> +			cmd_req->tag);
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	if (unlikely(!fc->connected)) {
> +		ret = -ENOTCONN;
> +		goto err;
> +	}
> +
> +	if (unlikely(!ring->configured)) {
> +		pr_info("command for a connection that is not ring configured\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	if (unlikely(cmd_req->qid >= ring->nr_queues)) {
> +		pr_devel("qid=%u >= nr-queues=%zu\n", cmd_req->qid,
> +			 ring->nr_queues);
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	queue = fuse_uring_get_queue(ring, cmd_req->qid);
> +	if (unlikely(queue == NULL)) {
> +		pr_info("Got NULL queue for qid=%d\n", cmd_req->qid);
> +		ret = -EIO;
> +		goto err;
> +	}
> +
> +	if (unlikely(!queue->configured || queue->stopped)) {
> +		pr_info("Ring or queue (qid=%u) not ready.\n", cmd_req->qid);
> +		ret = -ENOTCONN;
> +		goto err;
> +	}
> +
> +	if (cmd_req->tag > ring->queue_depth) {
> +		pr_info("tag=%u > queue-depth=%zu\n", cmd_req->tag,
> +			ring->queue_depth);
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	return queue;
> +
> +err:
> +	return ERR_PTR(ret);

There's no cleanup here, so just make all the above

return ERR_PTR(-whatever)

instead of the goto err thing.

> +}
> +
> +/**
> + * Entry function from io_uring to handle the given passthrough command
> + * (op cocde IORING_OP_URING_CMD)
> + */

Docstyle thing.

> +int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
> +{
> +	const struct fuse_uring_cmd_req *cmd_req = io_uring_sqe_cmd(cmd->sqe);
> +	struct fuse_dev *fud = fuse_get_dev(cmd->file);
> +	struct fuse_conn *fc = fud->fc;
> +	struct fuse_ring *ring = fc->ring;
> +	struct fuse_ring_queue *queue;
> +	struct fuse_ring_ent *ring_ent = NULL;
> +	u32 cmd_op = cmd->cmd_op;
> +	int ret = 0;
> +
> +	if (!ring) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	queue = fuse_uring_get_verify_queue(ring, cmd_req, issue_flags);
> +	if (IS_ERR(queue)) {
> +		ret = PTR_ERR(queue);
> +		goto out;
> +	}
> +
> +	ring_ent = &queue->ring_ent[cmd_req->tag];
> +
> +	pr_devel("%s:%d received: cmd op %d qid %d (%p) tag %d  (%p)\n",
> +		 __func__, __LINE__, cmd_op, cmd_req->qid, queue, cmd_req->tag,
> +		 ring_ent);
> +
> +	spin_lock(&queue->lock);
> +	if (unlikely(queue->stopped)) {
> +		/* XXX how to ensure queue still exists? Add
> +		 * an rw ring->stop lock? And take that at the beginning
> +		 * of this function? Better would be to advise uring
> +		 * not to call this function at all? Or free the queue memory
> +		 * only, on daemon PF_EXITING?
> +		 */
> +		ret = -ENOTCONN;
> +		goto err_unlock;
> +	}
> +
> +	if (current == queue->server_task)
> +		queue->uring_cmd_issue_flags = issue_flags;
> +
> +	switch (cmd_op) {
> +	case FUSE_URING_REQ_FETCH:

This is all organized kind of oddly, I think I'd prefer if you put all the code
from above where we grab the queue lock and the bit below into a helper.

So instead of

spin_lock(&queue->lock);
blah

switch (cmd_op) {
case FUSE_URING_REQ_FETCH:
	blah
default:
	ret = -EINVAL;
}

you have

static int fuse_uring_req_fetch(queue, cmd, issue_flags)
{
	ring_ent = blah;
	spin_lock(&queue->lock);
	<blah>
	spin_unlock(&que->lock);
	return ret;
}

then

switch (cmd_op) {
case FUSE_URING_REQ_FETCH:
	ret = fuse_uring_req_fetch(queue, cmd, issue_flags);
	break;
default:
	ret = -EINVAL;
	break;
}

Alternatively just pushe all the queue stuff down into the case
FUSE_URING_REQ_FETCH part, but I think the helper is cleaner.

> +		if (queue->server_task == NULL) {
> +			queue->server_task = current;
> +			queue->uring_cmd_issue_flags = issue_flags;
> +		}
> +
> +		/* No other bit must be set here */
> +		if (ring_ent->state != BIT(FRRS_INIT)) {
> +			pr_info_ratelimited(
> +				"qid=%d tag=%d register req state %lu expected %lu",
> +				cmd_req->qid, cmd_req->tag, ring_ent->state,
> +				BIT(FRRS_INIT));
> +			ret = -EINVAL;
> +			goto err_unlock;
> +		}
> +
> +		fuse_ring_ring_ent_unset_userspace(ring_ent);
> +
> +		ret = fuse_uring_fetch(ring_ent, cmd, issue_flags);
> +		if (ret)
> +			goto err_unlock;
> +
> +		/*
> +		 * The ring entry is registered now and needs to be handled
> +		 * for shutdown.
> +		 */
> +		atomic_inc(&ring->queue_refs);
> +
> +		spin_unlock(&queue->lock);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		pr_devel("Unknown uring command %d", cmd_op);
> +		goto err_unlock;
> +	}
> +out:
> +	pr_devel("uring cmd op=%d, qid=%d tag=%d ret=%d\n", cmd_op,
> +		 cmd_req->qid, cmd_req->tag, ret);
> +
> +	if (ret < 0) {
> +		if (ring_ent != NULL) {

You don't pull anything from ring_ent in the pr_info, so maybe drop the extra
if statement?  Thanks,

Josef

