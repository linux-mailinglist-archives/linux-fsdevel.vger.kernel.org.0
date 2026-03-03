Return-Path: <linux-fsdevel+bounces-79209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ2EINPTpmnHWgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 13:28:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E231EF688
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 13:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D71131141CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 12:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9313133F5A0;
	Tue,  3 Mar 2026 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OgudaeqH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA5313267;
	Tue,  3 Mar 2026 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772539405; cv=none; b=IsRGZsrgfIE8PYqm53QLQW2XZG1Skam2if/UoYxLEaCqWup86CZ5IHv7okfzrKApLbIZX2wTW5VtkIGQIkOVl74Q22PoJJab8vkl36GW4gji94j1jofnGFYpcGZrrfb3JZdmDxMqkB2KKEWR2LRHEXZIm6YaExUYCnvUjZU67Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772539405; c=relaxed/simple;
	bh=mIQs2vdLKFUMztx3UNVyUH9h1kjRTwVEl+7zZkflIBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PoluJLm5xc3TK2jo/L5YRlAhZe5euNuXw7CtBC3YM5n8uZwIsLfH5qkU3HTKdbz7g3GR0wxPOrqIQXmyCclYyH42e1zIeuBxsxoRpEMoLjfuWFZl0nB8wAeqWbVQSCRvK+tn+gWP401Mqi/umFDkQEQXWohDWKQg+NfPAcTGNPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OgudaeqH; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772539400; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4uW/1DwYKIVfN4L6I1i7GFtwixrQXETBMl0xi9nUwgs=;
	b=OgudaeqHjcKD2P+Dlgp33SOKXmkfNPkcOaLpTrxlddtCDrFZspL1Vg420LLgMNhos0Rbqd7V8nkFmdm+436cANY7WYsQA+nsyRrECabTN7weM1S0DIp/z9Kv//YrIOvfvBKgmSoPD5/ut41LnQVsQzAPfpSnoje6d84v/7Bv2eQ=
Received: from 30.221.146.213(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0X-9rZM5_1772539398 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Mar 2026 20:03:19 +0800
Message-ID: <8e322296-52c7-4826-adb3-7fb476cdf35b@linux.alibaba.com>
Date: Tue, 3 Mar 2026 20:03:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: move page cache invalidation after AIO to workqueue
To: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Cheng Ding <cding@ddn.com>
References: <20260303-async-dio-aio-cache-invalidation-v1-1-fba0fd0426c3@ddn.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20260303-async-dio-aio-cache-invalidation-v1-1-fba0fd0426c3@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C0E231EF688
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79209-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jefflexu@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ddn.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,alibaba.com:email]
X-Rspamd-Action: no action



On 3/3/26 6:23 PM, Bernd Schubert wrote:
> From: Cheng Ding <cding@ddn.com>
> 
> Invalidating the page cache in fuse_aio_complete() causes deadlock.
> Call Trace:
>  <TASK>
>  __schedule+0x27c/0x6b0
>  schedule+0x33/0x110
>  io_schedule+0x46/0x80
>  folio_wait_bit_common+0x136/0x330
>  __folio_lock+0x17/0x30
>  invalidate_inode_pages2_range+0x1d2/0x4f0
>  fuse_aio_complete+0x258/0x270 [fuse]
>  fuse_aio_complete_req+0x87/0xd0 [fuse]
>  fuse_request_end+0x18e/0x200 [fuse]
>  fuse_uring_req_end+0x87/0xd0 [fuse]
>  fuse_uring_cmd+0x241/0xf20 [fuse]
>  io_uring_cmd+0x9f/0x140
>  io_issue_sqe+0x193/0x410
>  io_submit_sqes+0x128/0x3e0
>  __do_sys_io_uring_enter+0x2ea/0x490
>  __x64_sys_io_uring_enter+0x22/0x40
> 
> Move the invalidate_inode_pages2_range() call to a workqueue worker
> to avoid this issue. This approach is similar to
> iomap_dio_bio_end_io().
> 
> (Minor edit by Bernd to avoid a merge conflict in Miklos' for-next
> branch). The commit is based on that branch with the addition of
> https://lore.kernel.org/r/20260111073701.6071-1-jefflexu@linux.alibaba.com)

