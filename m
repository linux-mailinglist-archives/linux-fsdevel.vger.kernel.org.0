Return-Path: <linux-fsdevel+bounces-21374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19FE902EEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 05:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265B2B212C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 03:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5935616F8F7;
	Tue, 11 Jun 2024 03:10:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435D616F8E0;
	Tue, 11 Jun 2024 03:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718075456; cv=none; b=qg7lWtuDL6ZKzdgry1xt4XtzSiO0u4nsZ62cfEA2QFK86Z52ELCWvXgin/f4Ze6+ZZ/jLbfuqyQUTTFst7Qt5+wufmYDVRK2J2bC24MNpTCMPNc6WKBf3c9YdgQT9Si9wWHAIDdGgrkXYiijgJUqw4rPJ7LG4bR7qeZOp2X1WhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718075456; c=relaxed/simple;
	bh=n9N1QyGzD8ltpsE0Cnq0l1cexAGqiukqlDno4lTCv1E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjPaEDwUiYDoF+f+S8gH54b5O/BsRI8qdZHTD+xJyL2EPqdcLhW4zpaPpG5AZJC8fegEhIR/+ofBG5NK/Gw8GOqeofMQiQPZZJhoKU9qk8AUYgH5KFkDXTPmYacUnd3GMTuVO7S2+rW4XXakTDElsP2flFUCdaHfnAF2WckRo4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Vytr73HGJz1X3Xn;
	Tue, 11 Jun 2024 11:07:03 +0800 (CST)
Received: from kwepemi500009.china.huawei.com (unknown [7.221.188.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 31A6E14022E;
	Tue, 11 Jun 2024 11:10:50 +0800 (CST)
Received: from localhost (10.175.127.227) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Jun
 2024 11:10:49 +0800
Date: Tue, 11 Jun 2024 11:10:09 +0800
From: Long Li <leo.lilong@huawei.com>
To: John Garry <john.g.garry@oracle.com>, <david@fromorbit.com>,
	<djwong@kernel.org>, <hch@lst.de>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <chandan.babu@oracle.com>,
	<willy@infradead.org>
CC: <axboe@kernel.dk>, <martin.petersen@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<tytso@mit.edu>, <jbongio@google.com>, <ojaswin@linux.ibm.com>,
	<ritesh.list@gmail.com>, <mcgrof@kernel.org>, <p.raghav@samsung.com>,
	<linux-xfs@vger.kernel.org>, <catherine.hoang@oracle.com>
Subject: Re: [PATCH v3 14/21] iomap: Sub-extent zeroing
Message-ID: <20240611031009.GA3408983@ceph-admin>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-15-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240429174746.2132161-15-john.g.garry@oracle.com>
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500009.china.huawei.com (7.221.188.199)

On Mon, Apr 29, 2024 at 05:47:39PM +0000, John Garry wrote:
> For FS_XFLAG_FORCEALIGN support, we want to treat any sub-extent IO like
> sub-fsblock DIO, in that we will zero the sub-extent when the mapping is
> unwritten.
> 
> This will be important for atomic writes support, in that atomically
> writing over a partially written extent would mean that we would need to
> do the unwritten extent conversion write separately, and the write could
> no longer be atomic.
> 
> It is the task of the FS to set iomap.extent_size per iter to indicate
> sub-extent zeroing required.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/iomap/direct-io.c  | 17 +++++++++++------
>  include/linux/iomap.h |  1 +
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f3b43d223a46..a3ed7cfa95bc 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -277,7 +277,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  {
>  	const struct iomap *iomap = &iter->iomap;
>  	struct inode *inode = iter->inode;
> -	unsigned int fs_block_size = i_blocksize(inode), pad;
> +	unsigned int zeroing_size, pad;
>  	loff_t length = iomap_length(iter);
>  	loff_t pos = iter->pos;
>  	blk_opf_t bio_opf;
> @@ -288,6 +288,11 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	size_t copied = 0;
>  	size_t orig_count;
>  
> +	if (iomap->extent_size)
> +		zeroing_size = iomap->extent_size;
> +	else
> +		zeroing_size = i_blocksize(inode);
> +
>  	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
>  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>  		return -EINVAL;
> @@ -354,8 +359,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		dio->iocb->ki_flags &= ~IOCB_HIPRI;
>  
>  	if (need_zeroout) {
> -		/* zero out from the start of the block to the write offset */
> -		pad = pos & (fs_block_size - 1);
> +		/* zero out from the start of the region to the write offset */
> +		pad = pos & (zeroing_size - 1);
>  		if (pad)
>  			iomap_dio_zero(iter, dio, pos - pad, pad);
 
Hi, John

I've been testing and using your atomic write patch series recently. I noticed
that if zeroing_size is larger than a single page, the length passed to
iomap_dio_zero() could also be larger than a page size. This seems incorrect
because iomap_dio_zero() utilizes ZERO_PAGE(0), which is only a single page
in size.

Thanks,
Long Li

