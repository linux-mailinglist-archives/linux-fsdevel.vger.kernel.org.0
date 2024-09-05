Return-Path: <linux-fsdevel+bounces-28794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8D096E4DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 23:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5919A1F24672
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED94A1AE054;
	Thu,  5 Sep 2024 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="QEYC8vua";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y8rqp8Oh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7971A42C7
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571005; cv=none; b=Z2Y7lyP0rIA8LckfaP2tHIgSoBCDZiK1vLnt1xrq3scfazvvYY2XEmtrXTiHv1rgfQrmQ8CkodXe/cyQCWSz+t2q7Jnp2EAo7gKUmfjlK/6b+tSy/oFklns6X30zeH8XrC0gxt6GYqekZoLAugwJPcx4dAF4jEvtOLlFnkDEOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571005; c=relaxed/simple;
	bh=0r9D8O3lIV19Y4beVPQ8Cz7K1SIdAaKtv6AFva5WNLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rN4O43g5GydElZkD8iG888huDJt0gczHTq6xPmgk5WFyagdlufBTQPrGKH9U7tZ5cBS1jsjpW67mdPEI32paUkm9cr/t8+gWHB23MP8s/LCpMJTlc7MwV3/64SyyYt/dBJRdb2mp6EfT8BwbB1exYqehV7FrLNc2+ystH+svmM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=QEYC8vua; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y8rqp8Oh; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 233061380212;
	Thu,  5 Sep 2024 17:16:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Sep 2024 17:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725571002;
	 x=1725657402; bh=C2zYHKJR3oMl2HITzGv+tZPBROCs0pGQzxo1sC/nOQE=; b=
	QEYC8vuaIYkSIlHr86XRfJgzqR/U8Uh9JM33G7pyoGZGazoJJo3xEwSsedEpyir6
	OhJbJwVqbjrlyyEJCUNGmgRe1n8iFgnpkzhH1rqxDueQAm8rxj4ijelhaMJSqv3z
	t8HQ4upnNXmCCGvblvA039goQYf+/t+FyccDQ5togDTd9qD3M3FFXrRhdHcGWR2B
	uUZtx8e6ofE3uzhpl2DE5YQfGwipksJ1jg3ePeKXf7ETVWhPbIJXrcycxNWvsYhb
	0aUwNeI2KJLCFiGDx+zNunqdwNY9a2bldOPrySmog/oaP+Lrv36F9lzfdF5GZjlM
	fC/dIRG6a5vyM5NuXUauWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725571002; x=
	1725657402; bh=C2zYHKJR3oMl2HITzGv+tZPBROCs0pGQzxo1sC/nOQE=; b=Y
	8rqp8OhyNIov0jf+TpiA8LqAGoYJ/9FT7XtTLL3gDN2wqv41mIRsjgKxsDHkOkeN
	N3xnxPC2QrQUPPpGU+2TpGBKfC3S1yluaCSYuwou4A7rO3rWaRHOJP5i3Oh0T+4D
	n3+QdUJRPBzRC0MkClSCgVpFI6H8fcgNFjNUVTFAP8d65dofGHaumhAwW3to1e7I
	LA/7hEo3Trs1OpStS0EySaqbk3TQNKwhkJLpnvL//ptMHHlL8SMTTsH20JIL+JZT
	cncGlIPU9BtpHV5xEokn4uiTGXXYkE2t7miVy1jfP0qx0Dxt+jFuD9xm36BrbrNB
	F/ydJdTeHBJ4ZNkh4YHUA==
X-ME-Sender: <xms:uR_aZnIeqq2ARK44s8a9l7GRWoLOT5rVsww4ksn-cjmU1f2o2rjkcQ>
    <xme:uR_aZrJ-1_23G_GWJVyx-ry1qX2tJM9BLMt16eZzo8KCcg6DBGPU1MfAVGSO_cxzC
    XV2AT5XWB2WV1QF>
X-ME-Received: <xmr:uR_aZvs1DdB7DUYyP5pi9ijzQ4z-dmWeBF3MYU3zVZCJBrtja19PkynSYJacaxiVlpsEA2UXvTWapiJDhzxpa87aSh7l5aWjlYfrwkFUyPk8EAqnXibz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeffjeevfeefjefg
    hfefhfeiueffffetledtgffhhfdttdefueevledvleetfeevtdenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohgrnhhn
    vghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivg
    hrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtg
    homhdprhgtphhtthhopehsfigvvghtthgvrgdqkhgvrhhnvghlseguohhrmhhinhihrdhm
    vgdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:uh_aZgbqZibUboDoZwQh2slPUEpL0D3173mtyVUFig17lc0xv-sKZQ>
    <xmx:uh_aZubM3v1tLWUIobZjDJmlWpBW3cAjAjy3SmEjfUVkntj87_07Og>
    <xmx:uh_aZkB-4hwl1tuNPYfFH1_LwTr5_rea6hgyz3o98Glx5Fpw_2Q05w>
    <xmx:uh_aZsbSeh_m79wyEWwpKXGTgQ_9f722n7AZNZWGithS_rX4EbyhoQ>
    <xmx:uh_aZjMEhKNX74Ib3tGsUUyZVr12Tca5F2zjq6J2uMgFfHIycew9TSNP>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 17:16:40 -0400 (EDT)
