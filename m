Return-Path: <linux-fsdevel+bounces-10692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCB184D726
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 01:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63599282A5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 00:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B521E49D;
	Thu,  8 Feb 2024 00:26:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38CA1E484
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351977; cv=none; b=KeVm5ayURkilNae6xtXEBXRE3U3y4VxMNg0TZd6tC/N2/utVyrev9kkQUk3L+V2G0hL5s53Fv0DtMHe3YUHuSmr0hAPnIAyEZaIRCq9RIK9VLmaCbqdTDuP+HKABEk57ZTSmtIBzywgi4QJpHkjOhXmc0gLGL772crCM5SqCBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351977; c=relaxed/simple;
	bh=Fn0oRCVUcPrgq8PU/Guv9EfAVCY8G2QGajXe7Papbt4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ijkPT1gUMzIpiQNEEcxPCmOPjmM1nnU1XckRLl6JGiyjOVzmIdOoJaNNdE+/zvRYkiwR6LaPZsWh25gtgmPgqIwUY7xg5Nz5scL5P2Y53h6/+sikyzPtXsi4qfKHwkAyEcrncdHOtoTHwUcfmRzjhauHpJQq9PFdIIFho19IJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ddf26eba3cso847840a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 16:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707351975; x=1707956775;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxKRVRKtdbRLHGC+8dbv92WPtUUitdnjnGXz/evFIWI=;
        b=JKZdxv8T6AIH4lDqIErj2vmHjC6f4RdQQ7BycPUZoU1aqIyP0vSyszPaNtOqYxJJOI
         FL4PlcKNqPCXL1a7ig1SkCDgG4J36RIbP4WK0hvemAnbZVLQIyfGwwUJ7DCmKFz65g0Y
         rJMAXDxzZ5IAqRlgG2aM/GIcLb3N2687dMXr/t1X7EXcGRMtZmqJoNIxPvBdV7CwHm51
         Oi2l2gvY3u/3nyA34M84y5Zi1xU6VYkci0a9hWTzYuFT/VMpQUMB/DIjZR1kNxuKHCNY
         mtk0lHpGvHeIX8HV19CFtJesix4DWEvdDxDpvJfGkXMtgBiSZc07Lktq8p9biuIpZ4Zq
         PpLw==
X-Forwarded-Encrypted: i=1; AJvYcCWkJXqsCOO158pXa4yqoQTbYp5aBqtSEMhYK2C6576Ne3moKxYJxDN/IBIKu3CElI8gHOlXOZTo+ROLl6GJdBgNFfRK47kSEeBg0mu0Qw==
X-Gm-Message-State: AOJu0Yx+GXAXJt2ostHKIzG8Y1SbW9AtNFFLqBJnoSHB3k7yD9TwvVKW
	gc8/jafVi1f5wRFEvf0nk/Jp64ZMFcrpLCXVz4DbC42YAAoRgorN
X-Google-Smtp-Source: AGHT+IFVlSfL/hP8QJVd0j0oqfnOZfYeaiXnl7TX1nMk5RsKHy+08DFiNFDXRoXG6ORivmHxn46kjQ==
X-Received: by 2002:a05:6830:1e91:b0:6e2:b1c2:4692 with SMTP id n17-20020a0568301e9100b006e2b1c24692mr6646551otr.36.1707351974806;
        Wed, 07 Feb 2024 16:26:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKsjO6L6nHI4doL2XZORuA8esEWaX0bviGb8joJhw4tLFTfoAEAypB5b3VEw5SAlB+D0JvixUFOpkqBjNysBTiko5EHsNtMK5p6O/e9XtsBNPQsKdz7pX1b6LqcOqlEGm0q9zMexJ7X8agHDHHFbbwEJ4G9FN4PtkLHfp0zXEizK7gFKmG00MIHJ0y4vaAL/e7qrpDofoEamjHAjcTPI18RFki8MGXeLRVzZna
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id l136-20020a633e8e000000b005dc191a1599sm2268196pga.1.2024.02.07.16.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 16:26:14 -0800 (PST)
Message-ID: <51a5017a-e37c-4b6e-8e68-4bf91ae383bc@acm.org>
Date: Wed, 7 Feb 2024 16:26:12 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] fs, USB gadget: Rework kiocb cancellation
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
 Sandeep Dhavale <dhavale@google.com>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240206234718.1437772-1-bvanassche@acm.org>
 <20240207-geliebt-badeort-a81cde648cfc@brauner>
