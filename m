Return-Path: <linux-fsdevel+bounces-53693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EC0AF607F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 19:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B9318895FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 17:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979F30B9B2;
	Wed,  2 Jul 2025 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAziHEtM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA3623184F;
	Wed,  2 Jul 2025 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478912; cv=none; b=Q6k+Akn/fD+SrAlCUVIuDeQN4PkiBlG/xsNVRjqIRZtbFACei2sgU5vpramIdVjJZxV7gQdcqc+jK+LKm1VjejMbr7Wpox5bR/XGstxIK/IIJ2SlzxvKIBGBnsAPf2RG9v0gMPk3gcZaVKKHFfWx5n87iRdwggUxoR9cU/vrypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478912; c=relaxed/simple;
	bh=LfF//zRdy+H6FdaC1yMGCaVLLq1jP0Uc4tJJXg1AljA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1OO7S7UH013toFxiVlUYjGyy3ozbrH4n9g4R+kWq7KCOPHMHPyDoTbKeOTlpm73fT8UC9Qscx3pCnDOYq0m3Njd1CQVbR+dUEVSFkaxT4qNVU6FB34pDH3/lbAxiDU+D7mizCI747wrQufFU0r8h92KE2i30/lLjeQ11ZUUZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAziHEtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AE8C4CEE7;
	Wed,  2 Jul 2025 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751478910;
	bh=LfF//zRdy+H6FdaC1yMGCaVLLq1jP0Uc4tJJXg1AljA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAziHEtMRH94URFkHK5Us8hmIFyiShY7IsPFJxv7lt0TB2fz+ylHNhaYRZbcagtbv
	 7O4Q01r8IWm6UceuwKH1woybIkTajhKMoMMwJEu/9DIDvfuBKtKXem/FpU+XbQeboD
	 FNd6UF1r/lowVf+n+tM37a0cZSQ5zrfqQLSXmGJOGtGIzRWGNOAQLgC9q974STYFap
	 16azv7FFXZ1VM3QchPT8A8SYtvSwRjE+u9+XYmdnYawB0rpsjUfgRoQS/nC9CFH0kF
	 zduAv6zuE82LKDPcPycR3YrII7cQeb+0yK96PQnFP7Z70MttfV2c3xbpFFOBLyYi79
	 ltw5xWoYkgo2g==
Date: Wed, 2 Jul 2025 10:55:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 12/16] fuse: use iomap for buffered writes
Message-ID: <20250702175509.GF10009@frogsfrogsfrogs>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-13-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022135.832899-13-joannelkoong@gmail.com>

On Mon, Jun 23, 2025 at 07:21:31PM -0700, Joanne Koong wrote:
> Have buffered writes go through iomap. This has two advantages:
> * granular large folio synchronous reads
> * granular large folio dirty tracking
> 
> If for example there is a 1 MB large folio and a write issued at pos 1
> to pos 1 MB - 2, only the head and tail pages will need to be read in
> and marked uptodate instead of the entire folio needing to be read in.
> Non-relevant trailing pages are also skipped (eg if for a 1 MB large
> folio a write is issued at pos 1 to 4099, only the first two pages are
> read in and the ones after that are skipped).
> 
> iomap also has granular dirty tracking. This is useful in that when it
> comes to writeback time, only the dirty portions of the large folio will
> be written instead of having to write out the entire folio. For example
> if there is a 1 MB large folio and only 2 bytes in it are dirty, only
> the page for those dirty bytes get written out. Please note that
> granular writeback is only done once fuse also uses iomap in writeback
> (separate commit).
> 
> .release_folio needs to be set to iomap_release_folio so that any
> allocated iomap ifs structs get freed.

What happens in the !iomap case, which can still happen for
!writeback_cache filesystems?  I don't think you can call
iomap_release_folio, because iomap doesn't own folio->private in that
case.

--D

> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/Kconfig |   1 +
>  fs/fuse/file.c  | 140 ++++++++++++++++++------------------------------
>  2 files changed, 53 insertions(+), 88 deletions(-)
> 
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index ca215a3cba3e..a774166264de 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -2,6 +2,7 @@
>  config FUSE_FS
>  	tristate "FUSE (Filesystem in Userspace) support"
>  	select FS_POSIX_ACL
> +	select FS_IOMAP
>  	help
>  	  With FUSE it is possible to implement a fully functional filesystem
>  	  in a userspace program.
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f102afc03359..a7f11c1a4f89 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -21,6 +21,7 @@
>  #include <linux/filelock.h>
>  #include <linux/splice.h>
>  #include <linux/task_io_accounting_ops.h>
> +#include <linux/iomap.h>
>  
>  static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
>  			  unsigned int open_flags, int opcode,
> @@ -788,12 +789,16 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
>  	}
>  }
>  
> -static int fuse_do_readfolio(struct file *file, struct folio *folio)
> +static int fuse_do_readfolio(struct file *file, struct folio *folio,
> +			     size_t off, size_t len)
>  {
>  	struct inode *inode = folio->mapping->host;
>  	struct fuse_mount *fm = get_fuse_mount(inode);
> -	loff_t pos = folio_pos(folio);
> -	struct fuse_folio_desc desc = { .length = folio_size(folio) };
> +	loff_t pos = folio_pos(folio) + off;
> +	struct fuse_folio_desc desc = {
> +		.offset = off,
> +		.length = len,
> +	};
>  	struct fuse_io_args ia = {
>  		.ap.args.page_zeroing = true,
>  		.ap.args.out_pages = true,
> @@ -820,8 +825,6 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
>  	if (res < desc.length)
>  		fuse_short_read(inode, attr_ver, res, &ia.ap);
>  
> -	folio_mark_uptodate(folio);
> -
>  	return 0;
>  }
>  
> @@ -834,13 +837,26 @@ static int fuse_read_folio(struct file *file, struct folio *folio)
>  	if (fuse_is_bad(inode))
>  		goto out;
>  
> -	err = fuse_do_readfolio(file, folio);
> +	err = fuse_do_readfolio(file, folio, 0, folio_size(folio));
> +	if (!err)
> +		folio_mark_uptodate(folio);
> +
>  	fuse_invalidate_atime(inode);
>   out:
>  	folio_unlock(folio);
>  	return err;
>  }
>  
> +static int fuse_iomap_read_folio_range(const struct iomap_iter *iter,
> +				       struct folio *folio, loff_t pos,
> +				       size_t len)
> +{
> +	struct file *file = iter->private;
> +	size_t off = offset_in_folio(folio, pos);
> +
> +	return fuse_do_readfolio(file, folio, off, len);
> +}
> +
>  static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
>  			       int err)
>  {
> @@ -1375,6 +1391,24 @@ static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
>  	}
>  }
>  
> +static const struct iomap_write_ops fuse_iomap_write_ops = {
> +	.read_folio_range = fuse_iomap_read_folio_range,
> +};
> +
> +static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +			    unsigned int flags, struct iomap *iomap,
> +			    struct iomap *srcmap)
> +{
> +	iomap->type = IOMAP_MAPPED;
> +	iomap->length = length;
> +	iomap->offset = offset;
> +	return 0;
> +}
> +
> +static const struct iomap_ops fuse_iomap_ops = {
> +	.iomap_begin	= fuse_iomap_begin,
> +};
> +
>  static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct file *file = iocb->ki_filp;
> @@ -1384,6 +1418,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	struct inode *inode = mapping->host;
>  	ssize_t err, count;
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> +	bool writeback = false;
>  
>  	if (fc->writeback_cache) {
>  		/* Update size (EOF optimization) and mode (SUID clearing) */
> @@ -1397,8 +1432,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  						file_inode(file))) {
>  			goto writethrough;
>  		}
> -
> -		return generic_file_write_iter(iocb, from);
> +		writeback = true;
>  	}
>  
>  writethrough:
> @@ -1420,6 +1454,15 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  			goto out;
>  		written = direct_write_fallback(iocb, from, written,
>  				fuse_perform_write(iocb, from));
> +	} else if (writeback) {
> +		/*
> +		 * Use iomap so that we can do granular uptodate reads
> +		 * and granular dirty tracking for large folios.
> +		 */
> +		written = iomap_file_buffered_write(iocb, from,
> +						    &fuse_iomap_ops,
> +						    &fuse_iomap_write_ops,
> +						    file);
>  	} else {
>  		written = fuse_perform_write(iocb, from);
>  	}
> @@ -2209,84 +2252,6 @@ static int fuse_writepages(struct address_space *mapping,
>  	return err;
>  }
>  
> -/*
> - * It's worthy to make sure that space is reserved on disk for the write,
> - * but how to implement it without killing performance need more thinking.
> - */
> -static int fuse_write_begin(struct file *file, struct address_space *mapping,
> -		loff_t pos, unsigned len, struct folio **foliop, void **fsdata)
> -{
> -	pgoff_t index = pos >> PAGE_SHIFT;
> -	struct fuse_conn *fc = get_fuse_conn(file_inode(file));
> -	struct folio *folio;
> -	loff_t fsize;
> -	int err = -ENOMEM;
> -
> -	WARN_ON(!fc->writeback_cache);
> -
> -	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> -			mapping_gfp_mask(mapping));
> -	if (IS_ERR(folio))
> -		goto error;
> -
> -	if (folio_test_uptodate(folio) || len >= folio_size(folio))
> -		goto success;
> -	/*
> -	 * Check if the start of this folio comes after the end of file,
> -	 * in which case the readpage can be optimized away.
> -	 */
> -	fsize = i_size_read(mapping->host);
> -	if (fsize <= folio_pos(folio)) {
> -		size_t off = offset_in_folio(folio, pos);
> -		if (off)
> -			folio_zero_segment(folio, 0, off);
> -		goto success;
> -	}
> -	err = fuse_do_readfolio(file, folio);
> -	if (err)
> -		goto cleanup;
> -success:
> -	*foliop = folio;
> -	return 0;
> -
> -cleanup:
> -	folio_unlock(folio);
> -	folio_put(folio);
> -error:
> -	return err;
> -}
> -
> -static int fuse_write_end(struct file *file, struct address_space *mapping,
> -		loff_t pos, unsigned len, unsigned copied,
> -		struct folio *folio, void *fsdata)
> -{
> -	struct inode *inode = folio->mapping->host;
> -
> -	/* Haven't copied anything?  Skip zeroing, size extending, dirtying. */
> -	if (!copied)
> -		goto unlock;
> -
> -	pos += copied;
> -	if (!folio_test_uptodate(folio)) {
> -		/* Zero any unwritten bytes at the end of the page */
> -		size_t endoff = pos & ~PAGE_MASK;
> -		if (endoff)
> -			folio_zero_segment(folio, endoff, PAGE_SIZE);
> -		folio_mark_uptodate(folio);
> -	}
> -
> -	if (pos > inode->i_size)
> -		i_size_write(inode, pos);
> -
> -	folio_mark_dirty(folio);
> -
> -unlock:
> -	folio_unlock(folio);
> -	folio_put(folio);
> -
> -	return copied;
> -}
> -
>  static int fuse_launder_folio(struct folio *folio)
>  {
>  	int err = 0;
> @@ -3145,11 +3110,10 @@ static const struct address_space_operations fuse_file_aops  = {
>  	.writepages	= fuse_writepages,
>  	.launder_folio	= fuse_launder_folio,
>  	.dirty_folio	= filemap_dirty_folio,
> +	.release_folio	= iomap_release_folio,
>  	.migrate_folio	= filemap_migrate_folio,
>  	.bmap		= fuse_bmap,
>  	.direct_IO	= fuse_direct_IO,
> -	.write_begin	= fuse_write_begin,
> -	.write_end	= fuse_write_end,
>  };
>  
>  void fuse_init_file_inode(struct inode *inode, unsigned int flags)
> -- 
> 2.47.1
> 
> 

