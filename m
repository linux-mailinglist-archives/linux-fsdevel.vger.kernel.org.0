Return-Path: <linux-fsdevel+bounces-20458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402A28D3C22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 18:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489B51C23000
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 16:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605C91836E9;
	Wed, 29 May 2024 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C+jo/LF8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fxPU1Bmg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C+jo/LF8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fxPU1Bmg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DAA1836E0;
	Wed, 29 May 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716999760; cv=none; b=EA3ixII6998BKZwem/TUTGtNZ+CAol77Ww8LYD+C7DJgFIzlzd7uSaBsVJronYkBQwXHlcrI/Cx/Y6Hu+mjT/H1E3stdd8un5nvw/iKQoJMyBk4Bu4vKxYoO0rY2X5rq12hvKTJC4umFHgS/owERZydOnV8paAg7+drPpJ+pHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716999760; c=relaxed/simple;
	bh=0N8WwniUWLzXIUhUFVHN1Xwhqc4YYBcv14U5W5AqVOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKDuvtARsIUx0OyCF79kHgwSYF47xnUWBlA/lQyPLuzszjtsnuM0QTSCTj3M/OfYLgpzPG5oe+ENrNZoLeN2dkomLMLnNotVSb/zyc+ORdIiaPzZcdWTzeRXkzkDy5Cve9xg2Y8DBlV+QFJVTMzUYbM0YA6JG0pZJ10F0I0R1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C+jo/LF8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fxPU1Bmg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C+jo/LF8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fxPU1Bmg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 19D8E205B9;
	Wed, 29 May 2024 16:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716999756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCZu6jdsDJqbFUOxgklErOVfk3nUsdlFfJQML2sSSgA=;
	b=C+jo/LF8K39lhbdaZ1p2WiJgAHG3wgS6vuKBsAsAhgae7r30juMxBVDBZ/Yv0R+zYyIR9A
	ei4L9SF6ACtq8DghCUEOMyCEUsQv5RvaLisqeaZEM/bTvcBp+zJ2e770bvSK1TZnCmU5kd
	TdwuOhqs+gxG/Awylxe9CkCJggdDS8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716999756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCZu6jdsDJqbFUOxgklErOVfk3nUsdlFfJQML2sSSgA=;
	b=fxPU1BmgKhi9azuUhIPM5e1vvALlG1xJsHEBOphIoINivX8k5AWjZZKoPQTv79aF195+r6
	wzbRYW7fVSp9SzDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716999756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCZu6jdsDJqbFUOxgklErOVfk3nUsdlFfJQML2sSSgA=;
	b=C+jo/LF8K39lhbdaZ1p2WiJgAHG3wgS6vuKBsAsAhgae7r30juMxBVDBZ/Yv0R+zYyIR9A
	ei4L9SF6ACtq8DghCUEOMyCEUsQv5RvaLisqeaZEM/bTvcBp+zJ2e770bvSK1TZnCmU5kd
	TdwuOhqs+gxG/Awylxe9CkCJggdDS8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716999756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCZu6jdsDJqbFUOxgklErOVfk3nUsdlFfJQML2sSSgA=;
	b=fxPU1BmgKhi9azuUhIPM5e1vvALlG1xJsHEBOphIoINivX8k5AWjZZKoPQTv79aF195+r6
	wzbRYW7fVSp9SzDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B55B1372E;
	Wed, 29 May 2024 16:22:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RxQ+AkxWV2ZOBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 29 May 2024 16:22:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9BA1AA082D; Wed, 29 May 2024 18:22:35 +0200 (CEST)
Date: Wed, 29 May 2024 18:22:35 +0200
From: Jan Kara <jack@suse.cz>
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs/file: fix the check in find_next_fd()
Message-ID: <20240529162235.b76ywqisawmcm22o@quack3>
References: <20240529160656.209352-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529160656.209352-1-yuntao.wang@linux.dev>
X-Spam-Flag: NO
X-Spam-Score: -3.72
X-Spam-Level: 
X-Spamd-Result: default: False [-3.72 / 50.00];
	BAYES_HAM(-2.92)[99.67%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]

On Thu 30-05-24 00:06:56, Yuntao Wang wrote:
> The maximum possible return value of find_next_zero_bit(fdt->full_fds_bits,
> maxbit, bitbit) is maxbit. This return value, multiplied by BITS_PER_LONG,
> gives the value of bitbit, which can never be greater than maxfd, it can
> only be equal to maxfd at most, so the following check 'if (bitbit > maxfd)'
> will never be true.
> 
> Moreover, when bitbit equals maxfd, it indicates that there are no unused
> fds, and the function can directly return.
> 
> Fix this check.
> 
> Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>

Good point. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 8076aef9c210..7058901a2154 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -491,7 +491,7 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
>  	unsigned int bitbit = start / BITS_PER_LONG;
>  
>  	bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
> -	if (bitbit > maxfd)
> +	if (bitbit >= maxfd)
>  		return maxfd;
>  	if (bitbit > start)
>  		start = bitbit;
> -- 
> 2.45.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

