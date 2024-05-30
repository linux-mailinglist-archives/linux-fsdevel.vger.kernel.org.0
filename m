Return-Path: <linux-fsdevel+bounces-20570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5028D52E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93F4282B38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70189612EB;
	Thu, 30 May 2024 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Pn0ZbG+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBBE4D8BF
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717099708; cv=none; b=aKoQFwlkaBFY7svJ0YOcMOP4c+LdKsV4sXinY9G85Y5zXkfO0RdA+Vs0BmF3kI7zWtFx8jhXCXk1PfZXyGN9+B1qpZlg1dbUCRVEbxOVHZXUljpH0O/iC9VmYLnlgJN03y99WROksdr/aYjUKOuGvWZfYTDuQWBmz5BjhJYizAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717099708; c=relaxed/simple;
	bh=C+I3FPnlgUF5EJDpPerf73VWNhrHdA9o+QGL1aUVkxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH+//oKYOoOJ5G3ctXwRl1yz/qVM9JEmps3xjVJOrqbRSWKq0l7aUwZrNLDA2mxbHDhhCokAK6xSZIxRbZfzoV1DrDqYdX9vsQL+z7cyyCKqEcIyopcYFpLQk949m+BXOvdTr6rtWB0oXgkQrEXqfWvC6NznwFdT3fv4fPYmc4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Pn0ZbG+m; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-794c3aed567so89917685a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717099706; x=1717704506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BKtT9k1iaiMBueWNH8N2zh0A7Xl7Ajhwv6uFC1AFWzw=;
        b=Pn0ZbG+mB377ZltqtB4WbW3TnubfbmskEQibtXQkgRq/DrcPe5sL8icJvc55tEfm2Y
         GCWOtNsnRf4eDtrhioEW+4lKPdQIPyXfztt+L2G1gZm91hdZqhK4FPILII2L3hzvpKFJ
         9MSYy6Okl8/kptLk9/WUyXem+9MUGs2+jJ3LS/1FIZioGeE2btZhHLgxEjf3aYaxt3x+
         m6EW2ER3uTxqZ/clSVY2sGgF353HFX61P+HMSiPGJg6CZKB8ctzUZvUbolJrfWJVy+Xd
         aPjvlXb4WGPd62wRk630CnXEB6Yw0oi0pEXadiGrhpAsMHjTKn8cRJgWD5VrG04BlY0B
         pqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717099706; x=1717704506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKtT9k1iaiMBueWNH8N2zh0A7Xl7Ajhwv6uFC1AFWzw=;
        b=raG/VNmDzOEIge9DMLTNFFDkOj0hI2zeKrxqjCzz/zaAU+ZRzLqJZobQHQIrKPRihW
         3JBElU0o7cD3cY6mcdqPLYFM4fhjfgSx/fXhpcdj0U3HUFTX93JmG6m7M/uY/a2hClyF
         dCgmIAUzWcszJW1TNjeMTaXhlzRoznHhZXeH4iIO19ltYCgw62BCTthNKFWE5emlcry5
         0pWJ9AT1yZCQUagsh/gqhRKuvtHBOLNL7rekLpEvnx/b9YJyLOAaxWDoTfuuss3NDLlJ
         ZMio2jt8gChlhonCv4xxJ0salovX4wMU/pTfkTs2pUzmrP3UEXcOmjHuO9ZyKKZ21SfW
         oDDg==
X-Forwarded-Encrypted: i=1; AJvYcCWyWFTaY8lrJop1debSI1DRDMHb3tZ4MIk4JSsAqWB7FjiDaTnlRLaU8S1DA3ruono9hlVQ2kZSUrK1dWR6mfgILNtKDQXGfw5bYxptyg==
X-Gm-Message-State: AOJu0YyEotplM5zMqVI+i4Eo8cOPFJ+fOQcr2ED/0spG8lkQlF+i26NI
	qOsvesr90VvfpwfiXtdxlOq7NSnht1LbvIwBn96N6vMPvG07lM/TYx+5n/S6kUU/CSC6J3AhU12
	a
