Return-Path: <linux-fsdevel+bounces-75158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHELE9mZcmnBmwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:42:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1176DE40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8712301DDA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E32B3C23C7;
	Thu, 22 Jan 2026 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dve5eph1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83137AA8B;
	Thu, 22 Jan 2026 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118148; cv=none; b=Fd8l25fA1GgMUh0XxY/aAtFd0w6803ex92knckpjHxeZSBO7oEMJVpohBj9QtAbFfjvDfOUNGLbKy+j99jG3qk4hF/LVt0H2IgHNVcGZ2mEBxhd35Khrxni1KAlXJ0x05HMd5+XXXvHUW/YyJ6Dn6/Y7yaZyrdW7zdwbRClqj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118148; c=relaxed/simple;
	bh=WmsxVBNy5gYTD03tdOxih5EC00R1xv6hp/bh7pyZVI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWOp1XBAkp1XBkr+pbYg8+q6D+XKcDsOWbHnrTp5m5JmkqZWfBup51P8K36GHdHdGrLZmBUF+MU3AlU92dxyQmbCUcWFxwxx+aNnpI5Vv+tOc03JhrvekXKQUdS+ouyWyIwaHI6aidDm11qepU4tfnCD9AMsYUsC1whtHxpZgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dve5eph1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5636C116C6;
	Thu, 22 Jan 2026 21:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769118148;
	bh=WmsxVBNy5gYTD03tdOxih5EC00R1xv6hp/bh7pyZVI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dve5eph1z1w3rBM7y2Y/LBpkDT6CRqhPTpIVdY56z06yY16RHIQDlCfm/RrtLi0bt
	 wpNfeFZvpR2IXG1GDVO1tzzz+zxhUGteiqt+uPyQGZ6qwU153hZq8veLESKlXd/P13
	 YQI7Nu78kYzF5rukluta1y2/8DAI9iBYE4b4xOj3bxK7uSe6r5tVAMYiVkLjgdSa5f
	 zklIDITtzSZTFU0ytwKII7AC6RYA2eaYmOCuUrXymkC7q41w47N7Jtj9mWQa3A0Jem
	 +Nx8YGg5wkd5U48C5n7B+eI6ueUA5WcZJ6UlF0ItuF2FfdFBavsPZFYcOFGKbHGjZU
	 l3ajwsol3zBqw==
Date: Thu, 22 Jan 2026 13:42:27 -0800
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
Subject: Re: [PATCH 05/11] fsverity: kick off hash readahead at data I/O
 submission time
