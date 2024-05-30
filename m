Return-Path: <linux-fsdevel+bounces-20533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EFB8D4F38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 17:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D044B26869
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 15:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E71618308B;
	Thu, 30 May 2024 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NmILZgnJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB72187558
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083437; cv=none; b=RyY820jJDCYLc3zAcWdKPKh9RQkSH1dLcaQo4uwSn92j/NHPQIMCIRrLgWLefaHcHJXwC+I+FPtiX8eP3FYThUPgv/1gEVh59utRhYvOc3eqMa6Io+Gj01RCV1VFd95Etl3Q327v5TuXZ6f+7fvmKS56MUcN+/xjR5mViub2/zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083437; c=relaxed/simple;
	bh=iNm5ye00+KSYRkNv7sY85zIZsM69kjdljzK4e0dg4MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeYq5Go2v9CShck1r+L3WFuMX5b5Fw1qTxvbqu54VWzKbMrsjfrftTNQXy77epB0Ph6fCpnSfziM0fcbJBUdNr4MPsEQXmah+X70b3Ffmkc8tZcqC6/d/KTJ7E+W//6trGO3kzC4gGlopCqKimgVji2w3SYw1/Xv68sh4uUITpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=NmILZgnJ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-792b8d989e8so68661185a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717083435; x=1717688235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kuKAvSaFAGdbyJPbf33/lAj/70tjxyhx0zTWXp86ggw=;
        b=NmILZgnJY7LhcZpmRPFFSGg28fMV9K1fZdoWklwcFd4S8si4ZunifLbXkpY5Al/gaw
         0T3RiWFI5llgQqVSCHCFx2qyuYKBg2nGXG4uRs5R9ilD23tWoo0xvKYwaDkBeSAEy6re
         4ifrFKktDBD10jXFfyGO4VM+9ZIODvqu/npw2VBA9PlnX1Iez+4k1BbgRv9GIlHCWWKi
         RgzJwlA5DZ/U3nXAQKMxsdgNlEPOLwnKicJtdpCSb3BnXdxjs4TEHttaIZegwEAMSpkQ
         ix2xHRNAvLWrgxOBxocaWPdUCcVgYrlXdrXovRWsH/4O2nKVleWFzQA/6IFqsUydNzSJ
         ouiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717083435; x=1717688235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuKAvSaFAGdbyJPbf33/lAj/70tjxyhx0zTWXp86ggw=;
        b=B368rCWfTxq5dsEH4hwbk4UZA996W41pCFZZKEHEo7pxI6MKoTDgBB4gun8VMupWR7
         h2CUdqbpc42cbXYrsnTA1FIt/SBX1ZRfwkZ2JOmZv15sEGknwLHBWCbFf6mLhnDj4x5U
         7g+5NFuTEOWbiGuj5CPepNtE26Sv+CuMjWSgBEzKuYEaZhJBywhA8RF0qte/WCd+8Zhh
         vAxcDG5ZQhcJ3oai5MgMZwgtgqxk7mREJFByocQbm58xwMntJOchEmsLZzxZHmXtmNEi
         1astbvMatPeHX8lNIZNfeQk4ZBCYdj1aS9wGESUBWJEVOm3UxS4iVAEM+DLj5Ar5rLuG
         APYA==
X-Forwarded-Encrypted: i=1; AJvYcCVOgGh74DmPT30LkDIjEJF0sUTBoDoQSq+TSHL1qKMQkipPSYxU9F2tSPnnX5lvTQaxo9e6gT7I0Jb8++qj7Fslr3rZktYPTHU59eXljA==
X-Gm-Message-State: AOJu0YxPHvKyjTVblDGgRL3kB2XBvnwyymKzkw7gwm3Zoq0aPZNscLjg
	nsjZZ9qrEQDTWIox8SvqvLmttbULTbBr0JJzI9kq38CcfPQ3U1fVEfmeFWzmPIU=
X-Google-Smtp-Source: AGHT+IFKWSmChua+/7LpHjrZn8W64dIbDIgZrvHKbTL194dhtZOgcHiRrwEy1EktfFYKlhAA+Z+EgQ==
X-Received: by 2002:a05:620a:29c6:b0:792:9d7c:d2b0 with SMTP id af79cd13be357-794eaedddc6mr403276385a.15.1717083434632;
        Thu, 30 May 2024 08:37:14 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd339edsm559836085a.106.2024.05.30.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:37:14 -0700 (PDT)
