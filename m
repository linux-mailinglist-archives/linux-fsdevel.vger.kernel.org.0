Return-Path: <linux-fsdevel+bounces-6513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D81F818E40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 18:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76A21F23381
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 17:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1FA225D9;
	Tue, 19 Dec 2023 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GjngV4fn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8uaGklS/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GjngV4fn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8uaGklS/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F6F2C841;
	Tue, 19 Dec 2023 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AFB2C1F7C1;
	Tue, 19 Dec 2023 17:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703007395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yrWjN6dEMiPl9OOQNdVUh8/ByQtuMHmNLWEAh2asvp4=;
	b=GjngV4fnDPG/ewmB0T/IdRWjXZYoGKT37UFtzdvXcaI4d1X6JZt36xar18VMRFOmIzjMyh
	uF1QmV4zbtqgAdSKgjKuKWGR0Cm1msbtlvv9cIwius/HUVb6jeN1CGMS7nwjdlOUdiBS6L
	2KD2gaFZyK3HUyiu20FTKD5KpdkiaJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703007395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yrWjN6dEMiPl9OOQNdVUh8/ByQtuMHmNLWEAh2asvp4=;
	b=8uaGklS/ME0u/96f8x6eqUh+RX34jTq2gaiWGy4GHi56gtVHSfXZHB7ie3zxlnK+G+EKB8
	DSotUdqwpphw8QDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703007395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yrWjN6dEMiPl9OOQNdVUh8/ByQtuMHmNLWEAh2asvp4=;
	b=GjngV4fnDPG/ewmB0T/IdRWjXZYoGKT37UFtzdvXcaI4d1X6JZt36xar18VMRFOmIzjMyh
	uF1QmV4zbtqgAdSKgjKuKWGR0Cm1msbtlvv9cIwius/HUVb6jeN1CGMS7nwjdlOUdiBS6L
	2KD2gaFZyK3HUyiu20FTKD5KpdkiaJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703007395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yrWjN6dEMiPl9OOQNdVUh8/ByQtuMHmNLWEAh2asvp4=;
	b=8uaGklS/ME0u/96f8x6eqUh+RX34jTq2gaiWGy4GHi56gtVHSfXZHB7ie3zxlnK+G+EKB8
	DSotUdqwpphw8QDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 96D6913B9B;
	Tue, 19 Dec 2023 17:36:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id x4TNJKPUgWXYIQAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 19 Dec 2023 17:36:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2F3DDA07E0; Tue, 19 Dec 2023 18:36:35 +0100 (CET)
Date: Tue, 19 Dec 2023 18:36:35 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] writeback: also update wbc->nr_to_write on
 writeback failure
Message-ID: <20231219173635.hrfs7snikfhcldre@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-3-hch@lst.de>
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GjngV4fn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="8uaGklS/"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.65 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
	 NEURAL_HAM_SHORT(-0.16)[-0.798];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.18)[88.96%]
X-Spam-Score: -5.65
X-Rspamd-Queue-Id: AFB2C1F7C1
X-Spam-Flag: NO

On Mon 18-12-23 16:35:38, Christoph Hellwig wrote:
> When exiting write_cache_pages early due to a non-integrity write
> failure, wbc->nr_to_write currently doesn't account for the folio
> we just failed to write.  This doesn't matter because the callers
> always ingore the value on a failure, but moving the update to
> common code will allow to simply the code, so do it.
			    ^^^ simplify

> Signed-off-by: Christoph Hellwig <hch@lst.de>

Otherwise the patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index b13ea243edb6b2..8e312d73475646 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2473,6 +2473,7 @@ int write_cache_pages(struct address_space *mapping,
>  			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
>  			error = writepage(folio, wbc, data);
>  			nr = folio_nr_pages(folio);
> +			wbc->nr_to_write -= nr;
>  			if (unlikely(error)) {
>  				/*
>  				 * Handle errors according to the type of
> @@ -2506,7 +2507,6 @@ int write_cache_pages(struct address_space *mapping,
>  			 * we tagged for writeback prior to entering this loop.
>  			 */
>  			done_index = folio->index + nr;
> -			wbc->nr_to_write -= nr;
>  			if (wbc->nr_to_write <= 0 &&
>  			    wbc->sync_mode == WB_SYNC_NONE) {
>  				done = 1;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

