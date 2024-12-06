Return-Path: <linux-fsdevel+bounces-36647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB99E74E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19381885C62
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187A220DD68;
	Fri,  6 Dec 2024 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pl2fd+k2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UbwZMOnW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pl2fd+k2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UbwZMOnW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D6E207DFD;
	Fri,  6 Dec 2024 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500183; cv=none; b=LoMZVJ0AznWFJgb9EkN+vvt7QZOOMKRLHXgld22/OaiOpnWtR0BdDU9mrlEGBM2oyR4xHKb8PyhcS/uxXrkY/Si3vw610o6xBKgG5QJGle0WOtHOXR0YtBdlyTVF/k9QbPiFb5uGQaSbG+YRwz2XvK9V8EvkOZf4o10KmAb2zEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500183; c=relaxed/simple;
	bh=nhir8vPoVjasB8UxwEnolQOEqtrjEb0PtSLMlDC0IqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIcQP8aUCPq/HgQ5/zhQjYUBczKwYYuVmVjwA0kbpNzg/lcQ8lbzsBeMeE14MROmSGBP3ZExHpH7oNeE69TGOdBBlEFP8z7RERfS3tDhn5RarwQPi3IMeJQzGq0lDwQ44q3QX40Nfld6lvXQIUUP3BzyouOQHRAAqYU3uKY0pr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pl2fd+k2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UbwZMOnW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pl2fd+k2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UbwZMOnW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6DDEA2115F;
	Fri,  6 Dec 2024 15:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733500179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Em9p/t7Cea5R3IVj/iloJ4eCcEajSafg53eL1G+TuA4=;
	b=Pl2fd+k2PdM9e/s6wVZ6JRuHIUOdwAH41f9qzSjAFBvWAT+frx/S8novwkE7795OQJ7SpE
	QBQLQFQOYNhGkyBDqPntPMQtRRVzlIYMv7LRV7CQu79LPiIVVgU0hKkWaF6x6+kJz+T0DT
	dWIVBiOJUCBQre7+Ykb5p7Dxpaq6Y8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733500179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Em9p/t7Cea5R3IVj/iloJ4eCcEajSafg53eL1G+TuA4=;
	b=UbwZMOnWYv6h/hTg+VqeSnAZhPJWzeWHxcxCodON7xKW5ksZAQ/52yc94mSZoW7VPTtDgE
	l43LFMc2wJSkyZBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733500179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Em9p/t7Cea5R3IVj/iloJ4eCcEajSafg53eL1G+TuA4=;
	b=Pl2fd+k2PdM9e/s6wVZ6JRuHIUOdwAH41f9qzSjAFBvWAT+frx/S8novwkE7795OQJ7SpE
	QBQLQFQOYNhGkyBDqPntPMQtRRVzlIYMv7LRV7CQu79LPiIVVgU0hKkWaF6x6+kJz+T0DT
	dWIVBiOJUCBQre7+Ykb5p7Dxpaq6Y8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733500179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Em9p/t7Cea5R3IVj/iloJ4eCcEajSafg53eL1G+TuA4=;
	b=UbwZMOnWYv6h/hTg+VqeSnAZhPJWzeWHxcxCodON7xKW5ksZAQ/52yc94mSZoW7VPTtDgE
	l43LFMc2wJSkyZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53AFC13647;
	Fri,  6 Dec 2024 15:49:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6D4cFBMdU2c/AgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Dec 2024 15:49:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E8AECA08CD; Fri,  6 Dec 2024 16:49:38 +0100 (CET)
Date: Fri, 6 Dec 2024 16:49:38 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 01/27] ext4: remove writable userspace mappings before
 truncating page cache
Message-ID: <20241206154938.xxosjc5ytbwwvxbp@quack3>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-2-yi.zhang@huaweicloud.com>
 <20241204111310.3yzbaozrijll4qx5@quack3>
 <d31e0298-edbc-4e2b-9acd-f1191409f149@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d31e0298-edbc-4e2b-9acd-f1191409f149@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,infradead.org,kernel.org,fromorbit.com,google.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Fri 06-12-24 15:59:44, Zhang Yi wrote:
> On 2024/12/4 19:13, Jan Kara wrote:
> > On Tue 22-10-24 19:10:32, Zhang Yi wrote:
> >> +static inline void ext4_truncate_folio(struct inode *inode,
> >> +				       loff_t start, loff_t end)
> >> +{
> >> +	unsigned long blocksize = i_blocksize(inode);
> >> +	struct folio *folio;
> >> +
> >> +	if (round_up(start, blocksize) >= round_down(end, blocksize))
> >> +		return;
> >> +
> >> +	folio = filemap_lock_folio(inode->i_mapping, start >> PAGE_SHIFT);
> >> +	if (IS_ERR(folio))
> >> +		return;
> >> +
> >> +	if (folio_mkclean(folio))
> >> +		folio_mark_dirty(folio);
> >> +	folio_unlock(folio);
> >> +	folio_put(folio);
> > 
> > I don't think this is enough. In your example from the changelog, this would
> > leave the page at index 0 dirty and still with 0x5a values in 2048-4096 range.
> > Then truncate_pagecache_range() does nothing, ext4_alloc_file_blocks()
> > converts blocks under 2048-4096 to unwritten state. But what handles
> > zeroing of page cache in 2048-4096 range? ext4_zero_partial_blocks() zeroes
> > only partial blocks, not full blocks. Am I missing something?
> > 
> 
> Sorry, I don't understand why truncate_pagecache_range() does nothing? In my
> example, the variable 'start' is 2048, the variable 'end' is 4096, and the
> call process truncate_pagecache_range(inode, 2048, 4096-1)->..->
> truncate_inode_partial_folio()->folio_zero_range() does zeroing the 2048-4096
> range. I also tested it below, it was zeroed.
> 
>   xfs_io -t -f -c "pwrite -S 0x58 0 4096" -c "mmap -rw 0 4096" \
>                -c "mwrite -S 0x5a 2048 2048" \
>                -c "fzero 2048 2048" -c "close" /mnt/foo
> 
>   od -Ax -t x1z /mnt/foo
>   000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
>   *
>   000800 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
>   *
>   001000

Yeah, sorry. I've got totally confused here. truncate_pagecache_range()
indeed does all the zeroing we need. Your version of ext4_truncate_folio()
should do the right thing.

> > If I'm right, I'd keep it simple and just writeout these partial folios with
> > filemap_write_and_wait_range() and expand the range
> > truncate_pagecache_range() removes to include these partial folios. The
> 
> What I mean is the truncate_pagecache_range() has already covered the partial
> folios. right?

Right, it should cover the partial folios.

> > overhead won't be big and it isn't like this is some very performance
> > sensitive path.
> > 
> >> +}
> >> +
> >> +/*
> >> + * When truncating a range of folios, if the block size is less than the
> >> + * page size, the file's mapped partial blocks within one page could be
> >> + * freed or converted to unwritten. We should call this function to remove
> >> + * writable userspace mappings so that ext4_page_mkwrite() can be called
> >> + * during subsequent write access to these folios.
> >> + */
> >> +void ext4_truncate_folios_range(struct inode *inode, loff_t start, loff_t end)
> > 
> > Maybe call this ext4_truncate_page_cache_block_range()? And assert that
> > start & end are block aligned. Because this essentially prepares page cache
> > for manipulation with a block range.
> 
> Ha, it's a good idea, I agree with you that move truncate_pagecache_range()
> and the hunk of flushing in journal data mode into this function. But I don't
> understand why assert that 'start & end' are block aligned?

Yes, that shouldn't be needed since truncate_pagecache_range() will do the
right thing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

