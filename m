Return-Path: <linux-fsdevel+bounces-20519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5E18D4C01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 14:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24655B22145
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 12:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFF7132126;
	Thu, 30 May 2024 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Oqu73bAq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O0/Vx6rD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CEE1E515
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073435; cv=none; b=bVfdMKnaSvoru2oEXJnI1HTxByWSZxJ/HAHF6XLv0qzyE11M8dzaxUW3uHVSzTA+K6myEAfy7NKrtHPV7+VfNMxTSO9QJYvlntABYuJrWjS9iwaYA0SpA5OogH0UCbB0Lm6d8cmhhNn1G8HOUx10VgcOkqMfDm80pkwnEr6q4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073435; c=relaxed/simple;
	bh=xyCFcgCyr047cCb6fEF1M5XJHbfSF/tRphznUbgbJfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdTYKF9swtlPYNLK6PFwLeGCcCHZO241TLE1zdVZudcOpsuTb9pwsFHGyeWBvY/gPkc/2BmCTomo2sXtmG9nQj3Rl7Bn8+zB00PxNk85uKtFO/qGbgyX8QBtV6det6Ld2E/JJr3vhZr6K4r9+tllD//M3sLHjmqvr3e9E0+/w/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=Oqu73bAq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O0/Vx6rD; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 67B7013800D8;
	Thu, 30 May 2024 08:50:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 30 May 2024 08:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717073432;
	 x=1717159832; bh=2uNXQ6Fjo+kSEjWPunY1HiCaofbdzyN995eTo2NCSXM=; b=
	Oqu73bAqzJrJspLz9H+rld/rEuIRWqsdWZRgNSafeBLi5z+g1Yrraz3+a9RqFM0j
	o/BNynfsEULyfGLU9VF9JwBQpov+FvfM3sRCnEjH+uxCey7aOX8HnOscd7P4l7GF
	RFSbaJiJr2T5eIBIYZW158SjmCh+yX4quiA4t0onOWwXoT0zBm8gQ2ZbUGRhIOrx
	UKB59xRqY1amW0Dzkfm/Lkshf7mVH42HaosgHyZKFNxko29FoLL5sOGzVWAYiosx
	c0KaNdy4OV4FJizg9oYzvgk2wTFD82r1CQwSz0E3QKbNGIEDd9BRAurwj5gHIov4
	5TnzNUJNpamobAORizphug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717073432; x=
	1717159832; bh=2uNXQ6Fjo+kSEjWPunY1HiCaofbdzyN995eTo2NCSXM=; b=O
	0/Vx6rDgRKViQUjyN2J+hPDlYsrl1D+k3T2m7huS+OBtoM0CPuWHbTcF5YeSGj8+
	kO1kxDs1UtVJTIQ+K6KUAiupe00lmNlw6j/0Ra5huHGj5kCGD3XsyWmh14fAlxxc
	vNfoXCFw8TbB/Iqg2pemqr+y4lW90Ausgis5m0xtplDaqpgnt8cdvnDayIUgFSXE
	ArVSvcLNtT8ZIaz4oZv+X9hCmcAYe869wQjO4/dhOKJYm79ltDoy7SShupgjmWo8
	rpwivlL8TGVEC5gcXXswcCCg4NeiXOMUBbXTVPwfZpyX9BP17sDrkMD1dIn6TP5y
	m29h6nIhcjxqMQ+W3cABg==
X-ME-Sender: <xms:F3ZYZk0NR8FOgtRWPTW1Wtx27YfETUZX5uNXQ5XF0eco19TUnNft6g>
    <xme:F3ZYZvHzJXIvfAuJtH5hDgRRM8N44FS4TSmwlG8h9iy34KsvAjZRe2WlLnaAM3aT9
    UVMjShmBbEq8p7Z>
