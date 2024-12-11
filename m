Return-Path: <linux-fsdevel+bounces-37002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF439EC096
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 01:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF10F18821DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 00:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BDCEEC8;
	Wed, 11 Dec 2024 00:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="npCggpsG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L1ROLQ95"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56658489
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733876236; cv=none; b=KokYaQk+uGzM13GMxa58p2ylAZ54IUHZVbbBoLvy5JGOZ2uKf6PAzf4N/+qiw/sjAwZ+5pSsm1wRFuncPQegIVoPbOe8/VyRWexb2V+Ij5EIcovHlQ7uLwodtuTveQr8qEeqMATdvgMplzueJkQJm1Adr93wJMrPkXK5W+WogfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733876236; c=relaxed/simple;
	bh=B/fpJrKHE8YMfYMlrdQlILGVY9WZXhvaHuc8A4B2Mk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0ytLvjWQufo9kmhPBvoxvubLwnJn6kmh8avFp1PFl3YfCXuIcVBpKv3O17AWDpsTGLVANIlYr4uaKPtElNLgj74bFtnmrP/f5uaIFtmTpQECGXdVXkIf5eyUGrzsq541ZWZWVGIbuwZct+LhmZ08h8g3eAKzXBD0I3NpCjzo84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=npCggpsG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L1ROLQ95; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5DDDC25400FA;
	Tue, 10 Dec 2024 19:17:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 10 Dec 2024 19:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733876231;
	 x=1733962631; bh=+CrF9CuOf9NuNGWjOcaSFrJ1MvVUwnEHRIdEG8NHR6o=; b=
	npCggpsGhnmYkuTRK1TpP2D/xaGG3L0fv2T4CmqFgwd6B1R1Rxr8lXxN/NBg+CGv
	/JbI1Vf4LS3TPTfGBKWH6JoJiJWJGaRDKUADUIgL4vJl3CbCfWvVhaY1M0LAn878
	ik6DG6+iJwWOYzAc/tgd1jiZxIqbCHBUKRdvpAoRNi4YDXBS+9LGKy7HlXB2BfHM
	obZ2tMkjQdcBjvqlDLO/Pqly+fP6aMpFTNNQ3LTzln1uTIVFCkgqlCUmYq11JSoT
	WWl32TLR0KtE/K+/gS3BMvrTflMHi3WGw+utH4kMGuhWS8WjsYTHIxMu8GXnxISy
	Hwerj7Ku9gm1iFSnOmhTMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733876231; x=
	1733962631; bh=+CrF9CuOf9NuNGWjOcaSFrJ1MvVUwnEHRIdEG8NHR6o=; b=L
	1ROLQ95SUhrIlzpEOCCVuqWHYOZ5aLroFZwPS1J25KMaUm9UDhpzHjtcVd8wxwDN
	W3NmSHjXlLOIKUL4rkkezN+yVn/I7exrlcTlr7slki4Bb4ZoF0xtVOXUD0JZa+D0
	P69AStbsQ55/ilA0z6mLNgngUO+y7Gm0O1dUZQUAKF5MXjMJzcWbnFvRwEmmmkTm
	oXg6qy2q4/DdlDaBC7MS8kT3ghZZDV0QCGhbos5dhfDOlghsCP2NvNl7h67Qp6Kz
	1FDUc9Nvo9d8ovlB5eldTu3oyz+guV6LJdHzPrfKGgMtDEVXQTv53kVPrK12i4t0
	jk17MqFJaXsYEmzvTlndQ==
X-ME-Sender: <xms:BtpYZ7lkoxRTQ9sgD-UNVMBBP0a8ZtMrzKuoqx2RTAX9JB7DU993Qw>
    <xme:BtpYZ-00kiYsCQ62sQ8WfL9EmrTcJ4lfJMSFXyVeNKwfPePdHfTTiDCyW6ay3rOZg
    rOOKAeAv6fU32hu>
