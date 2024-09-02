Return-Path: <linux-fsdevel+bounces-28258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA6096897A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 16:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197891F22701
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B892101A1;
	Mon,  2 Sep 2024 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X8U5Th4E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xqc0+d6q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X8U5Th4E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xqc0+d6q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9219E992;
	Mon,  2 Sep 2024 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286155; cv=none; b=auSHQHbW9lMeLqoI4I6gffyrAsxEh/DmdYSfFT++xKam7RpaQ3wRZxp/uCSGcXvRY8exV5S7sFQ+s7/xnfAe6Ly902cjo/uOZf/lC74SvoIUf0JPcdzTPeycvRl+z+MZn8JGmJQqoETwbR85yX2EAJNdZs+lH8J0YV7jXzOw9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286155; c=relaxed/simple;
	bh=0F/1tTzmeC08x83pDFWJWbgZAtpxfw8k/NcbcoX/BDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpmLUKR6Rjhxpmuu/j+EmFxthYKAsSG0rYFTfHCIMvsuL61zUpHO7yP3yJdyXLZoPlq6jQYukvRr3kGMneFGtRxbF3p/mz2GlMtqiWcHCdImtirApIdekLT0qecG3aG75sKbp5aUhs3ZKg1zQXoU9UtZLpK6nazV6Y4DI5cIZbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X8U5Th4E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xqc0+d6q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X8U5Th4E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xqc0+d6q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 566201FBB3;
	Mon,  2 Sep 2024 14:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725286152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zl525NZI+rdwb8hTQ8OaF32cmelBg9hHtUjXQ5wYcc=;
	b=X8U5Th4EjpfV1n5yl9ycU/I+YQX8PHZUAtR2FrO+0/ZiWI0NFbQOnmqfKDETIwM8c1woei
	18h9EyHrKHzcLb4H4oCTlZmwtoIFxJcFKIjCVznfhwvcPFBt1r+bruShFDV1ipX5Oe7vEM
	Fr0ZDvXAcKWbGF6sVGrWrdt2CwRVC9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725286152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zl525NZI+rdwb8hTQ8OaF32cmelBg9hHtUjXQ5wYcc=;
	b=Xqc0+d6ql8l+3mka2z8wv4PpOsNeR/LwJ3Qx9NAA0py50Wx3ITi4DG1ysbEGM2rf/P9Key
	PLn9zhVXG89PtQBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X8U5Th4E;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Xqc0+d6q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725286152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zl525NZI+rdwb8hTQ8OaF32cmelBg9hHtUjXQ5wYcc=;
	b=X8U5Th4EjpfV1n5yl9ycU/I+YQX8PHZUAtR2FrO+0/ZiWI0NFbQOnmqfKDETIwM8c1woei
	18h9EyHrKHzcLb4H4oCTlZmwtoIFxJcFKIjCVznfhwvcPFBt1r+bruShFDV1ipX5Oe7vEM
	Fr0ZDvXAcKWbGF6sVGrWrdt2CwRVC9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725286152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zl525NZI+rdwb8hTQ8OaF32cmelBg9hHtUjXQ5wYcc=;
	b=Xqc0+d6ql8l+3mka2z8wv4PpOsNeR/LwJ3Qx9NAA0py50Wx3ITi4DG1ysbEGM2rf/P9Key
	PLn9zhVXG89PtQBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4685313AE0;
	Mon,  2 Sep 2024 14:09:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hsgxEQjH1WbDLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Sep 2024 14:09:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BD0A0A0965; Mon,  2 Sep 2024 16:09:11 +0200 (CEST)
Date: Mon, 2 Sep 2024 16:09:11 +0200
From: Jan Kara <jack@suse.cz>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH] dax: Remove an unused field in struct dax_operations
Message-ID: <20240902140911.puhunqx4qg7rqy6b@quack3>
References: <56b92b722ca0a6fd1387c871a6ec01bcb9bd525e.1725203804.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56b92b722ca0a6fd1387c871a6ec01bcb9bd525e.1725203804.git.christophe.jaillet@wanadoo.fr>
X-Rspamd-Queue-Id: 566201FBB3
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[wanadoo.fr];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Sun 01-09-24 17:17:09, Christophe JAILLET wrote:
> .dax_supported() was apparently removed by commit 7b0800d00dae ("dax:
> remove dax_capable") on 2021-11.
> 
> Remove the now unused function pointer from the struct dax_operations.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Slightly compile tested only, but "git grep dax_supported" now returns
> nothing.
> ---
>  include/linux/dax.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 9d3e3327af4c..df41a0017b31 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -27,12 +27,6 @@ struct dax_operations {
>  	 */
>  	long (*direct_access)(struct dax_device *, pgoff_t, long,
>  			enum dax_access_mode, void **, pfn_t *);
> -	/*
> -	 * Validate whether this device is usable as an fsdax backing
> -	 * device.
> -	 */
> -	bool (*dax_supported)(struct dax_device *, struct block_device *, int,
> -			sector_t, sector_t);
>  	/* zero_page_range: required operation. Zero page range   */
>  	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
>  	/*
> -- 
> 2.46.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

