Return-Path: <linux-fsdevel+bounces-37497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7689F33EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 16:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115511881AD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C33F13B2A5;
	Mon, 16 Dec 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BISjqZrB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m2zLvD0N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f/BJ+eh7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iT5FSrl9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD5A7711F;
	Mon, 16 Dec 2024 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361355; cv=none; b=MdTfxNaADMvAYuRyvbHxRSKrbaxHoDie/XpzSR8Qv66aQsyYhjOdoK+cCy5QUWX0r7b9redKFaJqkvdQmewaNQsnK+O7VHhHWTlO0taagqULLnLfG2JrTXZpGb345zC3rtSSZrI68Vlc/Ee1PzqY86A//iOmn3ZlfKk7Zkrm/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361355; c=relaxed/simple;
	bh=etoOsWuUwMRRedEuUflxveiOildB/vpfPxxZqYAI3k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCESZCvlTAwyyfv3ZfvxFCHNYSAfFmGuOppd6szGFnfxLNBDwIDROtT9xY9c8YAgl+dcap0rd6flIR+UbICz2+gdwhcyCY0yUnsHOwZ+TwYZU//cFzCvnOFVuT0uU687etYdYUFuDKcwg2xt/qT218ElBNrASWRcNAQfH2KGHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BISjqZrB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m2zLvD0N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f/BJ+eh7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iT5FSrl9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 84ED921108;
	Mon, 16 Dec 2024 15:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734361351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NNIwNqNlsl5x4xTMRVJWVXFK+XKwtRHmG64fThrWLX4=;
	b=BISjqZrBaLb1ZbRxJcWgKbZTzVt6E5bSzTKVZ+4uDl6s69x1Z+PRpUstbYcwtrxOnzyez0
	lcRPChnjalTOBtXZt14WeDvH1O5zhqo1bYI7yqj0AQnNRsEpYJGbN8R1othJt/CgsEApGt
	/F9Ffr/FSrt/sSZ7qgBWx/GPGNA2/z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734361351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NNIwNqNlsl5x4xTMRVJWVXFK+XKwtRHmG64fThrWLX4=;
	b=m2zLvD0NqjQipmAjUNoNhFnRzSR6YaWtI9SC43pKdZW+DAIdZNzjx8Lvap6k7YRnSlOGtk
	HJFu0BLVcppQYDBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="f/BJ+eh7";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iT5FSrl9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734361350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NNIwNqNlsl5x4xTMRVJWVXFK+XKwtRHmG64fThrWLX4=;
	b=f/BJ+eh7hsUEjTV74fMS2QU6oMCgYHIzq0/pOztlHnjxurM6nmFgZzCzC4E+M0/GLrRAf8
	het4P988udvb7eLnkQHGfmhwsdLoAh9PmTf5ZjYrVYg1o8apj3hH0WAfO/G+ATdu3upW4l
	+cfLwoG1LKvzOhTnFkthx0nX5Q3z/kY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734361350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NNIwNqNlsl5x4xTMRVJWVXFK+XKwtRHmG64fThrWLX4=;
	b=iT5FSrl9gGpi/ejnP0LRe+VKx4DPalGchUOM+69HOyb/tgv3nmzmb1MDxTUcKqVVl7Sjg7
	cGaFyqp3ek8S+ZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74977137CF;
	Mon, 16 Dec 2024 15:02:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rVpzHAZBYGdLeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Dec 2024 15:02:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 18CB5A0935; Mon, 16 Dec 2024 16:02:22 +0100 (CET)
Date: Mon, 16 Dec 2024 16:02:22 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 03/10] ext4: don't write back data before punch hole
 in nojournal mode
Message-ID: <20241216150222.vrpdnm7ls4bretxl@quack3>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216013915.3392419-4-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 84ED921108
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Mon 16-12-24 09:39:08, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> There is no need to write back all data before punching a hole in
> non-journaled mode since it will be dropped soon after removing space.
> Therefore, the call to filemap_write_and_wait_range() can be eliminated.
> Besides, similar to ext4_zero_range(), we must address the case of
> partially punched folios when block size < page size. It is essential to
> remove writable userspace mappings to ensure that the folio can be
> faulted again during subsequent mmap write access.
> 
> In journaled mode, we need to write dirty pages out before discarding
> page cache in case of crash before committing the freeing data
> transaction, which could expose old, stale data, even if synchronization
> has been performed.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bf735d06b621..a5ba2b71d508 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4018,17 +4018,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	trace_ext4_punch_hole(inode, offset, length, 0);
>  
> -	/*
> -	 * Write out all dirty pages to avoid race conditions
> -	 * Then release them.
> -	 */
> -	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
> -		ret = filemap_write_and_wait_range(mapping, offset,
> -						   offset + length - 1);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	inode_lock(inode);
>  
>  	/* No need to punch hole beyond i_size */
> @@ -4090,8 +4079,11 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  		ret = ext4_update_disksize_before_punch(inode, offset, length);
>  		if (ret)
>  			goto out_dio;
> -		truncate_pagecache_range(inode, first_block_offset,
> -					 last_block_offset);
> +
> +		ret = ext4_truncate_page_cache_block_range(inode,
> +				first_block_offset, last_block_offset + 1);
> +		if (ret)
> +			goto out_dio;
>  	}
>  
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

