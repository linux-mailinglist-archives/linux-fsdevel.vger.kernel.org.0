Return-Path: <linux-fsdevel+bounces-54828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B33F5B03ADD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 11:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A0F3A5ADF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 09:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B67B23C518;
	Mon, 14 Jul 2025 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uDa8Kuzy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ckq19csk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rd/SVjei";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zZn5+2pG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6809229B16
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485590; cv=none; b=cFI91Lcbv7ERbk28vuSektdux0SRQownyWL+xxDiTTkKouRGXyP8QKKUNsox4xCMFPapZ7xpaCYPhhRrTc4oO4rYn1ueL3EvMCb4b72uOmgTHRfEDrYNxjbQvLotFYKQOgKTq+3rVnp4/B0jpv4yp8CyXPY5AxxfZ+Q6pgxxxfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485590; c=relaxed/simple;
	bh=jff1rg7cdA6FSA/2rKn4bJCh/qsPeyAuTnbAkwk2QcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7juYSPpMkJPRw902b3lJtH9mUZUxVyAy8HVGjNKen16BNzbgDLWiTnNsEbZIvVJ2zT9/A7WouXnvX/vyYrNKKvlh01ZWC58NWwPOGABWY5kOgG8Jz940dhnZxN80zG6lnnAHA/xoXsCH0jUbWfiaaatAEl9DTk6cpESBWHEujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uDa8Kuzy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ckq19csk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rd/SVjei; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zZn5+2pG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F086B1F387;
	Mon, 14 Jul 2025 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752485587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d58zeA97b6KomVEz3OwBjB6joIqhDEGdapyBAJdFDO4=;
	b=uDa8KuzyXgrwwsYs3OSF6xtgLSIqrr+CpRxVRJmSg8aXN+LS6rYy2XEP2/jglPn8nr8c9S
	xa5HrftK3ETtEbO/wNR5+VnDfMHF31H4VKQHhvD6LlHOZAg8QefiKDU3bZaA1IekNKcd2w
	pViZCxpxHrtrdga1dmXDa8YqKi5vngM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752485587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d58zeA97b6KomVEz3OwBjB6joIqhDEGdapyBAJdFDO4=;
	b=ckq19csk+VQFzjGjaKsdslmAZn8AZqV7OQb9hIaOpnVYjtyVEXZZC9F79AhN542pzvhhAp
	0Zae3GSxKMBEHbBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752485586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d58zeA97b6KomVEz3OwBjB6joIqhDEGdapyBAJdFDO4=;
	b=rd/SVjeiYRWfoGR0q7iBm66A1cHuGG83JLJ2Terf11aEOxj6aUs1IFWnOxIQ8MtWgUjsXm
	z0e86hBhGlS+mUFGKM1U8ESCvGFToIX86beJXzwx5+P7kSIzC6BB2N3NdFmPJ014G4+CQO
	O5t9VeL7sQJZ88TWZa+0FW6WbQXqOFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752485586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d58zeA97b6KomVEz3OwBjB6joIqhDEGdapyBAJdFDO4=;
	b=zZn5+2pGv98ETicUtJVq48eQ+um7+gutKTEDb23w1b9wiOLp3CAKECN8LOAdqzHm6Yr5Jm
	54HyA08jTaoST1Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E12DA138A1;
	Mon, 14 Jul 2025 09:33:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TPH0NtLOdGjIQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Jul 2025 09:33:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C12BA06F4; Mon, 14 Jul 2025 11:33:06 +0200 (CEST)
Date: Mon, 14 Jul 2025 11:33:06 +0200
From: Jan Kara <jack@suse.cz>
To: Youling Tang <youling.tang@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, chizhiling@163.com, 
	Youling Tang <tangyouling@kylinos.cn>, Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH] mm/filemap: Align last_index to folio size
