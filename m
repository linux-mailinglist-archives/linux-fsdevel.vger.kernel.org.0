Return-Path: <linux-fsdevel+bounces-54742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7882EB02963
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 06:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02431A627BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 04:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2E6149DE8;
	Sat, 12 Jul 2025 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVbLybs/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E773C0C
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752295572; cv=none; b=E5W3Wr8aH82oSUliPAz/jzMfzgZH56114iQpj0e5dTk/qark/0GW2KuPoL6I+LydDk709M+M/Rjj5Dn3FG+QRDA8uKa7NeQ0GeDsedR0RRY+S1Era/an1ZrSzh/TkEIrRIzPbyYPn5TsxEmZy7PhNt7kWorHdqTu0CkVXUz2QZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752295572; c=relaxed/simple;
	bh=eK7FNRuDVDcxbLHRqH3nBvyHKiuKaEaODMj2mR1c3LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fava9gBfOAUEE0EMoZ1ppzGNxipuWN3AYNyWj2Nu/kNNG2kaH3vDx9Y3imRhS9qpNQzqytZqZh5xwgL+VzxA87URNLfrP5VwdwHCKUT6X4oHzHjwvoXrw7i1gtV2TnVqdxn4KbS3CneNw94LRDLuAI5nwRA3eMt2K2vITOoP8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVbLybs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF2BC4CEEF;
	Sat, 12 Jul 2025 04:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752295571;
	bh=eK7FNRuDVDcxbLHRqH3nBvyHKiuKaEaODMj2mR1c3LY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVbLybs/dNXgfEQLi4O4+8GFJ2YBQodyojcSm/4Ztw28nohzp6FDydEen6R+i8T4C
	 8k7IBTKoRVv+X31YGdL4GpZBvr4yvr4gjcAgfZTt7jBu3dQzy7FmH647Nf3OCbubhQ
	 qMNxZxbIiTo6mFSRX1DSHOCv8Cn1i2FqfRIhHvZsUUJ50/rfcto+mnQLWhEn4akfoJ
	 Zk8Hdrw9aGd4RKmTu34S4Q1xOkMSthGeaiWsQErkN0flhi651nYxUtOQ6dHlXxBnDi
	 zZDxy9DMpncUHGEdnUcYrWH8IrwkJnt/YH3CFO8entBH62k07Ejubk8jNj3qLeHfgo
	 7zgKC2bb1aTEQ==
Date: Fri, 11 Jul 2025 21:46:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, anuj20.g@samsung.com, kernel-team@meta.com
Subject: Re: [PATCH v4 1/5] fuse: use iomap for buffered writes
Message-ID: <20250712044611.GI2672029@frogsfrogsfrogs>
References: <20250709221023.2252033-1-joannelkoong@gmail.com>
 <20250709221023.2252033-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709221023.2252033-2-joannelkoong@gmail.com>

On Wed, Jul 09, 2025 at 03:10:19PM -0700, Joanne Koong wrote:
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
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/Kconfig |   1 +
>  fs/fuse/file.c  | 148 ++++++++++++++++++------------------------------
>  2 files changed, 55 insertions(+), 94 deletions(-)
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
> index 47006d0753f1..cadad61ef7df 100644
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
> @@ -1374,6 +1390,24 @@ static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
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
> @@ -1383,6 +1417,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	struct inode *inode = mapping->host;
>  	ssize_t err, count;
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> +	bool writeback = false;
>  
>  	if (fc->writeback_cache) {
>  		/* Update size (EOF optimization) and mode (SUID clearing) */
> @@ -1391,16 +1426,11 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		if (err)
>  			return err;
>  
> -		if (fc->handle_killpriv_v2 &&
> -		    setattr_should_drop_suidgid(idmap,
> -						file_inode(file))) {
> -			goto writethrough;
> -		}
> -
> -		return generic_file_write_iter(iocb, from);
> +		if (!fc->handle_killpriv_v2 ||
> +		    !setattr_should_drop_suidgid(idmap, file_inode(file)))
> +			writeback = true;
>  	}
>  
> -writethrough:
>  	inode_lock(inode);
>  
>  	err = count = generic_write_checks(iocb, from);
> @@ -1419,6 +1449,15 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  			goto out;
>  		written = direct_write_fallback(iocb, from, written,
>  				fuse_perform_write(iocb, from));

Random unrelatd question: does anyone know why fuse handles IOCB_DIRECT
in its fuse_cache_{read,write}_iter functions and /also/ sets
->direct_IO?  I thought filesystems only did one or the other, not both.

Anyway your changes look reasonable to me, so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

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
> @@ -2208,84 +2247,6 @@ static int fuse_writepages(struct address_space *mapping,
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
> @@ -3144,11 +3105,10 @@ static const struct address_space_operations fuse_file_aops  = {
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