Message-ID: <27b6ad2f-9a43-4938-9f0d-2d11581e8be7@fastmail.fm>
Date: Thu, 5 Sep 2024 23:16:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] fuse: Enable dynamic configuration of fuse max
 pages limit (FUSE_MAX_MAX_PAGES)
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, sweettea-kernel@dorminy.me, kernel-team@meta.com
References: <20240905174541.392785-1-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20240905174541.392785-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Joanne,

On 9/5/24 19:45, Joanne Koong wrote:
> Introduce the capability to dynamically configure the fuse max pages
> limit (formerly #defined as FUSE_MAX_MAX_PAGES) through a sysctl.
> This enhancement allows system administrators to adjust the value
> based on system-specific requirements.
> 
> This removes the previous static limit of 256 max pages, which limits
> the max write size of a request to 1 MiB (on 4096 pagesize systems).
> Having the ability to up the max write size beyond 1 MiB allows for the
> perf improvements detailed in this thread [1].

the change itself looks good to me, but have you seen this discussion here?

https://lore.kernel.org/lkml/CAJfpegs10SdtzNXJfj3=vxoAZMhksT5A1u5W5L6nKL-P2UOuLQ@mail.gmail.com/T/


Miklos is basically worried about page pinning and accounting for that
for unprivileged user processes. 


Thanks,
Bernd


> 
> $ sysctl -a | grep max_pages_limit
> fs.fuse.max_pages_limit = 256
> 
> $ sysctl -n fs.fuse.max_pages_limit
> 256
> 
> $ echo 1024 | sudo tee /proc/sys/fs/fuse/max_pages_limit
> 1024
> 
> $ sysctl -n fs.fuse.max_pages_limit
> 1024
> 
> $ echo 65536 | sudo tee /proc/sys/fs/fuse/max_pages_limit
> tee: /proc/sys/fs/fuse/max_pages_limit: Invalid argument
> 
> $ echo 0 | sudo tee /proc/sys/fs/fuse/max_pages_limit
> tee: /proc/sys/fs/fuse/max_pages_limit: Invalid argument
> 
> $ echo 65535 | sudo tee /proc/sys/fs/fuse/max_pages_limit
> 65535
> 
> $ sysctl -n fs.fuse.max_pages_limit
> 65535
> 
> v2 (original):
> https://lore.kernel.org/linux-fsdevel/20240702014627.4068146-1-joannelkoong@gmail.com/
> 
> v1:
> https://lore.kernel.org/linux-fsdevel/20240628001355.243805-1-joannelkoong@gmail.com/
> 
> Changes from v1:
> - Rename fuse_max_max_pages to fuse_max_pages_limit internally
> - Rename /proc/sys/fs/fuse/fuse_max_max_pages to
>   /proc/sys/fs/fuse/max_pages_limit
> - Restrict fuse max_pages_limit sysctl values to between 1 and 65535
>   (inclusive)
> 
> [1] https://lore.kernel.org/linux-fsdevel/20240124070512.52207-1-jefflexu@linux.alibaba.com/T/#u
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  Documentation/admin-guide/sysctl/fs.rst | 10 +++++++
>  fs/fuse/Makefile                        |  2 +-
>  fs/fuse/fuse_i.h                        | 14 +++++++--
>  fs/fuse/inode.c                         | 11 ++++++-
>  fs/fuse/ioctl.c                         |  4 ++-
>  fs/fuse/sysctl.c                        | 40 +++++++++++++++++++++++++
>  6 files changed, 75 insertions(+), 6 deletions(-)
>  create mode 100644 fs/fuse/sysctl.c
> 
> diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
> index 47499a1742bd..fa25d7e718b3 100644
> --- a/Documentation/admin-guide/sysctl/fs.rst
> +++ b/Documentation/admin-guide/sysctl/fs.rst
> @@ -332,3 +332,13 @@ Each "watch" costs roughly 90 bytes on a 32-bit kernel, and roughly 160 bytes
>  on a 64-bit one.
>  The current default value for ``max_user_watches`` is 4% of the
>  available low memory, divided by the "watch" cost in bytes.
> +
> +5. /proc/sys/fs/fuse - Configuration options for FUSE filesystems
> +=====================================================================
> +
> +This directory contains the following configuration options for FUSE
> +filesystems:
> +
> +``/proc/sys/fs/fuse/max_pages_limit`` is a read/write file for
> +setting/getting the maximum number of pages that can be used for servicing
> +requests in FUSE.
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index 6e0228c6d0cb..cd4ef3e08ebf 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -7,7 +7,7 @@ obj-$(CONFIG_FUSE_FS) += fuse.o
>  obj-$(CONFIG_CUSE) += cuse.o
>  obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
>  
> -fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
> +fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o sysctl.o
>  fuse-y += iomode.o
>  fuse-$(CONFIG_FUSE_DAX) += dax.o
>  fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index f23919610313..bb252a3ea37b 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -35,9 +35,6 @@
>  /** Default max number of pages that can be used in a single read request */
>  #define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
>  
> -/** Maximum of max_pages received in init_out */
> -#define FUSE_MAX_MAX_PAGES 256
> -
>  /** Bias for fi->writectr, meaning new writepages must not be sent */
>  #define FUSE_NOWRITE INT_MIN
>  
> @@ -47,6 +44,9 @@
>  /** Number of dentries for each connection in the control filesystem */
>  #define FUSE_CTL_NUM_DENTRIES 5
>  
> +/** Maximum of max_pages received in init_out */
> +extern unsigned int fuse_max_pages_limit;
> +
>  /** List of active connections */
>  extern struct list_head fuse_conn_list;
>  
> @@ -1472,4 +1472,12 @@ ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
>  				      size_t len, unsigned int flags);
>  ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma);
>  
> +#ifdef CONFIG_SYSCTL
> +extern int fuse_sysctl_register(void);
> +extern void fuse_sysctl_unregister(void);
> +#else
> +#define fuse_sysctl_register()		(0)
> +#define fuse_sysctl_unregister()	do { } while (0)
> +#endif /* CONFIG_SYSCTL */
> +
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 99e44ea7d875..973e58df816a 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -35,6 +35,8 @@ DEFINE_MUTEX(fuse_mutex);
>  
>  static int set_global_limit(const char *val, const struct kernel_param *kp);
>  
> +unsigned int fuse_max_pages_limit = 256;
> +
>  unsigned max_user_bgreq;
>  module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
>  		  &max_user_bgreq, 0644);
> @@ -932,7 +934,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
>  	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
>  	fc->user_ns = get_user_ns(user_ns);
>  	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
> -	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
> +	fc->max_pages_limit = fuse_max_pages_limit;
>  
>  	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>  		fuse_backing_files_init(fc);
> @@ -2039,8 +2041,14 @@ static int __init fuse_fs_init(void)
>  	if (err)
>  		goto out3;
>  
> +	err = fuse_sysctl_register();
> +	if (err)
> +		goto out4;
> +
>  	return 0;
>  
> + out4:
> +	unregister_filesystem(&fuse_fs_type);
>   out3:
>  	unregister_fuseblk();
>   out2:
> @@ -2053,6 +2061,7 @@ static void fuse_fs_cleanup(void)
>  {
>  	unregister_filesystem(&fuse_fs_type);
>  	unregister_fuseblk();
> +	fuse_sysctl_unregister();
>  
>  	/*
>  	 * Make sure all delayed rcu free inodes are flushed before we
> diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
> index 572ce8a82ceb..a6c8ee551635 100644
> --- a/fs/fuse/ioctl.c
> +++ b/fs/fuse/ioctl.c
> @@ -10,6 +10,8 @@
>  #include <linux/fileattr.h>
>  #include <linux/fsverity.h>
>  
> +#define FUSE_VERITY_ENABLE_ARG_MAX_PAGES 256
> +
>  static ssize_t fuse_send_ioctl(struct fuse_mount *fm, struct fuse_args *args,
>  			       struct fuse_ioctl_out *outarg)
>  {
> @@ -140,7 +142,7 @@ static int fuse_setup_enable_verity(unsigned long arg, struct iovec *iov,
>  {
>  	struct fsverity_enable_arg enable;
>  	struct fsverity_enable_arg __user *uarg = (void __user *)arg;
> -	const __u32 max_buffer_len = FUSE_MAX_MAX_PAGES * PAGE_SIZE;
> +	const __u32 max_buffer_len = FUSE_VERITY_ENABLE_ARG_MAX_PAGES * PAGE_SIZE;
>  
>  	if (copy_from_user(&enable, uarg, sizeof(enable)))
>  		return -EFAULT;
> diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
> new file mode 100644
> index 000000000000..b272bb333005
> --- /dev/null
> +++ b/fs/fuse/sysctl.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * linux/fs/fuse/fuse_sysctl.c
> + *
> + * Sysctl interface to fuse parameters
> + */
> +#include <linux/sysctl.h>
> +
> +#include "fuse_i.h"
> +
> +static struct ctl_table_header *fuse_table_header;
> +
> +/* Bound by fuse_init_out max_pages, which is a u16 */
> +static unsigned int sysctl_fuse_max_pages_limit = 65535;
> +
> +static struct ctl_table fuse_sysctl_table[] = {
> +	{
> +		.procname	= "max_pages_limit",
> +		.data		= &fuse_max_pages_limit,
> +		.maxlen		= sizeof(fuse_max_pages_limit),
> +		.mode		= 0644,
> +		.proc_handler	= proc_douintvec_minmax,
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= &sysctl_fuse_max_pages_limit,
> +	},
> +};
> +
> +int fuse_sysctl_register(void)
> +{
> +	fuse_table_header = register_sysctl("fs/fuse", fuse_sysctl_table);
> +	if (!fuse_table_header)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +void fuse_sysctl_unregister(void)
> +{
> +	unregister_sysctl_table(fuse_table_header);
> +	fuse_table_header = NULL;
> +}

