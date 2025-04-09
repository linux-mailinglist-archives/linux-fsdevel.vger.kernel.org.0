Return-Path: <linux-fsdevel+bounces-46034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690ABA81ADA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 04:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2969D1B645F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 02:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2E44AEE2;
	Wed,  9 Apr 2025 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khNoS7BW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8B15746F;
	Wed,  9 Apr 2025 02:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165390; cv=none; b=Ygb74py2NNKSWw2f2il79gBOkT/9tz/nsdfc9TBI+JQ9ywA6Stao6iEgKxJJlMgm2W03NacNC8CvfNo0QOZBVubSOX6LtMTa4ZSUrnxKPog/EUXuLlEHXSlC4HGjWGeQul0FFL4yFp0QuvKKqRbMX+RZQXNbeylALolOhAJOXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165390; c=relaxed/simple;
	bh=5YrKufIRjjuIDHAGNdEbgfNkGgfPSHnxt8MOhqKxuF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4W9PTM3I5bqxqhXYUnxsmitVrVpdymc6vNZSuuW2LIaPbK5OJCWro+0gcguwn64v8wQW1ZOa+ASGYMUWVxYCUzGjxepbTD1QCT4eFlIR9iCTzQjyH1vnLPQcArd6RsmpOTEuQFFMaNsPhF794A5jkszAYS+jdxtiKu/RNSo7PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khNoS7BW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A26C4CEE5;
	Wed,  9 Apr 2025 02:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744165389;
	bh=5YrKufIRjjuIDHAGNdEbgfNkGgfPSHnxt8MOhqKxuF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khNoS7BWq7Ex98xDmpqkq9piwD6HzZvi1Dpw0kif/WvX6cf53WmJ11AOi7jKZNZdm
	 w85lcYSzZyyw1Cdh7ntscKd9q43Gu6h0Ly4fBTR//AT3ItytEZNu0ihHs/KlkG+r9x
	 2JUrKF0qjZpxb9HJon37o6dNx/lDHTvxz9rYNO+23ocFAhI53JjWkO0d86HI5MAMuP
	 2iTIRN3DXpmWPaOpTAQvy//nFO6mS7PlI8MSkXjmsO6nM3Az0mjHDwIvFExdww3KmV
	 2JglaDIWbIYHlShpXGCVemuRZa4DYFCb13PNX5rC4yjuS6SXXZKh1kekrLp79sOeKf
	 jjk1Z/G5a2U1A==
Date: Tue, 8 Apr 2025 19:23:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v6 01/12] fs: add atomic write unit max opt to statx
Message-ID: <20250409022308.GJ6283@frogsfrogsfrogs>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
 <20250408104209.1852036-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408104209.1852036-2-john.g.garry@oracle.com>

This probably should have cc'd linux-api...

