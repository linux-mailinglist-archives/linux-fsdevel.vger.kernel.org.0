Return-Path: <linux-fsdevel+bounces-20491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376D98D403F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 23:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E3A1C21D77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 21:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4AE1C68AE;
	Wed, 29 May 2024 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="DLmmSugH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B07E542
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717017894; cv=none; b=GCVF8KKvBaTnn0HZkYtQil38dOKE5BP4oDau4JX2HLl+ag0adOLCSwezjnG/tnNo2RmkzvVVQDahpdxqtCpHvl+t0haf4mZksCdAjAdCYVwDmRPbTWXNX3XUxI60RqtHDcUqU9EYr1VKodSQ/KpIOQ+BxiKi1kymAehpXcTo4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717017894; c=relaxed/simple;
	bh=iPWl6N5GSAg7YKM5K8zfnjemXxkhscSwSzbJrltDIIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvjYwuNX4e8Rm5gaQ5xCFzwzA+WA6K5ifuY0K8p59Ey4EJ1C900nR75fbmmISHtXkOB01X6NUyL5hAtPmiP+hvTiIwEkXaDyqd2UFrvME3PhfuKeqM4uKrpdtuehz3A/GNomybCwYOMAhvsFNGJYxAj9CDzCyRJ4Tl2jc0nzR6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=DLmmSugH; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-62a08092c4dso1537947b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717017892; x=1717622692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8r897WkAV4d+S0QgJKILxRzLdkkfdUwpw8+khOf80nA=;
        b=DLmmSugHmjxG1WE3Vqv0jl9hRMk2piii+Gw6+Tjd2sTsiWkzZt0nkkV6zA0TzVhvjr
         ai6IbBksiDqRXMa2ukVvJnqOWutL4MEmq5tbr79xXLBBvA2SKrk25kMHt5zSZ/nwRAlA
         aqA83gVkqgaghGP2Yvt6U2B5FeYUAhYM4WUd3+JJ2bfeeJF0eEn30bK9R0kTuVfZG+16
         d8y1QBash+lL5nVM5hXb3x0tx2nSMlwGAuqY5z7eIlvKBMl91l/2jtMmoEcdUdqYuR2L
         kN2RPV5/jlFT2Y7wC8wU4/ZUvSx24HE6JsYQQ4ucVQj5amUMxNgyY1h3Eip5n2j8ZMcW
         2DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717017892; x=1717622692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8r897WkAV4d+S0QgJKILxRzLdkkfdUwpw8+khOf80nA=;
        b=qIKPoZ/jVr6RtUPXSqWGQGpm+z/mjY7izO6ac9AkBcXx+Yu0lJ3zLT2BAjKku/Egcu
         fcTMJN6ZGm7z634N77fqYemPdcNlMrBvi087IjD/tu+302OGnIHYd1s1vazwXrlb27qU
         78ZsNFiBcR2ROOoYYw6Y6YF5PO+C5KeAQf2LW48ODelg2oH60CwKEDDLr0fzjJ3i0rDE
         gYDHkDtg+ravu4y/QINoBNvkhC7Yxj1WC/cZTxseTAwMAzDNmrTTtKeUQv2n9dzUo36g
         tzMts7bgr/8DSHHYkx4G01iBzecAVOAmc04IaOqg1vUzmtGnuClvFuC3oFSkyqNYLiXP
         BBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW96iRdCkiUcGkul+idlDUoBDlJ7bX/DBmjfSdAGe3Rh+ck/mf419cuJtfBE2G3MDZG2lcM6fFjUD0UVUyNIkY9IoVoLIhLlXIyvNQmIg==
X-Gm-Message-State: AOJu0YxMHR9YIOND1qUCRPXBCt6H4+3FUkZKJBizB8QizfjRYtwSh7CJ
	4SM7ro61StjSUcWcc5yni2YTsJR7FCqGJeEaJxdRpmodeZxUsOj+FxoR5jmqrRs=
X-Google-Smtp-Source: AGHT+IFPYVM3p2K8T5vO8ZYL11hLgOitfNY1OaWDbtvs9ZyN6lhO4rFcHpO17mZgaAY2TEX89OiQvQ==
X-Received: by 2002:a05:690c:f87:b0:615:18f8:d32a with SMTP id 00721157ae682-62c6bcdbacamr3576687b3.36.1717017891644;
        Wed, 29 May 2024 14:24:51 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd324fcsm502880685a.120.2024.05.29.14.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 14:24:51 -0700 (PDT)
