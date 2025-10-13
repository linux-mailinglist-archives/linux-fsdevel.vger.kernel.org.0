Return-Path: <linux-fsdevel+bounces-63953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE205BD2E25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 14:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725D6189E116
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 12:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C63C26158C;
	Mon, 13 Oct 2025 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o3So9e0U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wqt8mG8b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o3So9e0U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wqt8mG8b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B3C19CCEC
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356825; cv=none; b=cGB+xe1uYnSTYQ8FYI5NLobK0qPCrwDvLjBJYXj+gtk4EPqRo7Gg4lPAAblG/AwRtdFcQeZ85vt47UluQ25Qile2tBQ8/f0UZ4XhvNfQbcecb8T+3aDOwCHPuGpWUyC8TOBpuQrzL5kTWbtRRr3MQMNvSEWt48akTcrIZ5caBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356825; c=relaxed/simple;
	bh=dh0bPw8OvQbBIvQVpO2Mbwvxlq3Odzz9Uh+NJSwM2PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNsWEeznez0AvH+ToVOdYTOTb5b9uIAx0AG/pKO407D628fW27IqYpJ22o+WPc0sqqWEd5reA8VvzWlKZDJmAnUjiTYaat/veq/CFdBj3KIOjPSEOwkRqC+vXOCnexSstOVsRW0pf7M2uOOrYIAZMzF4yHhJMIOilsEfkuKlNP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o3So9e0U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wqt8mG8b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o3So9e0U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wqt8mG8b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9FBC219BD;
	Mon, 13 Oct 2025 12:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760356821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4ozAoCHFVPL2RaeOvGtQnbmZ7SwKWEtlu18MyCihJ0=;
	b=o3So9e0Uth84O+PnIEh4Oun1iPQuZvVVPoCQHorbtKIwuu6mUgAwnbxgqugoKaZ+hKRSH5
	72mtDq2nhfqyGwMaACw7/a0TRsBTLgKar+wCPOoZVBdoRX1jz/WcNTz2KMAjy2i7nAYrXr
	po9DR7+9gbCBDVqbqs2APg8qOr6o1ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760356821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4ozAoCHFVPL2RaeOvGtQnbmZ7SwKWEtlu18MyCihJ0=;
	b=Wqt8mG8b+3z6+GM7rCsz8+6pGorvjFjHtNKSx6T1X04EmFMGoXIOJQZmbr/RpktbXZgXJY
	gv9d+SK1c1CvXfAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=o3So9e0U;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Wqt8mG8b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760356821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4ozAoCHFVPL2RaeOvGtQnbmZ7SwKWEtlu18MyCihJ0=;
	b=o3So9e0Uth84O+PnIEh4Oun1iPQuZvVVPoCQHorbtKIwuu6mUgAwnbxgqugoKaZ+hKRSH5
	72mtDq2nhfqyGwMaACw7/a0TRsBTLgKar+wCPOoZVBdoRX1jz/WcNTz2KMAjy2i7nAYrXr
	po9DR7+9gbCBDVqbqs2APg8qOr6o1ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760356821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4ozAoCHFVPL2RaeOvGtQnbmZ7SwKWEtlu18MyCihJ0=;
	b=Wqt8mG8b+3z6+GM7rCsz8+6pGorvjFjHtNKSx6T1X04EmFMGoXIOJQZmbr/RpktbXZgXJY
	gv9d+SK1c1CvXfAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A729C13874;
	Mon, 13 Oct 2025 12:00:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L1/OKNXp7Gj0AwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Oct 2025 12:00:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4C3FFA0A58; Mon, 13 Oct 2025 14:00:17 +0200 (CEST)
