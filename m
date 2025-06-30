Return-Path: <linux-fsdevel+bounces-53322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5F5AED9C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 12:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61E91765D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3401A258CC4;
	Mon, 30 Jun 2025 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lpGgUkvn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vdN64Uls";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lpGgUkvn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vdN64Uls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548DA254846
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751279150; cv=none; b=Vc5t2d+QQOcRo3hVDbYggHT9gBmdCqIAEFHUomaif4bEJCx018brF6LKOuKh79i7csC6MhtQR1nfqKkEfd8bcvA0v1aJz1Urk+XKwMaYkglpiaQI6aeSRqa4aQmuAS2twHH42Rv3OWij3ingvDUyK1a9374PLUD/14Z09kriPhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751279150; c=relaxed/simple;
	bh=7Bk8KYz+4mlTNgeg030g4WguYTJYVRalANAqyvBe4Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjDyrbBrorocYZ+CBz4i6xyUdS2F8Kp4QyxCPfw1zwli9Bf9eDAlX4Y1EgM4xjBnNBoYZT8/XijSW9zEydQRl8RLjjkJm9dTiEgbJvpF5pMMb0U0qqE6z9LWP1BvPVUE6sdKUZitaDy6ld5vvF8OLBE8UpEynAQ6LOqArdtIvA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lpGgUkvn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vdN64Uls; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lpGgUkvn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vdN64Uls; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54EC621161;
	Mon, 30 Jun 2025 10:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751279146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XKAzHcA0Oh6qymDSIW81tbTOgvwE9rhf9erEuzP/cwY=;
	b=lpGgUkvncKLtZocSFLNlIBJu0yj4GaPPIaqKdYYQYC+olYGDLwrpNkssXJNaU8Hk6d7OH/
	DiNwr1kHp79BOx+oYi+nYBbGONFoN0exEPHbqMDwNiQgtwjTVJu6hkq7omBdmRoyAPWggx
	ZNQWiDLLNQQbMC4NZaL62wcExOeCps0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751279146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XKAzHcA0Oh6qymDSIW81tbTOgvwE9rhf9erEuzP/cwY=;
	b=vdN64UlsP1Dcl+WbEvACZncooGcqvR0Huz7Y1n4/rBzpqPMiMgfSTZ50giMn2TDJYnCcxT
	zg57tf+mvHHQwYAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751279146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XKAzHcA0Oh6qymDSIW81tbTOgvwE9rhf9erEuzP/cwY=;
	b=lpGgUkvncKLtZocSFLNlIBJu0yj4GaPPIaqKdYYQYC+olYGDLwrpNkssXJNaU8Hk6d7OH/
	DiNwr1kHp79BOx+oYi+nYBbGONFoN0exEPHbqMDwNiQgtwjTVJu6hkq7omBdmRoyAPWggx
	ZNQWiDLLNQQbMC4NZaL62wcExOeCps0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751279146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XKAzHcA0Oh6qymDSIW81tbTOgvwE9rhf9erEuzP/cwY=;
	b=vdN64UlsP1Dcl+WbEvACZncooGcqvR0Huz7Y1n4/rBzpqPMiMgfSTZ50giMn2TDJYnCcxT
	zg57tf+mvHHQwYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 471A61399F;
	Mon, 30 Jun 2025 10:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ofdTESpmYmh5IgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Jun 2025 10:25:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F0758A0A31; Mon, 30 Jun 2025 12:25:45 +0200 (CEST)
Date: Mon, 30 Jun 2025 12:25:45 +0200
From: Jan Kara <jack@suse.cz>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	mcgrof@kernel.org, Christian Brauner <brauner@kernel.org>, 
	Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gost.dev@samsung.com, kernel@pankajraghav.com, Zhang Yi <yi.zhang@huawei.com>
Subject: Re: [PATCH] fs/libfs: don't assume blocksize <= PAGE_SIZE in
 generic_check_addressable
Message-ID: <t5ijc2nwhq67s5hp6rtpzs3rgdtnunacoj3vnr7pjcwynw7ue3@jlv4abixb2wx>
References: <20250630101509.212291-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630101509.212291-1-p.raghav@samsung.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,samsung.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 30-06-25 12:15:09, Pankaj Raghav wrote:
> Since [1], it is possible for filesystems to have blocksize > PAGE_SIZE
> of the system.
> 
> Remove the assumption and make the check generic for all blocksizes in
> generic_check_addressable().
> 
> [1] https://lore.kernel.org/linux-xfs/20240822135018.1931258-1-kernel@pankajraghav.com/
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

One style nit below:

> diff --git a/fs/libfs.c b/fs/libfs.c
> index 4d1862f589e8..81756dc0be6d 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1584,13 +1584,17 @@ EXPORT_SYMBOL(generic_file_fsync);
>  int generic_check_addressable(unsigned blocksize_bits, u64 num_blocks)
>  {
>  	u64 last_fs_block = num_blocks - 1;
> -	u64 last_fs_page =
> -		last_fs_block >> (PAGE_SHIFT - blocksize_bits);
> +	u64 last_fs_page, max_bytes;
> +
> +	if (check_shl_overflow(num_blocks, blocksize_bits, &max_bytes))
> +		return -EFBIG;
> +
> +	last_fs_page = (max_bytes >> PAGE_SHIFT) - 1;
>  
>  	if (unlikely(num_blocks == 0))
>  		return 0;
>  
> -	if ((blocksize_bits < 9) || (blocksize_bits > PAGE_SHIFT))
> +	if ((blocksize_bits < 9))
            ^ extra parentheses here

>  		return -EINVAL;
>  
>  	if ((last_fs_block > (sector_t)(~0ULL) >> (blocksize_bits - 9)) ||
> 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

