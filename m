Return-Path: <linux-fsdevel+bounces-27409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B999896140E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7635E285044
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C551CCB50;
	Tue, 27 Aug 2024 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR8D81LL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927FF481CD;
	Tue, 27 Aug 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776107; cv=none; b=OiqePxULrPL8pSbCmEC1btopBb1lExkR4RAX82Md1usj10tgpSpgLnEP2tDaIDy+579fAolWainmayEHEwsahwbObhv4zjk3w020sE/kmFtmy0Crwd5HB1fEIm7HBz9XPlxuHD69YwcbUbXlRZRQklmEQP6zMijOe5ZcRl2q5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776107; c=relaxed/simple;
	bh=sD9yc8giyl7eSOL6/QDJ/cGgpCPUE/qHb51FmqgKq7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltiymR3cyAGpFplbZsHLfqNZVe/ryhF1UvWD+FVFix+7rMwS9ztJ/1te25RY7OqGR7bxmY2GGu9GMHoqw5IGoRBYfsmyLRTAlUlWtIuxsSU7p/viSmjryBJOQHpjHrp3ozAdWjU6RF+tqPHT4otaEqAK1wnbdW7IYonZrmmsH9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jR8D81LL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EA4C4CA0E;
	Tue, 27 Aug 2024 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724776107;
	bh=sD9yc8giyl7eSOL6/QDJ/cGgpCPUE/qHb51FmqgKq7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jR8D81LLer+RV9pZwfrsPRovFF0sR7ckMOvIH0LMKg6fTF6zYVrhj6520TygRaH/V
	 OFGhRBXHbXUDrYbbzuM2M2DazjOnfwzf7g5Y/OjhQjXRTmODrfkUeQvmpj0yiyNpFz
	 kGP8orKGvdoiNY2RJ/J/OBiunWAo7A1bdSfN68SsTA088saYWk1oOICnDwylyU+wYG
	 9krA1Y64CU3cKw7PwVcEBNzVnr0BmrMNC6orlRY59CXmC5l1LdGlLhpemh+yfIOrfQ
	 HbNxdsa/VOJe03MLrHJ5ZWkZC6YQhMHSFqVsnKneHpHp6gdhUzdbmdP9RRsEiSjQe0
	 nvC71YWc6QFtQ==
Date: Tue, 27 Aug 2024 09:28:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/10] iomap: pass the iomap to the punch callback
Message-ID: <20240827162826.GZ865349@frogsfrogsfrogs>
References: <20240827051028.1751933-1-hch@lst.de>
 <20240827051028.1751933-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827051028.1751933-6-hch@lst.de>