Date: Mon, 13 Oct 2025 14:00:17 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 08/10] mm: remove filemap_fdatawrite_wbc
Message-ID: <2iplfhsl7b6nsq7nf6fhre2udcqeujph6mfg22afssqhnvpdwd@pknnzyakfwxs>
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013025808.4111128-9-hch@lst.de>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B9FBC219BD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	R_RATELIMIT(0.00)[to_ip_from(RLs49k5m81mxp7q8diy8d4za6z)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Mon 13-10-25 11:58:03, Christoph Hellwig wrote:
> Replace filemap_fdatawrite_wbc, which exposes a writeback_control to the
> callers with a __filemap_fdatawrite helper that takes all the possible
> arguments and declares the writeback_control itself.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/pagemap.h |  2 --
>  mm/filemap.c            | 54 ++++++++++++++---------------------------
>  2 files changed, 18 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index fc060ce2d31d..742ba1dd3990 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -61,8 +61,6 @@ int filemap_fdatawrite_range(struct address_space *mapping,
>  		loff_t start, loff_t end);
>  int filemap_check_errors(struct address_space *mapping);
>  void __filemap_set_wb_err(struct address_space *mapping, int err);
> -int filemap_fdatawrite_wbc(struct address_space *mapping,
> -			   struct writeback_control *wbc);
>  int kiocb_write_and_wait(struct kiocb *iocb, size_t count);
>  
>  static inline int filemap_write_and_wait(struct address_space *mapping)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index bbd5d5eaa661..26b692dbf091 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -366,31 +366,30 @@ static int filemap_check_and_keep_errors(struct address_space *mapping)
>  	return 0;
>  }
>  
> -/**
> - * filemap_fdatawrite_wbc - start writeback on mapping dirty pages in range
> - * @mapping:	address space structure to write
> - * @wbc:	the writeback_control controlling the writeout
> - *
> - * Call writepages on the mapping using the provided wbc to control the
> - * writeout.
> - *
> - * Return: %0 on success, negative error code otherwise.
> - */
> -int filemap_fdatawrite_wbc(struct address_space *mapping,
> -			   struct writeback_control *wbc)
> +static int __filemap_fdatawrite(struct address_space *mapping, loff_t start,
> +		loff_t end, enum writeback_sync_modes sync_mode,
> +		long *nr_to_write)
>  {
> +	struct writeback_control wbc = {
> +		.sync_mode	= sync_mode,
> +		.nr_to_write	= nr_to_write ? *nr_to_write : LONG_MAX,
> +		.range_start	= start,
> +		.range_end	= end,
> +	};
>  	int ret;
>  
>  	if (!mapping_can_writeback(mapping) ||
>  	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
>  		return 0;
>  
> -	wbc_attach_fdatawrite_inode(wbc, mapping->host);
> -	ret = do_writepages(mapping, wbc);
> -	wbc_detach_inode(wbc);
> +	wbc_attach_fdatawrite_inode(&wbc, mapping->host);
> +	ret = do_writepages(mapping, &wbc);
> +	wbc_detach_inode(&wbc);
> +
> +	if (!ret && nr_to_write)
> +		*nr_to_write = wbc.nr_to_write;
>  	return ret;
>  }
> -EXPORT_SYMBOL(filemap_fdatawrite_wbc);
>  
>  /**
>   * __filemap_fdatawrite_range - start writeback on mapping dirty pages in range
> @@ -412,14 +411,7 @@ EXPORT_SYMBOL(filemap_fdatawrite_wbc);
>  int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
>  				loff_t end, int sync_mode)
>  {
> -	struct writeback_control wbc = {
> -		.sync_mode = sync_mode,
> -		.nr_to_write = LONG_MAX,
> -		.range_start = start,
> -		.range_end = end,
> -	};
> -
> -	return filemap_fdatawrite_wbc(mapping, &wbc);
> +	return __filemap_fdatawrite(mapping, start, end, sync_mode, NULL);
>  }
>  
>  int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
> @@ -475,18 +467,8 @@ EXPORT_SYMBOL(filemap_flush);
>   */
>  int filemap_fdatawrite_kick_nr(struct address_space *mapping, long *nr_to_write)
>  {
> -	struct writeback_control wbc = {
> -		.nr_to_write = *nr_to_write,
> -		.sync_mode = WB_SYNC_NONE,
> -		.range_start = 0,
> -		.range_end = LLONG_MAX,
> -	};
> -	int ret;
> -
> -	ret = filemap_fdatawrite_wbc(mapping, &wbc);
> -	if (!ret)
> -		*nr_to_write = wbc.nr_to_write;
> -	return ret;
> +	return __filemap_fdatawrite(mapping, 0, LLONG_MAX, WB_SYNC_NONE,
> +			nr_to_write);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(filemap_fdatawrite_kick_nr, "btrfs");
>  
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

