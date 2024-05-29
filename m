Return-Path: <linux-fsdevel+bounces-20490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DF08D402E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 23:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107D11F2406A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 21:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A941C2334;
	Wed, 29 May 2024 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LhwU36tj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583501C2302
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717017474; cv=none; b=YVPu2DYrlRjLdEMGYp4Yb2Lc4YHa0v5JSuy/Pjighkgs/GK/8msIhN0gpHgKh3NfhJJ4EUA4iSm6vJ3OG6LhFbLbzpnE7b/Xngme5eWx4iyBx48NmloWeSilhBVOqwhYaRC5VlKhCYpQS9Qg66iQq/O9Qqpcxci68YaiN9XNoJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717017474; c=relaxed/simple;
	bh=ZKUymR7VLynTZgN2g3OpqoSXtLZiiyKw4XH6zkVranU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhvpNrt7VdsuPKGwzQWhD1lhjdXbTB0feuItrT3CIFAIl3xg2fIModQd2gO6xLxfF962nK8yNEFEwaTYF1+VqGpy+1pwsnJ4z30FL3OrOu9v3lXHVttNNRtBq0qeWYoWGJ+wEQI7DxvsoNnUuO/fbNBUBWDwbACV/6BpTliXCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LhwU36tj; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ae0c4d23ddso1034026d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 14:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717017468; x=1717622268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DmIBqdGufRiEB4E9Ue90JMaBbfGmP0g3E4hfTg0EJIw=;
        b=LhwU36tjL0J8Kpqz0CeGlM5Sm9IA8kt3H1xK8PRfvLBveWdlLioZxxG1kmyni0Crhy
         5joBwrV2uBFWJnrTKY4rcHjsWCU0s2k43QjOvg1K/odS2NCSVtBJZ2L6q0pH+/wLbF+4
         9gwGGGf3VRaCVIOInImro8luZx5DbJfHE1oWvCOUSwIwMcgSOzDnpDQ43CDTCTQ/dLyB
         VR4pEb5EXVqmqTRCb9lOrdDrm43+JL0E5xVvExmWhTkSoQ5c5Q4FZKZ6VofcdeK1GNBb
         32bRjGt8adUtc86gn8cs+tbptPqJBK8bxsu0OEtJQXg274Zsa+klFhaH0c4E3NI04Yps
         TlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717017468; x=1717622268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmIBqdGufRiEB4E9Ue90JMaBbfGmP0g3E4hfTg0EJIw=;
        b=XZbSZAgLxjVZLBUwcl6cbwiGFTt46fdawuw1mLbtQwg3bAkhAjbXVdJsv26KWWHbgn
         f5UBCpXJx1++RJ+AFchAobYObwm+F+A1Mn+/0eNN1m2tqOHjvZhkstGuXNLUC3nCdWHL
         wK2HdFYIWhYPhI5D5+GKaExWEcRq0sF1CLXXQmFeqwyf1QgaAVLSOlOthwNFgIfA1QtT
         4EJn2vPdUnlSQznqUOFOpA68b7Ke8K3tWattiXfWwb0Y6t67jtoXziP+F33ybVUDswKf
         MRYv6x+awDkM+dBngG6xq2sVqHj6xn95WuG0LP7NGqXlu5m4p/bpkwWJ5n1iPDOYgFLd
         wPJg==
X-Forwarded-Encrypted: i=1; AJvYcCUdlis/tRtj1zD96RyZSWKxbkvEiWmdg8SM+/IbCh7lvhUSbpaET0LQOOz0xF+N820bC95dijbCMni+dMH3ef2xnWPqs0wjS4kbk4cQTQ==
X-Gm-Message-State: AOJu0YzTdeEYXLSgfGitRCZnclvuR4dePXuNdfe1kR5Nwz9Z0RnOb7vy
	rSrqPALkX48/3g/geF4vQKiCqZr78PDA8CNWByT65VnSlh3jvG0zn6dPw1ZUUWM=
X-Google-Smtp-Source: AGHT+IH8bUGMLUynwXMDwTb+XLALE3LN7joCCxbSsP5QjhQvsgIOh4sMas1NMVkN1f7o896Mj6XhSQ==
X-Received: by 2002:a05:6214:3284:b0:6ab:9ac1:15cc with SMTP id 6a1803df08f44-6ae0ccb0bd1mr3326356d6.52.1717017468025;
        Wed, 29 May 2024 14:17:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac162f0969sm57673656d6.89.2024.05.29.14.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 14:17:47 -0700 (PDT)
Date: Wed, 29 May 2024 17:17:46 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm
Subject: Re: [PATCH RFC v2 04/19] fuse: Add fuse-io-uring design documentation
Message-ID: <20240529211746.GD2182086@perftesting>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-4-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-4-d149476b1d65@ddn.com>

