Return-Path: <linux-fsdevel+bounces-20536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFBA8D4F7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 17:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616B31C23638
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CCA21106;
	Thu, 30 May 2024 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XLmpFthV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD36208A0
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717084444; cv=none; b=WOWQsFdSv6veKgPtNYqEwO4mOGglryOfasIQ99uyrykOSkWItVBaYUUebkzXDqNzTY/RXvX/r8hnHFY0AiBw7eK9hdnoLxVU5BrgvUgNE7R1LE0tlIS0aTrtvfwaXTkS1H59XIHq3cJ+7eOXRKjL8nfZkUFAUkcUJtlWvue8qZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717084444; c=relaxed/simple;
	bh=cVMX3UBU8J47mJiQNYdNAzYAJVVEnuK/j+0jAKH8T+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXvF1sVp/SRqEBNwEBTW/cqsx9+Bh0+jnQnAhvBnSAFNw8H1QdgwGJrCPIn5T8XtiltAsHgibPmFpKl7W1IdkowPfj4YZv6iDpps3Dzs7wgabHsYnGsT1OOli686otGvCxc57luvSu96PWpjY5hvyeaCR+5CR7cF1LSS+6eDx0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XLmpFthV; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ad8243dba8so4945056d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717084441; x=1717689241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1euDqGcy7hWNnLQNTmhBW6nzxAFg2b2UrgaSZt/rOto=;
        b=XLmpFthVFqNErfncAjypL2Wablyf5UuON8j2Fxd95VHxKDF/8c+mz4JAbtXshWdN53
         sPqJKaW0iCmIn2vp28zGbeAtgkm7tXC0uJSNpoNlEgYwtZXxaBkhg/Q/iSZFnV/LIkMm
         2MuweDF9QWvlUDXZnhLQn4WBs3XEiRrEMytRcJWzOI23zcv7Wz0zpgv5JjqIknzcHWj5
         WgJt8L87KyIWG9jbJPbY1qhhI2u0ljhaELuACbHtihPbmmT7wCjZ5xHyQMA5pvJGP8/R
         W1Hw0u4Bjri3Edfh1izsqoz0duX2xhv0bxeF2jHJn/tNRBEPI5HoKGd4qV6eM5HoA02B
         9Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717084441; x=1717689241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1euDqGcy7hWNnLQNTmhBW6nzxAFg2b2UrgaSZt/rOto=;
        b=wBpN9T1BYRUfOnw2Ym5GZ0DSmuuDiyy4j0siPoUOg4LDf67umcWP2fb5eybwZM5Sph
         7N/O0AKCeeQ6jP3/kAESyowODUfY4yKKvGAJNN7unrNygZUT/07OqcmfIXgweFh8DFwb
         etVXe4SU9N5m+fIEX9yvp6AsNAADjynF9P/+kKWZcwYf2h7ZrAatpBb9TawsHch/PoCm
         YrnAoephbohH3WzlXCL1s7SrZE8dONEQfmJFZCIOkxnWsx9svecesKAy3v32mKtEZbRd
         7nwF985AwzoGTRRWMsQVjg4wRGFOlclhWRy0oJYDwSk6NGnr5f20nN+8ko6jAccYdeaf
         qFIA==
X-Forwarded-Encrypted: i=1; AJvYcCWeJdBMQq1uuO4OthoIj2vXZYqQiu6fbaxx6CaXUVyG/s8Z6IDIsqyEgKhYHGJ4XIibctVWI3utTk51SmW/+kaoDzpE29bBJQx8DMhmcQ==
X-Gm-Message-State: AOJu0Yy7+SEgC12zVKnKVrC5/z0AIrUKbJ7qAcGkcSLV5nEgFvvi4ccb
	lvTmbYXjeE3+9l5m5VnGATS4R2iTFo9SqizKkh3+OWdHb5cxizbPi73+K5rug5uPIKwRJPLB5mn
	g
X-Google-Smtp-Source: AGHT+IERtjK6msTsN4EnSh0liYaL3LGOGXmX86j3GBDYHNjEP5B193tDjBZ4N1cO8/4EmI/J6wyWog==
X-Received: by 2002:a05:6214:5a01:b0:6ab:9320:2fe5 with SMTP id 6a1803df08f44-6ae0ccd892amr27441836d6.63.1717084441327;
        Thu, 30 May 2024 08:54:01 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad88f07f98sm33991296d6.124.2024.05.30.08.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:54:00 -0700 (PDT)
