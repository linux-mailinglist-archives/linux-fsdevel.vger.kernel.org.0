Return-Path: <linux-fsdevel+bounces-36412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2B09E388B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A591620A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED01E1B3937;
	Wed,  4 Dec 2024 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CTMM6/QK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="amgJTwtc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CTMM6/QK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="amgJTwtc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70C16F851;
	Wed,  4 Dec 2024 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310795; cv=none; b=r44dlspSlSXAF93WBZ/XFT3wKzVvLy7k/F0rXsu6T7BMT9g3MzLD/2nO+k+uNd2ALwP9TGKBgHfpd1VAUy4/HAI9A8nLwgAWP2fyw6mITspt8LnkorNHWWLyzxxXrA5NgOLVu7mD+h73J/VIUrHFyf9ouLAjAX1T0X1WgVy14ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310795; c=relaxed/simple;
	bh=+GRYcnu/t+0hUfDEaNsZWR+kkdzkh7NvHPhh06IT/Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7WvUDXQBjeZUEggWyHdd/BQXv2XVTbenWIEuDh0LP3vRu6y486B2F8ROXsMEt9gG1WkUYVkrWkOjJmiNombkegv7qGRmjL6vKHu5OB7tpPHdsmOSD4S1T8JTQ27rTWMmLP2H5p7PfcXg5MVojI0AinWfaSzgQrCPXlWuEQ//j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CTMM6/QK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=amgJTwtc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CTMM6/QK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=amgJTwtc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51737210FE;
	Wed,  4 Dec 2024 11:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733310791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KN5n+Ws60RcZ9WKykYQo4KhL9bCCfMxAQl+yyCqg+Xg=;
	b=CTMM6/QKUZP/Nj6PHt+ZCLZwwRX0GerTLF2hCLEMJ9HYfuU846j8OwVjoESmIousGpgjp2
	s5r0RXZBGnhJSeUi44HXNh53JVJ+WL8VcgVGb4SUQbXWeqDDWu7rvHlPtfONq2waFJBLQf
	lm4G1/KEFU8aSvmEJhZhHh2EgBwf7ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733310791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KN5n+Ws60RcZ9WKykYQo4KhL9bCCfMxAQl+yyCqg+Xg=;
	b=amgJTwtcVfwfopX5zCOL/J7J6vzmYQFbAUPhnx36cqh/6Kh8ExcWIQO4k1CyRW8M1FIOpr
	2IIoTzktnRMLAtDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="CTMM6/QK";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=amgJTwtc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733310791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KN5n+Ws60RcZ9WKykYQo4KhL9bCCfMxAQl+yyCqg+Xg=;
	b=CTMM6/QKUZP/Nj6PHt+ZCLZwwRX0GerTLF2hCLEMJ9HYfuU846j8OwVjoESmIousGpgjp2
	s5r0RXZBGnhJSeUi44HXNh53JVJ+WL8VcgVGb4SUQbXWeqDDWu7rvHlPtfONq2waFJBLQf
	lm4G1/KEFU8aSvmEJhZhHh2EgBwf7ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733310791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KN5n+Ws60RcZ9WKykYQo4KhL9bCCfMxAQl+yyCqg+Xg=;
	b=amgJTwtcVfwfopX5zCOL/J7J6vzmYQFbAUPhnx36cqh/6Kh8ExcWIQO4k1CyRW8M1FIOpr
	2IIoTzktnRMLAtDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 453D31396E;
	Wed,  4 Dec 2024 11:13:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZRflEEc5UGfGDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 11:13:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EE790A0918; Wed,  4 Dec 2024 12:13:10 +0100 (CET)
Date: Wed, 4 Dec 2024 12:13:10 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 01/27] ext4: remove writable userspace mappings before
 truncating page cache
Message-ID: <20241204111310.3yzbaozrijll4qx5@quack3>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022111059.2566137-2-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 51737210FE
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,fromorbit.com,google.com,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huawei.com:email,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

I'm sorry for the huge delay here...

