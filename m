Return-Path: <linux-fsdevel+bounces-26496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200FA95A2AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93750B266DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB41F14F13A;
	Wed, 21 Aug 2024 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaXEs3GN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C80F139597;
	Wed, 21 Aug 2024 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257180; cv=none; b=UJzZvLW/QPJoq4JDUDGy70USzUOZo75Jl4sPkE+SFfL05fUOXB+H8YmSfZhTI3vzoIl0D8CR0VGvcqNmXAtQ+dZFk/UVOwz+pqLcOeFNJZGg60n02/XkhjT9CWG7iYeBwixt0ZEr8b5xGbS86Iz9ytuY10KjN/QRGSUS1gSVa5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257180; c=relaxed/simple;
	bh=OClUNMuUaEsOuuemntmYvckMZOeB5Md+vVB+ePxIrOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGFC+tU+EbUZhy7MwJ2d93GKckEbNKptFVUyOR/VxooFge2qlstFH0a05tZFXwfo+ZwGzBaIzNCXyQCud6yGjL76NFd5tCy58QCE4KhOSQegFwqR5pQXbvQeBajZ6IyM08FgQVKnkzu3ESPZcwoXForUBHdy61zXGfnxlQuanbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaXEs3GN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89719C32781;
	Wed, 21 Aug 2024 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724257179;
	bh=OClUNMuUaEsOuuemntmYvckMZOeB5Md+vVB+ePxIrOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NaXEs3GN1UurP62B20P8bKtWE4Nzo4ejsW/gP7sbpABzvPPueF/W+Sp4yNY7mcLk6
	 uhuRDlnKJ5ilzoAVLsrudYnmqmoGGg/pOtohvShOgrg11ouvl/eHlVoCh42UEgoC59
	 Xz2z+5q1g5ZUeIvFHHnDwFFLRFBHuVEHfhIQy3CnDkq61YQGkZ0HQzxzI7gQ1nzAS/
	 RFEEfTg5DC+5az0h/lJTZhA3OaHW1bvsnb2N+cUf71KxdCOa7XjHKqB1yUEnHdimqZ
	 LO8dVA57VhYuaKeW/usRLCpi+U4P6PIHTMe2SK0DoAdbpvqYTYr4AkaBOpuEFH21//
	 MCGelnwlnew9Q==
Date: Wed, 21 Aug 2024 09:19:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] xfs: use kfree_rcu_mightsleep to free the perag
 structures
Message-ID: <20240821161939.GC865349@frogsfrogsfrogs>
References: <20240821063901.650776-1-hch@lst.de>
 <20240821063901.650776-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821063901.650776-2-hch@lst.de>

On Wed, Aug 21, 2024 at 08:38:28AM +0200, Christoph Hellwig wrote:
> Using the kfree_rcu_mightsleep is simpler and removes the need for a
> rcu_head in the perag structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/libxfs/xfs_ag.c | 12 +-----------
>  fs/xfs/libxfs/xfs_ag.h |  3 ---
>  2 files changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
> index 7e80732cb54708..4b5a39a83f7aed 100644
> --- a/fs/xfs/libxfs/xfs_ag.c
> +++ b/fs/xfs/libxfs/xfs_ag.c
> @@ -235,16 +235,6 @@ xfs_initialize_perag_data(
>  	return error;
>  }
>  
> -STATIC void
> -__xfs_free_perag(
> -	struct rcu_head	*head)
> -{
> -	struct xfs_perag *pag = container_of(head, struct xfs_perag, rcu_head);
> -
> -	ASSERT(!delayed_work_pending(&pag->pag_blockgc_work));
> -	kfree(pag);
> -}
> -
>  /*
>   * Free up the per-ag resources associated with the mount structure.
>   */
> @@ -270,7 +260,7 @@ xfs_free_perag(
>  		xfs_perag_rele(pag);
>  		XFS_IS_CORRUPT(pag->pag_mount,
>  				atomic_read(&pag->pag_active_ref) != 0);
> -		call_rcu(&pag->rcu_head, __xfs_free_perag);
> +		kfree_rcu_mightsleep(pag);

I started wondering, have you seen any complaints from might_sleep when
freeing pags after a failed growfs?  Then I wondered if growfs_data
could actually take any locks that would prevent sleeping, which led me
to another question: why do growfs_{data,log} hold m_growlock but
growfs_rt doesn't?  Is that actually safe?

I think the kfree_rcu_mightsleep conversion is ok, but I want to see if
anything blows up with the rtgroups variant.

--D

>  	}
>  }
>  
> diff --git a/fs/xfs/libxfs/xfs_ag.h b/fs/xfs/libxfs/xfs_ag.h
> index 35de09a2516c70..d62c266c0b44d5 100644
> --- a/fs/xfs/libxfs/xfs_ag.h
> +++ b/fs/xfs/libxfs/xfs_ag.h
> @@ -63,9 +63,6 @@ struct xfs_perag {
>  	/* Blocks reserved for the reverse mapping btree. */
>  	struct xfs_ag_resv	pag_rmapbt_resv;
>  
> -	/* for rcu-safe freeing */
> -	struct rcu_head	rcu_head;
> -
>  	/* Precalculated geometry info */
>  	xfs_agblock_t		block_count;
>  	xfs_agblock_t		min_block;
> -- 
> 2.43.0
> 
> 

