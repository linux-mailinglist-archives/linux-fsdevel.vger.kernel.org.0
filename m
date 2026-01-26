Return-Path: <linux-fsdevel+bounces-75515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJieGfO8d2l8kgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:13:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B72A8C6C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED616300A329
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 19:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB7427A107;
	Mon, 26 Jan 2026 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d91eKtPf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE94F248886;
	Mon, 26 Jan 2026 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769454828; cv=none; b=Cyi6aW4O420S7DDq/yAMitEPQQhQ6BDdw7j1SPCGY3u2GeXs/OITqalLKzO3TufL9wHWq5bBNooXAncYZXAYeE0jZe9nplgZX2ozbwzeswYa0LCTlkWflM1L+9IWcnqnyFhJCReGpMTe8UQWQTjrwO1FvBfybU5bpVr9fAn8XUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769454828; c=relaxed/simple;
	bh=uJ4TrmswYapcKpzl6+LRL/lyOK9W/uASjQX0lK7L4Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqri87VOFMQARpTKgTPdtigM42iM4gUSZZYccpd5rArfMCFa/YZeG8Xbfi9vwqgZpPXX0E68Q1HQifO3cx4mFNFvbFURjnAKhZq5C+uqyKCsEU+QlPuxuN/3mJXMEnTRGT4LJnpgS1SPLAdNDtU/ezBECMyr/S7Q9d8JFu1obog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d91eKtPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E91C116C6;
	Mon, 26 Jan 2026 19:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769454828;
	bh=uJ4TrmswYapcKpzl6+LRL/lyOK9W/uASjQX0lK7L4Fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d91eKtPfJIqQiS47895fe4SYkOiehS91isvaJmb2kzCOv872oSVjNl0gCClWHWg9u
	 92iD8pIPgJOrOwu4Lny6esjp5zDSZzg040JGMyM1d4RK76OHlTqyjXCNmzcxhiPapQ
	 QCn+tDe7zjTqQ/JDMJzss0MeB3frIj3Lo4p2Aiu3izb4F+hvvQZN3dZLvwN2G57CQx
	 TSUVaXvK5UfYxwC/LUEf88kZsCRirWDJDFocByCGEDqvh6Mfif66BP0agKg4NCzPGW
	 tMVFSSAJOmzTRtDXwSJZcZdMC7IVUO9Yo4U7i4c4nRjZpDAfGBEia0MV5FkjEQsRcP
	 FwamTTBa4x5UA==
Date: Mon, 26 Jan 2026 11:13:47 -0800
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
Subject: Re: [PATCH 10/16] fsverity: deconstify the inode pointer in struct
 fsverity_info
Message-ID: <20260126191347.GQ5910@frogsfrogsfrogs>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-11-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126045212.1381843-11-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75515-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 0B72A8C6C3
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 05:50:56AM +0100, Christoph Hellwig wrote:
> A lot of file system code expects a non-const inode pointer.  Dropping
> the const qualifier here allows using the inode pointer in
> verify_data_block and prepares for further argument reductions.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good, though I'm leaning heavily on the build bot and your local
gcc to find any weird problems,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/verity/fsverity_private.h | 4 ++--
>  fs/verity/open.c             | 2 +-
>  fs/verity/verify.c           | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> index dd20b138d452..f9f3936b0a89 100644
> --- a/fs/verity/fsverity_private.h
> +++ b/fs/verity/fsverity_private.h
> @@ -73,7 +73,7 @@ struct fsverity_info {
>  	struct merkle_tree_params tree_params;
>  	u8 root_hash[FS_VERITY_MAX_DIGEST_SIZE];
>  	u8 file_digest[FS_VERITY_MAX_DIGEST_SIZE];
> -	const struct inode *inode;
> +	struct inode *inode;
>  	unsigned long *hash_block_verified;
>  };
>  
> @@ -124,7 +124,7 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
>  				     unsigned int log_blocksize,
>  				     const u8 *salt, size_t salt_size);
>  
> -struct fsverity_info *fsverity_create_info(const struct inode *inode,
> +struct fsverity_info *fsverity_create_info(struct inode *inode,
>  					   struct fsverity_descriptor *desc);
>  
>  void fsverity_set_info(struct inode *inode, struct fsverity_info *vi);
> diff --git a/fs/verity/open.c b/fs/verity/open.c
> index 090cb77326ee..128502cf0a23 100644
> --- a/fs/verity/open.c
> +++ b/fs/verity/open.c
> @@ -175,7 +175,7 @@ static void compute_file_digest(const struct fsverity_hash_alg *hash_alg,
>   * appended builtin signature), and check the signature if present.  The
>   * fsverity_descriptor must have already undergone basic validation.
>   */
> -struct fsverity_info *fsverity_create_info(const struct inode *inode,
> +struct fsverity_info *fsverity_create_info(struct inode *inode,
>  					   struct fsverity_descriptor *desc)
>  {
>  	struct fsverity_info *vi;
> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index 881af159e705..55f1078c645a 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -156,10 +156,10 @@ static bool is_hash_block_verified(const struct fsverity_info *vi,
>   *
>   * Return: %true if the data block is valid, else %false.
>   */
> -static bool verify_data_block(struct inode *inode,
> -			      const struct fsverity_info *vi,
> +static bool verify_data_block(const struct fsverity_info *vi,
>  			      const struct fsverity_pending_block *dblock)
>  {
> +	struct inode *inode = vi->inode;
>  	const u64 data_pos = dblock->pos;
>  	const struct merkle_tree_params *params = &vi->tree_params;
>  	const unsigned int hsize = params->digest_size;
> @@ -362,7 +362,7 @@ fsverity_verify_pending_blocks(struct fsverity_verification_context *ctx)
>  	}
>  
>  	for (i = 0; i < ctx->num_pending; i++) {
> -		if (!verify_data_block(ctx->inode, vi, &ctx->pending_blocks[i]))
> +		if (!verify_data_block(vi, &ctx->pending_blocks[i]))
>  			return false;
>  	}
>  	fsverity_clear_pending_blocks(ctx);
> -- 
> 2.47.3
> 
> 

