Return-Path: <linux-fsdevel+bounces-51232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C05AD4AD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 08:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5C43A6432
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 06:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD32228CA5;
	Wed, 11 Jun 2025 06:11:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3FF226888;
	Wed, 11 Jun 2025 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749622266; cv=none; b=UJ99rKpc86/CFxt/hyLOXPTK+mfJlAWsohYUUoEHJHpewkwhFAL7BIguicvDROqBWAYC4FpVt4uaQwcL6MSWf9lroIDwHmEmx+9c9tFSOqrfiBJ3dWsz2wuzpciHgTtmvQBo5DMprpH9p48Zlp15bdFnxWWzuFsDEBy5iX7HTy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749622266; c=relaxed/simple;
	bh=gCYqfeP01dFMugvs6vUFmJxrlEq0uOra2uN2zZsgAuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eitUtsTQvZdx7huwbZROaGtpCZiGOxrBdlmKberDVrAzexeQwDQ0ZRbOu21iPMtUEohVwk6u5OwYxufCFerF1kskzWtbGFjZq8+mgQVsD80e6u8P8/LnKjc1R2ivtZatsIhKSYfE0Jn/iCU4eNOi3LExkkfKakYU7zf3KnUZ9Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3722468AA6; Wed, 11 Jun 2025 08:10:59 +0200 (CEST)
Date: Wed, 11 Jun 2025 08:10:58 +0200
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
Subject: Re: [PATCH 09/10] block: add FALLOC_FL_WRITE_ZEROES support
Message-ID: <20250611061058.GB4613@lst.de>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com> <20250604020850.1304633-10-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604020850.1304633-10-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 04, 2025 at 10:08:49AM +0800, Zhang Yi wrote:
> @@ -856,6 +856,13 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  	/* Fail if we don't recognize the flags. */
>  	if (mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
>  		return -EOPNOTSUPP;
> +	/*
> +	 * Don't allow writing zeroes if the device does not enable the
> +	 * unmap write zeroes operation.
> +	 */
> +	if (!bdev_write_zeroes_unmap(bdev) &&
> +	    (mode & FALLOC_FL_WRITE_ZEROES))

Cosmetic nitpick, but I'd turn the check around to check the mode first
as that's easier to read.  The whole check also fits onto a single line:

	if ((mode & FALLOC_FL_WRITE_ZEROES) && !bdev_write_zeroes_unmap(bdev))

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

