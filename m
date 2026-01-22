Return-Path: <linux-fsdevel+bounces-75161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD77LLqccmkFnAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:55:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4081A6DF8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4EA7301C10B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647E83876D1;
	Thu, 22 Jan 2026 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijE9gWqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158853994A0;
	Thu, 22 Jan 2026 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118898; cv=none; b=mRvrC8xJtD8qm7Rc1WudwGn0t/Ob9Y7kAQnAQdC2YpEOPW1Z47y8MmbP/sQ/fCVq7FKYGqaVi9tusRsZcBTm91exVLnNjqC/PILmzQJc6O7o6wo7NotuNK0IKB3eKTfEohYdgWxrDERszbpXk0tByLQXzb3wvzs8uaKmXLHkq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118898; c=relaxed/simple;
	bh=caONCuwCvjGuCRxUQ7JbMidBxiy8Pe4HnHmp8ASxXws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pm0C59fNCUh5gL92aQGSUrWbdWC1PR7i8/P32MZBUF8x6RY+ivyAdYQXQNDSj+hyLgteD6V5vYdOHLvqWVRIznOUhp5pm+olpHMT+If9QlSExf9npf9TqBc9H9khtOKKU6NIBZtvP1TIm6tGzx+5jOTeqXggraiFwDROsIYTD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijE9gWqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30C1C116C6;
	Thu, 22 Jan 2026 21:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769118897;
	bh=caONCuwCvjGuCRxUQ7JbMidBxiy8Pe4HnHmp8ASxXws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ijE9gWqKtBFIessficlOSNDv1SY2fDE4hluKoAELLXGpcf4iPxh1eBvcwaG6Xp8lm
	 kovKZNuprtj5BgSRPJF+Ii/8AjzEC/GQHxBIeC7WYQjnWNZvkT+pQnAM5WH0kw+9XL
	 iaD3vm+1LlI/1VnB0XIA9jCOIPHmPaKcfAfUaJ1AUD2rCpnnXsCANP9qOIe39KYtyX
	 SRq/FOSJhm1Tc6BnO46ZIko18c8WKHSbmtC0RLyTx9pN9C9DyT9xXezhI1kY3BNTQq
	 FBfUZA39BrF+FoafkQde0FCcymSdFe8QEEfzfKhnzxgcPNG92oa1QXBQTlUHyIItAc
	 egALlERcUc2gg==
