Return-Path: <linux-fsdevel+bounces-10263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BE4849921
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705B61F2307C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 11:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392BF1B5B2;
	Mon,  5 Feb 2024 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nnEt+6Ta";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mgicj8+Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nnEt+6Ta";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mgicj8+Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009061AACA;
	Mon,  5 Feb 2024 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133421; cv=none; b=TSTaIh1N3+8ReBfeIIOYQVY7tOPNL6uCr8zODD9ktSVbCRtH64ckli+ZzLRyaDrN88e3jfvIuuqVIQYVWafx8lRHXQ9zC2tjK8rxP0kKNJFEv+5OIjG1ag1Q6v4u0WY0Se6AVjexfPD7qPUtwUi6GJVRSLlRhyJ6u44UOWDbIoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133421; c=relaxed/simple;
	bh=B8qY2p66/oiwnuC49HiJlR/0aVHEOE8sdzptsXmZ3M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVIwFfwdSZchLjmiU7SJgbcoM7hrK+GrI/7YX8KwJ7lGi92SfZw5TwgJUboiBYCyIIeDKAMtyLc9/o+52FgZYvkInKIVHVA96Q/Iv6YBX3nh8kA80iRFdRnrcKiMxIWSQhOxE1lt7znr/oBPEDgOAPMp8RGUcWXImwP4nlJMTS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nnEt+6Ta; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mgicj8+Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nnEt+6Ta; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mgicj8+Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 063872227F;
	Mon,  5 Feb 2024 11:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707133418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0PuzXhLwyJ6hL46dcFxwenDBPB8LUfJn9fPk0vsMfBM=;
	b=nnEt+6TamS7Wde7eoXF4sK3iocuJhs0LuDm9519pSHulP2Ab0O/ETe938vq61/6JCk78WK
	Kgv5I870s0aXufrAtQm974jkSw3jVd2itVd8v24CUFU5prlVaqR+4N+MBJkqV4br5jh7TI
	WbtXIy8dRF5KLYcn8joDMvQEjQanEQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707133418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0PuzXhLwyJ6hL46dcFxwenDBPB8LUfJn9fPk0vsMfBM=;
	b=mgicj8+ZHMtv3Xme9QARO8ZoyIPZbrgZpGuMjwXj6voIxRNm101V/tsR68iiLqnfZZt0B1
	eeNGxcx1wd4Y88Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707133418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0PuzXhLwyJ6hL46dcFxwenDBPB8LUfJn9fPk0vsMfBM=;
	b=nnEt+6TamS7Wde7eoXF4sK3iocuJhs0LuDm9519pSHulP2Ab0O/ETe938vq61/6JCk78WK
	Kgv5I870s0aXufrAtQm974jkSw3jVd2itVd8v24CUFU5prlVaqR+4N+MBJkqV4br5jh7TI
	WbtXIy8dRF5KLYcn8joDMvQEjQanEQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707133418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0PuzXhLwyJ6hL46dcFxwenDBPB8LUfJn9fPk0vsMfBM=;
	b=mgicj8+ZHMtv3Xme9QARO8ZoyIPZbrgZpGuMjwXj6voIxRNm101V/tsR68iiLqnfZZt0B1
	eeNGxcx1wd4Y88Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED27B136F5;
	Mon,  5 Feb 2024 11:43:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rm7fOenJwGWFRAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Feb 2024 11:43:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A40B2A0809; Mon,  5 Feb 2024 12:43:37 +0100 (CET)
Date: Mon, 5 Feb 2024 12:43:37 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] writeback: Remove a use of write_cache_pages()
 from do_writepages()
Message-ID: <20240205114337.74l7sjanbmajqodt@quack3>
References: <20240203071147.862076-1-hch@lst.de>
 <20240203071147.862076-14-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203071147.862076-14-hch@lst.de>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nnEt+6Ta;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mgicj8+Z
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[42.04%]
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: 063872227F
X-Spam-Flag: NO

On Sat 03-02-24 08:11:47, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the new writeback_iter() directly instead of indirecting
> through a callback.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> [hch: ported to the while based iter style]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I've just noticed one preexisting problem which was made more visible by
your reshuffling:

> +static int writeback_use_writepage(struct address_space *mapping,
> +		struct writeback_control *wbc)
>  {
> -	struct address_space *mapping = data;
> -	int ret = mapping->a_ops->writepage(&folio->page, wbc);
> -	mapping_set_error(mapping, ret);
> -	return ret;
> +	struct folio *folio = NULL;
> +	struct blk_plug plug;
> +	int err;
> +
> +	blk_start_plug(&plug);
> +	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
> +		err = mapping->a_ops->writepage(&folio->page, wbc);
> +		mapping_set_error(mapping, err);

So if ->writepage() returns AOP_WRITEPAGE_ACTIVATE, we shouldn't call
mapping_set_error() because that's just going to confuse the error
tracking.

> +		if (err == AOP_WRITEPAGE_ACTIVATE) {
> +			folio_unlock(folio);
> +			err = 0;
> +		}
> +	}
> +	blk_finish_plug(&plug);
> +
> +	return err;
>  }

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