Message-ID: <jk3sbqrkfmtvrzgant74jfm2n3yn6hzd7tefjhjys42yt2trnp@avx5stdnkfsc>
References: <20250711055509.91587-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711055509.91587-1-youling.tang@linux.dev>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,linux-foundation.org,suse.cz,vger.kernel.org,kvack.org,163.com,kylinos.cn];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Fri 11-07-25 13:55:09, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> On XFS systems with pagesize=4K, blocksize=16K, and CONFIG_TRANSPARENT_HUGEPAGE
> enabled, We observed the following readahead behaviors:
>  # echo 3 > /proc/sys/vm/drop_caches
>  # dd if=test of=/dev/null bs=64k count=1
>  # ./tools/mm/page-types -r -L -f  /mnt/xfs/test
>  foffset	offset	flags
>  0	136d4c	__RU_l_________H______t_________________F_1
>  1	136d4d	__RU_l__________T_____t_________________F_1
>  2	136d4e	__RU_l__________T_____t_________________F_1
>  3	136d4f	__RU_l__________T_____t_________________F_1
>  ...
>  c	136bb8	__RU_l_________H______t_________________F_1
>  d	136bb9	__RU_l__________T_____t_________________F_1
>  e	136bba	__RU_l__________T_____t_________________F_1
>  f	136bbb	__RU_l__________T_____t_________________F_1   <-- first read
>  10	13c2cc	___U_l_________H______t______________I__F_1   <-- readahead flag
>  11	13c2cd	___U_l__________T_____t______________I__F_1
>  12	13c2ce	___U_l__________T_____t______________I__F_1
>  13	13c2cf	___U_l__________T_____t______________I__F_1
>  ...
>  1c	1405d4	___U_l_________H______t_________________F_1
>  1d	1405d5	___U_l__________T_____t_________________F_1
>  1e	1405d6	___U_l__________T_____t_________________F_1
>  1f	1405d7	___U_l__________T_____t_________________F_1
>  [ra_size = 32, req_count = 16, async_size = 16]
> 
>  # echo 3 > /proc/sys/vm/drop_caches
>  # dd if=test of=/dev/null bs=60k count=1
>  # ./page-types -r -L -f  /mnt/xfs/test
>  foffset	offset	flags
>  0	136048	__RU_l_________H______t_________________F_1
>  ...
>  c	110a40	__RU_l_________H______t_________________F_1
>  d	110a41	__RU_l__________T_____t_________________F_1
>  e	110a42	__RU_l__________T_____t_________________F_1   <-- first read
>  f	110a43	__RU_l__________T_____t_________________F_1   <-- first readahead flag
>  10	13e7a8	___U_l_________H______t_________________F_1
>  ...
>  20	137a00	___U_l_________H______t_______P______I__F_1   <-- second readahead flag (20 - 2f)
>  21	137a01	___U_l__________T_____t_______P______I__F_1
>  ...
>  3f	10d4af	___U_l__________T_____t_______P_________F_1
>  [first readahead: ra_size = 32, req_count = 15, async_size = 17]
> 
> When reading 64k data (same for 61-63k range, where last_index is page-aligned
> in filemap_get_pages()), 128k readahead is triggered via page_cache_sync_ra()
> and the PG_readahead flag is set on the next folio (the one containing 0x10 page).
> 
> When reading 60k data, 128k readahead is also triggered via page_cache_sync_ra().
> However, in this case the readahead flag is set on the 0xf page. Although the
> requested read size (req_count) is 60k, the actual read will be aligned to
> folio size (64k), which triggers the readahead flag and initiates asynchronous
> readahead via page_cache_async_ra(). This results in two readahead operations
> totaling 256k.
> 
> The root cause is that when the requested size is smaller than the actual read
> size (due to folio alignment), it triggers asynchronous readahead. By changing
> last_index alignment from page size to folio size, we ensure the requested size
> matches the actual read size, preventing the case where a single read operation
> triggers two readahead operations.
> 
> After applying the patch:
>  # echo 3 > /proc/sys/vm/drop_caches
>  # dd if=test of=/dev/null bs=60k count=1
>  # ./page-types -r -L -f  /mnt/xfs/test
>  foffset	offset	flags
>  0	136d4c	__RU_l_________H______t_________________F_1
>  1	136d4d	__RU_l__________T_____t_________________F_1
>  2	136d4e	__RU_l__________T_____t_________________F_1
>  3	136d4f	__RU_l__________T_____t_________________F_1
>  ...
>  c	136bb8	__RU_l_________H______t_________________F_1
>  d	136bb9	__RU_l__________T_____t_________________F_1
>  e	136bba	__RU_l__________T_____t_________________F_1   <-- first read
>  f	136bbb	__RU_l__________T_____t_________________F_1
>  10	13c2cc	___U_l_________H______t______________I__F_1   <-- readahead flag
>  11	13c2cd	___U_l__________T_____t______________I__F_1
>  12	13c2ce	___U_l__________T_____t______________I__F_1
>  13	13c2cf	___U_l__________T_____t______________I__F_1
>  ...
>  1c	1405d4	___U_l_________H______t_________________F_1
>  1d	1405d5	___U_l__________T_____t_________________F_1
>  1e	1405d6	___U_l__________T_____t_________________F_1
>  1f	1405d7	___U_l__________T_____t_________________F_1
>  [ra_size = 32, req_count = 16, async_size = 16]
> 
> The same phenomenon will occur when reading from 49k to 64k. Set the readahead
> flag to the next folio.
> 
> Because the minimum order of folio in address_space equals the block size (at
> least in xfs and bcachefs that already support bs > ps), having request_count
> aligned to block size will not cause overread.
> 
> Co-developed-by: Chi Zhiling <chizhiling@kylinos.cn>
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>

I agree with analysis of the problem but not quite with the solution. See
below.

> diff --git a/mm/filemap.c b/mm/filemap.c
> index 765dc5ef6d5a..56a8656b6f86 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2584,8 +2584,9 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>  	unsigned int flags;
>  	int err = 0;
>  
> -	/* "last_index" is the index of the page beyond the end of the read */
> -	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
> +	/* "last_index" is the index of the folio beyond the end of the read */
> +	last_index = round_up(iocb->ki_pos + count, mapping_min_folio_nrbytes(mapping));
> +	last_index >>= PAGE_SHIFT;

I think that filemap_get_pages() shouldn't be really trying to guess what
readahead code needs and round last_index based on min folio order. After
all the situation isn't special for LBS filesystems. It can also happen
that the readahead mark ends up in the middle of large folio for other
reasons. In fact, we already do have code in page_cache_ra_order() ->
ra_alloc_folio() that handles rounding of index where mark should be placed
so your changes essentially try to outsmart that code which is not good. I
think the solution should really be placed in page_cache_ra_order() +
ra_alloc_folio() instead.

In fact the problem you are trying to solve was kind of introduced (or at
least made more visible) by my commit ab4443fe3ca62 ("readahead: avoid
multiple marked readahead pages"). There I've changed the code to round the
index down because I've convinced myself it doesn't matter and rounding
down is easier to handle in that place. But your example shows there are
cases where rounding down has weird consequences and rounding up would have
been better. So I think we need to come up with a method how to round up
the index of marked folio to fix your case without reintroducing problems
mentioned in commit ab4443fe3ca62.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

