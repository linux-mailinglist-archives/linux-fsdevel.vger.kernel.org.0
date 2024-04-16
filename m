Return-Path: <linux-fsdevel+bounces-17009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCA58A6068
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 03:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4CA281C10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACFB7484;
	Tue, 16 Apr 2024 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aFDOW72q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E49C81F;
	Tue, 16 Apr 2024 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713231362; cv=none; b=Imjdvu+KMn50lWQXdJ0unLpdL4soV5rqEOmQfKq+egYRRsuqkbera42MR8QZVFhy0kUqiAxjvoE31e2txoyGmDBNXSVGea386W/wJTt8HxE+fFkUpLr6fXvu/X/NaGj6UWy1QEgYykuaP7RN1Pn09zgTGW94vMgKnHoEWr1na/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713231362; c=relaxed/simple;
	bh=jsmBFiYdJ39p4AypnhPt3gVPTdgbWiZEaDsPwo+slsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LABVkaIpLp586EnC5Qm+ny/LdcCNdTUmvrjDMaJAK7zKyTWTiE76DEq9oUvru3KhC1ayz/vU9lSkmQHA02an/bYlqdN4l3RngALK1wNp16ELPHcEhVHFwbt46rAQlMMkzu67F+4o2WWqllEVb8/9ubFVC9qTuTa7suZrWnkNerw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aFDOW72q; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Skx+tWSgaqX1mfAd0brbPN+dNPOOuoIWRe8tqmg9+LI=; b=aFDOW72qa1X3x4T+c2iWWA9TlW
	GA7brWjDSCVTdtzXKiDUwxpgxm4PPrFE7vl41OKWKh+CCk4LwpOcxVMKIKNPz6WW9sXNeNOKseI6c
	N44wNxjJweVL/Y9kR0PjIZBtgUb81EySL63ClnFcGxZrFxN8uDxIGzX6HNIIOzqiQVfO3EWDnxm/N
	9A7yyGQRDuy8x7oZmOq5xjRRJ/tmZedksRxsVB0myYcPZACStuTAgvbkNmOQlkZDK7noBVZzWmEkB
	swHBzq1BnhjrQckigMCU8aviNzoxfDIVN/zCi4pKX8MebF6H/v/RxDp7q1aumPFaAdP+wAaHeBXo4
	ba5KPXsw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rwXjn-00D8Ru-2Y;
	Tue, 16 Apr 2024 01:35:55 +0000
Date: Tue, 16 Apr 2024 02:35:55 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-s390@vger.kernel.org
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
	Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH vfs.all 15/26] s390/dasd: use bdev api in dasd_format()
Message-ID: <20240416013555.GZ2118490@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-16-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406090930.2252838-16-yukuai1@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 06, 2024 at 05:09:19PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Avoid to access bd_inode directly, prepare to remove bd_inode from
> block_devcie.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  drivers/s390/block/dasd_ioctl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
> index 7e0ed7032f76..c1201590f343 100644
> --- a/drivers/s390/block/dasd_ioctl.c
> +++ b/drivers/s390/block/dasd_ioctl.c
> @@ -215,8 +215,9 @@ dasd_format(struct dasd_block *block, struct format_data_t *fdata)
>  	 * enabling the device later.
>  	 */
>  	if (fdata->start_unit == 0) {
> -		block->gdp->part0->bd_inode->i_blkbits =
> -			blksize_bits(fdata->blksize);
> +		rc = set_blocksize(block->gdp->part0, fdata->blksize);

Could somebody (preferably s390 folks) explain what is going on in
dasd_format()?  The change in this commit is *NOT* an equivalent
transformation - mainline does not evict the page cache of device.

Is that
	* intentional behaviour in mainline version, possibly broken
by this patch
	* a bug in mainline accidentally fixed by this patch
	* something else?

And shouldn't there be an exclusion between that and having a filesystem
on a partition of that disk currently mounted?

