Return-Path: <linux-fsdevel+bounces-19371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805F48C422E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 15:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D75B2260B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 13:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137F9153581;
	Mon, 13 May 2024 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rrfKb7mY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YncoePQ/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rrfKb7mY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YncoePQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E71534EE;
	Mon, 13 May 2024 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607697; cv=none; b=W+xVWTeRnqpj0JmrkI/GqEjKFj1rqJ4ANphDZ+tZRWmvK/V5dWJDQAC+XQ2E58Ug3j6Ojm5CiI96Oo00PJ8zabk0aeRw+KHFroqQ8wT155jIHwq/S4jTL04kXknO1ev7AeOd4rGdZChaZvaOLavjQtGcsB9uPF+glFUaLUSTIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607697; c=relaxed/simple;
	bh=pvbccIDrJ/qt8bECpJu+QcSi9YHWSa4jeVHsdHe/d70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MckIxcP25C4NUUZhwTamrMuDc+HeDG5VcCaAWUdrkCoslp+VKr8UqwSRGdWis/K6I0cNka5qHV6MoAxuvW1JqMNZSDjJ5CdzEaMgtNQn8lq41ma5cgt+12YIBEUzLgbiTbR7bgt7zVhKgWYkZ49C9E6Y3gnpAIZTGnmTuzfQ3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rrfKb7mY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YncoePQ/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rrfKb7mY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YncoePQ/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26E8E5C0CB;
	Mon, 13 May 2024 13:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJPA7Ye27jAilXXvSKl033d5uNnOadT/aOkncjcjcGU=;
	b=rrfKb7mYXpUuYGwYH0CmNquyPJLrRrOSPD5HjHJJuY64rU0FZoYyYYxVtRaeUdbDFQ4Peb
	Ik6W41176KvO3c8hlI2ahkke6ge6FbTPJ6q0A1SgYK8SjP7Z5uAGeAU9PHxpS4uyv9T9B4
	6yBt7++vBS4DxAP/fGx/U39Q3yn9cXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJPA7Ye27jAilXXvSKl033d5uNnOadT/aOkncjcjcGU=;
	b=YncoePQ/RccA3QF0eBYNSBu5oochiM/x6b7Ip96qI87SwoUdUojxHBYi6HloR06ZYEAKyu
	McS7VwqNJgDEm7AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rrfKb7mY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="YncoePQ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJPA7Ye27jAilXXvSKl033d5uNnOadT/aOkncjcjcGU=;
	b=rrfKb7mYXpUuYGwYH0CmNquyPJLrRrOSPD5HjHJJuY64rU0FZoYyYYxVtRaeUdbDFQ4Peb
	Ik6W41176KvO3c8hlI2ahkke6ge6FbTPJ6q0A1SgYK8SjP7Z5uAGeAU9PHxpS4uyv9T9B4
	6yBt7++vBS4DxAP/fGx/U39Q3yn9cXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJPA7Ye27jAilXXvSKl033d5uNnOadT/aOkncjcjcGU=;
	b=YncoePQ/RccA3QF0eBYNSBu5oochiM/x6b7Ip96qI87SwoUdUojxHBYi6HloR06ZYEAKyu
	McS7VwqNJgDEm7AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1BF013A5C;
	Mon, 13 May 2024 13:41:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RXWxNocYQmb/DgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 May 2024 13:41:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5C8B4A08FE; Sun, 12 May 2024 15:20:03 +0200 (CEST)
Date: Sun, 12 May 2024 15:20:03 +0200
From: Jan Kara <jack@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 4/7] ext2: Implement seq counter for validating cached
 iomap
Message-ID: <20240512132003.b6o4ghqk5yjsvkpy@quack3>
References: <cover.1714046808.git.ritesh.list@gmail.com>
 <009d08646b77e0d774b4ce248675b86564bca9ee.1714046808.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009d08646b77e0d774b4ce248675b86564bca9ee.1714046808.git.ritesh.list@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[24];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 26E8E5C0CB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.51

