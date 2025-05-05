Return-Path: <linux-fsdevel+bounces-48078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D6EAA944E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2C2178828
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C296258CD3;
	Mon,  5 May 2025 13:22:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87064204840;
	Mon,  5 May 2025 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451338; cv=none; b=WQzTXkt7J9sdilhgr0IlRgcufHaRs1ElxtIa+jBlxqS1TV12mv/ESx8cgwTYqyjkAeg8lc+YEgBGVBsH09k0DA9jq3LbXPfE2P3/fUXecHDDIQcubDRGlD79rZns1IorigFVilVNxOlHComM2MEbPvDowrqsbKz2FTvnBUrRc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451338; c=relaxed/simple;
	bh=+O8XcPHr3zahII0nWAcKTPrXEdHRGL4hSFQbkqlKhMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDVRMTTqXfEONXF5t0hC/dVRDVvDyKMTPKN9DYWTSYIdc4VoajRnaVfZtCWD+oLZvHjTv/PiU/pMLHyjsnWrAmon/Uz98dOc5Bqdv/amWsHowth1qMIkwB5Ap+jn2CjIttNkNlsn9x4vCccTcIa9fgVh+NWeZK30IDOwzt/LM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A7E7D68BFE; Mon,  5 May 2025 15:22:08 +0200 (CEST)
Date: Mon, 5 May 2025 15:22:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
	tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
	bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250505132208.GA22182@lst.de>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com> <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Apr 21, 2025 at 10:15:05AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Add a new attribute flag to statx to determine whether a bdev or a file
> supports the unmap write zeroes command.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  block/bdev.c              | 4 ++++
>  fs/ext4/inode.c           | 9 ++++++---
>  include/uapi/linux/stat.h | 1 +
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 4844d1e27b6f..29b0e5feb138 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1304,6 +1304,10 @@ void bdev_statx(struct path *path, struct kstat *stat,
>  			queue_atomic_write_unit_max_bytes(bd_queue));
>  	}
>  
> +	if (bdev_write_zeroes_unmap(bdev))
> +		stat->attributes |= STATX_ATTR_WRITE_ZEROES_UNMAP;
> +	stat->attributes_mask |= STATX_ATTR_WRITE_ZEROES_UNMAP;

Hmm, shouldn't this always be set by stat?  But I might just be
really confused what attributes_mask is, and might in fact have
misapplied it in past patches of my own..

Also shouldn't the patches to report the flag go into the bdev/ext4
patches that actually implement the feature for the respective files
to keep bisectability?


