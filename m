Return-Path: <linux-fsdevel+bounces-13754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB5387364F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 13:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A62284783
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D83D8002D;
	Wed,  6 Mar 2024 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RBJNKoMm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RmZ8xQ/S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l4hX5RY9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mxvgkxln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221815D72F
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728085; cv=none; b=Sp7eWdR38aASBBl8JwfdwbSPnT214dUvxGR1NN7u71oiL2cnXzURsRUXhZDDgkkOlp62UcgeIST9ZjCvpBeVzLToYjScFgTbxOW7UNwRbVlQalPY5eObBxp6vxOskXkFwd2Wzjf07SNogDqkRHOGhVxsRPRG1mKhlneAbNF+O0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728085; c=relaxed/simple;
	bh=AN1i7npPSqFKa/gTCEHxPlHdCIUdRDUp8chUF3ALU3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLFML9TlL4xi5yKW+vC4w4vmOGqkxb0xkqWaelh49anFEgpM1UWjgOZOYaXrsbKV2YoiOJxkBeVEj4oYGXodxGGvE8zsh7n1AP3p7L8cb7k3yGfENMalNfx/UuyiuHQAp14OTJ61UTJqcGw7lDab/j4d34vodaxeae9KeutVuak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RBJNKoMm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RmZ8xQ/S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l4hX5RY9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mxvgkxln; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF0CD4EDAF;
	Wed,  6 Mar 2024 12:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709728082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tkNXMA3nHBxOqFthTA9+evEHySDTwartsh9veXDVVKI=;
	b=RBJNKoMmzqc8vBTde65xsjEG2OmsqY7p2m3A12rrF3/MX6ty8/4GGxr15Jg0rZwX/QNwku
	ftimeDBPz6Ee4BA9wjISkIvb6Qhbbp4EzVHMAZjOaFWQKV4odYW0LMG3TbGqSx27++86mp
	DA4KxwcRcqGc3UuhsnZe8FW6RflA/jM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709728082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tkNXMA3nHBxOqFthTA9+evEHySDTwartsh9veXDVVKI=;
	b=RmZ8xQ/SN0UhedHazJ3Ra2o9ZwCDA8ZK9+CxzisvWaCya7wX6o//eyWsgrJyh5G12cYUc4
	xmamMVii8v4qNkAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709728081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tkNXMA3nHBxOqFthTA9+evEHySDTwartsh9veXDVVKI=;
	b=l4hX5RY9G6CuxWFUc4rK2NdaEvFaLWk5X8+2oNM1cqmWYRPy8+Yw2tGU0X0pGNcQdSwVYm
	UcjIj/6DYCU7H5d6dw6F0zP9li/+zm+mdQJ6+8twjNI3F2f3oDMGrBmZMdhhFY6kOOE27R
	Ipz1vpfeps2HPzgHeSGce44/JAPJkvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709728081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tkNXMA3nHBxOqFthTA9+evEHySDTwartsh9veXDVVKI=;
	b=MxvgkxlnwRqLLAzHTMK212reVUWfzchYbwOwmZzh4qFnu0hTGuKpgeyQ7hWRQXqr6SCKXz
	E1oHb/TE4zAUhHAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E50951377D;
	Wed,  6 Mar 2024 12:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SnXxN1Fh6GUuTgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 06 Mar 2024 12:28:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 91C89A0803; Wed,  6 Mar 2024 13:28:01 +0100 (CET)
Date: Wed, 6 Mar 2024 13:28:01 +0100
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: reiserfs_wait_on_write_block@infradead.org,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] reiserfs: Convert to writepages
Message-ID: <20240306122801.srdr67eeb5nq4j4x@quack3>
References: <20240305185208.1200166-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305185208.1200166-1-willy@infradead.org>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=l4hX5RY9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Mxvgkxln
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,infradead.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EF0CD4EDAF
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Tue 05-03-24 18:52:05, Matthew Wilcox (Oracle) wrote:
> Use buffer_migrate_folio to handle folio migration instead of writing
> out dirty pages and reading them back in again.  Use writepages to write
> out folios more efficiently.  We now only do that wait_on_write_block
> check once per call to writepages instead of once per page.  It would be
> possible to do one transaction per writeback run, but that's a bit of a
> big change to do to this old filesystem, so leave it as one transaction
> per folio (and leave reiserfs supporting only one page per folio).
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/reiserfs/inode.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
> index 1d825459ee6e..c1daedc50f4c 100644
> --- a/fs/reiserfs/inode.c
> +++ b/fs/reiserfs/inode.c
> @@ -2503,8 +2503,8 @@ static int map_block_for_writepage(struct inode *inode,
>   * start/recovery path as __block_write_full_folio, along with special
>   * code to handle reiserfs tails.
>   */
> -static int reiserfs_write_full_folio(struct folio *folio,
> -				    struct writeback_control *wbc)
> +static int reiserfs_write_folio(struct folio *folio,
> +		struct writeback_control *wbc, void *data)
>  {
>  	struct inode *inode = folio->mapping->host;
>  	unsigned long end_index = inode->i_size >> PAGE_SHIFT;
> @@ -2721,12 +2721,11 @@ static int reiserfs_read_folio(struct file *f, struct folio *folio)
>  	return block_read_full_folio(folio, reiserfs_get_block);
>  }
>  
> -static int reiserfs_writepage(struct page *page, struct writeback_control *wbc)
> +static int reiserfs_writepages(struct address_space *mapping,
> +		struct writeback_control *wbc)
>  {
> -	struct folio *folio = page_folio(page);
> -	struct inode *inode = folio->mapping->host;
> -	reiserfs_wait_on_write_block(inode->i_sb);
> -	return reiserfs_write_full_folio(folio, wbc);
> +	reiserfs_wait_on_write_block(mapping->host->i_sb);
> +	return write_cache_pages(mapping, wbc, reiserfs_write_folio, NULL);
>  }
>  
>  static void reiserfs_truncate_failed_write(struct inode *inode)
> @@ -3405,7 +3404,7 @@ int reiserfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  }
>  
>  const struct address_space_operations reiserfs_address_space_operations = {
> -	.writepage = reiserfs_writepage,
> +	.writepages = reiserfs_writepages,
>  	.read_folio = reiserfs_read_folio,
>  	.readahead = reiserfs_readahead,
>  	.release_folio = reiserfs_release_folio,
> @@ -3415,4 +3414,5 @@ const struct address_space_operations reiserfs_address_space_operations = {
>  	.bmap = reiserfs_aop_bmap,
>  	.direct_IO = reiserfs_direct_IO,
>  	.dirty_folio = reiserfs_dirty_folio,
> +	.migrate_folio = buffer_migrate_folio,
>  };
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