On Tue 22-10-24 19:10:32, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When zeroing a range of folios on the filesystem which block size is
> less than the page size, the file's mapped partial blocks within one
> page will be marked as unwritten, we should remove writable userspace
> mappings to ensure that ext4_page_mkwrite() can be called during
> subsequent write access to these folios. Otherwise, data written by
> subsequent mmap writes may not be saved to disk.
> 
>  $mkfs.ext4 -b 1024 /dev/vdb
>  $mount /dev/vdb /mnt
>  $xfs_io -t -f -c "pwrite -S 0x58 0 4096" -c "mmap -rw 0 4096" \
>                -c "mwrite -S 0x5a 2048 2048" -c "fzero 2048 2048" \
>                -c "mwrite -S 0x59 2048 2048" -c "close" /mnt/foo
> 
>  $od -Ax -t x1z /mnt/foo
>  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>  *
>  000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
>  *
>  001000
> 
>  $umount /mnt && mount /dev/vdb /mnt
>  $od -Ax -t x1z /mnt/foo
>  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>  *
>  000800 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  *
>  001000
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

This is a great catch! I think this may be source of the sporadic data
corruption issues we observe with blocksize < pagesize.

> +static inline void ext4_truncate_folio(struct inode *inode,
> +				       loff_t start, loff_t end)
> +{
> +	unsigned long blocksize = i_blocksize(inode);
> +	struct folio *folio;
> +
> +	if (round_up(start, blocksize) >= round_down(end, blocksize))
> +		return;
> +
> +	folio = filemap_lock_folio(inode->i_mapping, start >> PAGE_SHIFT);
> +	if (IS_ERR(folio))
> +		return;
> +
> +	if (folio_mkclean(folio))
> +		folio_mark_dirty(folio);
> +	folio_unlock(folio);
> +	folio_put(folio);

I don't think this is enough. In your example from the changelog, this would
leave the page at index 0 dirty and still with 0x5a values in 2048-4096 range.
Then truncate_pagecache_range() does nothing, ext4_alloc_file_blocks()
converts blocks under 2048-4096 to unwritten state. But what handles
zeroing of page cache in 2048-4096 range? ext4_zero_partial_blocks() zeroes
only partial blocks, not full blocks. Am I missing something?

If I'm right, I'd keep it simple and just writeout these partial folios with
filemap_write_and_wait_range() and expand the range
truncate_pagecache_range() removes to include these partial folios. The
overhead won't be big and it isn't like this is some very performance
sensitive path.

> +}
> +
> +/*
> + * When truncating a range of folios, if the block size is less than the
> + * page size, the file's mapped partial blocks within one page could be
> + * freed or converted to unwritten. We should call this function to remove
> + * writable userspace mappings so that ext4_page_mkwrite() can be called
> + * during subsequent write access to these folios.
> + */
> +void ext4_truncate_folios_range(struct inode *inode, loff_t start, loff_t end)

Maybe call this ext4_truncate_page_cache_block_range()? And assert that
start & end are block aligned. Because this essentially prepares page cache
for manipulation with a block range.

> +{
> +	unsigned long blocksize = i_blocksize(inode);
> +
> +	if (end > inode->i_size)
> +		end = inode->i_size;
> +	if (start >= end || blocksize >= PAGE_SIZE)
> +		return;
> +
> +	ext4_truncate_folio(inode, start, min(round_up(start, PAGE_SIZE), end));
> +	if (end > round_up(start, PAGE_SIZE))
> +		ext4_truncate_folio(inode, round_down(end, PAGE_SIZE), end);
> +}

So I'd move the following truncate_pagecache_range() into
ext4_truncate_folios_range(). And also the preceding:

                /*
                 * For journalled data we need to write (and checkpoint) pages
                 * before discarding page cache to avoid inconsitent data on
                 * disk in case of crash before zeroing trans is committed.
                 */
                if (ext4_should_journal_data(inode)) {
                        ret = filemap_write_and_wait_range(mapping, start,
                                                           end - 1);
		...

into this function. So that it can be self-contained "do the right thing
with page cache to prepare for block range manipulations".

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

