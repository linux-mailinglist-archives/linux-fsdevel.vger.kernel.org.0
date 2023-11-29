Return-Path: <linux-fsdevel+bounces-4135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EEE7FCF24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 07:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252D71C20F60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884C7101EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+JcHttB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B716363AC;
	Wed, 29 Nov 2023 04:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3723BC433C7;
	Wed, 29 Nov 2023 04:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701232903;
	bh=VcdsiaqZ4IEDNviJ01jqnZDZsvSxxjjBXasVkDAR0Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+JcHttBKSFUtyqLJwXhkxCVYWJzgewRk45xnKqNd8ouvTEt3e8+WErM2lEq28Ngo
	 KdC9qb7DpX+SqszVmXNPTFKreiZ6P+vx6OqWubxY4aZlDWG4xhV0PjVJgFVvwNNOyP
	 OpW/qXcNqnrgqjR80xRH9Wc6acgrTW17FuN01yOBGUJudEPDtpAYDALWXRZpV6gLA9
	 yHp7GeN2zszSUNnkHTYl9lsiDJ2tDaBUdo3BQKa+SN6lg6T78MV1IMuU+braaOtjpn
	 WMbQiNvmSTwH/+vN3eLGDUVTUugMnA1wP6DqYaQZNP6r32h+nD3zSMjIfAhHVcDHwO
	 Yzs6btXIySYxg==
Date: Tue, 28 Nov 2023 20:41:42 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/13] iomap: move the io_folios field out of struct
 iomap_ioend
Message-ID: <20231129044142.GI4167244@frogsfrogsfrogs>
References: <20231126124720.1249310-1-hch@lst.de>
 <20231126124720.1249310-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126124720.1249310-4-hch@lst.de>

On Sun, Nov 26, 2023 at 01:47:10PM +0100, Christoph Hellwig wrote:
> The io_folios member in struct iomap_ioend counts the number of folios
> added to an ioend.  It is only used at submission time and can thus be
> moved to iomap_writepage_ctx instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

LGTM
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 7 ++++---
>  include/linux/iomap.h  | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index b1bcc43baf0caf..b28c57f8603303 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1685,10 +1685,11 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
>  	ioend->io_flags = wpc->iomap.flags;
>  	ioend->io_inode = inode;
>  	ioend->io_size = 0;
> -	ioend->io_folios = 0;
>  	ioend->io_offset = offset;
>  	ioend->io_bio = bio;
>  	ioend->io_sector = sector;
> +
> +	wpc->nr_folios = 0;
>  	return ioend;
>  }
>  
> @@ -1732,7 +1733,7 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
>  	 * also prevents long tight loops ending page writeback on all the
>  	 * folios in the ioend.
>  	 */
> -	if (wpc->ioend->io_folios >= IOEND_BATCH_SIZE)
> +	if (wpc->nr_folios >= IOEND_BATCH_SIZE)
>  		return false;
>  	return true;
>  }
> @@ -1829,7 +1830,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		count++;
>  	}
>  	if (count)
> -		wpc->ioend->io_folios++;
> +		wpc->nr_folios++;
>  
>  	WARN_ON_ONCE(!wpc->ioend && !list_empty(&submit_list));
>  	WARN_ON_ONCE(!folio_test_locked(folio));
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 96dd0acbba44ac..b2a05dff914d0c 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -293,7 +293,6 @@ struct iomap_ioend {
>  	struct list_head	io_list;	/* next ioend in chain */
>  	u16			io_type;
>  	u16			io_flags;	/* IOMAP_F_* */
> -	u32			io_folios;	/* folios added to ioend */
>  	struct inode		*io_inode;	/* file being written to */
>  	size_t			io_size;	/* size of the extent */
>  	loff_t			io_offset;	/* offset in the file */
> @@ -329,6 +328,7 @@ struct iomap_writepage_ctx {
>  	struct iomap		iomap;
>  	struct iomap_ioend	*ioend;
>  	const struct iomap_writeback_ops *ops;
> +	u32			nr_folios;	/* folios added to the ioend */
>  };
>  
>  void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
> -- 
> 2.39.2
> 
> 

