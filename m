Return-Path: <linux-fsdevel+bounces-55469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C00B0AABF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 21:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE241C41CD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 19:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA5121579F;
	Fri, 18 Jul 2025 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOBgDYRY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C616DEB3
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752867287; cv=none; b=hphuDzPVxYSxaH5pTKSzNNIVNHpaq+bblsoSymalWRx+1y1A9/WkUYGS4GfmrTD9iNJs7otDNNmFKrAdQl+GFQW8F/wWSaWGNiK1TUpqsRGkc3cdl+2OXsO86hAYS6E05meGgQ5hTlH4CPiOGtdau1+JEK+k9IBTgZfXDd6+uXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752867287; c=relaxed/simple;
	bh=2pdXGeg/FED1EgEUxQJOicrcFHkqRA1qQ62lUpH0Exg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6Pu2wwFgNrUkjTRF+MgdFy/SfzviQoQ5JLwed0SaDyshLGGalm7ksHen9D8iUgLhdkui45NZYu5mDueMAfBEK52MhQk2ial0EqyH9AE5LgtB1QiJIwAum0iymyti3x67NJNpvYS+zA+srFOQnVctruYI2JbU+LCKWx3uW2kRzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOBgDYRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F85C4CEEB;
	Fri, 18 Jul 2025 19:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752867286;
	bh=2pdXGeg/FED1EgEUxQJOicrcFHkqRA1qQ62lUpH0Exg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BOBgDYRYjZr0AJ997uG/MxyzRk3zbN8uNHv38pvlhwuoBnisyYGRpVtO5jKnVtrUz
	 s90uzv9OTIpYeTU6zS4lEesE9CintPG1sV6cV70Qd5RcXAGqzq7oNP4+I/fFqXSJ8t
	 WSdoaKo5dWXxpxaSlfTLP47Dt0ESDwvIVAN42nLxzVvgEKgC3KQyhU3avCsMMUkitz
	 H8r7VyApCs+NMjofR4E4T5nQgI/0jAgAa9VgkByVqlENlhY0m8nuWPZlLX+UJ1Cn3T
	 RjF5rrXcBzGi1xdkN/WaEClEiq3QB2y5Pnr/FljeOtNP5PqE0biOxwztTaH/TIbE14
	 deckxd2FChv3Q==
Date: Fri, 18 Jul 2025 12:34:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
	miklos@szeredi.hu, joannelkoong@gmail.com,
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20250718193446.GD2672029@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <286e65f0-a54c-46f0-86b7-e997d8bbca21@bsbernd.com>
 <71f7e629-13ed-4320-a9c1-da2a16b2e26d@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71f7e629-13ed-4320-a9c1-da2a16b2e26d@bsbernd.com>

