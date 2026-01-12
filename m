Return-Path: <linux-fsdevel+bounces-73326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF9DD15998
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 23:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5600C30210F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 22:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5B22BF006;
	Mon, 12 Jan 2026 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQE5rwgR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1048A283FEF;
	Mon, 12 Jan 2026 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768257734; cv=none; b=uOYRLjPhyPvNwXtU/0XDa5CeE3F9U2+4GAgnTqzaStcE12EAc9gQRX+hl2+Wcv8OABCJEzllhBtH/HN/PwWlJ2bRPKRAi8iN0st6Npa/avi0M8b8wff94bxOyqQT7kKAaL+4a1B16hxWM36Hx66dCfUXsdWW9In8jzOBQtgf1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768257734; c=relaxed/simple;
	bh=gu0CyP6MnpGZ4d+f9Ib+xdPtkM9EpkKMQGUMquC8Nno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bA2Vma0bHK3If4i8VT9KnzIasrh7EAJrbpNQDX6zqU5SRVX6LOcypE6adTRllwtL8yDkmzwyhIU4lBuZZyA68fIPRPsod8W6eE+7XO7faGJnSZalnhDdJ1egKzRBAq7BSZEwsjHhWJT2eNB/wd/qQipoYymGtkyVhLOV4JxPI04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQE5rwgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D515AC116D0;
	Mon, 12 Jan 2026 22:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768257733;
	bh=gu0CyP6MnpGZ4d+f9Ib+xdPtkM9EpkKMQGUMquC8Nno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQE5rwgRliWMgDdfdn0yj2fPU+Q2OGKob+r8S2ji9Czs6tHZJu18HUx7ghD7CyqL/
	 P285v4AL22BkgfEgTnDS0UaMB9/ojtT04xwSNLrtVYAEG9mgYAfisGS/a6mtG3Fafb
	 NHA5iu0XIw0AIVkr6KS901wceB7fxuVfRT/Jj3y942dPeyviUsMoniHsO5Qh4JbYEQ
	 TNLhz2JFouqINCumbuv/5iD4vk50drJGeO0B0EH6frdWFfwrPFk3jHueBF7mYNNxrD
	 ZsZVEAbh3JK6OBF2zDu81zL5kuVoCnvXVKHlXvSeJMZ/pfswm7XXZSi0lckN7K34Uk
	 BGR/f++ze32JA==
Date: Mon, 12 Jan 2026 14:42:13 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 12/22] xfs: introduce XFS_FSVERITY_CONSTRUCTION inode
 flag
Message-ID: <20260112224213.GN15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <bfcg5hug75qtvc2psw5yymfoudnz2uda3gg5dfzgnze46hwt6n@u67n3rdzzuo4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfcg5hug75qtvc2psw5yymfoudnz2uda3gg5dfzgnze46hwt6n@u67n3rdzzuo4>

On Mon, Jan 12, 2026 at 03:51:16PM +0100, Andrey Albershteyn wrote:
> Add new flag meaning that merkle tree is being build on the inode.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Seems fine to me, with one nit below
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_inode.h | 6 ++++++
>  1 file changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index f149cb1eb5..9373bf146a 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -420,6 +420,12 @@
>   */
>  #define XFS_IREMAPPING		(1U << 15)
>  
> +/*
> + * fs-verity's Merkle tree is under construction. The file is read-only, the
> + * only writes happening is the ones with Merkle tree blocks.

"..the only writes happening are for the fsverity metadata."

since fsverity could in theory someday write more than just a merkle
tree and a descriptor.

--D

> + */
> +#define XFS_VERITY_CONSTRUCTION	(1U << 16)
> +
>  /* All inode state flags related to inode reclaim. */
>  #define XFS_ALL_IRECLAIM_FLAGS	(XFS_IRECLAIMABLE | \
>  				 XFS_IRECLAIM | \
> 
> -- 
> - Andrey
> 
> 

