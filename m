Return-Path: <linux-fsdevel+bounces-27947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18068964EA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 21:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C464D28478C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E06D1B9B40;
	Thu, 29 Aug 2024 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qA8QGZv2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ueoTqUv5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uo5mXcF6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tZp+Zomu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F77D1B8E9B;
	Thu, 29 Aug 2024 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959075; cv=none; b=X+HodJbfts1zkGqvWqEBSxnylx+FvZ2QNqVfgkmMIBEsFqDzNj4S6oEnhPxdbdzinYmmmFAo/+0fwGlhkLMGw5JT+tyAQ5URdZdVf2Gy6nLk3xNNbLP8r9Yvv19Y0lEzNcPkY+Fdh8bkh5rbz+B1wJObrd/BDO4FgFD56bv9CBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959075; c=relaxed/simple;
	bh=C2N5Y/tQjmC08EHo/jUR42zriwZDcNX9AkzwHS5Ad1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PweJA7NYFicrYvq/T7Zwg30JENoyPKMn1sEwJEFKUSRqfFmoIoOqPbJGWA1rp4f9+IEKM93FCLjL8Ct4es2b4y1pRoiuiIReeMUG+Y6670vLDcLLc6Og7OPanNDqb2Xen+iM8qLBBV7G7STNKfhxIHgRfcIkk5Rh6SLUKT74jRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qA8QGZv2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ueoTqUv5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uo5mXcF6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tZp+Zomu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA30B1F46E;
	Thu, 29 Aug 2024 19:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724959071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QszGUirkdONpguALrhY6gCWl9AUvvnneMrANgOv1yss=;
	b=qA8QGZv2ffmeQjFVUEtfyYMZbo8FILjAbnRU+aK7Z+HlObBUe7HEKiFJVQ4M4f8b6MxumR
	RvmBlPxYzL9HsHKaGR1u1OBnLsYqu4jTWYialApUETKIXa6n0lZwLOwJNqYDpa0DU0iLKQ
	5GfAT5Xybgj5LZM/Jhid1BFrMCqyRt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724959071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QszGUirkdONpguALrhY6gCWl9AUvvnneMrANgOv1yss=;
	b=ueoTqUv5YD30xR71lJ2uzeT7CCmZ3Yi+sFFnbnPBX1pUR/E9m5kjYTC4KM88chA5QKN8yO
	G3AXePTmWTLMX5BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Uo5mXcF6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tZp+Zomu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724959070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QszGUirkdONpguALrhY6gCWl9AUvvnneMrANgOv1yss=;
	b=Uo5mXcF6/scu6v4NpKWYk/4ivo4CVAYMhYVcu2Ixdp1icdiGt5ioIlcpdLesJBbFykfjLo
	pKiaZIifbbulWt8jXczgoSBAvFmZ9n0zqcC14MH7kAsURdElPEmiJ92o2saXibRBGwWNKz
	+3+v713XJ7Houi8G5jNSH/eSoXc8tqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724959070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QszGUirkdONpguALrhY6gCWl9AUvvnneMrANgOv1yss=;
	b=tZp+ZomuFEEUKIXNdyVVKVcadPFZVkwd2W2e4yqoghnarkTAl5KweECuhWok1DCeftT/iB
	URMmXyj2bArROaBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAB82139B0;
	Thu, 29 Aug 2024 19:17:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kYUaNV7J0GZvKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 19:17:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6F075A096C; Thu, 29 Aug 2024 21:17:46 +0200 (CEST)
Date: Thu, 29 Aug 2024 21:17:46 +0200
From: Jan Kara <jack@suse.cz>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] fs: drop GFP_NOFAIL mode from alloc_page_buffers
Message-ID: <20240829191746.tsrojxj3kntt4jhp@quack3>
References: <20240829130640.1397970-1-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829130640.1397970-1-mhocko@kernel.org>
X-Rspamd-Queue-Id: EA30B1F46E
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 29-08-24 15:06:40, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> There is only one called of alloc_page_buffers and it doesn't require
> __GFP_NOFAIL so drop this allocation mode.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Although even better fix would be to convert the last remaining caller of
alloc_page_buffers() to folio_alloc_buffers()... But that may be more
difficult.

								Honza


> ---
>  drivers/md/md-bitmap.c      | 2 +-
>  fs/buffer.c                 | 5 +----
>  include/linux/buffer_head.h | 3 +--
>  3 files changed, 3 insertions(+), 7 deletions(-)
> 
> while looking at GFP_NOFAIL users I have encountered this left over.
> 
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 08232d8dc815..db5330d97348 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -360,7 +360,7 @@ static int read_file_page(struct file *file, unsigned long index,
>  	pr_debug("read bitmap file (%dB @ %llu)\n", (int)PAGE_SIZE,
>  		 (unsigned long long)index << PAGE_SHIFT);
>  
> -	bh = alloc_page_buffers(page, blocksize, false);
> +	bh = alloc_page_buffers(page, blocksize);
>  	if (!bh) {
>  		ret = -ENOMEM;
>  		goto out;
> diff --git a/fs/buffer.c b/fs/buffer.c
> index e55ad471c530..f1381686d325 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -958,12 +958,9 @@ struct buffer_head *folio_alloc_buffers(struct folio *folio, unsigned long size,
>  }
>  EXPORT_SYMBOL_GPL(folio_alloc_buffers);
>  
> -struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
> -				       bool retry)
> +struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size)
>  {
>  	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;
> -	if (retry)
> -		gfp |= __GFP_NOFAIL;
>  
>  	return folio_alloc_buffers(page_folio(page), size, gfp);
>  }
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 14acf1bbe0ce..7e903457967a 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -199,8 +199,7 @@ void folio_set_bh(struct buffer_head *bh, struct folio *folio,
>  		  unsigned long offset);
>  struct buffer_head *folio_alloc_buffers(struct folio *folio, unsigned long size,
>  					gfp_t gfp);
> -struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
> -		bool retry);
> +struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size);
>  struct buffer_head *create_empty_buffers(struct folio *folio,
>  		unsigned long blocksize, unsigned long b_state);
>  void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
> -- 
> 2.46.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

