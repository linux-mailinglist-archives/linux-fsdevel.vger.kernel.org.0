Return-Path: <linux-fsdevel+bounces-14039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE675876F14
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 05:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891051C20C70
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 04:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9205E364A5;
	Sat,  9 Mar 2024 04:14:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE2241E2;
	Sat,  9 Mar 2024 04:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709957674; cv=none; b=dCXWb4EnBBdlF6W/V3/r1lVFc/HTZ5bhabbiG1pOWCAI0rzpE8CY3re72qBQFn1EI2Y+vQATT8OefzHsdVRSu/+CwFJkIFIpPBFNUAnN3iUGkP46/CR8X+0mAtFJkCu6tYaMISksq94c51d2lCds3GNbULlQ0NQ7mBtjC9ITSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709957674; c=relaxed/simple;
	bh=aDharQ5Zr3CvZw8T5yYIYXdAyz83YOaP3kBsZGPqdUo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=P8tCXioLZmmfzN1fX7f2RkQbwT3RdwIcOp65f7zuaw/CAEnD/oHsol6YsAmVxmhYjOU6Jw22tziPDS68j4ApDCFrqlhLId7ezWmmcqntpQbHX4ggmt7eANrOT8YtvtUs9LNI9uCL4eZDU5q6dcG5dRcqHHUn9sk+QEqxip0Mcuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ts8nC4LTJz4f3jjw;
	Sat,  9 Mar 2024 12:14:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 342BC1A0C21;
	Sat,  9 Mar 2024 12:14:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgB3ymwf4utlrj30GQ--.5053S2;
	Sat, 09 Mar 2024 12:14:27 +0800 (CST)
Subject: Re: [PATCH v2 4/6] virtiofs: support bounce buffer backed by
 scattered pages
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 "Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Benjamin Coddington <bcodding@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 houtao1@huawei.com
References: <20240228144126.2864064-1-houtao@huaweicloud.com>
 <20240228144126.2864064-5-houtao@huaweicloud.com> <ZeCcV9Jo3mTRPsME@bfoster>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ef80346a-532a-c394-77f7-ec9f640e5b6f@huaweicloud.com>
Date: Sat, 9 Mar 2024 12:14:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZeCcV9Jo3mTRPsME@bfoster>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgB3ymwf4utlrj30GQ--.5053S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GrW8AFyrWrW7JFWrJF18Krg_yoW7CF15pF
	WUt3W5CFZ7JFW2kryxKF4UCF1Fk393uF17GrZ3XasYkr1DZrWSqFy5JryF9Fs7Ar97CF10
	yF10van7Wr1qy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/29/2024 11:01 PM, Brian Foster wrote:
