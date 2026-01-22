Return-Path: <linux-fsdevel+bounces-75155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNiNAAqWcmmSmwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:26:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B356DBD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F58C302417A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337583BFE53;
	Thu, 22 Jan 2026 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYqJ0K+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62731395728;
	Thu, 22 Jan 2026 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769116998; cv=none; b=O9+u8pOxj2W03Te0xvqMoUDpRFuVH0rN5z7xpBWRPQMpUDuFPjgO7BApfpxY97+NDGFRezHxLiR//l0GkMO9JzmEoS5RpLQTwjPShtugkbFEfdMekIm6jvcpqj7SQyT6FCBInOwHTOnxka76/35rGF/I500+mI1dEpY3uPZlCwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769116998; c=relaxed/simple;
	bh=0E0Y8wsqJ+yOMAQ4nu9GNNF6bw/35ygZ2QAwswXS4vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF+LlayQW85i2UiOxp6LhRqPMIdrFStIAng0Vsh1osp8teEO0rmoo+uqvdMxhXpKMSEoWLpu4jsV1huR9Fu4KKUYMMy3HYRn49qccx7LlrmWUmKrCGtOgCM1J4ZovJTrJu9RrhLyulFnq9X31db0T6PnP7TT6PMDU9m35HsnlvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYqJ0K+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC3CC116C6;
	Thu, 22 Jan 2026 21:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769116997;
	bh=0E0Y8wsqJ+yOMAQ4nu9GNNF6bw/35ygZ2QAwswXS4vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYqJ0K+ugsFxKRUIYHjG1TDtiUsx2nCAdR3j72YHrTYhOk/VoYlV+xesp22IIaLdS
	 1fjsWE0gmIz/0CuMxMKVWU9pVSSXgGB2UpWka+NjfLUs57nNLxoQn23TM7sAqSptUd
	 xvXHIfzRq+RBLtwuI6o4mjYcC6bPzV+tNw0yUazdQGlp7NNppD3SLF3chINkB/l1Aj
	 tMlYC56a/THCWlvwpx70crpYuMARDzxMtBpP9JQ/fxRYE7NsLxGOo56ggX+X+agCWy
	 dcmsM9/S5ZsoH60m/cEaMLdJ9WZDqxpnWkAOFvJ1vs2Dhb+AlRqGBQu0S5989n50os
	 0v2AQn9NN3jhg==
Date: Thu, 22 Jan 2026 13:23:16 -0800
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
Subject: Re: [PATCH 03/11] fsverity: pass struct file to
 ->write_merkle_tree_block
