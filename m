Return-Path: <linux-fsdevel+bounces-12805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D898675C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D381C247AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5536D84FD1;
	Mon, 26 Feb 2024 12:56:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB2A81756;
	Mon, 26 Feb 2024 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952208; cv=none; b=AVmGHMpfDRNJJXKAPACV3iplJn3JK/SRAhSwo0RCkYEmWlmYb9uNATaDi16Spv0Nbgqu/vEKfrh5G+D7dbEoCsB9fZsXlIowNTvP/ZC6atIeKT7ukl224qDz4UaCla8MjUJCBOhFgxICB4Bhy3HWRt4aJTCvnZoQz1cMUeicXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952208; c=relaxed/simple;
	bh=NC9zbuoZghbczDmZXWcpM9NU9mKbcnjtKFhuyF8fuZs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmlU2Y5svXNQP2I1mmdauHhBrlOMRxZwf4b/qSDRV5vSTFMobtAggOGhjwUEYUO3ghjJbVg6k519nQPU2cYQBvW7/xSLrSY9VtN4b8MH3Y+xJO1zFwl1hztsuEqHzLeZNLaHchOGYV3w7YwqTRutHB6wYfpVWhqlLZLgxs8nSGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk0s85lMRz6K9JP;
	Mon, 26 Feb 2024 20:53:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F41F9140FB6;
	Mon, 26 Feb 2024 20:56:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 12:56:43 +0000
Date: Mon, 26 Feb 2024 12:56:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: John Groves <John@Groves.net>
CC: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, "Dan
 Williams" <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <john@jagalactic.com>, Dave Chinner
	<david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>,
	<dave.hansen@linux.intel.com>, <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 10/20] famfs: famfs_open_device() &
 dax_holder_operations
Message-ID: <20240226125642.000076d2@Huawei.com>
In-Reply-To: <74359fdc83688fb1aac1cb2c336fbd725590a131.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
	<74359fdc83688fb1aac1cb2c336fbd725590a131.1708709155.git.john@groves.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 11:41:54 -0600
John Groves <John@Groves.net> wrote:

> Famfs works on both /dev/pmem and /dev/dax devices. This commit introduces
> the function that opens a block (pmem) device and the struct
> dax_holder_operations that are needed for that ABI.
> 
> In this commit, support for opening character /dev/dax is stubbed. A
> later commit introduces this capability.
> 
> Signed-off-by: John Groves <john@groves.net>

Formatting comments mostly same as previous patches, so I'll stop repeating them.

> ---
>  fs/famfs/famfs_inode.c | 83 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
> index 3329aff000d1..82c861998093 100644
> --- a/fs/famfs/famfs_inode.c
> +++ b/fs/famfs/famfs_inode.c
> @@ -68,5 +68,88 @@ static const struct super_operations famfs_ops = {
>  	.show_options	= famfs_show_options,
>  };
>  
> +/***************************************************************************************
> + * dax_holder_operations for block dax
> + */
> +
> +static int
> +famfs_blk_dax_notify_failure(
> +	struct dax_device	*dax_devp,
> +	u64			offset,
> +	u64			len,
> +	int			mf_flags)
> +{
> +
> +	pr_err("%s: dax_devp %llx offset %llx len %lld mf_flags %x\n",
> +	       __func__, (u64)dax_devp, (u64)offset, (u64)len, mf_flags);
> +	return -EOPNOTSUPP;
> +}
> +
> +const struct dax_holder_operations famfs_blk_dax_holder_ops = {
> +	.notify_failure		= famfs_blk_dax_notify_failure,
> +};
> +
> +static int
> +famfs_open_char_device(
> +	struct super_block *sb,
> +	struct fs_context  *fc)
> +{
> +	pr_err("%s: Root device is %s, but your kernel does not support famfs on /dev/dax\n",
> +	       __func__, fc->source);
> +	return -ENODEV;
> +}
> +
> +/**
> + * famfs_open_device()
> + *
> + * Open the memory device. If it looks like /dev/dax, call famfs_open_char_device().
> + * Otherwise try to open it as a block/pmem device.
> + */
> +static int
> +famfs_open_device(
> +	struct super_block *sb,
> +	struct fs_context  *fc)
> +{
> +	struct famfs_fs_info *fsi = sb->s_fs_info;
> +	struct dax_device    *dax_devp;
> +	u64 start_off = 0;
> +	struct bdev_handle   *handlep;
Definitely don't force alignment in local parameter definitions.
Always goes wrong and makes for unreadable mess in patches!

> +
> +	if (fsi->dax_devp) {
> +		pr_err("%s: already mounted\n", __func__);
Fine to fail but worth a error message? Not sure on convention on this but seems noisy
and maybe in userspace control which isn't good.
> +		return -EALREADY;
> +	}
> +
> +	if (strstr(fc->source, "/dev/dax")) /* There is probably a better way to check this */
> +		return famfs_open_char_device(sb, fc);
> +
> +	if (!strstr(fc->source, "/dev/pmem")) { /* There is probably a better way to check this */
> +		pr_err("%s: primary backing dev (%s) is not pmem\n",
> +		       __func__, fc->source);
> +		return -EINVAL;
> +	}
> +
> +	handlep = bdev_open_by_path(fc->source, FAMFS_BLKDEV_MODE, fsi, &fs_holder_ops);
> +	if (IS_ERR(handlep->bdev)) {
> +		pr_err("%s: failed blkdev_get_by_path(%s)\n", __func__, fc->source);
> +		return PTR_ERR(handlep->bdev);
> +	}
> +
> +	dax_devp = fs_dax_get_by_bdev(handlep->bdev, &start_off,
> +				      fsi  /* holder */,
> +				      &famfs_blk_dax_holder_ops);
> +	if (IS_ERR(dax_devp)) {
> +		pr_err("%s: unable to get daxdev from handlep->bdev\n", __func__);
> +		bdev_release(handlep);
> +		return -ENODEV;
> +	}
> +	fsi->bdev_handle = handlep;
> +	fsi->dax_devp    = dax_devp;
> +
> +	pr_notice("%s: root device is block dax (%s)\n", __func__, fc->source);

pr_debug()  Kernel log is too noisy anyway! + I'd assume we can tell this succeeded
in lots of other ways.


> +	return 0;
> +}
> +
> +
>  
>  MODULE_LICENSE("GPL");


