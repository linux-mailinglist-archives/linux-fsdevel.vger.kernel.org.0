Return-Path: <linux-fsdevel+bounces-20528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648788D4E86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 17:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8721C1C233CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 15:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E4E17D8A1;
	Thu, 30 May 2024 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RD5oyUel"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A5A17D8A0
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081198; cv=none; b=PbzDRSZDi1tgiDlibAqV1WdMA5E66W/17T2sRTcKWY4B6hrIGSW/oNvq6QmLBBCUMwiUHSVl5v7xQboaYZf3TuxkyCVRYYQJ+TqiKV7xmkWSrPfmdB2ocNSU859GfE9yUSRrwYcEH9Ieo6uGopQa16eBV0dx0vaCG2RM9FiwYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081198; c=relaxed/simple;
	bh=7uXhRnNROcjnlQ+4K/Jeo4vJ2IhE4NUb7skACzV+x34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5nKioVdOXyhawocbjsKBst5KI2zj4KoVqu5aori8H1sEGOVds5YGr1Nx9KFuSz+uApFbSOK4vaHbnsON/4BmQqV8bYEq0pmHONZiGvxaKIkJxDz4uq47nr+tZ//+7lYCJw7ofOqHcHQpe3t6ps1fNAQIQ6lNVAeqbHd6GTnDdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RD5oyUel; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43fb058873bso5064061cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 07:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717081195; x=1717685995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iliHbEYgDEOUMT8Ywm5JgqUevvmnGhuiPFTCi9smHK4=;
        b=RD5oyUel1Cu8mDpztKNRpCKcOHBAW308wemzmHSOttQN4vK1OTmABwX7/YOdf8VsRm
         Lm3ZQDiIMWinBCuasTCFo7SxEDsx6vNc325CginO2nAE2WQuY//BZmD14UuItk5RItqf
         avKUlu/M0JRYCY+QivX9I/a0zjU6OFD1CTdrpTCbcj58G1JatWODu4Fdv3OD13KnDhhW
         xIpPWCX4jDXTAfl2wCUf/Ud3bXssjgZq5SQZnLOcz5CZBLUErxhvVFgu5zy4yhQELepb
         vrnwXMLIlIctCzWweVx8wZUGY9Wc4WJ0ZN8VixrcA4RPO+zTOi0IoZlCM+3YI4WEvwEt
         5+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717081195; x=1717685995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iliHbEYgDEOUMT8Ywm5JgqUevvmnGhuiPFTCi9smHK4=;
        b=kUcc1LiFGe/bX8lrlfQb1Pouth+LeXbOQ4mK5o9g5OXnqias7AJyY4t9e+WAfFIPvK
         6mtY0KmSE+fkZpBWTZsh9sbN/TGEpH6LRh/VzvquHCVeFfXfHfuBMnKJSTczxhkdXbkj
         GWY4ykwTm/0cgR6dapQERFGdm4Qb/F2SSJ3cI2aDbb1r2AtGKP6HJUJUB9JXftheDCZk
         RXZx3yqVWj0fmDQelCkY1OL0cF/QV4q/qsib+u4OK0/ij2DZi3oGlRpjVKCfy/0hM6g0
         yHa3Cfr1M6Q8DRw+7SWehaSGC7NJGfcuRc1oykDvtecwOHVGsbiqKq3f5yUS6AQG2+aD
         14MA==
X-Forwarded-Encrypted: i=1; AJvYcCXXqJAN/iBMJzLWAO60xYaJBLaC7XHufHvCJ5Vq8Lwj7qLHHoLKQUL35Xrz5dq+bx//h38232A66vUzv7hvQOwb44Goi6aNVHLTQtttHA==
X-Gm-Message-State: AOJu0YzplVfxp4RGwvgIo8LqfffrYIthsv+wrHTPAyFxQ00cRqrvQdYG
	ihmLrM6P01q1Z/PY+tr9Z4QoyI6pAD375YQkv3yAa8faiN0OXEX9yGyqDEGisDQ=
