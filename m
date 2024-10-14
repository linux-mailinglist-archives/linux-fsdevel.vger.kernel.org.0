Return-Path: <linux-fsdevel+bounces-31838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7DC99C004
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630351C223AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 06:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513CA13CABC;
	Mon, 14 Oct 2024 06:31:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88A33C9
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887460; cv=none; b=Qr4LpOr8eLLozI7flzgF1XTDoGoGj4fb2jstlLtnXpQndimMGCXgT+g3GWX42C8qjS5BsPxX3p9fYLfTH8nJXRcQLOmWT13HaCPd+EZvpxyDyPNs8+heZVFOjDY9pryfTTYJJvFNAt/36fr0rZN2ee1I44aUkF1Dd8m3xdITl3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887460; c=relaxed/simple;
	bh=Hb/cYk0aCyKc2bFFM5C0gH0r4eRVVjNQh8RDMfTYVCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnPJiNPlU49C+ZadrFZ+4Fd9EhPX++HxS1qUuf4bg6d/k5Tes1BBDEse4wg3NQjyqdohRCVQEo2ld4CR0hYDF+rzxSgnD/sCfC3pNVcqH0hY5JEoC+ebrFj5YbrmQ43dsl4DW8a6xS7vRzB5vwc6JKHC/BjKtW/AEIxSIVW9my4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XRnPM1WW8zpWsK;
	Mon, 14 Oct 2024 14:28:55 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 0833F180AE9;
	Mon, 14 Oct 2024 14:30:54 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 kwepemd100024.china.huawei.com (7.221.188.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Oct 2024 14:30:53 +0800
From: yangyun <yangyun50@huawei.com>
To: <amir73il@gmail.com>
CC: <bernd.schubert@fastmail.fm>, <linux-fsdevel@vger.kernel.org>,
	<miklos@szeredi.hu>, <yangyun50@huawei.com>, <lixiaokeng@huawei.com>
Subject: Re: [PATCH] fuse: update inode size after extending passthrough write
Date: Mon, 14 Oct 2024 15:30:41 +0000
Message-ID: <20241014153041.4142058-1-yangyun50@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011135326.667781-1-amir73il@gmail.com>
References: <20241011135326.667781-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100024.china.huawei.com (7.221.188.41)

On Fri, Oct 11, 2024 at 03:53:26PM +0200, Amir Goldstein wrote:
> yangyun reported that libfuse test test_copy_file_range() copies zero
> bytes from a newly written file when fuse passthrough is enabled.
> 
> The reason is that extending passthrough write is not updating the fuse
> inode size and when vfs_copy_file_range() observes a zero size inode,
> it returns without calling the filesystem copy_file_range() method.
> 
> Extend the fuse inode size to the size of the backing inode after every
> passthrough write if the backing inode size is larger.
> 
> This does not yet provide cache coherency of fuse inode attributes and
> backing inode attributes, but it should prevent situations where fuse
> inode size is too small, causing read/copy to be wrongly shortened.
> 
> Reported-by: yangyun <yangyun50@huawei.com>
> Closes: https://github.com/libfuse/libfuse/issues/1048
> Fixes: 57e1176e6086 ("fuse: implement read/write passthrough")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Doh! force of habbit - fixed subject s/ovl/fuse
> 
> Thanks,
> Amir.
> 
>  fs/fuse/passthrough.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index ba3207f6c4ce..d3047a4bc40e 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -20,9 +20,18 @@ static void fuse_file_accessed(struct file *file)
>  
>  static void fuse_file_modified(struct file *file)
>  {
> +	struct fuse_file *ff = file->private_data;
> +	struct file *backing_file = fuse_file_passthrough(ff);
>  	struct inode *inode = file_inode(file);
> -
> -	fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
> +	loff_t size = i_size_read(file_inode(backing_file));
> +
> +	/*
> +	 * Most of the time we will be holding inode_lock(), but even if we are
> +	 * called from async io completion without inode_lock(), the last write
> +	 * will update fuse inode size to the size of the backing inode, even if
> +	 * the last write was not the extending write.
> +	 */
> +	fuse_write_update_attr(inode, size, size);
>  }
>  
>  ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> -- 
> 2.34.1

Sorry for a late reply. Because I have spent some time on figuring out whether we 
need some FUSE_I_SIZE_UNSTABLE bit operations before and after the write which are
provided in your v14 patch of fuse passthrough, just like in fuse_perform_write.

The conclusion is not, IMO. The FUSE_I_SIZE_UNSTABLE bit is provided in
commit 06a7c3c2781(fuse: hotfix truncate_pagecache() issue) for the
races between i_size updates and truncate_pagecache() in
fuse_change_attributes. Because the pagecache operations of fuse inode
is not allowed in fuse passthrough mode, this FUSE_I_SIZE_UNSTABLE bit is useless.
And we just need the minimum fix for extending writes by now.

I have also tested this patch with xfstests (using ./check -fuse -b) and libfuse 
test. In xfstest, this patch does not import new failed tests compared with pre-this
patch. And in libfuse test, this patch can solve the problem test_copy_file_range(). 

