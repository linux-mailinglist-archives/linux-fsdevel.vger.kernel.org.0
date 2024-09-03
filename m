Return-Path: <linux-fsdevel+bounces-28330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387CA9697B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 10:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69768B2720F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7B53DAC04;
	Tue,  3 Sep 2024 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZLrbJXri"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5081D0940;
	Tue,  3 Sep 2024 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353083; cv=none; b=nlGZgalS/dswhIiHCDw4xTzr40Ud3ntiXm+J6yD+NlY9CIeWCT6ORwizA6tMb8t2rOuFBdaZipKB3peoszjzBYEytTJVSfpNJ0+IGh9qnaIOSKSJsEfOyOskOz/PytWieqhFavODyBXrcLbo/93Ug5EZ+3ae1upgS5T3riLE80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353083; c=relaxed/simple;
	bh=Zj7h+Df61/pENQfgug3gu4dOhNubOSRMV4QeUjHXPoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMedGaaiGr9iTkRRY22hEk8P7G46eQ6NGIz3oJXeEE08zTXLEPOUM/OnTPvOVj63TsRQZ87E+EvTpEoZ567wPqcm8gx3XC+aLlBsekD4ntcyxBNb01Gb+b0sm9LFJkbJ+F/6ajRyY93Kgju/5LJNhnoNssmcEA7GCIH/f3e4wTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZLrbJXri; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725353078; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=07f+ZRUYFuuGrxUxDNJ+07f6JVD8p2TyIQijT4Sm9TY=;
	b=ZLrbJXritpISpWqQWstHcLYosB1qixcWbWJRT2Jn/74o2BZRATG07jgS6Ym54bcMB/gyUkxhZzCJihYYCIPTAcF4gDoZBYdZRseV4VAibKi3F5p4aQdziTzE5VySAHZob/XUuvry1VqxizmeumkDAmA/RWwOe7KOZv/4zOzH0PI=
Received: from 30.221.146.33(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WECkfE6_1725353076)
          by smtp.aliyun-inc.com;
          Tue, 03 Sep 2024 16:44:37 +0800
Message-ID: <6074d653-3dd3-45a3-9241-a9e2e12252c6@linux.alibaba.com>
Date: Tue, 3 Sep 2024 16:44:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] virtiofs: use pages instead of pointer for kernel
 direct IO
To: Hou Tao <houtao@huaweicloud.com>, linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 "Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Benjamin Coddington <bcodding@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 houtao1@huawei.com
References: <20240831093750.1593871-1-houtao@huaweicloud.com>
 <20240831093750.1593871-2-houtao@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240831093750.1593871-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/31/24 5:37 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When trying to insert a 10MB kernel module kept in a virtio-fs with cache
