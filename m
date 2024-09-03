Return-Path: <linux-fsdevel+bounces-28343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BE7969930
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A0F286AEF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 09:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784EB1B9850;
	Tue,  3 Sep 2024 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o5t/zlcD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031B1AD272;
	Tue,  3 Sep 2024 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356055; cv=none; b=QM7x6S7nfBvLizSZdLVlYq5/rS9dpPF+4ubaVDRYPnR9asiLMqBdO/RPZrn6X2yevoZCYnxe8QBsZanD+1EoGRpIBCJAzjWkEn44ooVrKjfb4DRmCKnC/gnDyo9EcdC0LwsqSCltJPw38Pm4CLIuEkjlnFYhUfPFqS8zj7/W87o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356055; c=relaxed/simple;
	bh=7jJBly8Y6bE9sPKCf9EEsc7epwehNU1txM4jSXiORyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PI4dPKP9OgTv0dWOk8aaiDjehRBp7HSsu01vlZlSjCzq0aXJJtYlW6G8Nsza8lzkwfOhsy+N5lbSFQTuM6dAxPflwVGyt0kqfhRy56mSk2Z5WWb1m35psVqZZXMnM9YLKJnOUdKZu3guvg1N2HrdNn0giabNiTDmON3ahdHgI98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o5t/zlcD; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725356045; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Eb+P3ApRDSOdltbSEo0YbmmjQpT9J2C1awOD4TBbcTc=;
	b=o5t/zlcDDQiluvCQpsgwrWnl05SGXVPXxITmWO3hiCL5O1GWmn2mzHyOmGbV0pPujhjqGtPl0YUum01UnoV+VT6EjBM4xiZDr3PzlvoW+ngalvMz8SsKKmzKi4CSsnttPBFSYBWUEYw6mtqoyLPj7ZFdi7lq+vXqa9J673jxQHM=
Received: from 30.221.113.157(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WECwpGA_1725356043)
          by smtp.aliyun-inc.com;
          Tue, 03 Sep 2024 17:34:04 +0800
Message-ID: <5769af42-e4dd-4535-9432-f149b8c17af5@linux.alibaba.com>
Date: Tue, 3 Sep 2024 17:34:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] virtiofs: use GFP_NOFS when enqueuing request
 through kworker
To: Hou Tao <houtao@huaweicloud.com>, linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 "Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Benjamin Coddington <bcodding@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 houtao1@huawei.com
References: <20240831093750.1593871-1-houtao@huaweicloud.com>
 <20240831093750.1593871-3-houtao@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240831093750.1593871-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/31/24 5:37 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When invoking virtio_fs_enqueue_req() through kworker, both the
> allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
> Considering the size of the sg array may be greater than PAGE_SIZE, use
> GFP_NOFS instead of GFP_ATOMIC to lower the possibility of memory
> allocation failure and to avoid unnecessarily depleting the atomic
> reserves. GFP_NOFS is not passed to virtio_fs_enqueue_req() directly,
> GFP_KERNEL and memalloc_nofs_{save|restore} helpers are used instead.
> 
> It may seem OK to pass GFP_NOFS to virtio_fs_enqueue_req() as well when
> queuing the request for the first time, but this is not the case. The
> reason is that fuse_request_queue_background() may call
> ->queue_request_and_unlock() while holding fc->bg_lock, which is a
> spin-lock. Therefore, still use GFP_ATOMIC for it.

Actually, .wake_pending_and_unlock() is called under fiq->lock and
GFP_ATOMIC is requisite.


> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/fuse/virtio_fs.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 43d66ab5e891..9bc48b3ca384 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -95,7 +95,8 @@ struct virtio_fs_req_work {
>  };
>  
>  static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
> -				 struct fuse_req *req, bool in_flight);
> +				 struct fuse_req *req, bool in_flight,
> +				 gfp_t gfp);
>  
>  static const struct constant_table dax_param_enums[] = {
>  	{"always",	FUSE_DAX_ALWAYS },
> @@ -439,6 +440,8 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>  
>  	/* Dispatch pending requests */
>  	while (1) {
> +		unsigned int flags;
> +
>  		spin_lock(&fsvq->lock);
>  		req = list_first_entry_or_null(&fsvq->queued_reqs,
>  					       struct fuse_req, list);
> @@ -449,7 +452,9 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>  		list_del_init(&req->list);
>  		spin_unlock(&fsvq->lock);
>  
> -		ret = virtio_fs_enqueue_req(fsvq, req, true);
> +		flags = memalloc_nofs_save();
> +		ret = virtio_fs_enqueue_req(fsvq, req, true, GFP_KERNEL);
> +		memalloc_nofs_restore(flags);
>  		if (ret < 0) {
>  			if (ret == -ENOSPC) {
>  				spin_lock(&fsvq->lock);
> @@ -550,7 +555,7 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
>  }
>  
>  /* Allocate and copy args into req->argbuf */
> -static int copy_args_to_argbuf(struct fuse_req *req)
> +static int copy_args_to_argbuf(struct fuse_req *req, gfp_t gfp)
>  {
>  	struct fuse_args *args = req->args;
>  	unsigned int offset = 0;
> @@ -564,7 +569,7 @@ static int copy_args_to_argbuf(struct fuse_req *req)
>  	len = fuse_len_args(num_in, (struct fuse_arg *) args->in_args) +
>  	      fuse_len_args(num_out, args->out_args);
>  
> -	req->argbuf = kmalloc(len, GFP_ATOMIC);
> +	req->argbuf = kmalloc(len, gfp);
>  	if (!req->argbuf)
>  		return -ENOMEM;
>  
> @@ -1239,7 +1244,8 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
>  
>  /* Add a request to a virtqueue and kick the device */
>  static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
> -				 struct fuse_req *req, bool in_flight)
> +				 struct fuse_req *req, bool in_flight,
> +				 gfp_t gfp)
>  {
>  	/* requests need at least 4 elements */
>  	struct scatterlist *stack_sgs[6];
> @@ -1260,8 +1266,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
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
> @@ -1269,7 +1275,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>  	}
>  
>  	/* Use a bounce buffer since stack args cannot be mapped */
> -	ret = copy_args_to_argbuf(req);
> +	ret = copy_args_to_argbuf(req, gfp);
>  	if (ret < 0)
>  		goto out;
>  
> @@ -1367,7 +1373,7 @@ __releases(fiq->lock)
>  		 queue_id);
>  
>  	fsvq = &fs->vqs[queue_id];
> -	ret = virtio_fs_enqueue_req(fsvq, req, false);
> +	ret = virtio_fs_enqueue_req(fsvq, req, false, GFP_ATOMIC);
>  	if (ret < 0) {
>  		if (ret == -ENOSPC) {
>  			/*

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>



-- 
Thanks,
Jingbo

