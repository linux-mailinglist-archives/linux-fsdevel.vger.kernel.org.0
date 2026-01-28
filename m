Return-Path: <linux-fsdevel+bounces-75769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBseLkc5eml+4gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:28:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E505A5AFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBDB93004DE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FEC320CB1;
	Wed, 28 Jan 2026 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JfkyG4dy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v62W1A1R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JfkyG4dy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v62W1A1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B28314A77
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617710; cv=none; b=gm5HKWSIfWVllgrpEsbIr1EMC6q0YWFNCX/yecFxdWAo6VQvnYTntTn7okmheuI8aX74vUdItKJrgZibWUWRb7B6crnx2u36e1PlsJVmWQSWh6mLgnGF1d2rxwOCzST8Pa/1w/CEYdZo5taCjjF5vngFlUgUBUyWhn+/ZLw+b+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617710; c=relaxed/simple;
	bh=JVg2mNic3CJ+pGll6OMkPz1ohwamXi8IeMHdbBJ3IL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjrRANfr7szNebFckRGdC7g7fH0M/6oIzspcQCSD+lcJx4iV12yXsKcPYDAlLydqfxrVKEa3nx2gzieRUYp4FgR8svaXru1Qd8MFQOZBNv1UHoB6GjsjAp/ksz94mJ545aIXdgRh7H7LPZnfZWtUUehuSwmowOpdr0Tkvw9v/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JfkyG4dy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v62W1A1R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JfkyG4dy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v62W1A1R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A97585BCD1;
	Wed, 28 Jan 2026 16:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769617706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sOgtyD+rnn3xlw2AzOhByODAAMdadxJsEuDseDsD+gs=;
	b=JfkyG4dy9Ak6/TjGPZ6TNiLO3yddKkQrM1qGHGjnMbJw0fINkybCBMMe/tsXVotpp7hVzh
	6viKMucezpeTyp/H5O52zFFbVP5SQvg7ROenoaQYOzRs7/YGJdmCd8qwp+q7Apzxqt2iN1
	mKHWQIjACrY9BWuw7E+WD/JL8OFHcHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769617706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sOgtyD+rnn3xlw2AzOhByODAAMdadxJsEuDseDsD+gs=;
	b=v62W1A1Rt4vc0/KY26kJ3awOlG/d1v0AXQsMCIxX24nFSkzTPMCV47x+unlsK5isl9Mv9a
	bZKeYjK6F0WdohDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JfkyG4dy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=v62W1A1R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769617706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sOgtyD+rnn3xlw2AzOhByODAAMdadxJsEuDseDsD+gs=;
	b=JfkyG4dy9Ak6/TjGPZ6TNiLO3yddKkQrM1qGHGjnMbJw0fINkybCBMMe/tsXVotpp7hVzh
	6viKMucezpeTyp/H5O52zFFbVP5SQvg7ROenoaQYOzRs7/YGJdmCd8qwp+q7Apzxqt2iN1
	mKHWQIjACrY9BWuw7E+WD/JL8OFHcHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769617706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sOgtyD+rnn3xlw2AzOhByODAAMdadxJsEuDseDsD+gs=;
	b=v62W1A1Rt4vc0/KY26kJ3awOlG/d1v0AXQsMCIxX24nFSkzTPMCV47x+unlsK5isl9Mv9a
	bZKeYjK6F0WdohDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CB743EA61;
	Wed, 28 Jan 2026 16:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4JNQIio5emnydgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Jan 2026 16:28:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 463ACA06AC; Wed, 28 Jan 2026 17:28:26 +0100 (CET)
Date: Wed, 28 Jan 2026 17:28:26 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 12/15] ext4: consolidate fsverity_info lookup
Message-ID: <kww6k5yzaqrfkn2fuon4fdowlvs4254hpho27qiolokpiqh4s2@wuxxwhvrgjeo>
References: <20260128152630.627409-1-hch@lst.de>
 <20260128152630.627409-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128152630.627409-13-hch@lst.de>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75769-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5E505A5AFA
X-Rspamd-Action: no action

On Wed 28-01-26 16:26:24, Christoph Hellwig wrote:
> Look up the fsverity_info once in ext4_mpage_readpages, and then use it
> for the readahead, local verification of holes and pass it along to the
> I/O completion workqueue in struct bio_post_read_ctx.
> 
> This amortizes the lookup better once it becomes less efficient.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

							Honza

> ---
>  fs/ext4/readpage.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index bf65562da9c2..17920f14e2c2 100644
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
> @@ -173,22 +174,16 @@ static void mpage_end_io(struct bio *bio)
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
> @@ -197,6 +192,7 @@ static void ext4_set_bio_post_read_ctx(struct bio *bio,
>  			mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
>  
>  		ctx->bio = bio;
> +		ctx->vi = vi;
>  		ctx->enabled_steps = post_read_steps;
>  		bio->bi_private = ctx;
>  	}
> @@ -224,6 +220,7 @@ int ext4_mpage_readpages(struct inode *inode,
>  	sector_t first_block;
>  	unsigned page_block;
>  	struct block_device *bdev = inode->i_sb->s_bdev;
> +	struct fsverity_info *vi = NULL;
>  	int length;
>  	unsigned relative_block = 0;
>  	struct ext4_map_blocks map;
> @@ -245,9 +242,11 @@ int ext4_mpage_readpages(struct inode *inode,
>  			folio = readahead_folio(rac);
>  
>  		if (first_folio) {
> -			if (ext4_need_verity(inode, folio->index))
> -				fsverity_readahead(*fsverity_info_addr(inode),
> -						folio, nr_pages);
> +			if (folio->index <
> +			    DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
> +				vi = fsverity_get_info(inode);
> +			if (vi)
> +				fsverity_readahead(vi, folio, nr_pages);
>  			first_folio = false;
>  		}
>  
> @@ -338,10 +337,7 @@ int ext4_mpage_readpages(struct inode *inode,
>  			folio_zero_segment(folio, first_hole << blkbits,
>  					  folio_size(folio));
>  			if (first_hole == 0) {
> -				if (ext4_need_verity(inode, folio->index) &&
> -				    !fsverity_verify_folio(
> -						*fsverity_info_addr(inode),
> -						folio))
> +				if (vi && !fsverity_verify_folio(vi, folio))
>  					goto set_error_page;
>  				folio_end_read(folio, true);
>  				continue;
> @@ -369,7 +365,7 @@ int ext4_mpage_readpages(struct inode *inode,
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
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

