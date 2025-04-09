Return-Path: <linux-fsdevel+bounces-46062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 476D1A82241
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 12:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154DF463635
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 10:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C2525DAEE;
	Wed,  9 Apr 2025 10:34:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584F317A319;
	Wed,  9 Apr 2025 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194853; cv=none; b=FguccO3J28VYOMChkwGIRKWUZZFSYK8Dsv0mV6UrF573siOHsTRm1MViKwBgmjXqw2UGvRP0Ve/s4CKwRnJL+3B9fWJhqo7kgaGPJt+xcGrY14P/bEwd2WMSHCtkrxTmZMHYW8DbViCv/phN1VRT72mWvL7laPsnYjF5uu4fT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194853; c=relaxed/simple;
	bh=DobfG+3gV1Rkv7VQbq130VP7/54eKGQY8yYdBas+qoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0401pAVCQjYZ/XnqC1SleKRpw60sYQgef66p7R//a/iZFBjZ1/xr0E15T8uACUIMOqdqGsfyjZDf1WC7Ewe1wvM3GPdZDaatWBC+7uHYOkN6nSaIuqD8fl8WVy+zYodO8YqbtIeyOZw701vsYsZnpQdCzqdC4rXKXX6hxSvHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 42E1368AA6; Wed,  9 Apr 2025 12:34:05 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:34:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
	tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
	bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH -next v3 04/10] nvmet: set WZDS and DRB if device
 supports BLK_FEAT_WRITE_ZEROES_UNMAP
Message-ID: <20250409103405.GB4950@lst.de>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com> <20250318073545.3518707-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318073545.3518707-5-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 03:35:39PM +0800, Zhang Yi wrote:
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 5d280c7fba65..836738ab1fa6 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1344,6 +1344,11 @@ static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
>  	return bdev_limits(bdev)->max_write_zeroes_sectors;
>  }
>  
> +static inline bool bdev_unmap_write_zeroes(struct block_device *bdev)
> +{
> +	return bdev_limits(bdev)->features & BLK_FEAT_WRITE_ZEROES_UNMAP;

This helper has an odd name. In doubt stick to the name of the flag
instead of reordering the words.

Also no core block code should be added in an nvmet patch, this needs
to go into the first patch.

