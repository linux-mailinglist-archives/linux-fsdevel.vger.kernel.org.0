Return-Path: <linux-fsdevel+bounces-51330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBC8AD59BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 17:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98F71BC4C57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A2F1DDC2C;
	Wed, 11 Jun 2025 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q09gTN7J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4259418BC2F;
	Wed, 11 Jun 2025 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654356; cv=none; b=gs2p97F8xakutiMBlAhVpbhOEq0ICMVZ4Xd9sDMtS01a2sWk/COeeYYx4rqiFik8WB3FVb/zvDgqgvFtEx1s/ZGU9CyW32NLSPipu/rdOcCmYJ5qhodTZXJ8AFqhmwbz02QXQ8KWTmJmglmwdBBKE8Lr1SlUfmaCUas/9cTQHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654356; c=relaxed/simple;
	bh=nXn//9wEDz612qpwUp8e5GEyUKA50kkwM4h/bE6ZsuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=su5z1yS8jd8azCp46KNpSr3hGUrUxHodUkSa+nWZc3tLl4dQVwIHtbkS0idMXbDby+r8eqovkXu0UhwBY3u26oWorq0EgJWCy2yxS/3YLRcycAhBIkhbUozQjxDFHetKSj8wLxN6+SmApe8OT+k09HiqetS+eJ9HtWj2LJ6Pxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q09gTN7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF97EC4CEE3;
	Wed, 11 Jun 2025 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749654355;
	bh=nXn//9wEDz612qpwUp8e5GEyUKA50kkwM4h/bE6ZsuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q09gTN7JEA9p4RLFDHZ4C0xd3qOt0xR+cuu6CEvOs3oeO1rgndK/SFluuYHxpBwiL
	 pcrJUktzodkyPGdCmioD3Pn+DGNwZw7t8x7x2D0qcxhP98WSlrEXXDrl7ncRliIhTv
	 i4B1LttaTfBZZFx7yGC/ufWAgQofppsA7SN8MiAQIPngifAuoyFFbczwovXdJeehdI
	 4OJt2ThjrKPM/ptQuox2H9n/ZSCCZ39v0wavG5UYR+eo8fL5G9z0B1cJtSFNF0XXL9
	 lNIgvxMVexROrysgq8wf/C4BYLcPSK2fCrvofoN4KX+z/6+s8eFIPH4pHF4mqI6jr0
	 gYUgZDM+G7c/Q==
Date: Wed, 11 Jun 2025 08:05:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	brauner@kernel.org, martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 07/10] fs: introduce FALLOC_FL_WRITE_ZEROES to fallocate
Message-ID: <20250611150555.GB6134@frogsfrogsfrogs>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
 <20250604020850.1304633-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604020850.1304633-8-yi.zhang@huaweicloud.com>

[cc linux-api about a fallocate uapi change]

