Return-Path: <linux-fsdevel+bounces-28462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5D196AF91
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 05:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02F31F2511B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 03:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F84B57CA7;
	Wed,  4 Sep 2024 03:53:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68CD482E4;
	Wed,  4 Sep 2024 03:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725421990; cv=none; b=rqSBc7Ne0XZO8rPDjWvTuUwe9DqT4PpVQuExpRWPfk9SMXU7qVpn9ZpRAMN5F+MCbgFqy+j0+ciGda4btw5fyWIHluTNnr3FGK6eyvH/m5ckI7jCOFFXfsGBRdeCz+oLaAnCbMuAThlZFnQ+ySvqYcIa04JMn+AZ6B1XEWzMBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725421990; c=relaxed/simple;
	bh=qfTGY7LLPnbbGfe7hXasTXkhmXaQmCUKdfpKjG9YC3s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Hob/9d0yskuaVrN6QO+2S/uR8EpPAdECds4psYB+Z6BIZ4XVnoNKrChQU0Itis2AxBCrQh/H1DuiIr9KR2lNuwVOe14z2PizCGkn9lWHSPl2HtA3mNcYtfxFuWCO1ckziqWd7KZXcj/qmkJ3iO2F20m9aMH+lYk4P9AoQ/jWajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wz7qn5yyGz4f3jjy;
	Wed,  4 Sep 2024 11:52:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1F1E41A018D;
	Wed,  4 Sep 2024 11:53:04 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgB3rMid2ddmkCNbAQ--.7192S2;
	Wed, 04 Sep 2024 11:53:03 +0800 (CST)
Subject: Re: [PATCH v4 2/2] virtiofs: use GFP_NOFS when enqueuing request
 through kworker
To: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 "Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Benjamin Coddington <bcodding@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 houtao1@huawei.com
References: <20240831093750.1593871-1-houtao@huaweicloud.com>
 <20240831093750.1593871-3-houtao@huaweicloud.com>
 <5769af42-e4dd-4535-9432-f149b8c17af5@linux.alibaba.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <815f6c3d-bb8a-1a23-72dd-cd7b1f5f06d0@huaweicloud.com>
Date: Wed, 4 Sep 2024 11:53:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5769af42-e4dd-4535-9432-f149b8c17af5@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgB3rMid2ddmkCNbAQ--.7192S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW8Aw1xKrWkCryxZw4Utwb_yoWrKw1Dpr
	WDJa15CFWrJrW2gFW0qF4DWr129wsYkry7GrWfXa4akryYqrn7GFy8uFy0v39YvrykCF1x
	Zr4FqrsrursFv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 9/3/2024 5:34 PM, Jingbo Xu wrote:
>
> On 8/31/24 5:37 PM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When invoking virtio_fs_enqueue_req() through kworker, both the
>> allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
>> Considering the size of the sg array may be greater than PAGE_SIZE, use
>> GFP_NOFS instead of GFP_ATOMIC to lower the possibility of memory
>> allocation failure and to avoid unnecessarily depleting the atomic
>> reserves. GFP_NOFS is not passed to virtio_fs_enqueue_req() directly,
>> GFP_KERNEL and memalloc_nofs_{save|restore} helpers are used instead.
>>
>> It may seem OK to pass GFP_NOFS to virtio_fs_enqueue_req() as well when
>> queuing the request for the first time, but this is not the case. The
>> reason is that fuse_request_queue_background() may call
>> ->queue_request_and_unlock() while holding fc->bg_lock, which is a
>> spin-lock. Therefore, still use GFP_ATOMIC for it.
> Actually, .wake_pending_and_unlock() is called under fiq->lock and
> GFP_ATOMIC is requisite.

