Return-Path: <linux-fsdevel+bounces-75159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCo2JsaacmnBmwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:46:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C4B6DEDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06F49300EEAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989D5395739;
	Thu, 22 Jan 2026 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIe3YPK6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6FC366DCC;
	Thu, 22 Jan 2026 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118353; cv=none; b=rtM11n3wZWj8gWAUheM5JhB+W/p1DgfEQjUCuAcg7/6CBSG1d0gVAbgToK6tTLGZGMeU9ZHh9kirIns0a6JHgVsnOVnZsyXQU5djx79rAhuY+xCAsLR9bLHykcJmtnnccBNmXk6vzo8qHZfb984bCIx6JuX8vVlgPQXkRdqQmTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118353; c=relaxed/simple;
	bh=8dcjslYwHGSFWO8JvpsXfQ2fKhmuDeGQG5nWKoahI0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMjvuQ4Y2mB1xbkMQxcP57tUhY2GTQ0Bt5NGG062Wi8WrzmjpYkEFY1IdktfnrF7PVA3MlXiluWYOao7WAWkofU4qFUDyOLi8/X5oALkmLGRqKexfOLEtZWKKKpmS6/0ii1HJOyyDil2zAVVnDw61LpbeKD4clulkgRco3HLhbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIe3YPK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1836C116C6;
	Thu, 22 Jan 2026 21:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769118352;
	bh=8dcjslYwHGSFWO8JvpsXfQ2fKhmuDeGQG5nWKoahI0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIe3YPK6Efh9zX6GWaEPN088Ulnf9unq4oyj65aIdm1vbi5Ieb6XGS1CrReSZcl2h
	 4jkkLfJ3bKCATIXjoZfxWc+dZFvHq0+53FEKz2Jdj0Pb3svjHaDdhebRb7Hcca6BqG
	 Xh5WlTSJtl50xCpIZqA3o2iu/2zb/+FRnhsK0Kmp4WXepOuG0A/kiiqteEXVfWxSYQ
	 rLJ/WRebyJItr0o3pQMythRGwTwWSuvTyRzzwgVTghAH7JxHXy4uaisSGoDE6gUqRx
	 SHHZa3mWB5NTrV13K49o/B/vGlpAJEMAXuxBvGEwB1m1nxLH86mwwqCbP6Esb99siN
	 jsugf4xpYiS6A==