Content-Language: en-US
In-Reply-To: <20240207-geliebt-badeort-a81cde648cfc@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/24 00:56, Christian Brauner wrote:
> On Tue, Feb 06, 2024 at 03:47:18PM -0800, Bart Van Assche wrote:
>> Calling kiocb_set_cancel_fn() without knowing whether the caller
>> submitted a struct kiocb or a struct aio_kiocb is unsafe. Fix this by
>> introducing the cancel_kiocb() method in struct file_operations. The
>> following call trace illustrates that without this patch an
>> out-of-bounds write happens if I/O is submitted by io_uring (from a
>> phone with an ARM CPU and kernel 6.1):
>>
>> WARNING: CPU: 3 PID: 368 at fs/aio.c:598 kiocb_set_cancel_fn+0x9c/0xa8
>> Call trace:
>>   kiocb_set_cancel_fn+0x9c/0xa8
>>   ffs_epfile_read_iter+0x144/0x1d0
>>   io_read+0x19c/0x498
>>   io_issue_sqe+0x118/0x27c
>>   io_submit_sqes+0x25c/0x5fc
>>   __arm64_sys_io_uring_enter+0x104/0xab0
>>   invoke_syscall+0x58/0x11c
>>   el0_svc_common+0xb4/0xf4
>>   do_el0_svc+0x2c/0xb0
>>   el0_svc+0x2c/0xa4
>>   el0t_64_sync_handler+0x68/0xb4
>>   el0t_64_sync+0x1a4/0x1a8
>>
>> The following patch has been used as the basis of this patch: Christoph
>> Hellwig, "[PATCH 08/32] aio: replace kiocb_set_cancel_fn with a
>> cancel_kiocb file operation", May 2018
>> (https://lore.kernel.org/all/20180515194833.6906-9-hch@lst.de/).
> 
> What's changed that voids Al's objections on that patch from 2018?
> Specifically
> https://lore.kernel.org/all/20180406021553.GS30522@ZenIV.linux.org.uk
> https://lore.kernel.org/all/20180520052720.GY30522@ZenIV.linux.org.uk

How about adding requests to the pending request list before calling
call_*_iter() instead of after call_*_iter() has returned?

Thanks,

Bart.

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 6bff6cb93789..4837e3071263 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -31,7 +31,6 @@
  #include <linux/usb/composite.h>
  #include <linux/usb/functionfs.h>

-#include <linux/aio.h>
  #include <linux/kthread.h>
  #include <linux/poll.h>
  #include <linux/eventfd.h>
@@ -1157,23 +1156,16 @@ ffs_epfile_open(struct inode *inode, struct file *file)
  	return stream_open(inode, file);
  }

-static int ffs_aio_cancel(struct kiocb *kiocb)
+static void ffs_epfile_cancel_kiocb(struct kiocb *kiocb)
  {
  	struct ffs_io_data *io_data = kiocb->private;
  	struct ffs_epfile *epfile = kiocb->ki_filp->private_data;
  	unsigned long flags;
-	int value;

  	spin_lock_irqsave(&epfile->ffs->eps_lock, flags);
-
  	if (io_data && io_data->ep && io_data->req)
-		value = usb_ep_dequeue(io_data->ep, io_data->req);
-	else
-		value = -EINVAL;
-
+		usb_ep_dequeue(io_data->ep, io_data->req);
  	spin_unlock_irqrestore(&epfile->ffs->eps_lock, flags);
-
-	return value;
  }

  static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
@@ -1198,9 +1190,6 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)

  	kiocb->private = p;

-	if (p->aio)
-		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
-
  	res = ffs_epfile_io(kiocb->ki_filp, p);
  	if (res == -EIOCBQUEUED)
  		return res;
@@ -1242,9 +1231,6 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)

  	kiocb->private = p;

-	if (p->aio)
-		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
-
  	res = ffs_epfile_io(kiocb->ki_filp, p);
  	if (res == -EIOCBQUEUED)
  		return res;
@@ -1356,6 +1342,7 @@ static const struct file_operations ffs_epfile_operations = {
  	.release =	ffs_epfile_release,
  	.unlocked_ioctl =	ffs_epfile_ioctl,
  	.compat_ioctl = compat_ptr_ioctl,
+	.cancel_kiocb = ffs_epfile_cancel_kiocb,
  };


diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 03179b1880fd..b79cf0db8243 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -22,7 +22,6 @@
  #include <linux/slab.h>
  #include <linux/poll.h>
  #include <linux/kthread.h>
