Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25C3435376
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 21:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhJTTLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 15:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230076AbhJTTLU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634756945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UgUA3SJ5DsBMw0PT4Kwb/d/AnN0maV/O7njAQ0lG5Y0=;
        b=OQmWHSSEm5703fO66gJf/F249L4/ZhQgHxWXJ8bfiwTUfYQ5GqYaaEbvtZ8Ml8p4aGj8Y+
        cLZjmfB2a1MM1+9J7bIEr89UW0RaMhgh0cglXNIruk8a0YOdvcem64krh/OnbFT39lLZfb
        JEogeW8YDiauoYDiTaRlkFdqTsBoHLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-zGgJztRYOi2ewamZsnt96Q-1; Wed, 20 Oct 2021 15:09:00 -0400
X-MC-Unique: zGgJztRYOi2ewamZsnt96Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E0C25074C;
        Wed, 20 Oct 2021 19:08:59 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D70869119;
        Wed, 20 Oct 2021 19:08:58 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
        <x498ryno93g.fsf@segfault.boston.devel.redhat.com>
        <16a7a029-0d23-6a14-9ae9-79ab8a9adb34@kernel.dk>
        <x494k9bo84w.fsf@segfault.boston.devel.redhat.com>
        <80244d5b-692c-35ac-e468-2581ff869395@kernel.dk>
        <8f5fdbbf-dc66-fabe-db3b-01b2085083b0@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 20 Oct 2021 15:11:03 -0400
In-Reply-To: <8f5fdbbf-dc66-fabe-db3b-01b2085083b0@kernel.dk> (Jens Axboe's
        message of "Wed, 20 Oct 2021 12:56:05 -0600")
Message-ID: <x49zgr3mrzs.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 10/20/21 12:41 PM, Jens Axboe wrote:
>> Working on just changing it to a 64-bit type instead, then we can pass
>> in both at once with res2 being the upper 32 bits. That'll keep the same
>> API on the aio side.
>
> Here's that as an incremental. Since we can only be passing in 32-bits
> anyway across 32/64-bit, we can just make it an explicit 64-bit instead.
> This generates the same code on 64-bit for calling ->ki_complete, and we
> can trivially ignore the usb gadget issue as we now can pass in both
> values (and fill them in on the aio side).

Yeah, I think that should work.

Cheers,
Jeff