X-Google-Smtp-Source: AGHT+IEFSSJzYmFAuVbZUHrMPQMkLG1ec7ApXhKK3ZqH/fcywwA+FrikIgz6KzbnUY/6+3u4RJJvjQ==
X-Received: by 2002:a05:620a:9345:b0:794:ef4e:721b with SMTP id af79cd13be357-794ef4e79f9mr171423385a.48.1717099705580;
        Thu, 30 May 2024 13:08:25 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f317074asm9459885a.110.2024.05.30.13.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 13:08:25 -0700 (PDT)
Date: Thu, 30 May 2024 16:08:23 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm
Subject: Re: [PATCH RFC v2 12/19] fuse: {uring} Add uring sqe commit and
 fetch support
Message-ID: <20240530200823.GD2210558@perftesting>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-12-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-12-d149476b1d65@ddn.com>

On Wed, May 29, 2024 at 08:00:47PM +0200, Bernd Schubert wrote:
> This adds support for fuse request completion through ring SQEs
> (FUSE_URING_REQ_COMMIT_AND_FETCH handling). After committing
> the ring entry it becomes available for new fuse requests.
> Handling of requests through the ring (SQE/CQE handling)
> is complete now.
> 
> Fuse request data are copied through the mmaped ring buffer,
> there is no support for any zero copy yet.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev_uring.c | 311 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 311 insertions(+)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 48b1118b64f4..5269b3f8891e 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -31,12 +31,23 @@
>  #include <linux/topology.h>
>  #include <linux/io_uring/cmd.h>
>  
> +static void fuse_uring_req_end_and_get_next(struct fuse_ring_ent *ring_ent,
> +					    bool set_err, int error,
> +					    unsigned int issue_flags);
> +

Just order this above all the users instead of putting a declaration here.

