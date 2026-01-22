Return-Path: <linux-fsdevel+bounces-75156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKUGJ4CWcmmSmwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:28:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 469B46DC30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EB4C303C032
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E67F3994A4;
	Thu, 22 Jan 2026 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJPq9gkt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD31C38E5CA;
	Thu, 22 Jan 2026 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117223; cv=none; b=E1Gyo3nZHgpBLPe9fBb+8X2Vm9jUbk2TK2h2sj43DofF33RR3KLYoqqpSzaphlf6rfgqAKBQlM6RMBFrxWwmIRInthkTxuVOgdzyWHc4eQZA82YNqqXAgRpwMurJNG73rGEu7+OR1h4oZiCzk7PB/EZ9GXApK7mBxipaL0Wuyi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117223; c=relaxed/simple;
	bh=U10N7ULI9KAcvzTiDsxNFxtjl4EJCZqPOvlb4g1ZbUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9+Orau13yT8HQQ6s1RjeiA5ZNAeciDIe5DJ5bl+teZ11zSa7NlueKZQW8v8HMAhtFLtcH6xPScgWjLzWBzosFmVDXDmgaeepuArWVbGS7kDyRfPH+bW/a0j1LezF3XMQgwHyJQxtBqAPFN4nWElg+vVWUfYPgLGfwlxUNk7sY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJPq9gkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE21C19423;
	Thu, 22 Jan 2026 21:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769117221;
	bh=U10N7ULI9KAcvzTiDsxNFxtjl4EJCZqPOvlb4g1ZbUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJPq9gktVwk0sp4pr0hoATeQnthpgn9hLQIzJzJiyOCIZuuq72NaoYVe0Qh3fFELw
	 UDA79/097W+MDYAWljX5K4kMsMbyLiXZ6zKD5WeXv42sohvNwPOcVDlHoCWY960VOF
	 GUImQW0Sp1IVRwcpGVtZpOGhzaR7ldOijeiofs912DMIk4jeVieWzVqth0edJFSznb
	 nTrcBZM4Vqj4kERQp3Th9UY7id7oVIwuUUBTYeKS8WdcRDowvxa+GWalm6PbDo2Diy
	 oR3JOS01L1a7BiX7g8oTwxsxd+8zvqOb3ch72LS/IJ+67nhwE7rQbxkuXgPdl/KO8s
	 YBwcrpMqB9/2A==
Date: Thu, 22 Jan 2026 13:27:00 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>, t@magnolia.djwong.org
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 04/11] fsverity: start consolidating pagecache code
Message-ID: <20260122212700.GD5910@frogsfrogsfrogs>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-5-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75156-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 469B46DC30
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:22:00AM +0100, Christoph Hellwig wrote:
> ext4 and f2fs are largely using the same code to read a page full
> of Merkle tree blocks from the page cache, and the upcoming xfs
> fsverity support would add another copy.
> 
> Move the ext4 code to fs/verity/ and use it in f2fs as well.  For f2fs
> this removes the previous f2fs-specific error injection, but otherwise
> the behavior remains unchanged.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/ext4/verity.c         | 17 +----------------
>  fs/f2fs/verity.c         | 17 +----------------
>  fs/verity/pagecache.c    | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/fsverity.h |  3 +++
>  4 files changed, 43 insertions(+), 32 deletions(-)
>  create mode 100644 fs/verity/pagecache.c
> 
> diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> index 2ce4cf8a1e31..a071860ad36a 100644
> --- a/fs/ext4/verity.c
> +++ b/fs/ext4/verity.c
> @@ -361,23 +361,8 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
>  					       pgoff_t index,
>  					       unsigned long num_ra_pages)
>  {
> -	struct folio *folio;
> -
>  	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
> -
> -	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
> -	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
> -		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
> -
> -		if (!IS_ERR(folio))
> -			folio_put(folio);
> -		else if (num_ra_pages > 1)
> -			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
> -		folio = read_mapping_folio(inode->i_mapping, index, NULL);
> -		if (IS_ERR(folio))
> -			return ERR_CAST(folio);
> -	}
> -	return folio_file_page(folio, index);
> +	return generic_read_merkle_tree_page(inode, index, num_ra_pages);
>  }
>  
>  static int ext4_write_merkle_tree_block(struct file *file, const void *buf,
> diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
> index c1c4d8044681..d37e584423af 100644
> --- a/fs/f2fs/verity.c
> +++ b/fs/f2fs/verity.c
> @@ -259,23 +259,8 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
>  					       pgoff_t index,
>  					       unsigned long num_ra_pages)
>  {
> -	struct folio *folio;
> -
>  	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
> -
> -	folio = f2fs_filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
> -	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
> -		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
> -
> -		if (!IS_ERR(folio))
> -			folio_put(folio);
> -		else if (num_ra_pages > 1)
> -			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
> -		folio = read_mapping_folio(inode->i_mapping, index, NULL);
> -		if (IS_ERR(folio))
> -			return ERR_CAST(folio);
> -	}
> -	return folio_file_page(folio, index);
> +	return generic_read_merkle_tree_page(inode, index, num_ra_pages);
>  }
>  
>  static int f2fs_write_merkle_tree_block(struct file *file, const void *buf,
> diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
> new file mode 100644
> index 000000000000..1efcdde20b73
> --- /dev/null
> +++ b/fs/verity/pagecache.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 Google LLC
> + */
> +
> +#include <linux/fsverity.h>
> +#include <linux/pagemap.h>
> +
> +/**
> + * generic_read_merkle_tree_page - generic ->read_merkle_tree_page helper
> + * @inode:	inode containing the Merkle tree
> + * @index:	0-based index of the page in the inode
> + * @num_ra_pages: The number of Merkle tree pages that should be prefetched.
> + *
> + * The caller needs to adjust @index from the Merkle-tree relative index passed
> + * to ->read_merkle_tree_page to the actual index where the Merkle tree is
> + * stored in the page cache for @inode.
> + */
> +struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
> +		unsigned long num_ra_pages)
> +{
> +	struct folio *folio;
> +
> +	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);

Nice hoist, though I wonder -- as an exported fs function, should we be
checking that the returned folio doesn't cover EOF?  Not that any of the
users actually check that returned merkle tree folios fit that
criterion.

<shrug> as a pure hoist this is ok so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
> +		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
> +
> +		if (!IS_ERR(folio))
> +			folio_put(folio);
> +		else if (num_ra_pages > 1)
> +			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
> +		folio = read_mapping_folio(inode->i_mapping, index, NULL);
> +		if (IS_ERR(folio))
> +			return ERR_CAST(folio);
> +	}
> +	return folio_file_page(folio, index);
> +}
> +EXPORT_SYMBOL_GPL(generic_read_merkle_tree_page);
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index e22cf84fe83a..121703625cc8 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -309,4 +309,7 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
>  
>  void fsverity_cleanup_inode(struct inode *inode);
>  
> +struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
> +		unsigned long num_ra_pages);
> +
>  #endif	/* _LINUX_FSVERITY_H */
> -- 
> 2.47.3
> 
> 

