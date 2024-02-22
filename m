Return-Path: <linux-fsdevel+bounces-12517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13C986032E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 20:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACDE283322
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 19:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF02F6AF8A;
	Thu, 22 Feb 2024 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsiC1fdr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921FE548E7
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631396; cv=none; b=B2RFgK4XURS4AUPkE26JiDwnfjLJUgcj4sG1UiPW8ojnEC2sTcr6rvCbyHFVLlcRCKSVvmb8wQ7HSOIpdXZdik6nu9xvrfCKBGy1/gqdLjXbLXtSvUYcpJPQXF1kzSoxT/8vwBfpumry/DFa3KQD1NED4jUFXxy+ZZ1IAJ5a8Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631396; c=relaxed/simple;
	bh=2QLLW+IDkCr4cgd4k0ZnBRVRrE0Ty0HWRgBFwTeLP8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rmf16q8F3NTAJsgxKY97e6pVxjED69NY+ZqBzFd0rIfpO0WEAEDi1LFR1INe3nkbXn/k09NwWgrtD02L8dvt/nW7RGHQ1sIqJ66vek0+V4bdQVCGlq3KGoOAM5+OUfa7zSi0n1OQs6riicignkzFn/Ekl9DesnIUmimBZvaqlnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FsiC1fdr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708631393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B14VSMvxVqAeXnQ2e0nLRDE3jOC6HbsDFeCY40Y6s2Y=;
	b=FsiC1fdr1nE5CFFmzJJ2ZFFLOOdNW9Vq0wktpyyFHDNikX3ma29DBQNX57ADjaFOQaquby
	TAa3IvqHEmib9UGtqD4xlogN5QKkzZ86j/E+nNw0J9kByN/QB6S+C/WZ1nHXt6EYM9nei6
	b9T0y6fSeVCxluqJj3qSrr5NNkpUIkA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-wwK7JMG8MfWKtiIvotTuZw-1; Thu, 22 Feb 2024 14:49:52 -0500
X-MC-Unique: wwK7JMG8MfWKtiIvotTuZw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d8d785b08so89526f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 11:49:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708631390; x=1709236190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B14VSMvxVqAeXnQ2e0nLRDE3jOC6HbsDFeCY40Y6s2Y=;
        b=VwbMAaDBG31VxFRIBpv2QmSAXx9TO6Yjv4sViaIiVpv1JxT4atRyPxkirALUG7o21X
         u6UsfO4SQqs1z2tLSqBdHuemC2cK+SK9my+rPAdcRGksthUE0fQPmI5gmBUEQrImg2SQ
         /vuujV44RPlP+OwrdCWC7gye6uBtaIgCGLkXWfMptoVSZMgws7MSW8NQU1RY21Kvs+wa
         JquJjOau+miqZUOY9fvyZcoUiuxm0dLQkEkaWQC0Z6JCrhGD+RwC3tBotxffXzPzXJOR
         voc1vSU+Imgt/6XmLj1GNKzBzuIXZNkux45quLfaHsZrJbvClS8wUva+iU/np4p5sPtN
         j4DA==
X-Gm-Message-State: AOJu0Yyzj7EYQmQcDDIZrvbMFTeR78g42gifwN0QxPMElFvbtLoHwfEs
	iBgScDSlyZu+cmh820o6Fpj1wlqqzawJyHf2U5XIC/CSHvY9F+D18qFS3rArOdm+Fd8Xl6LSywa
	L+j09ZlrWhglHKNc5e0h+BtynYChZAfV0E/ndzUW5yKnGaAkrwziqpMlL6ds9uuLSKpbUFhEKAQ
	==
X-Received: by 2002:a5d:6646:0:b0:33d:3b72:d2c8 with SMTP id f6-20020a5d6646000000b0033d3b72d2c8mr73538wrw.71.1708631390447;
        Thu, 22 Feb 2024 11:49:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaBVKisoMxO5nbkxyDQT6zkPbLiLcfVpJynqra2jIu5OlbddhLBDs8SyHa4SYsDXQIiITRGg==
X-Received: by 2002:a5d:6646:0:b0:33d:3b72:d2c8 with SMTP id f6-20020a5d6646000000b0033d3b72d2c8mr73531wrw.71.1708631390042;
        Thu, 22 Feb 2024 11:49:50 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id bs30-20020a056000071e00b0033d297c9118sm58957wrb.24.2024.02.22.11.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:49:49 -0800 (PST)
Date: Thu, 22 Feb 2024 14:49:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, houtao1@huawei.com
Subject: Re: [PATCH] virtiofs: limit the length of ITER_KVEC dio by
 max_nopage_rw
Message-ID: <20240222144828-mutt-send-email-mst@kernel.org>
References: <20240103105929.1902658-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103105929.1902658-1-houtao@huaweicloud.com>

