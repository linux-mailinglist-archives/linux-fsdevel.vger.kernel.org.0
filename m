Return-Path: <linux-fsdevel+bounces-75514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDkIF9q8d2l8kgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:13:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCCB8C6AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F15433023E2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 19:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F45727A107;
	Mon, 26 Jan 2026 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUeTP6mY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A288248886;
	Mon, 26 Jan 2026 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769454799; cv=none; b=MltfkeXUifDQp0iDQgjVN3/Xfb7SH0lp0e+gaR9fWCaqLjskf6xv3AEwLr2sNzTK0EZ2qefXvKWSlc9yG7Za9Ybm3YoIju3046cUBTAFK62pIJPDQIhvI+117ibt8TPa7krdjw9v5SdPbqqvBTMQtfdj0T03dmCx0ls0ZGv6hdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769454799; c=relaxed/simple;
	bh=eT3IR992p6oONvMpC+r6wQi71diCQPvsBYr8PIDAS60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zegm/mjwmbGkMK7qU/YmS8XfVqyvhGmp1l1J5/f0BX7wimMLAeNxBz/HOxj5i1iiw9PSg9fjowuWP/w80vHjzIeLZdxzoiHz3OSb5AUXWC0P0CuG+CmXJYN1HGNNmjEPWz7US2vs52LesZd1PORjHE3nm01yVVKGwD7YhVYwKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUeTP6mY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D57C116C6;
	Mon, 26 Jan 2026 19:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769454798;
	bh=eT3IR992p6oONvMpC+r6wQi71diCQPvsBYr8PIDAS60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUeTP6mYSouKnWqfts+Fd19K43rbbbzw/DMIIBchyEZpiveM1eUIckXa5l9Y8CLII
	 TGk0KsSO/SimN8kSWWweGqMOI3Om+eiAFauIUzVuFTqYiWdERA7xniuhhlBpZW/s/1
	 9/sqbhas1kG6h24grwtNZ75DknHZtlCGdKKcFhhDhBOB8unb/xHimGxplEItnKPflp
	 6MmU6kU2OPoGvMdCu4G3dohIxAxFohOepqwzoX3BvFADp+iSe8Yqi5PVutA/SbBEZI
	 wnLrdel391jDTv3Msymbi/OtiEdPBhpuAMlZdWTdeRgWb80SHsv+MXJKeLc0wjDRsE
	 RmeIuLcKu5N7Q==
Date: Mon, 26 Jan 2026 11:13:18 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 09/16] fsverity: constify the vi pointer in
 fsverity_verification_context
Message-ID: <20260126191318.GP5910@frogsfrogsfrogs>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-10-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126045212.1381843-10-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75514-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 1DCCB8C6AD
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 05:50:55AM +0100, Christoph Hellwig wrote:
> struct fsverity_info contains information that is only read in the
> verification path.  Apply the const qualifier to match various explicitly
> passed arguments.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Seems fine to me...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/verity/verify.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index 32cadb71953c..881af159e705 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -21,7 +21,7 @@ struct fsverity_pending_block {
>  
>  struct fsverity_verification_context {
>  	struct inode *inode;
> -	struct fsverity_info *vi;
> +	const struct fsverity_info *vi;
>  
>  	/*
>  	 * This is the queue of data blocks that are pending verification.  When
> @@ -84,8 +84,8 @@ EXPORT_SYMBOL_GPL(fsverity_readahead);
>   * Returns true if the hash block with index @hblock_idx in the tree, located in
>   * @hpage, has already been verified.
>   */
> -static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
> -				   unsigned long hblock_idx)
> +static bool is_hash_block_verified(const struct fsverity_info *vi,
> +				   struct page *hpage, unsigned long hblock_idx)
>  {
>  	unsigned int blocks_per_page;
>  	unsigned int i;
> @@ -156,7 +156,8 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
>   *
>   * Return: %true if the data block is valid, else %false.
>   */
> -static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
> +static bool verify_data_block(struct inode *inode,
> +			      const struct fsverity_info *vi,
>  			      const struct fsverity_pending_block *dblock)
>  {
>  	const u64 data_pos = dblock->pos;
> @@ -315,7 +316,7 @@ static void
>  fsverity_init_verification_context(struct fsverity_verification_context *ctx,
>  				   struct inode *inode)
>  {
> -	struct fsverity_info *vi = *fsverity_info_addr(inode);
> +	const struct fsverity_info *vi = *fsverity_info_addr(inode);
>  
>  	ctx->inode = inode;
>  	ctx->vi = vi;
> @@ -342,7 +343,7 @@ fsverity_clear_pending_blocks(struct fsverity_verification_context *ctx)
>  static bool
>  fsverity_verify_pending_blocks(struct fsverity_verification_context *ctx)
>  {
> -	struct fsverity_info *vi = ctx->vi;
> +	const struct fsverity_info *vi = ctx->vi;
>  	const struct merkle_tree_params *params = &vi->tree_params;
>  	int i;
>  
> @@ -372,7 +373,7 @@ static bool fsverity_add_data_blocks(struct fsverity_verification_context *ctx,
>  				     struct folio *data_folio, size_t len,
>  				     size_t offset)
>  {
> -	struct fsverity_info *vi = ctx->vi;
> +	const struct fsverity_info *vi = ctx->vi;
>  	const struct merkle_tree_params *params = &vi->tree_params;
>  	const unsigned int block_size = params->block_size;
>  	u64 pos = (u64)data_folio->index << PAGE_SHIFT;
> -- 
> 2.47.3
> 
> 

