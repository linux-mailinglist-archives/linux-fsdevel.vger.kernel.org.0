Return-Path: <linux-fsdevel+bounces-17240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9888A97C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 12:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42ED12817A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 10:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7A315DBA0;
	Thu, 18 Apr 2024 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Al4vUaPH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hFEjY9V/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Al4vUaPH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hFEjY9V/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B021442F6
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437405; cv=none; b=E6CA9EYeIFyu6xGsGrBdT9RkfoseTFkK++GzYt+q2pmySizzKosYRpLuP16eUQcxaKwPrgSqAvVSmyTvgPoDUtNahujmYPYMwbA/QXXhWSeNq3OVAPpakS7U26LtUoXwTfQe+TkTTNeANzRGOv6Lay5PUqeCukFsDszZvY6RjRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437405; c=relaxed/simple;
	bh=Y3J1BUDvs5nqvFGXGKPSZX6L+UrEpNESbcEZK/eYn0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muOulWfzweEG9ULV3J7RqXi9ZqAk78MG/Bbng4X0eaAlVc95cRMnsEkHIOnZ0OCHx8MOS4DwCTUo4+l81p2Z2pZ4++BdGKPJjuAVBbxCQYVhHR6mBtmOA3RoHdq4/HJ+aDnBsY8jVUFvlIwqdFFZx4b0Bo4lU2SlvT3aGpc6TPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Al4vUaPH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hFEjY9V/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Al4vUaPH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hFEjY9V/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66FB434D9E;
	Thu, 18 Apr 2024 10:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713437401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GCZK8u7lLQvDQQMrgeKbhDa7Q+13dalxPQfQjZXUB14=;
	b=Al4vUaPH1Pk+XabMvNcqtm1pX09tV/jEbjjApoJqsnjbv9WNuFwNl+WaIUyCElKHX588Wq
	8nvrn4zbqkFOgV/GYDlJOrh/IBo8o/5vYgXxbEtlV/NQSNB90/3yN+05heCupVY7L3rqRB
	4DY8G/AjX4M4txQDQU1NCrCY4ahONUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713437401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GCZK8u7lLQvDQQMrgeKbhDa7Q+13dalxPQfQjZXUB14=;
	b=hFEjY9V/gU0MXob3zUwQJYbwolmflWCIKGDEUGu0DoBTpfJm6mIphjuSPWbWNTZWlO6xaT
	8lMfW8lX2o3GgRAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Al4vUaPH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="hFEjY9V/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713437401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GCZK8u7lLQvDQQMrgeKbhDa7Q+13dalxPQfQjZXUB14=;
	b=Al4vUaPH1Pk+XabMvNcqtm1pX09tV/jEbjjApoJqsnjbv9WNuFwNl+WaIUyCElKHX588Wq
	8nvrn4zbqkFOgV/GYDlJOrh/IBo8o/5vYgXxbEtlV/NQSNB90/3yN+05heCupVY7L3rqRB
	4DY8G/AjX4M4txQDQU1NCrCY4ahONUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713437401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GCZK8u7lLQvDQQMrgeKbhDa7Q+13dalxPQfQjZXUB14=;
	b=hFEjY9V/gU0MXob3zUwQJYbwolmflWCIKGDEUGu0DoBTpfJm6mIphjuSPWbWNTZWlO6xaT
	8lMfW8lX2o3GgRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5789513687;
	Thu, 18 Apr 2024 10:50:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hi4PFdn6IGYgVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Apr 2024 10:50:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 041CBA0812; Thu, 18 Apr 2024 12:50:00 +0200 (CEST)
Date: Thu, 18 Apr 2024 12:50:00 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] udf: Convert udf_adinicb_readpage() to
 udf_adinicb_read_folio()
Message-ID: <20240418105000.inlrq2z666vworuu@quack3>
References: <20240417150416.752929-1-willy@infradead.org>
 <20240417150416.752929-5-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417150416.752929-5-willy@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -3.10
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 66FB434D9E
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.10 / 50.00];
	BAYES_HAM(-2.09)[95.56%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,infradead.org:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]

On Wed 17-04-24 16:04:10, Matthew Wilcox (Oracle) wrote:
> Now that all three callers have a folio, convert this function to
> take a folio, and use the folio APIs.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

One comment below:

> -static void udf_adinicb_readpage(struct page *page)
> +static void udf_adinicb_read_folio(struct folio *folio)
>  {
> -	struct inode *inode = page->mapping->host;
> -	char *kaddr;
> +	struct inode *inode = folio->mapping->host;
>  	struct udf_inode_info *iinfo = UDF_I(inode);
>  	loff_t isize = i_size_read(inode);
>  
> -	kaddr = kmap_local_page(page);
> -	memcpy(kaddr, iinfo->i_data + iinfo->i_lenEAttr, isize);
> -	memset(kaddr + isize, 0, PAGE_SIZE - isize);
> -	flush_dcache_page(page);

So where did the flush_dcache_page() call go? AFAIU we should be calling
flush_dcache_folio(folio) here, shouldn't we?

> -	SetPageUptodate(page);
> -	kunmap_local(kaddr);
> +	folio_fill_tail(folio, 0, iinfo->i_data + iinfo->i_lenEAttr, isize);
> +	folio_mark_uptodate(folio);
>  }

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