On Wed, Jun 04, 2025 at 10:08:47AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> With the development of flash-based storage devices, we can quickly
> write zeros to SSDs using the WRITE_ZERO command if the devices do not
> actually write physical zeroes to the media. Therefore, we can use this
> command to quickly preallocate a real all-zero file with written
> extents. This approach should be beneficial for subsequent pure
> overwriting within this file, as it can save on block allocation and,
> consequently, significant metadata changes, which should greatly improve
> overwrite performance on certain filesystems.
> 
> Therefore, introduce a new operation FALLOC_FL_WRITE_ZEROES to
> fallocate. This flag is used to convert a specified range of a file to
> zeros by issuing a zeroing operation. Blocks should be allocated for the
> regions that span holes in the file, and the entire range is converted
> to written extents. If the underlying device supports the actual offload
> write zeroes command, the process of zeroing out operation can be
> accelerated. If it does not, we currently don't prevent the file system
> from writing actual zeros to the device. This provides users with a new
> method to quickly generate a zeroed file, users no longer need to write
> zero data to create a file with written extents.
> 
> Users can determine whether a disk supports the unmap write zeroes
> operation through querying this sysfs interface:
> 
>     /sys/block/<disk>/queue/write_zeroes_unmap
> 
> Finally, this flag cannot be specified in conjunction with the
> FALLOC_FL_KEEP_SIZE since allocating written extents beyond file EOF is
> not permitted. In addition, filesystems that always require out-of-place
> writes should not support this flag since they still need to allocated
> new blocks during subsequent overwrites.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/open.c                   |  1 +
>  include/linux/falloc.h      |  3 ++-
>  include/uapi/linux/falloc.h | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 7828234a7caa..b777e11e5522 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -281,6 +281,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  		break;
>  	case FALLOC_FL_COLLAPSE_RANGE:
>  	case FALLOC_FL_INSERT_RANGE:
> +	case FALLOC_FL_WRITE_ZEROES:
>  		if (mode & FALLOC_FL_KEEP_SIZE)
>  			return -EOPNOTSUPP;
>  		break;
> diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> index 3f49f3df6af5..7c38c6b76b60 100644
> --- a/include/linux/falloc.h
> +++ b/include/linux/falloc.h
> @@ -36,7 +36,8 @@ struct space_resv {
>  				 FALLOC_FL_COLLAPSE_RANGE |	\
>  				 FALLOC_FL_ZERO_RANGE |		\
>  				 FALLOC_FL_INSERT_RANGE |	\
> -				 FALLOC_FL_UNSHARE_RANGE)
> +				 FALLOC_FL_UNSHARE_RANGE |	\
> +				 FALLOC_FL_WRITE_ZEROES)
>  
>  /* on ia32 l_start is on a 32-bit boundary */
>  #if defined(CONFIG_X86_64)
> diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> index 5810371ed72b..265aae7ff8c1 100644
> --- a/include/uapi/linux/falloc.h
> +++ b/include/uapi/linux/falloc.h
> @@ -78,4 +78,22 @@
>   */
>  #define FALLOC_FL_UNSHARE_RANGE		0x40
>  
> +/*
> + * FALLOC_FL_WRITE_ZEROES is used to convert a specified range of a file to
> + * zeros by issuing a zeroing operation. Blocks should be allocated for the
> + * regions that span holes in the file, and the entire range is converted to
> + * written extents.

I think you could simplify this a bit by talking only about the end
state after a successful call:

"FALLOC_FL_WRITE_ZEROES zeroes a specified file range in such a way that
subsequent writes to that range do not require further changes to file
mapping metadata."

Note that we don't say how the filesystem gets to this goal.  Presumably
the first implementations will send a zeroing operation to the block
device during allocation and the fs will create written mappings, but
there are other ways to get there -- a filesystem could maintain a pool
of pre-zeroed space and hand those out; or it could zero space on
freeing and mounting such that all new mappings can be created as
written even without the block device zeroing operation.

Or you could be running on some carefully engineered system where you
know the storage will always be zeroed at allocation time due to some
other aspect of the system design, e.g. a single-use throwaway cloud vm
where you allocate to the end of the disk and reboot the node.

> + *                  This flag is beneficial for subsequent pure overwriting
> + * within this range, as it can save on block allocation and, consequently,
> + * significant metadata changes. Therefore, filesystems that always require
> + * out-of-place writes should not support this flag.
> + *
> + * Different filesystems may implement different limitations on the
> + * granularity of the zeroing operation. Most will preferably be accelerated
> + * by submitting write zeroes command if the backing storage supports, which
> + * may not physically write zeros to the media.
> + *
> + * This flag cannot be specified in conjunction with the FALLOC_FL_KEEP_SIZE.
> + */
> +#define FALLOC_FL_WRITE_ZEROES		0x80

The rest of the writeup seems fine to me.

--D

> +
>  #endif /* _UAPI_FALLOC_H_ */
> -- 
> 2.46.1
> 
> 

