Return-Path: <linux-fsdevel+bounces-6666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 285A681B4CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2492283FF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6DF6BB47;
	Thu, 21 Dec 2023 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kMpzL+ie";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p2fc/wre";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kMpzL+ie";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p2fc/wre"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FFE34555;
	Thu, 21 Dec 2023 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3D9721DC8;
	Thu, 21 Dec 2023 11:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703157726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pi7hRIwpboX5Xu7y0qd/z2bmAu98D1+xyAumfJmNvK4=;
	b=kMpzL+ie++zLwCkwHGBQZ0WX2Gtuv7hgYuCZ0BhNBsVV6zvtNObGFQIrhNqcX+IvGwC9gy
	WbJkETUtT9ZHa3nSXEF2fsB5ByEnOTO6SDIzSYPs3INMzBSLMvPlqqVy50lOjwrBuM2rP6
	vApsEVVPzlqlu6597SCPrUsb3b86M3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703157726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pi7hRIwpboX5Xu7y0qd/z2bmAu98D1+xyAumfJmNvK4=;
	b=p2fc/wreu6wuPV676GJ09229hWhN15CuWbvMvuLxXIG/cGFw5zxXYvdFQIAJu+M5o1hu49
	8+WjvyTVxHRH8KBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703157726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pi7hRIwpboX5Xu7y0qd/z2bmAu98D1+xyAumfJmNvK4=;
	b=kMpzL+ie++zLwCkwHGBQZ0WX2Gtuv7hgYuCZ0BhNBsVV6zvtNObGFQIrhNqcX+IvGwC9gy
	WbJkETUtT9ZHa3nSXEF2fsB5ByEnOTO6SDIzSYPs3INMzBSLMvPlqqVy50lOjwrBuM2rP6
	vApsEVVPzlqlu6597SCPrUsb3b86M3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703157726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pi7hRIwpboX5Xu7y0qd/z2bmAu98D1+xyAumfJmNvK4=;
	b=p2fc/wreu6wuPV676GJ09229hWhN15CuWbvMvuLxXIG/cGFw5zxXYvdFQIAJu+M5o1hu49
	8+WjvyTVxHRH8KBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7E7113725;
	Thu, 21 Dec 2023 11:22:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GpX7KN4fhGVmWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 11:22:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5C2B6A07E3; Thu, 21 Dec 2023 12:22:06 +0100 (CET)
Date: Thu, 21 Dec 2023 12:22:06 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/17] writeback: Factor should_writeback_folio() out of
 write_cache_pages()
Message-ID: <20231221112206.f6biqpkpwl6w64mo@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-9-hch@lst.de>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.89 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.08)[95.51%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,lst.de:email,infradead.org:email];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kMpzL+ie;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="p2fc/wre"
X-Spam-Score: -1.89
X-Rspamd-Queue-Id: B3D9721DC8

On Mon 18-12-23 16:35:44, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Reduce write_cache_pages() by about 30 lines; much of it is commentary,
> but it all bundles nicely into an obvious function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

One nit below, otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> +static bool should_writeback_folio(struct address_space *mapping,
> +		struct writeback_control *wbc, struct folio *folio)
> +{

I'd call this function folio_prepare_writeback() or something like that to
make it clearer that this function is not only about the decision whether
we want to write folio or not but we also clear the dirty bit &
writeprotect the folio in page tables.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

