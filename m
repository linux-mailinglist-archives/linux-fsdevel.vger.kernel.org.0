Return-Path: <linux-fsdevel+bounces-26662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A7295AE6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E4BBB22567
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 07:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8040E1531DD;
	Thu, 22 Aug 2024 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j51Q6zZ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A212E3EE
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310391; cv=none; b=HIdy6iz8s/0P2ZwIk/n5g49SVwXRDK2wlYZLIYCYw7hQHJO/8PX1x++RmYaswyVQWpjp217/nzkEd8Aer4PBxwOkd2LIB0KBXdGbexTZ5c4LHTTM2BXmQ1VSMdCp+Rgfmb9d6P48YfV0120YJFaBcZ43tLIhtHVEPa0M2/Ftr8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310391; c=relaxed/simple;
	bh=GLveJU2NJj52a2mB3XNiIrf7RkmQ5mX9+7HBG0D1V4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roPrCWv2KSyCMlr09amiQczrAWxaT/8JF2CNqmMWqwdEovq7HfXBTHCMtpddMAJZAB0q6EKC/AXBhELSFTeMS/sVWUWa+T3g2qA5dzdTuRfbZWM9DQ4fbKNB/v/6WxN28cfByK28EsRndOm8zHcXttImJNLmqZ+1EdI3wPLoWPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j51Q6zZ4; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724310385; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=i46Bih46CpKJl7ggLzneShePQL2QTTIe7w/2cEjCuXM=;
	b=j51Q6zZ43lFb0NAO3h85dCVAW1kR+D8OU8UmRj6tjQ14IEo/9zfGDZHAp2AYnywqOyw2zJjwxk7TuX8LkhOP9mUBz52p506nDaWGCRt1zRkuHO0LJdCUcmM5ZiwlKcC3wGANpY4P2ZoRJrpnvvYRwmXI29wFjk8miZzwW802AFI=
Received: from 30.221.144.204(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WDOEh5W_1724310384)
          by smtp.aliyun-inc.com;
          Thu, 22 Aug 2024 15:06:24 +0800
Message-ID: <2cd21f0b-e3db-4a6f-8a5e-8da4991985e8@linux.alibaba.com>
Date: Thu, 22 Aug 2024 15:06:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, laoar.shao@gmail.com,
 kernel-team@meta.com, Bernd Schubert <bschubert@ddn.com>
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
 <20240813232241.2369855-3-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240813232241.2369855-3-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/24 7:22 AM, Joanne Koong wrote:
> Introduce two new sysctls, "default_request_timeout" and
> "max_request_timeout". These control timeouts on replies by the
> server to kernel-issued fuse requests.
> 
> "default_request_timeout" sets a timeout if no timeout is specified by
> the fuse server on mount. 0 (default) indicates no timeout should be enforced.
> 
> "max_request_timeout" sets a maximum timeout for fuse requests. If the
> fuse server attempts to set a timeout greater than max_request_timeout,
> the system will default to max_request_timeout. Similarly, if the max
> default timeout is greater than the max request timeout, the system will
> default to the max request timeout. 0 (default) indicates no timeout should
> be enforced.
> 
> $ sysctl -a | grep fuse
> fs.fuse.default_request_timeout = 0
> fs.fuse.max_request_timeout = 0
> 
> $ echo 0x100000000 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
> 
> $ echo 0xFFFFFFFF | sudo tee /proc/sys/fs/fuse/default_request_timeout
> 0xFFFFFFFF
> 
> $ sysctl -a | grep fuse
> fs.fuse.default_request_timeout = 4294967295
> fs.fuse.max_request_timeout = 0
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  Documentation/admin-guide/sysctl/fs.rst | 17 ++++++++++
>  fs/fuse/Makefile                        |  2 +-
>  fs/fuse/fuse_i.h                        | 16 ++++++++++
>  fs/fuse/inode.c                         | 19 ++++++++++-
>  fs/fuse/sysctl.c                        | 42 +++++++++++++++++++++++++
>  5 files changed, 94 insertions(+), 2 deletions(-)
>  create mode 100644 fs/fuse/sysctl.c
> 
> diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
> index 47499a1742bd..44fd495f69b4 100644
> --- a/Documentation/admin-guide/sysctl/fs.rst
> +++ b/Documentation/admin-guide/sysctl/fs.rst
> @@ -332,3 +332,20 @@ Each "watch" costs roughly 90 bytes on a 32-bit kernel, and roughly 160 bytes
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
> +``/proc/sys/fs/fuse/default_request_timeout`` is a read/write file for
> +setting/getting the default timeout (in seconds) for a fuse server to
> +reply to a kernel-issued request in the event where the server did not
> +specify a timeout at mount. 0 indicates no timeout.
> +
> +``/proc/sys/fs/fuse/max_request_timeout`` is a read/write file for
> +setting/getting the maximum timeout (in seconds) for a fuse server to
> +reply to a kernel-issued request. If the server attempts to set a
> +timeout greater than max_request_timeout, the system will use
> +max_request_timeout as the timeout. 0 indicates no timeout.

