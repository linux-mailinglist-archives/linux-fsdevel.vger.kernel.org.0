Return-Path: <linux-fsdevel+bounces-46550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F43A8B583
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 11:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8385F5A2051
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 09:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CD32356BC;
	Wed, 16 Apr 2025 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XPUdgiIg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F6cwiYRe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XPUdgiIg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F6cwiYRe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14259233739
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796149; cv=none; b=GfJ4S5cuePM1Nj0SElUP5Kz/iDRvgB8hTPmcqTt/w3zajw1fOosjKIAsTFMFDLHq3yj/envurgS8LNRV7k++uBG0TUGwZDKzNcWiB1FJNdZnB9zuFR0WMKCaLI0wrrBNxWwgY+SzzR1rlgasBdBYIhOJNjJU/mImYtnydMSOZVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796149; c=relaxed/simple;
	bh=eujkX5iYPvUSNFaXrQeNLkMJIce9Xq2ExU/R9HlS7yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsMa7tgV1MRcAkdqyYr4iI8cyL5NvY5CSG8/Jx8tuf8emBqdHp6DkOF85A/uVfL5V0mSDKeoR3lP5ldHqxwgNXjh3Tys1jkRVByZRiKdPi125mNV5B8oKIrn4qE4nMqhR0DciBamjWvcVkf7yDZmUTdmZBiOOiOQrSD9iAgXWgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XPUdgiIg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F6cwiYRe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XPUdgiIg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F6cwiYRe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20892211A6;
	Wed, 16 Apr 2025 09:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744796146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgkZ1fRS53uDN5PoxYa4lBptEV1A2yLR4pcQU/oqRBo=;
	b=XPUdgiIg+vd9UAZXzC5CbUa0OWyGoze5Ue6kRJ6kC+WMZAhmshmFMDWhNLI9XHqxFPnJB4
	eDv4Ks5cWaFaKUamQPyMgsb/T9HF0F2KcrRDcowXdKZc08ISzoXNdLlQFEnV8VVs8DiFNX
	Io2ALXfxUGk97jjT4eSjA8IiptFH6aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744796146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgkZ1fRS53uDN5PoxYa4lBptEV1A2yLR4pcQU/oqRBo=;
	b=F6cwiYRe6I/lwMvFvGCvErEl8mCRRByqT/4zKSeUZcCYY3Azu8v/zvXMcivV2Fd4nChXQz
	qGcVBpw2Vl/TI2Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XPUdgiIg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=F6cwiYRe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744796146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgkZ1fRS53uDN5PoxYa4lBptEV1A2yLR4pcQU/oqRBo=;
	b=XPUdgiIg+vd9UAZXzC5CbUa0OWyGoze5Ue6kRJ6kC+WMZAhmshmFMDWhNLI9XHqxFPnJB4
	eDv4Ks5cWaFaKUamQPyMgsb/T9HF0F2KcrRDcowXdKZc08ISzoXNdLlQFEnV8VVs8DiFNX
	Io2ALXfxUGk97jjT4eSjA8IiptFH6aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744796146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgkZ1fRS53uDN5PoxYa4lBptEV1A2yLR4pcQU/oqRBo=;
	b=F6cwiYRe6I/lwMvFvGCvErEl8mCRRByqT/4zKSeUZcCYY3Azu8v/zvXMcivV2Fd4nChXQz
	qGcVBpw2Vl/TI2Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1665A13976;
	Wed, 16 Apr 2025 09:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EVZ2BfJ5/2dkdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 16 Apr 2025 09:35:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C6241A0947; Wed, 16 Apr 2025 11:35:45 +0200 (CEST)
Date: Wed, 16 Apr 2025 11:35:45 +0200
From: Jan Kara <jack@suse.cz>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, 
	brauner@kernel.org, mcgrof@kernel.org, willy@infradead.org, hare@suse.de, 
	djwong@kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 4/7] fs/ocfs2: use sleeping version of __find_get_block()
Message-ID: <eaibtk55ct3nwuvta3yoe3mkzywp4dyehswxpjqjnivue5s57t@honop3yup4y3>
References: <20250415231635.83960-1-dave@stgolabs.net>
 <20250415231635.83960-5-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415231635.83960-5-dave@stgolabs.net>
X-Rspamd-Queue-Id: 20892211A6
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 15-04-25 16:16:32, Davidlohr Bueso wrote:
> This is a path that allows for blocking as it does IO. Convert
> to the new nonatomic flavor to benefit from potential performance
> benefits and adapt in the future vs migration such that semantics
> are kept.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

One nit below but either way feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index f1b4b3e611cb..c7a9729dc9d0 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -1249,7 +1249,7 @@ static int ocfs2_force_read_journal(struct inode *inode)
>  		}
>  
>  		for (i = 0; i < p_blocks; i++, p_blkno++) {
> -			bh = __find_get_block(osb->sb->s_bdev, p_blkno,
> +			bh = __find_get_block_nonatomic(osb->sb->s_bdev, p_blkno,

This could be using sb_find_get_block_nonatomic().

>  					osb->sb->s_blocksize);
>  			/* block not cached. */
>  			if (!bh)
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

