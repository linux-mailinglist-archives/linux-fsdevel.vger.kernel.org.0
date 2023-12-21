Return-Path: <linux-fsdevel+bounces-6661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2530881B48C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860AB1F25C84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 10:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCFC6AB9A;
	Thu, 21 Dec 2023 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dYXJRTOF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jotvAD5S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sdHrz2rS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ANYb3JrT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C170F6A02D;
	Thu, 21 Dec 2023 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2EA021C5E;
	Thu, 21 Dec 2023 10:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703156379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9lr7w1qfXBqyv9nqbmtcLJAQk34Gbv+KRr+izpr/xd4=;
	b=dYXJRTOFpDduwZofbTStEhhIllBr0x/tOq5sQQNppYoKHnXxQldv7dfNTb0gX8u0L2t/Mn
	OToUxz14MtCjBRf7KNIIrCh1IOKghOo8WlW++4FZN1lvsfO5Rs86zqtAGy7PZULvGbpxiB
	+RVoepx00ZsNS/Sa+Mi0rTMab3ddm1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703156379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9lr7w1qfXBqyv9nqbmtcLJAQk34Gbv+KRr+izpr/xd4=;
	b=jotvAD5Sup4uY5AoS+xXzCOomowB1BTS9w69zmXvvaBdt+G/2ebz4lkN6b7rHlMwLGBcl0
	huaOENkpkgH6XzDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703156378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9lr7w1qfXBqyv9nqbmtcLJAQk34Gbv+KRr+izpr/xd4=;
	b=sdHrz2rSXSmj5jlM9KoOqHJeqUTm6rf+GsHhoGSgaTkEvG8Q5X8BiOqQuQR34AVfFc82BR
	3zX4z0UNNG1rt6Olj0CPEy++M8WkJ+5UT4NIXlYquNU/GvUojr3nvWdzgkwiU4tMuYzg1b
	oceB3osZ8pgTbUVwTMBkn/yq6AkvXX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703156378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9lr7w1qfXBqyv9nqbmtcLJAQk34Gbv+KRr+izpr/xd4=;
	b=ANYb3JrT2fsxz4GV0aZdJApHl1LzLqxQgp8pyoy7vl0IrT6OYSAj/giYN8Gs/mSci7HCA0
	z3eUrrmvd50A2WAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8A0513725;
	Thu, 21 Dec 2023 10:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rj8PLZoahGUxUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 10:59:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5BB51A07E3; Thu, 21 Dec 2023 11:59:34 +0100 (CET)
Date: Thu, 21 Dec 2023 11:59:34 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/17] writeback: only update ->writeback_index for
 range_cyclic writeback
Message-ID: <20231221105934.6bhdl73siuu3fct6@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-5-hch@lst.de>
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.com:email,suse.cz:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.60
X-Spam-Flag: NO

On Mon 18-12-23 16:35:40, Christoph Hellwig wrote:
> mapping->writeback_index is only [1] used as the starting point for
> range_cyclic writeback, so there is no point in updating it for other
> types of writeback.
> 
> [1] except for btrfs_defrag_file which does really odd things with
> mapping->writeback_index.  But btrfs doesn't use write_cache_pages at
> all, so this isn't relevant here.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 7ed6c2bc8dd51c..c798c0d6d0abb4 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2403,7 +2403,6 @@ int write_cache_pages(struct address_space *mapping,
>  	pgoff_t index;
>  	pgoff_t end;		/* Inclusive */
>  	pgoff_t done_index;
> -	int range_whole = 0;
>  	xa_mark_t tag;
>  
>  	folio_batch_init(&fbatch);
> @@ -2413,8 +2412,6 @@ int write_cache_pages(struct address_space *mapping,
>  	} else {
>  		index = wbc->range_start >> PAGE_SHIFT;
>  		end = wbc->range_end >> PAGE_SHIFT;
> -		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
> -			range_whole = 1;
>  	}
>  	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
>  		tag_pages_for_writeback(mapping, index, end);
> @@ -2514,14 +2511,21 @@ int write_cache_pages(struct address_space *mapping,
>  	}
>  
>  	/*
> -	 * If we hit the last page and there is more work to be done: wrap
> -	 * back the index back to the start of the file for the next
> -	 * time we are called.
> +	 * For range cyclic writeback we need to remember where we stopped so
> +	 * that we can continue there next time we are called.  If  we hit the
> +	 * last page and there is more work to be done, wrap back to the start
> +	 * of the file.
> +	 *
> +	 * For non-cyclic writeback we always start looking up at the beginning
> +	 * of the file if we are called again, which can only happen due to
> +	 * -ENOMEM from the file system.
>  	 */
> -	if (wbc->range_cyclic && !done)
> -		done_index = 0;
> -	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
> -		mapping->writeback_index = done_index;
> +	if (wbc->range_cyclic) {
> +		if (done)
> +			mapping->writeback_index = done_index;
> +		else
> +			mapping->writeback_index = 0;
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

