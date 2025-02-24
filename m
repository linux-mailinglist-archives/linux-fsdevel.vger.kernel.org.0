Return-Path: <linux-fsdevel+bounces-42496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6547A42DAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593253B2790
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE24242911;
	Mon, 24 Feb 2025 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEv/LVYV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9E1F03C1;
	Mon, 24 Feb 2025 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428697; cv=none; b=P68dR9R5XY1I4Ecgjvl53ADO/PiJlPVpDhsghtnTpJuLqqzIQWc2X1oZeAUMp3foLtMHNAte3kWhmWJ3LfnGP9duUvetDGxIM/3RGTF3Zf+71FGeJQEACut2u+BYs6+pz8Zs+zFy1K4H3ctIdbJduimldoslJejG+6gFF4LnHWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428697; c=relaxed/simple;
	bh=l/MFWRud7t098wBF/lfw4tADHECtkN/XfyIu1vGbRN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teIu2tYkT4RzCQIKTwQNoACCK50AxxcG6kby0yNUkq7f1re2B54ypPV7pmBB6NFPcez8qqX6yEPEp5ywXkxu8qNTmOSU5kicUbWbYC1PHN6eHCkyF3gjXmZoMqQk9YplTM50aXOVwvdwcHfhH6v2Tqe7YJPXgHN5yJdszWocbFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEv/LVYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7FCC4CED6;
	Mon, 24 Feb 2025 20:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740428697;
	bh=l/MFWRud7t098wBF/lfw4tADHECtkN/XfyIu1vGbRN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEv/LVYV01fznWakAPZ7d8CBqh7z4AoBnyC7JvA8XRt2rUH/Mk5C8D4Qie4r76V7G
	 SWeKD1a+0kXrJqBlXGXjyK0Cl9hvN3iSrgnkX+OMOAOcfoDmnVF+kizrgaJmmdC+Xa
	 muJDMflN1fnx6OcefuSNnH4TKXQTfkHIlawHDQutTGRqnXVgs7MdQiMDiYN9BqIN9o
	 Ch2ijyo/iBKActHFKncLadJaVLiV7FErERWXTlqmqyPvDjiIbdrzKIQKhwAKgvgsLo
	 dTLDR+epirpTFDxaQBUeVZusfRTBDJV8AVglfoxoM8Ie5WmkmyXBuiZpS7ioWJDv+A
	 a+tO7fQKi0eoQ==
Date: Mon, 24 Feb 2025 12:24:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 02/11] xfs: Switch atomic write size check in
 xfs_file_write_iter()
Message-ID: <20250224202456.GG21808@frogsfrogsfrogs>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213135619.1148432-3-john.g.garry@oracle.com>

On Thu, Feb 13, 2025 at 01:56:10PM +0000, John Garry wrote:
> Currently the size of atomic write allowed is fixed at the blocksize.
> 
> To start to lift this restriction, refactor xfs_get_atomic_write_attr()
> to into a helper - xfs_report_atomic_write() - and use that helper to
> find the per-inode atomic write limits and check according to that.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks fine,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c | 12 +++++-------
>  fs/xfs/xfs_iops.c | 20 +++++++++++++++++---
>  fs/xfs/xfs_iops.h |  3 +++
>  3 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index f7a7d89c345e..258c82cbce12 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -853,14 +853,12 @@ xfs_file_write_iter(
>  		return xfs_file_dax_write(iocb, from);
>  
>  	if (iocb->ki_flags & IOCB_ATOMIC) {
> -		/*
> -		 * Currently only atomic writing of a single FS block is
> -		 * supported. It would be possible to atomic write smaller than
> -		 * a FS block, but there is no requirement to support this.
> -		 * Note that iomap also does not support this yet.
> -		 */
> -		if (ocount != ip->i_mount->m_sb.sb_blocksize)
> +		unsigned int	unit_min, unit_max;
> +
> +		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
> +		if (ocount < unit_min || ocount > unit_max)
>  			return -EINVAL;
> +
>  		ret = generic_atomic_write_valid(iocb, from);
>  		if (ret)
>  			return ret;
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 40289fe6f5b2..ea79fb246e33 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -600,15 +600,29 @@ xfs_report_dioalign(
>  		stat->dio_offset_align = stat->dio_read_offset_align;
>  }
>  
> +void
> +xfs_get_atomic_write_attr(
> +	struct xfs_inode	*ip,
> +	unsigned int		*unit_min,
> +	unsigned int		*unit_max)
> +{
> +	if (!xfs_inode_can_atomicwrite(ip)) {
> +		*unit_min = *unit_max = 0;
> +		return;
> +	}
> +
> +	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
> +}
> +
>  static void
>  xfs_report_atomic_write(
>  	struct xfs_inode	*ip,
>  	struct kstat		*stat)
>  {
> -	unsigned int		unit_min = 0, unit_max = 0;
> +	unsigned int		unit_min, unit_max;
> +
> +	xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
>  
> -	if (xfs_inode_can_atomicwrite(ip))
> -		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
>  	generic_fill_statx_atomic_writes(stat, unit_min, unit_max);
>  }
>  
> diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
> index 3c1a2605ffd2..ce7bdeb9a79c 100644
> --- a/fs/xfs/xfs_iops.h
> +++ b/fs/xfs/xfs_iops.h
> @@ -19,5 +19,8 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
>  extern void xfs_setup_inode(struct xfs_inode *ip);
>  extern void xfs_setup_iops(struct xfs_inode *ip);
>  extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
> +void xfs_get_atomic_write_attr(struct xfs_inode *ip,
> +		unsigned int *unit_min, unsigned int *unit_max);
> +
>  
>  #endif /* __XFS_IOPS_H__ */
> -- 
> 2.31.1
> 
> 

