Return-Path: <linux-fsdevel+bounces-6675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C88B81B54F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE41B24D7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350D66E2BF;
	Thu, 21 Dec 2023 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oLST258I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yT7a2fho";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oLST258I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yT7a2fho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309346F602;
	Thu, 21 Dec 2023 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 67FD121E44;
	Thu, 21 Dec 2023 11:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703159625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L31YACKSQsFcxxfW7VaGnizvEvAwj2sWxxztR/WkIj8=;
	b=oLST258IANtlkxNQE9+eUj/nMzwZaADtIVJFFeGRl7JvU++VyCiEKxyyl/kbPS8Qyz2KkE
	N0xXsBjrFHwTmG4VyIqWO30F+dSFRuVmPWkXt+7TQSY/6i3dMYNmfG0QleHKge+Xd7f4TK
	qQ2J+8+5di4lO3Rg/wKKvpm403CaCqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703159625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L31YACKSQsFcxxfW7VaGnizvEvAwj2sWxxztR/WkIj8=;
	b=yT7a2fhoGycH/mU51y5QnFa1RIGX8wiVt4CKtTT910qi9O1PvEtRjgUX0lcnM7Hke2+qO9
	FOpVzS8omBa8gpBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703159625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L31YACKSQsFcxxfW7VaGnizvEvAwj2sWxxztR/WkIj8=;
	b=oLST258IANtlkxNQE9+eUj/nMzwZaADtIVJFFeGRl7JvU++VyCiEKxyyl/kbPS8Qyz2KkE
	N0xXsBjrFHwTmG4VyIqWO30F+dSFRuVmPWkXt+7TQSY/6i3dMYNmfG0QleHKge+Xd7f4TK
	qQ2J+8+5di4lO3Rg/wKKvpm403CaCqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703159625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L31YACKSQsFcxxfW7VaGnizvEvAwj2sWxxztR/WkIj8=;
	b=yT7a2fhoGycH/mU51y5QnFa1RIGX8wiVt4CKtTT910qi9O1PvEtRjgUX0lcnM7Hke2+qO9
	FOpVzS8omBa8gpBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D78313AB5;
	Thu, 21 Dec 2023 11:53:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WfrcFkknhGXyYwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 11:53:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 17115A07E3; Thu, 21 Dec 2023 12:53:45 +0100 (CET)
Date: Thu, 21 Dec 2023 12:53:45 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/17] writeback: Remove a use of write_cache_pages()
 from do_writepages()
Message-ID: <20231221115345.jaqzljtj2s675vjr@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-17-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-17-hch@lst.de>
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-0.52 / 50.00];
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
	 BAYES_HAM(-0.92)[86.25%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -0.52
X-Spam-Flag: NO

On Mon 18-12-23 16:35:52, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the new for_each_writeback_folio() directly instead of indirecting
> through a callback.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index fbffd30a9cc93f..d3c2c78e0c67ce 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2564,13 +2564,21 @@ int write_cache_pages(struct address_space *mapping,
>  }
>  EXPORT_SYMBOL(write_cache_pages);
>  
> -static int writepage_cb(struct folio *folio, struct writeback_control *wbc,
> -		void *data)
> +static int writeback_use_writepage(struct address_space *mapping,
> +		struct writeback_control *wbc)
>  {
> -	struct address_space *mapping = data;
> -	int ret = mapping->a_ops->writepage(&folio->page, wbc);
> -	mapping_set_error(mapping, ret);
> -	return ret;
> +	struct blk_plug plug;
> +	struct folio *folio;
> +	int err;
> +
> +	blk_start_plug(&plug);
> +	for_each_writeback_folio(mapping, wbc, folio, err) {
> +		err = mapping->a_ops->writepage(&folio->page, wbc);
> +		mapping_set_error(mapping, err);
> +	}
> +	blk_finish_plug(&plug);
> +
> +	return err;
>  }
>  
>  int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
> @@ -2586,12 +2594,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
>  		if (mapping->a_ops->writepages) {
>  			ret = mapping->a_ops->writepages(mapping, wbc);
>  		} else if (mapping->a_ops->writepage) {
> -			struct blk_plug plug;
> -
> -			blk_start_plug(&plug);
> -			ret = write_cache_pages(mapping, wbc, writepage_cb,
> -						mapping);
> -			blk_finish_plug(&plug);
> +			ret = writeback_use_writepage(mapping, wbc);
>  		} else {
>  			/* deal with chardevs and other special files */
>  			ret = 0;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

