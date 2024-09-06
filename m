Return-Path: <linux-fsdevel+bounces-28838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0003596F17B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 12:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BFD9B215A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 10:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8031C9EA1;
	Fri,  6 Sep 2024 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PrGnFRvJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qFtIG2qX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PrGnFRvJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qFtIG2qX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768952D600
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618596; cv=none; b=iSfFQZrztF0gZw8Wv2aNWA4XBELdUSOuSHXOSDgWfXSuz4AE5ubZCxlxKlSIZHSj1xBactbSlg7WSw82de+Uektjmo/2qNGwqMObXkN9bMtURpXEdPWwMqmH0M0+LIALiWxgx5hqnok4fOVdMHnVnnjmr8e44wMWkqu5/iGXUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618596; c=relaxed/simple;
	bh=feDpphR00xG3rT60scarPK5jQRemSFowpEoABOjFDBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msLxWt7biDyYIdCPUw1GQX8bxW+35nIRWFOU4/3q+ZcWs9Xn4dRkB9G+lTiRA7t7RIP5rSkD32JB7lzq0PY0xSWKYGPWS/NtiBp/z2ub65NWq2zRg01Ja3HRZENGJr//rMMnn0gWm/TjUc7S00WGQKliDIUGV1l9CqnPTnoCKh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PrGnFRvJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qFtIG2qX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PrGnFRvJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qFtIG2qX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B6D221AAC;
	Fri,  6 Sep 2024 10:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725618587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/TEocIWx3v+XRpjvtaYxWmjUp/l0q7RFSjvdesOdAc=;
	b=PrGnFRvJpKp3GqUATRpP410mmVEMqgWY7a6Fs4h1KqkS/8e486SGp9AAMWpqNVHfc02+X9
	mOl1ZMTUi0U0arxUZThlS+1OaZMS6wmPVNwN2TLFz/z8hoNllHr8IRPh399tZm/sLoKAGm
	2CN9K6v8FuOspq0kEjh4poc12ASd/b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725618587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/TEocIWx3v+XRpjvtaYxWmjUp/l0q7RFSjvdesOdAc=;
	b=qFtIG2qXfH+0nJWcmHAWJJoa6e/+RKFV6aMgvXqV84wbyjmSyLNlVsK1YOah7nCUP/Op8r
	peAmCa3GanuNjsAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725618587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/TEocIWx3v+XRpjvtaYxWmjUp/l0q7RFSjvdesOdAc=;
	b=PrGnFRvJpKp3GqUATRpP410mmVEMqgWY7a6Fs4h1KqkS/8e486SGp9AAMWpqNVHfc02+X9
	mOl1ZMTUi0U0arxUZThlS+1OaZMS6wmPVNwN2TLFz/z8hoNllHr8IRPh399tZm/sLoKAGm
	2CN9K6v8FuOspq0kEjh4poc12ASd/b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725618587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/TEocIWx3v+XRpjvtaYxWmjUp/l0q7RFSjvdesOdAc=;
	b=qFtIG2qXfH+0nJWcmHAWJJoa6e/+RKFV6aMgvXqV84wbyjmSyLNlVsK1YOah7nCUP/Op8r
	peAmCa3GanuNjsAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10DE9136A8;
	Fri,  6 Sep 2024 10:29:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3wYaBJvZ2mY+bAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Sep 2024 10:29:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ABC3BA0962; Fri,  6 Sep 2024 12:29:42 +0200 (CEST)
Date: Fri, 6 Sep 2024 12:29:42 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH] vfs: return -EOVERFLOW in generic_remap_checks() when
 overflow check fails
Message-ID: <20240906102942.egowavntfx6t3z6t@quack3>
References: <20240906033202.1252195-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906033202.1252195-1-sunjunchao2870@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 06-09-24 11:32:02, Julian Sun wrote:
> Keep it consistent with the handling of the same check within
> generic_copy_file_checks().
> Also, returning -EOVERFLOW in this case is more appropriate.
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>

Well, you were already changing this condition here [1] so maybe just
update the errno in that patch as well? No need to generate unnecessary
patch conflicts...

[1] https://lore.kernel.org/all/20240905121545.ma6zdnswn5s72byb@quack3

								Honza

> ---
>  fs/remap_range.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index 28246dfc8485..97171f2191aa 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -46,7 +46,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
>  
>  	/* Ensure offsets don't wrap. */
>  	if (pos_in + count < pos_in || pos_out + count < pos_out)
> -		return -EINVAL;
> +		return -EOVERFLOW;
>  
>  	size_in = i_size_read(inode_in);
>  	size_out = i_size_read(inode_out);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

