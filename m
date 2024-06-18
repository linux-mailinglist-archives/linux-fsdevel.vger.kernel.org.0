Return-Path: <linux-fsdevel+bounces-21892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B9D90D918
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 18:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9AB284525
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 16:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E9B4F5EA;
	Tue, 18 Jun 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diGRBdkB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E922557F;
	Tue, 18 Jun 2024 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727808; cv=none; b=ehyftlxLXX3SwdEHZnHyKOixvutwstKyU+q0o9EYI4YqTT83xZBFJjAmKSOeyKpUTJwIXGLrc05ZvnFkzjM3WCh9UZvJYvI9/jm4SoKgXKAdfT4RDAIWG827g5Gfz6/NStFlftqLcpL1g09qtxs4mfu3XVsxHXfgGrT1MOhbMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727808; c=relaxed/simple;
	bh=yU6vnMcOu/mOPcBQIy0ybVjtgAw+/1eLWRNgxN9bzTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDOPLxLCGFA25VIv3j9AAn6buibG40UlIIjSEn5jw1RWeDK7xUOXhDif7MjBKN1VRPTni2P2bGXG7GEiNrHN8O172j3M+6/bFUxAF1cfu5odjxhm+QvwrxrwoMGi5sKQl3uzsOEySgH8GAdeWHenDrOoutvQ9bKLlL6G0y3jVTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diGRBdkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C137C3277B;
	Tue, 18 Jun 2024 16:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718727808;
	bh=yU6vnMcOu/mOPcBQIy0ybVjtgAw+/1eLWRNgxN9bzTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=diGRBdkBD8kmXiADOUD7v5q4mLrOailc48nfqA69mb53U9SfOBnXyWSa+QRT5V3YK
	 Pm1ChaGKqpTeHUuYF4LuezmIuVxWfeRgJjV9eIQTr0Qp2WFOgN2gXGCmERlmTVPq6+
	 +jMN4YO00HTT8T1NRhtCaXyjoo3UIJZvgzFsKyy1e+mNX6pYjuUjTEq5fuPRiqanXe
	 f52bWDBRjvz+Kjsmg58WSKXoCcokKfwUEVUsomBDalKXpgeZFb0B8Gv33a4/PzgMyE
	 EeWDn3TD1XQ1VSK/+8Z09NYvVALwaYgcyOkV1cB4X0J1FI5Zc3to71No/lebaOEFvq
	 DYD1jaDmjQQBQ==
Date: Tue, 18 Jun 2024 09:23:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Junchao Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	chandan.babu@oracle.com
Subject: Re: [PATCH 1/2] xfs: reorder xfs_inode structure elements to remove
 unneeded padding.
Message-ID: <20240618162327.GE103034@frogsfrogsfrogs>
References: <20240618113505.476072-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618113505.476072-1-sunjunchao2870@gmail.com>

On Tue, Jun 18, 2024 at 07:35:04PM +0800, Junchao Sun wrote:
> By reordering the elements in the xfs_inode structure, we can
> reduce the padding needed on an x86_64 system by 8 bytes.

Does this result in denser packing of xfs_inode objects in the slab
page?

--D

> Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
> ---
>  fs/xfs/xfs_inode.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 292b90b5f2ac..3239ae4e33d2 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -40,8 +40,8 @@ typedef struct xfs_inode {
>  	/* Transaction and locking information. */
>  	struct xfs_inode_log_item *i_itemp;	/* logging information */
>  	struct rw_semaphore	i_lock;		/* inode lock */
> -	atomic_t		i_pincount;	/* inode pin count */
>  	struct llist_node	i_gclist;	/* deferred inactivation list */
> +	atomic_t		i_pincount;	/* inode pin count */
>  
>  	/*
>  	 * Bitsets of inode metadata that have been checked and/or are sick.
> -- 
> 2.39.2
> 
> 

