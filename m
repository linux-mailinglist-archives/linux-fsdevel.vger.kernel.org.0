Return-Path: <linux-fsdevel+bounces-23103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A93D927399
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 12:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B01287CE0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 10:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8B01AB8F7;
	Thu,  4 Jul 2024 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gnkZMc2O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cL+OAbFF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gnkZMc2O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cL+OAbFF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C46118637;
	Thu,  4 Jul 2024 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720087400; cv=none; b=GfixAorNn5UVYFofApN6hnBstdlTpIMseTP40BRL69o1gVUCLudONuVEtnpaEI78LbP8a6+KtuxVXt/+sC6uugtnjBBrYOsZJxYKfYvyDtPWSidwhxX7bMuIEDU4QrMJ9NiPT2GySY0Ulcpd+4Cy89j2jQbD7BZd+8QCGBgAkAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720087400; c=relaxed/simple;
	bh=9qeb1KifPEkMCIQIEObJxjpZiClWg0yHe4ksMUqPBoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmL+2K3DpL1ECc2OYHOPv6H9EP/URM/zpOzivyFA8pt/Vb+ldKqXtbvvKSid1tBhWZVjucG8lzVN2MRBJzHxnhFn3nr1CiThxbRMYrJzJEw5uBapjFUUmFZd/kxZqIlsgxVWpqNdSz2IkG+ZtM2q06RNbViOxb2LsVV138Z44Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gnkZMc2O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cL+OAbFF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gnkZMc2O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cL+OAbFF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D22821999;
	Thu,  4 Jul 2024 10:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720087397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+XRSc+Zeoy42L8D2dFx6phJ360HhYwVquKQssa5tLjQ=;
	b=gnkZMc2OxX+7QlPyAg7GBaZboZgMdnLvn4lS15YIO2rbxVg2J7t5gjsSwqCRahLz4LyhDL
	HRxuwkQtjZv2gXMMWZN1hVr9Rmd+FUq2NVbfBljk5qiRPxF9LVhkK/POzobnvy58Ik2GR7
	I0RmwGci/vtaL5GDv1TZX3BWMUMhEMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720087397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+XRSc+Zeoy42L8D2dFx6phJ360HhYwVquKQssa5tLjQ=;
	b=cL+OAbFFh0v2FRbypkbZLEKKGpNWqV9YMR5NHLl/9WI+URTlQGlomrGnaZVIZ8ci61DuYj
	eB3RSPAA7Zja5xDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gnkZMc2O;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cL+OAbFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720087397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+XRSc+Zeoy42L8D2dFx6phJ360HhYwVquKQssa5tLjQ=;
	b=gnkZMc2OxX+7QlPyAg7GBaZboZgMdnLvn4lS15YIO2rbxVg2J7t5gjsSwqCRahLz4LyhDL
	HRxuwkQtjZv2gXMMWZN1hVr9Rmd+FUq2NVbfBljk5qiRPxF9LVhkK/POzobnvy58Ik2GR7
	I0RmwGci/vtaL5GDv1TZX3BWMUMhEMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720087397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+XRSc+Zeoy42L8D2dFx6phJ360HhYwVquKQssa5tLjQ=;
	b=cL+OAbFFh0v2FRbypkbZLEKKGpNWqV9YMR5NHLl/9WI+URTlQGlomrGnaZVIZ8ci61DuYj
	eB3RSPAA7Zja5xDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DFE51369F;
	Thu,  4 Jul 2024 10:03:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f7seD2VzhmacYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jul 2024 10:03:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E5C62A088E; Thu,  4 Jul 2024 12:03:08 +0200 (CEST)
Date: Thu, 4 Jul 2024 12:03:08 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Ma <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	mjguzik@gmail.com, edumazet@google.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v3 3/3] fs/file.c: add fast path in find_next_fd()
Message-ID: <20240704100308.6hczzyqhmpty4avx@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240703143311.2184454-1-yu.ma@intel.com>
 <20240703143311.2184454-4-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703143311.2184454-4-yu.ma@intel.com>
X-Rspamd-Queue-Id: 4D22821999
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,intel.com:email,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,google.com,vger.kernel.org,intel.com,linux.intel.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed 03-07-24 10:33:11, Yu Ma wrote:
> There is available fd in the lower 64 bits of open_fds bitmap for most cases
> when we look for an available fd slot. Skip 2-levels searching via
> find_next_zero_bit() for this common fast path.
> 
> Look directly for an open bit in the lower 64 bits of open_fds bitmap when a
> free slot is available there, as:
> (1) The fd allocation algorithm would always allocate fd from small to large.
> Lower bits in open_fds bitmap would be used much more frequently than higher
> bits.
> (2) After fdt is expanded (the bitmap size doubled for each time of expansion),
> it would never be shrunk. The search size increases but there are few open fds
> available here.
> (3) There is fast path inside of find_next_zero_bit() when size<=64 to speed up
> searching.
> 
> As suggested by Mateusz Guzik <mjguzik gmail.com> and Jan Kara <jack@suse.cz>,
> update the fast path from alloc_fd() to find_next_fd(). With which, on top of
> patch 1 and 2, pts/blogbench-1.1.0 read is improved by 13% and write by 7% on
> Intel ICX 160 cores configuration with v6.10-rc6.
> 
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Yu Ma <yu.ma@intel.com>

Nice! The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

One style nit below:

> diff --git a/fs/file.c b/fs/file.c
> index a15317db3119..f25eca311f51 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -488,6 +488,11 @@ struct files_struct init_files = {
>  
>  static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
>  {
> +	unsigned int bit;

Empty line here please to separate variable declaration and code...

> +	bit = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, start);
> +	if (bit < BITS_PER_LONG)
> +		return bit;
> +
>  	unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
>  	unsigned int maxbit = maxfd / BITS_PER_LONG;
>  	unsigned int bitbit = start / BITS_PER_LONG;

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

