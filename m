Return-Path: <linux-fsdevel+bounces-43587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7A6A590BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 11:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF3116C60F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F1722578E;
	Mon, 10 Mar 2025 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9GKbAz7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56732253EC;
	Mon, 10 Mar 2025 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601174; cv=none; b=OP6f6EhOoPTTuOmw5DiD0al4RjvY3ducF2NuF0COw56pXMGkdEPvi1UBKou3VfNMfx9Bo4n8NLiWrbpG2uLIPMFbZwpLMjcIoW58Qm3i8gKjQbmA87FRGx99bOyjx+VrcK1OHkjRwuuOJtBj+GKeKa86fvnW+FbrMy4vcVfUWrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601174; c=relaxed/simple;
	bh=hP2uUw8I8mbMn2yNz3/uwyIxABFOv5u58HBG32GXAl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/og09s4zi6mFXDLs1276zukpz8YgvTajSfsQdtXsn0lfGjouj5KTXJDcNHmS1AZdZOPc/+zLnBToYlMZvISfCCbw9/L7NgZcQCTdTn/k1opA3LCgtIrC7dJ3TOdkOKZbHwcWCprwGEWEZnKW22FmO2YjaDKlCzzByh/LsdzJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9GKbAz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C343DC4CEE5;
	Mon, 10 Mar 2025 10:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741601174;
	bh=hP2uUw8I8mbMn2yNz3/uwyIxABFOv5u58HBG32GXAl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9GKbAz70zpGllrnCpfsX2csmTb4K9W/vm7OhjijcPXbQES+OwRob6jgbbDN/PU0m
	 tD7Cd201qFfaCebbzoAFaztXjhlE/G7Ebl7UTbtYNqGVp15bBK/BoCsylzysw8ddRF
	 BzerdPTJwit9QiydxEEMVxMViLGl1pLOXJQKcwyKGoFCvF7Tw8kUL164GZcMLZrnAF
	 gXCeMkKpDwPiEif48MlMftai2X2PYEUspi+ub90AdpT2qRMugMVLTbaYw5gfwJhsyV
	 q3gFV0p7sXX+ZQzheW8ZuFhnyFBh2opWmnPJqsPxjcCijxHw5Onoii0QYmtAbcBvSg
	 jYs+f05xe7iPA==
Date: Mon, 10 Mar 2025 11:06:08 +0100
From: Carlos Maiolino <cem@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, 
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu, 
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 11/12] xfs: Update atomic write max size
Message-ID: <bed7wptkueyxnjvaq4isizybxsagh7vb7nx7efcyamvtzbot5p@oqrij3ahq3vl>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <2LEUjvzJ3RO3jyirsnti2pPKtOuVZZt-wKhzIi2mfCPwOESoN_SuN9GjHA4Iu_C4LRZQxiZ6dF__eT6u-p8CdQ==@protonmail.internalid>
 <20250303171120.2837067-12-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303171120.2837067-12-john.g.garry@oracle.com>

Hi John.

On Mon, Mar 03, 2025 at 05:11:19PM +0000, John Garry wrote:
> Now that CoW-based atomic writes are supported, update the max size of an
> atomic write.
> 
> For simplicity, limit at the max of what the mounted bdev can support in
> terms of atomic write limits. Maybe in future we will have a better way
> to advertise this optimised limit.
> 
> In addition, the max atomic write size needs to be aligned to the agsize.
> Limit the size of atomic writes to the greatest power-of-two factor of the
> agsize so that allocations for an atomic write will always be aligned
> compatibly with the alignment requirements of the storage.
> 
> For RT inode, just limit to 1x block, even though larger can be supported
> in future.
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_iops.c  | 13 ++++++++++++-
>  fs/xfs/xfs_mount.c | 28 ++++++++++++++++++++++++++++
>  fs/xfs/xfs_mount.h |  1 +
>  3 files changed, 41 insertions(+), 1 deletion(-)
> 

> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index fbed172d6770..bc96b8214173 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -198,6 +198,7 @@ typedef struct xfs_mount {
>  	bool			m_fail_unmount;
>  	bool			m_finobt_nores; /* no per-AG finobt resv. */
>  	bool			m_update_sb;	/* sb needs update in mount */
> +	xfs_extlen_t		awu_max;	/* data device max atomic write */

Could you please rename this to something else? All fields within xfs_mount
follows the same pattern m_<name>. Perhaps m_awu_max?

I was going to send a patch replacing it once I had this merged, but giving
Dave's new comments, and the conflicts with zoned devices, you'll need to send a
V5, so, please include this change if nobody else has any objections on keeping
the xfs_mount naming convention.

Carlos.

> 
>  	/*
>  	 * Bitsets of per-fs metadata that have been checked and/or are sick.
> --
> 2.31.1
> 

