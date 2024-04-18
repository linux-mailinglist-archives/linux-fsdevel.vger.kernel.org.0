Return-Path: <linux-fsdevel+bounces-17239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307D88A97A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 12:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D719B217F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 10:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3309715CD6C;
	Thu, 18 Apr 2024 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nLiqLOsL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FtVLhEyw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nLiqLOsL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FtVLhEyw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E509A15AAAD
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437054; cv=none; b=GprCnaJLnyAeYQTs+ETryRs1Hy4W/5Uydv01rmzBCcjObIv+ZszE1efizicE/tTC5kYfIYHvmbyINHBmZi8aSfpAb6D2p87fr5wesEnDEs4V+pVOHU0ZOXHIURaYgj6YQEmwFOLMZiBRSG8ilRvj5rvWwJPLTy9i5LrFijDFoD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437054; c=relaxed/simple;
	bh=D3WMot7VsdnAd2ol8hIsjQhj4UAkn/xMqc6my1xAGwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfLC80qsopi+6/+X9C0sU3Hm4HR0M13bw5KFMcJyV3poqfqrgJEkAFZlse/EW615Mo8fYPlviRh00BqFDynd64QaRfxqSpkCQHDNHotc4pmn7p3fktEAA8afQVHuz7Y8x0gsCp8QO2rWhj2nnP9DfSU+s/VoDPHxJqSqiSXFrYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nLiqLOsL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FtVLhEyw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nLiqLOsL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FtVLhEyw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03F4634D85;
	Thu, 18 Apr 2024 10:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713437051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiB7Ioe1GubH4E0lWiTicTWXpFOL5UIuUZ6K84Vsoe0=;
	b=nLiqLOsLR/Iy0miQbLZA5XNeKTT8lbqyqNEOp81FNskY19qmWtGx1YZTYBkpwaWbBQjpSf
	UZ6NATXUnKyDpJkVmYHAwMEkH2dsH5Z0LtNBg8qXXOXbkq4bkcAm90n6JYwmqJyGYrPXlT
	X1CB1JOUjrOVphf8oZl4Yv/oZM0F69M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713437051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiB7Ioe1GubH4E0lWiTicTWXpFOL5UIuUZ6K84Vsoe0=;
	b=FtVLhEywB8O8ZzXhrfECHTQbrnRQPKO4bHE/AOg/jTnGNuot54Tjh6USbvrJez8ENl48yS
	Sj7cHlMSPeK/YEBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nLiqLOsL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FtVLhEyw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713437051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiB7Ioe1GubH4E0lWiTicTWXpFOL5UIuUZ6K84Vsoe0=;
	b=nLiqLOsLR/Iy0miQbLZA5XNeKTT8lbqyqNEOp81FNskY19qmWtGx1YZTYBkpwaWbBQjpSf
	UZ6NATXUnKyDpJkVmYHAwMEkH2dsH5Z0LtNBg8qXXOXbkq4bkcAm90n6JYwmqJyGYrPXlT
	X1CB1JOUjrOVphf8oZl4Yv/oZM0F69M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713437051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiB7Ioe1GubH4E0lWiTicTWXpFOL5UIuUZ6K84Vsoe0=;
	b=FtVLhEywB8O8ZzXhrfECHTQbrnRQPKO4bHE/AOg/jTnGNuot54Tjh6USbvrJez8ENl48yS
	Sj7cHlMSPeK/YEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED9BD13687;
	Thu, 18 Apr 2024 10:44:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o+b8OXr5IGYhVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Apr 2024 10:44:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8D9ECA0812; Thu, 18 Apr 2024 12:44:06 +0200 (CEST)
Date: Thu, 18 Apr 2024 12:44:06 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] udf: Convert udf_expand_file_adinicb() to use a folio
Message-ID: <20240418104406.6dqx5jlwtywsyuu2@quack3>
References: <20240417150416.752929-1-willy@infradead.org>
 <20240417150416.752929-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417150416.752929-4-willy@infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.44 / 50.00];
	BAYES_HAM(-2.43)[97.37%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 03F4634D85
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.44

On Wed 17-04-24 16:04:09, Matthew Wilcox (Oracle) wrote:
> Use the folio APIs throughout this function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good.

>  	up_write(&iinfo->i_data_sem);
>  	err = filemap_fdatawrite(inode->i_mapping);
>  	if (err) {
>  		/* Restore everything back so that we don't lose data... */
> -		lock_page(page);
> +		folio_lock(folio);
>  		down_write(&iinfo->i_data_sem);
> -		memcpy_to_page(page, 0, iinfo->i_data + iinfo->i_lenEAttr,
> -			       inode->i_size);
> -		unlock_page(page);
> +		memcpy_from_folio(iinfo->i_data + iinfo->i_lenEAttr,
> +				folio, 0, inode->i_size);
> +		folio_unlock(folio);

So this actually silently fixes a bug on the error recovery path where we
could be loosing old data in case of ENOSPC. I'll add:

Fixes: 1eeceaec794e ("udf: Convert udf_expand_file_adinicb() to avoid kmap_atomic()")

and some commentary on commit.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

