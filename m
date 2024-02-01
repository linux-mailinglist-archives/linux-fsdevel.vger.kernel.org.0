Return-Path: <linux-fsdevel+bounces-9824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748AE8453DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D9728B229
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A13E15B10F;
	Thu,  1 Feb 2024 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EK1Xce2m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ywSa7cRP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EK1Xce2m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ywSa7cRP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3496615A498;
	Thu,  1 Feb 2024 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779695; cv=none; b=Lzi3GR3RvPc3gr3cW+NkyIcc8NEIVJmri1KDckWVi0fV26XyMhn3QlZ0iCWXZkWbuEn5aE8DhIVp6dMYfvh7ci/9AkLOLqWgSDBWUWXsnWnL4F59srmDTTFn2fEu4v76S0QdipDy4by1VoCjD5wrPAg5Nq640PhrYuyK1o2bQdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779695; c=relaxed/simple;
	bh=cZ8hpkR/3u+9nW8V/2LfRPSay0z0DtpGIpqWUwfMnlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAiIIM6ae3MQqqhuoFAFmm77Lkf9lx4PZBITNyHPcyhXXdiNMA75+K72xYmx3phwg8OuVyhyhz8qOU1EWWgwPCWmmEOaSOMc5mDxIp6G7tal8HTvQXeyK6Zqr3E4jT/CpjPb22YA5PdBeCFwHGzKflciEdxTkSeY7/c0WBsynCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EK1Xce2m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ywSa7cRP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EK1Xce2m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ywSa7cRP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F1E02205A;
	Thu,  1 Feb 2024 09:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706779692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZXgLLa0AgQAAzLt+5EkE3Qo2/vmJJ/AA1BTUNqnDIc=;
	b=EK1Xce2mBq6yxLlhpfJlbluuhV5OslGE3Ihq9ykf96pXF7vJhk6atO/IXrz7yoZH4lkPQ0
	cahd+9kJXp7PcDARqcqCi1l0kZ+qRxr7cs0B5VdUeF1/6JKo0Hl762DvbC3T4xYb+c3A8t
	53PsZNMu4QDHVkC6lALalNs72sasIZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706779692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZXgLLa0AgQAAzLt+5EkE3Qo2/vmJJ/AA1BTUNqnDIc=;
	b=ywSa7cRP+K5QgHKyokZsMb2v6/xI9DEvDMndE6k61NRtyyee4b3nrZrDVebWl4Jq+YAGyF
	EK7zD6pNtRQqx0AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706779692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZXgLLa0AgQAAzLt+5EkE3Qo2/vmJJ/AA1BTUNqnDIc=;
	b=EK1Xce2mBq6yxLlhpfJlbluuhV5OslGE3Ihq9ykf96pXF7vJhk6atO/IXrz7yoZH4lkPQ0
	cahd+9kJXp7PcDARqcqCi1l0kZ+qRxr7cs0B5VdUeF1/6JKo0Hl762DvbC3T4xYb+c3A8t
	53PsZNMu4QDHVkC6lALalNs72sasIZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706779692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZXgLLa0AgQAAzLt+5EkE3Qo2/vmJJ/AA1BTUNqnDIc=;
	b=ywSa7cRP+K5QgHKyokZsMb2v6/xI9DEvDMndE6k61NRtyyee4b3nrZrDVebWl4Jq+YAGyF
	EK7zD6pNtRQqx0AA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 317B513594;
	Thu,  1 Feb 2024 09:28:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id LrYEDCxku2X+UQAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 09:28:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C935DA0809; Thu,  1 Feb 2024 10:28:11 +0100 (CET)
Date: Thu, 1 Feb 2024 10:28:11 +0100
From: Jan Kara <jack@suse.cz>
To: Liu Shixin <liushixin2@huawei.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/readahead: stop readahead loop if memcg charge
 fails
Message-ID: <20240201092811.ycoh2rekx4wagglc@quack3>
References: <20240201100835.1626685-1-liushixin2@huawei.com>
 <20240201100835.1626685-2-liushixin2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201100835.1626685-2-liushixin2@huawei.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EK1Xce2m;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ywSa7cRP
X-Spamd-Result: default: False [0.18 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[49.80%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.18
X-Rspamd-Queue-Id: 3F1E02205A
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Thu 01-02-24 18:08:34, Liu Shixin wrote:
> When a task in memcg readaheads file pages, page_cache_ra_unbounded()
> will try to readahead nr_to_read pages. Even if the new allocated page
> fails to charge, page_cache_ra_unbounded() still tries to readahead
> next page. This leads to too much memory reclaim.
> 
> Stop readahead if mem_cgroup_charge() fails, i.e. add_to_page_cache_lru()
> returns -ENOMEM.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/readahead.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 23620c57c1225..cc4abb67eb223 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -228,6 +228,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  	 */
>  	for (i = 0; i < nr_to_read; i++) {
>  		struct folio *folio = xa_load(&mapping->i_pages, index + i);
> +		int ret;
>  
>  		if (folio && !xa_is_value(folio)) {
>  			/*
> @@ -247,9 +248,12 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  		folio = filemap_alloc_folio(gfp_mask, 0);
>  		if (!folio)
>  			break;
> -		if (filemap_add_folio(mapping, folio, index + i,
> -					gfp_mask) < 0) {
> +
> +		ret = filemap_add_folio(mapping, folio, index + i, gfp_mask);
> +		if (ret < 0) {
>  			folio_put(folio);
> +			if (ret == -ENOMEM)
> +				break;
>  			read_pages(ractl);
>  			ractl->_index++;
>  			i = ractl->_index + ractl->_nr_pages - index - 1;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