X-ME-Received: <xmr:F3ZYZs6734rjpZHnUPg2AbXehe_IBR45dWDaQzVybWi08Kt_zf23TDkxVvMdDBWJ7uDex-PThEyCvsvHJu6xie9xV-D_D_Fe6YkCVHjgtdm-Dq15Vbx9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:F3ZYZt12yS4049EFWsDOf3B7OsnUnwR_9EUNtHcbbteuYF7sOcUq8w>
    <xmx:F3ZYZnHukWJOBPQxxfrPP8WwwhByEkMND4P2Xdba1I5_UBu2bC02AQ>
    <xmx:F3ZYZm-obmPz_hCxEE8CAihhMi2y6DnDVt7J2B9t2TVWkmOKqXm0aw>
    <xmx:F3ZYZskCY7w9DdLFfTPK9P-X-T3MLv-cDr-XxaDO3YDdcKNrz7WtJQ>
    <xmx:GHZYZoPBEvfPC6WTtuzn0wkALvTcps0V2THdKfWsXO0auMM7AUy5GzD5>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:50:31 -0400 (EDT)
Message-ID: <8e756ed6-3b12-4afa-ad6a-94e9a56fd4be@fastmail.fm>
Date: Thu, 30 May 2024 14:50:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 04/19] fuse: Add fuse-io-uring design documentation
To: Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 linux-fsdevel@vger.kernel.org
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-4-d149476b1d65@ddn.com>
 <20240529211746.GD2182086@perftesting>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20240529211746.GD2182086@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/29/24 23:17, Josef Bacik wrote:
> On Wed, May 29, 2024 at 08:00:39PM +0200, Bernd Schubert wrote:
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  Documentation/filesystems/fuse-io-uring.rst | 167 ++++++++++++++++++++++++++++
>>  1 file changed, 167 insertions(+)
>>
>> diff --git a/Documentation/filesystems/fuse-io-uring.rst b/Documentation/filesystems/fuse-io-uring.rst
>> new file mode 100644
>> index 000000000000..4aa168e3b229
>> --- /dev/null
>> +++ b/Documentation/filesystems/fuse-io-uring.rst
>> @@ -0,0 +1,167 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +===============================
>> +FUSE Uring design documentation
>> +==============================
>> +
>> +This documentation covers basic details how the fuse
>> +kernel/userspace communication through uring is configured
>> +and works. For generic details about FUSE see fuse.rst.
>> +
>> +This document also covers the current interface, which is
>> +still in development and might change.
>> +
>> +Limitations
>> +===========
>> +As of now not all requests types are supported through uring, userspace
> 
> s/userspace side/userspace/
> 
>> +side is required to also handle requests through /dev/fuse after
>> +uring setup is complete. These are especially notifications (initiated
> 
> especially is an awkward word choice here, I'm not quite sure what you're trying
> say here, perhaps
> 
> "Specifically notifications (initiated from the daemon side), interrupts and
> forgets"

Yep, thanks a lot! I removed forgets", these should be working over the ring 
in the mean time.

> 
> ?
> 
>> +from daemon side), interrupts and forgets.
>> +Interrupts are probably not working at all when uring is used. At least
>> +current state of libfuse will not be able to handle those for requests
>> +on ring queues.
>> +All these limitation will be addressed later.
>> +
>> +Fuse uring configuration
>> +========================
>> +
>> +Fuse kernel requests are queued through the classical /dev/fuse
>> +read/write interface - until uring setup is complete.
>> +
>> +In order to set up fuse-over-io-uring userspace has to send ioctls,
>> +mmap requests in the right order
>> +
>> +1) FUSE_DEV_IOC_URING ioctl with FUSE_URING_IOCTL_CMD_RING_CFG
>> +
>> +First the basic kernel data structure has to be set up, using
>> +FUSE_DEV_IOC_URING with subcommand FUSE_URING_IOCTL_CMD_RING_CFG.
>> +
>> +Example (from libfuse)
>> +
>> +static int fuse_uring_setup_kernel_ring(int session_fd,
>> +					int nr_queues, int sync_qdepth,
>> +					int async_qdepth, int req_arg_len,
>> +					int req_alloc_sz)
>> +{
>> +	int rc;
>> +
>> +	struct fuse_ring_config rconf = {
>> +		.nr_queues		    = nr_queues,
>> +		.sync_queue_depth	= sync_qdepth,
>> +		.async_queue_depth	= async_qdepth,
>> +		.req_arg_len		= req_arg_len,
>> +		.user_req_buf_sz	= req_alloc_sz,
>> +		.numa_aware		    = nr_queues > 1,
>> +	};
>> +
>> +	struct fuse_uring_cfg ioc_cfg = {
>> +		.flags = 0,
>> +		.cmd = FUSE_URING_IOCTL_CMD_RING_CFG,
>> +		.rconf = rconf,
>> +	};
>> +
>> +	rc = ioctl(session_fd, FUSE_DEV_IOC_URING, &ioc_cfg);
>> +	if (rc)
>> +		rc = -errno;
>> +
>> +	return rc;
>> +}
>> +
>> +2) MMAP
>> +
>> +For shared memory communication between kernel and userspace
>> +each queue has to allocate and map memory buffer.
>> +For numa awares kernel side verifies if the allocating thread
> 
> This bit is awkwardly worded and there's some spelling mistakes.  Perhaps
> something like this?
> 
> "For numa aware kernels, the kernel verifies that the allocating thread is bound
> to a single core, as the kernel has the expectation that only a single thread
> accesses a queue, and for numa aware memory allocation the core of the thread
> sending the mmap request is used to identify the numa node"

