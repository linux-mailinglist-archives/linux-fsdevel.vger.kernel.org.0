Return-Path: <linux-fsdevel+bounces-7674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F188291FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 02:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DAF1F26B8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 01:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B31232C71;
	Wed, 10 Jan 2024 01:17:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834652AE87;
	Wed, 10 Jan 2024 01:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T8qdY66gtz4f3khY;
	Wed, 10 Jan 2024 09:16:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5B3311A038B;
	Wed, 10 Jan 2024 09:16:53 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgC3hxAB8J1lBYp_AQ--.55646S2;
	Wed, 10 Jan 2024 09:16:53 +0800 (CST)
Subject: Re: [PATCH] virtiofs: limit the length of ITER_KVEC dio by
 max_nopage_rw
To: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, houtao1@huawei.com
References: <20240103105929.1902658-1-houtao@huaweicloud.com>
 <b6c0d521-bba8-447f-b114-0a679ca89e4b@fastmail.fm>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <c71c80af-2813-dee5-a8e5-3782b34e9eb9@huaweicloud.com>
Date: Wed, 10 Jan 2024 09:16:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b6c0d521-bba8-447f-b114-0a679ca89e4b@fastmail.fm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgC3hxAB8J1lBYp_AQ--.55646S2
X-Coremail-Antispam: 1UD129KBjvJXoW3ArW7Cw1rWw1ruFykZr1xGrg_yoW3uFyxpr
	s3tFW5ZrWfJF1kCr17JF1UZryrAw18Ganrtr1rXasavr47Ar9F9F4UXFyjgFy7ArW8Jr1I
	qr4qqry7Zrs0vaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/9/2024 9:11 PM, Bernd Schubert wrote:
>
>
> On 1/3/24 11:59, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When trying to insert a 10MB kernel module kept in a virtiofs with cache
>> disabled, the following warning was reported:
>>
>>    ------------[ cut here ]------------
>>    WARNING: CPU: 2 PID: 439 at mm/page_alloc.c:4544 ......
>>    Modules linked in:
>>    CPU: 2 PID: 439 Comm: insmod Not tainted 6.7.0-rc7+ #33
>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ......
>>    RIP: 0010:__alloc_pages+0x2c4/0x360
>>    ......
>>    Call Trace:
>>     <TASK>
>>     ? __warn+0x8f/0x150
>>     ? __alloc_pages+0x2c4/0x360
>>     __kmalloc_large_node+0x86/0x160
>>     __kmalloc+0xcd/0x140
>>     virtio_fs_enqueue_req+0x240/0x6d0
>>     virtio_fs_wake_pending_and_unlock+0x7f/0x190
>>     queue_request_and_unlock+0x58/0x70
>>     fuse_simple_request+0x18b/0x2e0
>>     fuse_direct_io+0x58a/0x850
>>     fuse_file_read_iter+0xdb/0x130
>>     __kernel_read+0xf3/0x260
>>     kernel_read+0x45/0x60
>>     kernel_read_file+0x1ad/0x2b0
>>     init_module_from_file+0x6a/0xe0
>>     idempotent_init_module+0x179/0x230
>>     __x64_sys_finit_module+0x5d/0xb0
>>     do_syscall_64+0x36/0xb0
>>     entry_SYSCALL_64_after_hwframe+0x6e/0x76
>>     ......
>>     </TASK>
>>    ---[ end trace 0000000000000000 ]---
>>
>> The warning happened as follow. In copy_args_to_argbuf(), virtiofs uses
>> kmalloc-ed memory as bound buffer for fuse args, but
>> fuse_get_user_pages() only limits the length of fuse arg by max_read or
>> max_write for IOV_KVEC io (e.g., kernel_read_file from finit_module()).
>> For virtiofs, max_read is UINT_MAX, so a big read request which is about
>
>
> I find this part of the explanation a bit confusing. I guess you
> wanted to write something like
>
> fuse_direct_io() -> fuse_get_user_pages() is limited by
> fc->max_write/fc->max_read and fc->max_pages. For virtiofs max_pages
> does not apply as ITER_KVEC is used. As virtiofs sets fc->max_read to
> UINT_MAX basically no limit is applied at all.

Yes, what you said is just as expected but it is not the root cause of
the warning. The culprit of the warning is kmalloc() in
copy_args_to_argbuf() just as said in commit message. vmalloc() is also
not acceptable, because the physical memory needs to be contiguous. For
the problem, because there is no page involved, so there will be extra
sg available, maybe we can use these sg to break the big read/write
request into page.
>
> I also wonder if it wouldn't it make sense to set a sensible limit in
> virtio_fs_ctx_set_defaults() instead of introducing a new variable?

As said in the commit message:

A feasible solution is to limit the value of max_read for virtiofs, so
the length passed to kmalloc() will be limited. However it will affects
the max read size for ITER_IOVEC io and the value of max_write also needs
limitation.