On Wed, May 29, 2024 at 08:00:39PM +0200, Bernd Schubert wrote:
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  Documentation/filesystems/fuse-io-uring.rst | 167 ++++++++++++++++++++++++++++
>  1 file changed, 167 insertions(+)
> 
> diff --git a/Documentation/filesystems/fuse-io-uring.rst b/Documentation/filesystems/fuse-io-uring.rst
> new file mode 100644
> index 000000000000..4aa168e3b229
> --- /dev/null
> +++ b/Documentation/filesystems/fuse-io-uring.rst
> @@ -0,0 +1,167 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============================
> +FUSE Uring design documentation
> +==============================
> +
> +This documentation covers basic details how the fuse
> +kernel/userspace communication through uring is configured
> +and works. For generic details about FUSE see fuse.rst.
> +
> +This document also covers the current interface, which is
> +still in development and might change.
> +
> +Limitations
> +===========
> +As of now not all requests types are supported through uring, userspace

s/userspace side/userspace/

> +side is required to also handle requests through /dev/fuse after
> +uring setup is complete. These are especially notifications (initiated

especially is an awkward word choice here, I'm not quite sure what you're trying
say here, perhaps

"Specifically notifications (initiated from the daemon side), interrupts and
forgets"

?

> +from daemon side), interrupts and forgets.
> +Interrupts are probably not working at all when uring is used. At least
> +current state of libfuse will not be able to handle those for requests
> +on ring queues.
> +All these limitation will be addressed later.
> +
> +Fuse uring configuration
> +========================
> +
> +Fuse kernel requests are queued through the classical /dev/fuse
> +read/write interface - until uring setup is complete.
> +
> +In order to set up fuse-over-io-uring userspace has to send ioctls,
> +mmap requests in the right order
> +
> +1) FUSE_DEV_IOC_URING ioctl with FUSE_URING_IOCTL_CMD_RING_CFG
> +
> +First the basic kernel data structure has to be set up, using
> +FUSE_DEV_IOC_URING with subcommand FUSE_URING_IOCTL_CMD_RING_CFG.
> +
> +Example (from libfuse)
> +
> +static int fuse_uring_setup_kernel_ring(int session_fd,
> +					int nr_queues, int sync_qdepth,
> +					int async_qdepth, int req_arg_len,
> +					int req_alloc_sz)
> +{
> +	int rc;
> +
> +	struct fuse_ring_config rconf = {
> +		.nr_queues		    = nr_queues,
> +		.sync_queue_depth	= sync_qdepth,
> +		.async_queue_depth	= async_qdepth,
> +		.req_arg_len		= req_arg_len,
> +		.user_req_buf_sz	= req_alloc_sz,
> +		.numa_aware		    = nr_queues > 1,
> +	};
> +
> +	struct fuse_uring_cfg ioc_cfg = {
> +		.flags = 0,
> +		.cmd = FUSE_URING_IOCTL_CMD_RING_CFG,
> +		.rconf = rconf,
> +	};
> +
> +	rc = ioctl(session_fd, FUSE_DEV_IOC_URING, &ioc_cfg);
> +	if (rc)
> +		rc = -errno;
> +
> +	return rc;
> +}
> +
> +2) MMAP
> +
> +For shared memory communication between kernel and userspace
> +each queue has to allocate and map memory buffer.
> +For numa awares kernel side verifies if the allocating thread

This bit is awkwardly worded and there's some spelling mistakes.  Perhaps
something like this?

"For numa aware kernels, the kernel verifies that the allocating thread is bound
to a single core, as the kernel has the expectation that only a single thread
accesses a queue, and for numa aware memory allocation the core of the thread
sending the mmap request is used to identify the numa node"

> +is bound to a single core - in general kernel side has expectations
> +that only a single thread accesses a queue and for numa aware
> +memory alloation the core of the thread sending the mmap request
> +is used to identify the numa node.
> +
> +The offsset parameter has to be FUSE_URING_MMAP_OFF to identify
       ^^^^ "offset"

> +it is a request concerning fuse-over-io-uring.
> +
> +3) FUSE_DEV_IOC_URING ioctl with FUSE_URING_IOCTL_CMD_QUEUE_CFG
> +
> +This ioctl has to be send for every queue and takes the queue-id (qid)
                        ^^^^ "sent"

> +and memory address obtained by mmap to set up queue data structures.
> +
> +Kernel - userspace interface using uring
> +========================================
> +
> +After queue ioctl setup and memory mapping userspace submits

This needs a comma, so

"After queue ioctl setup and memory mapping, userspace submites"

> +SQEs (opcode = IORING_OP_URING_CMD) in order to fetch
> +fuse requests. Initial submit is with the sub command
> +FUSE_URING_REQ_FETCH, which will just register entries
> +to be available on the kernel side - it sets the according

s/according/associated/ maybe?

> +entry state and marks the entry as available in the queue bitmap.
> +
> +Once all entries for all queues are submitted kernel side starts
> +to enqueue to ring queue(s). The request is copied into the shared
> +memory queue entry buffer and submitted as CQE to the userspace
> +side.
> +Userspace side handles the CQE and submits the result as subcommand
> +FUSE_URING_REQ_COMMIT_AND_FETCH - kernel side does completes the requests

"the kernel completes the request"

Thanks,

Josef