-#include <linux/aio.h>
  #include <linux/uio.h>
  #include <linux/refcount.h>
  #include <linux/delay.h>
@@ -446,23 +445,18 @@ struct kiocb_priv {
  	unsigned		actual;
  };

-static int ep_aio_cancel(struct kiocb *iocb)
+static void ep_cancel_kiocb(struct kiocb *iocb)
  {
  	struct kiocb_priv	*priv = iocb->private;
  	struct ep_data		*epdata;
-	int			value;

  	local_irq_disable();
  	epdata = priv->epdata;
  	// spin_lock(&epdata->dev->lock);
  	if (likely(epdata && epdata->ep && priv->req))
-		value = usb_ep_dequeue (epdata->ep, priv->req);
-	else
-		value = -EINVAL;
+		usb_ep_dequeue (epdata->ep, priv->req);
  	// spin_unlock(&epdata->dev->lock);
  	local_irq_enable();
-
-	return value;
  }

  static void ep_user_copy_worker(struct work_struct *work)
@@ -537,7 +531,6 @@ static ssize_t ep_aio(struct kiocb *iocb,
  	iocb->private = priv;
  	priv->iocb = iocb;

-	kiocb_set_cancel_fn(iocb, ep_aio_cancel);
  	get_ep(epdata);
  	priv->epdata = epdata;
  	priv->actual = 0;
@@ -709,6 +702,7 @@ static const struct file_operations ep_io_operations = {
  	.unlocked_ioctl = ep_ioctl,
  	.read_iter =	ep_read_iter,
  	.write_iter =	ep_write_iter,
+	.cancel_kiocb = ep_cancel_kiocb,
  };

  /* ENDPOINT INITIALIZATION
diff --git a/fs/aio.c b/fs/aio.c
index bb2ff48991f3..c10c2cfc979e 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -203,7 +203,6 @@ struct aio_kiocb {
  	};

  	struct kioctx		*ki_ctx;
-	kiocb_cancel_fn		*ki_cancel;

  	struct io_event		ki_res;

@@ -587,22 +586,6 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
  #define AIO_EVENTS_FIRST_PAGE	((PAGE_SIZE - sizeof(struct aio_ring)) / sizeof(struct io_event))
  #define AIO_EVENTS_OFFSET	(AIO_EVENTS_PER_PAGE - AIO_EVENTS_FIRST_PAGE)

-void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
-{
-	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
-	struct kioctx *ctx = req->ki_ctx;
-	unsigned long flags;
-
-	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
-		return;
-
-	spin_lock_irqsave(&ctx->ctx_lock, flags);
-	list_add_tail(&req->ki_list, &ctx->active_reqs);
-	req->ki_cancel = cancel;
-	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-}
-EXPORT_SYMBOL(kiocb_set_cancel_fn);
-
  /*
   * free_ioctx() should be RCU delayed to synchronize against the RCU
   * protected lookup_ioctx() and also needs process context to call
@@ -634,6 +617,8 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
  	queue_rcu_work(system_wq, &ctx->free_rwork);
  }

+static void aio_cancel_and_del(struct aio_kiocb *req);
+
  /*
   * When this function runs, the kioctx has been removed from the "hash table"
   * and ctx->users has dropped to 0, so we know no more kiocbs can be submitted -
@@ -649,8 +634,7 @@ static void free_ioctx_users(struct percpu_ref *ref)
  	while (!list_empty(&ctx->active_reqs)) {
  		req = list_first_entry(&ctx->active_reqs,
  				       struct aio_kiocb, ki_list);
-		req->ki_cancel(&req->rw);
-		list_del_init(&req->ki_list);
+		aio_cancel_and_del(req);
  	}

  	spin_unlock_irq(&ctx->ctx_lock);
@@ -1593,8 +1577,26 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
  	if (ret < 0)
  		return ret;
  	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
-	if (!ret)
-		aio_rw_done(req, call_read_iter(file, req, &iter));
+	if (ret)
+		goto free_iovec;
+
+	/*
+	 * If the .cancel_kiocb() callback has been set, add the request
+	 * to the list of active requests.
+	 */
+	if (req->ki_filp->f_op->cancel_kiocb) {
+		struct aio_kiocb *aio = container_of(req, struct aio_kiocb, rw);
+		struct kioctx *ctx = aio->ki_ctx;
+		unsigned long flags;
+
+		spin_lock_irqsave(&ctx->ctx_lock, flags);
+		list_add_tail(&aio->ki_list, &ctx->active_reqs);
+		spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+	}
+
+	aio_rw_done(req, call_read_iter(file, req, &iter));
+
+free_iovec:
  	kfree(iovec);
  	return ret;
  }