Er, but virtio_fs_wake_pending_and_unlock() unlocks fiq->lock before
queuing the request.
>
>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  fs/fuse/virtio_fs.c | 24 +++++++++++++++---------
>>  1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
>> index 43d66ab5e891..9bc48b3ca384 100644
>> --- a/fs/fuse/virtio_fs.c
>> +++ b/fs/fuse/virtio_fs.c
>> @@ -95,7 +95,8 @@ struct virtio_fs_req_work {
>>  };
>>  
>>  static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>> -				 struct fuse_req *req, bool in_flight);
>> +				 struct fuse_req *req, bool in_flight,
>> +				 gfp_t gfp);
>>  
>>  static const struct constant_table dax_param_enums[] = {
>>  	{"always",	FUSE_DAX_ALWAYS },
>> @@ -439,6 +440,8 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>>  
>>  	/* Dispatch pending requests */
>>  	while (1) {
>> +		unsigned int flags;
>> +
>>  		spin_lock(&fsvq->lock);
>>  		req = list_first_entry_or_null(&fsvq->queued_reqs,
>>  					       struct fuse_req, list);
>> @@ -449,7 +452,9 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>>  		list_del_init(&req->list);
>>  		spin_unlock(&fsvq->lock);
>>  
>> -		ret = virtio_fs_enqueue_req(fsvq, req, true);
>> +		flags = memalloc_nofs_save();
>> +		ret = virtio_fs_enqueue_req(fsvq, req, true, GFP_KERNEL);
>> +		memalloc_nofs_restore(flags);
>>  		if (ret < 0) {
>>  			if (ret == -ENOSPC) {
>>  				spin_lock(&fsvq->lock);
>> @@ -550,7 +555,7 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
>>  }
>>  
>>  /* Allocate and copy args into req->argbuf */
>> -static int copy_args_to_argbuf(struct fuse_req *req)
>> +static int copy_args_to_argbuf(struct fuse_req *req, gfp_t gfp)
>>  {
>>  	struct fuse_args *args = req->args;
>>  	unsigned int offset = 0;
>> @@ -564,7 +569,7 @@ static int copy_args_to_argbuf(struct fuse_req *req)
>>  	len = fuse_len_args(num_in, (struct fuse_arg *) args->in_args) +
>>  	      fuse_len_args(num_out, args->out_args);
>>  
>> -	req->argbuf = kmalloc(len, GFP_ATOMIC);
>> +	req->argbuf = kmalloc(len, gfp);
>>  	if (!req->argbuf)
>>  		return -ENOMEM;
>>  
>> @@ -1239,7 +1244,8 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
>>  
>>  /* Add a request to a virtqueue and kick the device */
>>  static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>> -				 struct fuse_req *req, bool in_flight)
>> +				 struct fuse_req *req, bool in_flight,
>> +				 gfp_t gfp)
>>  {
>>  	/* requests need at least 4 elements */
>>  	struct scatterlist *stack_sgs[6];
>> @@ -1260,8 +1266,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>>  	/* Does the sglist fit on the stack? */
>>  	total_sgs = sg_count_fuse_req(req);
>>  	if (total_sgs > ARRAY_SIZE(stack_sgs)) {
>> -		sgs = kmalloc_array(total_sgs, sizeof(sgs[0]), GFP_ATOMIC);
>> -		sg = kmalloc_array(total_sgs, sizeof(sg[0]), GFP_ATOMIC);
>> +		sgs = kmalloc_array(total_sgs, sizeof(sgs[0]), gfp);
>> +		sg = kmalloc_array(total_sgs, sizeof(sg[0]), gfp);
>>  		if (!sgs || !sg) {
>>  			ret = -ENOMEM;
>>  			goto out;
>> @@ -1269,7 +1275,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>>  	}
>>  
>>  	/* Use a bounce buffer since stack args cannot be mapped */
>> -	ret = copy_args_to_argbuf(req);
>> +	ret = copy_args_to_argbuf(req, gfp);
>>  	if (ret < 0)
>>  		goto out;
>>  
>> @@ -1367,7 +1373,7 @@ __releases(fiq->lock)
>>  		 queue_id);
>>  
>>  	fsvq = &fs->vqs[queue_id];
>> -	ret = virtio_fs_enqueue_req(fsvq, req, false);
>> +	ret = virtio_fs_enqueue_req(fsvq, req, false, GFP_ATOMIC);
>>  	if (ret < 0) {
>>  		if (ret == -ENOSPC) {
>>  			/*
> LGTM.
>
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Thanks for the review.
>
>


