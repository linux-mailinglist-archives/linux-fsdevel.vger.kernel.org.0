Return-Path: <linux-fsdevel+bounces-4143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B0D7FCF30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 07:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26037282295
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DEB11714
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1KifegR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B95D3D8F;
	Wed, 29 Nov 2023 05:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E005C433C7;
	Wed, 29 Nov 2023 05:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701234203;
	bh=SWuijgDPVJI7uOvU5s0WR8OhQFyKIH1KAQrrEHtNv7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1KifegRB6MYbd5+Vhd8iUCn629Yvgz0RfEax0kM+6NrhGd5K8qcZsjcgMHZXxpsK
	 aO7NvrpGJiXm4dsDy8MQ6gOebiwZO0BDqoXsUi6CSdGNK+QE3TGZh3gVk3P1D6c/T3
	 27CgdYq/FJZSQeXE8oL+OK++XToFcvBi1II+Ocxh3okCjQCZMceYDjsbJsU19xuNSN
	 c/DM3SSHVoYFg66UzSFhCdk/Ud8niaIZHj2kfUVhkLcmm2YAR3Mh/9egrFAPiu8ART
	 sAd/e5js5rZ0GAJo7QpEZyZR0B6l4cnwZkyIuowtqxHgUPFCVM5KQguKzUqlnLY5Hc
	 pF7Jwc44qqfNA==
Date: Tue, 28 Nov 2023 21:03:22 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/13] iomap: only call mapping_set_error once for each
 failed bio
Message-ID: <20231129050322.GP4167244@frogsfrogsfrogs>
References: <20231126124720.1249310-1-hch@lst.de>
 <20231126124720.1249310-11-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126124720.1249310-11-hch@lst.de>

On Sun, Nov 26, 2023 at 01:47:17PM +0100, Christoph Hellwig wrote:
> Instead of clling mapping_set_error once per folio, only do that once
> per bio, and consolidate all the writeback error handling code in
> iomap_finish_ioend.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 17760f3e67c61e..e1d5076251702d 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1464,15 +1464,10 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
>  EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
>  
>  static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
> -		size_t len, int error)
> +		size_t len)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  
> -	if (error) {
> -		folio_set_error(folio);
> -		mapping_set_error(inode->i_mapping, error);
> -	}
> -
>  	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
>  	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
>  
> @@ -1493,18 +1488,24 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  	struct folio_iter fi;
>  	u32 folio_count = 0;
>  
> +	if (error) {
> +		mapping_set_error(inode->i_mapping, error);
> +		if (!bio_flagged(bio, BIO_QUIET)) {
> +			pr_err_ratelimited(
> +"%s: writeback error on inode %lu, offset %lld, sector %llu",
> +				inode->i_sb->s_id, inode->i_ino,
> +				ioend->io_offset, ioend->io_sector);

Something that's always bothered me: Why don't we log the *amount* of
data that just failed writeback?

"XFS: writeback error on inode 63, offset 4096, length 8192, sector 27"

Now we'd actually have some way to work out that we've lost 8k worth of
data.  OFC maybe the better solution is to wire up that inotify error
reporting interface that ext4 added a while back...?

This patch is pretty straightforward tho
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> +		}
> +	}
> +
>  	/* walk all folios in bio, ending page IO on them */
>  	bio_for_each_folio_all(fi, bio) {
> -		iomap_finish_folio_write(inode, fi.folio, fi.length, error);
> +		if (error)
> +			folio_set_error(fi.folio);
> +		iomap_finish_folio_write(inode, fi.folio, fi.length);
>  		folio_count++;
>  	}
>  
> -	if (unlikely(error && !bio_flagged(bio, BIO_QUIET))) {
> -		printk_ratelimited(KERN_ERR
> -"%s: writeback error on inode %lu, offset %lld, sector %llu",
> -			inode->i_sb->s_id, inode->i_ino,
> -			ioend->io_offset, ioend->io_sector);
> -	}
>  	bio_put(bio);	/* frees the ioend */
>  	return folio_count;
>  }
> -- 
> 2.39.2
> 
> 

