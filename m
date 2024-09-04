Return-Path: <linux-fsdevel+bounces-28461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2EA96AF8D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 05:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4298DB21178
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 03:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3D6558B6;
	Wed,  4 Sep 2024 03:50:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0111E515;
	Wed,  4 Sep 2024 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725421835; cv=none; b=GG2WtdzGVxXRVOi7xG8X8uAvOojdqMLwOWuThhLQqQALOnkl4q1xTeqEG9VakbuP3sToQeVm981aElBRNI8fAzo2TlKilCr8IQlOJWVN25qqLSbfBePz0b/J22Mi7yTfmA2zTTQy0FZT1qliNP/9utrjgyH8ggz1yefJYAMZjGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725421835; c=relaxed/simple;
	bh=hFMnDmxVkkoxLJI4eHL2y2iXdvzX0K18YIayDSFys7U=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GRENyAyxenl5KPBy6eqyAhwkPiBIrnq3iDl7mbMEVzY4sqgU+GFnO1JhbnskiCtne1rLBQZOjNKPrZY8ZUQPzTObqKmI5wRVEicywTv0klBwSfO6upjhYICVStUlPNgKQDpr6JpDUdPxtv3PPiQkxsM/hGiROr8ZNZ8nJiMW678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wz7mg6M1kz4f3kw5;
	Wed,  4 Sep 2024 11:50:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B5A171A07B6;
	Wed,  4 Sep 2024 11:50:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBnu4f_2NdmAdNPAQ--.50726S2;
	Wed, 04 Sep 2024 11:50:27 +0800 (CST)
Subject: Re: [PATCH v4 1/2] virtiofs: use pages instead of pointer for kernel
 direct IO
To: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 "Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Benjamin Coddington <bcodding@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 houtao1@huawei.com
References: <20240831093750.1593871-1-houtao@huaweicloud.com>
 <20240831093750.1593871-2-houtao@huaweicloud.com>
 <6074d653-3dd3-45a3-9241-a9e2e12252c6@linux.alibaba.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ce91a37d-762f-75f8-3b16-dd714fceb4b9@huaweicloud.com>
Date: Wed, 4 Sep 2024 11:50:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6074d653-3dd3-45a3-9241-a9e2e12252c6@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBnu4f_2NdmAdNPAQ--.50726S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jry8AF13WF1rJr4xZF1kXwb_yoW7trWxpr
	W5Kan0yFWxXrW7ur13Ga1Uur1Sv3yrKa18GrWfJa45Jrnaqr9FkF1Y9a4jgFy3Zr1vyrsF
	qF4jvrsFgayqg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 9/3/2024 4:44 PM, Jingbo Xu wrote:
>
> On 8/31/24 5:37 PM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When trying to insert a 10MB kernel module kept in a virtio-fs with cache
>> disabled, the following warning was reported:
>>

SNIP
>>
>> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Tested-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Thanks for the test.
>
>
>> ---
>>  fs/fuse/file.c      | 62 +++++++++++++++++++++++++++++++--------------
>>  fs/fuse/fuse_i.h    |  6 +++++
>>  fs/fuse/virtio_fs.c |  1 +
>>  3 files changed, 50 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index f39456c65ed7..331208d3e4d1 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -645,7 +645,7 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
>>  	args->out_args[0].size = count;
>>  }
>>  
>> -

