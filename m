Return-Path: <linux-fsdevel+bounces-26508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E103B95A39E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9B2BB21B27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C8A1B5309;
	Wed, 21 Aug 2024 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOWylYw7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525651B252B;
	Wed, 21 Aug 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260232; cv=none; b=K6InvTAuDvPbv+DX1CYXwRvknPbT+Y2UKUNhpTvea9HDbsJBm5RPHoCFh8jATMhmKZzh4FftbqHwcxYeAUuywzlQVHCEr2rBys6Rkj0J5lcRoAhWt87qLqz8cAa2p+hf0WZiXWcdD+Cf/DM/EY+hhoOoOCeTv+nO8Bg6JKmH9Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260232; c=relaxed/simple;
	bh=6+hagwQZKzS5uTRWslKDye7xDTbQCXqNR+BuPmuN4MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gacz6U/WwqNJP3z4MUar5ZDL9Sg66CxYfTmi4hn0q+X0h7kNwkxDCy5mWaBFMTWn6ftugWIlNtaT4q/jHeS+isXqpMAyXzhLg7WlnTCmUDGnIKnYzw193/twcgHY/A+XstQkmo5O49aVNib7uussnU3UmQLPJyFhIfoMwcsmq+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOWylYw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2B4C32781;
	Wed, 21 Aug 2024 17:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724260231;
	bh=6+hagwQZKzS5uTRWslKDye7xDTbQCXqNR+BuPmuN4MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOWylYw7VNEVeDhgWayz9fPffIMIlSoNLuyAd1XPunhvgin9J9JgpS5+N+7s4F3Ux
	 6D6MW8l+TSRJMiE2z+gjaE8wCf537y5IGzJ5BrKE8X3/6Ldue7shgc9hv4nlS91mGi
	 fmqyQgqqucbG/KaCXrXgoCP5V88/aos07MRqHCsj6UA/IcSi32Ai29ktoobuo2k1xx
	 5myJoj8k63vNKCpNrrBCkdSi9C2EbAMDZa/4wuyzw06fp8RSUEwoWHDMJFpEVEjlK3
	 CwPWMrObvnVLWuibYL0DEHK0pKvdVBXtEhWieMNNN6wTqTXj/InjbUZU7XQmaFAnG2
	 nYtH5nkerRkJA==
Date: Wed, 21 Aug 2024 10:10:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, chandan.babu@oracle.com, dchinner@redhat.com,
	hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	kbusch@kernel.org
Subject: Re: [PATCH v5 6/7] xfs: Validate atomic writes
Message-ID: <20240821171031.GL865349@frogsfrogsfrogs>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-7-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817094800.776408-7-john.g.garry@oracle.com>

On Sat, Aug 17, 2024 at 09:47:59AM +0000, John Garry wrote:
> Validate that an atomic write adheres to length/offset rules. Since we
> require extent alignment for atomic writes, this effectively also enforces
> that the BIO which iomap produces is aligned.
> 
> For an IOCB with IOCB_ATOMIC set to get as far as xfs_file_dio_write(),
> FMODE_CAN_ATOMIC_WRITE will need to be set for the file; for this,
> FORCEALIGN and also ATOMICWRITES flags would also need to be set for the
> inode.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 4cdc54dc9686..9b6530a4eb4a 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -684,9 +684,20 @@ xfs_file_dio_write(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*from)
>  {
> -	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
> +	struct inode		*inode = file_inode(iocb->ki_filp);
> +	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
>  	size_t			count = iov_iter_count(from);
> +	struct xfs_mount	*mp = ip->i_mount;
> +
> +	if (iocb->ki_flags & IOCB_ATOMIC) {
> +		if (count < i_blocksize(inode))
> +			return -EINVAL;
> +		if (count > XFS_FSB_TO_B(mp, ip->i_extsize))
> +			return -EINVAL;

Here's also the place to check the dynamic things like dalign/swidth
alignment.  Other than that, this looks good.

--D

> +		if (!generic_atomic_write_valid(iocb, from))
> +			return -EINVAL;
> +	}
>  
>  	/* direct I/O must be aligned to device logical sector size */
>  	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
> -- 
> 2.31.1
> 
> 

