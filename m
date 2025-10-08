Return-Path: <linux-fsdevel+bounces-63589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4F1BC4A02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 13:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F49E188B593
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 11:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABA42F7ACC;
	Wed,  8 Oct 2025 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W5tuoW+g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RYbPcZQH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W5tuoW+g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RYbPcZQH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB792F7AA7
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924294; cv=none; b=KU8ZHPCxheHMV2hX3Umvg7C8P2nUPZciSwnYA47Ls5/00PtIXp0WBxhD5OpBMKxIumY+K0mHtdQBmsZU4eHy+eoDRhae5kmf+UGTMttf9Tyr76ZVyECWHKmw89xMPRToag3m1EZ/BcmgroJ+Dh6DhoIttcM6bDiUR9X2O5Uh5sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924294; c=relaxed/simple;
	bh=8cag3zuNphr8CppeayVDLR81Rxb3ZdgnTZMEP5CeOaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNFfVHwCeRvkCkKr4Kk2y0SPNh+4sTR+xZwS1C8gvjZ0jkWUeE6XVwQgRpXJGr+3VC4yqdpkj3CiIq7xKhc7MuKAo8rxVLTZhi4K6BJODFk6Y93QDxsxnmbl2D+tXD73L2FuL2n2ck1DGj60qIGWjY+QNNsh/MfG3hQU9Rbm8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W5tuoW+g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RYbPcZQH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W5tuoW+g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RYbPcZQH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C030733682;
	Wed,  8 Oct 2025 11:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759924290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ryI3+xKFvG3c0t0tQvHX7EADdfWryz/6C8fjbSuKgwA=;
	b=W5tuoW+guY+5vNNO8Am10H4oSJxdlVfucBdKw1Pz3RYkC1JPt5U+mPv2TYkndO4Wfsqh5T
	EqDUoYibvVmndJLHk+GqnTfwaiBv99RF8cP7HgLfl5NC7u5SdLlIBOdarpAZouQqsyyiax
	kMQtYOzor/Dnuw9Usa+5H4b4GmIBqlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759924290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ryI3+xKFvG3c0t0tQvHX7EADdfWryz/6C8fjbSuKgwA=;
	b=RYbPcZQHwGQVu8SY7EP2G6sITOVIrSnaFVKVpjwIC8Z8Yxyo8KXH2ThmEZ+bq7exM8a5IK
	YJLje4pLIySL9RCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=W5tuoW+g;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RYbPcZQH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759924290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ryI3+xKFvG3c0t0tQvHX7EADdfWryz/6C8fjbSuKgwA=;
	b=W5tuoW+guY+5vNNO8Am10H4oSJxdlVfucBdKw1Pz3RYkC1JPt5U+mPv2TYkndO4Wfsqh5T
	EqDUoYibvVmndJLHk+GqnTfwaiBv99RF8cP7HgLfl5NC7u5SdLlIBOdarpAZouQqsyyiax
	kMQtYOzor/Dnuw9Usa+5H4b4GmIBqlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759924290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ryI3+xKFvG3c0t0tQvHX7EADdfWryz/6C8fjbSuKgwA=;
	b=RYbPcZQHwGQVu8SY7EP2G6sITOVIrSnaFVKVpjwIC8Z8Yxyo8KXH2ThmEZ+bq7exM8a5IK
	YJLje4pLIySL9RCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4EE313A3D;
	Wed,  8 Oct 2025 11:51:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cKUqLEJQ5mhKMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Oct 2025 11:51:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 67FD3A0ACD; Wed,  8 Oct 2025 13:51:26 +0200 (CEST)
Date: Wed, 8 Oct 2025 13:51:26 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 09/13] ext4: rename mext_page_mkuptodate() to
 mext_folio_mkuptodate()
Message-ID: <gxjjbokvnurzrwc64oqlisadx5anmwdv67qit7ttd3wlunj6d5@ab35hupg4zby>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-10-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925092610.1936929-10-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huawei.com:email,suse.cz:email,suse.cz:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: C030733682
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Thu 25-09-25 17:26:05, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> mext_page_mkuptodate() no longer works on a single page, so rename it to
> mext_folio_mkuptodate().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/move_extent.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 0191a3c746db..2df6072b26c0 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -165,7 +165,7 @@ mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
>  }
>  
>  /* Force folio buffers uptodate w/o dropping folio's lock */
> -static int mext_page_mkuptodate(struct folio *folio, size_t from, size_t to)
> +static int mext_folio_mkuptodate(struct folio *folio, size_t from, size_t to)
>  {
>  	struct inode *inode = folio->mapping->host;
>  	sector_t block;
> @@ -358,7 +358,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
>  data_copy:
>  	from = offset_in_folio(folio[0],
>  			       orig_blk_offset << orig_inode->i_blkbits);
> -	*err = mext_page_mkuptodate(folio[0], from, from + replaced_size);
> +	*err = mext_folio_mkuptodate(folio[0], from, from + replaced_size);
>  	if (*err)
>  		goto unlock_folios;
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