Date: Thu, 22 Jan 2026 13:54:57 -0800
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
Subject: Re: [PATCH 08/11] ext4: consolidate fsverity_info lookup
Message-ID: <20260122215457.GH5910@frogsfrogsfrogs>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-9-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75161-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email]
X-Rspamd-Queue-Id: 4081A6DF8F
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:22:04AM +0100, Christoph Hellwig wrote:
> Look up the fsverity_info once in ext4_mpage_readpages, and then use it
> for the readahead, local verification of holes and pass it along to the
> I/O completion workqueue in struct bio_post_read_ctx.
> 
> This amortizes the lookup better once it becomes less efficient.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/ext4/readpage.c | 33 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index 02f918cf1945..6092d6d59063 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -61,6 +61,7 @@ enum bio_post_read_step {
>  
>  struct bio_post_read_ctx {
>  	struct bio *bio;
> +	struct fsverity_info *vi;
>  	struct work_struct work;
>  	unsigned int cur_step;
>  	unsigned int enabled_steps;
> @@ -96,7 +97,7 @@ static void verity_work(struct work_struct *work)
>  	struct bio_post_read_ctx *ctx =
>  		container_of(work, struct bio_post_read_ctx, work);
>  	struct bio *bio = ctx->bio;
> -	struct inode *inode = bio_first_folio_all(bio)->mapping->host;
> +	struct fsverity_info *vi = ctx->vi;
>  
>  	/*
>  	 * fsverity_verify_bio() may call readahead() again, and although verity
> @@ -109,7 +110,7 @@ static void verity_work(struct work_struct *work)
>  	mempool_free(ctx, bio_post_read_ctx_pool);
>  	bio->bi_private = NULL;
>  
> -	fsverity_verify_bio(*fsverity_info_addr(inode), bio);
> +	fsverity_verify_bio(vi, bio);
>  
>  	__read_end_io(bio);
>  }
> @@ -172,22 +173,16 @@ static void mpage_end_io(struct bio *bio)
>  	__read_end_io(bio);
>  }
>  
> -static inline bool ext4_need_verity(const struct inode *inode, pgoff_t idx)
> -{
> -	return fsverity_active(inode) &&
> -	       idx < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
> -}
> -
>  static void ext4_set_bio_post_read_ctx(struct bio *bio,
>  				       const struct inode *inode,
> -				       pgoff_t first_idx)
> +				       struct fsverity_info *vi)
>  {
>  	unsigned int post_read_steps = 0;
>  
>  	if (fscrypt_inode_uses_fs_layer_crypto(inode))
>  		post_read_steps |= 1 << STEP_DECRYPT;
>  
> -	if (ext4_need_verity(inode, first_idx))
> +	if (vi)
>  		post_read_steps |= 1 << STEP_VERITY;
>  
>  	if (post_read_steps) {
> @@ -196,6 +191,7 @@ static void ext4_set_bio_post_read_ctx(struct bio *bio,
>  			mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
>  
>  		ctx->bio = bio;
> +		ctx->vi = vi;
>  		ctx->enabled_steps = post_read_steps;
>  		bio->bi_private = ctx;
>  	}
> @@ -223,6 +219,7 @@ int ext4_mpage_readpages(struct inode *inode,
>  	sector_t first_block;
>  	unsigned page_block;
>  	struct block_device *bdev = inode->i_sb->s_bdev;
> +	struct fsverity_info *vi = NULL;
>  	int length;
>  	unsigned relative_block = 0;
>  	struct ext4_map_blocks map;
> @@ -244,9 +241,11 @@ int ext4_mpage_readpages(struct inode *inode,
>  			folio = readahead_folio(rac);
>  
>  		if (first_folio) {
> -			if (ext4_need_verity(inode, folio->index))
> -				fsverity_readahead(*fsverity_info_addr(inode),
> -						folio, nr_pages);
> +			if (folio->index <
> +			    DIV_ROUND_UP(inode->i_size, PAGE_SIZE))

I keep seeing this predicate, maybe it should go into fsverity.h as a
helper function with the comment about mmap that I was muttering about
in the previous patch?

Or maybe a "get verity info for given folio index" helper?

/*
 * Grab the fsverity context needed to verify the contents of the folio.
 *
 * <Big fat comment from before, about mmap and whatnot>
 */
static inline struct fsverity_info *vi
fsverity_folio_info(const struct folio *folio)
{
	struct inode *inode = folio->mapping->host;

	if (folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
		return fsverity_get_info(inode);
	return NULL;
}

then ext4 just does:

		vi = fsverity_folio_info(folio);
		if (vi)
			fsverity_readahead(vi, folio, nr_pages);

Hrm?

--D

> +				vi = fsverity_get_info(inode);
> +			if (vi)
> +				fsverity_readahead(vi, folio, nr_pages);
>  			first_folio = false;
>  		}
>  
> @@ -337,11 +336,7 @@ int ext4_mpage_readpages(struct inode *inode,
>  			folio_zero_segment(folio, first_hole << blkbits,
>  					  folio_size(folio));
>  			if (first_hole == 0) {
> -				struct fsverity_info *vi =
> -					*fsverity_info_addr(folio->mapping->host);
> -
> -				if (ext4_need_verity(inode, folio->index) &&
> -				    !fsverity_verify_folio(vi, folio))
> +				if (vi && !fsverity_verify_folio(vi, folio))
>  					goto set_error_page;
>  				folio_end_read(folio, true);
>  				continue;
> @@ -369,7 +364,7 @@ int ext4_mpage_readpages(struct inode *inode,
>  					REQ_OP_READ, GFP_KERNEL);
>  			fscrypt_set_bio_crypt_ctx(bio, inode, next_block,
>  						  GFP_KERNEL);
> -			ext4_set_bio_post_read_ctx(bio, inode, folio->index);
> +			ext4_set_bio_post_read_ctx(bio, inode, vi);
>  			bio->bi_iter.bi_sector = first_block << (blkbits - 9);
>  			bio->bi_end_io = mpage_end_io;
>  			if (rac)
> -- 
> 2.47.3
> 
> 