Message-ID: <20260122214227.GE5910@frogsfrogsfrogs>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-6-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75158-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 0B1176DE40
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:22:01AM +0100, Christoph Hellwig wrote:
> Currently all reads of the fsverity hashes is kicked off from the data
> I/O completion handler, leading to needlessly dependent I/O.  This is
> worked around a bit by performing readahead on the level 0 nodes, but
> still fairly ineffective.
> 
> Switch to a model where the ->read_folio and ->readahead methods instead
> kick off explicit readahead of the fsverity hashed so they are usually
> available at I/O completion time.
> 
> For 64k sequential reads on my test VM this improves read performance
> from 2.4GB/s - 2.6GB/s to 3.5GB/s - 3.9GB/s.  The improvements for
> random reads are likely to be even bigger.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/verity.c            |  4 +-
>  fs/ext4/readpage.c           |  7 +++
>  fs/ext4/verity.c             | 13 ++++--
>  fs/f2fs/data.c               |  7 +++
>  fs/f2fs/verity.c             | 13 ++++--
>  fs/verity/Makefile           |  3 +-
>  fs/verity/fsverity_private.h |  2 +
>  fs/verity/pagecache.c        | 41 ++++++++++++------
>  fs/verity/read_metadata.c    | 10 ++---
>  fs/verity/verify.c           | 82 ++++++++++++++++++++++++------------
>  include/linux/fsverity.h     | 29 +++++++++----
>  11 files changed, 149 insertions(+), 62 deletions(-)
> 
> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> index e7643c22a6bf..c152bef71e8b 100644
> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c
> @@ -697,7 +697,6 @@ int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size)
>   *
>   * @inode:         inode to read a merkle tree page for
>   * @index:         page index relative to the start of the merkle tree
> - * @num_ra_pages:  number of pages to readahead. Optional, we ignore it
>   *
>   * The Merkle tree is stored in the filesystem btree, but its pages are cached
>   * with a logical position past EOF in the inode's mapping.
> @@ -705,8 +704,7 @@ int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size)
>   * Returns the page we read, or an ERR_PTR on error.
>   */
>  static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
> -						pgoff_t index,
> -						unsigned long num_ra_pages)
> +						pgoff_t index)
>  {
>  	struct folio *folio;
>  	u64 off = (u64)index << PAGE_SHIFT;
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index e7f2350c725b..574584123b8a 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -226,6 +226,7 @@ int ext4_mpage_readpages(struct inode *inode,
>  	unsigned relative_block = 0;
>  	struct ext4_map_blocks map;
>  	unsigned int nr_pages, folio_pages;
> +	bool first_folio = true;
>  
>  	map.m_pblk = 0;
>  	map.m_lblk = 0;
> @@ -241,6 +242,12 @@ int ext4_mpage_readpages(struct inode *inode,
>  		if (rac)
>  			folio = readahead_folio(rac);
>  
> +		if (first_folio) {
> +			if (ext4_need_verity(inode, folio->index))
> +				fsverity_readahead(folio, nr_pages);

Ok, so here ext4 is trying to read a data page into memory, so we
initiate readahead on the merkle tree block(s) for that data page.

> +			first_folio = false;
> +		}
> +
>  		folio_pages = folio_nr_pages(folio);
>  		prefetchw(&folio->flags);
>  

<snip>

> diff --git a/fs/verity/Makefile b/fs/verity/Makefile
> index 435559a4fa9e..2475d72ff861 100644
> --- a/fs/verity/Makefile
> +++ b/fs/verity/Makefile
> @@ -5,7 +5,8 @@ obj-$(CONFIG_FS_VERITY) += enable.o \
>  			   init.o \
>  			   measure.o \
>  			   open.o \
> +			   pagecache.o \
>  			   read_metadata.o \
> -			   verify.o
> +			   verify.o \
>  
>  obj-$(CONFIG_FS_VERITY_BUILTIN_SIGNATURES) += signature.o
> diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> index dd20b138d452..9018b71b3b23 100644
> --- a/fs/verity/fsverity_private.h
> +++ b/fs/verity/fsverity_private.h
> @@ -159,6 +159,8 @@ static inline void fsverity_init_signature(void)
>  
>  /* verify.c */
>  
> +void __fsverity_readahead(struct inode *inode, const struct fsverity_info *vi,
> +		loff_t data_start_pos, unsigned long nr_pages);
>  void __init fsverity_init_workqueue(void);
>  
>  #endif /* _FSVERITY_PRIVATE_H */
> diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
> index 1efcdde20b73..53cbf27f9fed 100644
> --- a/fs/verity/pagecache.c
> +++ b/fs/verity/pagecache.c
> @@ -10,29 +10,44 @@
>   * generic_read_merkle_tree_page - generic ->read_merkle_tree_page helper
>   * @inode:	inode containing the Merkle tree
>   * @index:	0-based index of the page in the inode
> - * @num_ra_pages: The number of Merkle tree pages that should be prefetched.
>   *
>   * The caller needs to adjust @index from the Merkle-tree relative index passed
>   * to ->read_merkle_tree_page to the actual index where the Merkle tree is
>   * stored in the page cache for @inode.
>   */
> -struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
> -		unsigned long num_ra_pages)
> +struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index)
> +{
> +	struct folio *folio;
> +
> +	folio = read_mapping_folio(inode->i_mapping, index, NULL);
> +	if (IS_ERR(folio))
> +		return ERR_CAST(folio);
> +	return folio_file_page(folio, index);
> +}
> +EXPORT_SYMBOL_GPL(generic_read_merkle_tree_page);
> +
> +/**
> + * generic_readahead_merkle_tree() - generic ->readahead_merkle_tree helper
> + * @inode:	inode containing the Merkle tree
> + * @index:	0-based index of the first page to read ahead in the inode
> + * @nr_pages:	number of data pages to read ahead
> + *
> + * The caller needs to adjust @index from the Merkle-tree relative index passed
> + * to ->read_merkle_tree_page to the actual index where the Merkle tree is
> + * stored in the page cache for @inode.
> + */
> +void generic_readahead_merkle_tree(struct inode *inode, pgoff_t index,
> +		unsigned long nr_pages)
>  {
>  	struct folio *folio;
>  
>  	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
> -	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
> +	if (PTR_ERR(folio) == -ENOENT || !folio_test_uptodate(folio)) {
>  		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
>  
> -		if (!IS_ERR(folio))
> -			folio_put(folio);
> -		else if (num_ra_pages > 1)
> -			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
> -		folio = read_mapping_folio(inode->i_mapping, index, NULL);
> -		if (IS_ERR(folio))
> -			return ERR_CAST(folio);
> +		page_cache_ra_unbounded(&ractl, nr_pages, 0);
>  	}
> -	return folio_file_page(folio, index);
> +	if (!IS_ERR(folio))
> +		folio_put(folio);
>  }
> -EXPORT_SYMBOL_GPL(generic_read_merkle_tree_page);
> +EXPORT_SYMBOL_GPL(generic_readahead_merkle_tree);

Ok, so here we're splitting read and readahead into separate pieces,
that makes sense.

> diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
> index cba5d6af4e04..430306abc4c6 100644
> --- a/fs/verity/read_metadata.c
> +++ b/fs/verity/read_metadata.c
> @@ -28,24 +28,24 @@ static int fsverity_read_merkle_tree(struct inode *inode,
>  	if (offset >= end_offset)
>  		return 0;
>  	offs_in_page = offset_in_page(offset);
> +	index = offset >> PAGE_SHIFT;
>  	last_index = (end_offset - 1) >> PAGE_SHIFT;
>  
> +	__fsverity_readahead(inode, vi, offset, last_index - index + 1);

I went "Huh??" here until I realized that this is the function that
reads merkle tree content on behalf of some ioctl, so this is merely
starting readahead for that.  Not sure anyone cares about throughput of
FS_VERITY_METADATA_TYPE_MERKLE_TREE but sure why not.

> +
>  	/*
>  	 * Iterate through each Merkle tree page in the requested range and copy
>  	 * the requested portion to userspace.  Note that the Merkle tree block
>  	 * size isn't important here, as we are returning a byte stream; i.e.,
>  	 * we can just work with pages even if the tree block size != PAGE_SIZE.
>  	 */
> -	for (index = offset >> PAGE_SHIFT; index <= last_index; index++) {
> -		unsigned long num_ra_pages =
> -			min_t(unsigned long, last_index - index + 1,
> -			      inode->i_sb->s_bdi->io_pages);
> +	for (; index <= last_index; index++) {
>  		unsigned int bytes_to_copy = min_t(u64, end_offset - offset,
>  						   PAGE_SIZE - offs_in_page);
>  		struct page *page;
>  		const void *virt;
>  
> -		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
> +		page = vops->read_merkle_tree_page(inode, index);
>  		if (IS_ERR(page)) {
>  			err = PTR_ERR(page);
>  			fsverity_err(inode,
> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index 86067c8b40cf..7ccd906e2b28 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/bio.h>
>  #include <linux/export.h>
> +#include <linux/pagemap.h>
>  
>  #define FS_VERITY_MAX_PENDING_BLOCKS 2
>  
> @@ -21,7 +22,6 @@ struct fsverity_pending_block {
>  struct fsverity_verification_context {
>  	struct inode *inode;
>  	struct fsverity_info *vi;
> -	unsigned long max_ra_pages;
>  
>  	/*
>  	 * This is the queue of data blocks that are pending verification.  When
> @@ -37,6 +37,55 @@ struct fsverity_verification_context {
>  
>  static struct workqueue_struct *fsverity_read_workqueue;
>  
> +void __fsverity_readahead(struct inode *inode, const struct fsverity_info *vi,
> +		loff_t data_start_pos, unsigned long nr_pages)
> +{
> +	const struct merkle_tree_params *params = &vi->tree_params;
> +	u64 start_hidx = data_start_pos >> params->log_blocksize;
> +	u64 end_hidx = (data_start_pos + ((nr_pages - 1) << PAGE_SHIFT)) >>
> +			params->log_blocksize;

I really wish these unit conversions had proper types and helpers
instead of this multiline to read shifting stuff.  Oh well, you didn't
write it this way, you're just slicing and dicing.

> +	int level;
> +
> +	if (!inode->i_sb->s_vop->readahead_merkle_tree)
> +		return;
> +	if (unlikely(data_start_pos >= inode->i_size))
> +		return;
> +
> +	for (level = 0; level < params->num_levels; level++) {
> +		unsigned long level_start = params->level_start[level];
> +		unsigned long next_start_hidx = start_hidx >> params->log_arity;
> +		unsigned long next_end_hidx = end_hidx >> params->log_arity;
> +		unsigned long start_idx = (level_start + next_start_hidx) >>
> +				params->log_blocks_per_page;
> +		unsigned long end_idx = (level_start + next_end_hidx) >>
> +				params->log_blocks_per_page;
> +
> +		inode->i_sb->s_vop->readahead_merkle_tree(inode, start_idx,
> +				end_idx - start_idx + 1);
> +
> +		start_hidx = next_start_hidx;
> +		end_hidx = next_end_hidx;
> +	}

So if I read this correctly, we're initiating readahead of merkle tree
(leaf) data for the file data range starting at data_start_pos and
running for (nr_pages<<SHIFT) bytes?  Then going another level up in the
merkle tree and initiating readahead for the corresponding interior
nodes until we get to the root?

> +}
> +EXPORT_SYMBOL_GPL(fsverity_readahead);
> +
> +/**
> + * fsverity_readahead() - kick off readahead on fsverity hashes
> + * @folio:		first folio that is being read
> + * @nr_pages:		number of data pages to read
> + *
> + * Start readahead on fsverity hashes.  To be called from the file systems
> + * ->read_folio and ->readahead methods to ensure that the hashes are
> + * already cached on completion of the file data read if possible.
> + */
> +void fsverity_readahead(struct folio *folio, unsigned long nr_pages)
> +{
> +	struct inode *inode = folio->mapping->host;
> +
> +	return __fsverity_readahead(inode, *fsverity_info_addr(inode),
> +			folio_pos(folio), nr_pages);
> +}
> +
>  /*
>   * Returns true if the hash block with index @hblock_idx in the tree, located in
>   * @hpage, has already been verified.
> @@ -114,8 +163,7 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
>   * Return: %true if the data block is valid, else %false.
>   */
>  static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
> -			      const struct fsverity_pending_block *dblock,
> -			      unsigned long max_ra_pages)
> +			      const struct fsverity_pending_block *dblock)
>  {
>  	const u64 data_pos = dblock->pos;
>  	const struct merkle_tree_params *params = &vi->tree_params;
> @@ -200,8 +248,7 @@ static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  			  (params->block_size - 1);
>  
>  		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode,
> -				hpage_idx, level == 0 ? min(max_ra_pages,
> -					params->tree_pages - hpage_idx) : 0);
> +				hpage_idx);
>  		if (IS_ERR(hpage)) {
>  			fsverity_err(inode,
>  				     "Error %ld reading Merkle tree page %lu",
> @@ -272,14 +319,12 @@ static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  
>  static void
>  fsverity_init_verification_context(struct fsverity_verification_context *ctx,
> -				   struct inode *inode,
> -				   unsigned long max_ra_pages)
> +				   struct inode *inode)
>  {
>  	struct fsverity_info *vi = *fsverity_info_addr(inode);
>  
>  	ctx->inode = inode;
>  	ctx->vi = vi;
> -	ctx->max_ra_pages = max_ra_pages;
>  	ctx->num_pending = 0;
>  	if (vi->tree_params.hash_alg->algo_id == HASH_ALGO_SHA256 &&
>  	    sha256_finup_2x_is_optimized())
> @@ -322,8 +367,7 @@ fsverity_verify_pending_blocks(struct fsverity_verification_context *ctx)
>  	}
>  
>  	for (i = 0; i < ctx->num_pending; i++) {
> -		if (!verify_data_block(ctx->inode, vi, &ctx->pending_blocks[i],
> -				       ctx->max_ra_pages))
> +		if (!verify_data_block(ctx->inode, vi, &ctx->pending_blocks[i]))
>  			return false;
>  	}
>  	fsverity_clear_pending_blocks(ctx);
> @@ -373,7 +417,7 @@ bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset)
>  {
>  	struct fsverity_verification_context ctx;
>  
> -	fsverity_init_verification_context(&ctx, folio->mapping->host, 0);
> +	fsverity_init_verification_context(&ctx, folio->mapping->host);
>  
>  	if (fsverity_add_data_blocks(&ctx, folio, len, offset) &&
>  	    fsverity_verify_pending_blocks(&ctx))
> @@ -403,22 +447,8 @@ void fsverity_verify_bio(struct bio *bio)
>  	struct inode *inode = bio_first_folio_all(bio)->mapping->host;
>  	struct fsverity_verification_context ctx;
>  	struct folio_iter fi;
> -	unsigned long max_ra_pages = 0;
> -
> -	if (bio->bi_opf & REQ_RAHEAD) {
> -		/*
> -		 * If this bio is for data readahead, then we also do readahead
> -		 * of the first (largest) level of the Merkle tree.  Namely,
> -		 * when a Merkle tree page is read, we also try to piggy-back on
> -		 * some additional pages -- up to 1/4 the number of data pages.
> -		 *
> -		 * This improves sequential read performance, as it greatly
> -		 * reduces the number of I/O requests made to the Merkle tree.
> -		 */
> -		max_ra_pages = bio->bi_iter.bi_size >> (PAGE_SHIFT + 2);
> -	}
>  
> -	fsverity_init_verification_context(&ctx, inode, max_ra_pages);
> +	fsverity_init_verification_context(&ctx, inode);
>  
>  	bio_for_each_folio_all(fi, bio) {
>  		if (!fsverity_add_data_blocks(&ctx, fi.folio, fi.length,
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 121703625cc8..862fea8a2eb1 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -97,10 +97,6 @@ struct fsverity_operations {
>  	 *
>  	 * @inode: the inode
>  	 * @index: 0-based index of the page within the Merkle tree
> -	 * @num_ra_pages: The number of Merkle tree pages that should be
> -	 *		  prefetched starting at @index if the page at @index
> -	 *		  isn't already cached.  Implementations may ignore this
> -	 *		  argument; it's only a performance optimization.
>  	 *
>  	 * This can be called at any time on an open verity file.  It may be
>  	 * called by multiple processes concurrently, even with the same page.
> @@ -110,8 +106,23 @@ struct fsverity_operations {
>  	 * Return: the page on success, ERR_PTR() on failure
>  	 */
>  	struct page *(*read_merkle_tree_page)(struct inode *inode,
> -					      pgoff_t index,
> -					      unsigned long num_ra_pages);
> +					      pgoff_t index);
> +
> +	/**
> +	 * Perform readahad of a Merkle tree for the given inode.
> +	 *
> +	 * @inode: the inode
> +	 * @index: 0-based index of the first page within the Merkle tree
> +	 * @nr_pages: number of pages to be read ahead.
> +	 *
> +	 * This can be called at any time on an open verity file.  It may be
> +	 * called by multiple processes concurrently, even with the same range.
> +	 *
> +	 * Optional method so that ->read_merkle_tree_page preferably finds
> +	 * cached data instead of issuing dependent I/O.
> +	 */
> +	void (*readahead_merkle_tree)(struct inode *inode, pgoff_t index,
> +			unsigned long nr_pages);

I think this is a reasonable interface.  The patch mostly looks good to
me, save for my comments and question above.

--D

>  
>  	/**
>  	 * Write a Merkle tree block to the given inode.
> @@ -308,8 +319,10 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
>  }
>  
>  void fsverity_cleanup_inode(struct inode *inode);
> +void fsverity_readahead(struct folio *folio, unsigned long nr_pages);
>  
> -struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
> -		unsigned long num_ra_pages);
> +struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index);
> +void generic_readahead_merkle_tree(struct inode *inode, pgoff_t index,
> +		unsigned long nr_pages);
>  
>  #endif	/* _LINUX_FSVERITY_H */
> -- 
> 2.47.3
> 
> 