On Thu 25-04-24 18:58:48, Ritesh Harjani (IBM) wrote:
> There is a possibility of following race with iomap during
> writebck -
> 
> write_cache_pages()
>   cache extent covering 0..1MB range
>   write page at offset 0k
> 					truncate(file, 4k)
> 					  drops all relevant pages
> 					  frees fs blocks
> 					pwrite(file, 4k, 4k)
> 					  creates dirty page in the page cache
>   writes page at offset 4k to a stale block
> 
> This race can happen because iomap_writepages() keeps a cached extent mapping
> within struct iomap. While write_cache_pages() is going over each folio,
> (can cache a large extent range), if a truncate happens in parallel on the
> next folio followed by a buffered write to the same offset within the file,
> this can change logical to physical offset of the cached iomap mapping.
> That means, the cached iomap has now become stale.
> 
> This patch implements the seq counter approach for revalidation of stale
> iomap mappings. i_blkseq will get incremented for every block
> allocation/free. Here is what we do -
> 
> For ext2 buffered-writes, the block allocation happens at the
> ->write_iter time itself. So at writeback time,
> 1. We first cache the i_blkseq.
> 2. Call ext2_get_blocks(, create = 0) to get the no. of blocks
>    already allocated.
> 3. Call ext2_get_blocks() the second time with length to be same as
>    the no. of blocks we know were already allocated.
> 4. Till now it means, the cached i_blkseq remains valid as no block
>    allocation has happened yet.
> This means the next call to ->map_blocks(), we can verify whether the
> i_blkseq has raced with truncate or not. If not, then i_blkseq will
> remain valid.
> 
> In case of a hole (could happen with mmaped writes), we only allocate
> 1 block at a time anyways. So even if the i_blkseq value changes right
> after, we anyway need to allocate the next block in subsequent
> ->map_blocks() call.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

A few small comments below.

> @@ -698,6 +699,11 @@ static inline struct ext2_inode_info *EXT2_I(struct inode *inode)
>  	return container_of(inode, struct ext2_inode_info, vfs_inode);
>  }
>  
> +static inline void ext2_inc_i_blkseq(struct ext2_inode_info *ei)
> +{
> +	WRITE_ONCE(ei->i_blkseq, READ_ONCE(ei->i_blkseq) + 1);
> +}
> +

Please add a comment here (and assertion as well) that updates of i_blkseq
are protected by ei->i_truncate_mutex. Reads can race at any moment to
that's the reason why WRITE_ONCE() is used. You can remove READ_ONCE() here
as it is pointless (we are locked here).

>  static int ext2_write_map_blocks(struct iomap_writepage_ctx *wpc,
>  				 struct inode *inode, loff_t offset,
>  				 unsigned len)
>  {
> -	if (offset >= wpc->iomap.offset &&
> -	    offset < wpc->iomap.offset + wpc->iomap.length)
> +	loff_t maxblocks = (loff_t)INT_MAX;
> +	u8 blkbits = inode->i_blkbits;
> +	u32 bno;
> +	bool new, boundary;
> +	int ret;
> +
> +	if (ext2_imap_valid(wpc, inode, offset))
>  		return 0;
>  
> -	return ext2_iomap_begin(inode, offset, inode->i_sb->s_blocksize,
> +	/*
> +	 * For ext2 buffered-writes, the block allocation happens at the
> +	 * ->write_iter time itself. So at writeback time -
> +	 * 1. We first cache the i_blkseq.
> +	 * 2. Call ext2_get_blocks(, create = 0) to get the no. of blocks
> +	 *    already allocated.
> +	 * 3. Call ext2_get_blocks() the second time with length to be same as
> +	 *    the no. of blocks we know were already allocated.
> +	 * 4. Till now it means, the cached i_blkseq remains valid as no block
> +	 *    allocation has happened yet.
> +	 * This means the next call to ->map_blocks(), we can verify whether the
> +	 * i_blkseq has raced with truncate or not. If not, then i_blkseq will
> +	 * remain valid.
> +	 *
> +	 * In case of a hole (could happen with mmaped writes), we only allocate
> +	 * 1 block at a time anyways. So even if the i_blkseq value changes, we
> +	 * anyway need to allocate the next block in subsequent ->map_blocks()
> +	 * call.
> +	 */

I suspect it would be tidier to move this logic into ext2_get_blocks()
itself but I guess it is ok as is for now.

> +	wpc->iomap.validity_cookie = READ_ONCE(EXT2_I(inode)->i_blkseq);
> +
> +	ret = ext2_get_blocks(inode, offset >> blkbits, maxblocks << blkbits,
> +			      &bno, &new, &boundary, 0);
> +	if (ret < 0)
> +		return ret;
> +	/*
> +	 * ret can be 0 in case of a hole which is possible for mmaped writes.
> +	 */
> +	ret = ret ? ret : 1;
> +	return ext2_iomap_begin(inode, offset, (loff_t)ret << blkbits,
>  				IOMAP_WRITE, &wpc->iomap, NULL);
>  }
>  
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 37f7ce56adce..32f5386284d6 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -188,7 +188,7 @@ static struct inode *ext2_alloc_inode(struct super_block *sb)
>  #ifdef CONFIG_QUOTA
>  	memset(&ei->i_dquot, 0, sizeof(ei->i_dquot));
>  #endif
> -
> +	WRITE_ONCE(ei->i_blkseq, 0);
>  	return &ei->vfs_inode;

No need for write once here. This cannot race with anything...

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