X-ME-Received: <xmr:BtpYZxrPqQ-dO-sELVMZW0gVG4YDOgBFpzvN3gj4oelmVRtA2ggWoNAcTNDXLim5-OPVP6BU8c2f5ZuMWoHu_QWuS60h1dgZEewA1Uo2Ftum7vrAbwfY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeelgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuf
    fvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghr
    thcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrf
    grthhtvghrnhepveeljeetvdeugfdujeeijeetvedvlefhkefhvdejfeehkeelffegudeg
    tdetvddunecuffhomhgrihhnpehsphhinhhitghsrdhnvghtnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegvthhmrghrthhinhegfedufeesghhmrghilhdrtghomhdprhgt
    phhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehjohgr
    nhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehjvghffhhlvgiguh
    eslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehjohhsvghfsehtohig
    ihgtphgrnhgurgdrtghomhdprhgtphhtthhopehlrghorghrrdhshhgrohesghhmrghilh
    drtghomhdprhgtphhtthhopegvthhmrghrthhinhestghishgtohdrtghomh
X-ME-Proxy: <xmx:BtpYZzn2OfjaJo4NC1DxyW9sj72wxREj2dExEzDtiMLgAK41ww-1HQ>
    <xmx:BtpYZ53QtGptfwcxC8la0oxtB0Pkx4JRGMUz4_XpC38CqrQlKV8a1A>
    <xmx:BtpYZyt9DNpmrsLjM_LetozBy133oSm3qPWSrGP_OMtFsfz51f_u-w>
    <xmx:BtpYZ9V-BzB8IpA-4vSCpG2Q5VH0LrGieoLb-MjnZ9k8lmf46OEfWw>
    <xmx:B9pYZyKyMh1v1Tl1a5P15fAzYccuMPdVkte7RrRjN71_cDrfV5etfaGb>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 19:17:08 -0500 (EST)
Message-ID: <3b13f18e-db92-4e34-946b-f6fbd1d66665@fastmail.fm>
Date: Wed, 11 Dec 2024 01:17:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Abort connection if FUSE server get stuck
To: etmartin4313@gmail.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, jefflexu@linux.alibaba.com, josef@toxicpanda.com,
 laoar.shao@gmail.com, etmartin@cisco.com
