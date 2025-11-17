Return-Path: <linux-fsdevel+bounces-68627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9E4C62383
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 04:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C57EE4EF691
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 03:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5980829D291;
	Mon, 17 Nov 2025 03:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mibON+29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81629299A90;
	Mon, 17 Nov 2025 03:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348794; cv=none; b=KBUdfbitCEm7ove1VqTZiQkX/jaWLwUAkAmwGceiibvTFVhiV/KpmTZ+nFUalAKpSBArl1q9EUtEGAcR6zB61+o880FDJG3qffPyOvy4HvfyoE5vr0LXz4/l57qVjSWjyjpR3SYyvm/4JwX75RQQLhYBHiU6bQZC0Tm1RDNTFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348794; c=relaxed/simple;
	bh=i3+p44+dBzq6x0x6erNVDhNQAeoZjm5bDt0dqKqamDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qM54U7nIKUsoibQTYALrHDdUzNz0upAecAfpaKVmMAe6JDyZZd0OYkmUoxUsUqLojqlB8iB3hFOi2pvA6s5T4IGSAZStFh5+H7oXTrzNIzii0Shh6dp8bDhUS1Xlp0kyC4DGfFAs5xpgid5WS4dE/xAbRY6tN50uUtxE7x+ZtXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mibON+29; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763348782; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zkUkVtaYANx14A78qG4oH+hGsB28R5OzoHfZ+Xxr/M0=;
	b=mibON+29kV/Q8GVTfLHbHT1+KDDXp73omzg79ykeKfa8HI4Kz4/BzpSz1OwQIlFgc3pmKj9cZXNVDa/TFiAntctKCEFFSH0SsjgJBm8KRWUfNGj3OD27SoAWlOV95eFp7iFKv/sGjSn3ifll3Z0SITq78o4n9aaDXPa0hR91SwY=
Received: from 30.221.131.30(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsTuQXG_1763348781 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Nov 2025 11:06:22 +0800
Message-ID: <ac1b5431-e71f-430d-8309-8d007dc449b9@linux.alibaba.com>
Date: Mon, 17 Nov 2025 11:06:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/9] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-7-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251114095516.207555-7-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/14 17:55, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Currently, reading files with different paths (or names) but the same
> content will consume multiple copies of the page cache, even if the
> content of these page caches is the same. For example, reading
> identical files (e.g., *.so files) from two different minor versions of
> container images will cost multiple copies of the same page cache,
> since different containers have different mount points. Therefore,
> sharing the page cache for files with the same content can save memory.
> 
> This introduces the page cache share feature in erofs. It allocate a
> deduplicated inode and use its page cache as shared. Reads for files
> with identical content will ultimately be routed to the page cache of
> the deduplicated inode. In this way, a single page cache satisfies
> multiple read requests for different files with the same contents.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---

...


> +
> +static int erofs_ishare_file_open(struct inode *inode, struct file *file)
> +{
> +	struct file *realfile;
> +	struct inode *dedup;
> +
> +	dedup = EROFS_I(inode)->ishare;
> +	if (!dedup)
> +		return -EINVAL;
> +
> +	realfile = alloc_file_pseudo(dedup, erofs_ishare_mnt, "erofs_ishare_file",
> +				     O_RDONLY, &erofs_file_fops);
> +	if (IS_ERR(realfile))
> +		return PTR_ERR(realfile);
> +
> +	file_ra_state_init(&realfile->f_ra, file->f_mapping);
> +	realfile->private_data = EROFS_I(inode);
> +	file->private_data = realfile;
> +	return 0;

Again, as Amir mentioned before, it should be converted to use (at least)
some of backing file interfaces, please see:
   file_user_path() and file_user_inode() in include/linux/fs.h

Or are you sure /proc/<pid>/maps is shown as expected?

Thanks,
Gao Xiang

