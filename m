Return-Path: <linux-fsdevel+bounces-7483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814BD825B7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 21:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3727A285385
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 20:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A6736098;
	Fri,  5 Jan 2024 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iogXcyS+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD753608B
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704485846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vd1YUEaCt/w4N4YoX8BDZeDQqXK9hd0o4D1WXieyEL8=;
	b=iogXcyS+tdIUPNciv8rRv0D/HJu+NhIEBbSI4+hi5S+AjxEryi1m5Te4Aca6GkxBUjAhVf
	SoLcKlwXhK3KC8vBMLnfLDzAgUdBbDiMNdy40uTs8Fx/zk9bO07sORMnwWSRHGfuQNoVlc
	Aej0EXDRFr5yzaDE6lssEQ5qQef4Ghg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-mNga88ZGMVKb53DzxRzGWw-1; Fri, 05 Jan 2024 15:17:21 -0500
X-MC-Unique: mNga88ZGMVKb53DzxRzGWw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D700A185A781;
	Fri,  5 Jan 2024 20:17:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 81A4F51D5;
	Fri,  5 Jan 2024 20:17:20 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
	id D025E28EBD2; Fri,  5 Jan 2024 15:17:19 -0500 (EST)
Date: Fri, 5 Jan 2024 15:17:19 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, houtao1@huawei.com
Subject: Re: [PATCH v2] virtiofs: use GFP_NOFS when enqueuing request through
 kworker
Message-ID: <ZZhjzwnQUEJhNJiq@redhat.com>
References: <20240105105305.4052672-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105105305.4052672-1-houtao@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Fri, Jan 05, 2024 at 06:53:05PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When invoking virtio_fs_enqueue_req() through kworker, both the
> allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
> Considering the size of both the sg array and the bounce buffer may be
> greater than PAGE_SIZE, use GFP_NOFS instead of GFP_ATOMIC to lower the
> possibility of memory allocation failure.
> 

What's the practical benefit of this patch. Looks like if memory
allocation fails, we keep retrying at interval of 1ms and don't
return error to user space.

Thanks
Vivek

> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
> Change log:
> v2:
>   * pass gfp_t instead of bool to virtio_fs_enqueue_req() (Suggested by Matthew)
> 
> v1: https://lore.kernel.org/linux-fsdevel/20240104015805.2103766-1-houtao@huaweicloud.com
> 
>  fs/fuse/virtio_fs.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 3aac31d451985..8cf518624ce9e 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -87,7 +87,8 @@ struct virtio_fs_req_work {
>  };
>  
>  static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
> -				 struct fuse_req *req, bool in_flight);
> +				 struct fuse_req *req, bool in_flight,
> +				 gfp_t gfp);
>  
>  static const struct constant_table dax_param_enums[] = {
>  	{"always",	FUSE_DAX_ALWAYS },
> @@ -383,7 +384,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>  		list_del_init(&req->list);
>  		spin_unlock(&fsvq->lock);
>  
> -		ret = virtio_fs_enqueue_req(fsvq, req, true);
> +		ret = virtio_fs_enqueue_req(fsvq, req, true, GFP_NOFS);
>  		if (ret < 0) {
>  			if (ret == -ENOMEM || ret == -ENOSPC) {
>  				spin_lock(&fsvq->lock);
> @@ -488,7 +489,7 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
>  }
>  
>  /* Allocate and copy args into req->argbuf */
> -static int copy_args_to_argbuf(struct fuse_req *req)
> +static int copy_args_to_argbuf(struct fuse_req *req, gfp_t gfp)
>  {
>  	struct fuse_args *args = req->args;
>  	unsigned int offset = 0;
> @@ -502,7 +503,7 @@ static int copy_args_to_argbuf(struct fuse_req *req)
>  	len = fuse_len_args(num_in, (struct fuse_arg *) args->in_args) +
>  	      fuse_len_args(num_out, args->out_args);
>  
> -	req->argbuf = kmalloc(len, GFP_ATOMIC);
> +	req->argbuf = kmalloc(len, gfp);
>  	if (!req->argbuf)
>  		return -ENOMEM;
>  
> @@ -1119,7 +1120,8 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
>  
>  /* Add a request to a virtqueue and kick the device */
>  static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
> -				 struct fuse_req *req, bool in_flight)
> +				 struct fuse_req *req, bool in_flight,
> +				 gfp_t gfp)
>  {
>  	/* requests need at least 4 elements */
>  	struct scatterlist *stack_sgs[6];
> @@ -1140,8 +1142,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>  	/* Does the sglist fit on the stack? */
>  	total_sgs = sg_count_fuse_req(req);
>  	if (total_sgs > ARRAY_SIZE(stack_sgs)) {
> -		sgs = kmalloc_array(total_sgs, sizeof(sgs[0]), GFP_ATOMIC);
> -		sg = kmalloc_array(total_sgs, sizeof(sg[0]), GFP_ATOMIC);
> +		sgs = kmalloc_array(total_sgs, sizeof(sgs[0]), gfp);
> +		sg = kmalloc_array(total_sgs, sizeof(sg[0]), gfp);
>  		if (!sgs || !sg) {
>  			ret = -ENOMEM;
>  			goto out;
> @@ -1149,7 +1151,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>  	}
>  
>  	/* Use a bounce buffer since stack args cannot be mapped */
> -	ret = copy_args_to_argbuf(req);
> +	ret = copy_args_to_argbuf(req, gfp);
>  	if (ret < 0)
>  		goto out;
>  
> @@ -1245,7 +1247,7 @@ __releases(fiq->lock)
>  		 fuse_len_args(req->args->out_numargs, req->args->out_args));
>  
>  	fsvq = &fs->vqs[queue_id];
> -	ret = virtio_fs_enqueue_req(fsvq, req, false);
> +	ret = virtio_fs_enqueue_req(fsvq, req, false, GFP_ATOMIC);
>  	if (ret < 0) {
>  		if (ret == -ENOMEM || ret == -ENOSPC) {
>  			/*
> -- 
> 2.29.2
> 


