Return-Path: <linux-fsdevel+bounces-27616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5517962D91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 18:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECEBC1C2363F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17BA18DF8A;
	Wed, 28 Aug 2024 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4ZLjAl+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9B613C3F2;
	Wed, 28 Aug 2024 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862183; cv=none; b=LmpOMEh20yJJadCAK169h/tNcu+ra3f2hCXju20hRswqKQxnXJlC0YHquavwk/Ghr5ZiElFAuo0LWWUCTDm+sCZlp28DqzP8MaFH38I7frHiqws7z/h1O798/Rpb7yc5LS+rSznzwuc2/UfSSqKKvJwlJQxgjv4wiuyglcp083I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862183; c=relaxed/simple;
	bh=0xg2mrvANR6MAgnTeH06IuIinfx6nFD7qOmo9eS/8ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhUsHKfKQTjTWd2irO7f9C6gkp86j3KYs1X6ueVm5mW01gUm/7n9sabJvYezvWuLsp9WCfx5B4ndpBWle7vB63tCyzOAT21pcBOmMdZXvrYZaURip36EcHSj/0B8mfphVxjcG84PLoVvljCqMDDJmutUlS4ho7WzRNCuKvuhdbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4ZLjAl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA36CC4CEC6;
	Wed, 28 Aug 2024 16:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724862182;
	bh=0xg2mrvANR6MAgnTeH06IuIinfx6nFD7qOmo9eS/8ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4ZLjAl+skl8MQYXUAlIcwGXt/jv7qONYyI2ZFcrIJfyrf8HfMjU1R1PrrjcCaZjf
	 Z6ROEfjsPhCJ9JwtC1GkZF2HQ98R8rvNT9+UzNdOcImVZ8nJG8UZCaBj6JvUecDaLx
	 LGQmvooFSPmJ2QfRfEMG5eHXTnEJMaCKrI63NHli2OceRcnnh0ZvklJkNIx+cCBRH1
	 JK19LzlD559ndaxSX4DqRlRx12EMvXshk8wUqe2bNW33elTZr3s8/rusmsIsyfkhKR
	 xQ+GxnCLEXLtDYXNh/c3OHQehDamdSKtvV/0tKWuzI6240wu7651NMa0BTYe33Buok
	 W/idSWqWWCnNA==
Date: Wed, 28 Aug 2024 09:23:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs: report the correct read/write dio alignment for
 reflinked inodes
Message-ID: <20240828162302.GL1977952@frogsfrogsfrogs>
References: <20240828051149.1897291-1-hch@lst.de>
 <20240828051149.1897291-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828051149.1897291-4-hch@lst.de>

On Wed, Aug 28, 2024 at 08:11:03AM +0300, Christoph Hellwig wrote:
> For I/O to reflinked blocks we always need to write an entire new
> file system block, and the code enforces the file system block alignment
> for the entire file if it has any reflinked blocks.
> 
> Use the new STATX_DIO_READ_ALIGN flag to report the asymmetric read
> vs write alignments for reflinked files.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_iops.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 1cdc8034f54d93..de2fc12688dc23 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -570,6 +570,33 @@ xfs_stat_blksize(
>  	return PAGE_SIZE;
>  }
>  
> +static void
> +xfs_report_dioalign(
> +	struct xfs_inode	*ip,
> +	struct kstat		*stat)
> +{
> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +	struct block_device	*bdev = target->bt_bdev;
> +
> +	stat->result_mask |= STATX_DIOALIGN | STATX_DIO_READ_ALIGN;
> +	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
> +	stat->dio_read_offset_align = bdev_logical_block_size(bdev);
> +
> +	/*
> +	 * On COW inodes we are forced to always rewrite an entire file system
> +	 * block.
> +	 *
> +	 * Because applications assume they can do sector sized direct writes
> +	 * on XFS we provide an emulation by doing a read-modify-write cycle
> +	 * through the cache, but that is highly inefficient.  Thus report the
> +	 * natively supported size here.
> +	 */
> +	if (xfs_is_cow_inode(ip))
> +		stat->dio_offset_align = ip->i_mount->m_sb.sb_blocksize;

xfs_inode_alloc_unitsize(), since we can only cow full allocation units.

(Not necessary today, but we might as well make it work for rtreflink
from the start.)

--D

> +	else
> +		stat->dio_offset_align = stat->dio_read_offset_align;
> +}
> +
>  STATIC int
>  xfs_vn_getattr(
>  	struct mnt_idmap	*idmap,
> @@ -635,14 +662,8 @@ xfs_vn_getattr(
>  		stat->rdev = inode->i_rdev;
>  		break;
>  	case S_IFREG:
> -		if (request_mask & STATX_DIOALIGN) {
> -			struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> -			struct block_device	*bdev = target->bt_bdev;
> -
> -			stat->result_mask |= STATX_DIOALIGN;
> -			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
> -			stat->dio_offset_align = bdev_logical_block_size(bdev);
> -		}
> +		if (request_mask & (STATX_DIOALIGN | STATX_DIO_READ_ALIGN))
> +			xfs_report_dioalign(ip, stat);
>  		fallthrough;
>  	default:
>  		stat->blksize = xfs_stat_blksize(ip);
> -- 
> 2.43.0
> 
> 

