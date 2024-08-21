Return-Path: <linux-fsdevel+bounces-26509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E0095A3A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B66284155
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AEF1B2EC0;
	Wed, 21 Aug 2024 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmUeZXxI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4458E1B251D;
	Wed, 21 Aug 2024 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260303; cv=none; b=DM8C1OPDRBxV9YpBp8ZCCCn6/9bfEVT05iSWREHUg6zPMeMXR6U+fJ85gsdPyJuObpxHey5gg1jPSH/DgaQ/tPesQfu3cIZEwGpKtWrFj3lPODdhKeEXpYwKnK/iAZiIYlKqPd0vc/Ssxbw4wsULKeA5ikcu9YLChCkUdE/jAPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260303; c=relaxed/simple;
	bh=Q/ZYQt8J4KAddQXDpV5kSx08nUISVx0DuvFwh7TcBWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNsRTLwj4c/gTJEm+V+6CrnpRgwv5r9PdUckxMJ6oVkrzDloG54xHVt9nL/PkoudEKcR2ZXTlbbW0VeW1e8zmbjlt1J75ebam9QznGiBdL0aM8d4Uu4BD4lIYp6p566Z4tHcv4c7C0iMgu+n95dQFAapH3tv41qGVtrmoKsI9tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmUeZXxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2439C32781;
	Wed, 21 Aug 2024 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724260302;
	bh=Q/ZYQt8J4KAddQXDpV5kSx08nUISVx0DuvFwh7TcBWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmUeZXxILFzgJ3Dzni0Yz4ZzH0tPrnENkhA348FndwWHPtEkqJuoKg4vgUOSXFbjA
	 6/aUMPck0mb+vYZ4LMBhnRmVCYmpAKfLf7YkWJoLtUqjc4Jos0raGuC8f8HYkis6Pk
	 Yt+UIIH2k03neOUHeAjDuUuErjopa5LOpQBoWE0NxYfx5hy17u/7LxgggygcYqIjyN
	 /oeKvrw0RUzTUHqNSa6VlpWLz/k0v1ZhVlmFGpXn1XE+rqJ7zF/NyhbZblYMsoGDnR
	 ltTQ9D605P8EQshUH9fpdAtWm2q2XR0WWvEdfLunSqbyAMnFwVEcGnlZxTzXfZesuT
	 eZBSETHO6kHKA==
Date: Wed, 21 Aug 2024 10:11:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, chandan.babu@oracle.com, dchinner@redhat.com,
	hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	kbusch@kernel.org
Subject: Re: [PATCH v5 7/7] xfs: Support setting FMODE_CAN_ATOMIC_WRITE
Message-ID: <20240821171142.GM865349@frogsfrogsfrogs>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-8-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817094800.776408-8-john.g.garry@oracle.com>

On Sat, Aug 17, 2024 at 09:48:00AM +0000, John Garry wrote:
> For when an inode is enabled for atomic writes, set FMODE_CAN_ATOMIC_WRITE
> flag. Only direct IO is currently supported, so check for that also.
> 
> We rely on the block layer to reject atomic writes which exceed the bdev
> request_queue limits, so don't bother checking any such thing here.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 9b6530a4eb4a..3489d478809e 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1149,6 +1149,18 @@ xfs_file_remap_range(
>  	return remapped > 0 ? remapped : ret;
>  }
>  
> +static bool xfs_file_open_can_atomicwrite(
> +	struct inode		*inode,
> +	struct file		*file)
> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +
> +	if (!(file->f_flags & O_DIRECT))
> +		return false;
> +
> +	return xfs_inode_has_atomicwrites(ip);

...and here too.  I do like the shift to having an incore flag that
controls whether you get untorn write support or not.

--D

> +}
> +
>  STATIC int
>  xfs_file_open(
>  	struct inode	*inode,
> @@ -1157,6 +1169,8 @@ xfs_file_open(
>  	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
>  		return -EIO;
>  	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
> +	if (xfs_file_open_can_atomicwrite(inode, file))
> +		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
>  	return generic_file_open(inode, file);
>  }
>  
> -- 
> 2.31.1
> 
> 

