Return-Path: <linux-fsdevel+bounces-12955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06C7869319
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 14:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904D81F2101A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 13:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD431419A6;
	Tue, 27 Feb 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOlo8Z/R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1D513AA4C;
	Tue, 27 Feb 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041300; cv=none; b=omMQyGXnVUD+KsfWpE5O20ZYKGyzQ6bt1usE3Hcww/owHpdF3EmIh9KtfEYfWCszSMfmd0fQ314L+IU3LIv4OU5OTGrridjoUuuDPhA5zqvR/bDGryrR+vLGnvq6v57vlULQJjOMg8QrUAPuZ73z1jiaN0MVIi+wtZorlTwMxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041300; c=relaxed/simple;
	bh=ZeSUM3z3GiUVvHCrkzq+QtV/032258+nd5zG5NeETjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKfg1zKx/kr5nnDEpJALpC6x8ywy1VCYfBXZMhjfjO1kdO4PCv8lzliHWeRAAVUF/RcJOfnNI6fBRhvIP4/JEreYQ5zvVVooMQ0zzm0tU32ix+LI7zvAWppOC7kasKIAQqexrisX6eK6JpjCQlI9PMnvm9UmN+Idma5abSQu4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOlo8Z/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E5CC43394;
	Tue, 27 Feb 2024 13:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709041299;
	bh=ZeSUM3z3GiUVvHCrkzq+QtV/032258+nd5zG5NeETjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nOlo8Z/R8XdRFHQ9eNWITjtSX+KKIe8oYY4tEdnmje2PGhHvGIXTVCWTmv991gE5y
	 OcGTD38890/yrE0qoUSqyMzZTr4HbzO+3GuYEYUzbxbi1lYHmef95LQWKFxLfSjKmk
	 0G+ebJc6Tp4fTxZOED7YKpvDdlVEn/GfaUPWl5QzGb1XTe/HVhLMA8ZbQLnR+0wkuz
	 K3HPfMGsgzDerzFlS5+c0kOKgGh6TM3hrx1Nytcm9dkDfrieFEsGJLXcZB80JYTvMZ
	 sye/K3BpPRsmGlEuaTXqyVMWEex4BWh8JBAI890MxtETG4ELs2vPPR5Bx1mMxhVgY0
	 PRa7sBaAFoXqg==
From: Christian Brauner <brauner@kernel.org>
To: John Groves <John@groves.net>
Cc: Christian Brauner <brauner@kernel.org>,
	John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com
Subject: Re: [RFC PATCH 10/20] famfs: famfs_open_device() & dax_holder_operations
Date: Tue, 27 Feb 2024 14:39:20 +0100
Message-ID: <20240227-aufhalten-funkspruch-91b2807d93a7@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <74359fdc83688fb1aac1cb2c336fbd725590a131.1708709155.git.john@groves.net>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4531; i=brauner@kernel.org; h=from:subject:message-id; bh=ZeSUM3z3GiUVvHCrkzq+QtV/032258+nd5zG5NeETjk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTefVbbFrY/zvbXyYiz8ct0Fa9WT52cm84y/dcD5ZRch 9eFkWvcO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYi387I8PxSN4tJ7K7M99va o9umi8pFib9szmKPXn6vUfny9F6vVQy/mN/Ln0vb/4WHkXHVhpufFP4L3LU02X//SQxPzGbBsIf PWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, Feb 23, 2024 at 11:41:54AM -0600, John Groves wrote:
> Famfs works on both /dev/pmem and /dev/dax devices. This commit introduces
> the function that opens a block (pmem) device and the struct
> dax_holder_operations that are needed for that ABI.
> 
> In this commit, support for opening character /dev/dax is stubbed. A
> later commit introduces this capability.
> 
> Signed-off-by: John Groves <john@groves.net>
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

I'm confused why that function is added here but it's completely unclear
in what wider context it's called. This is really hard to follow.

> +	struct super_block *sb,
> +	struct fs_context  *fc)
> +{
> +	struct famfs_fs_info *fsi = sb->s_fs_info;
> +	struct dax_device    *dax_devp;
> +	u64 start_off = 0;
> +	struct bdev_handle   *handlep;
> +
> +	if (fsi->dax_devp) {
> +		pr_err("%s: already mounted\n", __func__);
> +		return -EALREADY;
> +	}
> +
> +	if (strstr(fc->source, "/dev/dax")) /* There is probably a better way to check this */
> +		return famfs_open_char_device(sb, fc);
> +
> +	if (!strstr(fc->source, "/dev/pmem")) { /* There is probably a better way to check this */

Yeah, this is not just a bit ugly but also likely wrong because:

sudo mount --bind /dev/pmem /opt/muhaha

fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/opt/muhaha", [...])

or a simple mknod to create that device somewhere else. You likely want:

lookup_bdev(fc->source, &dev);

if (!DEVICE_NUMBER_SOMETHING_SOMETHING_SANE(dev))
	return invalfc(fc, "SOMETHING SOMETHING...

bdev_open_by_dev(dev, ....)

(This reminds me that I should get back to making it possible to specify
"source" as a file descriptor instead of a mere string with the new
mount api...)

> +		pr_err("%s: primary backing dev (%s) is not pmem\n",
> +		       __func__, fc->source);
> +		return -EINVAL;
> +	}
> +
> +	handlep = bdev_open_by_path(fc->source, FAMFS_BLKDEV_MODE, fsi, &fs_holder_ops);

Hm, I suspected that FAMFS_BLKDEV_MODE would be wrong based on:
https://lore.kernel.org/r/13556dbbd8d0f51bc31e3bdec796283fe85c6baf.1708709155.git.john@groves.net

It's defined as FMODE_READ | FMODE_WRITE which is wrong. But these
helpers want BLOCK_OPEN_READ | BLOCK_OPEN_WRITE.

> +	if (IS_ERR(handlep->bdev)) {

@bdev_handle will be gone as of v6.9 so you might want to wait until
then to resend.

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
> +	return 0;
> +}
> +
> +
>  
>  MODULE_LICENSE("GPL");
> -- 
> 2.43.0
> 

