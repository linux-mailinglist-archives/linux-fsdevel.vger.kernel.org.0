Return-Path: <linux-fsdevel+bounces-17238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C3D8A9798
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 12:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30D61C20D5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 10:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD3C15E1F3;
	Thu, 18 Apr 2024 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2fAvsNQU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zg3qdNiQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2fAvsNQU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zg3qdNiQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605E915E1F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436664; cv=none; b=A3hjW9H1UXsAZ4xNoVNlt9u6wSlu+oB6RzoWTvudcivT2tzmBMxKxBb438ROlBFP7ssUEiopOaIcB+QkbqRbPHifTu/nGKfKFnrW71q0jVsrJp+/PfapcmE8YCDydFTqP7Hnan7rVS5KU62/+ni9+Sp5mtHi2wg91V9h04QIEt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436664; c=relaxed/simple;
	bh=tqplIyliXatKC8kQFnnDBRkXxGERjS55Q14sCK9wC6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJINggQNU7ezpyd359jZ+LKa8Vr72fqAjHcgdam6/VLSlqyXwp5PC8J/867BaDh40zKwGV8IkZKup37GBO9qO5LOHH3tcq5wu30Qv0xrtLAD4iqPvjmZCOw64Na0IzHA9+LHKIQo0donw8gkUwhWG5sWT1lCEHkcUa8c4AbsCNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2fAvsNQU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zg3qdNiQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2fAvsNQU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zg3qdNiQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 97E7121FFF;
	Thu, 18 Apr 2024 10:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713436654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msGuJbB+vxR1J17fc6Fp+5eJclGPrgKOv46SVeh8ZNg=;
	b=2fAvsNQUzdVL4vvT2ct2O7EUXk62BIgY3F6TzT41Q88b73JkWvJSg35FuEByUDLq6wS6lj
	W1REJ0yMow/TPk38R0yDU8rkD0xKhu+SakP6WP0aodpYZfAH9r96N466t5xQkS9MrPsauv
	5t9V2KdX2IMsmWlCsFSfoqPxRwqRfZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713436654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msGuJbB+vxR1J17fc6Fp+5eJclGPrgKOv46SVeh8ZNg=;
	b=Zg3qdNiQAULcHTItFlWR70hPU8UTYw921b/+IiHInRJb3Dw4Z+2a28dPzWIRvdWnhpLFYc
	UXJt+lR2X4YRJsDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713436654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msGuJbB+vxR1J17fc6Fp+5eJclGPrgKOv46SVeh8ZNg=;
	b=2fAvsNQUzdVL4vvT2ct2O7EUXk62BIgY3F6TzT41Q88b73JkWvJSg35FuEByUDLq6wS6lj
	W1REJ0yMow/TPk38R0yDU8rkD0xKhu+SakP6WP0aodpYZfAH9r96N466t5xQkS9MrPsauv
	5t9V2KdX2IMsmWlCsFSfoqPxRwqRfZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713436654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msGuJbB+vxR1J17fc6Fp+5eJclGPrgKOv46SVeh8ZNg=;
	b=Zg3qdNiQAULcHTItFlWR70hPU8UTYw921b/+IiHInRJb3Dw4Z+2a28dPzWIRvdWnhpLFYc
	UXJt+lR2X4YRJsDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B22513687;
	Thu, 18 Apr 2024 10:37:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xwj2Ie73IGYFUgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Apr 2024 10:37:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 209E2A0812; Thu, 18 Apr 2024 12:37:34 +0200 (CEST)
Date: Thu, 18 Apr 2024 12:37:34 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] udf: Convert udf_symlink_filler() to use a folio
Message-ID: <20240418103734.kdr5u3556wyt3zgw@quack3>
References: <20240417150416.752929-1-willy@infradead.org>
 <20240417150416.752929-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417150416.752929-2-willy@infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 17-04-24 16:04:07, Matthew Wilcox (Oracle) wrote:
> Remove the conversion to struct page and use folio APIs throughout.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. I've just noticed this removes the SetPageError(). Grepping for
a while we seem to set/clear that in quite some places in the filesystems
but nobody is reading it these days (to be fair jfs has one test and btrfs
also one)? And similarly with folio_test_error... I have a recollection
this was actually used in the past but maybe you've removed it as part of
folio overhaul? Anyway, either something should start using the error bit
or we can drop the dead code and free up a page flags bit. Yay.

								Honza

> ---
>  fs/udf/symlink.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
> index f7eaf7b14594..0105e7e2ba3d 100644
> --- a/fs/udf/symlink.c
> +++ b/fs/udf/symlink.c
> @@ -99,18 +99,17 @@ static int udf_pc_to_char(struct super_block *sb, unsigned char *from,
>  
>  static int udf_symlink_filler(struct file *file, struct folio *folio)
>  {
> -	struct page *page = &folio->page;
> -	struct inode *inode = page->mapping->host;
> +	struct inode *inode = folio->mapping->host;
>  	struct buffer_head *bh = NULL;
>  	unsigned char *symlink;
>  	int err = 0;
> -	unsigned char *p = page_address(page);
> +	unsigned char *p = folio_address(folio);
>  	struct udf_inode_info *iinfo = UDF_I(inode);
>  
>  	/* We don't support symlinks longer than one block */
>  	if (inode->i_size > inode->i_sb->s_blocksize) {
>  		err = -ENAMETOOLONG;
> -		goto out_unlock;
> +		goto out;
>  	}
>  
>  	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
> @@ -120,24 +119,15 @@ static int udf_symlink_filler(struct file *file, struct folio *folio)
>  		if (!bh) {
>  			if (!err)
>  				err = -EFSCORRUPTED;
> -			goto out_err;
> +			goto out;
>  		}
>  		symlink = bh->b_data;
>  	}
>  
>  	err = udf_pc_to_char(inode->i_sb, symlink, inode->i_size, p, PAGE_SIZE);
>  	brelse(bh);
> -	if (err)
> -		goto out_err;
> -
> -	SetPageUptodate(page);
> -	unlock_page(page);
> -	return 0;
> -
> -out_err:
> -	SetPageError(page);
> -out_unlock:
> -	unlock_page(page);
> +out:
> +	folio_end_read(folio, err == 0);
>  	return err;
>  }
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

