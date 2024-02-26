Return-Path: <linux-fsdevel+bounces-12818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B2686773F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 14:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01FD4B24867
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688621292E5;
	Mon, 26 Feb 2024 13:52:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33212126F3B;
	Mon, 26 Feb 2024 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955555; cv=none; b=eV9ugEz4qZ8MQ1dO03cV+Do1O6re7O1AXfV8g93r9HqsAcUiA6YojqTUzhDhIiG+FEl2+wrHah0u+Xyq2p4ZqheGl4/x+ckVCdlio1EFZRPIBSFWHdv92QYotkI9s1ls1R55ulRkmRXEfp8YOjNSNUS0B82i1urgnempgYXBh2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955555; c=relaxed/simple;
	bh=Xsm/8R6Mlt6gOOz8zdM11uszjNbgmxwBzqPat5Py7Xw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oa23mBpzrJrbZO3eE9zpPG9BrbOIGoVVJWb2edX6GgVGG9Qs9rcX34G4DHq4M2oyp2ZwudvIHH36UAPqCCMocx8cFiiurrA1sTExFGhXOaTcLjagzPZyiYC3sJGW+8k2jtv0oKKEVAl2Bw6XY7JF5rrzUOvJjeDea619kwdbR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk24r0YY0z67PcT;
	Mon, 26 Feb 2024 21:48:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BB3CE140A70;
	Mon, 26 Feb 2024 21:52:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 13:52:30 +0000
Date: Mon, 26 Feb 2024 13:52:28 +0000
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
Subject: Re: [RFC PATCH 18/20] famfs: Support character dax via the
 dev_dax_iomap patch
Message-ID: <20240226135228.00007714@Huawei.com>
In-Reply-To: <fa06095b6a05a26a0a016768b2e2b70663163eeb.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
	<fa06095b6a05a26a0a016768b2e2b70663163eeb.1708709155.git.john@groves.net>
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

On Fri, 23 Feb 2024 11:42:02 -0600
John Groves <John@Groves.net> wrote:

> This commit introduces the ability to open a character /dev/dax device
> instead of a block /dev/pmem device. This rests on the dev_dax_iomap
> patches earlier in this series.

Not sure the back reference is needed given it's in the series.

> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/famfs/famfs_inode.c | 97 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 87 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
> index 0d659820e8ff..7d65ac497147 100644
> --- a/fs/famfs/famfs_inode.c
> +++ b/fs/famfs/famfs_inode.c
> @@ -215,6 +215,93 @@ static const struct super_operations famfs_ops = {
>  	.show_options	= famfs_show_options,
>  };
>  
> +/*****************************************************************************/
> +
> +#if defined(CONFIG_DEV_DAX_IOMAP)
> +
> +/*
> + * famfs dax_operations  (for char dax)
> + */
> +static int
> +famfs_dax_notify_failure(struct dax_device *dax_dev, u64 offset,
> +			u64 len, int mf_flags)
> +{
> +	pr_err("%s: offset %lld len %llu flags %x\n", __func__,
> +	       offset, len, mf_flags);
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct dax_holder_operations famfs_dax_holder_ops = {
> +	.notify_failure		= famfs_dax_notify_failure,
> +};
> +
> +/*****************************************************************************/
> +
> +/**
> + * famfs_open_char_device()
> + *
> + * Open a /dev/dax device. This only works in kernels with the dev_dax_iomap patch

That comment you definitely don't need as this won't get merged without
that patch being in place.


> + */
> +static int
> +famfs_open_char_device(
> +	struct super_block *sb,
> +	struct fs_context  *fc)
> +{
> +	struct famfs_fs_info *fsi = sb->s_fs_info;
> +	struct dax_device    *dax_devp;
> +	struct inode         *daxdev_inode;
> +
> +	int rc = 0;
set in all paths where it's used.

> +
> +	pr_notice("%s: Opening character dax device %s\n", __func__, fc->source);

pr_debug

> +
> +	fsi->dax_filp = filp_open(fc->source, O_RDWR, 0);
> +	if (IS_ERR(fsi->dax_filp)) {
> +		pr_err("%s: failed to open dax device %s\n",
> +		       __func__, fc->source);
> +		fsi->dax_filp = NULL;
Better to use a local variable

	fp = filp_open(fc->source, O_RDWR, 0);
	if (IS_ERR(fp)) {
		pr_err.
		return;
	}
	fsi->dax_filp = fp;
or similar.

> +		return PTR_ERR(fsi->dax_filp);
> +	}
> +
> +	daxdev_inode = file_inode(fsi->dax_filp);
> +	dax_devp     = inode_dax(daxdev_inode);
> +	if (IS_ERR(dax_devp)) {
> +		pr_err("%s: unable to get daxdev from inode for %s\n",
> +		       __func__, fc->source);
> +		rc = -ENODEV;
> +		goto char_err;
> +	}
> +
> +	rc = fs_dax_get(dax_devp, fsi, &famfs_dax_holder_ops);
> +	if (rc) {
> +		pr_info("%s: err attaching famfs_dax_holder_ops\n", __func__);
> +		goto char_err;
> +	}
> +
> +	fsi->bdev_handle = NULL;
> +	fsi->dax_devp = dax_devp;
> +
> +	return 0;
> +
> +char_err:
> +	filp_close(fsi->dax_filp, NULL);

You carefully set fsi->dax_filp to null in other other error paths.
Why there and not here?

> +	return rc;
> +}
> +
> +#else /* CONFIG_DEV_DAX_IOMAP */
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
> +
> +#endif /* CONFIG_DEV_DAX_IOMAP */
> +
>  /***************************************************************************************
>   * dax_holder_operations for block dax
>   */
> @@ -236,16 +323,6 @@ const struct dax_holder_operations famfs_blk_dax_holder_ops = {
>  	.notify_failure		= famfs_blk_dax_notify_failure,
>  };
>  

Put it in right place earlier! Makes this less noisy.

> -static int
> -famfs_open_char_device(
> -	struct super_block *sb,
> -	struct fs_context  *fc)
> -{
> -	pr_err("%s: Root device is %s, but your kernel does not support famfs on /dev/dax\n",
> -	       __func__, fc->source);
> -	return -ENODEV;
> -}
> -
>  /**
>   * famfs_open_device()
>   *