Message-ID: <20260122212316.GC5910@frogsfrogsfrogs>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-4-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75155-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60B356DBD6
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:21:59AM +0100, Christoph Hellwig wrote:
> This will make an iomap implementation of the method easier.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Much better...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/btrfs/verity.c        | 5 +++--
>  fs/ext4/verity.c         | 6 +++---
>  fs/f2fs/verity.c         | 6 +++---
>  fs/verity/enable.c       | 9 +++++----
>  include/linux/fsverity.h | 4 ++--
>  5 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> index a2ac3fb68bc8..e7643c22a6bf 100644
> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c
> @@ -774,16 +774,17 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
>  /*
>   * fsverity op that writes a Merkle tree block into the btree.
>   *
> - * @inode:	inode to write a Merkle tree block for
> + * @file:	file to write a Merkle tree block for
>   * @buf:	Merkle tree block to write
>   * @pos:	the position of the block in the Merkle tree (in bytes)
>   * @size:	the Merkle tree block size (in bytes)
>   *
>   * Returns 0 on success or negative error code on failure
>   */
> -static int btrfs_write_merkle_tree_block(struct inode *inode, const void *buf,
> +static int btrfs_write_merkle_tree_block(struct file *file, const void *buf,
>  					 u64 pos, unsigned int size)
>  {
> +	struct inode *inode = file_inode(file);
>  	loff_t merkle_pos = merkle_file_pos(inode);
>  
>  	if (merkle_pos < 0)
> diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> index 415d9c4d8a32..2ce4cf8a1e31 100644
> --- a/fs/ext4/verity.c
> +++ b/fs/ext4/verity.c
> @@ -380,12 +380,12 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
>  	return folio_file_page(folio, index);
>  }
>  
> -static int ext4_write_merkle_tree_block(struct inode *inode, const void *buf,
> +static int ext4_write_merkle_tree_block(struct file *file, const void *buf,
>  					u64 pos, unsigned int size)
>  {
> -	pos += ext4_verity_metadata_pos(inode);
> +	pos += ext4_verity_metadata_pos(file_inode(file));
>  
> -	return pagecache_write(inode, buf, size, pos);
> +	return pagecache_write(file_inode(file), buf, size, pos);
>  }
>  
>  const struct fsverity_operations ext4_verityops = {
> diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
> index 05b935b55216..c1c4d8044681 100644
> --- a/fs/f2fs/verity.c
> +++ b/fs/f2fs/verity.c
> @@ -278,12 +278,12 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
>  	return folio_file_page(folio, index);
>  }
>  
> -static int f2fs_write_merkle_tree_block(struct inode *inode, const void *buf,
> +static int f2fs_write_merkle_tree_block(struct file *file, const void *buf,
>  					u64 pos, unsigned int size)
>  {
> -	pos += f2fs_verity_metadata_pos(inode);
> +	pos += f2fs_verity_metadata_pos(file_inode(file));
>  
> -	return pagecache_write(inode, buf, size, pos);
> +	return pagecache_write(file_inode(file), buf, size, pos);
>  }
>  
>  const struct fsverity_operations f2fs_verityops = {
> diff --git a/fs/verity/enable.c b/fs/verity/enable.c
> index 95ec42b84797..c56c18e2605b 100644
> --- a/fs/verity/enable.c
> +++ b/fs/verity/enable.c
> @@ -41,14 +41,15 @@ static int hash_one_block(const struct merkle_tree_params *params,
>  	return 0;
>  }
>  
> -static int write_merkle_tree_block(struct inode *inode, const u8 *buf,
> +static int write_merkle_tree_block(struct file *file, const u8 *buf,
>  				   unsigned long index,
>  				   const struct merkle_tree_params *params)
>  {
> +	struct inode *inode = file_inode(file);
>  	u64 pos = (u64)index << params->log_blocksize;
>  	int err;
>  
> -	err = inode->i_sb->s_vop->write_merkle_tree_block(inode, buf, pos,
> +	err = inode->i_sb->s_vop->write_merkle_tree_block(file, buf, pos,
>  							  params->block_size);
>  	if (err)
>  		fsverity_err(inode, "Error %d writing Merkle tree block %lu",
> @@ -135,7 +136,7 @@ static int build_merkle_tree(struct file *filp,
>  			err = hash_one_block(params, &buffers[level]);
>  			if (err)
>  				goto out;
> -			err = write_merkle_tree_block(inode,
> +			err = write_merkle_tree_block(filp,
>  						      buffers[level].data,
>  						      level_offset[level],
>  						      params);
> @@ -155,7 +156,7 @@ static int build_merkle_tree(struct file *filp,
>  			err = hash_one_block(params, &buffers[level]);
>  			if (err)
>  				goto out;
> -			err = write_merkle_tree_block(inode,
> +			err = write_merkle_tree_block(filp,
>  						      buffers[level].data,
>  						      level_offset[level],
>  						      params);
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index ea1ed2e6c2f9..e22cf84fe83a 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -116,7 +116,7 @@ struct fsverity_operations {
>  	/**
>  	 * Write a Merkle tree block to the given inode.
>  	 *
> -	 * @inode: the inode for which the Merkle tree is being built
> +	 * @file: the file for which the Merkle tree is being built
>  	 * @buf: the Merkle tree block to write
>  	 * @pos: the position of the block in the Merkle tree (in bytes)
>  	 * @size: the Merkle tree block size (in bytes)
> @@ -126,7 +126,7 @@ struct fsverity_operations {
>  	 *
>  	 * Return: 0 on success, -errno on failure
>  	 */
> -	int (*write_merkle_tree_block)(struct inode *inode, const void *buf,
> +	int (*write_merkle_tree_block)(struct file *file, const void *buf,
>  				       u64 pos, unsigned int size);
>  };
>  
> -- 
> 2.47.3
> 
> 