"0 indicates no timeout"

I think 0 max_request_timeout shall indicate that there's no explicit
maximum limitation for request_timeout.


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
> index 0a2fa487a3bf..dae9977fa050 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -47,6 +47,14 @@
>  /** Number of dentries for each connection in the control filesystem */
>  #define FUSE_CTL_NUM_DENTRIES 5
>  
> +/*
> + * Default timeout (in seconds) for the server to reply to a request
> + * if no timeout was specified on mount
> + */
> +extern u32 fuse_default_req_timeout;
> +/** Max timeout (in seconds) for the server to reply to a request */
> +extern u32 fuse_max_req_timeout;
> +
>  /** List of active connections */
>  extern struct list_head fuse_conn_list;
>  
> @@ -1486,4 +1494,12 @@ ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
>  				      size_t len, unsigned int flags);
>  ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma);
>  
> +#ifdef CONFIG_SYSCTL
> +int fuse_sysctl_register(void);
> +void fuse_sysctl_unregister(void);
> +#else
> +static inline int fuse_sysctl_register(void) { return 0; }
> +static inline void fuse_sysctl_unregister(void) { return; }
> +#endif /* CONFIG_SYSCTL */
> +
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 9e69006fc026..cf333448f2d3 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -35,6 +35,10 @@ DEFINE_MUTEX(fuse_mutex);
>  
>  static int set_global_limit(const char *val, const struct kernel_param *kp);
>  
> +/* default is no timeout */
> +u32 fuse_default_req_timeout = 0;
> +u32 fuse_max_req_timeout = 0;
> +
>  unsigned max_user_bgreq;
>  module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
>  		  &max_user_bgreq, 0644);
> @@ -1678,6 +1682,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	struct fuse_conn *fc = fm->fc;
>  	struct inode *root;
>  	struct dentry *root_dentry;
> +	u32 req_timeout;
>  	int err;
>  
>  	err = -EINVAL;
> @@ -1730,10 +1735,16 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	fc->group_id = ctx->group_id;
>  	fc->legacy_opts_show = ctx->legacy_opts_show;
>  	fc->max_read = max_t(unsigned int, 4096, ctx->max_read);
> -	fc->req_timeout = ctx->req_timeout * HZ;
>  	fc->destroy = ctx->destroy;
>  	fc->no_control = ctx->no_control;
>  	fc->no_force_umount = ctx->no_force_umount;
> +	req_timeout = ctx->req_timeout ?: fuse_default_req_timeout;
> +	if (!fuse_max_req_timeout)
> +		fc->req_timeout = req_timeout * HZ;
> +	else if (!req_timeout)
> +		fc->req_timeout = fuse_max_req_timeout * HZ;

So if fuse_max_req_timeout is non-zero and req_timeout is zero (either
because of 0 fuse_default_req_timeout, or explicit "-o request_timeout =
0" mount option), the final request timeout is exactly
fuse_max_req_timeout, which is unexpected as I think 0
fuse_default_req_timeout, or "-o request_timeout=0" shall indicate no
timeout.

> +	else
> +		fc->req_timeout = min(req_timeout, fuse_max_req_timeout) * HZ;
>  
>  	err = -ENOMEM;
>  	root = fuse_get_root_inode(sb, ctx->rootmode);
> @@ -2046,8 +2057,14 @@ static int __init fuse_fs_init(void)
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
> diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
> new file mode 100644
> index 000000000000..c87bb0ecbfa9
> --- /dev/null
> +++ b/fs/fuse/sysctl.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> +* linux/fs/fuse/fuse_sysctl.c
> +*
> +* Sysctl interface to fuse parameters
> +*/
> +#include <linux/sysctl.h>
> +
> +#include "fuse_i.h"
> +
> +static struct ctl_table_header *fuse_table_header;
> +
> +static struct ctl_table fuse_sysctl_table[] = {
> +	{
> +		.procname	= "default_request_timeout",
> +		.data		= &fuse_default_req_timeout,
> +		.maxlen		= sizeof(fuse_default_req_timeout),
> +		.mode		= 0644,
> +		.proc_handler	= proc_douintvec,
> +	},
> +	{
> +		.procname	= "max_request_timeout",
> +		.data		= &fuse_max_req_timeout,
> +		.maxlen		= sizeof(fuse_max_req_timeout),
> +		.mode		= 0644,
> +		.proc_handler	= proc_douintvec,
> +	},

Missing "{}" here?  The internal implementation of register_sysctl()
depends on an empty last element of the array as the sentinel.

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

-- 
Thanks,
Jingbo