Thank you, updated. I actually consider to reduce this to a warning (will try 
to add an async FUSE_WARN request type for this and others). Issue is that
systems cannot set up fuse-uring when a core is disabled. 

> 
>> +is bound to a single core - in general kernel side has expectations
>> +that only a single thread accesses a queue and for numa aware
>> +memory alloation the core of the thread sending the mmap request
>> +is used to identify the numa node.
>> +
>> +The offsset parameter has to be FUSE_URING_MMAP_OFF to identify
>        ^^^^ "offset"


Fixed.

> 
>> +it is a request concerning fuse-over-io-uring.
>> +
>> +3) FUSE_DEV_IOC_URING ioctl with FUSE_URING_IOCTL_CMD_QUEUE_CFG
>> +
>> +This ioctl has to be send for every queue and takes the queue-id (qid)
>                         ^^^^ "sent"
> 
>> +and memory address obtained by mmap to set up queue data structures.
>> +
>> +Kernel - userspace interface using uring
>> +========================================
>> +
>> +After queue ioctl setup and memory mapping userspace submits
> 
> This needs a comma, so
> 
> "After queue ioctl setup and memory mapping, userspace submites"
> 
>> +SQEs (opcode = IORING_OP_URING_CMD) in order to fetch
>> +fuse requests. Initial submit is with the sub command
>> +FUSE_URING_REQ_FETCH, which will just register entries
>> +to be available on the kernel side - it sets the according
> 
> s/according/associated/ maybe?
> 
>> +entry state and marks the entry as available in the queue bitmap.

Or maybe like this?

Initial submit is with the sub command FUSE_URING_REQ_FETCH, which 
will just register entries to be available in the kernel.


>> +
>> +Once all entries for all queues are submitted kernel side starts
>> +to enqueue to ring queue(s). The request is copied into the shared
>> +memory queue entry buffer and submitted as CQE to the userspace
>> +side.
>> +Userspace side handles the CQE and submits the result as subcommand
>> +FUSE_URING_REQ_COMMIT_AND_FETCH - kernel side does completes the requests
> 
> "the kernel completes the request"

Yeah, now I see the bad grammar myself. Updated to


Once all entries for all queues are submitted, kernel starts
to enqueue to ring queues. The request is copied into the shared
memory buffer and submitted as CQE to the daemon.
Userspace handles the CQE/fuse-request and submits the result as
subcommand FUSE_URING_REQ_COMMIT_AND_FETCH - kernel completes
the requests and also marks the entry available again. If there are
pending requests waiting the request will be immediately submitted
to the daemon again.



Thank you very much for your help to phrase this better!



Bernd

