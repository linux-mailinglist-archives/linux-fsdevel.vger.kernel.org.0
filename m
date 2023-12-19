Return-Path: <linux-fsdevel+bounces-6512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7616818E38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 18:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E58286236
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25323374FF;
	Tue, 19 Dec 2023 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JJtCW6a8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5IB12f7P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JJtCW6a8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5IB12f7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1BF374CF;
	Tue, 19 Dec 2023 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C509921E99;
	Tue, 19 Dec 2023 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703007209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3dL7h8ceV7aXiO27Scimg+YoS9afC6qEOpXAa9fm794=;
	b=JJtCW6a8tG0oX5QaOWF3s38dZD9xtqLQjTHPXsicLVMtYhK9LFoSINWPxWdM7Ri4OCgTtL
	kdomvY9IuAnrDmOOzP5tj+Eio/HKEwnHF2LAFVdpFVxj2U2mlkmFaN/4W/pPMz1+pq/q+K
	h7ZFM/eLFSz9pMglmpOVBTvkqRdelvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703007209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3dL7h8ceV7aXiO27Scimg+YoS9afC6qEOpXAa9fm794=;
	b=5IB12f7Pqb/iD32Pjj++IGNtIH3KhdJ/RDFA8nNOnZpPJmZtJck+fn+fIAl5xsvxE67JcC
	VRxiEfIISuBoajBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703007209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3dL7h8ceV7aXiO27Scimg+YoS9afC6qEOpXAa9fm794=;
	b=JJtCW6a8tG0oX5QaOWF3s38dZD9xtqLQjTHPXsicLVMtYhK9LFoSINWPxWdM7Ri4OCgTtL
	kdomvY9IuAnrDmOOzP5tj+Eio/HKEwnHF2LAFVdpFVxj2U2mlkmFaN/4W/pPMz1+pq/q+K
	h7ZFM/eLFSz9pMglmpOVBTvkqRdelvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703007209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3dL7h8ceV7aXiO27Scimg+YoS9afC6qEOpXAa9fm794=;
	b=5IB12f7Pqb/iD32Pjj++IGNtIH3KhdJ/RDFA8nNOnZpPJmZtJck+fn+fIAl5xsvxE67JcC
	VRxiEfIISuBoajBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B46CC13B9B;
	Tue, 19 Dec 2023 17:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id L9pfK+nTgWXpIAAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 19 Dec 2023 17:33:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 64E84A07E0; Tue, 19 Dec 2023 18:33:29 +0100 (CET)
Date: Tue, 19 Dec 2023 18:33:29 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] writeback: fix done_index when hitting the
 wbc->nr_to_write
Message-ID: <20231219173329.wp6v4y5637wavnba@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-2-hch@lst.de>
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-2.17 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.57)[98.10%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.17
X-Spam-Flag: NO

On Mon 18-12-23 16:35:37, Christoph Hellwig wrote:
> When write_cache_pages finishes writing out a folio, it fails to update
> done_inde to account for the number of pages in the folio just written.
  ^^^ done_index

> That means when range_cyclic writeback is restarted, it will be
> restarted at this folio instead of after it as it should.  Fix that
> by updating done_index before breaking out of the loop.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Otherwise looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index ee2fd6a6af4072..b13ea243edb6b2 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2505,6 +2505,7 @@ int write_cache_pages(struct address_space *mapping,
>  			 * keep going until we have written all the pages
>  			 * we tagged for writeback prior to entering this loop.
>  			 */
> +			done_index = folio->index + nr;
>  			wbc->nr_to_write -= nr;
>  			if (wbc->nr_to_write <= 0 &&
>  			    wbc->sync_mode == WB_SYNC_NONE) {
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

