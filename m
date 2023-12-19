Return-Path: <linux-fsdevel+bounces-6518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D4A818FC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 19:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFA2287B0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 18:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61AA37D32;
	Tue, 19 Dec 2023 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yJkIpqLj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ND3r4peh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yJkIpqLj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ND3r4peh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4830E37D17;
	Tue, 19 Dec 2023 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4485E22168;
	Tue, 19 Dec 2023 18:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703010432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wwwn4EPAgSsB+knSVTXoG3tIQt4g4UOJHmQAEbH/lw=;
	b=yJkIpqLjMNi3Dj3rOmN1hIIVyNJGeRo9IEl/0PXk6uIc8ickQFNyOdAXckJE/lFFWzei68
	jiA+UhucvHxP77vqPKCX8yefHPJHw8ectoRREJB55q4/rsRoJ8ke/SsTvNCmV35SBskjk5
	rXzGAyu9OpT1jPMTJtGplFMM4NaUK4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703010432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wwwn4EPAgSsB+knSVTXoG3tIQt4g4UOJHmQAEbH/lw=;
	b=ND3r4peh60mJqstnuduW+WeCtT/aPlEPjUdS5JlHdaX3N5OAzE8MHokT63Kk2/8lyRIO1q
	5Ct13LGe8WOshGCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703010432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wwwn4EPAgSsB+knSVTXoG3tIQt4g4UOJHmQAEbH/lw=;
	b=yJkIpqLjMNi3Dj3rOmN1hIIVyNJGeRo9IEl/0PXk6uIc8ickQFNyOdAXckJE/lFFWzei68
	jiA+UhucvHxP77vqPKCX8yefHPJHw8ectoRREJB55q4/rsRoJ8ke/SsTvNCmV35SBskjk5
	rXzGAyu9OpT1jPMTJtGplFMM4NaUK4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703010432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wwwn4EPAgSsB+knSVTXoG3tIQt4g4UOJHmQAEbH/lw=;
	b=ND3r4peh60mJqstnuduW+WeCtT/aPlEPjUdS5JlHdaX3N5OAzE8MHokT63Kk2/8lyRIO1q
	5Ct13LGe8WOshGCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3207A13BF1;
	Tue, 19 Dec 2023 18:27:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id byzsC4DggWVLLgAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 19 Dec 2023 18:27:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 790E5A07E0; Tue, 19 Dec 2023 19:27:11 +0100 (CET)
Date: Tue, 19 Dec 2023 19:27:11 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] writeback: rework the loop termination condition
 in write_cache_pages
Message-ID: <20231219182711.oskwl65vdctbpsxe@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-4-hch@lst.de>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Mon 18-12-23 16:35:39, Christoph Hellwig wrote:
> Rework we deal with the cleanup after the writepage call.  First handle
        ^^ the way

> the magic AOP_WRITEPAGE_ACTIVATE separately from real error returns to
> get it out of the way of the actual error handling.  Then merge the
> code to set ret for integrity vs non-integrity writeback.  For
> non-integrity writeback the loop is terminated on the first error, so
> ret will never be non-zero.  Then use a single block to check for
> non-integrity writewack to consolidate the cases where it returns for
> either an error or running off the end of nr_to_write.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Otherwise looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 62 +++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 33 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 8e312d73475646..7ed6c2bc8dd51c 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2474,43 +2474,39 @@ int write_cache_pages(struct address_space *mapping,
>  			error = writepage(folio, wbc, data);
>  			nr = folio_nr_pages(folio);
>  			wbc->nr_to_write -= nr;
> -			if (unlikely(error)) {
> -				/*
> -				 * Handle errors according to the type of
> -				 * writeback. There's no need to continue for
> -				 * background writeback. Just push done_index
> -				 * past this page so media errors won't choke
> -				 * writeout for the entire file. For integrity
> -				 * writeback, we must process the entire dirty
> -				 * set regardless of errors because the fs may
> -				 * still have state to clear for each page. In
> -				 * that case we continue processing and return
> -				 * the first error.
> -				 */
> -				if (error == AOP_WRITEPAGE_ACTIVATE) {
> -					folio_unlock(folio);
> -					error = 0;
> -				} else if (wbc->sync_mode != WB_SYNC_ALL) {
> -					ret = error;
> -					done_index = folio->index + nr;
> -					done = 1;
> -					break;
> -				}
> -				if (!ret)
> -					ret = error;
> +
> +			/*
> +			 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return
> +			 * value.  Eventually all instances should just unlock
> +			 * the folio themselves and return 0;
> +			 */
> +			if (error == AOP_WRITEPAGE_ACTIVATE) {
> +				folio_unlock(folio);
> +				error = 0;
>  			}
>  
>  			/*
> -			 * We stop writing back only if we are not doing
> -			 * integrity sync. In case of integrity sync we have to
> -			 * keep going until we have written all the pages
> -			 * we tagged for writeback prior to entering this loop.
> +			 * For integrity sync  we have to keep going until we
> +			 * have written all the folios we tagged for writeback
> +			 * prior to entering this loop, even if we run past
> +			 * wbc->nr_to_write or encounter errors.  This is
> +			 * because the file system may still have state to clear
> +			 * for each folio.   We'll eventually return the first
> +			 * error encountered.
> +			 *
> +			 * For background writeback just push done_index past
> +			 * this folio so that we can just restart where we left
> +			 * off and media errors won't choke writeout for the
> +			 * entire file.
>  			 */
> -			done_index = folio->index + nr;
> -			if (wbc->nr_to_write <= 0 &&
> -			    wbc->sync_mode == WB_SYNC_NONE) {
> -				done = 1;
> -				break;
> +			if (error && !ret)
> +				ret = error;
> +			if (wbc->sync_mode == WB_SYNC_NONE) {
> +				if (ret || wbc->nr_to_write <= 0) {
> +					done_index = folio->index + nr;
> +					done = 1;
> +					break;
> +				}
>  			}
>  		}
>  		folio_batch_release(&fbatch);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

