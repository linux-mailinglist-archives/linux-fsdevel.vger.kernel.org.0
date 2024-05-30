Return-Path: <linux-fsdevel+bounces-20554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B15CC8D517A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 19:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D422FB24EBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 17:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DDC46B91;
	Thu, 30 May 2024 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="GsDd85kE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z8H4w4kN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAB04D9E8
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717091362; cv=none; b=AIQUnnB3ApuYkH/U753uY3Ux+dY/FuZCXZjPMcbSKOzgPsMYIZ38ZbpF+pKQFLd7wN0qSk3RxJcGtZCJcWytFnsyGDFA12gckUsKaGorf8hKCaQnmI9KgolNmiZ5/iTn7rNH6ylOOvfj7CfNy3Xm3rDg5Vhm0imS7rZwEVgH7bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717091362; c=relaxed/simple;
	bh=8w2tfreCL3qoSsEk5tC8kt7b+EV+IVUwaU/AmFIrWNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtXtWg4hI/evDfOFhEcb8UE4CLJI8U1AWs/RydTEF08tbULBbsfEjSCh0FQCBw7KaJH+wBlgLlNkZQid/Mh/ZukI7ubjt5/798w0+lGOks30nkMl9/8KlXoxYfVE1ZMwCusgx1pIJnhvnNMmFi1Aaa6mfu7HGfQQLIbLJ4XbEm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=GsDd85kE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z8H4w4kN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1FDF11140159;
	Thu, 30 May 2024 13:49:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 30 May 2024 13:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717091360;
	 x=1717177760; bh=utIIHUEBGwQvOfvaGzn0YyesYnn95I4KKDoYgo57e04=; b=
	GsDd85kEM3SZo25U8p40KsAK6RDSgCQlcdQ/vuQvv+4fErOFoW7VMtfKWvf2WxNK
	umeUldl12OjpIZBK8fDdicypzRuy//IuLfqhRJn32uVU8Gk9GlX2TjJL5x7EUkfa
	ti89WDjfz5zCDOFETo16o/rETVsZtsLs2ksAXNykRMaejm6YjZNrMk+L4+PuV1DV
	i01uuo0iLzQ5HwxUO1rWiadgrhxjr/gy+Svq7mwiFfY2N4Vvm5slp09AQwCU+a+5
	NxLY1oIZkFcrLpq4UynRX5qwn8mcmdCYbD2bjNSwLCOlfSFJFbqxt5kHqrsa7GB+
	H6xFwLjEfiK7S6H4Edbr+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717091360; x=
	1717177760; bh=utIIHUEBGwQvOfvaGzn0YyesYnn95I4KKDoYgo57e04=; b=Z
	8H4w4kNoIvsrkwpUysVjm3FP/TnCWeTjHBk6GDuvgbLTzImV/JLzEVcR+i1L91qw
	5NPb09MwQ3PW1YUI70C2k6owMFWcN+YSxWl1y6jQJLkiVPEYzFnVT7nrESBC5kB1
	CKYZ40vHYd1BkCcjeMFzZlqoiwizFzmH3IB2BORSlrqqqttaAQ+l1GfvC9VJhQyP
	xs2x+C8gK2X9V9QJ3D+2vSmdNCyf++LaUPy8h1G0Kkfa+4HZPGWb9KDA26Q0q0MV
	bMBsODtDALwGfVjJjdC951l8SJfi3HDu7hQEkLMzMQ07r2QeVuVgGjLQfYEkFFAf
	1yj/qcFxlZo8KBAS8SSlg==
X-ME-Sender: <xms:H7xYZrzfRHrYss4PWHVov9HzFqWUxQsn4n-UfJDoP5YBWJqmmtfIrA>
    <xme:H7xYZjRHnIE-IBgHcZMDdf5dYV8OLLpcm0WSmGtJEm9BmnVySAZlcW6MapK-_mxMX
    kL5ly_pHgD9PlaA>
X-ME-Received: <xmr:H7xYZlVh00qh1_nUd1KTbfEfZ2ZkEDsy-WERIqxTLiovvIQGNqj6LgwWaXgmTo363SmqVYiS041HTwJuwdSJQLbpAqcCsVO2E0yifbUgvTzZA8Z1Y6Xv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpedtudeggfejfeektdeghfehgedvtdefjeeh
    heeuueffhfefleefueehteefuddtieenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhn
    ugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:H7xYZlg7snr8WPBndjkJrrFeKvQOBkja7dm8pIfRk0K_XUb-Nqci8w>
    <xmx:H7xYZtAYmKAKksJCZgOTipY4wUnYuUzlzqGu2oIsAMwbx6DkT5b8yQ>
    <xmx:H7xYZuIMtMcw65InGL15pmzb5NWZBhPcbWZKHtBhV1E0gtZYihKNHw>
    <xmx:H7xYZsAZMhpRQAEXP89Ykqq5ddyhUEq5-_VXYnYxfw8fEh0ujPd0xQ>
    <xmx:ILxYZg5NLIHOg6-1MUeC8uQnbpuj4lNCb5epyTGtxUp7NXM9Ae4gU7jW>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 13:49:18 -0400 (EDT)
