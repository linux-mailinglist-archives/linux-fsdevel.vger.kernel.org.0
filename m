Return-Path: <linux-fsdevel+bounces-67057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94E3C33B05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 02:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C1E1884C21
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 01:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A441E2253FF;
	Wed,  5 Nov 2025 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsoO09I2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C53D28DC4
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 01:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306888; cv=none; b=KsD+jb8FAUWudeoxozfRL7NjEPeM0AulNI/incbfM+jBtfiAtaFR4DCe4EngKdUal/CJ8cGzhdqOaFhNYOLZcVoumpJyg0VyFwg2LmVH6AUxqbYOMruNTuF0focOBu+zGwJX488KcoLSXesRZ0JoheSPJ86j0o4U6N0B6ymRp8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306888; c=relaxed/simple;
	bh=RsFFZ+ezbsm2xfUj7bolxDAj6HGgU4sSpRvPuZbYdXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggb4vLWn19DswWlUS78IpSQ9o6Rl1/9TBVdpcy1ZJI9JHzTrftV3eAhBcC4HqQJaWoInQNtJZSfzxiJ8TD/8F2UCTP7DoN9LgM74SQbqC3ST/Y9MqTuVypQxVNrMzs3KknkSrD85R/L8u54AvIPy7ibfuqMgTHTDC/JaQL3rxfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsoO09I2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C044C4CEF7;
	Wed,  5 Nov 2025 01:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762306887;
	bh=RsFFZ+ezbsm2xfUj7bolxDAj6HGgU4sSpRvPuZbYdXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IsoO09I2wmHyUVdzGrek/YTzmTJ5pjOOTMMZ2MitaR2Txv6uYGqKUSd54Pfw6ERzr
	 vYzVkpAYVWvEUuhpZ4QmCp7v2RWkUYOMMOX0ihX+4vS6v9hxDfnYJUofe2tBcKEfsK
	 OJN9WlQJ0G1HdAJlSZxFFGEVRxP3oPd6qKo8s0rKPCi+YhkigTmMmKVjH6PRpchAf/
	 LvQjkKq+WizrudwYp+uS/BuaA162sX7ktU+j4zK/Y1+bOSFE2ztOq/5/yBc03qNJHd
	 gylOhPOtvgMfeeaFUPBnmdmja7fDoyyFgijnJDBosupq90X5IkpQcBMsenz4acbeM1
	 cJI6gXLyrN19w==
Date: Tue, 4 Nov 2025 17:41:27 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 6/8] iomap: use loff_t for file positions and offsets
 in writeback code
Message-ID: <20251105014127.GG196362@frogsfrogsfrogs>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
 <20251104205119.1600045-7-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104205119.1600045-7-joannelkoong@gmail.com>

On Tue, Nov 04, 2025 at 12:51:17PM -0800, Joanne Koong wrote:
> Use loff_t instead of u64 for file positions and offsets to be
> consistent with kernel VFS conventions. Both are 64-bit types. loff_t is
> signed for historical reasons but this has no practical effect.

Let's hope iomap never encounters a FOP_UNSIGNED_OFFSET filesystem.

(should we warn somewhere if we do?)

> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  block/fops.c           |  3 ++-
>  fs/fuse/file.c         |  4 ++--
>  fs/gfs2/bmap.c         |  3 ++-
>  fs/iomap/buffered-io.c | 17 +++++++++--------
>  fs/xfs/xfs_aops.c      |  8 ++++----
>  fs/zonefs/file.c       |  3 ++-
>  include/linux/iomap.h  |  4 ++--
>  7 files changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 4dad9c2d5796..d2b96143b40f 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -550,7 +550,8 @@ static void blkdev_readahead(struct readahead_control *rac)
>  }
>  
>  static ssize_t blkdev_writeback_range(struct iomap_writepage_ctx *wpc,
> -		struct folio *folio, u64 offset, unsigned int len, u64 end_pos)
> +		struct folio *folio, loff_t offset, unsigned int len,
> +		loff_t end_pos)
>  {
>  	loff_t isize = i_size_read(wpc->inode);
>  
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 7bcb650a9f26..6d5e44cbd62e 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2168,8 +2168,8 @@ static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
>  }
>  
>  static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
> -					  struct folio *folio, u64 pos,
> -					  unsigned len, u64 end_pos)
> +					  struct folio *folio, loff_t pos,
> +					  unsigned len, loff_t end_pos)
>  {
>  	struct fuse_fill_wb_data *data = wpc->wb_ctx;
>  	struct fuse_writepage_args *wpa = data->wpa;
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 131091520de6..2b61b057151b 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -2473,7 +2473,8 @@ int __gfs2_punch_hole(struct file *file, loff_t offset, loff_t length)
>  }
>  
>  static ssize_t gfs2_writeback_range(struct iomap_writepage_ctx *wpc,
> -		struct folio *folio, u64 offset, unsigned int len, u64 end_pos)
> +		struct folio *folio, loff_t offset, unsigned int len,
> +		loff_t end_pos)
>  {
>  	if (WARN_ON_ONCE(gfs2_is_stuffed(GFS2_I(wpc->inode))))
>  		return -EIO;
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index c02d33bff3d0..420fe2865927 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -86,7 +86,8 @@ static inline bool ifs_block_is_dirty(struct folio *folio,
>  }
>  
>  static unsigned ifs_find_dirty_range(struct folio *folio,
> -		struct iomap_folio_state *ifs, u64 *range_start, u64 range_end)
> +		struct iomap_folio_state *ifs, loff_t *range_start,
> +		loff_t range_end)
>  {
>  	struct inode *inode = folio->mapping->host;
>  	unsigned start_blk =
> @@ -110,8 +111,8 @@ static unsigned ifs_find_dirty_range(struct folio *folio,
>  	return nblks << inode->i_blkbits;
>  }
>  
> -static unsigned iomap_find_dirty_range(struct folio *folio, u64 *range_start,
> -		u64 range_end)
> +static unsigned iomap_find_dirty_range(struct folio *folio, loff_t *range_start,
> +		loff_t range_end)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  
> @@ -1677,7 +1678,7 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
>  EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
>  
>  static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
> -		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
> +		struct folio *folio, loff_t pos, u32 rlen, loff_t end_pos,
>  		size_t *bytes_submitted)
>  {
>  	do {
> @@ -1709,7 +1710,7 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
>   * i_size, adjust end_pos and zero all data beyond i_size.
>   */
>  static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
> -		u64 *end_pos)
> +		loff_t *end_pos)
>  {
>  	u64 isize = i_size_read(inode);
>  
> @@ -1764,9 +1765,9 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  	struct inode *inode = wpc->inode;
> -	u64 pos = folio_pos(folio);
> -	u64 end_pos = pos + folio_size(folio);
> -	u64 end_aligned = 0;
> +	loff_t pos = folio_pos(folio);
> +	loff_t end_pos = pos + folio_size(folio);
> +	loff_t end_aligned = 0;
>  	size_t bytes_submitted = 0;
>  	int error = 0;
>  	u32 rlen;
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 0c2ed00733f2..593a34832116 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -480,9 +480,9 @@ static ssize_t
>  xfs_writeback_range(
>  	struct iomap_writepage_ctx *wpc,
>  	struct folio		*folio,
> -	u64			offset,
> +	loff_t			offset,
>  	unsigned int		len,
> -	u64			end_pos)
> +	loff_t			end_pos)
>  {
>  	ssize_t			ret;
>  
> @@ -630,9 +630,9 @@ static ssize_t
>  xfs_zoned_writeback_range(
>  	struct iomap_writepage_ctx *wpc,
>  	struct folio		*folio,
> -	u64			offset,
> +	loff_t			offset,
>  	unsigned int		len,
> -	u64			end_pos)
> +	loff_t			end_pos)
>  {
>  	ssize_t			ret;
>  
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index c1e5e30e90a0..d748ed99ac2d 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -126,7 +126,8 @@ static void zonefs_readahead(struct readahead_control *rac)
>   * which implies that the page range can only be within the fixed inode size.
>   */
>  static ssize_t zonefs_writeback_range(struct iomap_writepage_ctx *wpc,
> -		struct folio *folio, u64 offset, unsigned len, u64 end_pos)
> +		struct folio *folio, loff_t offset, unsigned len,
> +		loff_t end_pos)
>  {
>  	struct zonefs_zone *z = zonefs_inode_zone(wpc->inode);
>  
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 520e967cb501..351c7bd9653d 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -442,8 +442,8 @@ struct iomap_writeback_ops {
>  	 * Returns the number of bytes processed or a negative errno.
>  	 */
>  	ssize_t (*writeback_range)(struct iomap_writepage_ctx *wpc,
> -			struct folio *folio, u64 pos, unsigned int len,
> -			u64 end_pos);
> +			struct folio *folio, loff_t pos, unsigned int len,
> +			loff_t end_pos);
>  
>  	/*
>  	 * Submit a writeback context previously build up by ->writeback_range.
> -- 
> 2.47.3
> 
> 