On Wed, Jan 03, 2024 at 06:59:29PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When trying to insert a 10MB kernel module kept in a virtiofs with cache
> disabled, the following warning was reported:
> 
>   ------------[ cut here ]------------
>   WARNING: CPU: 2 PID: 439 at mm/page_alloc.c:4544 ......
>   Modules linked in:
>   CPU: 2 PID: 439 Comm: insmod Not tainted 6.7.0-rc7+ #33
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ......
>   RIP: 0010:__alloc_pages+0x2c4/0x360
>   ......
>   Call Trace:
>    <TASK>
>    ? __warn+0x8f/0x150
>    ? __alloc_pages+0x2c4/0x360
>    __kmalloc_large_node+0x86/0x160
>    __kmalloc+0xcd/0x140
>    virtio_fs_enqueue_req+0x240/0x6d0
>    virtio_fs_wake_pending_and_unlock+0x7f/0x190
>    queue_request_and_unlock+0x58/0x70
>    fuse_simple_request+0x18b/0x2e0
>    fuse_direct_io+0x58a/0x850
>    fuse_file_read_iter+0xdb/0x130
>    __kernel_read+0xf3/0x260
>    kernel_read+0x45/0x60
>    kernel_read_file+0x1ad/0x2b0
>    init_module_from_file+0x6a/0xe0
>    idempotent_init_module+0x179/0x230
>    __x64_sys_finit_module+0x5d/0xb0
>    do_syscall_64+0x36/0xb0
>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
>    ......
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
> 
> The warning happened as follow. In copy_args_to_argbuf(), virtiofs uses
> kmalloc-ed memory as bound buffer for fuse args, but
> fuse_get_user_pages() only limits the length of fuse arg by max_read or
> max_write for IOV_KVEC io (e.g., kernel_read_file from finit_module()).
> For virtiofs, max_read is UINT_MAX, so a big read request which is about
> 10MB is passed to copy_args_to_argbuf(), kmalloc() is called in turn
> with len=10MB, and triggers the warning in __alloc_pages():
> WARN_ON_ONCE_GFP(order > MAX_ORDER, gfp)).
> 
> A feasible solution is to limit the value of max_read for virtiofs, so
> the length passed to kmalloc() will be limited. However it will affects
> the max read size for ITER_IOVEC io and the value of max_write also needs
> limitation. So instead of limiting the values of max_read and max_write,
> introducing max_nopage_rw to cap both the values of max_read and
> max_write when the fuse dio read/write request is initiated from kernel.
> 
> Considering that fuse read/write request from kernel is uncommon and to
> decrease the demand for large contiguous pages, set max_nopage_rw as
> 256KB instead of KMALLOC_MAX_SIZE - 4096 or similar.
> 
> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> Signed-off-by: Hou Tao <houtao1@huawei.com>


So what should I do with this patch? It includes fuse changes
but of course I can merge too if no one wants to bother either way...


> ---
>  fs/fuse/file.c      | 12 +++++++++++-
>  fs/fuse/fuse_i.h    |  3 +++
>  fs/fuse/inode.c     |  1 +
>  fs/fuse/virtio_fs.c |  6 ++++++
>  4 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index a660f1f21540..f1beb7c0b782 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1422,6 +1422,16 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  	return ret < 0 ? ret : 0;
>  }
>  
> +static size_t fuse_max_dio_rw_size(const struct fuse_conn *fc,
> +				   const struct iov_iter *iter, int write)
> +{
> +	unsigned int nmax = write ? fc->max_write : fc->max_read;
> +
> +	if (iov_iter_is_kvec(iter))
> +		nmax = min(nmax, fc->max_nopage_rw);
> +	return nmax;
> +}
> +
>  ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>  		       loff_t *ppos, int flags)
>  {
> @@ -1432,7 +1442,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>  	struct inode *inode = mapping->host;
>  	struct fuse_file *ff = file->private_data;
>  	struct fuse_conn *fc = ff->fm->fc;
> -	size_t nmax = write ? fc->max_write : fc->max_read;
> +	size_t nmax = fuse_max_dio_rw_size(fc, iter, write);
>  	loff_t pos = *ppos;
>  	size_t count = iov_iter_count(iter);
>  	pgoff_t idx_from = pos >> PAGE_SHIFT;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 1df83eebda92..fc753cd34211 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -594,6 +594,9 @@ struct fuse_conn {
>  	/** Constrain ->max_pages to this value during feature negotiation */
>  	unsigned int max_pages_limit;
>  
> +	/** Maximum read/write size when there is no page in request */
> +	unsigned int max_nopage_rw;
> +
>  	/** Input queue */
>  	struct fuse_iqueue iq;
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 2a6d44f91729..4cbbcb4a4b71 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -923,6 +923,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
>  	fc->user_ns = get_user_ns(user_ns);
>  	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
>  	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
> +	fc->max_nopage_rw = UINT_MAX;
>  
>  	INIT_LIST_HEAD(&fc->mounts);
>  	list_add(&fm->fc_entry, &fc->mounts);
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 5f1be1da92ce..3aac31d45198 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1452,6 +1452,12 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>  	/* Tell FUSE to split requests that exceed the virtqueue's size */
>  	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
>  				    virtqueue_size - FUSE_HEADER_OVERHEAD);
> +	/* copy_args_to_argbuf() uses kmalloc-ed memory as bounce buffer
> +	 * for fuse args, so limit the total size of these args to prevent
> +	 * the warning in __alloc_pages() and decrease the demand for large
> +	 * contiguous pages.
> +	 */
> +	fc->max_nopage_rw = min(fc->max_nopage_rw, 256U << 10);
>  
>  	fsc->s_fs_info = fm;
>  	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
> -- 
> 2.29.2


