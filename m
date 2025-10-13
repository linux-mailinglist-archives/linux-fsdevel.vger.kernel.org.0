Return-Path: <linux-fsdevel+bounces-63952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE88BD2DFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 13:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A1884EE430
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 11:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2502E263C8F;
	Mon, 13 Oct 2025 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YMlz/os4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ETy4GHph";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YMlz/os4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ETy4GHph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268F81E5B95
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356773; cv=none; b=gQX4eUK4dqZfSMF2HV3vbrIyEbJfjiqRsVk0sSXoYXotX06xgkEtMyr2IR1Tgif4Wamk9+9Hq8V7gEodmM87t4umMXMo611CqLJAEA9wJ1Ct2eKKQkrUiyEeuUhzkYK+BxYeGwSVYnWOVOxTOrajOS4U8OlKIoRfzg4Dkr652yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356773; c=relaxed/simple;
	bh=yHAd0tNRbozztQPcdE+l+S0sipojyf3AkohHqkb2Ov4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSNsr5Q6RYn5HFBmr7QK9X7NtDGgxALj2CirE7iIW3SOKtyzHR+W3NcHiMJ19w86jRxpMuXsBCT2T0uPae/4RrZqaz9rIa7HTLFdkiFs+BJ+J1fSb86hLkGRLZk5o7ZNPZs+JK1uBaTIUHSxquFp0cV+SX0FS+xUbPK/eXFvXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YMlz/os4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ETy4GHph; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YMlz/os4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ETy4GHph; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54C23219BD;
	Mon, 13 Oct 2025 11:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760356770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=65YchmjaU4/afzOfYncGWxSpSpwMbIPUmdJHCVAQsJ0=;
	b=YMlz/os4GFl2vtP8mwGeoXm53hLwLCPEJblsob3IQxrWvk+OWwIKLj17v74P4CEvJ/VUe/
	+HVTKDtjX5NLglP0DFaoInVjGEEXfvUZM+HuS062SmrD9yAkwXMRPnBufJ7/CNHymNduLc
	l/RKCSzWDL81YSqHCvLNnFErKyCGxBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760356770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=65YchmjaU4/afzOfYncGWxSpSpwMbIPUmdJHCVAQsJ0=;
	b=ETy4GHphA8RJlkrrbZSA96ohF2idrC1LMJa2vT6HKHXqrWGzgPNhdSWb9Hxj2v1fxt4gDY
	P5DFm6ew9cL4HuDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="YMlz/os4";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ETy4GHph
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760356770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=65YchmjaU4/afzOfYncGWxSpSpwMbIPUmdJHCVAQsJ0=;
	b=YMlz/os4GFl2vtP8mwGeoXm53hLwLCPEJblsob3IQxrWvk+OWwIKLj17v74P4CEvJ/VUe/
	+HVTKDtjX5NLglP0DFaoInVjGEEXfvUZM+HuS062SmrD9yAkwXMRPnBufJ7/CNHymNduLc
	l/RKCSzWDL81YSqHCvLNnFErKyCGxBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760356770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=65YchmjaU4/afzOfYncGWxSpSpwMbIPUmdJHCVAQsJ0=;
	b=ETy4GHphA8RJlkrrbZSA96ohF2idrC1LMJa2vT6HKHXqrWGzgPNhdSWb9Hxj2v1fxt4gDY
	P5DFm6ew9cL4HuDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4827E13874;
	Mon, 13 Oct 2025 11:59:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OmSbEaLp7Gj9AgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Oct 2025 11:59:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E4B13A0A58; Mon, 13 Oct 2025 13:59:21 +0200 (CEST)
Date: Mon, 13 Oct 2025 13:59:21 +0200
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
Subject: Re: [PATCH 07/10] mm: remove __filemap_fdatawrite
Message-ID: <t4y7xtgfnzfpfupnb7on33n6qzrfxfphsm2hqsa5rx4liqvvbc@wwj7ckhyilpo>
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013025808.4111128-8-hch@lst.de>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 54C23219BD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,lst.de:email,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Mon 13-10-25 11:58:02, Christoph Hellwig wrote:
> And rewrite filemap_fdatawrite to use filemap_fdatawrite_range instead
> to have a simpler call chain.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

...

>  int filemap_fdatawrite(struct address_space *mapping)
>  {
> -	return __filemap_fdatawrite(mapping, WB_SYNC_ALL);
> +	return filemap_fdatawrite_range(mapping, 0, LONG_MAX);

As Damien pointed out, here should be LLONG_MAX.


> @@ -470,7 +464,7 @@ EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
>   */
>  int filemap_flush(struct address_space *mapping)
>  {
> -	return __filemap_fdatawrite(mapping, WB_SYNC_NONE);
> +	return filemap_fdatawrite_range_kick(mapping, 0, LLONG_MAX);
>  }
>  EXPORT_SYMBOL(filemap_flush);

filemap_fdatawrite_range_kick() doesn't exist at this point in the series.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

