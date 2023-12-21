Return-Path: <linux-fsdevel+bounces-6668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C07B181B4DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D99B1F252E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C216BB59;
	Thu, 21 Dec 2023 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o5lLzhrY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VeHvaUqg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o5lLzhrY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VeHvaUqg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDDB6AB8F;
	Thu, 21 Dec 2023 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4FB821DBA;
	Thu, 21 Dec 2023 11:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703158004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/mUSHSfPZ+Yf1KncGnQnYY22sxHKtN68QzA+lLUhQY=;
	b=o5lLzhrYii6N3XBAgFNGNvhIXrHIy+LED3XqlesuqOKrq78YFXepc+WmeA7FHD4RuEIcgD
	012odl2yj28G3yt/AeLEIE9nT+TyoU4feyI9lOJTP9GiSpPX/B9lpINRVsRexs0T1Vq9Ba
	ShFRkETV0td7baTLVFi1rpOXr2wv3LM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703158004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/mUSHSfPZ+Yf1KncGnQnYY22sxHKtN68QzA+lLUhQY=;
	b=VeHvaUqgMwgDvtJgqZqQ6+tExelDFer+HiKSJmXtH/rCR6jchWLO8pZHK2j70Hh85PKTmc
	hFtAGU0zEKY1a+CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703158004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/mUSHSfPZ+Yf1KncGnQnYY22sxHKtN68QzA+lLUhQY=;
	b=o5lLzhrYii6N3XBAgFNGNvhIXrHIy+LED3XqlesuqOKrq78YFXepc+WmeA7FHD4RuEIcgD
	012odl2yj28G3yt/AeLEIE9nT+TyoU4feyI9lOJTP9GiSpPX/B9lpINRVsRexs0T1Vq9Ba
	ShFRkETV0td7baTLVFi1rpOXr2wv3LM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703158004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/mUSHSfPZ+Yf1KncGnQnYY22sxHKtN68QzA+lLUhQY=;
	b=VeHvaUqgMwgDvtJgqZqQ6+tExelDFer+HiKSJmXtH/rCR6jchWLO8pZHK2j70Hh85PKTmc
	hFtAGU0zEKY1a+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B695E13725;
	Thu, 21 Dec 2023 11:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D3FCLPQghGXHWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 11:26:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 69F04A07E3; Thu, 21 Dec 2023 12:26:44 +0100 (CET)
Date: Thu, 21 Dec 2023 12:26:44 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] pagevec: Add ability to iterate a queue
Message-ID: <20231221112644.2ijv6c5zooclcqtm@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-11-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-11-hch@lst.de>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.82
X-Spamd-Result: default: False [-0.82 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,lst.de:email,infradead.org:email,suse.com:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[52.12%]
X-Spam-Flag: NO

On Mon 18-12-23 16:35:46, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Add a loop counter inside the folio_batch to let us iterate from 0-nr
> instead of decrementing nr and treating the batch as a stack.  It would
> generate some very weird and suboptimal I/O patterns for page writeback
> to iterate over the batch as a stack.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/pagevec.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
> index 87cc678adc850b..fcc06c300a72c3 100644
> --- a/include/linux/pagevec.h
> +++ b/include/linux/pagevec.h
> @@ -27,6 +27,7 @@ struct folio;
>   */
>  struct folio_batch {
>  	unsigned char nr;
> +	unsigned char i;
>  	bool percpu_pvec_drained;
>  	struct folio *folios[PAGEVEC_SIZE];
>  };
> @@ -40,12 +41,14 @@ struct folio_batch {
>  static inline void folio_batch_init(struct folio_batch *fbatch)
>  {
>  	fbatch->nr = 0;
> +	fbatch->i = 0;
>  	fbatch->percpu_pvec_drained = false;
>  }
>  
>  static inline void folio_batch_reinit(struct folio_batch *fbatch)
>  {
>  	fbatch->nr = 0;
> +	fbatch->i = 0;
>  }
>  
>  static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
> @@ -75,6 +78,21 @@ static inline unsigned folio_batch_add(struct folio_batch *fbatch,
>  	return folio_batch_space(fbatch);
>  }
>  
> +/**
> + * folio_batch_next - Return the next folio to process.
> + * @fbatch: The folio batch being processed.
> + *
> + * Use this function to implement a queue of folios.
> + *
> + * Return: The next folio in the queue, or NULL if the queue is empty.
> + */
> +static inline struct folio *folio_batch_next(struct folio_batch *fbatch)
> +{
> +	if (fbatch->i == fbatch->nr)
> +		return NULL;
> +	return fbatch->folios[fbatch->i++];
> +}
> +
>  void __folio_batch_release(struct folio_batch *pvec);
>  
>  static inline void folio_batch_release(struct folio_batch *fbatch)
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