Message-ID: <df6647f8-0e54-4f2d-8a0a-42eb2835b6e3@fastmail.fm>
Date: Thu, 30 May 2024 19:49:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 08/19] fuse: Add the queue configuration ioctl
To: Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 linux-fsdevel@vger.kernel.org
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-8-d149476b1d65@ddn.com>
 <20240530155400.GE2205585@perftesting>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20240530155400.GE2205585@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/30/24 17:54, Josef Bacik wrote:
> On Wed, May 29, 2024 at 08:00:43PM +0200, Bernd Schubert wrote:
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  fs/fuse/dev.c             | 10 +++++
>>  fs/fuse/dev_uring.c       | 95 +++++++++++++++++++++++++++++++++++++++++++++++
>>  fs/fuse/dev_uring_i.h     | 18 +++++++++
>>  fs/fuse/fuse_i.h          |  3 ++
>>  include/uapi/linux/fuse.h | 26 +++++++++++++
>>  5 files changed, 152 insertions(+)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 349c1d16b0df..78c05516da7f 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -2395,6 +2395,12 @@ static long fuse_uring_ioctl(struct file *file, __u32 __user *argp)
>>  	if (res != 0)
>>  		return -EFAULT;
>>  
>> +	if (cfg.cmd == FUSE_URING_IOCTL_CMD_QUEUE_CFG) {
>> +		res = _fuse_dev_ioctl_clone(file, cfg.qconf.control_fd);
>> +		if (res != 0)
>> +			return res;
>> +	}
>> +
>>  	fud = fuse_get_dev(file);
>>  	if (fud == NULL)
>>  		return -ENODEV;
>> @@ -2424,6 +2430,10 @@ static long fuse_uring_ioctl(struct file *file, __u32 __user *argp)
>>  		if (res != 0)
>>  			return res;
>>  		break;
>> +		case FUSE_URING_IOCTL_CMD_QUEUE_CFG:
>> +			fud->uring_dev = 1;
>> +			res = fuse_uring_queue_cfg(fc->ring, &cfg.qconf);
>> +		break;
>>  	default:
>>  		res = -EINVAL;
>>  	}
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index 9491bdaa5716..2c0ccb378908 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -144,6 +144,39 @@ static char *fuse_uring_alloc_queue_buf(int size, int node)
>>  	return buf ? buf : ERR_PTR(-ENOMEM);
>>  }
>>  
>> +/*
>> + * mmaped allocated buffers, but does not know which queue that is for
>> + * This ioctl uses the userspace address as key to identify the kernel address
>> + * and assign it to the kernel side of the queue.
>> + */
>> +static int fuse_uring_ioctl_mem_reg(struct fuse_ring *ring,
>> +				    struct fuse_ring_queue *queue,
>> +				    uint64_t uaddr)
>> +{
>> +	struct rb_node *node;
>> +	struct fuse_uring_mbuf *entry;
>> +	int tag;
>> +
>> +	node = rb_find((const void *)uaddr, &ring->mem_buf_map,
>> +		       fuse_uring_rb_tree_buf_cmp);
>> +	if (!node)
>> +		return -ENOENT;
>> +	entry = rb_entry(node, struct fuse_uring_mbuf, rb_node);
>> +
>> +	rb_erase(node, &ring->mem_buf_map);
>> +
>> +	queue->queue_req_buf = entry->kbuf;
>> +
>> +	for (tag = 0; tag < ring->queue_depth; tag++) {
>> +		struct fuse_ring_ent *ent = &queue->ring_ent[tag];
>> +
>> +		ent->rreq = entry->kbuf + tag * ring->req_buf_sz;
>> +	}
>> +
>> +	kfree(node);
>> +	return 0;
>> +}
>> +
>>  /**
>>   * fuse uring mmap, per ring qeuue.
>>   * Userpsace maps a kernel allocated ring/queue buffer. For numa awareness,
>> @@ -234,3 +267,65 @@ fuse_uring_mmap(struct file *filp, struct vm_area_struct *vma)
>>  
>>  	return ret;
>>  }
>> +
>> +int fuse_uring_queue_cfg(struct fuse_ring *ring,
>> +			 struct fuse_ring_queue_config *qcfg)
>> +{
>> +	int tag;
>> +	struct fuse_ring_queue *queue;
>> +
>> +	if (qcfg->qid >= ring->nr_queues) {
>> +		pr_info("fuse ring queue config: qid=%u >= nr-queues=%zu\n",
>> +			qcfg->qid, ring->nr_queues);
>> +		return -EINVAL;
>> +	}
>> +	queue = fuse_uring_get_queue(ring, qcfg->qid);
>> +
>> +	if (queue->configured) {
>> +		pr_info("fuse ring qid=%u already configured!\n", queue->qid);
>> +		return -EALREADY;
>> +	}
>> +
>> +	mutex_lock(&ring->start_stop_lock);
>> +	fuse_uring_ioctl_mem_reg(ring, queue, qcfg->uaddr);
>> +	mutex_unlock(&ring->start_stop_lock);
> 
> You're not handling the error here.  Thanks,


Thanks again for all your reviews! All fixed up to here, except
vmalloc_node_user(), as you suggested, I will try to decouple it from
this series.

And d'oh! I didn't find the simple numa_node_id() function. Thanks so
much for pointing that out.

New branch is here:
https://github.com/bsbernd/linux/tree/fuse-uring-for-6.9-rfc3


Thanks,
Bernd