>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 92b87aa8be86..66c6e0c5d638 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -550,7 +550,7 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
>  		blk_mq_complete_request(rq);
>  }
>  
> -static void lo_rw_aio_complete(struct kiocb *iocb, long ret)
> +static void lo_rw_aio_complete(struct kiocb *iocb, u64 ret)
>  {
>  	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
>  
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index 80a0f35ae1dc..83a2f5b0a3a0 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -123,7 +123,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
>  	return call_iter(iocb, &iter);
>  }
>  
> -static void nvmet_file_io_done(struct kiocb *iocb, long ret)
> +static void nvmet_file_io_done(struct kiocb *iocb, u64 ret)
>  {
>  	struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
>  	u16 status = NVME_SC_SUCCESS;
> diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
> index 968ace2ddf64..c4ca7fa18e61 100644
> --- a/drivers/target/target_core_file.c
> +++ b/drivers/target/target_core_file.c
> @@ -245,7 +245,7 @@ struct target_core_file_cmd {
>  	struct bio_vec	bvecs[];
>  };
>  
> -static void cmd_rw_aio_complete(struct kiocb *iocb, long ret)
> +static void cmd_rw_aio_complete(struct kiocb *iocb, u64 ret)
>  {
>  	struct target_core_file_cmd *cmd;
>  
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index e20c19a0f106..8536f19d3c9a 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -831,7 +831,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
>  		kthread_unuse_mm(io_data->mm);
>  	}
>  
> -	io_data->kiocb->ki_complete(io_data->kiocb, ret);
> +	io_data->kiocb->ki_complete(io_data->kiocb, ((u64) ret << 32) | ret);
>  
>  	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
>  		eventfd_signal(io_data->ffs->ffs_eventfd, 1);
> diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
> index ad1739dbfab9..d3deb23eb2ab 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -469,7 +469,7 @@ static void ep_user_copy_worker(struct work_struct *work)
>  		ret = -EFAULT;
>  
>  	/* completing the iocb can drop the ctx and mm, don't touch mm after */
> -	iocb->ki_complete(iocb, ret);
> +	iocb->ki_complete(iocb, ((u64) ret << 32) | ret);
>  
>  	kfree(priv->buf);
>  	kfree(priv->to_free);
> @@ -492,14 +492,16 @@ static void ep_aio_complete(struct usb_ep *ep, struct usb_request *req)
>  	 * complete the aio request immediately.
>  	 */
>  	if (priv->to_free == NULL || unlikely(req->actual == 0)) {
> +		u64 aio_ret;
> +
>  		kfree(req->buf);
>  		kfree(priv->to_free);
>  		kfree(priv);
>  		iocb->private = NULL;
>  		/* aio_complete() reports bytes-transferred _and_ faults */
> -
> -		iocb->ki_complete(iocb,
> -				req->actual ? req->actual : (long)req->status);
> +		aio_ret = req->actual ? req->actual : (long)req->status;
> +		aio_ret |= (u64) req->status << 32;
> +		iocb->ki_complete(iocb, aio_ret);
>  	} else {
>  		/* ep_copy_to_user() won't report both; we hide some faults */
>  		if (unlikely(0 != req->status))
> diff --git a/fs/aio.c b/fs/aio.c
> index 836dc7e48db7..e39c61dccf37 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1417,7 +1417,7 @@ static void aio_remove_iocb(struct aio_kiocb *iocb)
>  	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
>  }
>  
> -static void aio_complete_rw(struct kiocb *kiocb, long res)
> +static void aio_complete_rw(struct kiocb *kiocb, u64 res)
>  {
>  	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
>  
> @@ -1436,8 +1436,8 @@ static void aio_complete_rw(struct kiocb *kiocb, long res)
>  		file_end_write(kiocb->ki_filp);
>  	}
>  
> -	iocb->ki_res.res = res;
> -	iocb->ki_res.res2 = 0;
> +	iocb->ki_res.res = res & 0xffffffff;
> +	iocb->ki_res.res2 = res >> 32;
>  	iocb_put(iocb);
>  }
>  
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index effe37ef8629..b2f44ff8eae2 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -37,11 +37,11 @@ static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
>  /*
>   * Handle completion of a read from the cache.
>   */
> -static void cachefiles_read_complete(struct kiocb *iocb, long ret)
> +static void cachefiles_read_complete(struct kiocb *iocb, u64 ret)
>  {
>  	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
>  
> -	_enter("%ld", ret);
> +	_enter("%llu", (unsigned long long) ret);
>  
>  	if (ki->term_func) {
>  		if (ret >= 0)
> @@ -159,12 +159,12 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
>  /*
>   * Handle completion of a write to the cache.
>   */
> -static void cachefiles_write_complete(struct kiocb *iocb, long ret)
> +static void cachefiles_write_complete(struct kiocb *iocb, u64 ret)
>  {
>  	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
>  	struct inode *inode = file_inode(ki->iocb.ki_filp);
>  
> -	_enter("%ld", ret);
> +	_enter("%llu", (unsigned long long) ret);
>  
>  	/* Tell lockdep we inherited freeze protection from submission thread */
>  	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 5ad046145f29..0ed6c199f394 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2672,7 +2672,7 @@ static void __io_complete_rw(struct io_kiocb *req, long res, long res2,
>  	__io_req_complete(req, issue_flags, req->result, io_put_rw_kbuf(req));
>  }
>  
> -static void io_complete_rw(struct kiocb *kiocb, long res)
> +static void io_complete_rw(struct kiocb *kiocb, u64 res)
>  {
>  	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw.kiocb);
>  
> @@ -2683,7 +2683,7 @@ static void io_complete_rw(struct kiocb *kiocb, long res)
>  	io_req_task_work_add(req);
>  }
>  
> -static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
> +static void io_complete_rw_iopoll(struct kiocb *kiocb, u64 res)
>  {
>  	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw.kiocb);
>  
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index ac461a499882..ff7db16aea2e 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -272,7 +272,7 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
>  	kmem_cache_free(ovl_aio_request_cachep, aio_req);
>  }
>  
> -static void ovl_aio_rw_complete(struct kiocb *iocb, long res)
> +static void ovl_aio_rw_complete(struct kiocb *iocb, u64 res)
>  {
>  	struct ovl_aio_req *aio_req = container_of(iocb,
>  						   struct ovl_aio_req, iocb);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 0dcb9020a7b3..3c809ce2518c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -330,7 +330,7 @@ struct kiocb {
>  	randomized_struct_fields_start
>  
>  	loff_t			ki_pos;
> -	void (*ki_complete)(struct kiocb *iocb, long ret);
> +	void (*ki_complete)(struct kiocb *iocb, u64 ret);
>  	void			*private;
>  	int			ki_flags;
>  	u16			ki_hint;

