Return-Path: <linux-fsdevel+bounces-77648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF6yOuRHlmmCdQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:14:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FF815AD8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEA9E30B6B19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0CF33A9D8;
	Wed, 18 Feb 2026 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep04s/HP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83133A9DE;
	Wed, 18 Feb 2026 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771456249; cv=none; b=UMPclJ1CH3+g1kkbJr1KF7h91yhU5s2azzcAQgAFEART8RyJLREb75mcDePYN3S89LX+toGV8D4n7+if4fMpgOZfBzezREpST0hospkgvkcqutKV6a0bUdU62VIMPxcJPuzKz8DV3kLf65LvPsEdjtH2zsJ0i/bIeum5Ou853SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771456249; c=relaxed/simple;
	bh=0G5vrtKngOdn0wSJEfvE7DcNkyO0ythRUY1m2Vdu3ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRkJ+e49E6VBFrYkmqUPEnoDdYtw13P00MtgssitGN2zXS4nL6PMQq2AlP2g4dYzswI3WxDS+qrJzyoAaesj/zwywKPhRU34ir+cfl3K99eAIngx7nddUKQ0rJ9ZiNgjRJWhOtSI70wjkZdyByqIgRpFyG557HusMOkD5zQgwL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ep04s/HP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9C0C116D0;
	Wed, 18 Feb 2026 23:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771456248;
	bh=0G5vrtKngOdn0wSJEfvE7DcNkyO0ythRUY1m2Vdu3ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ep04s/HP2YZ7wG4tK34Kc5hr+g3YFG6pLFz5xqGghWEgY2LqajfzMPiMazMTfxdN4
	 PuJ8MXTIwU9jEaiSZRiDMJ5Nt9pYmE/IrqVXShSirsHNNB2wCTqLP7Si7MMrKc8ZAf
	 5pLj5vl9v1KFHL8CQAKUhwMa3PZjpnZ0hku1H9B7lCUZbhs8HNjE/q2fNadYs5rDtI
	 FT7KJNMJwcE+IxbNBtnwAWMbBO+7PlSxzmYiljpypxeIYvYQitphXxT/1F/IzufvTY
	 dxkRkxSG2rnguDgm50IKdbezh38M7iFkXp30z1EF4rTWmHqp8DdsbixEnpm1YLJVtH
	 mXzLnKagnfqCA==
Date: Wed, 18 Feb 2026 15:10:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH v3 19/35] xfs: introduce XFS_FSVERITY_CONSTRUCTION inode
 flag
Message-ID: <20260218231048.GJ6467@frogsfrogsfrogs>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-20-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217231937.1183679-20-aalbersh@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77648-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90FF815AD8C
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:19:19AM +0100, Andrey Albershteyn wrote:
> Add new flag meaning that merkle tree is being build on the inode.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Seems fine to me, though this could just be in whatever patch actually
starts using it.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_inode.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index bd6d33557194..6df48d68a919 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -415,6 +415,12 @@ static inline bool xfs_inode_can_sw_atomic_write(const struct xfs_inode *ip)
>   */
>  #define XFS_IREMAPPING		(1U << 15)
>  
> +/*
> + * fs-verity's Merkle tree is under construction. The file is read-only, the
> + * only writes happening are for the fsverity metadata.
> + */
> +#define XFS_VERITY_CONSTRUCTION	(1U << 16)
> +
>  /* All inode state flags related to inode reclaim. */
>  #define XFS_ALL_IRECLAIM_FLAGS	(XFS_IRECLAIMABLE | \
>  				 XFS_IRECLAIM | \
> -- 
> 2.51.2
> 
> 