> On Wed, Feb 28, 2024 at 10:41:24PM +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When reading a file kept in virtiofs from kernel (e.g., insmod a kernel
>> module), if the cache of virtiofs is disabled, the read buffer will be
>> passed to virtiofs through out_args[0].value instead of pages. Because
>> virtiofs can't get the pages for the read buffer, virtio_fs_argbuf_new()
>> will create a bounce buffer for the read buffer by using kmalloc() and
>> copy the read buffer into bounce buffer. If the read buffer is large
>> (e.g., 1MB), the allocation will incur significant stress on the memory
>> subsystem.
>>
>> So instead of allocating bounce buffer by using kmalloc(), allocate a
>> bounce buffer which is backed by scattered pages. The original idea is
>> to use vmap(), but the use of GFP_ATOMIC is no possible for vmap(). To
>> simplify the copy operations in the bounce buffer, use a bio_vec flex
>> array to represent the argbuf. Also add an is_flat field in struct
>> virtio_fs_argbuf to distinguish between kmalloc-ed and scattered bounce
>> buffer.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  fs/fuse/virtio_fs.c | 163 ++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 149 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
>> index f10fff7f23a0f..ffea684bd100d 100644
>> --- a/fs/fuse/virtio_fs.c
>> +++ b/fs/fuse/virtio_fs.c
> ...
>> @@ -408,42 +425,143 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>>  	}
>>  }
>>  
> ...  
>>  static void virtio_fs_argbuf_copy_from_in_arg(struct virtio_fs_argbuf *argbuf,
>>  					      unsigned int offset,
>>  					      const void *src, unsigned int len)
>>  {
>> -	memcpy(argbuf->buf + offset, src, len);
>> +	struct iov_iter iter;
>> +	unsigned int copied;
>> +
>> +	if (argbuf->is_flat) {
>> +		memcpy(argbuf->f.buf + offset, src, len);
>> +		return;
>> +	}
>> +
>> +	iov_iter_bvec(&iter, ITER_DEST, argbuf->s.bvec,
>> +		      argbuf->s.nr, argbuf->s.size);
>> +	iov_iter_advance(&iter, offset);
> Hi Hou,
>
> Just a random comment, but it seems a little inefficient to reinit and
> readvance the iter like this on every copy/call. It looks like offset is
> already incremented in the callers of the argbuf copy helpers. Perhaps
> iov_iter could be lifted into the callers and passed down, or even just
> include it in the argbuf structure and init it at alloc time?

Sorry for the late reply. Being busy with off-site workshop these days.

I have tried a similar idea before in which iov_iter was saved directly
in argbuf struct, but it didn't work out well. The reason is that for
copy both in_args and out_args, an iov_iter is needed, but the direction
is different. Currently the bi-directional io_vec is not supported, so
the code have to initialize the iov_iter twice: one for copy from
in_args and another one for copy to out_args.

For dio read initiated from kernel, both of its in_numargs and
out_numargs is 1, so there will be only one iov_iter_advance() in
virtio_fs_argbuf_copy_to_out_arg() and the offset is 64, so I think the
overhead will be fine. For dio write initiated from kernel, its
in_numargs is 2 and out_numargs is 1, so there will be two invocations
of iov_iter_advance(). The first one with offset=64, and the another one
with offset=round_up_page_size(64 + write_size), so the later one may
introduce extra overhead. But compared with the overhead of data copy, I
still think the overhead of calling iov_iter_advance() is fine.

> Brian
>
>> +
>> +	copied = _copy_to_iter(src, len, &iter);
>> +	WARN_ON_ONCE(copied != len);
>>  }
>>  
>>  static unsigned int
>> @@ -451,15 +569,32 @@ virtio_fs_argbuf_out_args_offset(struct virtio_fs_argbuf *argbuf,
>>  				 const struct fuse_args *args)
>>  {
>>  	unsigned int num_in = args->in_numargs - args->in_pages;
>> +	unsigned int offset = fuse_len_args(num_in,
>> +					    (struct fuse_arg *)args->in_args);
>>  
>> -	return fuse_len_args(num_in, (struct fuse_arg *)args->in_args);
>> +	if (argbuf->is_flat)
>> +		return offset;
>> +	return round_up(offset, PAGE_SIZE);
>>  }
>>  
>>  static void virtio_fs_argbuf_copy_to_out_arg(struct virtio_fs_argbuf *argbuf,
>>  					     unsigned int offset, void *dst,
>>  					     unsigned int len)
>>  {
>> -	memcpy(dst, argbuf->buf + offset, len);
>> +	struct iov_iter iter;
>> +	unsigned int copied;
>> +
>> +	if (argbuf->is_flat) {
>> +		memcpy(dst, argbuf->f.buf + offset, len);
>> +		return;
>> +	}
>> +
>> +	iov_iter_bvec(&iter, ITER_SOURCE, argbuf->s.bvec,
>> +		      argbuf->s.nr, argbuf->s.size);
>> +	iov_iter_advance(&iter, offset);
>> +
>> +	copied = _copy_from_iter(dst, len, &iter);
>> +	WARN_ON_ONCE(copied != len);
>>  }
>>  
>>  /*
>> @@ -1154,7 +1289,7 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
>>  	len = fuse_len_args(numargs - argpages, args);
>>  	if (len)
>>  		total_sgs += virtio_fs_argbuf_setup_sg(req->argbuf, *len_used,
>> -						       len, &sg[total_sgs]);
>> +						       &len, &sg[total_sgs]);
>>  
>>  	if (argpages)
>>  		total_sgs += sg_init_fuse_pages(&sg[total_sgs],
>> @@ -1199,7 +1334,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>>  	}
>>  
>>  	/* Use a bounce buffer since stack args cannot be mapped */
>> -	req->argbuf = virtio_fs_argbuf_new(args, GFP_ATOMIC);
>> +	req->argbuf = virtio_fs_argbuf_new(args, GFP_ATOMIC, true);
>>  	if (!req->argbuf) {
>>  		ret = -ENOMEM;
>>  		goto out;
>> -- 
>> 2.29.2
>>
>>


