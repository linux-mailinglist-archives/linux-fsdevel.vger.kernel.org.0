Return-Path: <linux-fsdevel+bounces-17284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D698AAAE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 10:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F831F226B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 08:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8EB651B7;
	Fri, 19 Apr 2024 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E2e9KkXE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sfw7YyoP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E2e9KkXE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sfw7YyoP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C93B1E4BE
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713516648; cv=none; b=jSHLY/GxVWiyj9EJf1wB1FdAaxPly8srIzdXBKsR7bPJnnUd4ObOvcfTP3ZKx0iVijvsPYVnf9aI/FdbcMIXuboyXwKCByGVhcH+FqHxsMhFNpuWilm/BIfytUqINzW9inGHmHeO0108cHigvOBsG78NR3qagAk2fls1tnVUNeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713516648; c=relaxed/simple;
	bh=STWAlh0KQd/yWqFxfyYPL/qJwk4AgY7OjAwBgd0AoRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G04qIHo5gu/Ztx8nQObpxh3vNoXlAV7EFIHMpLIKAwg4kHlHnTv4aL899C4OutIPZ9zQe27SLFFA3AGYfcHzTh4EB7bb6wQCaanXu/hWDjMc+4HZps+oxhstMTPHH+rSY6E92oNXBoX+aJKWnnJq3FVeujT0zrKIF6m90zRj64w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E2e9KkXE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sfw7YyoP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E2e9KkXE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sfw7YyoP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E2E337596;
	Fri, 19 Apr 2024 08:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713516644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cdGjY/gIvdU1vq6vM7H5ha1pIJ5cVzi76HzoEa0I+BQ=;
	b=E2e9KkXEn2MQCgU10L+uQCbo146PAdPTxl4Hmr4kbStsZTELz1k06Iw+mw2G4lpDUAQWp4
	zP0UfxOhwS1UX/6P7dA3Uq3wbe65LMhfibrvo3elY2zq4u9rlkCyzHXOar0px+yD9A8mkz
	WGHBNNwadSTcf0O2ZqT2fxUk+Q4RNx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713516644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cdGjY/gIvdU1vq6vM7H5ha1pIJ5cVzi76HzoEa0I+BQ=;
	b=sfw7YyoPIbwbO93QaeNrIMbZTn2V1seDn2KWDj/mD9C/yMeCHezT5TJDEIxU8c5gYgnk98
	rvu/+EuD+MchT7Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=E2e9KkXE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sfw7YyoP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713516644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cdGjY/gIvdU1vq6vM7H5ha1pIJ5cVzi76HzoEa0I+BQ=;
	b=E2e9KkXEn2MQCgU10L+uQCbo146PAdPTxl4Hmr4kbStsZTELz1k06Iw+mw2G4lpDUAQWp4
	zP0UfxOhwS1UX/6P7dA3Uq3wbe65LMhfibrvo3elY2zq4u9rlkCyzHXOar0px+yD9A8mkz
	WGHBNNwadSTcf0O2ZqT2fxUk+Q4RNx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713516644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cdGjY/gIvdU1vq6vM7H5ha1pIJ5cVzi76HzoEa0I+BQ=;
	b=sfw7YyoPIbwbO93QaeNrIMbZTn2V1seDn2KWDj/mD9C/yMeCHezT5TJDEIxU8c5gYgnk98
	rvu/+EuD+MchT7Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93FCF13687;
	Fri, 19 Apr 2024 08:50:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L4ccJGQwImbrcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Apr 2024 08:50:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3A7E0A0884; Fri, 19 Apr 2024 10:50:44 +0200 (CEST)
Date: Fri, 19 Apr 2024 10:50:44 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] udf: Convert udf_adinicb_readpage() to
 udf_adinicb_read_folio()
Message-ID: <20240419085044.nvhly2makizcogle@quack3>
References: <20240417150416.752929-1-willy@infradead.org>
 <20240417150416.752929-5-willy@infradead.org>
 <20240418105000.inlrq2z666vworuu@quack3>
 <ZiESIMaRHQyaFfFa@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiESIMaRHQyaFfFa@casper.infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9E2E337596
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Thu 18-04-24 13:29:20, Matthew Wilcox wrote:
> On Thu, Apr 18, 2024 at 12:50:00PM +0200, Jan Kara wrote:
> > > -	kaddr = kmap_local_page(page);
> > > -	memcpy(kaddr, iinfo->i_data + iinfo->i_lenEAttr, isize);
> > > -	memset(kaddr + isize, 0, PAGE_SIZE - isize);
> > > -	flush_dcache_page(page);
> > 
> > So where did the flush_dcache_page() call go? AFAIU we should be calling
> > flush_dcache_folio(folio) here, shouldn't we?
> > 
> > > -	SetPageUptodate(page);
> > > -	kunmap_local(kaddr);
> > > +	folio_fill_tail(folio, 0, iinfo->i_data + iinfo->i_lenEAttr, isize);
> > > +	folio_mark_uptodate(folio);
> > >  }
> 
> It's inside folio_zero_tail(), called from folio_fill_tail().

Ah, missed that. Well hidden ;) Thanks for clarification.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