> disabled, the following warning was reported:
> 
>   ------------[ cut here ]------------
>   WARNING: CPU: 1 PID: 404 at mm/page_alloc.c:4551 ......
>   Modules linked in:
>   CPU: 1 PID: 404 Comm: insmod Not tainted 6.9.0-rc5+ #123
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
>   RIP: 0010:__alloc_pages+0x2bf/0x380
>   ......
>   Call Trace:
>    <TASK>
>    ? __warn+0x8e/0x150
>    ? __alloc_pages+0x2bf/0x380
>    __kmalloc_large_node+0x86/0x160
>    __kmalloc+0x33c/0x480
>    virtio_fs_enqueue_req+0x240/0x6d0
>    virtio_fs_wake_pending_and_unlock+0x7f/0x190
>    queue_request_and_unlock+0x55/0x60
>    fuse_simple_request+0x152/0x2b0
>    fuse_direct_io+0x5d2/0x8c0
>    fuse_file_read_iter+0x121/0x160
>    __kernel_read+0x151/0x2d0
>    kernel_read+0x45/0x50
>    kernel_read_file+0x1a9/0x2a0
>    init_module_from_file+0x6a/0xe0
>    idempotent_init_module+0x175/0x230
>    __x64_sys_finit_module+0x5d/0xb0
>    x64_sys_call+0x1c3/0x9e0
>    do_syscall_64+0x3d/0xc0
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>    ......
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
> 
> The warning is triggered as follows:
> 
> 1) syscall finit_module() handles the module insertion and it invokes
> kernel_read_file() to read the content of the module first.
> 
> 2) kernel_read_file() allocates a 10MB buffer by using vmalloc() and
> passes it to kernel_read(). kernel_read() constructs a kvec iter by
> using iov_iter_kvec() and passes it to fuse_file_read_iter().
> 
> 3) virtio-fs disables the cache, so fuse_file_read_iter() invokes
> fuse_direct_io(). As for now, the maximal read size for kvec iter is
> only limited by fc->max_read. For virtio-fs, max_read is UINT_MAX, so
> fuse_direct_io() doesn't split the 10MB buffer. It saves the address and
> the size of the 10MB-sized buffer in out_args[0] of a fuse request and
> passes the fuse request to virtio_fs_wake_pending_and_unlock().
> 
> 4) virtio_fs_wake_pending_and_unlock() uses virtio_fs_enqueue_req() to
> queue the request. Because virtiofs need DMA-able address, so
> virtio_fs_enqueue_req() uses kmalloc() to allocate a bounce buffer for
> all fuse args, copies these args into the bounce buffer and passed the
> physical address of the bounce buffer to virtiofsd. The total length of
> these fuse args for the passed fuse request is about 10MB, so
> copy_args_to_argbuf() invokes kmalloc() with a 10MB size parameter and
> it triggers the warning in __alloc_pages():
> 
> 	if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
> 		return NULL;
> 
> 5) virtio_fs_enqueue_req() will retry the memory allocation in a
> kworker, but it won't help, because kmalloc() will always return NULL
> due to the abnormal size and finit_module() will hang forever.
> 
> A feasible solution is to limit the value of max_read for virtio-fs, so
> the length passed to kmalloc() will be limited. However it will affect
> the maximal read size for normal read. And for virtio-fs write initiated
> from kernel, it has the similar problem but now there is no way to limit
> fc->max_write in kernel.
> 
> So instead of limiting both the values of max_read and max_write in
> kernel, introducing use_pages_for_kvec_io in fuse_conn and setting it as
> true in virtiofs. When use_pages_for_kvec_io is enabled, fuse will use
> pages instead of pointer to pass the KVEC_IO data.
> 
> After switching to pages for KVEC_IO data, these pages will be used for
> DMA through virtio-fs. If these pages are backed by vmalloc(),
> {flush|invalidate}_kernel_vmap_range() are necessary to flush or
> invalidate the cache before the DMA operation. So add two new fields in
> fuse_args_pages to record the base address of vmalloc area and the
> condition indicating whether invalidation is needed. Perform the flush
> in fuse_get_user_pages() for write operations and the invalidation in
> fuse_release_user_pages() for read operations.
> 
> It may seem necessary to introduce another field in fuse_conn to
> indicate that these KVEC_IO pages are used for DMA, However, considering
> that virtio-fs is currently the only user of use_pages_for_kvec_io, just
> reuse use_pages_for_kvec_io to indicate that these pages will be used
> for DMA.
> 
> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Tested-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/fuse/file.c      | 62 +++++++++++++++++++++++++++++++--------------
>  fs/fuse/fuse_i.h    |  6 +++++
>  fs/fuse/virtio_fs.c |  1 +
>  3 files changed, 50 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f39456c65ed7..331208d3e4d1 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -645,7 +645,7 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
>  	args->out_args[0].size = count;
>  }
>  
> -static void fuse_release_user_pages(struct fuse_args_pages *ap,
> +static void fuse_release_user_pages(struct fuse_args_pages *ap, ssize_t nres,
>  				    bool should_dirty)
>  {
>  	unsigned int i;
> @@ -656,6 +656,9 @@ static void fuse_release_user_pages(struct fuse_args_pages *ap,
>  		if (ap->args.is_pinned)
>  			unpin_user_page(ap->pages[i]);
>  	}
> +
> +	if (nres > 0 && ap->args.invalidate_vmap)
> +		invalidate_kernel_vmap_range(ap->args.vmap_base, nres);
>  }
>  
>  static void fuse_io_release(struct kref *kref)
> @@ -754,25 +757,29 @@ static void fuse_aio_complete_req(struct fuse_mount *fm, struct fuse_args *args,
>  	struct fuse_io_args *ia = container_of(args, typeof(*ia), ap.args);
>  	struct fuse_io_priv *io = ia->io;
>  	ssize_t pos = -1;
> -
> -	fuse_release_user_pages(&ia->ap, io->should_dirty);
> +	size_t nres;
>  
>  	if (err) {
>  		/* Nothing */
>  	} else if (io->write) {
>  		if (ia->write.out.size > ia->write.in.size) {
>  			err = -EIO;
> -		} else if (ia->write.in.size != ia->write.out.size) {
> -			pos = ia->write.in.offset - io->offset +
> -				ia->write.out.size;
> +		} else {
> +			nres = ia->write.out.size;
> +			if (ia->write.in.size != ia->write.out.size)
> +				pos = ia->write.in.offset - io->offset +
> +				      ia->write.out.size;
>  		}
>  	} else {
>  		u32 outsize = args->out_args[0].size;
>  
> +		nres = outsize;
>  		if (ia->read.in.size != outsize)
>  			pos = ia->read.in.offset - io->offset + outsize;
>  	}
>  
> +	fuse_release_user_pages(&ia->ap, err ?: nres, io->should_dirty);
> +
>  	fuse_aio_complete(io, err, pos);
>  	fuse_io_free(ia);
>  }
> @@ -1467,24 +1474,37 @@ static inline size_t fuse_get_frag_size(const struct iov_iter *ii,
>  
>  static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  			       size_t *nbytesp, int write,
> -			       unsigned int max_pages)
> +			       unsigned int max_pages,
> +			       bool use_pages_for_kvec_io)
>  {
> +	bool flush_or_invalidate = false;
>  	size_t nbytes = 0;  /* # bytes already packed in req */
>  	ssize_t ret = 0;
>  
> -	/* Special case for kernel I/O: can copy directly into the buffer */
> +	/* Special case for kernel I/O: can copy directly into the buffer.
> +	 * However if the implementation of fuse_conn requires pages instead of
> +	 * pointer (e.g., virtio-fs), use iov_iter_extract_pages() instead.
> +	 */
>  	if (iov_iter_is_kvec(ii)) {
> -		unsigned long user_addr = fuse_get_user_addr(ii);
> -		size_t frag_size = fuse_get_frag_size(ii, *nbytesp);
> +		void *user_addr = (void *)fuse_get_user_addr(ii);
>  
> -		if (write)
> -			ap->args.in_args[1].value = (void *) user_addr;
> -		else
> -			ap->args.out_args[0].value = (void *) user_addr;
> +		if (!use_pages_for_kvec_io) {
> +			size_t frag_size = fuse_get_frag_size(ii, *nbytesp);
>  
> -		iov_iter_advance(ii, frag_size);
> -		*nbytesp = frag_size;
> -		return 0;
> +			if (write)
> +				ap->args.in_args[1].value = user_addr;
> +			else
> +				ap->args.out_args[0].value = user_addr;
> +
> +			iov_iter_advance(ii, frag_size);
> +			*nbytesp = frag_size;
> +			return 0;
> +		}
> +
> +		if (is_vmalloc_addr(user_addr)) {
> +			ap->args.vmap_base = user_addr;
> +			flush_or_invalidate = true;

Could we move flush_kernel_vmap_range() upon here, so that
flush_or_invalidate is not needed anymore and the code looks cleaner?

> +		}
>  	}
>  
>  	while (nbytes < *nbytesp && ap->num_pages < max_pages) {
> @@ -1513,6 +1533,10 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  			(PAGE_SIZE - ret) & (PAGE_SIZE - 1);
>  	}
>  
> +	if (write && flush_or_invalidate)
> +		flush_kernel_vmap_range(ap->args.vmap_base, nbytes);
> +
> +	ap->args.invalidate_vmap = !write && flush_or_invalidate;

How about initializing vmap_base only when the data buffer is vmalloced
and it's a read request?  In this case invalidate_vmap is no longer needed.

>  	ap->args.is_pinned = iov_iter_extract_will_pin(ii);
>  	ap->args.user_pages = true;
>  	if (write)
> @@ -1581,7 +1605,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>  		size_t nbytes = min(count, nmax);
>  
>  		err = fuse_get_user_pages(&ia->ap, iter, &nbytes, write,
> -					  max_pages);
> +					  max_pages, fc->use_pages_for_kvec_io);
>  		if (err && !nbytes)
>  			break;
>  
> @@ -1595,7 +1619,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>  		}
>  
>  		if (!io->async || nres < 0) {
> -			fuse_release_user_pages(&ia->ap, io->should_dirty);
> +			fuse_release_user_pages(&ia->ap, nres, io->should_dirty);
>  			fuse_io_free(ia);
>  		}
>  		ia = NULL;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index f23919610313..79add14c363f 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -309,9 +309,12 @@ struct fuse_args {
>  	bool may_block:1;
>  	bool is_ext:1;
>  	bool is_pinned:1;
> +	bool invalidate_vmap:1;
>  	struct fuse_in_arg in_args[3];
>  	struct fuse_arg out_args[2];
>  	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
> +	/* Used for kvec iter backed by vmalloc address */
> +	void *vmap_base;
>  };
>  
>  struct fuse_args_pages {
> @@ -860,6 +863,9 @@ struct fuse_conn {
>  	/** Passthrough support for read/write IO */
>  	unsigned int passthrough:1;
>  
> +	/* Use pages instead of pointer for kernel I/O */
> +	unsigned int use_pages_for_kvec_io:1;

Maybe we need a better (actually shorter) name for this flag. kvec_pages?

> +
>  	/** Maximum stack depth for passthrough backing files */
>  	int max_stack_depth;
>  
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index dd5260141615..43d66ab5e891 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1568,6 +1568,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>  	fc->delete_stale = true;
>  	fc->auto_submounts = true;
>  	fc->sync_fs = true;
> +	fc->use_pages_for_kvec_io = true;
>  
>  	/* Tell FUSE to split requests that exceed the virtqueue's size */
>  	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,

-- 
Thanks,
Jingbo

