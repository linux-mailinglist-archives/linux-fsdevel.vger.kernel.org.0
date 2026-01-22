Return-Path: <linux-fsdevel+bounces-75005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOojFEz5cWmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:17:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC6865210
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76F437221B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2F334A3DC;
	Thu, 22 Jan 2026 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gmzM6HE/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6Oxx+RhE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gmzM6HE/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6Oxx+RhE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9E3ACA62
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076789; cv=none; b=uq9geVD4TRTpwr4+t+Hd/bw2N8tbJxLPxaQPERt1zzq4qaUPWQoZYYDOwNQYpn4MhqEYtHAhLn/OaVbh6S+Dd5MBJG7nCN5TZlpIwjXTxtg2zZtkAYil1Y9cgjtB7Ag1JoLo+urNSn0Zt4ehpzz4mGeALvXqYXBbRnocJ1fSjNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076789; c=relaxed/simple;
	bh=8BZS5DIGZfVT3Ds49beDWcwLzrxDOxYiLfZsOwhNHeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KA0bUYSGUHlkcfM4ZOt3z9hqU/KL2tma2GIyNPi3tJ+K0YoE+CD/6T+3c067oxaPgp8NGJHcOanubwQlzPgwBvO8UyiJOjqPZRo7E/7X/hjuQN2NR+Mb6DHzaD0w1uxMjk5yEzxJ87ZJEiwxGzZS+CdeidYf0wz0U11t8l02sSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gmzM6HE/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6Oxx+RhE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gmzM6HE/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6Oxx+RhE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D823F5BCD9;
	Thu, 22 Jan 2026 10:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769076784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3LEHVFVQ4TZGfzpQpk/WGviASPctZdrW85QejcVxrSw=;
	b=gmzM6HE/o+jNbctQ150+xXP4oZYhWeWVpjPuukug8In4tIRjnMGugUr2h0x6NoogXOF/cb
	0LPwQve8A3nYHHUh7KM42p1MQBq/02nBQj2KJtEnta9CntwpCm+ken4TiqtiGPLIk3ZDlo
	zbeaM8AoAuR0DpF1rfvGzOEvhJZeejY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769076784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3LEHVFVQ4TZGfzpQpk/WGviASPctZdrW85QejcVxrSw=;
	b=6Oxx+RhEzg5qUYh8tGYwkuK6bIsOMN3GzAexoHFWi/xij+RhnmeDCJDw6aXudBuJ3Brg0B
	gDtSAPGpXvp58ZAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769076784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3LEHVFVQ4TZGfzpQpk/WGviASPctZdrW85QejcVxrSw=;
	b=gmzM6HE/o+jNbctQ150+xXP4oZYhWeWVpjPuukug8In4tIRjnMGugUr2h0x6NoogXOF/cb
	0LPwQve8A3nYHHUh7KM42p1MQBq/02nBQj2KJtEnta9CntwpCm+ken4TiqtiGPLIk3ZDlo
	zbeaM8AoAuR0DpF1rfvGzOEvhJZeejY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769076784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3LEHVFVQ4TZGfzpQpk/WGviASPctZdrW85QejcVxrSw=;
	b=6Oxx+RhEzg5qUYh8tGYwkuK6bIsOMN3GzAexoHFWi/xij+RhnmeDCJDw6aXudBuJ3Brg0B
	gDtSAPGpXvp58ZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFC7213978;
	Thu, 22 Jan 2026 10:13:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m9TMLjD4cWkMKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Jan 2026 10:13:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 37A1CA0B2E; Thu, 22 Jan 2026 10:18:03 +0100 (CET)
Date: Thu, 22 Jan 2026 10:18:03 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 04/11] fsverity: start consolidating pagecache code
Message-ID: <qcctljyfbkrfqxgwn3crbxq3k5n3qjkx447uh5vppdlhl4nyyy@ykllbscqtwxs>
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
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.cz:email,suse.cz:dkim,suse.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-75005-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BAC6865210
X-Rspamd-Action: no action

On Thu 22-01-26 09:22:00, Christoph Hellwig wrote:
> ext4 and f2fs are largely using the same code to read a page full
> of Merkle tree blocks from the page cache, and the upcoming xfs
> fsverity support would add another copy.
> 
> Move the ext4 code to fs/verity/ and use it in f2fs as well.  For f2fs
> this removes the previous f2fs-specific error injection, but otherwise
> the behavior remains unchanged.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

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
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

