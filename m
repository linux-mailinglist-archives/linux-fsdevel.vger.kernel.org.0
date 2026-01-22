Return-Path: <linux-fsdevel+bounces-75160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCsJHJ2bcmkFnAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:50:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC446DF1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EF56302AE2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F115E38E5C3;
	Thu, 22 Jan 2026 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4g5d4Fk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227CF376BF2;
	Thu, 22 Jan 2026 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118599; cv=none; b=UUqzBVY34NwawTUnUBOTBeSj3ltaIY6sO/5BZOfKMNN5VyTkehiHewzdqgIneXbPtnLq/f8Zkr8z0LYeEVkA9VR2ZpbqRranl76eaorrImDixCN/SGE9QFNQmjTxmzavItyjdY8VBOiI+IDFXEpSKnwUSh/LjRmVeNYkU8sg8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118599; c=relaxed/simple;
	bh=ufxHtozV90WXKnBj108j+ggff6c1OBhFqclRqjleqIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM2f48/G+Xu+vp5ROX5gCaKZJWxPisuMUyw2LQeiiw+MgcGgCCEVT2xsxFjZ6Pd0IA6HV52w8pqFNYlePx65vVayXpKr7BjboU2q61+a0jbnoQm7Sm+bjBmdAoi2C8zvcZHcsyHXktW/uvsckQJfzFxyXSfDFzEJ4PrHvN2cXP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4g5d4Fk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C89C116C6;
	Thu, 22 Jan 2026 21:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769118598;
	bh=ufxHtozV90WXKnBj108j+ggff6c1OBhFqclRqjleqIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4g5d4FkHk3xUtHYxm4X160kg4e6BEfG95MdgdWelDxEb9ZgNPPwKluo7553+DjAo
	 l2dUSvndt2cgZz6CszLuZ+rfvrORoCtC8wzwk0abgHZ7DkV0eS8LGrAUvO0F9qkOEL
	 rKBxkCLeE8obmuWsETZywsw+3Gwrl2RshOYvIGqCKb27UsyBt81kSt/QCSIBr2+ODA
	 yMXoBcMPa/SPGZ9RTmYqxPQmWOCdVM4yE+1RCRBBCwQLI9Y32i51LRtzqDn7Nosjuf
	 mdKleR7V6zYyEpjbsq6nxAJqHowcnSLGiFrQcO+e72N1KiAeqOhnPeNjAtOB5sqST/
	 RkwWZ4cllt2Jw==
Date: Thu, 22 Jan 2026 13:49:58 -0800
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
Subject: Re: [PATCH 07/11] fs: consolidate fsverity_info lookup in buffer.c
Message-ID: <20260122214958.GG5910@frogsfrogsfrogs>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-8-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75160-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: DCC446DF1F
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:22:03AM +0100, Christoph Hellwig wrote:
> Look up the fsverity_info once in end_buffer_async_read_io, and then
> pass it along to the I/O completion workqueue in
> struct postprocess_bh_ctx.
> 
> This amortizes the lookup better once it becomes less efficient.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/buffer.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 3982253b6805..f4b3297ef1b1 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -302,6 +302,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
>  struct postprocess_bh_ctx {
>  	struct work_struct work;
>  	struct buffer_head *bh;
> +	struct fsverity_info *vi;
>  };
>  
>  static void verify_bh(struct work_struct *work)
> @@ -309,25 +310,14 @@ static void verify_bh(struct work_struct *work)
>  	struct postprocess_bh_ctx *ctx =
>  		container_of(work, struct postprocess_bh_ctx, work);
>  	struct buffer_head *bh = ctx->bh;
> -	struct inode *inode = bh->b_folio->mapping->host;
>  	bool valid;
>  
> -	valid = fsverity_verify_blocks(*fsverity_info_addr(inode), bh->b_folio,
> -				       bh->b_size, bh_offset(bh));
> +	valid = fsverity_verify_blocks(ctx->vi, bh->b_folio, bh->b_size,
> +				       bh_offset(bh));
>  	end_buffer_async_read(bh, valid);
>  	kfree(ctx);
>  }
>  
> -static bool need_fsverity(struct buffer_head *bh)
> -{
> -	struct folio *folio = bh->b_folio;
> -	struct inode *inode = folio->mapping->host;
> -
> -	return fsverity_active(inode) &&
> -		/* needed by ext4 */
> -		folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
> -}
> -
>  static void decrypt_bh(struct work_struct *work)
>  {
>  	struct postprocess_bh_ctx *ctx =
> @@ -337,7 +327,7 @@ static void decrypt_bh(struct work_struct *work)
>  
>  	err = fscrypt_decrypt_pagecache_blocks(bh->b_folio, bh->b_size,
>  					       bh_offset(bh));
> -	if (err == 0 && need_fsverity(bh)) {
> +	if (err == 0 && ctx->vi) {
>  		/*
>  		 * We use different work queues for decryption and for verity
>  		 * because verity may require reading metadata pages that need
> @@ -359,15 +349,20 @@ static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
>  {
>  	struct inode *inode = bh->b_folio->mapping->host;
>  	bool decrypt = fscrypt_inode_uses_fs_layer_crypto(inode);
> -	bool verify = need_fsverity(bh);
> +	struct fsverity_info *vi = NULL;
> +
> +	/* needed by ext4 */
> +	if (bh->b_folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
> +		vi = fsverity_get_info(inode);

Well this is no longer a weird ext4ism, since f2fs also needs this,
right?  Maybe this comment should read:

	/*
	 * Merkle tree folios can be cached in the pagecache, but they
	 * must never be cached below the first base page offset beyond
	 * EOF because mmap can expose address space beyond EOF.
	 */
	if (bh->b_folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))

--D

>  
>  	/* Decrypt (with fscrypt) and/or verify (with fsverity) if needed. */
> -	if (uptodate && (decrypt || verify)) {
> +	if (uptodate && (decrypt || vi)) {
>  		struct postprocess_bh_ctx *ctx =
>  			kmalloc(sizeof(*ctx), GFP_ATOMIC);
>  
>  		if (ctx) {
>  			ctx->bh = bh;
> +			ctx->vi = vi;
>  			if (decrypt) {
>  				INIT_WORK(&ctx->work, decrypt_bh);
>  				fscrypt_enqueue_decrypt_work(&ctx->work);
> -- 
> 2.47.3
> 
> 