References: <20241210171621.64645-1-etmartin4313@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20241210171621.64645-1-etmartin4313@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/10/24 18:16, etmartin4313@gmail.com wrote:
> From: Etienne Martineau <etmartin4313@gmail.com>
> 
> This patch abort connection if HUNG_TASK_PANIC is set and a FUSE server
> is getting stuck for too long.
> 
> Without this patch, an unresponsive / buggy / malicious FUSE server can
> leave the clients in D state for a long period of time and on system where
> HUNG_TASK_PANIC is set, trigger a catastrophic reload.
> 
> So, if HUNG_TASK_PANIC checking is enabled, we should wake up periodically
> to abort connections that exceed the timeout value which is define to be
> half the HUNG_TASK_TIMEOUT period, which keeps overhead low.
> 
> This patch introduce a list of request waiting for answer that is time
> sorted to minimize the overhead.
> 
> When HUNG_TASK_PANIC is enable there is a timeout check per connection
> that is running at low frequency only if there are active FUSE request
> pending.
> 
> A FUSE client can get into D state as such ( see below Scenario #1 / #2 )
>  1) request_wait_answer() -> wait_event() is UNINTERRUPTIBLE
>     OR
>  2) request_wait_answer() -> wait_event_(interruptible / killable) is head
>     of line blocking for subsequent clients accessing the same file
> 
> 	Scenario #1:
> 	2716 pts/2    D+     0:00 cat
> 	$ cat /proc/2716/stack
> 		[<0>] request_wait_answer+0x22e/0x340
> 		[<0>] __fuse_simple_request+0xd8/0x2c0
> 		[<0>] fuse_perform_write+0x3ec/0x760
> 		[<0>] fuse_file_write_iter+0x3d5/0x3f0
> 		[<0>] vfs_write+0x313/0x430
> 		[<0>] ksys_write+0x6a/0xf0
> 		[<0>] __x64_sys_write+0x19/0x30
> 		[<0>] x64_sys_call+0x18ab/0x26f0
> 		[<0>] do_syscall_64+0x7c/0x170
> 		[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> 	Scenario #2:
> 	2962 pts/2    S+     0:00 cat
> 	2963 pts/3    D+     0:00 cat
> 	$ cat /proc/2962/stack
> 		[<0>] request_wait_answer+0x140/0x340
> 		[<0>] __fuse_simple_request+0xd8/0x2c0
> 		[<0>] fuse_perform_write+0x3ec/0x760
> 		[<0>] fuse_file_write_iter+0x3d5/0x3f0
> 		[<0>] vfs_write+0x313/0x430
> 		[<0>] ksys_write+0x6a/0xf0
> 		[<0>] __x64_sys_write+0x19/0x30
> 		[<0>] x64_sys_call+0x18ab/0x26f0
> 		[<0>] do_syscall_64+0x7c/0x170
> 		[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 	$ cat /proc/2963/stack
> 		[<0>] fuse_file_write_iter+0x252/0x3f0
> 		[<0>] vfs_write+0x313/0x430
> 		[<0>] ksys_write+0x6a/0xf0
> 		[<0>] __x64_sys_write+0x19/0x30
> 		[<0>] x64_sys_call+0x18ab/0x26f0
> 		[<0>] do_syscall_64+0x7c/0x170
> 		[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Please note that this patch doesn't prevent the HUNG_TASK_WARNING.
> 
> Signed-off-by: Etienne Martineau <etmartin4313@gmail.com>
> ---
>  fs/fuse/dev.c                | 56 ++++++++++++++++++++++++++++++++++--
>  fs/fuse/fuse_i.h             | 14 +++++++++
>  fs/fuse/inode.c              |  4 +++
>  include/linux/sched/sysctl.h |  8 ++++--
>  kernel/hung_task.c           |  3 +-
>  5 files changed, 79 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 27ccae63495d..294b6ad8a90f 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -21,6 +21,8 @@
>  #include <linux/swap.h>
>  #include <linux/splice.h>
>  #include <linux/sched.h>
> +#include <linux/completion.h>
> +#include <linux/sched/sysctl.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include "fuse_trace.h"
> @@ -418,18 +420,56 @@ static int queue_interrupt(struct fuse_req *req)
>  	return 0;
>  }
>  
> +/*
> + * Prevent hung task timer from firing at us
> + * Periodically poll the request waiting list on a per-connection basis
> + * and abort if the oldest request exceed the timeout. The oldest request
> + * is the first element on the list by definition
> + */
> +void fuse_wait_answer_timeout(struct work_struct *wk)
> +{
> +	unsigned long hang_check_timer = sysctl_hung_task_timeout_secs * (HZ / 2);
> +	struct fuse_conn *fc = container_of(wk, struct fuse_conn, work.work);
> +	struct fuse_req *req;
> +
> +	spin_lock(&fc->lock);
> +	req = list_first_entry_or_null(&fc->req_waiting, struct fuse_req, timeout_list);
> +	if (req && time_after(jiffies, req->wait_start + hang_check_timer)) {
> +		spin_unlock(&fc->lock);
> +		fuse_abort_conn(fc);
> +		return;
> +	}
> +
> +	/* Keep the ball rolling but don't re-arm when only one req is pending */
> +	if (atomic_read(&fc->num_waiting) != 1)
> +		queue_delayed_work(system_wq, &fc->work, hang_check_timer);
> +	spin_unlock(&fc->lock);
> +}
> +
>  static void request_wait_answer(struct fuse_req *req)
>  {
> +	unsigned long hang_check_timer = sysctl_hung_task_timeout_secs * (HZ / 2);
> +	unsigned int hang_check = sysctl_hung_task_panic;
>  	struct fuse_conn *fc = req->fm->fc;
>  	struct fuse_iqueue *fiq = &fc->iq;
>  	int err;
>  
> +	if (hang_check) {
> +		spin_lock(&fc->lock);
> +		/* Get the ball rolling if we are the first request */
> +		if (atomic_read(&fc->num_waiting) == 1)
> +			queue_delayed_work(system_wq, &fc->work, hang_check_timer);
> +		req->wait_start = jiffies;
> +		list_add_tail(&req->timeout_list, &fc->req_waiting);
> +		spin_unlock(&fc->lock);
> +	}
> +
>  	if (!fc->no_interrupt) {
>  		/* Any signal may interrupt this */
>  		err = wait_event_interruptible(req->waitq,
>  					test_bit(FR_FINISHED, &req->flags));
>  		if (!err)
> -			return;
> +			goto out;
>  
>  		set_bit(FR_INTERRUPTED, &req->flags);
>  		/* matches barrier in fuse_dev_do_read() */
> @@ -443,7 +483,7 @@ static void request_wait_answer(struct fuse_req *req)
>  		err = wait_event_killable(req->waitq,
>  					test_bit(FR_FINISHED, &req->flags));
>  		if (!err)
> -			return;
> +			goto out;
>  
>  		spin_lock(&fiq->lock);
>  		/* Request is not yet in userspace, bail out */
> @@ -452,7 +492,7 @@ static void request_wait_answer(struct fuse_req *req)
>  			spin_unlock(&fiq->lock);
>  			__fuse_put_request(req);
>  			req->out.h.error = -EINTR;
> -			return;
> +			goto out;
>  		}
>  		spin_unlock(&fiq->lock);
>  	}
> @@ -462,6 +502,16 @@ static void request_wait_answer(struct fuse_req *req)
>  	 * Wait it out.
>  	 */
>  	wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
> +
> +out:
> +	if (hang_check) {
> +		spin_lock(&fc->lock);
> +		/* Stop the timeout check if we are the last request */
> +		if (atomic_read(&fc->num_waiting) == 1)
> +			cancel_delayed_work_sync(&fc->work);
> +		list_del(&req->timeout_list);
> +		spin_unlock(&fc->lock);
> +	}
>  }
>  
>  static void __fuse_request_send(struct fuse_req *req)
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 74744c6f2860..7cbfbd8e4e54 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -438,6 +438,12 @@ struct fuse_req {
>  
>  	/** fuse_mount this request belongs to */
>  	struct fuse_mount *fm;
> +
> +	/** Entry on req_waiting list */
> +	struct list_head timeout_list;
> +
> +	/** Wait start time in jiffies */
> +	unsigned long wait_start;
>  };
>  
>  struct fuse_iqueue;
> @@ -923,6 +929,12 @@ struct fuse_conn {
>  	/** IDR for backing files ids */
>  	struct idr backing_files_map;
>  #endif
> +
> +	/** Request wait timeout */
> +	struct delayed_work work;
> +
> +	/** List of request waiting for answer */
> +	struct list_head req_waiting;
>  };
>  
>  /*
> @@ -1190,6 +1202,8 @@ void fuse_request_end(struct fuse_req *req);
>  /* Abort all requests */
>  void fuse_abort_conn(struct fuse_conn *fc);
>  void fuse_wait_aborted(struct fuse_conn *fc);
> +/* Connection timeout */
> +void fuse_wait_answer_timeout(struct work_struct *wk);
>  
>  /**
>   * Invalidate inode attributes
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 3ce4f4e81d09..ce78c2b5ad8c 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -23,6 +23,7 @@
>  #include <linux/exportfs.h>
>  #include <linux/posix_acl.h>
>  #include <linux/pid_namespace.h>
> +#include <linux/completion.h>
>  #include <uapi/linux/magic.h>
>  
>  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> @@ -964,6 +965,8 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
>  	INIT_LIST_HEAD(&fc->entry);
>  	INIT_LIST_HEAD(&fc->devices);
>  	atomic_set(&fc->num_waiting, 0);
> +	INIT_DELAYED_WORK(&fc->work, fuse_wait_answer_timeout);
> +	INIT_LIST_HEAD(&fc->req_waiting);


https://www.spinics.net/lists//linux-fsdevel/msg283639.html


Thanks,
Bernd


PS: In my fuse-io-uring series global lists are eliminated.

