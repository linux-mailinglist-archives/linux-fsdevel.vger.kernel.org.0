Return-Path: <linux-fsdevel+bounces-54680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAFCB0222F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDBA5A4DD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9E02ED84E;
	Fri, 11 Jul 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K8drUSku";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v1HDL4Mf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qBoTwiNf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r3llKiEL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8562AE66
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252722; cv=none; b=aCCz5nmHy4/spC7rcv7hF3/S4V3XlTKjL/B4vZ5d8h0aT2XIuD6zW/MkxEvOBM5dZbA/UnxN8slyd2NuXUNgR+oYVuAm8ADcfDfhTw6vkDL00Led2v8JO8nzNF8pe/gWLj0loKc8Bx2EGn0qv554MTvkHdUvG8+eTj6N+FZ27Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252722; c=relaxed/simple;
	bh=pee92NaOTrHCTNZPNpM+NaB9v/GSNsen5I44+zcMLps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDrRb8CaTbn+LsUzh0EPORmbmTtJJy4evhEuxLUPzjr0/gewHC+ox1vF/ORPAg/LtoCJ2QwShTylTUt/agPM2sp/afRRjSgTxUV3og22EbEdxB9K7rsE4Lx77QQfes3eVJ1pUIaswTjXlPx1NFPj28I42My4TIGL4dah9xsk/nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K8drUSku; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v1HDL4Mf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qBoTwiNf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r3llKiEL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 946431F45E;
	Fri, 11 Jul 2025 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752252718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ma9sOalOmV07BRs5Tzh1FQkC2TPq3niCU+aIZe8ye1g=;
	b=K8drUSkuTUM1KDA+UN7hDhmtysbKXjYbgmT7Vl9a7Q20XK7ChfiLIFGdByQ9bencrf3Ln1
	3T88JhThv11iUSyn4Kuk70NBC/tSdYzWHQMqsPTqXBrSsRzpi0GHkjW6HE0OCwUi4vmGUS
	zr8gRp17jljffjrnbzVN7F6qHrM/2k8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752252718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ma9sOalOmV07BRs5Tzh1FQkC2TPq3niCU+aIZe8ye1g=;
	b=v1HDL4Mf45VmFP8axgIX0x/vfpKL4HEBMu9ZT9P7ov2blTd1P202+CwvTdcCoe9wOiDiko
	BQQV22znYn5w/0Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qBoTwiNf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=r3llKiEL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752252717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ma9sOalOmV07BRs5Tzh1FQkC2TPq3niCU+aIZe8ye1g=;
	b=qBoTwiNf+ipWryncUHZTgydLtSs7JIbTBMsD7DpSgcWxcb0IN7y3QPw9oAvJkQfs7pNd7e
	RXEggqel3o192JLZh93/3spLkdf0icfZrQ0gat6AmU3HVgf6fw48bb+0C7uoKnNuXsi+gM
	uvLtPIN0SAWep8jpRfr0pUNQ4kDLQgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752252717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ma9sOalOmV07BRs5Tzh1FQkC2TPq3niCU+aIZe8ye1g=;
	b=r3llKiELHFC8DrEpCfCINrG1k4RE783vjZYxVRV14iOuf5I9pvke872EVtTLhycnE8synX
	6puVLJsT/FQHh8DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89E0F138A5;
	Fri, 11 Jul 2025 16:51:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7nKlIS1BcWhJfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Jul 2025 16:51:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 397BCA099A; Fri, 11 Jul 2025 18:51:49 +0200 (CEST)
Date: Fri, 11 Jul 2025 18:51:49 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: jack@suse.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] udf: stop using write_cache_pages
Message-ID: <5mpfwzgjpw4xfkz4yihcyntiby4oqeb7opvanewydvrsnm6r7r@pzqvag3b57yr>
References: <20250711081036.564232-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711081036.564232-1-hch@lst.de>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 946431F45E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,lst.de:email,suse.cz:dkim]
X-Spam-Score: -4.01

On Fri 11-07-25 10:10:36, Christoph Hellwig wrote:
> Stop using the obsolete write_cache_pages and use writeback_iter directly.
> Use the chance to refactor the inacb writeback code to not have a separate
> writeback helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks! Added to my tree.

								Honza

> ---
>  fs/udf/inode.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 4386dd845e40..c0975d5dec25 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -181,19 +181,23 @@ static void udf_write_failed(struct address_space *mapping, loff_t to)
>  	}
>  }
>  
> -static int udf_adinicb_writepage(struct folio *folio,
> -				 struct writeback_control *wbc, void *data)
> +static int udf_adinicb_writepages(struct address_space *mapping,
> +		      struct writeback_control *wbc)
>  {
> -	struct inode *inode = folio->mapping->host;
> +	struct inode *inode = mapping->host;
>  	struct udf_inode_info *iinfo = UDF_I(inode);
> +	struct folio *folio = NULL;
> +	int error = 0;
> +
> +	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
> +		BUG_ON(!folio_test_locked(folio));
> +		BUG_ON(folio->index != 0);
> +		memcpy_from_file_folio(iinfo->i_data + iinfo->i_lenEAttr, folio,
> +				0, i_size_read(inode));
> +		folio_unlock(folio);
> +	}
>  
> -	BUG_ON(!folio_test_locked(folio));
> -	BUG_ON(folio->index != 0);
> -	memcpy_from_file_folio(iinfo->i_data + iinfo->i_lenEAttr, folio, 0,
> -		       i_size_read(inode));
> -	folio_unlock(folio);
>  	mark_inode_dirty(inode);
> -
>  	return 0;
>  }
>  
> @@ -203,9 +207,9 @@ static int udf_writepages(struct address_space *mapping,
>  	struct inode *inode = mapping->host;
>  	struct udf_inode_info *iinfo = UDF_I(inode);
>  
> -	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB)
> -		return mpage_writepages(mapping, wbc, udf_get_block_wb);
> -	return write_cache_pages(mapping, wbc, udf_adinicb_writepage, NULL);
> +	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
> +		return udf_adinicb_writepages(mapping, wbc);
> +	return mpage_writepages(mapping, wbc, udf_get_block_wb);
>  }
>  
>  static void udf_adinicb_read_folio(struct folio *folio)
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