Date: Thu, 22 Jan 2026 13:45:51 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 06/11] fsverity: push out fsverity_info lookup
Message-ID: <20260122214551.GF5910@frogsfrogsfrogs>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-7-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75159-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 97C4B6DEDE
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:22:02AM +0100, Christoph Hellwig wrote:
> Pass a struct fsverity_info to the verification and readahead helpers,
> and push the lookup into the callers.  Right now this is a very
> dumb almost mechanic move that open codes a lot of fsverity_info_addr()
> calls int the file systems.  The subsequent patches will clean this up.
> 
> This prepares for reducing the number of fsverity_info lookups, which
> will allow to amortize them better when using a more expensive lookup
> method.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/extent_io.c     |  4 +++-
>  fs/buffer.c              |  4 +++-
>  fs/ext4/readpage.c       | 11 ++++++++---
>  fs/f2fs/compress.c       |  4 +++-
>  fs/f2fs/data.c           | 15 +++++++++++----
>  fs/verity/verify.c       | 26 ++++++++++++++------------
>  include/linux/fsverity.h | 24 +++++++++++++++---------
>  7 files changed, 57 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a4b74023618d..6e65e2cdf950 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -484,7 +484,8 @@ static bool btrfs_verify_folio(struct folio *folio, u64 start, u32 len)
>  	    btrfs_folio_test_uptodate(fs_info, folio, start, len) ||
>  	    start >= i_size_read(folio->mapping->host))
>  		return true;
> -	return fsverity_verify_folio(folio);
> +	return fsverity_verify_folio(*fsverity_info_addr(folio->mapping->host),

<shudder>

At least that goes away in a few patches so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


> +			folio);
>  }
>  
>  static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 len)
> @@ -578,6 +579,7 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
>  	struct folio_iter fi;
>  
>  	ASSERT(!bio_flagged(bio, BIO_CLONED));
> +
>  	bio_for_each_folio_all(fi, &bbio->bio) {
>  		bool uptodate = !bio->bi_status;
>  		struct folio *folio = fi.folio;
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 838c0c571022..3982253b6805 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -309,9 +309,11 @@ static void verify_bh(struct work_struct *work)
>  	struct postprocess_bh_ctx *ctx =
>  		container_of(work, struct postprocess_bh_ctx, work);
>  	struct buffer_head *bh = ctx->bh;
> +	struct inode *inode = bh->b_folio->mapping->host;
>  	bool valid;
>  
> -	valid = fsverity_verify_blocks(bh->b_folio, bh->b_size, bh_offset(bh));
> +	valid = fsverity_verify_blocks(*fsverity_info_addr(inode), bh->b_folio,
> +				       bh->b_size, bh_offset(bh));
>  	end_buffer_async_read(bh, valid);
>  	kfree(ctx);
>  }
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index 574584123b8a..02f918cf1945 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -96,6 +96,7 @@ static void verity_work(struct work_struct *work)
>  	struct bio_post_read_ctx *ctx =
>  		container_of(work, struct bio_post_read_ctx, work);
>  	struct bio *bio = ctx->bio;
> +	struct inode *inode = bio_first_folio_all(bio)->mapping->host;
>  
>  	/*
>  	 * fsverity_verify_bio() may call readahead() again, and although verity
> @@ -108,7 +109,7 @@ static void verity_work(struct work_struct *work)
>  	mempool_free(ctx, bio_post_read_ctx_pool);
>  	bio->bi_private = NULL;
>  
> -	fsverity_verify_bio(bio);
> +	fsverity_verify_bio(*fsverity_info_addr(inode), bio);
>  
>  	__read_end_io(bio);
>  }
> @@ -244,7 +245,8 @@ int ext4_mpage_readpages(struct inode *inode,
>  
>  		if (first_folio) {
>  			if (ext4_need_verity(inode, folio->index))
> -				fsverity_readahead(folio, nr_pages);
> +				fsverity_readahead(*fsverity_info_addr(inode),
> +						folio, nr_pages);
>  			first_folio = false;
>  		}
>  
> @@ -335,8 +337,11 @@ int ext4_mpage_readpages(struct inode *inode,
>  			folio_zero_segment(folio, first_hole << blkbits,
>  					  folio_size(folio));
>  			if (first_hole == 0) {
> +				struct fsverity_info *vi =
> +					*fsverity_info_addr(folio->mapping->host);
> +
>  				if (ext4_need_verity(inode, folio->index) &&
> -				    !fsverity_verify_folio(folio))
> +				    !fsverity_verify_folio(vi, folio))
>  					goto set_error_page;
>  				folio_end_read(folio, true);
>  				continue;
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 7b68bf22989d..0c269b875e0c 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1814,7 +1814,9 @@ static void f2fs_verify_cluster(struct work_struct *work)
>  		if (!rpage)
>  			continue;
>  
> -		if (fsverity_verify_page(rpage))
> +		if (fsverity_verify_page(
> +				*fsverity_info_addr(rpage->mapping->host),
> +				rpage))
>  			SetPageUptodate(rpage);
>  		else
>  			ClearPageUptodate(rpage);
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 49bdc7e771f2..bca1e34d327a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -185,15 +185,19 @@ static void f2fs_verify_bio(struct work_struct *work)
>  
>  		bio_for_each_folio_all(fi, bio) {
>  			struct folio *folio = fi.folio;
> +			struct fsverity_info *vi =
> +				*fsverity_info_addr(folio->mapping->host);
>  
>  			if (!f2fs_is_compressed_page(folio) &&
> -			    !fsverity_verify_page(&folio->page)) {
> +			    !fsverity_verify_page(vi, &folio->page)) {
>  				bio->bi_status = BLK_STS_IOERR;
>  				break;
>  			}
>  		}
>  	} else {
> -		fsverity_verify_bio(bio);
> +		struct inode *inode = bio_first_folio_all(bio)->mapping->host;
> +
> +		fsverity_verify_bio(*fsverity_info_addr(inode), bio);
>  	}
>  
>  	f2fs_finish_read_bio(bio, true);
> @@ -2121,7 +2125,9 @@ static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
>  zero_out:
>  		folio_zero_segment(folio, 0, folio_size(folio));
>  		if (f2fs_need_verity(inode, index) &&
> -		    !fsverity_verify_folio(folio)) {
> +		    !fsverity_verify_folio(
> +				*fsverity_info_addr(folio->mapping->host),
> +				folio)) {
>  			ret = -EIO;
>  			goto out;
>  		}
> @@ -2386,7 +2392,8 @@ static int f2fs_mpage_readpages(struct inode *inode,
>  
>  		if (first_folio) {
>  			if (f2fs_need_verity(inode, folio->index))
> -				fsverity_readahead(folio, nr_pages);
> +				fsverity_readahead(*fsverity_info_addr(inode),
> +						folio, nr_pages);
>  			first_folio = false;
>  		}
>  
> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index 7ccd906e2b28..74792cd8b037 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -71,6 +71,7 @@ EXPORT_SYMBOL_GPL(fsverity_readahead);
>  
>  /**
>   * fsverity_readahead() - kick off readahead on fsverity hashes
> + * @vi:			fsverity_info for the inode to be read
>   * @folio:		first folio that is being read
>   * @nr_pages:		number of data pages to read
>   *
> @@ -78,12 +79,11 @@ EXPORT_SYMBOL_GPL(fsverity_readahead);
>   * ->read_folio and ->readahead methods to ensure that the hashes are
>   * already cached on completion of the file data read if possible.
>   */
> -void fsverity_readahead(struct folio *folio, unsigned long nr_pages)
> +void fsverity_readahead(struct fsverity_info *vi, struct folio *folio,
> +			unsigned long nr_pages)
>  {
> -	struct inode *inode = folio->mapping->host;
> -
> -	return __fsverity_readahead(inode, *fsverity_info_addr(inode),
> -			folio_pos(folio), nr_pages);
> +	return __fsverity_readahead(folio->mapping->host, vi, folio_pos(folio),
> +			nr_pages);
>  }
>  
>  /*
> @@ -319,10 +319,9 @@ static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  
>  static void
>  fsverity_init_verification_context(struct fsverity_verification_context *ctx,
> -				   struct inode *inode)
> +				   struct inode *inode,
> +				   struct fsverity_info *vi)
>  {
> -	struct fsverity_info *vi = *fsverity_info_addr(inode);
> -
>  	ctx->inode = inode;
>  	ctx->vi = vi;
>  	ctx->num_pending = 0;
> @@ -403,6 +402,7 @@ static bool fsverity_add_data_blocks(struct fsverity_verification_context *ctx,
>  
>  /**
>   * fsverity_verify_blocks() - verify data in a folio
> + * @vi: fsverity_info for the inode to be read
>   * @folio: the folio containing the data to verify
>   * @len: the length of the data to verify in the folio
>   * @offset: the offset of the data to verify in the folio
> @@ -413,11 +413,12 @@ static bool fsverity_add_data_blocks(struct fsverity_verification_context *ctx,
>   *
>   * Return: %true if the data is valid, else %false.
>   */
> -bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset)
> +bool fsverity_verify_blocks(struct fsverity_info *vi, struct folio *folio,
> +			    size_t len, size_t offset)
>  {
>  	struct fsverity_verification_context ctx;
>  
> -	fsverity_init_verification_context(&ctx, folio->mapping->host);
> +	fsverity_init_verification_context(&ctx, folio->mapping->host, vi);
>  
>  	if (fsverity_add_data_blocks(&ctx, folio, len, offset) &&
>  	    fsverity_verify_pending_blocks(&ctx))
> @@ -430,6 +431,7 @@ EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
>  #ifdef CONFIG_BLOCK
>  /**
>   * fsverity_verify_bio() - verify a 'read' bio that has just completed
> + * @vi: fsverity_info for the inode to be read
>   * @bio: the bio to verify
>   *
>   * Verify the bio's data against the file's Merkle tree.  All bio data segments
> @@ -442,13 +444,13 @@ EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
>   * filesystems) must instead call fsverity_verify_page() directly on each page.
>   * All filesystems must also call fsverity_verify_page() on holes.
>   */
> -void fsverity_verify_bio(struct bio *bio)
> +void fsverity_verify_bio(struct fsverity_info *vi, struct bio *bio)
>  {
>  	struct inode *inode = bio_first_folio_all(bio)->mapping->host;
>  	struct fsverity_verification_context ctx;
>  	struct folio_iter fi;
>  
> -	fsverity_init_verification_context(&ctx, inode);
> +	fsverity_init_verification_context(&ctx, inode, vi);
>  
>  	bio_for_each_folio_all(fi, bio) {
>  		if (!fsverity_add_data_blocks(&ctx, fi.folio, fi.length,
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 862fea8a2eb1..c044285b6aff 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -197,8 +197,9 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
>  
>  /* verify.c */
>  
> -bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset);
> -void fsverity_verify_bio(struct bio *bio);
> +bool fsverity_verify_blocks(struct fsverity_info *vi, struct folio *folio,
> +			    size_t len, size_t offset);
> +void fsverity_verify_bio(struct fsverity_info *vi, struct bio *bio);
>  void fsverity_enqueue_verify_work(struct work_struct *work);
>  
>  #else /* !CONFIG_FS_VERITY */
> @@ -251,14 +252,16 @@ static inline int fsverity_ioctl_read_metadata(struct file *filp,
>  
>  /* verify.c */
>  
> -static inline bool fsverity_verify_blocks(struct folio *folio, size_t len,
> +static inline bool fsverity_verify_blocks(struct fsverity_info *vi,
> +					  struct folio *folio, size_t len,
>  					  size_t offset)
>  {
>  	WARN_ON_ONCE(1);
>  	return false;
>  }
>  
> -static inline void fsverity_verify_bio(struct bio *bio)
> +static inline void fsverity_verify_bio(struct fsverity_info *vi,
> +				       struct bio *bio)
>  {
>  	WARN_ON_ONCE(1);
>  }
> @@ -270,14 +273,16 @@ static inline void fsverity_enqueue_verify_work(struct work_struct *work)
>  
>  #endif	/* !CONFIG_FS_VERITY */
>  
> -static inline bool fsverity_verify_folio(struct folio *folio)
> +static inline bool fsverity_verify_folio(struct fsverity_info *vi,
> +					 struct folio *folio)
>  {
> -	return fsverity_verify_blocks(folio, folio_size(folio), 0);
> +	return fsverity_verify_blocks(vi, folio, folio_size(folio), 0);
>  }
>  
> -static inline bool fsverity_verify_page(struct page *page)
> +static inline bool fsverity_verify_page(struct fsverity_info *vi,
> +					struct page *page)
>  {
> -	return fsverity_verify_blocks(page_folio(page), PAGE_SIZE, 0);
> +	return fsverity_verify_blocks(vi, page_folio(page), PAGE_SIZE, 0);
>  }
>  
>  /**
> @@ -319,7 +324,8 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
>  }
>  
>  void fsverity_cleanup_inode(struct inode *inode);
> -void fsverity_readahead(struct folio *folio, unsigned long nr_pages);
> +void fsverity_readahead(struct fsverity_info *vi, struct folio *folio,
> +		unsigned long nr_pages);
>  
>  struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index);
>  void generic_readahead_merkle_tree(struct inode *inode, pgoff_t index,
> -- 
> 2.47.3
> 
> 

