Return-Path: <linux-fsdevel+bounces-75368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNSvBGQxdWmrBwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 21:53:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6219A7EF8E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 21:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 140EF3011867
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 20:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C788427F732;
	Sat, 24 Jan 2026 20:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrnYUkgM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5164F1391;
	Sat, 24 Jan 2026 20:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769288020; cv=none; b=iEYUi9X32cCbIWNyCYVQW0HD3m12/Xu6dWE0El8TsBvkZM5/39DR8+M9S9Gfdv5gvmijBk+IpGRO33jKBac8vT7tvn1GGSpeKc1/RFIK9rA2ux166oo1BbLwKxxHVULRrkWq8r2L92x7+APPrJnZ/3DOykBTFUB3Dvtpfv2l09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769288020; c=relaxed/simple;
	bh=+z7P8o/2AvAS2HxAhMpt7l6mG9q9YNMOg7B1XIrmpiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFmQ4Wy4nkOPjJJhB633Z71Uqq3KemY169lSmLJuljjBEAkS9xloE5mQ2aU+JGcUeERQTaxICf+lKK1NLrwwaYY8QwjEBwrRjPgbiwnIiEu+czi5AxUC8B9qx1DKOwKyq1Ynv1SbCj4A1MYlPNxXeR7xZI+oNvx1svbXVccE0p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrnYUkgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75893C19421;
	Sat, 24 Jan 2026 20:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769288019;
	bh=+z7P8o/2AvAS2HxAhMpt7l6mG9q9YNMOg7B1XIrmpiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrnYUkgMgLh95HZVEGLxtKpEEPIJ9i+kCGXVczoDgweCyruT+jbNyrNC0ntS8jKe/
	 h8ekQd3zwR8Z4KEvr4QksVUdZcFlsWQ9nPDrmgjbA7hghI6ep4soiakTKR6jaQpXPK
	 C0h504KGR/6MLiq82fhUImEg0m7xb/afNx7buBCXCrZHaw9Z4/qC68d5tYpzvWWZrO
	 x7W2QAcFNv/NYmm5JQ54O/qlmWpChFUAs/IBBUvBhftkiCO8o0TDWOa5e7M+/S9zTp
	 yIWglfmCgF3A6YNHzKFcoFihtN7UU1tZPF88iH9op2/GsFRkvLaHbCCFHjwa5pJ1iX
	 kcddSF2E6YUNQ==
Date: Sat, 24 Jan 2026 12:53:29 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <20260124205329.GE2762@quark>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75368-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6219A7EF8E
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:22:01AM +0100, Christoph Hellwig wrote:
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

This dereferences an ERR_PTR() when __filemap_get_folio() returns an
error other than -ENOENT.

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

This passes a position in the Merkle tree to a function that expects a
position in the file data.

I think the correct thing to do here would be the following:

        if (inode->i_sb->s_vop->readahead_merkle_tree)
		inode->i_sb->s_vop->readahead_merkle_tree(inode, index,
							  last_index - index + 1);

Then __fsverity_readahead() can be folded into fsverity_readahead().

> +void __fsverity_readahead(struct inode *inode, const struct fsverity_info *vi,
> +		loff_t data_start_pos, unsigned long nr_pages)
> +{
> +	const struct merkle_tree_params *params = &vi->tree_params;
> +	u64 start_hidx = data_start_pos >> params->log_blocksize;
> +	u64 end_hidx = (data_start_pos + ((nr_pages - 1) << PAGE_SHIFT)) >>
> +			params->log_blocksize;

(nr_pages - 1) << PAGE_SHIFT can overflow an 'unsigned long'.
(nr_pages - 1) needs to be cast to u64 before doing the shift.

But also it would make more sense to pass
(pgoff_t start_index, unsigned long nr_pages) instead of
(loff_t data_start_pos, unsigned long nr_pages),
so that the two numbers have the same units.

start_idx and end_hidx could then be computed as follows:

    u64 start_hidx = (u64)start_index << params->log_blocks_per_page;
    u64 end_hidx = (((u64)start_index + nr_pages) << params->log_blocks_per_page) - 1;

Note that fsverity_readahead() derives the position from the index.  If
it just used the index directly, that would be more direct.

> +	int level;
> +
> +	if (!inode->i_sb->s_vop->readahead_merkle_tree)
> +		return;
> +	if (unlikely(data_start_pos >= inode->i_size))
> +		return;

The check against i_size shouldn't be necessary: the caller should just
call this only for data it's actually going to read.

> +	for (level = 0; level < params->num_levels; level++) {
> +		unsigned long level_start = params->level_start[level];
> +		unsigned long next_start_hidx = start_hidx >> params->log_arity;
> +		unsigned long next_end_hidx = end_hidx >> params->log_arity;
> +		unsigned long start_idx = (level_start + next_start_hidx) >>
> +				params->log_blocks_per_page;
> +		unsigned long end_idx = (level_start + next_end_hidx) >>
> +				params->log_blocks_per_page;

start_idx and end_idx should have type pgoff_t to make it clear that
they're page indices.

> +EXPORT_SYMBOL_GPL(fsverity_readahead);

This should be below the definition of fsverity_readahead, not the
definition of __fsverity_readahead.

> +/**
> + * fsverity_readahead() - kick off readahead on fsverity hashes
> + * @folio:		first folio that is being read

folio => file data folio

Otherwise it can be confused with the Merkle tree.

> + * Start readahead on fsverity hashes.  To be called from the file systems
> + * ->read_folio and ->readahead methods to ensure that the hashes are
> + * already cached on completion of the file data read if possible.

Similarly, it would be helpful to clarify that the readahead is done on
the hashes *that will be needed to verify the specified file data*.
Otherwise it might sound like the caller is specifying the hashes to
readahead directly.

> +       /**
> +        * Perform readahad of a Merkle tree for the given inode.

readahad => readahead

- Eric