>  static void fuse_ring_ring_ent_unset_userspace(struct fuse_ring_ent *ent)
>  {
>  	clear_bit(FRRS_USERSPACE, &ent->state);
>  	list_del_init(&ent->list);
>  }
>  
> +static void
> +fuse_uring_async_send_to_ring(struct io_uring_cmd *cmd,
> +			      unsigned int issue_flags)
> +{
> +	io_uring_cmd_done(cmd, 0, 0, issue_flags);
> +}
> +
>  /* Update conn limits according to ring values */
>  static void fuse_uring_conn_cfg_limits(struct fuse_ring *ring)
>  {
> @@ -350,6 +361,188 @@ int fuse_uring_queue_cfg(struct fuse_ring *ring,
>  	return 0;
>  }
>  
> +/*
> + * Checks for errors and stores it into the request
> + */
> +static int fuse_uring_ring_ent_has_err(struct fuse_ring *ring,
> +				       struct fuse_ring_ent *ring_ent)
> +{
> +	struct fuse_conn *fc = ring->fc;
> +	struct fuse_req *req = ring_ent->fuse_req;
> +	struct fuse_out_header *oh = &req->out.h;
> +	int err;
> +
> +	if (oh->unique == 0) {
> +		/* Not supportd through request based uring, this needs another
> +		 * ring from user space to kernel
> +		 */
> +		pr_warn("Unsupported fuse-notify\n");
> +		err = -EINVAL;
> +		goto seterr;
> +	}
> +
> +	if (oh->error <= -512 || oh->error > 0) {

What is -512?  No magic numbers please.

> +		err = -EINVAL;
> +		goto seterr;
> +	}
> +
> +	if (oh->error) {
> +		err = oh->error;
> +		pr_devel("%s:%d err=%d op=%d req-ret=%d", __func__, __LINE__,
> +			 err, req->args->opcode, req->out.h.error);
> +		goto err; /* error already set */
> +	}
> +
> +	if ((oh->unique & ~FUSE_INT_REQ_BIT) != req->in.h.unique) {
> +		pr_warn("Unpexted seqno mismatch, expected: %llu got %llu\n",
> +			req->in.h.unique, oh->unique & ~FUSE_INT_REQ_BIT);
> +		err = -ENOENT;
> +		goto seterr;
> +	}
> +
> +	/* Is it an interrupt reply ID?	 */
> +	if (oh->unique & FUSE_INT_REQ_BIT) {
> +		err = 0;
> +		if (oh->error == -ENOSYS)
> +			fc->no_interrupt = 1;
> +		else if (oh->error == -EAGAIN) {
> +			/* XXX Interrupts not handled yet */
> +			/* err = queue_interrupt(req); */
> +			pr_warn("Intrerupt EAGAIN not supported yet");
> +			err = -EINVAL;
> +		}
> +
> +		goto seterr;
> +	}
> +
> +	return 0;
> +
> +seterr:
> +	pr_devel("%s:%d err=%d op=%d req-ret=%d", __func__, __LINE__, err,
> +		 req->args->opcode, req->out.h.error);
> +	oh->error = err;
> +err:
> +	pr_devel("%s:%d err=%d op=%d req-ret=%d", __func__, __LINE__, err,
> +		 req->args->opcode, req->out.h.error);
> +	return err;
> +}
> +
> +/*
> + * Copy data from the ring buffer to the fuse request
> + */
> +static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
> +				     struct fuse_req *req,
> +				     struct fuse_ring_req *rreq)
> +{
> +	struct fuse_copy_state cs;
> +	struct fuse_args *args = req->args;
> +
> +	fuse_copy_init(&cs, 0, NULL);
> +	cs.is_uring = 1;
> +	cs.ring.buf = rreq->in_out_arg;
> +
> +	if (rreq->in_out_arg_len > ring->req_arg_len) {
> +		pr_devel("Max ring buffer len exceeded (%u vs %zu\n",
> +			 rreq->in_out_arg_len, ring->req_arg_len);
> +		return -EINVAL;
> +	}
> +	cs.ring.buf_sz = rreq->in_out_arg_len;
> +	cs.req = req;
> +
> +	pr_devel("%s:%d buf=%p len=%d args=%d\n", __func__, __LINE__,
> +		 cs.ring.buf, cs.ring.buf_sz, args->out_numargs);
> +
> +	return fuse_copy_out_args(&cs, args, rreq->in_out_arg_len);
> +}
> +
> +/*
> + * Copy data from the req to the ring buffer
> + */
> +static int fuse_uring_copy_to_ring(struct fuse_ring *ring, struct fuse_req *req,
> +				   struct fuse_ring_req *rreq)
> +{
> +	struct fuse_copy_state cs;
> +	struct fuse_args *args = req->args;
> +	int err;
> +
> +	fuse_copy_init(&cs, 1, NULL);
> +	cs.is_uring = 1;
> +	cs.ring.buf = rreq->in_out_arg;
> +	cs.ring.buf_sz = ring->req_arg_len;
> +	cs.req = req;
> +
> +	pr_devel("%s:%d buf=%p len=%d args=%d\n", __func__, __LINE__,
> +		 cs.ring.buf, cs.ring.buf_sz, args->out_numargs);
> +
> +	err = fuse_copy_args(&cs, args->in_numargs, args->in_pages,
> +			     (struct fuse_arg *)args->in_args, 0);
> +	rreq->in_out_arg_len = cs.ring.offset;

Is this ok if there's an error?  I genuinely don't know, maybe add a comment for
idiots like me?

> +
> +	pr_devel("%s:%d buf=%p len=%d args=%d err=%d\n", __func__, __LINE__,
> +		 cs.ring.buf, cs.ring.buf_sz, args->out_numargs, err);
> +
> +	return err;
> +}
> +
> +/*
> + * Write data to the ring buffer and send the request to userspace,
> + * userspace will read it
> + * This is comparable with classical read(/dev/fuse)
> + */
> +static void fuse_uring_send_to_ring(struct fuse_ring_ent *ring_ent,
> +				    unsigned int issue_flags, bool send_in_task)
> +{
> +	struct fuse_ring *ring = ring_ent->queue->ring;
> +	struct fuse_ring_req *rreq = ring_ent->rreq;
> +	struct fuse_req *req = ring_ent->fuse_req;
> +	struct fuse_ring_queue *queue = ring_ent->queue;
> +	int err = 0;
> +
> +	spin_lock(&queue->lock);
> +
> +	if (WARN_ON(test_bit(FRRS_USERSPACE, &ring_ent->state) ||
> +		   (test_bit(FRRS_FREED, &ring_ent->state)))) {

WARN_ON(x || b)

Makes me sad when it trips because IDK which one it was, please make them have
their own warn condition.

Also I don't love using WARN_ON() in an if statement if it can be avoided, so
maybe

if (test_bit() || test_bit()) {
	WARN_ON_ONCE(test_bit(USERSPACE));
	WARN_ON_ONCE(test_bit(FREED));
	err = -EIO;
}

Also again I'm sorry for not bringing this up early, I'd prefer WARN_ON_ONCE().
History has shown me many a hung box because I thought this would never happen
and now it's spewing stack traces to my slow ass serial console and I can't get
the box to respond at all.

> +		pr_err("qid=%d tag=%d ring-req=%p buf_req=%p invalid state %lu on send\n",
> +		       queue->qid, ring_ent->tag, ring_ent, rreq,
> +		       ring_ent->state);
> +		err = -EIO;
> +	} else {
> +		set_bit(FRRS_USERSPACE, &ring_ent->state);
> +		list_add(&ring_ent->list, &queue->ent_in_userspace);
> +	}
> +
> +	spin_unlock(&queue->lock);
> +	if (err)
> +		goto err;
> +
> +	err = fuse_uring_copy_to_ring(ring, req, rreq);
> +	if (unlikely(err)) {
> +		spin_lock(&queue->lock);
> +		fuse_ring_ring_ent_unset_userspace(ring_ent);
> +		spin_unlock(&queue->lock);
> +		goto err;
> +	}
> +
> +	/* ring req go directly into the shared memory buffer */
> +	rreq->in = req->in.h;
> +	set_bit(FR_SENT, &req->flags);
> +
> +	pr_devel("%s qid=%d tag=%d state=%lu cmd-done op=%d unique=%llu issue_flags=%u\n",
> +		 __func__, ring_ent->queue->qid, ring_ent->tag, ring_ent->state,
> +		 rreq->in.opcode, rreq->in.unique, issue_flags);
> +
> +	if (send_in_task)
> +		io_uring_cmd_complete_in_task(ring_ent->cmd,
> +					      fuse_uring_async_send_to_ring);
> +	else
> +		io_uring_cmd_done(ring_ent->cmd, 0, 0, issue_flags);
> +
> +	return;
> +
> +err:
> +	fuse_uring_req_end_and_get_next(ring_ent, true, err, issue_flags);
> +}
> +
>  /*
>   * Put a ring request onto hold, it is no longer used for now.
>   */
> @@ -381,6 +574,104 @@ static void fuse_uring_ent_avail(struct fuse_ring_ent *ring_ent,
>  	set_bit(FRRS_WAIT, &ring_ent->state);
>  }
>  
> +/*
> + * Assign a fuse queue entry to the given entry
> + */
> +static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ring_ent,
> +					   struct fuse_req *req)
> +{
> +	clear_bit(FRRS_WAIT, &ring_ent->state);
> +	list_del_init(&req->list);
> +	clear_bit(FR_PENDING, &req->flags);
> +	ring_ent->fuse_req = req;
> +	set_bit(FRRS_FUSE_REQ, &ring_ent->state);
> +}
> +
> +/*
> + * Release a uring entry and fetch the next fuse request if available
> + *
> + * @return true if a new request has been fetched
> + */
> +static bool fuse_uring_ent_release_and_fetch(struct fuse_ring_ent *ring_ent)
> +{
> +	struct fuse_req *req = NULL;
> +	struct fuse_ring_queue *queue = ring_ent->queue;
> +	struct list_head *req_queue = ring_ent->async ?
> +		&queue->async_fuse_req_queue : &queue->sync_fuse_req_queue;
> +
> +	spin_lock(&ring_ent->queue->lock);
> +	fuse_uring_ent_avail(ring_ent, queue);
> +	if (!list_empty(req_queue)) {
> +		req = list_first_entry(req_queue, struct fuse_req, list);
> +		fuse_uring_add_req_to_ring_ent(ring_ent, req);
> +		list_del_init(&ring_ent->list);
> +	}
> +	spin_unlock(&ring_ent->queue->lock);
> +
> +	return req ? true : false;
> +}
> +
> +/*
> + * Finalize a fuse request, then fetch and send the next entry, if available
> + *
> + * has lock/unlock/lock to avoid holding the lock on calling fuse_request_end
> + */
> +static void fuse_uring_req_end_and_get_next(struct fuse_ring_ent *ring_ent,
> +					    bool set_err, int error,
> +					    unsigned int issue_flags)
> +{
> +	struct fuse_req *req = ring_ent->fuse_req;
> +	int has_next;
> +
> +	if (set_err)
> +		req->out.h.error = error;

The set_err thing seems redundant since we always have it set to true if error
is set, so just drop this bit and set error if there's an error.

> +
> +	clear_bit(FR_SENT, &req->flags);
> +	fuse_request_end(ring_ent->fuse_req);
> +	ring_ent->fuse_req = NULL;
> +	clear_bit(FRRS_FUSE_REQ, &ring_ent->state);
> +
> +	has_next = fuse_uring_ent_release_and_fetch(ring_ent);
> +	if (has_next) {
> +		/* called within uring context - use provided flags */
> +		fuse_uring_send_to_ring(ring_ent, issue_flags, false);
> +	}
> +}
> +
> +/*
> + * Read data from the ring buffer, which user space has written to
> + * This is comparible with handling of classical write(/dev/fuse).
> + * Also make the ring request available again for new fuse requests.
> + */
> +static void fuse_uring_commit_and_release(struct fuse_dev *fud,
> +					  struct fuse_ring_ent *ring_ent,
> +					  unsigned int issue_flags)
> +{
> +	struct fuse_ring_req *rreq = ring_ent->rreq;
> +	struct fuse_req *req = ring_ent->fuse_req;
> +	ssize_t err = 0;
> +	bool set_err = false;
> +
> +	req->out.h = rreq->out;
> +
> +	err = fuse_uring_ring_ent_has_err(fud->fc->ring, ring_ent);
> +	if (err) {
> +		/* req->out.h.error already set */
> +		pr_devel("%s:%d err=%zd oh->err=%d\n", __func__, __LINE__, err,
> +			 req->out.h.error);
> +		goto out;
> +	}
> +
> +	err = fuse_uring_copy_from_ring(fud->fc->ring, req, rreq);
> +	if (err)
> +		set_err = true;
> +
> +out:
> +	pr_devel("%s:%d ret=%zd op=%d req-ret=%d\n", __func__, __LINE__, err,
> +		 req->args->opcode, req->out.h.error);
> +	fuse_uring_req_end_and_get_next(ring_ent, set_err, err, issue_flags);
> +}
> +
>  /*
>   * fuse_uring_req_fetch command handling
>   */
> @@ -566,6 +857,26 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  
>  		spin_unlock(&queue->lock);
>  		break;
> +	case FUSE_URING_REQ_COMMIT_AND_FETCH:
> +		if (unlikely(!ring->ready)) {
> +			pr_info("commit and fetch, but fuse-uringis not ready.");
> +			goto err_unlock;
> +		}
> +
> +		if (!test_bit(FRRS_USERSPACE, &ring_ent->state)) {
> +			pr_info("qid=%d tag=%d state %lu SQE already handled\n",
> +				queue->qid, ring_ent->tag, ring_ent->state);
> +			goto err_unlock;
> +		}
> +
> +		fuse_ring_ring_ent_unset_userspace(ring_ent);
> +		spin_unlock(&queue->lock);
> +
> +		WRITE_ONCE(ring_ent->cmd, cmd);
> +		fuse_uring_commit_and_release(fud, ring_ent, issue_flags);
> +
> +		ret = 0;
> +		break;

Hmm ok this changes my comments on the previous patch slightly, tho I think
still it would be better to push this code into a helper as well and do the
locking in there, let me go look at the resulting code...yeah ok I think it's
still better to just have these two cases in their own helper.  Thanks,

Josef

