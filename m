Return-Path: <linux-fsdevel+bounces-12397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C67E285ED5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 00:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D069B21D51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 23:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1ED12C802;
	Wed, 21 Feb 2024 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="JHjUbj8x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C9EycoJr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534BAA35
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559308; cv=none; b=sv/HMKKbplGbJbSVhmwnXi5duH0k9dLDcd8F1ngAy25qaW6qtbS3Z6m5D+GQ4CXvuxqbwrZ6Bz11yyt3Wr5MNtlmNyxlY/boU/PzvPsnjV+73zsfHar32sCqdSFD9+3GsiJHEzRxJjuc/7wIjrWxOult4lcNM9tjgKHf56KLq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559308; c=relaxed/simple;
	bh=0tO+2Ld+AS3h4b/shAYfoCBnYOnGPctpuWep6gmzmic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxleN3yMBQhwmG4FZQLsNToEb1fyljJl5zafZT/GIHnDAzv04tubnSQkyyWEfWEtpstsUqHXjt/9XuRgWpwuJbA9J7IRvLApWF1o+x8xaDAxAOdzd0Al18Ht7f9XgK+Jrcul+2XYfL1UrZiVoKrgPtDHqgv/u3um+/CqdtIxm+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=JHjUbj8x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C9EycoJr; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id E740E3200B36;
	Wed, 21 Feb 2024 18:48:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 21 Feb 2024 18:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708559303;
	 x=1708645703; bh=KzG5RHyHAxqqbL5cy3CC9mfUP+0W7mDbbj7xVmk4J8w=; b=
	JHjUbj8xqdsKMohAGZSVSGoVoIrEOWb0MSaBtCq0bTr2O1jdeCLpLjs4rSixzi8c
	LbR76c0UoCnyuhf18L6KazCq9Wcj3IAfHaBOMTC1ZCL+KgQxta0dv5guSefgsjDU
	xiUDoQ6lCLmJ5VNGgn2mfT76tguOV9YWZqafmFJgp1xMTnslkvPiIq3uMKl0LAi5
	/M5qALysaJ9azJCDTSmyOOV5Z/X4+ydUa72PrcHM7cZbG1rIxACgQMtKU1fmHYX5
	4tRZJt2Tko/hTqRP6itBLRxlF6lBNNRBR3nEnbrleBxafuCCvD/igbb5PnAWvliY
	JrSURyh+u4IPdjWO1PGgVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708559303; x=
	1708645703; bh=KzG5RHyHAxqqbL5cy3CC9mfUP+0W7mDbbj7xVmk4J8w=; b=C
	9EycoJrMSICvfw/yawVtkV3xK4Ep1RMO92VpMPuDez56L09RZ+b7lUE40+elBDOd
	R4xJLPwzlZqhTfMWJ+bE3fzVunFGWJiTVZNH1+zUBa4iBBLjPZbXYzGf3wMBDCpw
	anNDxW04MW/zF3HuGBksPbo5aW1FtHWFyaxWoSippcnc+zlqffBgRpBWvoYG8Pkq
	cg/wAy9xiq3WiVAHNU3Gw4GhbCv3WvktCuY1argSZXdZvPi9cJamm8+zb7MU8O3W
	fCSfRfSiTrnqWEum+KqxcsIA2Yc6sWKGK8NiVtFUuqO5aSNsyHin65uZHrcaL5/C
	cYMyKiQtKsyw+aOiySKiQ==
X-ME-Sender: <xms:x4vWZYC7PIVfm9CiFOP71xjUpTSOi8yiDYew0FsezGMfkIotkwnHPQ>
    <xme:x4vWZajxRm2UKtFcODmS6Gvh8G8tIWhip26fNUJnHy5tBAF3naa5mzb6Zg5NT3erS
    2SXo0j_5y9R>
X-ME-Received: <xmr:x4vWZbkskrLERZwoj189oSK5C1iArHKHTaIIz0sWMTUuZBjMjtA_gvzq4808zeYT9U4iQuil_jCw1XTmxtTlMt5Zyu4ft_IwAIsNo-3DwGQPVoEytihXWCd8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eigffgveffvdejtdetuddtfeehhefgjeeiudeuffevleeufeefueffudffvdekveenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:x4vWZeys2knmtXzUZxQhl_AxmpAwDKyeUCSM9fLq_06XEtgFOFcWdA>
    <xmx:x4vWZdRsSzcQZx2qjUCc1qCref3BDRYGn32riU9tR4pj4MK8zUPYpg>
    <xmx:x4vWZZZqOvvf0IEGHvbisKN5mknCCuQi0AWmrt-dkSvKgGzt2SV98A>
    <xmx:x4vWZfdMESKc2ZETCn4T2_ST96oQJ91Tc6bFTyOlf9wDLp3shsjVZA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 18:48:20 -0500 (EST)
