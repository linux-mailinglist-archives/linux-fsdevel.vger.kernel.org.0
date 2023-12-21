Return-Path: <linux-fsdevel+bounces-6676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B86981B556
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DBF281EE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484026E2C2;
	Thu, 21 Dec 2023 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FaC/jpxL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tDOhWt+0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FaC/jpxL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tDOhWt+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE956A02A;
	Thu, 21 Dec 2023 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75BDC1FB73;
	Thu, 21 Dec 2023 11:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703159677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2M7C0GoB7X8XAnxaAgw9zOcBEuLiI+H/k44O2aeGnkY=;
	b=FaC/jpxLTx/SFyAVWKmjOvXA97rWeI26wRgraGOiIvumbUYeYgm8HnDW+GaZfRAD+3K13G
	70RzarMo/xBV8tlymkKoirCLoG+QX1to/RLOkqLeZEdLh/uU5X0cwCDxTtTF+orwDRgl2P
	5wClfvEV0WUHZILqkwO5CWHtDsXYsbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703159677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2M7C0GoB7X8XAnxaAgw9zOcBEuLiI+H/k44O2aeGnkY=;
	b=tDOhWt+0l/bQ27UXfO4HoW7dToZgy13cJ2qKXi8v0qGC9cg3XscO1pobNP7+VUNSk2vDV0
	i/2sgKfIazW7QzCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703159677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2M7C0GoB7X8XAnxaAgw9zOcBEuLiI+H/k44O2aeGnkY=;
	b=FaC/jpxLTx/SFyAVWKmjOvXA97rWeI26wRgraGOiIvumbUYeYgm8HnDW+GaZfRAD+3K13G
	70RzarMo/xBV8tlymkKoirCLoG+QX1to/RLOkqLeZEdLh/uU5X0cwCDxTtTF+orwDRgl2P
	5wClfvEV0WUHZILqkwO5CWHtDsXYsbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703159677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2M7C0GoB7X8XAnxaAgw9zOcBEuLiI+H/k44O2aeGnkY=;
	b=tDOhWt+0l/bQ27UXfO4HoW7dToZgy13cJ2qKXi8v0qGC9cg3XscO1pobNP7+VUNSk2vDV0
	i/2sgKfIazW7QzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A1A113AB5;
	Thu, 21 Dec 2023 11:54:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F3/iGX0nhGVEZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 11:54:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2D5BBA07E3; Thu, 21 Dec 2023 12:54:37 +0100 (CET)
Date: Thu, 21 Dec 2023 12:54:37 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] writeback: update the kerneldoc comment for
 tag_pages_for_writeback
Message-ID: <20231221115437.nyxxipfyezn6jrzt@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-18-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-18-hch@lst.de>
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -2.60
X-Spam-Flag: NO

On Mon 18-12-23 16:35:53, Christoph Hellwig wrote:
> Don't refer to write_cache_pages, which now is just a wrapper for the
> writeback iterator.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index d3c2c78e0c67ce..bc69044fd063e8 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2325,18 +2325,18 @@ void __init page_writeback_init(void)
>  }
>  
>  /**
> - * tag_pages_for_writeback - tag pages to be written by write_cache_pages
> + * tag_pages_for_writeback - tag pages to be written by writeback
>   * @mapping: address space structure to write
>   * @start: starting page index
>   * @end: ending page index (inclusive)
>   *
>   * This function scans the page range from @start to @end (inclusive) and tags
> - * all pages that have DIRTY tag set with a special TOWRITE tag. The idea is
> - * that write_cache_pages (or whoever calls this function) will then use
> - * TOWRITE tag to identify pages eligible for writeback.  This mechanism is
> - * used to avoid livelocking of writeback by a process steadily creating new
> - * dirty pages in the file (thus it is important for this function to be quick
> - * so that it can tag pages faster than a dirtying process can create them).
> + * all pages that have DIRTY tag set with a special TOWRITE tag.  The caller
> + * can then use the TOWRITE tag to identify pages eligible for writeback.
> + * This mechanism is used to avoid livelocking of writeback by a process
> + * steadily creating new dirty pages in the file (thus it is important for this
> + * function to be quick so that it can tag pages faster than a dirtying process
> + * can create them).
>   */
>  void tag_pages_for_writeback(struct address_space *mapping,
>  			     pgoff_t start, pgoff_t end)
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