Date: Wed, 29 May 2024 17:24:50 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm
Subject: Re: [PATCH RFC v2 05/19] fuse: Add a uring config ioctl
Message-ID: <20240529212450.GE2182086@perftesting>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-5-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-5-d149476b1d65@ddn.com>

On Wed, May 29, 2024 at 08:00:40PM +0200, Bernd Schubert wrote:
> This only adds the initial ioctl for basic fuse-uring initialization.
> More ioctl types will be added later to initialize queues.
> 
> This also adds data structures needed or initialized by the ioctl
> command and that will be used later.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/Kconfig           |  12 +++
>  fs/fuse/Makefile          |   1 +
>  fs/fuse/dev.c             |  91 ++++++++++++++++--
>  fs/fuse/dev_uring.c       | 122 +++++++++++++++++++++++
>  fs/fuse/dev_uring_i.h     | 239 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_dev_i.h      |   1 +
>  fs/fuse/fuse_i.h          |   5 +
>  fs/fuse/inode.c           |   3 +
>  include/uapi/linux/fuse.h |  73 ++++++++++++++
>  9 files changed, 538 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 8674dbfbe59d..11f37cefc94b 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -63,3 +63,15 @@ config FUSE_PASSTHROUGH
>  	  to be performed directly on a backing file.
>  
>  	  If you want to allow passthrough operations, answer Y.
> +
> +config FUSE_IO_URING
> +	bool "FUSE communication over io-uring"
> +	default y
> +	depends on FUSE_FS
> +	depends on IO_URING
> +	help
> +	  This allows sending FUSE requests over the IO uring interface and
> +          also adds request core affinity.
> +
> +	  If you want to allow fuse server/client communication through io-uring,
> +	  answer Y
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index 6e0228c6d0cb..7193a14374fd 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -11,5 +11,6 @@ fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
>  fuse-y += iomode.o
>  fuse-$(CONFIG_FUSE_DAX) += dax.o
>  fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
> +fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
>  
>  virtiofs-y := virtio_fs.o
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index b98ecb197a28..bc77413932cf 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -8,6 +8,7 @@
>  
>  #include "fuse_i.h"
>  #include "fuse_dev_i.h"
> +#include "dev_uring_i.h"
>  
>  #include <linux/init.h>
>  #include <linux/module.h>
> @@ -26,6 +27,13 @@
>  MODULE_ALIAS_MISCDEV(FUSE_MINOR);
>  MODULE_ALIAS("devname:fuse");
>  
> +#if IS_ENABLED(CONFIG_FUSE_IO_URING)
> +static bool __read_mostly enable_uring;
> +module_param(enable_uring, bool, 0644);
> +MODULE_PARM_DESC(enable_uring,
> +		 "Enable uring userspace communication through uring.");
> +#endif
> +
>  static struct kmem_cache *fuse_req_cachep;
>  
>  static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
> @@ -2297,16 +2305,12 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
>  	return 0;
>  }
>  
> -static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
> +static long _fuse_dev_ioctl_clone(struct file *file, int oldfd)
>  {
>  	int res;
> -	int oldfd;
>  	struct fuse_dev *fud = NULL;
>  	struct fd f;
>  
> -	if (get_user(oldfd, argp))
> -		return -EFAULT;
> -
>  	f = fdget(oldfd);
>  	if (!f.file)
>  		return -EINVAL;
> @@ -2329,6 +2333,16 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
>  	return res;
>  }
>  
> +static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
> +{
> +	int oldfd;
> +
> +	if (get_user(oldfd, argp))
> +		return -EFAULT;
> +
> +	return _fuse_dev_ioctl_clone(file, oldfd);
> +}
> +
>  static long fuse_dev_ioctl_backing_open(struct file *file,
>  					struct fuse_backing_map __user *argp)
>  {
> @@ -2364,8 +2378,65 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
>  	return fuse_backing_close(fud->fc, backing_id);
>  }
>  
> -static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
> -			   unsigned long arg)
> +/**
> + * Configure the queue for the given qid. First call will also initialize
> + * the ring for this connection.
> + */
> +static long fuse_uring_ioctl(struct file *file, __u32 __user *argp)
> +{
> +#if IS_ENABLED(CONFIG_FUSE_IO_URING)
> +	int res;
> +	struct fuse_uring_cfg cfg;
> +	struct fuse_dev *fud;
> +	struct fuse_conn *fc;
> +	struct fuse_ring *ring;
> +
> +	res = copy_from_user(&cfg, (void *)argp, sizeof(cfg));
> +	if (res != 0)
> +		return -EFAULT;
> +
> +	fud = fuse_get_dev(file);
> +	if (fud == NULL)
> +		return -ENODEV;
> +	fc = fud->fc;
> +
> +	switch (cfg.cmd) {
> +	case FUSE_URING_IOCTL_CMD_RING_CFG:
> +		if (READ_ONCE(fc->ring) == NULL)
> +			ring = kzalloc(sizeof(*fc->ring), GFP_KERNEL);
> +
> +		spin_lock(&fc->lock);
> +		if (fc->ring == NULL) {
> +			fc->ring = ring;

Need to have error handling here in case the kzalloc failed.

> +			fuse_uring_conn_init(fc->ring, fc);
> +		} else {
> +			kfree(ring);
> +		}
> +
> +		spin_unlock(&fc->lock);
> +		if (fc->ring == NULL)
> +			return -ENOMEM;
> +
> +		mutex_lock(&fc->ring->start_stop_lock);
> +		res = fuse_uring_conn_cfg(fc->ring, &cfg.rconf);
> +		mutex_unlock(&fc->ring->start_stop_lock);
> +
> +		if (res != 0)
> +			return res;
> +		break;
> +	default:
> +		res = -EINVAL;
> +	}
> +
> +		return res;
> +#else
> +	return -ENOTTY;
> +#endif
> +}
> +
> +static long
> +fuse_dev_ioctl(struct file *file, unsigned int cmd,
> +	       unsigned long arg)
>  {
>  	void __user *argp = (void __user *)arg;
>  
> @@ -2379,8 +2450,10 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
>  	case FUSE_DEV_IOC_BACKING_CLOSE:
>  		return fuse_dev_ioctl_backing_close(file, argp);
>  
> -	default:
> -		return -ENOTTY;
> +	case FUSE_DEV_IOC_URING:
> +		return fuse_uring_ioctl(file, argp);
> +

Instead just wrap the above in 

#ifdef CONFIG_FUSE_IO_URING
	case FUSE_DEV_IOC_URING:
		return fuse_uring_ioctl(file, argp);
#endif

instead of wrapping the entire function above in the check.
	
> +	default: return -ENOTTY;
>  	}
>  }
>  
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> new file mode 100644
> index 000000000000..702a994cf192
> --- /dev/null
> +++ b/fs/fuse/dev_uring.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FUSE: Filesystem in Userspace
> + * Copyright (c) 2023-2024 DataDirect Networks.
> + */
> +
> +#include "fuse_i.h"
> +#include "fuse_dev_i.h"
> +#include "dev_uring_i.h"
> +
> +#include "linux/compiler_types.h"
> +#include "linux/spinlock.h"
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/poll.h>
> +#include <linux/sched/signal.h>
> +#include <linux/uio.h>
> +#include <linux/miscdevice.h>
> +#include <linux/pagemap.h>
> +#include <linux/file.h>
> +#include <linux/slab.h>
> +#include <linux/pipe_fs_i.h>
> +#include <linux/swap.h>
> +#include <linux/splice.h>
> +#include <linux/sched.h>
> +#include <linux/io_uring.h>
> +#include <linux/mm.h>
> +#include <linux/io.h>
> +#include <linux/io_uring.h>
> +#include <linux/io_uring/cmd.h>
> +#include <linux/topology.h>
> +#include <linux/io_uring/cmd.h>
> +
> +/*
> + * Basic ring setup for this connection based on the provided configuration
> + */
> +int fuse_uring_conn_cfg(struct fuse_ring *ring, struct fuse_ring_config *rcfg)
> +{
> +	size_t queue_sz;
> +
> +	if (ring->configured) {
> +		pr_info("The ring is already configured.\n");
> +		return -EALREADY;
> +	}
> +
> +	if (rcfg->nr_queues == 0) {
> +		pr_info("zero number of queues is invalid.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (rcfg->nr_queues > 1 && rcfg->nr_queues != num_present_cpus()) {
> +		pr_info("nr-queues (%d) does not match nr-cores (%d).\n",
> +			rcfg->nr_queues, num_present_cpus());
> +		return -EINVAL;
> +	}
> +
> +	if (rcfg->req_arg_len < FUSE_RING_MIN_IN_OUT_ARG_SIZE) {
> +		pr_info("Per req buffer size too small (%d), min: %d\n",
> +			rcfg->req_arg_len, FUSE_RING_MIN_IN_OUT_ARG_SIZE);
> +		return -EINVAL;
> +	}
> +
> +	if (WARN_ON(ring->queues))
> +		return -EINVAL;
> +
> +	ring->numa_aware = rcfg->numa_aware;
> +	ring->nr_queues = rcfg->nr_queues;
> +	ring->per_core_queue = rcfg->nr_queues > 1;
> +
> +	ring->max_nr_sync = rcfg->sync_queue_depth;
> +	ring->max_nr_async = rcfg->async_queue_depth;
> +	ring->queue_depth = ring->max_nr_sync + ring->max_nr_async;
> +
> +	ring->req_arg_len = rcfg->req_arg_len;
> +	ring->req_buf_sz = rcfg->user_req_buf_sz;
> +
> +	ring->queue_buf_size = ring->req_buf_sz * ring->queue_depth;
> +
> +	queue_sz = sizeof(*ring->queues) +
> +		   ring->queue_depth * sizeof(struct fuse_ring_ent);
> +	ring->queues = kcalloc(rcfg->nr_queues, queue_sz, GFP_KERNEL);
> +	if (!ring->queues)
> +		return -ENOMEM;
> +	ring->queue_size = queue_sz;
> +	ring->configured = 1;
> +
> +	atomic_set(&ring->queue_refs, 0);
> +
> +	return 0;
> +}
> +
> +void fuse_uring_ring_destruct(struct fuse_ring *ring)
> +{
> +	unsigned int qid;
> +	struct rb_node *rbn;
> +
> +	for (qid = 0; qid < ring->nr_queues; qid++) {
> +		struct fuse_ring_queue *queue = fuse_uring_get_queue(ring, qid);
> +
> +		vfree(queue->queue_req_buf);
> +	}
> +
> +	kfree(ring->queues);
> +	ring->queues = NULL;
> +	ring->nr_queues_ioctl_init = 0;
> +	ring->queue_depth = 0;
> +	ring->nr_queues = 0;
> +
> +	rbn = rb_first(&ring->mem_buf_map);
> +	while (rbn) {
> +		struct rb_node *next = rb_next(rbn);
> +		struct fuse_uring_mbuf *entry =
> +			rb_entry(rbn, struct fuse_uring_mbuf, rb_node);
> +
> +		rb_erase(rbn, &ring->mem_buf_map);
> +		kfree(entry);
> +
> +		rbn = next;
> +	}
> +
> +	mutex_destroy(&ring->start_stop_lock);
> +}
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> new file mode 100644
> index 000000000000..58ab4671deff
> --- /dev/null
> +++ b/fs/fuse/dev_uring_i.h
> @@ -0,0 +1,239 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * FUSE: Filesystem in Userspace
> + * Copyright (c) 2023-2024 DataDirect Networks.
> + */
> +
> +#ifndef _FS_FUSE_DEV_URING_I_H
> +#define _FS_FUSE_DEV_URING_I_H
> +
> +#include "fuse_i.h"
> +#include "linux/compiler_types.h"
> +#include "linux/rbtree_types.h"
> +
> +#if IS_ENABLED(CONFIG_FUSE_IO_URING)
> +
> +/* IORING_MAX_ENTRIES */
> +#define FUSE_URING_MAX_QUEUE_DEPTH 32768
> +
> +struct fuse_uring_mbuf {
> +	struct rb_node rb_node;
> +	void *kbuf; /* kernel allocated ring request buffer */
> +	void *ubuf; /* mmaped address */
> +};
> +
> +/** A fuse ring entry, part of the ring queue */
> +struct fuse_ring_ent {
> +	/*
> +	 * pointer to kernel request buffer, userspace side has direct access
> +	 * to it through the mmaped buffer
> +	 */
> +	struct fuse_ring_req *rreq;
> +
> +	/* the ring queue that owns the request */
> +	struct fuse_ring_queue *queue;
> +
> +	struct io_uring_cmd *cmd;
> +
> +	struct list_head list;
> +
> +	/*
> +	 * state the request is currently in
> +	 * (enum fuse_ring_req_state)
> +	 */
> +	unsigned long state;
> +
> +	/* array index in the ring-queue */
> +	int tag;
> +
> +	/* is this an async or sync entry */
> +	unsigned int async : 1;
> +
> +	struct fuse_req *fuse_req; /* when a list request is handled */
> +};
> +
> +struct fuse_ring_queue {
> +	/* task belonging to the current queue */
> +	struct task_struct *server_task;
> +
> +	/*
> +	 * back pointer to the main fuse uring structure that holds this
> +	 * queue
> +	 */
> +	struct fuse_ring *ring;
> +
> +	/* issue flags when running in io-uring task context */
> +	unsigned int uring_cmd_issue_flags;
> +
> +	int qid;
> +
> +	/*
> +	 * available number of sync requests,
> +	 * loosely bound to fuse foreground requests
> +	 */
> +	int nr_req_sync;
> +
> +	/*
> +	 * available number of async requests
> +	 * loosely bound to fuse background requests
> +	 */
> +	int nr_req_async;
> +
> +	/* queue lock, taken when any value in the queue changes _and_ also
> +	 * a ring entry state changes.
> +	 */
> +	spinlock_t lock;
> +
> +	/* per queue memory buffer that is divided per request */
> +	char *queue_req_buf;
> +
> +	/* fuse fg/bg request types */
> +	struct list_head async_fuse_req_queue;
> +	struct list_head sync_fuse_req_queue;
> +
> +	/* available ring entries (struct fuse_ring_ent) */
> +	struct list_head async_ent_avail_queue;
> +	struct list_head sync_ent_avail_queue;
> +
> +	struct list_head ent_in_userspace;
> +
> +	unsigned int configured : 1;
> +	unsigned int stopped : 1;
> +
> +	/* size depends on queue depth */
> +	struct fuse_ring_ent ring_ent[] ____cacheline_aligned_in_smp;
> +};
> +
> +/**
> + * Describes if uring is for communication and holds alls the data needed
> + * for uring communication
> + */
> +struct fuse_ring {
> +	/* back pointer to fuse_conn */
> +	struct fuse_conn *fc;
> +
> +	/* number of ring queues */
> +	size_t nr_queues;
> +
> +	/* number of entries per queue */
> +	size_t queue_depth;
> +
> +	/* max arg size for a request */
> +	size_t req_arg_len;
> +
> +	/* req_arg_len + sizeof(struct fuse_req) */
> +	size_t req_buf_sz;
> +
> +	/* max number of background requests per queue */
> +	size_t max_nr_async;
> +
> +	/* max number of foreground requests */
> +	size_t max_nr_sync;
> +
> +	/* size of struct fuse_ring_queue + queue-depth * entry-size */
> +	size_t queue_size;
> +
> +	/* buffer size per queue, that is used per queue entry */
> +	size_t queue_buf_size;
> +
> +	/* Used to release the ring on stop */
> +	atomic_t queue_refs;
> +
> +	/* Hold ring requests */
> +	struct fuse_ring_queue *queues;
> +
> +	/* number of initialized queues with the ioctl */
> +	int nr_queues_ioctl_init;
> +
> +	/* number of SQEs initialized */
> +	atomic_t nr_sqe_init;
> +
> +	/* one queue per core or a single queue only ? */
> +	unsigned int per_core_queue : 1;
> +
> +	/* Is the ring completely iocl configured */
> +	unsigned int configured : 1;
> +
> +	/* numa aware memory allocation */
> +	unsigned int numa_aware : 1;
> +
> +	/* Is the ring read to take requests */
> +	unsigned int ready : 1;
> +
> +	/*
> +	 * Log ring entry states onces on stop when entries cannot be
> +	 * released
> +	 */
> +	unsigned int stop_debug_log : 1;
> +
> +	struct mutex start_stop_lock;
> +
> +	wait_queue_head_t stop_waitq;
> +
> +	/* mmaped ring entry memory buffers, mmaped values is the key,
> +	 * kernel pointer is the value
> +	 */
> +	struct rb_root mem_buf_map;
> +
> +	struct delayed_work stop_work;
> +	unsigned long stop_time;
> +};

This is mostly a preference thing, but you've added a huge amount of code that
isn't used in this patch, so it makes it hard for me to review without knowing
how the things are to be used.

Generally it's easier on reviewers if you're adding the structs as you need them
so you can clearly follow what the purpose of everything is.  Here I just have
to go look at the end result and figure out what everything does and if it makes
sense.  Thanks,

Josef

