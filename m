Return-Path: <linux-fsdevel+bounces-23751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D5A932575
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 13:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF611C226D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 11:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716D21990D6;
	Tue, 16 Jul 2024 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T8QFm0Ar";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PUN0htGR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T8QFm0Ar";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PUN0htGR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97D751C5A;
	Tue, 16 Jul 2024 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128754; cv=none; b=WXuLPQHy33Hzpuo6xxA0nWC6fhRd0OjbUDS+YEEHY/OaJexcVDeivGrWMHFPhoeoGOVVljetWRAyk2V4mT+pHe2YDLOG/ErB1Q3om4MF4LQI3v14Ogv2vdWQb4bU0RCtkA7x8LoA/57sEDFTTa/r7zNK3FbA9NBZX2ZigAFICes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128754; c=relaxed/simple;
	bh=bR1KWghkHAGWtponbZYrlDDSuDJv7ldCcY4Rty/DFNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cxg9BvpO9+MAgPdMzmRUPBK/tXyA4RaNaUWpiUZb0+WjU+StN+vTOCbrICUM3i+XrpLQlGN8sGwSqWpHr+cpSaj7Q+jErqF6gwUTV2JUDkoRxqIXtv6RpiRyvDU9CXQ3WIO+kZMU+6hr0vys65blR8M53Eq4Vh4i/ToVnSNxUVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T8QFm0Ar; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PUN0htGR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T8QFm0Ar; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PUN0htGR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 04E1F1F8AF;
	Tue, 16 Jul 2024 11:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721128751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5gQZIy32REV53zp7TQ6wKPWCs5iQT1+jhl+IpdGfcsk=;
	b=T8QFm0ArjNPJIhMf0x2+VO6We6Wdcqo+hxCq4weEbumXtdlxQvqs0Sj+JYBCN2gyNCVLe/
	L1/pumfyNRloQLRAziiEQ6LxeqR6phbjw1nM9TMRAEtkZ6X1Xibb853FQbRTJKr4PSkI0g
	sNfuT/vkKIHcDw8n8y0TMEiu+USUb9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721128751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5gQZIy32REV53zp7TQ6wKPWCs5iQT1+jhl+IpdGfcsk=;
	b=PUN0htGR9Jo3Up7RdGm2xA3oI29M3qXw9G1IO2q6EY2W91TSqNkUcOZ26PCCOpDRh+6e9y
	G1UpqflqXVJDuJAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T8QFm0Ar;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PUN0htGR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721128751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5gQZIy32REV53zp7TQ6wKPWCs5iQT1+jhl+IpdGfcsk=;
	b=T8QFm0ArjNPJIhMf0x2+VO6We6Wdcqo+hxCq4weEbumXtdlxQvqs0Sj+JYBCN2gyNCVLe/
	L1/pumfyNRloQLRAziiEQ6LxeqR6phbjw1nM9TMRAEtkZ6X1Xibb853FQbRTJKr4PSkI0g
	sNfuT/vkKIHcDw8n8y0TMEiu+USUb9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721128751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5gQZIy32REV53zp7TQ6wKPWCs5iQT1+jhl+IpdGfcsk=;
	b=PUN0htGR9Jo3Up7RdGm2xA3oI29M3qXw9G1IO2q6EY2W91TSqNkUcOZ26PCCOpDRh+6e9y
	G1UpqflqXVJDuJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5CDB13795;
	Tue, 16 Jul 2024 11:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tThFMC5Xlmb8PwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Jul 2024 11:19:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 00A4AA0987; Tue, 16 Jul 2024 13:19:08 +0200 (CEST)
Date: Tue, 16 Jul 2024 13:19:08 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Ma <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	mjguzik@gmail.com, edumazet@google.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v4 3/3] fs/file.c: add fast path in find_next_fd()
Message-ID: <20240716111908.tocqtq435d6bc3q3@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240713023917.3967269-1-yu.ma@intel.com>
 <20240713023917.3967269-4-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713023917.3967269-4-yu.ma@intel.com>
X-Rspamd-Queue-Id: 04E1F1F8AF
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,google.com,vger.kernel.org,intel.com,linux.intel.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spamd-Bar: /

On Fri 12-07-24 22:39:17, Yu Ma wrote:
> Skip 2-levels searching via find_next_zero_bit() when there is free slot in the
> word contains next_fd, as:
> (1) next_fd indicates the lower bound for the first free fd.
> (2) There is fast path inside of find_next_zero_bit() when size<=64 to speed up
> searching.
> (3) After fdt is expanded (the bitmap size doubled for each time of expansion),
> it would never be shrunk. The search size increases but there are few open fds
> available here.
> 
> This fast path is proposed by Mateusz Guzik <mjguzik@gmail.com>, and agreed by
> Jan Kara <jack@suse.cz>, which is more generic and scalable than previous
> versions. And on top of patch 1 and 2, it improves pts/blogbench-1.1.0 read by
> 8% and write by 4% on Intel ICX 160 cores configuration with v6.10-rc7.
> 
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Yu Ma <yu.ma@intel.com>

Looks good. Just some code style nits below.

> diff --git a/fs/file.c b/fs/file.c
> index 1be2a5bcc7c4..a3ce6ba30c8c 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -488,9 +488,20 @@ struct files_struct init_files = {
>  
>  static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
>  {
> +	unsigned int bitbit = start / BITS_PER_LONG;
> +	unsigned int bit;
> +
> +	/*
> +	 * Try to avoid looking at the second level bitmap
> +	 */
> +	bit = find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
> +				 start & (BITS_PER_LONG -1));
							^^ Either
(BITS_PER_LONG-1) or (BITS_PER_LONG - 1) please. Your combination looks
particularly weird :)

> +	if (bit < BITS_PER_LONG) {
> +		return bit + bitbit * BITS_PER_LONG;
> +	}

No need for braces around the above block.

>  	unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
>  	unsigned int maxbit = maxfd / BITS_PER_LONG;

We keep declarations at the beginning of the block. Usually it keeps the
code more readable and the compiler should be clever enough to perform the
loads & arithmetics only when needed.

After fixing these style nits feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