@@ -1715,6 +1717,47 @@ static void poll_iocb_unlock_wq(struct poll_iocb *req)
  	rcu_read_unlock();
  }

+static bool aio_poll_cancel(struct aio_kiocb *aiocb)
+{
+	struct poll_iocb *req = &aiocb->poll;
+	struct kioctx *ctx = aiocb->ki_ctx;
+
+	lockdep_assert_held(&ctx->ctx_lock);
+
+	if (!poll_iocb_lock_wq(req)) {
+		/*
+		 * Not a polled request or polling has already been cancelled.
+		 */
+		return false;
+	}
+
+	WRITE_ONCE(req->cancelled, true);
+	if (!req->work_scheduled) {
+		schedule_work(&aiocb->poll.work);
+		req->work_scheduled = true;
+	}
+	poll_iocb_unlock_wq(req);
+
+	return true;
+}
+
+static void aio_cancel_and_del(struct aio_kiocb *req)
+{
+	struct kioctx *ctx = req->ki_ctx;
+
+	lockdep_assert_held(&ctx->ctx_lock);
+
+	if (!aio_poll_cancel(req)) {
+		void (*cancel_kiocb)(struct kiocb *) =
+			req->rw.ki_filp->f_op->cancel_kiocb;
+
+		WARN_ON_ONCE(!cancel_kiocb);
+		if (cancel_kiocb)
+			cancel_kiocb(&req->rw);
+	}
+	list_del_init(&req->ki_list);
+}
+
  static void aio_poll_complete_work(struct work_struct *work)
  {
  	struct poll_iocb *req = container_of(work, struct poll_iocb, work);
@@ -1760,24 +1803,6 @@ static void aio_poll_complete_work(struct work_struct *work)
  	iocb_put(iocb);
  }

-/* assumes we are called with irqs disabled */
-static int aio_poll_cancel(struct kiocb *iocb)
-{
-	struct aio_kiocb *aiocb = container_of(iocb, struct aio_kiocb, rw);
-	struct poll_iocb *req = &aiocb->poll;
-
-	if (poll_iocb_lock_wq(req)) {
-		WRITE_ONCE(req->cancelled, true);
-		if (!req->work_scheduled) {
-			schedule_work(&aiocb->poll.work);
-			req->work_scheduled = true;
-		}
-		poll_iocb_unlock_wq(req);
-	} /* else, the request was force-cancelled by POLLFREE already */
-
-	return 0;
-}
-
  static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
  		void *key)
  {
@@ -1945,7 +1970,6 @@ static int aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
  			 * active_reqs so that it can be cancelled if needed.
  			 */
  			list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
-			aiocb->ki_cancel = aio_poll_cancel;
  		}
  		if (on_queue)
  			poll_iocb_unlock_wq(req);
@@ -2189,8 +2213,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
  	/* TODO: use a hash or array, this sucks. */
  	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
  		if (kiocb->ki_res.obj == obj) {
-			ret = kiocb->ki_cancel(&kiocb->rw);
-			list_del_init(&kiocb->ki_list);
+			aio_cancel_and_del(kiocb);
  			break;
  		}
  	}
diff --git a/include/linux/aio.h b/include/linux/aio.h
index 86892a4fe7c8..2aa6d0be3171 100644
--- a/include/linux/aio.h
+++ b/include/linux/aio.h
@@ -4,20 +4,13 @@

  #include <linux/aio_abi.h>

-struct kioctx;
-struct kiocb;
  struct mm_struct;

-typedef int (kiocb_cancel_fn)(struct kiocb *);
-
  /* prototypes */
  #ifdef CONFIG_AIO
  extern void exit_aio(struct mm_struct *mm);
-void kiocb_set_cancel_fn(struct kiocb *req, kiocb_cancel_fn *cancel);
  #else
  static inline void exit_aio(struct mm_struct *mm) { }
-static inline void kiocb_set_cancel_fn(struct kiocb *req,
-				       kiocb_cancel_fn *cancel) { }
  #endif /* CONFIG_AIO */

  #endif /* __LINUX__AIO_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..7ec714878637 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2021,6 +2021,7 @@ struct file_operations {
  	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
  	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
  				unsigned int poll_flags);
+	void (*cancel_kiocb)(struct kiocb *);
  } __randomize_layout;

  /* Wrap a directory iterator that needs exclusive inode access */

