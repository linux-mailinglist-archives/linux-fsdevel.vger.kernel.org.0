Return-Path: <linux-fsdevel+bounces-35438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822A09D4C70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 13:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6632281EAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBADB1D417B;
	Thu, 21 Nov 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WbDF2+/Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+jrpssDL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WbDF2+/Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+jrpssDL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504151D2F64;
	Thu, 21 Nov 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732190380; cv=none; b=Vo9b572mPwwpnsdXuknTktR2mMxstANxxCQV58xgGN/tbXLtgwfK2ZJexN49X5wP/j2bUJ0SOCe/9wSmPEnsqvNmvDLCQvTanNVlFh8rs2XklBP+focw7foWJaj/pTf/QLtc4W6SZE3vDeLixs4XbTVoQ6Ps6xq4j0BqTflbYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732190380; c=relaxed/simple;
	bh=GA7riFDojV7b5B3QZgtknj0rdQA0T3ulbHqf0EQnPYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHC8xXIa6MBumzy1tndWArXytS2S/cmJKelqTR4tOQtVeba8nnJogCsH7rAaexFTuEitxZeLac5yokL0BoXBOg1IIx9+hRPvBAqMe7SUotUkgZ/fiHCNo2zijmFqhODEd4ykc5uHAy/dW4+Sn45d8PxYef4raUFzLq34prRGPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WbDF2+/Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+jrpssDL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WbDF2+/Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+jrpssDL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74DB6219DA;
	Thu, 21 Nov 2024 11:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732190376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffwoLapS7ds0fc8Z3M05iUgxL+jHEXm7ir+HgYb1z3k=;
	b=WbDF2+/QPA0BtRSxUvFeewXAZflxCiLqPIZMTUTBOMoeZMewXFqQhyVIPwsyKnsLuIxLjC
	YBChiaJq5lKbX8t4wNVp2++Qx7FR6qZMYkzwasGxasrMAz+wa3x2aScdHMns5vY1+ieppk
	NhUl+b/emgEGkDchCkFue9JS0Af1ZT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732190376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffwoLapS7ds0fc8Z3M05iUgxL+jHEXm7ir+HgYb1z3k=;
	b=+jrpssDLjADPog+MQaemqubSlppPYFhOsOzpEiliVLAEQMf4vMl0xJ3upfL8L62marbGSA
	VDGseYFK8w5YByAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="WbDF2+/Q";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+jrpssDL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732190376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffwoLapS7ds0fc8Z3M05iUgxL+jHEXm7ir+HgYb1z3k=;
	b=WbDF2+/QPA0BtRSxUvFeewXAZflxCiLqPIZMTUTBOMoeZMewXFqQhyVIPwsyKnsLuIxLjC
	YBChiaJq5lKbX8t4wNVp2++Qx7FR6qZMYkzwasGxasrMAz+wa3x2aScdHMns5vY1+ieppk
	NhUl+b/emgEGkDchCkFue9JS0Af1ZT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732190376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffwoLapS7ds0fc8Z3M05iUgxL+jHEXm7ir+HgYb1z3k=;
	b=+jrpssDLjADPog+MQaemqubSlppPYFhOsOzpEiliVLAEQMf4vMl0xJ3upfL8L62marbGSA
	VDGseYFK8w5YByAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B2EC13927;
	Thu, 21 Nov 2024 11:59:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WMsqGqggP2d/DAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:59:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2E8BBA089E; Thu, 21 Nov 2024 12:59:32 +0100 (CET)
Date: Thu, 21 Nov 2024 12:59:32 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hughd@google.com, linux-ext4@vger.kernel.org, tytso@mit.edu,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 3/3] tmpfs: use inode_set_cached_link()
Message-ID: <20241121115932.bwm64mrghjc3nxtk@quack3>
References: <20241120112037.822078-1-mjguzik@gmail.com>
 <20241120112037.822078-4-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120112037.822078-4-mjguzik@gmail.com>
X-Rspamd-Queue-Id: 74DB6219DA
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 20-11-24 12:20:36, Mateusz Guzik wrote:
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/shmem.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index c7881e16f4be..135f38eb2ff1 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3868,6 +3868,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	int len;
>  	struct inode *inode;
>  	struct folio *folio;
> +	char *link;
>  
>  	len = strlen(symname) + 1;
>  	if (len > PAGE_SIZE)
> @@ -3889,12 +3890,13 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  
>  	inode->i_size = len-1;
>  	if (len <= SHORT_SYMLINK_LEN) {
> -		inode->i_link = kmemdup(symname, len, GFP_KERNEL);
> -		if (!inode->i_link) {
> +		link = kmemdup(symname, len, GFP_KERNEL);
> +		if (!link) {
>  			error = -ENOMEM;
>  			goto out_remove_offset;
>  		}
>  		inode->i_op = &shmem_short_symlink_operations;
> +		inode_set_cached_link(inode, link, len - 1);
>  	} else {
>  		inode_nohighmem(inode);
>  		inode->i_mapping->a_ops = &shmem_aops;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

