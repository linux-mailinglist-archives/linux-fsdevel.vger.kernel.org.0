Return-Path: <linux-fsdevel+bounces-50740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD8CACF12F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 15:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 187D67AB93E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 13:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DCA25E82E;
	Thu,  5 Jun 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RZv/4Yiq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RtMzMSwH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oQR2qWjD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5TH0s2EQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC325F97D
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131052; cv=none; b=EMsd8+wDsihZtOKtuOtm+7jXMJQES6TjnjxJf2eVA3r+marhlRCxZirJyMukgZRKGBKi/b0RK4okSX94y+IOZPk0oTowM+XEuh2D5jrjtLaCaWOxkZUMNTwJHNBS+156dFOD3UO2iYgarZnnyVGkHp1DGaVryZtVjDmyWUbLiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131052; c=relaxed/simple;
	bh=KmeuWrYaeqlbzsLSlP0URgmbeXEVd8dunrIQASpwYi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDQ2/de4gNXH017UIoESSE3E6AwadSsoP04+AifYZNqG8NQ3jA2frTrDf6sfm4iHptnslM2xpfJ3D7hLCTgtObojsCLzt0PRkLGRPbTKbeocN1jSauEWNZspvlqh/Qe17+dQHnw9MmLMntpFaSuvCtYYyAS/d+VH8fwVbPpXvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RZv/4Yiq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RtMzMSwH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oQR2qWjD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5TH0s2EQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D8200338A9;
	Thu,  5 Jun 2025 13:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749131049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Q/1NeIpiqpokheil1LdXghXLK2h5aS6Q3dL3jQpNW8=;
	b=RZv/4YiqWxDiwipBan62hUBciJbqCQVAsyog130PxpD8OvC6ZGMTRrTtNt4qfloU1c+79A
	GHyEzUfZZq+1lQSf+qnSeUhFgnu6ow0QnacKQ3268RbHqKZ4FEA1VB2h/dzcphFBJC/jI5
	qe0ExLElasygBKV6uKIdufDF/fLB3XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749131049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Q/1NeIpiqpokheil1LdXghXLK2h5aS6Q3dL3jQpNW8=;
	b=RtMzMSwH4bsX73zKDewzfqvjoISp6pJM6YcgP9fDdBUIrLcHhDMQ3O0j2z7l7qfMXyeSwg
	snXgkr7rS4w63LAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749131048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Q/1NeIpiqpokheil1LdXghXLK2h5aS6Q3dL3jQpNW8=;
	b=oQR2qWjDVvEQy8LxM+v8jsysKzPuVY0jL4Lhf8JpkmkqwY1YL1aNEKo72b4qhjSQDBn/Wz
	7M4Rk9EcXhP1YIvTIQ55oOh25rPSM/f1Eu8VG/8SbpCvOaPGOG5McGE35ImBZYQLXBDBh2
	yIT2S5yvxhDz64UlgdnC0lPyCyus78o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749131048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Q/1NeIpiqpokheil1LdXghXLK2h5aS6Q3dL3jQpNW8=;
	b=5TH0s2EQI+avncTv7xyk5CP7bgYSn3f5mMpsYU/Vf/18ATiM9nEJwx0nYhRrapdv7uei5p
	aIus9nLmp97YmKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8BB71373E;
	Thu,  5 Jun 2025 13:44:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c3/6MCifQWjpNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Jun 2025 13:44:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 47926A0951; Thu,  5 Jun 2025 15:44:00 +0200 (CEST)
Date: Thu, 5 Jun 2025 15:44:00 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH 4/5] ext4: fix insufficient credits calculation in
 ext4_meta_trans_blocks()
Message-ID: <i3x65oflf5uh6chfxcpbep6lvkbfmellgkm5edirg67amj6nfn@dvy3zldufkls>
References: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
 <20250530062858.458039-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530062858.458039-5-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Fri 30-05-25 14:28:57, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The calculation of journal credits in ext4_meta_trans_blocks() should
> include pextents, as each extent separately may be allocated from a
> different group and thus need to update different bitmap and group
> descriptor block.
> 
> Fixes: 0e32d8617012 ("ext4: correct the journal credits calculations of allocating blocks")
> Reported-by:: Jan Kara <jack@suse.cz>
> Closes: https://lore.kernel.org/linux-ext4/nhxfuu53wyacsrq7xqgxvgzcggyscu2tbabginahcygvmc45hy@t4fvmyeky33e/
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 1818a2a7ba8f..e7de2fafc941 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -6184,7 +6184,7 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
>  	int ret;
>  
>  	/*
> -	 * How many index and lead blocks need to touch to map @lblocks
> +	 * How many index and leaf blocks need to touch to map @lblocks
>  	 * logical blocks to @pextents physical extents?
>  	 */
>  	idxblocks = ext4_index_trans_blocks(inode, lblocks, pextents);
> @@ -6193,7 +6193,7 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
>  	 * Now let's see how many group bitmaps and group descriptors need
>  	 * to account
>  	 */
> -	groups = idxblocks;
> +	groups = idxblocks + pextents;
>  	gdpblocks = groups;
>  	if (groups > ngroups)
>  		groups = ngroups;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