Date: Thu, 30 May 2024 11:54:00 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm
Subject: Re: [PATCH RFC v2 08/19] fuse: Add the queue configuration ioctl
Message-ID: <20240530155400.GE2205585@perftesting>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-8-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-8-d149476b1d65@ddn.com>

On Wed, May 29, 2024 at 08:00:43PM +0200, Bernd Schubert wrote:
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev.c             | 10 +++++
>  fs/fuse/dev_uring.c       | 95 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/dev_uring_i.h     | 18 +++++++++
>  fs/fuse/fuse_i.h          |  3 ++
>  include/uapi/linux/fuse.h | 26 +++++++++++++
>  5 files changed, 152 insertions(+)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 349c1d16b0df..78c05516da7f 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2395,6 +2395,12 @@ static long fuse_uring_ioctl(struct file *file, __u32 __user *argp)
>  	if (res != 0)
>  		return -EFAULT;
>  
> +	if (cfg.cmd == FUSE_URING_IOCTL_CMD_QUEUE_CFG) {
> +		res = _fuse_dev_ioctl_clone(file, cfg.qconf.control_fd);
> +		if (res != 0)
> +			return res;
> +	}
> +
>  	fud = fuse_get_dev(file);
>  	if (fud == NULL)
>  		return -ENODEV;
> @@ -2424,6 +2430,10 @@ static long fuse_uring_ioctl(struct file *file, __u32 __user *argp)
>  		if (res != 0)
>  			return res;
>  		break;
> +		case FUSE_URING_IOCTL_CMD_QUEUE_CFG:
> +			fud->uring_dev = 1;
> +			res = fuse_uring_queue_cfg(fc->ring, &cfg.qconf);
> +		break;
>  	default:
>  		res = -EINVAL;
>  	}
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 9491bdaa5716..2c0ccb378908 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -144,6 +144,39 @@ static char *fuse_uring_alloc_queue_buf(int size, int node)
>  	return buf ? buf : ERR_PTR(-ENOMEM);
>  }
>  
> +/*
> + * mmaped allocated buffers, but does not know which queue that is for
> + * This ioctl uses the userspace address as key to identify the kernel address
> + * and assign it to the kernel side of the queue.
> + */
> +static int fuse_uring_ioctl_mem_reg(struct fuse_ring *ring,
> +				    struct fuse_ring_queue *queue,
> +				    uint64_t uaddr)
> +{
> +	struct rb_node *node;
> +	struct fuse_uring_mbuf *entry;
> +	int tag;
> +
> +	node = rb_find((const void *)uaddr, &ring->mem_buf_map,
> +		       fuse_uring_rb_tree_buf_cmp);
> +	if (!node)
> +		return -ENOENT;
> +	entry = rb_entry(node, struct fuse_uring_mbuf, rb_node);
> +
> +	rb_erase(node, &ring->mem_buf_map);
> +
> +	queue->queue_req_buf = entry->kbuf;
> +
> +	for (tag = 0; tag < ring->queue_depth; tag++) {
> +		struct fuse_ring_ent *ent = &queue->ring_ent[tag];
> +
> +		ent->rreq = entry->kbuf + tag * ring->req_buf_sz;
> +	}
> +
> +	kfree(node);
> +	return 0;
> +}
> +
>  /**
>   * fuse uring mmap, per ring qeuue.
>   * Userpsace maps a kernel allocated ring/queue buffer. For numa awareness,
> @@ -234,3 +267,65 @@ fuse_uring_mmap(struct file *filp, struct vm_area_struct *vma)
>  
>  	return ret;
>  }
> +
> +int fuse_uring_queue_cfg(struct fuse_ring *ring,
> +			 struct fuse_ring_queue_config *qcfg)
> +{
> +	int tag;
> +	struct fuse_ring_queue *queue;
> +
> +	if (qcfg->qid >= ring->nr_queues) {
> +		pr_info("fuse ring queue config: qid=%u >= nr-queues=%zu\n",
> +			qcfg->qid, ring->nr_queues);
> +		return -EINVAL;
> +	}
> +	queue = fuse_uring_get_queue(ring, qcfg->qid);
> +
> +	if (queue->configured) {
> +		pr_info("fuse ring qid=%u already configured!\n", queue->qid);
> +		return -EALREADY;
> +	}
> +
> +	mutex_lock(&ring->start_stop_lock);
> +	fuse_uring_ioctl_mem_reg(ring, queue, qcfg->uaddr);
> +	mutex_unlock(&ring->start_stop_lock);

You're not handling the error here.  Thanks,

Josef