Message-ID: <8c576360-692d-4395-8877-4444674c31e6@themaw.net>
Date: Thu, 22 Feb 2024 07:48:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] Convert coda to use the new mount API
Content-Language: en-US
To: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
 Bill O'Donnell <billodo@redhat.com>, Christian Brauner <brauner@kernel.org>
References: <2d1374cc-6b52-49ff-97d5-670709f54eae@redhat.com>
 <97650eeb-94c7-4041-b58c-90e81e76b699@redhat.com>
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <97650eeb-94c7-4041-b58c-90e81e76b699@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/2/24 23:40, Eric Sandeen wrote:
> From: David Howells <dhowells@redhat.com>
>
> Convert the coda filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
>
> See Documentation/filesystems/mount_api.rst for more information.
>
> Note this is slightly tricky as coda currently only has a binary mount data
> interface.  This is handled through the parse_monolithic hook.
>
> Also add a more conventional interface with a parameter named "fd" that
> takes an fd that refers to a coda psdev, thereby specifying the index to
> use.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Co-developed-by: Eric Sandeen <sandeen@redhat.com>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> [sandeen: forward port to current upstream mount API interfaces]
> Tested-by: Jan Harkes <jaharkes@cs.cmu.edu>
> cc: coda@cs.cmu.edu
> ---
>
> V2: Remove extra task_active_pid_ns check from fill_super() that I missed
> (note that Jan did not test with this change)
>
> NB: This updated patch is based on
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=mount-api-viro&id=4aec2ba3ca543e39944604774b8cab9c4d592651
>
> hence the From: David above.
>
>   fs/coda/inode.c | 143 +++++++++++++++++++++++++++++++++---------------
>   1 file changed, 98 insertions(+), 45 deletions(-)
>
> diff --git a/fs/coda/inode.c b/fs/coda/inode.c
> index 0c7c2528791e..a50356c541f6 100644
> --- a/fs/coda/inode.c
> +++ b/fs/coda/inode.c
> @@ -24,6 +24,8 @@
>   #include <linux/pid_namespace.h>
>   #include <linux/uaccess.h>
>   #include <linux/fs.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>   #include <linux/vmalloc.h>
>   
>   #include <linux/coda.h>
> @@ -87,10 +89,10 @@ void coda_destroy_inodecache(void)
>   	kmem_cache_destroy(coda_inode_cachep);
>   }
>   
> -static int coda_remount(struct super_block *sb, int *flags, char *data)
> +static int coda_reconfigure(struct fs_context *fc)
>   {
> -	sync_filesystem(sb);
> -	*flags |= SB_NOATIME;
> +	sync_filesystem(fc->root->d_sb);
> +	fc->sb_flags |= SB_NOATIME;
>   	return 0;
>   }
>   
> @@ -102,78 +104,102 @@ static const struct super_operations coda_super_operations =
>   	.evict_inode	= coda_evict_inode,
>   	.put_super	= coda_put_super,
>   	.statfs		= coda_statfs,
> -	.remount_fs	= coda_remount,
>   };
>   
> -static int get_device_index(struct coda_mount_data *data)
> +struct coda_fs_context {
> +	int	idx;
> +};
> +
> +enum {
> +	Opt_fd,
> +};
> +
> +static const struct fs_parameter_spec coda_param_specs[] = {
> +	fsparam_fd	("fd",	Opt_fd),
> +	{}
> +};
> +
> +static int coda_parse_fd(struct fs_context *fc, int fd)
>   {
> +	struct coda_fs_context *ctx = fc->fs_private;
>   	struct fd f;
>   	struct inode *inode;
>   	int idx;
>   
> -	if (data == NULL) {
> -		pr_warn("%s: Bad mount data\n", __func__);
> -		return -1;
> -	}
> -
> -	if (data->version != CODA_MOUNT_VERSION) {
> -		pr_warn("%s: Bad mount version\n", __func__);
> -		return -1;
> -	}
> -
> -	f = fdget(data->fd);
> +	f = fdget(fd);
>   	if (!f.file)
> -		goto Ebadf;
> +		return -EBADF;
>   	inode = file_inode(f.file);
>   	if (!S_ISCHR(inode->i_mode) || imajor(inode) != CODA_PSDEV_MAJOR) {
>   		fdput(f);
> -		goto Ebadf;
> +		return invalf(fc, "code: Not coda psdev");
>   	}
>   
>   	idx = iminor(inode);
>   	fdput(f);
>   
> -	if (idx < 0 || idx >= MAX_CODADEVS) {
> -		pr_warn("%s: Bad minor number\n", __func__);
> -		return -1;
> +	if (idx < 0 || idx >= MAX_CODADEVS)
> +		return invalf(fc, "coda: Bad minor number");
> +	ctx->idx = idx;
> +	return 0;
> +}
> +
> +static int coda_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	struct fs_parse_result result;
> +	int opt;
> +
> +	opt = fs_parse(fc, coda_param_specs, param, &result);
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case Opt_fd:
> +		return coda_parse_fd(fc, result.uint_32);
>   	}
>   
> -	return idx;
> -Ebadf:
> -	pr_warn("%s: Bad file\n", __func__);
> -	return -1;
> +	return 0;
> +}
> +
> +/*
> + * Parse coda's binary mount data form.  We ignore any errors and go with index
> + * 0 if we get one for backward compatibility.
> + */
> +static int coda_parse_monolithic(struct fs_context *fc, void *_data)
> +{
> +	struct coda_mount_data *data = _data;
> +
> +	if (!data)
> +		return invalf(fc, "coda: Bad mount data");
> +
> +	if (data->version != CODA_MOUNT_VERSION)
> +		return invalf(fc, "coda: Bad mount version");
> +
> +	coda_parse_fd(fc, data->fd);
> +	return 0;
>   }
>   
> -static int coda_fill_super(struct super_block *sb, void *data, int silent)
> +static int coda_fill_super(struct super_block *sb, struct fs_context *fc)
>   {
> +	struct coda_fs_context *ctx = fc->fs_private;
>   	struct inode *root = NULL;
>   	struct venus_comm *vc;
>   	struct CodaFid fid;
>   	int error;
> -	int idx;
> -
> -	if (task_active_pid_ns(current) != &init_pid_ns)
> -		return -EINVAL;
> -
> -	idx = get_device_index((struct coda_mount_data *) data);
>   
> -	/* Ignore errors in data, for backward compatibility */
> -	if(idx == -1)
> -		idx = 0;
> -	
> -	pr_info("%s: device index: %i\n", __func__,  idx);
> +	infof(fc, "coda: device index: %i\n", ctx->idx);
>   
> -	vc = &coda_comms[idx];
> +	vc = &coda_comms[ctx->idx];
>   	mutex_lock(&vc->vc_mutex);
>   
>   	if (!vc->vc_inuse) {
> -		pr_warn("%s: No pseudo device\n", __func__);
> +		errorf(fc, "coda: No pseudo device");
>   		error = -EINVAL;
>   		goto unlock_out;
>   	}
>   
>   	if (vc->vc_sb) {
> -		pr_warn("%s: Device already mounted\n", __func__);
> +		errorf(fc, "coda: Device already mounted");
>   		error = -EBUSY;
>   		goto unlock_out;
>   	}
> @@ -313,18 +339,45 @@ static int coda_statfs(struct dentry *dentry, struct kstatfs *buf)
>   	return 0;
>   }
>   
> -/* init_coda: used by filesystems.c to register coda */
> +static int coda_get_tree(struct fs_context *fc)
> +{
> +	if (task_active_pid_ns(current) != &init_pid_ns)
> +		return -EINVAL;
>   
> -static struct dentry *coda_mount(struct file_system_type *fs_type,
> -	int flags, const char *dev_name, void *data)
> +	return get_tree_nodev(fc, coda_fill_super);
> +}
> +
> +static void coda_free_fc(struct fs_context *fc)
>   {
> -	return mount_nodev(fs_type, flags, data, coda_fill_super);
> +	kfree(fc->fs_private);
> +}
> +
> +static const struct fs_context_operations coda_context_ops = {
> +	.free		= coda_free_fc,
> +	.parse_param	= coda_parse_param,
> +	.parse_monolithic = coda_parse_monolithic,
> +	.get_tree	= coda_get_tree,
> +	.reconfigure	= coda_reconfigure,
> +};
> +
> +static int coda_init_fs_context(struct fs_context *fc)
> +{
> +	struct coda_fs_context *ctx;
> +
> +	ctx = kzalloc(sizeof(struct coda_fs_context), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	fc->fs_private = ctx;
> +	fc->ops = &coda_context_ops;
> +	return 0;
>   }
>   
>   struct file_system_type coda_fs_type = {
>   	.owner		= THIS_MODULE,
>   	.name		= "coda",
> -	.mount		= coda_mount,
> +	.init_fs_context = coda_init_fs_context,
> +	.parameters	= coda_param_specs,
>   	.kill_sb	= kill_anon_super,
>   	.fs_flags	= FS_BINARY_MOUNTDATA,
>   };


Looks good to me.

Reviewed-by: Ian Kent <raven@themaw.net>