Date: Thu, 30 May 2024 11:37:13 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm
Subject: Re: [PATCH RFC v2 07/19] fuse uring: Add an mmap method
Message-ID: <20240530153713.GD2205585@perftesting>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-7-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-7-d149476b1d65@ddn.com>

On Wed, May 29, 2024 at 08:00:42PM +0200, Bernd Schubert wrote:
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev.c             |   3 ++
>  fs/fuse/dev_uring.c       | 114 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/dev_uring_i.h     |  22 +++++++++
>  include/uapi/linux/fuse.h |   3 ++
>  4 files changed, 142 insertions(+)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index bc77413932cf..349c1d16b0df 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2470,6 +2470,9 @@ const struct file_operations fuse_dev_operations = {
>  	.fasync		= fuse_dev_fasync,
>  	.unlocked_ioctl = fuse_dev_ioctl,
>  	.compat_ioctl   = compat_ptr_ioctl,
> +#if IS_ENABLED(CONFIG_FUSE_IO_URING)

I'm loathe to use

#if IS_ENABLED()

when we can use

#ifdef CONFIG_FUSE_IO_URING

which is more standard across the kernel.

> +	.mmap		= fuse_uring_mmap,
> +#endif
>  };
>  EXPORT_SYMBOL_GPL(fuse_dev_operations);
>  
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 702a994cf192..9491bdaa5716 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -120,3 +120,117 @@ void fuse_uring_ring_destruct(struct fuse_ring *ring)
>  
>  	mutex_destroy(&ring->start_stop_lock);
>  }
> +
> +static inline int fuse_uring_current_nodeid(void)
> +{
> +	int cpu;
> +	const struct cpumask *proc_mask = current->cpus_ptr;
> +
> +	cpu = cpumask_first(proc_mask);
> +
> +	return cpu_to_node(cpu);

You don't need this, just use numa_node_id();

> +}
> +
> +static char *fuse_uring_alloc_queue_buf(int size, int node)
> +{
> +	char *buf;
> +
> +	if (size <= 0) {
> +		pr_info("Invalid queue buf size: %d.\n", size);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	buf = vmalloc_node_user(size, node);
> +	return buf ? buf : ERR_PTR(-ENOMEM);
> +}

This is excessive, we base size off of ring->queue_buf_size, or the
fuse_uring_mmap() size we get from the vma, which I don't think can ever be 0 or
negative.  I think we just validate that ->queue_buf_size is always correct, and
if we're really worried about it in fuse_uring_mmap we validate that sz is
correct there, and then we just use vmalloc_node_user() directly instead of
having this helper.

> +
> +/**
> + * fuse uring mmap, per ring qeuue.
> + * Userpsace maps a kernel allocated ring/queue buffer. For numa awareness,
> + * userspace needs to run the do the mapping from a core bound thread.
> + */
> +int
> +fuse_uring_mmap(struct file *filp, struct vm_area_struct *vma)

I'm not seeing anywhere else in the fuse code that has this style, I'd prefer we
keep it consistent with the rest of the kernel and have

int fuse_uring_mmap(struct file *filp, struct vm_area_struct *vma)

additionally you're using the docstyle strings without the actual docstyle
formatting, which is pissing off my git hooks that run checkpatch.  Not a big
deal, but if you're going to provide docstyle comments then please do it
formatted properly, or just do a normal

/*
 * fuse uring mmap....
 */

> +{
> +	struct fuse_dev *fud = fuse_get_dev(filp);
> +	struct fuse_conn *fc;
> +	struct fuse_ring *ring;
> +	size_t sz = vma->vm_end - vma->vm_start;
> +	int ret;
> +	struct fuse_uring_mbuf *new_node = NULL;
> +	void *buf = NULL;
> +	int nodeid;
> +
> +	if (vma->vm_pgoff << PAGE_SHIFT != FUSE_URING_MMAP_OFF) {
> +		pr_debug("Invalid offset, expected %llu got %lu\n",
> +			 FUSE_URING_MMAP_OFF, vma->vm_pgoff << PAGE_SHIFT);
> +		return -EINVAL;
> +	}
> +
> +	if (!fud)
> +		return -ENODEV;
> +	fc = fud->fc;
> +	ring = fc->ring;
> +	if (!ring)
> +		return -ENODEV;
> +
> +	nodeid = ring->numa_aware ? fuse_uring_current_nodeid() : NUMA_NO_NODE;

nodeid = ring->numa_awayre ? numa_node_id() : NUMA_NO_NODE;

> +
> +	/* check if uring is configured and if the requested size matches */
> +	if (ring->nr_queues == 0 || ring->queue_depth == 0) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (sz != ring->queue_buf_size) {
> +		ret = -EINVAL;
> +		pr_devel("mmap size mismatch, expected %zu got %zu\n",
> +			 ring->queue_buf_size, sz);
> +		goto out;
> +	}
> +
> +	if (current->nr_cpus_allowed != 1 && ring->numa_aware) {
> +		ret = -EINVAL;
> +		pr_debug(
> +			"Numa awareness, but thread has more than allowed cpu.\n");
> +		goto out;
> +	}
> +
> +	buf = fuse_uring_alloc_queue_buf(ring->queue_buf_size, nodeid);
> +	if (IS_ERR(buf)) {
> +		ret = PTR_ERR(buf);
> +		goto out;
> +	}

All of the above you can just return ret, you don't have to jump to out.

> +
> +	new_node = kmalloc(sizeof(*new_node), GFP_USER);
> +	if (unlikely(new_node == NULL)) {
> +		ret = -ENOMEM;
> +		goto out;

Here I would just

if (unlikely(new_node == NULL)) {
	vfree(buf);
	return -ENOMEM;
}

> +	}
> +
> +	ret = remap_vmalloc_range(vma, buf, 0);
> +	if (ret)
> +		goto out;

And since this is the only place we can fail with both things allocated I'd just

if (ret) {
	vfree(buf);
	kfree(new_node);
	return ret;
}

and then drop the bit below where you free the buffers if there's an error.

> +
> +	mutex_lock(&ring->start_stop_lock);
> +	/*
> +	 * In this function we do not know the queue the buffer belongs to.
> +	 * Later server side will pass the mmaped address, the kernel address
> +	 * will be found through the map.
> +	 */
> +	new_node->kbuf = buf;
> +	new_node->ubuf = (void *)vma->vm_start;
> +	rb_add(&new_node->rb_node, &ring->mem_buf_map,
> +	       fuse_uring_rb_tree_buf_less);
> +	mutex_unlock(&ring->start_stop_lock);
> +out:
> +	if (ret) {
> +		kfree(new_node);
> +		vfree(buf);
> +	}
> +
> +	pr_devel("%s: pid %d addr: %p sz: %zu  ret: %d\n", __func__,
> +		 current->pid, (char *)vma->vm_start, sz, ret);
> +
> +	return ret;
> +}
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 58ab4671deff..c455ae0e729a 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -181,6 +181,7 @@ struct fuse_ring {
>  
>  void fuse_uring_abort_end_requests(struct fuse_ring *ring);
>  int fuse_uring_conn_cfg(struct fuse_ring *ring, struct fuse_ring_config *rcfg);
> +int fuse_uring_mmap(struct file *filp, struct vm_area_struct *vma);
>  int fuse_uring_queue_cfg(struct fuse_ring *ring,
>  			 struct fuse_ring_queue_config *qcfg);
>  void fuse_uring_ring_destruct(struct fuse_ring *ring);
> @@ -208,6 +209,27 @@ static inline void fuse_uring_conn_destruct(struct fuse_conn *fc)
>  	kfree(ring);
>  }
>  
> +static inline int fuse_uring_rb_tree_buf_cmp(const void *key,
> +					     const struct rb_node *node)
> +{
> +	const struct fuse_uring_mbuf *entry =
> +		rb_entry(node, struct fuse_uring_mbuf, rb_node);
> +
> +	if (key == entry->ubuf)
> +		return 0;
> +
> +	return (unsigned long)key < (unsigned long)entry->ubuf ? -1 : 1;
> +}
> +
> +static inline bool fuse_uring_rb_tree_buf_less(struct rb_node *node1,
> +					       const struct rb_node *node2)
> +{
> +	const struct fuse_uring_mbuf *entry1 =
> +		rb_entry(node1, struct fuse_uring_mbuf, rb_node);
> +
> +	return fuse_uring_rb_tree_buf_cmp(entry1->ubuf, node2) < 0;
> +}
> +

These are only used in dev_uring.c, just put them in there instead of the header
file.  Thanks,

Josef