It is a bit hard to set a reasonable value for both max_read and
max_write to handle both normal ITER_IOVEC io and ITER_KVEC io. And
considering ITER_KVEC io + dio case is uncommon, I think using a new
limitation is more reasonable.
>
> Also, I guess the issue is kmalloc_array() in virtio_fs_enqueue_req?
> Wouldn't it make sense to use kvm_alloc_array/kvfree in that function?
>
>
> Thanks,
> Bernd
>
>
>> 10MB is passed to copy_args_to_argbuf(), kmalloc() is called in turn
>> with len=10MB, and triggers the warning in __alloc_pages():
>> WARN_ON_ONCE_GFP(order > MAX_ORDER, gfp)).
>>
>> A feasible solution is to limit the value of max_read for virtiofs, so
>> the length passed to kmalloc() will be limited. However it will affects
>> the max read size for ITER_IOVEC io and the value of max_write also
>> needs
>> limitation. So instead of limiting the values of max_read and max_write,
>> introducing max_nopage_rw to cap both the values of max_read and
>> max_write when the fuse dio read/write request is initiated from kernel.
>>
>> Considering that fuse read/write request from kernel is uncommon and to
>> decrease the demand for large contiguous pages, set max_nopage_rw as
>> 256KB instead of KMALLOC_MAX_SIZE - 4096 or similar.
>>
>> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>   fs/fuse/file.c      | 12 +++++++++++-
>>   fs/fuse/fuse_i.h    |  3 +++
>>   fs/fuse/inode.c     |  1 +
>>   fs/fuse/virtio_fs.c |  6 ++++++
>>   4 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index a660f1f21540..f1beb7c0b782 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1422,6 +1422,16 @@ static int fuse_get_user_pages(struct
>> fuse_args_pages *ap, struct iov_iter *ii,
>>       return ret < 0 ? ret : 0;
>>   }
>>   +static size_t fuse_max_dio_rw_size(const struct fuse_conn *fc,
>> +                   const struct iov_iter *iter, int write)
>> +{
>> +    unsigned int nmax = write ? fc->max_write : fc->max_read;
>> +
>> +    if (iov_iter_is_kvec(iter))
>> +        nmax = min(nmax, fc->max_nopage_rw);
>> +    return nmax;
>> +}
>> +
>>   ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>>                  loff_t *ppos, int flags)
>>   {
>> @@ -1432,7 +1442,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io,
>> struct iov_iter *iter,
>>       struct inode *inode = mapping->host;
>>       struct fuse_file *ff = file->private_data;
>>       struct fuse_conn *fc = ff->fm->fc;
>> -    size_t nmax = write ? fc->max_write : fc->max_read;
>> +    size_t nmax = fuse_max_dio_rw_size(fc, iter, write);
>>       loff_t pos = *ppos;
>>       size_t count = iov_iter_count(iter);
>>       pgoff_t idx_from = pos >> PAGE_SHIFT;
>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>> index 1df83eebda92..fc753cd34211 100644
>> --- a/fs/fuse/fuse_i.h
>> +++ b/fs/fuse/fuse_i.h
>> @@ -594,6 +594,9 @@ struct fuse_conn {
>>       /** Constrain ->max_pages to this value during feature
>> negotiation */
>>       unsigned int max_pages_limit;
>>   +    /** Maximum read/write size when there is no page in request */
>> +    unsigned int max_nopage_rw;
>> +
>>       /** Input queue */
>>       struct fuse_iqueue iq;
>>   diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index 2a6d44f91729..4cbbcb4a4b71 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -923,6 +923,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct
>> fuse_mount *fm,
>>       fc->user_ns = get_user_ns(user_ns);
>>       fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
>>       fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
>> +    fc->max_nopage_rw = UINT_MAX;
>>         INIT_LIST_HEAD(&fc->mounts);
>>       list_add(&fm->fc_entry, &fc->mounts);
>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
>> index 5f1be1da92ce..3aac31d45198 100644
>> --- a/fs/fuse/virtio_fs.c
>> +++ b/fs/fuse/virtio_fs.c
>> @@ -1452,6 +1452,12 @@ static int virtio_fs_get_tree(struct
>> fs_context *fsc)
>>       /* Tell FUSE to split requests that exceed the virtqueue's size */
>>       fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
>>                       virtqueue_size - FUSE_HEADER_OVERHEAD);
>> +    /* copy_args_to_argbuf() uses kmalloc-ed memory as bounce buffer
>> +     * for fuse args, so limit the total size of these args to prevent
>> +     * the warning in __alloc_pages() and decrease the demand for large
>> +     * contiguous pages.
>> +     */
>> +    fc->max_nopage_rw = min(fc->max_nopage_rw, 256U << 10);
>>         fsc->s_fs_info = fm;
>>       sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
> .


