Return-Path: <linux-fsdevel+bounces-51231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C783EAD4ABD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 08:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BAE1786DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 06:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180BA228CA3;
	Wed, 11 Jun 2025 06:09:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3907422540B;
	Wed, 11 Jun 2025 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749622153; cv=none; b=VNe1XxzYvXdvx2taFP/PGDuPlYRYgvQtHOqf25+7C7zg0LyOkVn0L8m86DN78MunM2/9Ai5czotP1d6lOjY8f+tVLyW7eOBKwkoGAGtiiH6zSxXc2CptztzgdsiHiUuFnfs7T8a0HR4wW9ypZQBq5f//Y5RAAPq2Ng+sjlatQn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749622153; c=relaxed/simple;
	bh=8sMku4WxahX1FuZlVCqNoL8+EPGRsyZn1w622Xjs6Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czj4f2cTlh5981QD9TZHgySGtEntK/5LgE3GmX9Jm4B/67/3agdYjnP8ltMW0XI7Jly8zFrF5UfTK0hDKFhRTNyeEPTFldmRIpbl0I9rCltGfI20MOQy5EYHt57U5h8prdVGMvFXtwKO5pWi8PSzkuBwCC2ZrY2JKwAl0Tv8IX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9CE2368AA6; Wed, 11 Jun 2025 08:09:00 +0200 (CEST)
Date: Wed, 11 Jun 2025 08:09:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
	tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
	bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 01/10] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to
 queue limits features
Message-ID: <20250611060900.GA4613@lst.de>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com> <20250604020850.1304633-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604020850.1304633-2-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 04, 2025 at 10:08:41AM +0800, Zhang Yi wrote:
> +static ssize_t queue_write_zeroes_unmap_show(struct gendisk *disk, char *page)

..

> +static int queue_write_zeroes_unmap_store(struct gendisk *disk,
> +		const char *page, size_t count, struct queue_limits *lim)

We're probably getting close to wanting macros for the sysfs
flags, similar to the one for the features (QUEUE_SYSFS_FEATURE).

No need to do this now, just thinking along.

> +/* supports unmap write zeroes command */
> +#define BLK_FEAT_WRITE_ZEROES_UNMAP	((__force blk_features_t)(1u << 17))


Should this be exposed through sysfs as a read-only value?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