On Fri, Jul 18, 2025 at 08:07:30PM +0200, Bernd Schubert wrote:
> 
> > 
> > Please see the two attached patches, which are needed for fuse-io-uring.
> > I can also send them separately, if you prefer.
> 
> We (actually Horst) is just testing it as Horst sees failing xfs tests in
> our branch with tmp page removal
> 
> Patch 2 needs this addition (might be more, as I didn't test). 
> I had it in first, but then split the patch and missed that.

Aha, I noticed that the flush didn't quite work when uring was enabled.
I don't generally enable uring for testing because I already wrote a lot
of shaky code and uring support is new.

Though I'm afraid I have no opinion on this, because I haven't looked
deeply into dev_uring.c.

--D

> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index eca457d1005e..acf11eadbf3b 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -123,6 +123,9 @@ void fuse_uring_flush_bg(struct fuse_conn *fc)
>         struct fuse_ring_queue *queue;
>         struct fuse_ring *ring = fc->ring;
>  
> +       if (!ring)
> +               return;
> +
>         for (qid = 0; qid < ring->nr_queues; qid++) {
>                 queue = READ_ONCE(ring->queues[qid]);
>                 if (!queue)
> 
> 

> fuse: Refactor io-uring bg queue flush and queue abort
> 
> From: Bernd Schubert <bschubert@ddn.com>
> 
> This is a preparation to allow fuse-io-uring bg queue
> flush from flush_bg_queue()
> 
> This does two function renames:
> fuse_uring_flush_bg -> fuse_uring_flush_queue_bg
> fuse_uring_abort_end_requests -> fuse_uring_flush_bg
> 
> And fuse_uring_abort_end_queue_requests() is moved to
> fuse_uring_stop_queues().
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev_uring.c   |   14 +++++++-------
>  fs/fuse/dev_uring_i.h |    4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 249b210becb1..eca457d1005e 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -47,7 +47,7 @@ static struct fuse_ring_ent *uring_cmd_to_ring_ent(struct io_uring_cmd *cmd)
>  	return pdu->ent;
>  }
>  
> -static void fuse_uring_flush_bg(struct fuse_ring_queue *queue)
> +static void fuse_uring_flush_queue_bg(struct fuse_ring_queue *queue)
>  {
>  	struct fuse_ring *ring = queue->ring;
>  	struct fuse_conn *fc = ring->fc;
> @@ -88,7 +88,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
>  	if (test_bit(FR_BACKGROUND, &req->flags)) {
>  		queue->active_background--;
>  		spin_lock(&fc->bg_lock);
> -		fuse_uring_flush_bg(queue);
> +		fuse_uring_flush_queue_bg(queue);
>  		spin_unlock(&fc->bg_lock);
>  	}
>  
> @@ -117,11 +117,11 @@ static void fuse_uring_abort_end_queue_requests(struct fuse_ring_queue *queue)
>  	fuse_dev_end_requests(&req_list);
>  }
>  
> -void fuse_uring_abort_end_requests(struct fuse_ring *ring)
> +void fuse_uring_flush_bg(struct fuse_conn *fc)
>  {
>  	int qid;
>  	struct fuse_ring_queue *queue;
> -	struct fuse_conn *fc = ring->fc;
> +	struct fuse_ring *ring = fc->ring;
>  
>  	for (qid = 0; qid < ring->nr_queues; qid++) {
>  		queue = READ_ONCE(ring->queues[qid]);
> @@ -133,10 +133,9 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring)
>  		WARN_ON_ONCE(ring->fc->max_background != UINT_MAX);
>  		spin_lock(&queue->lock);
>  		spin_lock(&fc->bg_lock);
> -		fuse_uring_flush_bg(queue);
> +		fuse_uring_flush_queue_bg(queue);
>  		spin_unlock(&fc->bg_lock);
>  		spin_unlock(&queue->lock);
> -		fuse_uring_abort_end_queue_requests(queue);
>  	}
>  }
>  
> @@ -475,6 +474,7 @@ void fuse_uring_stop_queues(struct fuse_ring *ring)
>  		if (!queue)
>  			continue;
>  
> +		fuse_uring_abort_end_queue_requests(queue);
>  		fuse_uring_teardown_entries(queue);
>  	}
>  
> @@ -1326,7 +1326,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>  	fc->num_background++;
>  	if (fc->num_background == fc->max_background)
>  		fc->blocked = 1;
> -	fuse_uring_flush_bg(queue);
> +	fuse_uring_flush_queue_bg(queue);
>  	spin_unlock(&fc->bg_lock);
>  
>  	/*
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 51a563922ce1..55f52508de3c 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -138,7 +138,7 @@ struct fuse_ring {
>  bool fuse_uring_enabled(void);
>  void fuse_uring_destruct(struct fuse_conn *fc);
>  void fuse_uring_stop_queues(struct fuse_ring *ring);
> -void fuse_uring_abort_end_requests(struct fuse_ring *ring);
> +void fuse_uring_flush_bg(struct fuse_conn *fc);
>  int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
>  void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req);
>  bool fuse_uring_queue_bq_req(struct fuse_req *req);
> @@ -153,7 +153,7 @@ static inline void fuse_uring_abort(struct fuse_conn *fc)
>  		return;
>  
>  	if (atomic_read(&ring->queue_refs) > 0) {
> -		fuse_uring_abort_end_requests(ring);
> +		fuse_uring_flush_bg(fc);
>  		fuse_uring_stop_queues(ring);
>  	}
>  }

> fuse: Flush the io-uring bg queue from fuse_uring_flush_bg
> 
> From: Bernd Schubert <bschubert@ddn.com>
> 
> This is useful to have a unique API to flush background requests.
> For example when the bg queue gets flushed before
> the remaining of fuse_conn_destroy().
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev.c         |    2 ++
>  fs/fuse/dev_uring.c   |    3 +++
>  fs/fuse/dev_uring_i.h |   10 +++++++---
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 5387e4239d6a..3f5f168cc28a 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -426,6 +426,8 @@ static void flush_bg_queue(struct fuse_conn *fc)
>  		fc->active_background++;
>  		fuse_send_one(fiq, req);
>  	}
> +
> +	fuse_uring_flush_bg(fc);
>  }
>  
>  /*
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index eca457d1005e..acf11eadbf3b 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -123,6 +123,9 @@ void fuse_uring_flush_bg(struct fuse_conn *fc)
>  	struct fuse_ring_queue *queue;
>  	struct fuse_ring *ring = fc->ring;
>  
> +	if (!ring)
> +		return;
> +
>  	for (qid = 0; qid < ring->nr_queues; qid++) {
>  		queue = READ_ONCE(ring->queues[qid]);
>  		if (!queue)
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 55f52508de3c..fca2184e8d94 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -152,10 +152,10 @@ static inline void fuse_uring_abort(struct fuse_conn *fc)
>  	if (ring == NULL)
>  		return;
>  
> -	if (atomic_read(&ring->queue_refs) > 0) {
> -		fuse_uring_flush_bg(fc);
> +	/* Assumes bg queues were already flushed before */
> +
> +	if (atomic_read(&ring->queue_refs) > 0)
>  		fuse_uring_stop_queues(ring);
> -	}
>  }
>  
>  static inline void fuse_uring_wait_stopped_queues(struct fuse_conn *fc)
> @@ -206,6 +206,10 @@ static inline bool fuse_uring_request_expired(struct fuse_conn *fc)
>  	return false;
>  }
>  
> +static inline void fuse_uring_flush_bg(struct fuse_conn *fc)
> +{
> +}
> +
>  #endif /* CONFIG_FUSE_IO_URING */
>  
>  #endif /* _FS_FUSE_DEV_URING_I_H */


