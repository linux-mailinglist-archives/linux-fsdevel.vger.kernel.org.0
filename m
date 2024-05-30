Return-Path: <linux-fsdevel+bounces-20520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CC18D4C0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 14:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D527B246CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F3E183979;
	Thu, 30 May 2024 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="SFyZEd3j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YuyLvbnZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500D3DAC00
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073503; cv=none; b=cpG8nrGcoqeQ050kw9I6kV9kVQPeoDlqjCLxDvnwSTTb9awS1s4CAfwpzKr1eM6d52EFhilLVAJ+500dGAGHFBMLRBZzaCuRLMcmzGa3HIfQyVpAKwk2xFLgb1RZowlD4OpqmoVQp/AHORIfqcfL/sNu3tmZTZEX6nvuPQxkft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073503; c=relaxed/simple;
	bh=vw3dVHxmjamX9NEf/yj67Jp0tFx3tgzNoetr/OTckFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGLXCY3r6U1P2Mj7vjyGsYeV/o4sq7tpeWNpLwgH2YnrSnGrE/xFhf1Af9cS2GXaFCPNzZ8/6QKnEoT12BpohXU+YP1pE6cWp0kEfeMXQbu2DzvavKI/Mr5m3+SK597Rc3u9dwkultgJ4i+ktR0QkcY1Mg5BytvQ4mUodjLpqmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=SFyZEd3j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YuyLvbnZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BF4BE114014A;
	Thu, 30 May 2024 08:51:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 30 May 2024 08:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717073500;
	 x=1717159900; bh=Gdlp9J6gp4GbuOSX44soEBa+M8AblzmVQbSaibx1PX8=; b=
	SFyZEd3jTvQYU5fAn/QVa5h7f/UggituAdMJw428loCWBk6CUPrn/j02YPRLC8U9
	NxmotY2cu+RPL+/D0BYkN85qBkXKM0vfzYm/0b4axLAlGFioEBt2uw2FudcHVMVn
	guqNm4MMfN66S1urEuze5ZgH827baNDveG/0wLklWm5WYUaFF3KQZ3kws6IS43nd
	cHyDAScjKDCnVdSJsgx4GgW4mz/t+zYytiwDIQcXYTjDZk2O41wCzkaYKUiHfD9I
	1xn7otR+ikv8g/M+9fSD2TWZC0Ap3TvVC+0bPRp3mwnhroki+wzKiJ90DwqzVxbr
	prbNkJSKBzK+qu8Td2NVJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717073500; x=
	1717159900; bh=Gdlp9J6gp4GbuOSX44soEBa+M8AblzmVQbSaibx1PX8=; b=Y
	uyLvbnZ9pWm6P6P68QjnudjWKMo7f9U8gM08shIEId4rUmNqS06zl4eRoePAXNdG
	jzRsGOMRDWuhTr+Xi+ki9nnDyoNAycNXha7PbVzQyYKsSCnQky6p2dChvdQP6aCc
	68myPVEzD9P77KTPLkhMXzH5h3UNJ92Jdn5lqi8fzJjkr0rjh06wgu90E5z5ifI2
	DOfDld3bJWdncE4qHfmITfWX2U36CgSirfkG8TOcQnwrvI/XoXklfrQTOBQi6oqF
	NysYYN43zEHssRfEilKqfL8oOap+c8IfDuyf/nYoj9y8TLsHlE6j2eQgexw3i0r7
	2d2GWcZNaBijuvMaVIBRA==
X-ME-Sender: <xms:XHZYZlMAAFcN9cTIijSnLNUf3IktNoJP12lkNBZ_LoEJMED127LtdQ>
    <xme:XHZYZn_RxJlr07KgXf911HCho74s4cjUnGRkhWeFcJ9VH-ZxyXp9C5x_SmlfnmA4J
    LOZlRRuJXfQXEkR>