SNIP
>>  static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>>  			       size_t *nbytesp, int write,
>> -			       unsigned int max_pages)
>> +			       unsigned int max_pages,
>> +			       bool use_pages_for_kvec_io)
>>  {
>> +	bool flush_or_invalidate = false;
>>  	size_t nbytes = 0;  /* # bytes already packed in req */
>>  	ssize_t ret = 0;
>>  
>> -	/* Special case for kernel I/O: can copy directly into the buffer */
>> +	/* Special case for kernel I/O: can copy directly into the buffer.
>> +	 * However if the implementation of fuse_conn requires pages instead of
>> +	 * pointer (e.g., virtio-fs), use iov_iter_extract_pages() instead.
>> +	 */
>>  	if (iov_iter_is_kvec(ii)) {
>> -		unsigned long user_addr = fuse_get_user_addr(ii);
>> -		size_t frag_size = fuse_get_frag_size(ii, *nbytesp);
>> +		void *user_addr = (void *)fuse_get_user_addr(ii);
>>  
>> -		if (write)
>> -			ap->args.in_args[1].value = (void *) user_addr;
>> -		else
>> -			ap->args.out_args[0].value = (void *) user_addr;
>> +		if (!use_pages_for_kvec_io) {
>> +			size_t frag_size = fuse_get_frag_size(ii, *nbytesp);
>>  
>> -		iov_iter_advance(ii, frag_size);
>> -		*nbytesp = frag_size;
>> -		return 0;
>> +			if (write)
>> +				ap->args.in_args[1].value = user_addr;
>> +			else
>> +				ap->args.out_args[0].value = user_addr;
>> +
>> +			iov_iter_advance(ii, frag_size);
>> +			*nbytesp = frag_size;
>> +			return 0;
>> +		}
>> +
>> +		if (is_vmalloc_addr(user_addr)) {
>> +			ap->args.vmap_base = user_addr;
>> +			flush_or_invalidate = true;
> Could we move flush_kernel_vmap_range() upon here, so that
> flush_or_invalidate is not needed anymore and the code looks cleaner?

flush_kernel_vmap_range() needs to know the length of the flushed area,
if moving it here(), the length will be unknown.
>
>> +		}
>>  	}
>>  
>>  	while (nbytes < *nbytesp && ap->num_pages < max_pages) {
>> @@ -1513,6 +1533,10 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>>  			(PAGE_SIZE - ret) & (PAGE_SIZE - 1);
>>  	}
>>  
>> +	if (write && flush_or_invalidate)
>> +		flush_kernel_vmap_range(ap->args.vmap_base, nbytes);
>> +
>> +	ap->args.invalidate_vmap = !write && flush_or_invalidate;
> How about initializing vmap_base only when the data buffer is vmalloced
> and it's a read request?  In this case invalidate_vmap is no longer needed.

You mean using the value of vmap_base to indicate whether invalidation
is needed or not, right ? I prefer to keep it, because the extra
variable invalidate_vmap indicates the required action for the vmap area
and it doesn't increase the size of fuse_args.

>
>>  	ap->args.is_pinned = iov_iter_extract_will_pin(ii);
>>  	ap->args.user_pages = true;
>>  	if (write)
>> @@ -1581,7 +1605,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>>  		size_t nbytes = min(count, nmax);
>>  
>>  		err = fuse_get_user_pages(&ia->ap, iter, &nbytes, write,
>> -					  max_pages);
>> +					  max_pages, fc->use_pages_for_kvec_io);
>>  		if (err && !nbytes)
>>  			break;
>>  
>> @@ -1595,7 +1619,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>>  		}
>>  
>>  		if (!io->async || nres < 0) {
>> -			fuse_release_user_pages(&ia->ap, io->should_dirty);
>> +			fuse_release_user_pages(&ia->ap, nres, io->should_dirty);
>>  			fuse_io_free(ia);
>>  		}
>>  		ia = NULL;
>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>> index f23919610313..79add14c363f 100644
>> --- a/fs/fuse/fuse_i.h
>> +++ b/fs/fuse/fuse_i.h
>> @@ -309,9 +309,12 @@ struct fuse_args {
>>  	bool may_block:1;
>>  	bool is_ext:1;
>>  	bool is_pinned:1;
>> +	bool invalidate_vmap:1;
>>  	struct fuse_in_arg in_args[3];
>>  	struct fuse_arg out_args[2];
>>  	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
>> +	/* Used for kvec iter backed by vmalloc address */
>> +	void *vmap_base;
>>  };
>>  
>>  struct fuse_args_pages {
>> @@ -860,6 +863,9 @@ struct fuse_conn {
>>  	/** Passthrough support for read/write IO */
>>  	unsigned int passthrough:1;
>>  
>> +	/* Use pages instead of pointer for kernel I/O */
>> +	unsigned int use_pages_for_kvec_io:1;
> Maybe we need a better (actually shorter) name for this flag. kvec_pages?

Naming is hard. The name "use_pages_for_kvec_io" is verbose indeed.
kvec_pages is better. Will update it in the next spin.
>
>> +
>>  	/** Maximum stack depth for passthrough backing files */
>>  	int max_stack_depth;
>>  
>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
>> index dd5260141615..43d66ab5e891 100644
>> --- a/fs/fuse/virtio_fs.c
>> +++ b/fs/fuse/virtio_fs.c
>> @@ -1568,6 +1568,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>>  	fc->delete_stale = true;
>>  	fc->auto_submounts = true;
>>  	fc->sync_fs = true;
>> +	fc->use_pages_for_kvec_io = true;
>>  
>>  	/* Tell FUSE to split requests that exceed the virtqueue's size */
>>  	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,


