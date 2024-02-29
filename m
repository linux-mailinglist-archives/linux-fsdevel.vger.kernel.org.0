Return-Path: <linux-fsdevel+bounces-13191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E4986CC45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 16:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7F71C22955
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E86713777D;
	Thu, 29 Feb 2024 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T98dZ+UI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4897D419
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218809; cv=none; b=oyQA7IymULxR3ul2a+ZJbWff6byyXNe0PrIeGBQYbJDk0PFsjLG61xTOcsQ13SK5PtSqPSXP+RdVRFLSXapMvbPVKSbIkKTkTv6NNZwFJkET/ahqeVuKpydYiH2UvMOrNNbuBhuRvorWVYk4NWYcAt/r+g//vMc5ye0FhhoNOPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218809; c=relaxed/simple;
	bh=bzsLAiCQthrVFAfhIeoz62wmMKFtw1xDTxQwvoxknAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUpiGlzWHUcBwElZ1f+bFruWpInrsJ64vmCWRpijgsj73YodC7HJ8oZ/DLSFKxyONmTrcqL5yBpT4giANi+anC1uhciIaVGmD9eyO52roHMptYuoQ/iSo5w7hkYGCiUAPOuyQ69Dp+62fA02FtHxe0q5iieiAa9ZgT7FWvwETeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T98dZ+UI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709218806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6egRvLYRkiVfRFj4cN+8vcXUmac/AnmcaQNAMGAMNAg=;
	b=T98dZ+UIiQwwcrUSAhyTzrj4GhgIasLFZVHACsNrYUBxLKPACRLnsccdiRn59lNbIhCaG/
	yqyYxCjfz+p5IV9AyEev7gStDQDO/Hyz2RS4Ktb1W2Fu+JVECgJoGMBWUUWrhK0k7O8RC7
	8NxXCMr9kHbN6yLPbhvCD22VWBKLcTw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-i8F5JyzwPvWRc0Tt_-tQzw-1; Thu,
 29 Feb 2024 10:00:04 -0500
X-MC-Unique: i8F5JyzwPvWRc0Tt_-tQzw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5BC33C14955;
	Thu, 29 Feb 2024 15:00:03 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 76A79112132A;
	Thu, 29 Feb 2024 15:00:01 +0000 (UTC)
Date: Thu, 29 Feb 2024 10:01:43 -0500
From: Brian Foster <bfoster@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	houtao1@huawei.com
Subject: Re: [PATCH v2 4/6] virtiofs: support bounce buffer backed by
 scattered pages
Message-ID: <ZeCcV9Jo3mTRPsME@bfoster>
References: <20240228144126.2864064-1-houtao@huaweicloud.com>
 <20240228144126.2864064-5-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228144126.2864064-5-houtao@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Wed, Feb 28, 2024 at 10:41:24PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When reading a file kept in virtiofs from kernel (e.g., insmod a kernel
> module), if the cache of virtiofs is disabled, the read buffer will be
> passed to virtiofs through out_args[0].value instead of pages. Because
> virtiofs can't get the pages for the read buffer, virtio_fs_argbuf_new()
> will create a bounce buffer for the read buffer by using kmalloc() and
> copy the read buffer into bounce buffer. If the read buffer is large
> (e.g., 1MB), the allocation will incur significant stress on the memory
> subsystem.
> 
> So instead of allocating bounce buffer by using kmalloc(), allocate a
> bounce buffer which is backed by scattered pages. The original idea is
> to use vmap(), but the use of GFP_ATOMIC is no possible for vmap(). To
> simplify the copy operations in the bounce buffer, use a bio_vec flex
> array to represent the argbuf. Also add an is_flat field in struct
> virtio_fs_argbuf to distinguish between kmalloc-ed and scattered bounce
> buffer.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/fuse/virtio_fs.c | 163 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 149 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index f10fff7f23a0f..ffea684bd100d 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
...
> @@ -408,42 +425,143 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>  	}
>  }
>  
...  
>  static void virtio_fs_argbuf_copy_from_in_arg(struct virtio_fs_argbuf *argbuf,
>  					      unsigned int offset,
>  					      const void *src, unsigned int len)
>  {
> -	memcpy(argbuf->buf + offset, src, len);
> +	struct iov_iter iter;
> +	unsigned int copied;
> +
> +	if (argbuf->is_flat) {
> +		memcpy(argbuf->f.buf + offset, src, len);
> +		return;
> +	}
> +
> +	iov_iter_bvec(&iter, ITER_DEST, argbuf->s.bvec,
> +		      argbuf->s.nr, argbuf->s.size);
> +	iov_iter_advance(&iter, offset);

Hi Hou,

Just a random comment, but it seems a little inefficient to reinit and
readvance the iter like this on every copy/call. It looks like offset is
already incremented in the callers of the argbuf copy helpers. Perhaps
iov_iter could be lifted into the callers and passed down, or even just
include it in the argbuf structure and init it at alloc time?

Brian

> +
> +	copied = _copy_to_iter(src, len, &iter);
> +	WARN_ON_ONCE(copied != len);
>  }
>  
>  static unsigned int
> @@ -451,15 +569,32 @@ virtio_fs_argbuf_out_args_offset(struct virtio_fs_argbuf *argbuf,
>  				 const struct fuse_args *args)
>  {
>  	unsigned int num_in = args->in_numargs - args->in_pages;
> +	unsigned int offset = fuse_len_args(num_in,
> +					    (struct fuse_arg *)args->in_args);
>  
> -	return fuse_len_args(num_in, (struct fuse_arg *)args->in_args);
> +	if (argbuf->is_flat)
> +		return offset;
> +	return round_up(offset, PAGE_SIZE);
>  }
>  
>  static void virtio_fs_argbuf_copy_to_out_arg(struct virtio_fs_argbuf *argbuf,
>  					     unsigned int offset, void *dst,
>  					     unsigned int len)
>  {
> -	memcpy(dst, argbuf->buf + offset, len);
> +	struct iov_iter iter;
> +	unsigned int copied;
> +
> +	if (argbuf->is_flat) {
> +		memcpy(dst, argbuf->f.buf + offset, len);
> +		return;
> +	}
> +
> +	iov_iter_bvec(&iter, ITER_SOURCE, argbuf->s.bvec,
> +		      argbuf->s.nr, argbuf->s.size);
> +	iov_iter_advance(&iter, offset);
> +
> +	copied = _copy_from_iter(dst, len, &iter);
> +	WARN_ON_ONCE(copied != len);
>  }
>  
>  /*
> @@ -1154,7 +1289,7 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
>  	len = fuse_len_args(numargs - argpages, args);
>  	if (len)
>  		total_sgs += virtio_fs_argbuf_setup_sg(req->argbuf, *len_used,
> -						       len, &sg[total_sgs]);
> +						       &len, &sg[total_sgs]);
>  
>  	if (argpages)
>  		total_sgs += sg_init_fuse_pages(&sg[total_sgs],
> @@ -1199,7 +1334,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>  	}
>  
>  	/* Use a bounce buffer since stack args cannot be mapped */
> -	req->argbuf = virtio_fs_argbuf_new(args, GFP_ATOMIC);
> +	req->argbuf = virtio_fs_argbuf_new(args, GFP_ATOMIC, true);
>  	if (!req->argbuf) {
>  		ret = -ENOMEM;
>  		goto out;
> -- 
> 2.29.2
> 
> 


