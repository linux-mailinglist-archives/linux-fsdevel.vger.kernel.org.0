Return-Path: <linux-fsdevel+bounces-9515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF0B84208F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 11:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6261F2BBA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 10:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5603679EF;
	Tue, 30 Jan 2024 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vVZFDbYX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n/MERs5t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vVZFDbYX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n/MERs5t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E8679E8;
	Tue, 30 Jan 2024 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608991; cv=none; b=YRh9vZWAAHFzXowcNDI0b5Js6FzuBVtEZ/tSqlxyENay1Wd07phzrwlog0NkeAl0I6EFda0/RDEoAnw0tHPmKohGg08BiuB78IZALgBOKOWB9Kp24mxy53eSM2t/V1rPe2SZmnJ9ujnN/oM06co2HiNyQyqf/9IbIAS0s+eeubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608991; c=relaxed/simple;
	bh=IkKzQEXnXlwjhWZFN3oqHoe3HVv0pAR2z5vY4PVRLYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmBXAxkIqLap/Ad+V0hMIqf0WdC6/sDudtXtRmt4zIptrIyB+abma8toyuMdk33u51TTs9f6RrfuPlh1OQFivdskdjpmVq9PbLHT8rvFDwE+YETnKCRK1qNkbGL0Kn1aUyMkqYJTp4nEBhH6GW4kxbGsbi08MZxqULEpnYOGzjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vVZFDbYX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n/MERs5t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vVZFDbYX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n/MERs5t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9C9FD1F83F;
	Tue, 30 Jan 2024 10:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706608987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ypvJnXvVjmaayelrbx9cC9PI4eHdK+C4dtVzpiZqLQ4=;
	b=vVZFDbYX2wN/3NIyMU5Mb/zYfjArt0R1NdLgrRwS3sMURrlNf2A37D82b9XAdKCmjs7wF4
	wpLrRvpwHJSu4lLfIrm8JehI8cFJpQhC9lhShY4VVrSTceLWFs21FtoUAvS1Mlnv7uaNi3
	qIJoFKAwnNja2OGNOKTCpSfrNzvvIa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706608987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ypvJnXvVjmaayelrbx9cC9PI4eHdK+C4dtVzpiZqLQ4=;
	b=n/MERs5tRa7fMRqwi43Nhw143nMxUdTx1DsOb2d1LYDAMF2UgoTh1FS8GACB9h52YQ43a7
	w6raW35bJ59zKIAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706608987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ypvJnXvVjmaayelrbx9cC9PI4eHdK+C4dtVzpiZqLQ4=;
	b=vVZFDbYX2wN/3NIyMU5Mb/zYfjArt0R1NdLgrRwS3sMURrlNf2A37D82b9XAdKCmjs7wF4
	wpLrRvpwHJSu4lLfIrm8JehI8cFJpQhC9lhShY4VVrSTceLWFs21FtoUAvS1Mlnv7uaNi3
	qIJoFKAwnNja2OGNOKTCpSfrNzvvIa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706608987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ypvJnXvVjmaayelrbx9cC9PI4eHdK+C4dtVzpiZqLQ4=;
	b=n/MERs5tRa7fMRqwi43Nhw143nMxUdTx1DsOb2d1LYDAMF2UgoTh1FS8GACB9h52YQ43a7
	w6raW35bJ59zKIAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DABC13462;
	Tue, 30 Jan 2024 10:03:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Z7anHlvJuGXocgAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 30 Jan 2024 10:03:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1C92CA0807; Tue, 30 Jan 2024 11:03:07 +0100 (CET)
Date: Tue, 30 Jan 2024 11:03:07 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/19] iomap: Convert iomap_writepages() to use
 for_each_writeback_folio()
Message-ID: <20240130100307.5ub22s5ajanqstp6@quack3>
References: <20240125085758.2393327-1-hch@lst.de>
 <20240125085758.2393327-19-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125085758.2393327-19-hch@lst.de>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vVZFDbYX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="n/MERs5t"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.cz:dkim,suse.cz:email,infradead.org:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 9C9FD1F83F
X-Spam-Flag: NO

On Thu 25-01-24 09:57:57, Christoph Hellwig wrote:
> From: Matthew Wilcox <willy@infradead.org>
> 
> This removes one indirect function call per folio, and adds typesafety
> by not casting through a void pointer.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/iomap/buffered-io.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 093c4515b22a53..58b3661f5eac9e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1887,9 +1887,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>   * regular allocated space.
>   */
>  static int iomap_do_writepage(struct folio *folio,
> -		struct writeback_control *wbc, void *data)
> +		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc)
>  {
> -	struct iomap_writepage_ctx *wpc = data;
>  	struct inode *inode = folio->mapping->host;
>  	u64 end_pos, isize;
>  
> @@ -1986,10 +1985,12 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>  		struct iomap_writepage_ctx *wpc,
>  		const struct iomap_writeback_ops *ops)
>  {
> -	int			ret;
> +	struct folio *folio;
> +	int ret;
>  
>  	wpc->ops = ops;
> -	ret = write_cache_pages(mapping, wbc, iomap_do_writepage, wpc);
> +	for_each_writeback_folio(mapping, wbc, folio, ret)
> +		ret = iomap_do_writepage(folio, wbc, wpc);
>  	if (!wpc->ioend)
>  		return ret;
>  	return iomap_submit_ioend(wpc, wpc->ioend, ret);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

