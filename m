Return-Path: <linux-fsdevel+bounces-6179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BE581492B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 14:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CE62841E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 13:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B78A2DB8B;
	Fri, 15 Dec 2023 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gNJvKAAF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YHTHxRrf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gNJvKAAF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YHTHxRrf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4A18C2F;
	Fri, 15 Dec 2023 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B259721FA3;
	Fri, 15 Dec 2023 13:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702646799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tq9zADGaqdljmDLOT8it4clHsoh/dCFqwv8EI9ZL3eA=;
	b=gNJvKAAF4tgbYx7L32FAFZXR3Y92PmR7f4QPEFf+rb3IGmc1QGAAsP6HNZa8FKvmoF6GoA
	nl55891gIiVDrStzsvrASU7QOr7h3cAgcMaskLoCAnV8f34CZ3m0hAC+fHrtPrlFLKcjMy
	Bduld3LDJna/5UU7GrRvaSilNVFRyFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702646799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tq9zADGaqdljmDLOT8it4clHsoh/dCFqwv8EI9ZL3eA=;
	b=YHTHxRrfky1iaCK5Tr5cnHsW7rhiZCjuluxBPt4rtHknnYMBBL9zMC3Rh8J7llRLh9tpUZ
	qbUr+mYfDiDE9lDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702646799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tq9zADGaqdljmDLOT8it4clHsoh/dCFqwv8EI9ZL3eA=;
	b=gNJvKAAF4tgbYx7L32FAFZXR3Y92PmR7f4QPEFf+rb3IGmc1QGAAsP6HNZa8FKvmoF6GoA
	nl55891gIiVDrStzsvrASU7QOr7h3cAgcMaskLoCAnV8f34CZ3m0hAC+fHrtPrlFLKcjMy
	Bduld3LDJna/5UU7GrRvaSilNVFRyFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702646799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tq9zADGaqdljmDLOT8it4clHsoh/dCFqwv8EI9ZL3eA=;
	b=YHTHxRrfky1iaCK5Tr5cnHsW7rhiZCjuluxBPt4rtHknnYMBBL9zMC3Rh8J7llRLh9tpUZ
	qbUr+mYfDiDE9lDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A162813912;
	Fri, 15 Dec 2023 13:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id DXxgJw9UfGVkWAAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 15 Dec 2023 13:26:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2FE5DA07E0; Fri, 15 Dec 2023 14:26:39 +0100 (CET)
Date: Fri, 15 Dec 2023 14:26:39 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 01/11] writeback: Factor out writeback_finish()
Message-ID: <20231215132639.ftis3fhmcqkhrpzo@quack3>
References: <20231214132544.376574-1-hch@lst.de>
 <20231214132544.376574-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214132544.376574-2-hch@lst.de>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gNJvKAAF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YHTHxRrf
X-Spam-Score: -2.81
X-Rspamd-Queue-Id: B259721FA3

On Thu 14-12-23 14:25:34, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Instead of having a 'done' variable that controls the nested loops,
> have a writeback_finish() that can be returned directly.  This involves
> keeping more things in writeback_control, but it's just moving stuff
> allocated on the stack to being allocated slightly earlier on the stack.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> [hch: reorder and comment struct writeback_control]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/writeback.h |  8 +++++
>  mm/page-writeback.c       | 72 +++++++++++++++++++++------------------
>  2 files changed, 46 insertions(+), 34 deletions(-)
> 
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 083387c00f0c8b..05e8add4b5ae3c 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -11,6 +11,7 @@
>  #include <linux/flex_proportions.h>
>  #include <linux/backing-dev-defs.h>
>  #include <linux/blk_types.h>
> +#include <linux/pagevec.h>
>  
>  struct bio;
>  
> @@ -40,6 +41,7 @@ enum writeback_sync_modes {
>   * in a manner such that unspecified fields are set to zero.
>   */
>  struct writeback_control {
> +	/* public fields that can be set and/or consumed by the caller: */
>  	long nr_to_write;		/* Write this many pages, and decrement
>  					   this for each page written */
>  	long pages_skipped;		/* Pages which were not written */
> @@ -77,6 +79,12 @@ struct writeback_control {
>  	 */
>  	struct swap_iocb **swap_plug;
>  
> +	/* internal fields used by the ->writepages implementation: */
> +	struct folio_batch fbatch;
> +	pgoff_t done_index;
> +	int err;
> +	unsigned range_whole:1;		/* entire file */

Do we really need the range_whole member here? It is trivially derived from
range_start && range_end and used only in one place in writeback_finish().

> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index ee2fd6a6af4072..45309f3b8193f8 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2360,6 +2360,24 @@ void tag_pages_for_writeback(struct address_space *mapping,
>  }
>  EXPORT_SYMBOL(tag_pages_for_writeback);
>  
> +static int writeback_finish(struct address_space *mapping,
> +		struct writeback_control *wbc, bool done)
> +{
> +	folio_batch_release(&wbc->fbatch);
> +
> +	/*
> +	 * If we hit the last page and there is more work to be done:
> +	 * wrap the index back to the start of the file for the next
> +	 * time we are called.
> +	 */
> +	if (wbc->range_cyclic && !done)
> +		wbc->done_index = 0;
> +	if (wbc->range_cyclic || (wbc->range_whole && wbc->nr_to_write > 0))
> +		mapping->writeback_index = wbc->done_index;
> +
> +	return wbc->err;
> +}

Also I suspect we can get rid of the 'done' argument here. After all it
just controls whether we cycle back to index 0 which we could just
determine as:

	if (wbc->range_cyclic && !wbc->err && wbc->nr_to_write > 0) {
		WARN_ON_ONCE(wbc->sync_mode != WB_SYNC_NONE);
		wbc->done_index = 0;
	}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