On Tue, Aug 27, 2024 at 07:09:52AM +0200, Christoph Hellwig wrote:
> XFS will need to look at the flags in the iomap structure, so pass it
> down all the way to the callback.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 25 +++++++++++++------------
>  fs/xfs/xfs_iomap.c     |  3 ++-
>  include/linux/iomap.h  |  3 ++-
>  3 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 574ca413516443..7950cbecb78c22 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1047,7 +1047,7 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>  
>  static int iomap_write_delalloc_ifs_punch(struct inode *inode,
>  		struct folio *folio, loff_t start_byte, loff_t end_byte,
> -		iomap_punch_t punch)
> +		struct iomap *iomap, iomap_punch_t punch)
>  {
>  	unsigned int first_blk, last_blk, i;
>  	loff_t last_byte;
> @@ -1072,7 +1072,7 @@ static int iomap_write_delalloc_ifs_punch(struct inode *inode,
>  	for (i = first_blk; i <= last_blk; i++) {
>  		if (!ifs_block_is_dirty(folio, ifs, i)) {
>  			ret = punch(inode, folio_pos(folio) + (i << blkbits),
> -				    1 << blkbits);
> +				    1 << blkbits, iomap);
>  			if (ret)
>  				return ret;
>  		}
> @@ -1084,7 +1084,7 @@ static int iomap_write_delalloc_ifs_punch(struct inode *inode,
>  
>  static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>  		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
> -		iomap_punch_t punch)
> +		struct iomap *iomap, iomap_punch_t punch)
>  {
>  	int ret = 0;
>  
> @@ -1094,14 +1094,14 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>  	/* if dirty, punch up to offset */
>  	if (start_byte > *punch_start_byte) {
>  		ret = punch(inode, *punch_start_byte,
> -				start_byte - *punch_start_byte);
> +				start_byte - *punch_start_byte, iomap);
>  		if (ret)
>  			return ret;
>  	}
>  
>  	/* Punch non-dirty blocks within folio */
> -	ret = iomap_write_delalloc_ifs_punch(inode, folio, start_byte,
> -			end_byte, punch);
> +	ret = iomap_write_delalloc_ifs_punch(inode, folio, start_byte, end_byte,
> +			iomap, punch);
>  	if (ret)
>  		return ret;
>  
> @@ -1134,7 +1134,7 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>   */
>  static int iomap_write_delalloc_scan(struct inode *inode,
>  		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
> -		iomap_punch_t punch)
> +		struct iomap *iomap, iomap_punch_t punch)
>  {
>  	while (start_byte < end_byte) {
>  		struct folio	*folio;
> @@ -1150,7 +1150,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
>  		}
>  
>  		ret = iomap_write_delalloc_punch(inode, folio, punch_start_byte,
> -						 start_byte, end_byte, punch);
> +				start_byte, end_byte, iomap, punch);
>  		if (ret) {
>  			folio_unlock(folio);
>  			folio_put(folio);
> @@ -1199,7 +1199,8 @@ static int iomap_write_delalloc_scan(struct inode *inode,
>   * the code to subtle off-by-one bugs....
>   */
>  static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
> -		loff_t end_byte, unsigned flags, iomap_punch_t punch)
> +		loff_t end_byte, unsigned flags, struct iomap *iomap,
> +		iomap_punch_t punch)
>  {
>  	loff_t punch_start_byte = start_byte;
>  	loff_t scan_end_byte = min(i_size_read(inode), end_byte);
> @@ -1257,7 +1258,7 @@ static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  		WARN_ON_ONCE(data_end > scan_end_byte);
>  
>  		error = iomap_write_delalloc_scan(inode, &punch_start_byte,
> -				start_byte, data_end, punch);
> +				start_byte, data_end, iomap, punch);
>  		if (error)
>  			goto out_unlock;
>  
> @@ -1267,7 +1268,7 @@ static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  
>  	if (punch_start_byte < end_byte)
>  		error = punch(inode, punch_start_byte,
> -				end_byte - punch_start_byte);
> +				end_byte - punch_start_byte, iomap);
>  out_unlock:
>  	if (!(flags & IOMAP_ZERO))
>  		filemap_invalidate_unlock(inode->i_mapping);
> @@ -1335,7 +1336,7 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
>  		return 0;
>  
>  	return iomap_write_delalloc_release(inode, start_byte, end_byte, flags,
> -					punch);
> +					iomap, punch);
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
>  
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 47b5c83588259e..695e5bee776f94 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1212,7 +1212,8 @@ static int
>  xfs_buffered_write_delalloc_punch(
>  	struct inode		*inode,
>  	loff_t			offset,
> -	loff_t			length)
> +	loff_t			length,
> +	struct iomap		*iomap)
>  {
>  	xfs_bmap_punch_delalloc_range(XFS_I(inode), offset, offset + length);
>  	return 0;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 83da37d64d1144..a931190f6d858b 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -274,7 +274,8 @@ int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
>  			const struct iomap_ops *ops);
>  
> -typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
> +typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length,
> +		struct iomap *iomap);
>  int iomap_file_buffered_write_punch_delalloc(struct inode *inode, loff_t pos,
>  		loff_t length, ssize_t written, unsigned flag,
>  		struct iomap *iomap, iomap_punch_t punch);
> -- 
> 2.43.0
> 
> 

