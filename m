Return-Path: <linux-fsdevel+bounces-25818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B90950DEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 22:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BA71C224B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 20:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58051A4F3F;
	Tue, 13 Aug 2024 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="rLVL5M9l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hPlZL8QT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8182C1A4F30
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580909; cv=none; b=Hnf4BnUx1VTdNB3NWcMh18qBpadH/fH+FClj3ob8/XCkJ8TEWF0g7mfdukmr+1BPkbPvAN1HPZdnDWCgVd/cEbl+3eZpgOgeUi1bUikTxHVmKDnwSE0AlGg/EXiWcnb2VA7QD9X/oiVf3m0/LJylJLKb8++MBdpTdwED9wtC+24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580909; c=relaxed/simple;
	bh=+cSMn8G2OlwDEqmQ+f+GJN4qBlh+aEPck/xsKhgMI0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNBhdAAPTkdJgSI2268DZ59nsri6S3SLxYpOrYOLcOFz5iw95FF08Fx7U8JUKECUiktiBhgOwD4Wk5g84zHrfmVzcWBYrgRaGuPfv+1c9YtUb/PLHM1xt7u5fYICgSEPKN75VB/VYDd73d9vpZq8aaTzoLfsFVCiQTZNmBe3xPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=rLVL5M9l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hPlZL8QT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 93F55138FCE0;
	Tue, 13 Aug 2024 16:28:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Aug 2024 16:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723580906;
	 x=1723667306; bh=qtxd/O5Hg3vp+AG/m39+QciMpHUaP8Hc8Q3LitaQ7TY=; b=
	rLVL5M9lpOC6wL8FAgvAmeuKT9LVNVRKY1hTn3KIlylbXmKomUqvfJXQLcGOnXG5
	332wTVuuW8E47ZrB8u5KfK6R5zqY8Ramm2+Tx51D/cNPGN8p1VolsRo3KEDuMmpZ
	ZI3ABgV7DT5Rcyk9B3bmOax9QgYLWhMuQdo2UYb6xRTrM+qLE3HJ2dlPXRU76TKK
	UwWIxCdvSBjijJStpLu8akCVwZKao2srGLtEt1I8tlzCFNFsoCB56W2edHAgz2rI
	ja1/EbuOksFu5DBNgzqThxIysJrqefmkr7oCESAlBe/MWpoQxv3MmsyvE+dTyAyL
	3sdrpESrbjD9OOSDi62w1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723580906; x=
	1723667306; bh=qtxd/O5Hg3vp+AG/m39+QciMpHUaP8Hc8Q3LitaQ7TY=; b=h
	PlZL8QTivKqSD8Sj2SEvl7DmmI11vIMJlQJ5FVUQhUgAljdMDiX/m1Bizq3Ca1za
	fKTffzpD3tJv2rDG3pxovi4Cdqd8xV08tYaPiQ7824mMgwZcnj99SYkIeJXFZ4Bo
	3bOVgcLLV+jUPzCEZeWs1fjjXRwpyEWU8E9Fy2YNYUZBl6d8H4eRSnghxuESYNUM
	dX6/hNFmCZrpk5qn8nwYeeflO5XfKn7aiLItzeHJOFS0DO8bW6w9+Bvui8OOV1BD
	tDhUFSaJF+TF01kaDC8wwuip4XhtNdvZFxwTjkTIcE1WSciJG1zaxvxDf8i+Gz0w
	E98sXPGgl7en9OlGD4v7w==
X-ME-Sender: <xms:6cG7ZlY9U51N1FmCOMprDQLT_64dMHfFmX69iDi8eGWi6WGNsACazQ>
    <xme:6cG7ZsZ9yiz2H5zCy_W0u1eHvaaLzg2FweOPD-45v8zdQmdzzAKU0iSSYu5meHN83
    FGbCkSgVJZox_Rq>
X-ME-Received: <xmr:6cG7Zn_JH51_Gtxjj2iJAONL4OqOKlpMCwJfLbvr_ByBaP5ivBqNyUSqPwnorIwMaT7yiYP7crDrgzAErVbUXplwGbrDJIdY4ktCyKo_J_Cyh03-ROP6uyBmrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    shgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtohepjhgvfhhflhgvgihuse
    hlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhgrohgrrhdrshhhrgho
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrd
    gtohhm
X-ME-Proxy: <xmx:6cG7ZjpRiJ0WsQMZ0qIw31AjFUPT-JX_56qEReV4axLg9TFR1NgclQ>
    <xmx:6cG7Zgp2wPUObxVWIDrf7veHq9S-X3WEyL85z6a81qZnUwucZ26IQg>
    <xmx:6cG7ZpTaHYskHEe3AdBQG6rJoVL-0UPBEMx4YT8R2Uy3CjHRMc9diQ>
    <xmx:6cG7ZoqaJFkzlQf348w9pW6UH8aBhQJkFJ30TPtqoio_nzIROgmYdw>
    <xmx:6sG7ZoIFhyRgZ163JlD2EpPGvWw7XkZNvopCTlMivaipvyMsrZDq4iuI>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 16:28:24 -0400 (EDT)
Message-ID: <24779f80-acce-4f03-9f28-d6b3f629fee8@fastmail.fm>
Date: Tue, 13 Aug 2024 22:28:22 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, jefflexu@linux.alibaba.com, laoar.shao@gmail.com,
 kernel-team@meta.com
References: <20240808190110.3188039-1-joannelkoong@gmail.com>
 <20240808190110.3188039-3-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, fr, ru
In-Reply-To: <20240808190110.3188039-3-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/8/24 21:01, Joanne Koong wrote:
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
> index 2b616c5977b4..571fa36155da 100644
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

LGTM

Reviewed-by: Bernd Schubert <bschubert@ddn.com>