X-ME-Received: <xmr:XHZYZkSleYeIx_F_zQh8o6btcbIPOti6zDKqWfK9nXjlT-4pVXi-6I_3A7nYPCnyUTS30Y58xoThzAbd72O4wsk2Rwfa-0PuLr1xFlIPiz5n_jfTJr7O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:XHZYZhvi2ZD2UpWQqpxjgoTvshBrWxAHhqnzAkiUMGT0emLXgORIaA>
    <xmx:XHZYZtdLEYUGWTno9ocs10zWrlz7ilVHEpscOUhOx80mCBWCTzfdmQ>
    <xmx:XHZYZt0Qmw8GNWvSeA8HeLYEyw5WNp7Xwgw7Aas08kArRwKkllCONw>
    <xmx:XHZYZp9NhpqCJJqCIAYcFTNkI-YZOvsNjI0uk4gkodIjCf0oMUBPPw>
    <xmx:XHZYZmGo6RgRw6t5nHIADxY08dEgKZ3VLscn2q-SZLxfuibEeBTJHdk0>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:51:39 -0400 (EDT)
Message-ID: <996a49b0-5230-4106-900e-7b5ff3e151cf@fastmail.fm>
Date: Thu, 30 May 2024 14:51:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 05/19] fuse: Add a uring config ioctl
To: Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 linux-fsdevel@vger.kernel.org
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-5-d149476b1d65@ddn.com>
 <20240529212450.GE2182086@perftesting>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20240529212450.GE2182086@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/29/24 23:24, Josef Bacik wrote:
> On Wed, May 29, 2024 at 08:00:40PM +0200, Bernd Schubert wrote:
>> This only adds the initial ioctl for basic fuse-uring initialization.
>> More ioctl types will be added later to initialize queues.
>>
>> This also adds data structures needed or initialized by the ioctl
>> command and that will be used later.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  fs/fuse/Kconfig           |  12 +++
>>  fs/fuse/Makefile          |   1 +
>>  fs/fuse/dev.c             |  91 ++++++++++++++++--
>>  fs/fuse/dev_uring.c       | 122 +++++++++++++++++++++++
>>  fs/fuse/dev_uring_i.h     | 239 ++++++++++++++++++++++++++++++++++++++++++++++
>>  fs/fuse/fuse_dev_i.h      |   1 +
>>  fs/fuse/fuse_i.h          |   5 +
>>  fs/fuse/inode.c           |   3 +
>>  include/uapi/linux/fuse.h |  73 ++++++++++++++
>>  9 files changed, 538 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
>> index 8674dbfbe59d..11f37cefc94b 100644
>> --- a/fs/fuse/Kconfig
>> +++ b/fs/fuse/Kconfig
>> @@ -63,3 +63,15 @@ config FUSE_PASSTHROUGH
>>  	  to be performed directly on a backing file.
>>  
>>  	  If you want to allow passthrough operations, answer Y.
>> +
>> +config FUSE_IO_URING
>> +	bool "FUSE communication over io-uring"
>> +	default y
>> +	depends on FUSE_FS
>> +	depends on IO_URING
>> +	help
>> +	  This allows sending FUSE requests over the IO uring interface and
>> +          also adds request core affinity.
>> +
>> +	  If you want to allow fuse server/client communication through io-uring,
>> +	  answer Y
>> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
>> index 6e0228c6d0cb..7193a14374fd 100644
>> --- a/fs/fuse/Makefile
>> +++ b/fs/fuse/Makefile
>> @@ -11,5 +11,6 @@ fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
>>  fuse-y += iomode.o
>>  fuse-$(CONFIG_FUSE_DAX) += dax.o
>>  fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
>> +fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
>>  
>>  virtiofs-y := virtio_fs.o
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index b98ecb197a28..bc77413932cf 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -8,6 +8,7 @@
>>  
>>  #include "fuse_i.h"
>>  #include "fuse_dev_i.h"
>> +#include "dev_uring_i.h"
>>  
>>  #include <linux/init.h>
>>  #include <linux/module.h>
>> @@ -26,6 +27,13 @@
>>  MODULE_ALIAS_MISCDEV(FUSE_MINOR);
>>  MODULE_ALIAS("devname:fuse");
>>  
>> +#if IS_ENABLED(CONFIG_FUSE_IO_URING)
>> +static bool __read_mostly enable_uring;
>> +module_param(enable_uring, bool, 0644);
>> +MODULE_PARM_DESC(enable_uring,
>> +		 "Enable uring userspace communication through uring.");
>> +#endif
>> +
>>  static struct kmem_cache *fuse_req_cachep;
>>  
>>  static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
>> @@ -2297,16 +2305,12 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
>>  	return 0;
>>  }
>>  
>> -static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
>> +static long _fuse_dev_ioctl_clone(struct file *file, int oldfd)
>>  {
>>  	int res;
>> -	int oldfd;
>>  	struct fuse_dev *fud = NULL;
>>  	struct fd f;
>>  
>> -	if (get_user(oldfd, argp))
>> -		return -EFAULT;
>> -
>>  	f = fdget(oldfd);
>>  	if (!f.file)
>>  		return -EINVAL;
>> @@ -2329,6 +2333,16 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
>>  	return res;
>>  }
>>  
>> +static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
>> +{
>> +	int oldfd;
>> +
>> +	if (get_user(oldfd, argp))
>> +		return -EFAULT;
>> +
>> +	return _fuse_dev_ioctl_clone(file, oldfd);
>> +}
>> +
>>  static long fuse_dev_ioctl_backing_open(struct file *file,
>>  					struct fuse_backing_map __user *argp)
>>  {
>> @@ -2364,8 +2378,65 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
>>  	return fuse_backing_close(fud->fc, backing_id);
>>  }
>>  
>> -static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
>> -			   unsigned long arg)
>> +/**
>> + * Configure the queue for the given qid. First call will also initialize
>> + * the ring for this connection.
>> + */
>> +static long fuse_uring_ioctl(struct file *file, __u32 __user *argp)
>> +{
>> +#if IS_ENABLED(CONFIG_FUSE_IO_URING)
>> +	int res;
>> +	struct fuse_uring_cfg cfg;
>> +	struct fuse_dev *fud;
>> +	struct fuse_conn *fc;
>> +	struct fuse_ring *ring;
>> +
>> +	res = copy_from_user(&cfg, (void *)argp, sizeof(cfg));
>> +	if (res != 0)
>> +		return -EFAULT;
>> +
>> +	fud = fuse_get_dev(file);
>> +	if (fud == NULL)
>> +		return -ENODEV;
>> +	fc = fud->fc;
>> +
>> +	switch (cfg.cmd) {
>> +	case FUSE_URING_IOCTL_CMD_RING_CFG:
>> +		if (READ_ONCE(fc->ring) == NULL)
>> +			ring = kzalloc(sizeof(*fc->ring), GFP_KERNEL);
>> +
>> +		spin_lock(&fc->lock);
>> +		if (fc->ring == NULL) {
>> +			fc->ring = ring;
> 
> Need to have error handling here in case the kzalloc failed.
> 
>> +			fuse_uring_conn_init(fc->ring, fc);
>> +		} else {
>> +			kfree(ring);
>> +		}
>> +
>> +		spin_unlock(&fc->lock);
>> +		if (fc->ring == NULL)
>> +			return -ENOMEM;
>> +
>> +		mutex_lock(&fc->ring->start_stop_lock);
>> +		res = fuse_uring_conn_cfg(fc->ring, &cfg.rconf);
>> +		mutex_unlock(&fc->ring->start_stop_lock);
>> +
>> +		if (res != 0)
>> +			return res;
>> +		break;
>> +	default:
>> +		res = -EINVAL;
>> +	}
>> +
>> +		return res;
>> +#else
>> +	return -ENOTTY;
>> +#endif
>> +}
>> +
>> +static long
>> +fuse_dev_ioctl(struct file *file, unsigned int cmd,
>> +	       unsigned long arg)
>>  {
>>  	void __user *argp = (void __user *)arg;
>>  
>> @@ -2379,8 +2450,10 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
>>  	case FUSE_DEV_IOC_BACKING_CLOSE:
>>  		return fuse_dev_ioctl_backing_close(file, argp);
>>  
>> -	default:
>> -		return -ENOTTY;
>> +	case FUSE_DEV_IOC_URING:
>> +		return fuse_uring_ioctl(file, argp);
>> +
> 
> Instead just wrap the above in 
> 
> #ifdef CONFIG_FUSE_IO_URING
> 	case FUSE_DEV_IOC_URING:
> 		return fuse_uring_ioctl(file, argp);
> #endif
> 
> instead of wrapping the entire function above in the check.
> 	
>> +	default: return -ENOTTY;
>>  	}
>>  }
>>  
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> new file mode 100644
>> index 000000000000..702a994cf192
>> --- /dev/null
>> +++ b/fs/fuse/dev_uring.c
>> @@ -0,0 +1,122 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * FUSE: Filesystem in Userspace
>> + * Copyright (c) 2023-2024 DataDirect Networks.
>> + */
>> +
>> +#include "fuse_i.h"
>> +#include "fuse_dev_i.h"
>> +#include "dev_uring_i.h"
>> +
>> +#include "linux/compiler_types.h"
>> +#include "linux/spinlock.h"
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/poll.h>
>> +#include <linux/sched/signal.h>
>> +#include <linux/uio.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/pagemap.h>
>> +#include <linux/file.h>
>> +#include <linux/slab.h>
>> +#include <linux/pipe_fs_i.h>
>> +#include <linux/swap.h>
>> +#include <linux/splice.h>
>> +#include <linux/sched.h>
>> +#include <linux/io_uring.h>
>> +#include <linux/mm.h>
>> +#include <linux/io.h>
>> +#include <linux/io_uring.h>
>> +#include <linux/io_uring/cmd.h>
>> +#include <linux/topology.h>
>> +#include <linux/io_uring/cmd.h>
>> +
>> +/*
>> + * Basic ring setup for this connection based on the provided configuration
>> + */
>> +int fuse_uring_conn_cfg(struct fuse_ring *ring, struct fuse_ring_config *rcfg)
>> +{
>> +	size_t queue_sz;
>> +
>> +	if (ring->configured) {
>> +		pr_info("The ring is already configured.\n");
>> +		return -EALREADY;
>> +	}
>> +
>> +	if (rcfg->nr_queues == 0) {
>> +		pr_info("zero number of queues is invalid.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (rcfg->nr_queues > 1 && rcfg->nr_queues != num_present_cpus()) {
>> +		pr_info("nr-queues (%d) does not match nr-cores (%d).\n",
>> +			rcfg->nr_queues, num_present_cpus());
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (rcfg->req_arg_len < FUSE_RING_MIN_IN_OUT_ARG_SIZE) {
>> +		pr_info("Per req buffer size too small (%d), min: %d\n",
>> +			rcfg->req_arg_len, FUSE_RING_MIN_IN_OUT_ARG_SIZE);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (WARN_ON(ring->queues))
>> +		return -EINVAL;
>> +
>> +	ring->numa_aware = rcfg->numa_aware;
>> +	ring->nr_queues = rcfg->nr_queues;
>> +	ring->per_core_queue = rcfg->nr_queues > 1;
>> +
>> +	ring->max_nr_sync = rcfg->sync_queue_depth;
>> +	ring->max_nr_async = rcfg->async_queue_depth;
>> +	ring->queue_depth = ring->max_nr_sync + ring->max_nr_async;
>> +
>> +	ring->req_arg_len = rcfg->req_arg_len;
>> +	ring->req_buf_sz = rcfg->user_req_buf_sz;
>> +
>> +	ring->queue_buf_size = ring->req_buf_sz * ring->queue_depth;
>> +
>> +	queue_sz = sizeof(*ring->queues) +
>> +		   ring->queue_depth * sizeof(struct fuse_ring_ent);
>> +	ring->queues = kcalloc(rcfg->nr_queues, queue_sz, GFP_KERNEL);
>> +	if (!ring->queues)
>> +		return -ENOMEM;
>> +	ring->queue_size = queue_sz;
>> +	ring->configured = 1;
>> +
>> +	atomic_set(&ring->queue_refs, 0);
>> +
>> +	return 0;
>> +}
>> +
>> +void fuse_uring_ring_destruct(struct fuse_ring *ring)
>> +{
>> +	unsigned int qid;
>> +	struct rb_node *rbn;
>> +
>> +	for (qid = 0; qid < ring->nr_queues; qid++) {
>> +		struct fuse_ring_queue *queue = fuse_uring_get_queue(ring, qid);
>> +
>> +		vfree(queue->queue_req_buf);
>> +	}
>> +
>> +	kfree(ring->queues);
>> +	ring->queues = NULL;
>> +	ring->nr_queues_ioctl_init = 0;
>> +	ring->queue_depth = 0;
>> +	ring->nr_queues = 0;
>> +
>> +	rbn = rb_first(&ring->mem_buf_map);
>> +	while (rbn) {
>> +		struct rb_node *next = rb_next(rbn);
>> +		struct fuse_uring_mbuf *entry =
>> +			rb_entry(rbn, struct fuse_uring_mbuf, rb_node);
>> +
>> +		rb_erase(rbn, &ring->mem_buf_map);
>> +		kfree(entry);
>> +
>> +		rbn = next;
>> +	}
>> +
>> +	mutex_destroy(&ring->start_stop_lock);
>> +}
>> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
>> new file mode 100644
>> index 000000000000..58ab4671deff
>> --- /dev/null
>> +++ b/fs/fuse/dev_uring_i.h
>> @@ -0,0 +1,239 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + *
>> + * FUSE: Filesystem in Userspace
>> + * Copyright (c) 2023-2024 DataDirect Networks.
>> + */
>> +
>> +#ifndef _FS_FUSE_DEV_URING_I_H
>> +#define _FS_FUSE_DEV_URING_I_H
>> +
>> +#include "fuse_i.h"
>> +#include "linux/compiler_types.h"
>> +#include "linux/rbtree_types.h"
>> +
>> +#if IS_ENABLED(CONFIG_FUSE_IO_URING)
>> +
>> +/* IORING_MAX_ENTRIES */
>> +#define FUSE_URING_MAX_QUEUE_DEPTH 32768
>> +
>> +struct fuse_uring_mbuf {
>> +	struct rb_node rb_node;
>> +	void *kbuf; /* kernel allocated ring request buffer */
>> +	void *ubuf; /* mmaped address */
>> +};
>> +
>> +/** A fuse ring entry, part of the ring queue */
>> +struct fuse_ring_ent {
>> +	/*
>> +	 * pointer to kernel request buffer, userspace side has direct access
>> +	 * to it through the mmaped buffer
>> +	 */
>> +	struct fuse_ring_req *rreq;
>> +
>> +	/* the ring queue that owns the request */
>> +	struct fuse_ring_queue *queue;
>> +
>> +	struct io_uring_cmd *cmd;
>> +
>> +	struct list_head list;
>> +
>> +	/*
>> +	 * state the request is currently in
>> +	 * (enum fuse_ring_req_state)
>> +	 */
>> +	unsigned long state;
>> +
>> +	/* array index in the ring-queue */
>> +	int tag;
>> +
>> +	/* is this an async or sync entry */
>> +	unsigned int async : 1;
>> +
>> +	struct fuse_req *fuse_req; /* when a list request is handled */
>> +};
>> +
>> +struct fuse_ring_queue {
>> +	/* task belonging to the current queue */
>> +	struct task_struct *server_task;
>> +
>> +	/*
>> +	 * back pointer to the main fuse uring structure that holds this
>> +	 * queue
>> +	 */
>> +	struct fuse_ring *ring;
>> +
>> +	/* issue flags when running in io-uring task context */
>> +	unsigned int uring_cmd_issue_flags;
>> +
>> +	int qid;
>> +
>> +	/*
>> +	 * available number of sync requests,
>> +	 * loosely bound to fuse foreground requests
>> +	 */
>> +	int nr_req_sync;
>> +
>> +	/*
>> +	 * available number of async requests
>> +	 * loosely bound to fuse background requests
>> +	 */
>> +	int nr_req_async;
>> +
>> +	/* queue lock, taken when any value in the queue changes _and_ also
>> +	 * a ring entry state changes.
>> +	 */
>> +	spinlock_t lock;
>> +
>> +	/* per queue memory buffer that is divided per request */
>> +	char *queue_req_buf;
>> +
>> +	/* fuse fg/bg request types */
>> +	struct list_head async_fuse_req_queue;
>> +	struct list_head sync_fuse_req_queue;
>> +
>> +	/* available ring entries (struct fuse_ring_ent) */
>> +	struct list_head async_ent_avail_queue;
>> +	struct list_head sync_ent_avail_queue;
>> +
>> +	struct list_head ent_in_userspace;
>> +
>> +	unsigned int configured : 1;
>> +	unsigned int stopped : 1;
>> +
>> +	/* size depends on queue depth */
>> +	struct fuse_ring_ent ring_ent[] ____cacheline_aligned_in_smp;
>> +};
>> +
>> +/**
>> + * Describes if uring is for communication and holds alls the data needed
>> + * for uring communication
>> + */
>> +struct fuse_ring {
>> +	/* back pointer to fuse_conn */
>> +	struct fuse_conn *fc;
>> +
>> +	/* number of ring queues */
>> +	size_t nr_queues;
>> +
>> +	/* number of entries per queue */
>> +	size_t queue_depth;
>> +
>> +	/* max arg size for a request */
>> +	size_t req_arg_len;
>> +
>> +	/* req_arg_len + sizeof(struct fuse_req) */
>> +	size_t req_buf_sz;
>> +
>> +	/* max number of background requests per queue */
>> +	size_t max_nr_async;
>> +
>> +	/* max number of foreground requests */
>> +	size_t max_nr_sync;
>> +
>> +	/* size of struct fuse_ring_queue + queue-depth * entry-size */
>> +	size_t queue_size;
>> +
>> +	/* buffer size per queue, that is used per queue entry */
>> +	size_t queue_buf_size;
>> +
>> +	/* Used to release the ring on stop */
>> +	atomic_t queue_refs;
>> +
>> +	/* Hold ring requests */
>> +	struct fuse_ring_queue *queues;
>> +
>> +	/* number of initialized queues with the ioctl */
>> +	int nr_queues_ioctl_init;
>> +
>> +	/* number of SQEs initialized */
>> +	atomic_t nr_sqe_init;
>> +
>> +	/* one queue per core or a single queue only ? */
>> +	unsigned int per_core_queue : 1;
>> +
>> +	/* Is the ring completely iocl configured */
>> +	unsigned int configured : 1;
>> +
>> +	/* numa aware memory allocation */
>> +	unsigned int numa_aware : 1;
>> +
>> +	/* Is the ring read to take requests */
>> +	unsigned int ready : 1;
>> +
>> +	/*
>> +	 * Log ring entry states onces on stop when entries cannot be
>> +	 * released
>> +	 */
>> +	unsigned int stop_debug_log : 1;
>> +
>> +	struct mutex start_stop_lock;
>> +
>> +	wait_queue_head_t stop_waitq;
>> +
>> +	/* mmaped ring entry memory buffers, mmaped values is the key,
>> +	 * kernel pointer is the value
>> +	 */
>> +	struct rb_root mem_buf_map;
>> +
>> +	struct delayed_work stop_work;
>> +	unsigned long stop_time;
>> +};
> 
> This is mostly a preference thing, but you've added a huge amount of code that
> isn't used in this patch, so it makes it hard for me to review without knowing
> how the things are to be used.
> 
> Generally it's easier on reviewers if you're adding the structs as you need them
> so you can clearly follow what the purpose of everything is.  Here I just have
> to go look at the end result and figure out what everything does and if it makes
> sense.  Thanks,
> 
> Josef

Yeah, entirely agreed. Will improve that in the next patch version.


Thanks,
Bernd