I think it would be better to completely drop my previous patch and
rework on the bare ground, as the patch
(https://lore.kernel.org/r/20260111073701.6071-1-jefflexu@linux.alibaba.com)
is only in Miklos's branch, not merged to the master yet.


After reverting my previous patch, I think it would be cleaner by:


"The page cache invalidation for FOPEN_DIRECT_IO write in
fuse_direct_io() is moved to fuse_direct_write_iter() (with any progress
in write), to keep consistent with generic_file_direct_write().  This
covers the scenarios of both synchronous FOPEN_DIRECT_IO write
(regardless FUSE_ASYNC_DIO) and asynchronous FOPEN_DIRECT_IO write
without FUSE_ASYNC_DIO.

After that, only asynchronous direct write (for both FOPEN_DIRECT_IO and
non-FOPEN_DIRECT_IO) with FUSE_ASYNC_DIO is left."


```
@@ -1736,15 +1760,6 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io,
struct iov_iter *iter,
        if (res > 0)
                *ppos = pos;

-       if (res > 0 && write && fopen_direct_io) {
-               /*
-                * As in generic_file_direct_write(), invalidate after
-                * write, to invalidate read-ahead cache that may have
-                * with the write.
-                */
-               invalidate_inode_pages2_range(mapping, idx_from, idx_to);
-       }
-
        return res > 0 ? res : err;
 }
 EXPORT_SYMBOL_GPL(fuse_direct_io);

@@ -1799,6 +1814,14 @@ static ssize_t fuse_direct_write_iter(struct
kiocb *iocb, struct iov_iter *from)
                                             FUSE_DIO_WRITE);
                        fuse_write_update_attr(inode, iocb->ki_pos, res);
                }
+
+               /*
+                * As in generic_file_direct_write(), invalidate after
+                * write, to invalidate read-ahead cache that may have
+                * with the write.
+                */
+               if (res > 0)
+                       kiocb_invalidate_post_direct_write(iocb, res);
        }
        fuse_dio_unlock(iocb, exclusive);
```

> 
> Cc: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Cheng Ding <cding@ddn.com>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/file.c   | 39 +++++++++++++++++++++++++++++----------
>  fs/fuse/fuse_i.h |  1 +
>  2 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 64282c68d1ec7e4616e51735c1c0e8f2ec29cfad..b16515e3b42d33795ad45cf1e374ffab674714f7 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -23,6 +23,8 @@
>  #include <linux/task_io_accounting_ops.h>
>  #include <linux/iomap.h>
>  
> +int sb_init_dio_done_wq(struct super_block *sb);
> +

#include "../internal.h" ?

>  static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
>  			  unsigned int open_flags, int opcode,
>  			  struct fuse_open_out *outargp)
> @@ -635,6 +637,19 @@ static ssize_t fuse_get_res_by_io(struct fuse_io_priv *io)
>  	return io->bytes < 0 ? io->size : io->bytes;
>  }
>  
> +static void fuse_aio_invalidate_worker(struct work_struct *work)
> +{
> +	struct fuse_io_priv *io = container_of(work, struct fuse_io_priv, work);
> +	struct address_space *mapping = io->iocb->ki_filp->f_mapping;
> +	ssize_t res = fuse_get_res_by_io(io);
> +	pgoff_t start = io->offset >> PAGE_SHIFT;
> +	pgoff_t end = (io->offset + res - 1) >> PAGE_SHIFT;
> +
> +	invalidate_inode_pages2_range(mapping, start, end);
> +	io->iocb->ki_complete(io->iocb, res);
> +	kref_put(&io->refcnt, fuse_io_release);
> +}
> +
>  /*
>   * In case of short read, the caller sets 'pos' to the position of
>   * actual end of fuse request in IO request. Otherwise, if bytes_requested
> @@ -667,28 +682,32 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
>  	spin_unlock(&io->lock);
>  
>  	if (!left && !io->blocking) {
> +		struct inode *inode = file_inode(io->iocb->ki_filp);
> +		struct address_space *mapping = io->iocb->ki_filp->f_mapping;
>  		ssize_t res = fuse_get_res_by_io(io);
>  
>  		if (res >= 0) {
> -			struct inode *inode = file_inode(io->iocb->ki_filp);
>  			struct fuse_conn *fc = get_fuse_conn(inode);
>  			struct fuse_inode *fi = get_fuse_inode(inode);
> -			struct address_space *mapping = io->iocb->ki_filp->f_mapping;
>  
> +			spin_lock(&fi->lock);
> +			fi->attr_version = atomic64_inc_return(&fc->attr_version);
> +			spin_unlock(&fi->lock);
> +		}
> +
> +		if (io->write && res > 0 && mapping->nrpages) {
>  			/*
>  			 * As in generic_file_direct_write(), invalidate after the
>  			 * write, to invalidate read-ahead cache that may have competed
>  			 * with the write.
>  			 */
> -			if (io->write && res && mapping->nrpages) {
> -				invalidate_inode_pages2_range(mapping,
> -						io->offset >> PAGE_SHIFT,
> -						(io->offset + res - 1) >> PAGE_SHIFT);
> +			if (!inode->i_sb->s_dio_done_wq)
> +				res = sb_init_dio_done_wq(inode->i_sb);

Better to call sb_init_dio_done_wq() from fuse_direct_IO(), and fail the
IO directly if sb_init_dio_done_wq() fails.

> +			if (res >= 0) {
> +				INIT_WORK(&io->work, fuse_aio_invalidate_worker);
> +				queue_work(inode->i_sb->s_dio_done_wq, &io->work);
> +				return;
>  			}

Otherwise, the page cache invalidation would be missed if the previous
sb_init_dio_done_wq() fails.

> -
> -			spin_lock(&fi->lock);
> -			fi->attr_version = atomic64_inc_return(&fc->attr_version);
> -			spin_unlock(&fi->lock);
>  		}
>  
>  		io->iocb->ki_complete(io->iocb, res);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7f16049387d15e869db4be23a93605098588eda9..6e8c8cf6b2c82163acbfbd15c44b849898f945c1 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -377,6 +377,7 @@ union fuse_file_args {
>  /** The request IO state (for asynchronous processing) */
>  struct fuse_io_priv {
>  	struct kref refcnt;
> +	struct work_struct work;
>  	int async;
>  	spinlock_t lock;
>  	unsigned reqs;


-- 
Thanks,
Jingbo


