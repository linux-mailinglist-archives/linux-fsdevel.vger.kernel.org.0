Return-Path: <linux-fsdevel+bounces-23758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98069327D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 15:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA34281D14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196C619B3DA;
	Tue, 16 Jul 2024 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J/jcdynX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ESPYQUYi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o5szPFj/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n91yOSJf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEDA18EA61;
	Tue, 16 Jul 2024 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721138159; cv=none; b=ENeXcggbGqPhgHMssVpRsf14GqoBKE072TzKm13JE+szrQ7+QPDADVHRjfb035Wf9Rz8TP9aXlh8yc/xx5d80fZkwO/aDVKScZT2rl0ZRxORw6TM0ezc8vH5mC3lPQdQQZ/yrjPrldFn8yveY8/397Igk0R2HDvvf+cq8TU4BGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721138159; c=relaxed/simple;
	bh=xNNjr4lm8MAmZlGktOKl7L+x7Gl35XoAczsi/B1pkfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEyIuW0LhqU0FGYcw5Z8a3Ua3vRRdlkpIwjJf9xmpwY1f9jpb86C3Snh8Gz3kLsr6Eb2uj4/dYUVGkoJLmxK3zJwlq3TnsXcOpcOvruLnWCPuLftOEfsoltsw2z8/pEgH/aTRH/p2AI5YgPAJ9MIWlOvuYxo7i79+D25YYrFHEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J/jcdynX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ESPYQUYi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o5szPFj/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n91yOSJf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E366F21BF3;
	Tue, 16 Jul 2024 13:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721138156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/2rua72oWvlvPXyLKA5gEZ6ut0O6TNsdIr+5vhBSck=;
	b=J/jcdynX7Fvusxe7vA5WwpyxaWef0ytoETFeNyK9+PlxytXGUp67qJzKQtfydbJ/gfOXz/
	PNHrtIONKglLNDoQ+O9IoXdi3KsQnJ0TFPOPMJrwUPYFx5BNRMthKurBTi1yUvGD82UWNl
	G0KmP5gq2r/MDbJ7ZOW4dXleMDBGCns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721138156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/2rua72oWvlvPXyLKA5gEZ6ut0O6TNsdIr+5vhBSck=;
	b=ESPYQUYigxa6qhF87KBaETSRLfnx0lqiPt0H+Qz7y02720DrFlyZGV8nqd1t73rstAaO01
	HsBJ6hic+SWfmbCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="o5szPFj/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=n91yOSJf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721138155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/2rua72oWvlvPXyLKA5gEZ6ut0O6TNsdIr+5vhBSck=;
	b=o5szPFj/Y1Wp98sda/XQfTMmKEJihFPJuduGpkrUGXyT3tHBfoDCdGrN3cqAhBkOVo/570
	/1zMO/2ConFJDb72V2+QUyYfzIJ4oEnjxV+mW9NfN1gD3UGXAurMDh3u9BdAoid8FrSE+N
	vWwUGVzxjDAF/yyq8WRl6MaNVK6sB0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721138155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/2rua72oWvlvPXyLKA5gEZ6ut0O6TNsdIr+5vhBSck=;
	b=n91yOSJfaoUhEC+yVekRAIqXPgBptTM5wYr8sxkZ1lFej4Km9J4n0VpEez9D01k2b/Njvx
	F/ApXG6tc9ANHjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C60C613795;
	Tue, 16 Jul 2024 13:55:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /wkEMOt7lmbycwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Jul 2024 13:55:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4E9E2A0987; Tue, 16 Jul 2024 15:55:55 +0200 (CEST)
Date: Tue, 16 Jul 2024 15:55:55 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	bharata@amd.com
Subject: Re: [PATCH] vfs: use RCU in ilookup
Message-ID: <20240716135555.fywhj75tkw5ogujl@quack3>
References: <20240715071324.265879-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715071324.265879-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: E366F21BF3

On Mon 15-07-24 09:13:24, Mateusz Guzik wrote:
> A soft lockup in ilookup was reported when stress-testing a 512-way
> system [1] (see [2] for full context) and it was verified that not
> taking the lock shifts issues back to mm.
> 
> [1] https://lore.kernel.org/linux-mm/56865e57-c250-44da-9713-cf1404595bcc@amd.com/
> [2] https://lore.kernel.org/linux-mm/d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com/
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> fwiw the originally sent patch to the reporter performs a lockless
> lookup first and falls back to the locked variant, but that was me
> playing overfly safe.
> 
> I would add tested-by but patches are not the same in the end.
> 
> This is the only spot which can get this fixup, everything else taking
> the lock is also using custom callbacks, so filesystems invoking such
> code will need to get patched up on case-by-case basis (but
> realistically they probably already can do RCU-only operation).
> 
>  fs/inode.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index f356fe2ec2b6..52ca063c552c 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1525,9 +1525,7 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
>  	struct hlist_head *head = inode_hashtable + hash(sb, ino);
>  	struct inode *inode;
>  again:
> -	spin_lock(&inode_hash_lock);
> -	inode = find_inode_fast(sb, head, ino, true);
> -	spin_unlock(&inode_hash_lock);
> +	inode = find_inode_fast(sb, head, ino, false);
>  
>  	if (inode) {
>  		if (IS_ERR(inode))
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