On Tue, Apr 08, 2025 at 10:41:58AM +0000, John Garry wrote:
> XFS will be able to support large atomic writes (atomic write > 1x block)
> in future. This will be achieved by using different operating methods,
> depending on the size of the write.
> 
> Specifically a new method of operation based in FS atomic extent remapping
> will be supported in addition to the current HW offload-based method.
> 
> The FS method will generally be appreciably slower performing than the
> HW-offload method. However the FS method will be typically able to
> contribute to achieving a larger atomic write unit max limit.
> 
> XFS will support a hybrid mode, where HW offload method will be used when
> possible, i.e. HW offload is used when the length of the write is
> supported, and for other times FS-based atomic writes will be used.
> 
> As such, there is an atomic write length at which the user may experience
> appreciably slower performance.
> 
> Advertise this limit in a new statx field, stx_atomic_write_unit_max_opt.
> 
> When zero, it means that there is no such performance boundary.
> 
> Masks STATX{_ATTR}_WRITE_ATOMIC can be used to get this new field. This is
> ok for older kernels which don't support this new field, as they would
> report 0 in this field (from zeroing in cp_statx()) already. Furthermore
> those older kernels don't support large atomic writes - apart from block
> fops, but there would be consistent performance there for atomic writes
> in range [unit min, unit max].
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Seems fine to me, but I imagine others have stronger opinions.
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  block/bdev.c              | 3 ++-
>  fs/ext4/inode.c           | 2 +-
>  fs/stat.c                 | 6 +++++-
>  fs/xfs/xfs_iops.c         | 2 +-
>  include/linux/fs.h        | 3 ++-
>  include/linux/stat.h      | 1 +
>  include/uapi/linux/stat.h | 8 ++++++--
>  7 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 4844d1e27b6f..b4afc1763e8e 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1301,7 +1301,8 @@ void bdev_statx(struct path *path, struct kstat *stat,
>  
>  		generic_fill_statx_atomic_writes(stat,
>  			queue_atomic_write_unit_min_bytes(bd_queue),
> -			queue_atomic_write_unit_max_bytes(bd_queue));
> +			queue_atomic_write_unit_max_bytes(bd_queue),
> +			0);
>  	}
>  
>  	stat->blksize = bdev_io_min(bdev);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 1dc09ed5d403..51a45699112c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5663,7 +5663,7 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
>  			awu_max = sbi->s_awu_max;
>  		}
>  
> -		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
> +		generic_fill_statx_atomic_writes(stat, awu_min, awu_max, 0);
>  	}
>  
>  	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
> diff --git a/fs/stat.c b/fs/stat.c
> index f13308bfdc98..c41855f62d22 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -136,13 +136,15 @@ EXPORT_SYMBOL(generic_fill_statx_attr);
>   * @stat:	Where to fill in the attribute flags
>   * @unit_min:	Minimum supported atomic write length in bytes
>   * @unit_max:	Maximum supported atomic write length in bytes
> + * @unit_max_opt: Optimised maximum supported atomic write length in bytes
>   *
>   * Fill in the STATX{_ATTR}_WRITE_ATOMIC flags in the kstat structure from
>   * atomic write unit_min and unit_max values.
>   */
>  void generic_fill_statx_atomic_writes(struct kstat *stat,
>  				      unsigned int unit_min,
> -				      unsigned int unit_max)
> +				      unsigned int unit_max,
> +				      unsigned int unit_max_opt)
>  {
>  	/* Confirm that the request type is known */
>  	stat->result_mask |= STATX_WRITE_ATOMIC;
> @@ -153,6 +155,7 @@ void generic_fill_statx_atomic_writes(struct kstat *stat,
>  	if (unit_min) {
>  		stat->atomic_write_unit_min = unit_min;
>  		stat->atomic_write_unit_max = unit_max;
> +		stat->atomic_write_unit_max_opt = unit_max_opt;
>  		/* Initially only allow 1x segment */
>  		stat->atomic_write_segments_max = 1;
>  
> @@ -732,6 +735,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
>  	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
>  	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
>  	tmp.stx_atomic_write_segments_max = stat->atomic_write_segments_max;
> +	tmp.stx_atomic_write_unit_max_opt = stat->atomic_write_unit_max_opt;
>  
>  	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
>  }
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 756bd3ca8e00..f0e5d83195df 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -610,7 +610,7 @@ xfs_report_atomic_write(
>  
>  	if (xfs_inode_can_atomicwrite(ip))
>  		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
> -	generic_fill_statx_atomic_writes(stat, unit_min, unit_max);
> +	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
>  }
>  
>  STATIC int
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 016b0fe1536e..7b19d8f99aff 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3475,7 +3475,8 @@ void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
>  void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
>  void generic_fill_statx_atomic_writes(struct kstat *stat,
>  				      unsigned int unit_min,
> -				      unsigned int unit_max);
> +				      unsigned int unit_max,
> +				      unsigned int unit_max_opt);
>  extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
>  extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
>  void __inode_add_bytes(struct inode *inode, loff_t bytes);
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index be7496a6a0dd..e3d00e7bb26d 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -57,6 +57,7 @@ struct kstat {
>  	u32		dio_read_offset_align;
>  	u32		atomic_write_unit_min;
>  	u32		atomic_write_unit_max;
> +	u32		atomic_write_unit_max_opt;
>  	u32		atomic_write_segments_max;
>  };
>  
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index f78ee3670dd5..1686861aae20 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -182,8 +182,12 @@ struct statx {
>  	/* File offset alignment for direct I/O reads */
>  	__u32	stx_dio_read_offset_align;
>  
> -	/* 0xb8 */
> -	__u64	__spare3[9];	/* Spare space for future expansion */
> +	/* Optimised max atomic write unit in bytes */
> +	__u32	stx_atomic_write_unit_max_opt;
> +	__u32	__spare2[1];
> +
> +	/* 0xc0 */
> +	__u64	__spare3[8];	/* Spare space for future expansion */
>  
>  	/* 0x100 */
>  };
> -- 
> 2.31.1
> 
> 