X-Google-Smtp-Source: AGHT+IFTM3jcYEL7yzaiBtIP1TDwW6npXPsGW4S1cXF+U1DkMJ72dvCmzmopbBUuk6weQxhiVTLv1w==
X-Received: by 2002:a05:622a:2cc:b0:43d:fe36:99 with SMTP id d75a77b69052e-43fe931eed9mr28515871cf.52.1717081195087;
        Thu, 30 May 2024 07:59:55 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fe6c67dc0sm14209501cf.42.2024.05.30.07.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:59:54 -0700 (PDT)
Date: Thu, 30 May 2024 10:59:53 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 04/19] fuse: Add fuse-io-uring design documentation
Message-ID: <20240530145953.GB2205585@perftesting>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-4-d149476b1d65@ddn.com>
 <20240529211746.GD2182086@perftesting>
 <8e756ed6-3b12-4afa-ad6a-94e9a56fd4be@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e756ed6-3b12-4afa-ad6a-94e9a56fd4be@fastmail.fm>

On Thu, May 30, 2024 at 02:50:30PM +0200, Bernd Schubert wrote:
> 
> 
> On 5/29/24 23:17, Josef Bacik wrote:
> > On Wed, May 29, 2024 at 08:00:39PM +0200, Bernd Schubert wrote:
> >> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >> ---
> >>  Documentation/filesystems/fuse-io-uring.rst | 167 ++++++++++++++++++++++++++++
> >>  1 file changed, 167 insertions(+)
> >>
> >> diff --git a/Documentation/filesystems/fuse-io-uring.rst b/Documentation/filesystems/fuse-io-uring.rst
> >> new file mode 100644
> >> index 000000000000..4aa168e3b229
> >> --- /dev/null
> >> +++ b/Documentation/filesystems/fuse-io-uring.rst
> >> @@ -0,0 +1,167 @@
> >> +.. SPDX-License-Identifier: GPL-2.0
> >> +
> >> +===============================
> >> +FUSE Uring design documentation
> >> +==============================
> >> +
> >> +This documentation covers basic details how the fuse
> >> +kernel/userspace communication through uring is configured
> >> +and works. For generic details about FUSE see fuse.rst.
> >> +
> >> +This document also covers the current interface, which is
> >> +still in development and might change.
> >> +
> >> +Limitations
> >> +===========
> >> +As of now not all requests types are supported through uring, userspace
> > 
> > s/userspace side/userspace/
> > 
> >> +side is required to also handle requests through /dev/fuse after
> >> +uring setup is complete. These are especially notifications (initiated
> > 
> > especially is an awkward word choice here, I'm not quite sure what you're trying
> > say here, perhaps
> > 
> > "Specifically notifications (initiated from the daemon side), interrupts and
> > forgets"
> 
> Yep, thanks a lot! I removed forgets", these should be working over the ring 
> in the mean time.
> 
> > 
> > ?
> > 
> >> +from daemon side), interrupts and forgets.
> >> +Interrupts are probably not working at all when uring is used. At least
> >> +current state of libfuse will not be able to handle those for requests
> >> +on ring queues.
> >> +All these limitation will be addressed later.
> >> +
> >> +Fuse uring configuration
> >> +========================
> >> +
> >> +Fuse kernel requests are queued through the classical /dev/fuse
> >> +read/write interface - until uring setup is complete.
> >> +
> >> +In order to set up fuse-over-io-uring userspace has to send ioctls,
> >> +mmap requests in the right order
> >> +
> >> +1) FUSE_DEV_IOC_URING ioctl with FUSE_URING_IOCTL_CMD_RING_CFG
> >> +
> >> +First the basic kernel data structure has to be set up, using
> >> +FUSE_DEV_IOC_URING with subcommand FUSE_URING_IOCTL_CMD_RING_CFG.
> >> +
> >> +Example (from libfuse)
> >> +
> >> +static int fuse_uring_setup_kernel_ring(int session_fd,
> >> +					int nr_queues, int sync_qdepth,
> >> +					int async_qdepth, int req_arg_len,
> >> +					int req_alloc_sz)
> >> +{
> >> +	int rc;
> >> +
> >> +	struct fuse_ring_config rconf = {
> >> +		.nr_queues		    = nr_queues,
> >> +		.sync_queue_depth	= sync_qdepth,
> >> +		.async_queue_depth	= async_qdepth,
> >> +		.req_arg_len		= req_arg_len,
> >> +		.user_req_buf_sz	= req_alloc_sz,
> >> +		.numa_aware		    = nr_queues > 1,
> >> +	};
> >> +
> >> +	struct fuse_uring_cfg ioc_cfg = {
> >> +		.flags = 0,
> >> +		.cmd = FUSE_URING_IOCTL_CMD_RING_CFG,
> >> +		.rconf = rconf,
> >> +	};
> >> +
> >> +	rc = ioctl(session_fd, FUSE_DEV_IOC_URING, &ioc_cfg);
> >> +	if (rc)
> >> +		rc = -errno;
> >> +
> >> +	return rc;
> >> +}
> >> +
> >> +2) MMAP
> >> +
> >> +For shared memory communication between kernel and userspace
> >> +each queue has to allocate and map memory buffer.
> >> +For numa awares kernel side verifies if the allocating thread
> > 
> > This bit is awkwardly worded and there's some spelling mistakes.  Perhaps
> > something like this?
> > 
> > "For numa aware kernels, the kernel verifies that the allocating thread is bound
> > to a single core, as the kernel has the expectation that only a single thread
> > accesses a queue, and for numa aware memory allocation the core of the thread
> > sending the mmap request is used to identify the numa node"
> 
> Thank you, updated. I actually consider to reduce this to a warning (will try 
> to add an async FUSE_WARN request type for this and others). Issue is that
> systems cannot set up fuse-uring when a core is disabled. 
> 
> > 
> >> +is bound to a single core - in general kernel side has expectations
> >> +that only a single thread accesses a queue and for numa aware
> >> +memory alloation the core of the thread sending the mmap request
> >> +is used to identify the numa node.
> >> +
> >> +The offsset parameter has to be FUSE_URING_MMAP_OFF to identify
> >        ^^^^ "offset"
> 
> 
> Fixed.
> 
> > 
> >> +it is a request concerning fuse-over-io-uring.
> >> +
> >> +3) FUSE_DEV_IOC_URING ioctl with FUSE_URING_IOCTL_CMD_QUEUE_CFG
> >> +
> >> +This ioctl has to be send for every queue and takes the queue-id (qid)
> >                         ^^^^ "sent"
> > 
> >> +and memory address obtained by mmap to set up queue data structures.
> >> +
> >> +Kernel - userspace interface using uring
> >> +========================================
> >> +
> >> +After queue ioctl setup and memory mapping userspace submits
> > 
> > This needs a comma, so
> > 
> > "After queue ioctl setup and memory mapping, userspace submites"
> > 
> >> +SQEs (opcode = IORING_OP_URING_CMD) in order to fetch
> >> +fuse requests. Initial submit is with the sub command
> >> +FUSE_URING_REQ_FETCH, which will just register entries
> >> +to be available on the kernel side - it sets the according
> > 
> > s/according/associated/ maybe?
> > 
> >> +entry state and marks the entry as available in the queue bitmap.
> 
> Or maybe like this?
> 
> Initial submit is with the sub command FUSE_URING_REQ_FETCH, which 
> will just register entries to be available in the kernel.
> 
> 
> >> +
> >> +Once all entries for all queues are submitted kernel side starts
> >> +to enqueue to ring queue(s). The request is copied into the shared
> >> +memory queue entry buffer and submitted as CQE to the userspace
> >> +side.
> >> +Userspace side handles the CQE and submits the result as subcommand
> >> +FUSE_URING_REQ_COMMIT_AND_FETCH - kernel side does completes the requests
> > 
> > "the kernel completes the request"
> 
> Yeah, now I see the bad grammar myself. Updated to
> 
> 
> Once all entries for all queues are submitted, kernel starts
> to enqueue to ring queues. The request is copied into the shared
> memory buffer and submitted as CQE to the daemon.
> Userspace handles the CQE/fuse-request and submits the result as
> subcommand FUSE_URING_REQ_COMMIT_AND_FETCH - kernel completes
> the requests and also marks the entry available again. If there are
> pending requests waiting the request will be immediately submitted
> to the daemon again.
> 
> 
> 
> Thank you very much for your help to phrase this better!
> 

This all looks great, thanks!

Josef

