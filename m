Return-Path: <linux-fsdevel+bounces-30865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE7F98EEDC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F7B2847A8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 12:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38E416F8E9;
	Thu,  3 Oct 2024 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XHlOASG1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FLB2yonR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XHlOASG1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FLB2yonR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A3F16C6A7;
	Thu,  3 Oct 2024 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957593; cv=none; b=Y8En0Eqk8uA5FSo+o5ijPoctDhJAvEFkNHf9vX3z/HZ9oxaMPRDxO7OLL9zUXdqqhuMJJtvzvWGK8tWtLybk5sFSMlahCYrC4vrZxTXdkG5K79FLnbSPTCbqgkcAWcI0thyKdCTKxjvCBfMhr4DTT8M8LsvsiBySQEl9uqQFtk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957593; c=relaxed/simple;
	bh=ZJIsPxUxCakaPDnQQGQAClJ/pXQL3cD6sbEbl4qM8L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JU2ho9cr0Prgv13wlDUNTRkK+Zajnyt9iRHkEnQpRtiJ1zYLjbzP2G/riFeL/mDa4e6Uk4K/UIZ0U15qNBEMEvrGdjiNOpP5zXh9mc+j3tQ7HTFOpcU0LZexmRsc1RvOBqT/l9sCAKGVyXgVwBN+J4min5v1lcn/PHdXPVMRxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XHlOASG1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FLB2yonR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XHlOASG1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FLB2yonR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65D3B21C03;
	Thu,  3 Oct 2024 12:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727957589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YmDERVK5Bjc/XeyReSYqm539EjnZa14Ik4KdwHWDMhA=;
	b=XHlOASG1XtOXjH9Ll6eRj7NR60sQUaktDbEdmUb2GBrh5e1Vn5NMKWXh3cG0Vb4LF+wa/W
	v9+OIwmg3CDOKupnArecYb48DZMzNM6zXh6J2JPRNAdUaSSbiL+nHPnbEd5AlP8Yt7sGxX
	+plBcN7tmjOB+qF2ThHL8loAeB0AH2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727957589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YmDERVK5Bjc/XeyReSYqm539EjnZa14Ik4KdwHWDMhA=;
	b=FLB2yonRDGwAdDIY9qTyqPWbywTauirq+ZYTd+3+CEPo8E9U+ysqhRSFmBjHOVxENQq5aP
	Mucg9UAU4w3mUrDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XHlOASG1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FLB2yonR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727957589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YmDERVK5Bjc/XeyReSYqm539EjnZa14Ik4KdwHWDMhA=;
	b=XHlOASG1XtOXjH9Ll6eRj7NR60sQUaktDbEdmUb2GBrh5e1Vn5NMKWXh3cG0Vb4LF+wa/W
	v9+OIwmg3CDOKupnArecYb48DZMzNM6zXh6J2JPRNAdUaSSbiL+nHPnbEd5AlP8Yt7sGxX
	+plBcN7tmjOB+qF2ThHL8loAeB0AH2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727957589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YmDERVK5Bjc/XeyReSYqm539EjnZa14Ik4KdwHWDMhA=;
	b=FLB2yonRDGwAdDIY9qTyqPWbywTauirq+ZYTd+3+CEPo8E9U+ysqhRSFmBjHOVxENQq5aP
	Mucg9UAU4w3mUrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5905B13882;
	Thu,  3 Oct 2024 12:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HJi6FVWK/mbYIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Oct 2024 12:13:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E9ECA086F; Thu,  3 Oct 2024 14:13:05 +0200 (CEST)
Date: Thu, 3 Oct 2024 14:13:04 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 6/6] migrate: Remove references to Private2
Message-ID: <20241003121304.fhrjs5ocuzyqbemk@quack3>
References: <20241002040111.1023018-1-willy@infradead.org>
 <20241002040111.1023018-7-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002040111.1023018-7-willy@infradead.org>
X-Rspamd-Queue-Id: 65D3B21C03
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,infradead.org:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 02-10-24 05:01:08, Matthew Wilcox (Oracle) wrote:
> These comments are now stale; rewrite them.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/migrate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index df91248755e4..21264c24a404 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -472,7 +472,7 @@ static int folio_expected_refs(struct address_space *mapping,
>   * The number of remaining references must be:
>   * 1 for anonymous folios without a mapping
>   * 2 for folios with a mapping
> - * 3 for folios with a mapping and PagePrivate/PagePrivate2 set.
> + * 3 for folios with a mapping and the private flag set.
>   */
>  static int __folio_migrate_mapping(struct address_space *mapping,
>  		struct folio *newfolio, struct folio *folio, int expected_count)
> @@ -786,7 +786,7 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
>   * @mode: How to migrate the page.
>   *
>   * Common logic to directly migrate a single LRU folio suitable for
> - * folios that do not use PagePrivate/PagePrivate2.
> + * folios that do not have private data.
>   *
>   * Folios are locked upon entry and exit.
>   */
> -- 
> 2.43.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

