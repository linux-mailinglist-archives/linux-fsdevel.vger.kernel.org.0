Return-Path: <linux-fsdevel+bounces-6187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB489814A37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 15:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0935C1C24957
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 14:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928F330328;
	Fri, 15 Dec 2023 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="So1itEuk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iBS8k4A1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="So1itEuk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iBS8k4A1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6680B2C6B0;
	Fri, 15 Dec 2023 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C5DB2261D;
	Fri, 15 Dec 2023 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702649694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9rGIZBAj/ZudqVVlhby5XQEzqLM1rUnhm0PltEExyhg=;
	b=So1itEuk4cbDq4+Z0ytr67lbZSZry+Rf/RAe0VItXQP/eJy0gkb6CeQTjreGZ21VtIwW50
	gl4HQjZQwzUSI9NneszNKnOHkASy87D2psWUPKKZZKrvDwYpg+p56YmZg0HvQ7BMuyWSEa
	fSfr6et83NHGYzGoS3Z4kG10gWczMQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702649694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9rGIZBAj/ZudqVVlhby5XQEzqLM1rUnhm0PltEExyhg=;
	b=iBS8k4A1ecJteXNNcdGaAUieR+sg8z0/4Af6fS3MLLLEJISwLF3Mipz7JN1o3n6DS+MzlD
	1WskMnjSntUL29Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702649694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9rGIZBAj/ZudqVVlhby5XQEzqLM1rUnhm0PltEExyhg=;
	b=So1itEuk4cbDq4+Z0ytr67lbZSZry+Rf/RAe0VItXQP/eJy0gkb6CeQTjreGZ21VtIwW50
	gl4HQjZQwzUSI9NneszNKnOHkASy87D2psWUPKKZZKrvDwYpg+p56YmZg0HvQ7BMuyWSEa
	fSfr6et83NHGYzGoS3Z4kG10gWczMQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702649694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9rGIZBAj/ZudqVVlhby5XQEzqLM1rUnhm0PltEExyhg=;
	b=iBS8k4A1ecJteXNNcdGaAUieR+sg8z0/4Af6fS3MLLLEJISwLF3Mipz7JN1o3n6DS+MzlD
	1WskMnjSntUL29Aw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AB0D13BA0;
	Fri, 15 Dec 2023 14:14:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id T8eYAl5ffGXRZwAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 15 Dec 2023 14:14:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 63C54A07E0; Fri, 15 Dec 2023 15:14:45 +0100 (CET)
Date: Fri, 15 Dec 2023 15:14:45 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 02/11] writeback: Factor writeback_get_batch() out of
 write_cache_pages()
Message-ID: <20231215141445.rnt34v6emxulezde@quack3>
References: <20231214132544.376574-1-hch@lst.de>
 <20231214132544.376574-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214132544.376574-3-hch@lst.de>
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=So1itEuk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iBS8k4A1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
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
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[35.36%]
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: 1C5DB2261D
X-Spam-Flag: NO

On Thu 14-12-23 14:25:35, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This simple helper will be the basis of the writeback iterator.
> To make this work, we need to remember the current index
> and end positions in writeback_control.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Just some nits:

> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -81,6 +81,8 @@ struct writeback_control {
>  
>  	/* internal fields used by the ->writepages implementation: */
>  	struct folio_batch fbatch;
> +	pgoff_t index;
> +	pgoff_t end;			/* inclusive */
>  	pgoff_t done_index;

I don't think we need to cache 'end' since it isn't used that much. In
writeback_get_batch() we can just compute it locally as:

	if (wbc->range_cyclic)
		end = -1;
	else
		end = wbc->range_end >> PAGE_SHIFT;

and in the termination condition of the loop we can have it like:

	while (wbc->range_cyclic || index <= wbc->range_end >> PAGE_SHIFT)

Also I don't think we need both done_index and index since they are closely
related and when spread over several functions it gets a bit confusing
what's for what. So I'd just remove done_index, use index instead for
setting writeback_index and just reset 'index' to the desired value in
those two cases where we break out of the loop early and thus index !=
done_index.

I'm sorry for nitpicking about these state variables but IMO reducing their
amount actually makes things easier to verify (and thus maintain) when they
are spread over several functions.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

