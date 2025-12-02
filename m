Return-Path: <linux-fsdevel+bounces-70445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 492BCC9B28A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 11:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70EF6344B07
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 10:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7144430FC13;
	Tue,  2 Dec 2025 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IyaBy9iV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OuW1AB55";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IyaBy9iV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OuW1AB55"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F3430E829
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764671355; cv=none; b=PKWiWFw/5rnRfIahKxFBQVI1QvI4KIMxzkTei3qZH892RZOoOud5JQJX/TnTBmaxG2oW1KCEed6xzOiR6TRbYhoTDtMCwDhbmYTRaILIvRVa6+9hcK5pAILQiaeVAjfytCkkn+8XGQlfi2zcBHM1nCW72lVgCljG6Vg86cTtivY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764671355; c=relaxed/simple;
	bh=8A3zOnuKcLVQ24fxaojjlh+OCeznCYArMYOKxpJdV4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q70mvmFbk2KHinycNyd9bF6BhS9xAiN1jl2T/AUuw9pjcNEdNvmreKPuKm0kpsJRBtw/TUja9/yIVswQOR/QWaR4h296NQXyixmx0wT54mp3UUuhenfQt8fuaKtKQ/Dw48sbOOKD5Yfai1I3f0CWHSpAqU5USnwYr5oyKRmDmo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IyaBy9iV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OuW1AB55; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IyaBy9iV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OuW1AB55; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 43B775BCCC;
	Tue,  2 Dec 2025 10:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764671351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nltPjKPbUe+vCrYxLsRYqAP0CLvOVJnuoldxqSp003Q=;
	b=IyaBy9iVJ6/CO46iaXpGv6Orx+HpnjB/nC5HTf3x5HR/ISa6HGG51sksfnpS89bAgJmVqy
	EYUFAhpYaPcrnBSnzc/rM0xLI7uNdsjPVUdFWz6nYc2HBAux3wXsWM/p00SSdkwOs6nYJC
	viBr0HCO/Y1ZSi1TV6F5j84mX6sxuNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764671351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nltPjKPbUe+vCrYxLsRYqAP0CLvOVJnuoldxqSp003Q=;
	b=OuW1AB551W6eFwtS9N1gjxaXvE/6s4cdEPabEv6sFfSuw0aEh2EnhqZVMzkcU+HaB5pm7T
	/ElwEkVskvIYsnBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IyaBy9iV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OuW1AB55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764671351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nltPjKPbUe+vCrYxLsRYqAP0CLvOVJnuoldxqSp003Q=;
	b=IyaBy9iVJ6/CO46iaXpGv6Orx+HpnjB/nC5HTf3x5HR/ISa6HGG51sksfnpS89bAgJmVqy
	EYUFAhpYaPcrnBSnzc/rM0xLI7uNdsjPVUdFWz6nYc2HBAux3wXsWM/p00SSdkwOs6nYJC
	viBr0HCO/Y1ZSi1TV6F5j84mX6sxuNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764671351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nltPjKPbUe+vCrYxLsRYqAP0CLvOVJnuoldxqSp003Q=;
	b=OuW1AB551W6eFwtS9N1gjxaXvE/6s4cdEPabEv6sFfSuw0aEh2EnhqZVMzkcU+HaB5pm7T
	/ElwEkVskvIYsnBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2ED443EA63;
	Tue,  2 Dec 2025 10:29:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qa5hC3e/LmnpGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Dec 2025 10:29:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DD964A09DA; Tue,  2 Dec 2025 11:29:10 +0100 (CET)
Date: Tue, 2 Dec 2025 11:29:10 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: assert on I_FREEING not being set in iput() and
 iput_not_last()
Message-ID: <y4z3hvwqmae5yngcqjivli2sddyza6hwni4gcmkgpbbz2ojaqd@gqrewfuy3alv>
References: <20251201132037.22835-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201132037.22835-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 43B775BCCC
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Mon 01-12-25 14:20:37, Mateusz Guzik wrote:
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index cc8265cfe80e..521383223d8a 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1968,7 +1968,7 @@ void iput(struct inode *inode)
>  
>  retry:
>  	lockdep_assert_not_held(&inode->i_lock);
> -	VFS_BUG_ON_INODE(inode_state_read_once(inode) & I_CLEAR, inode);
> +	VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_CLEAR), inode);
>  	/*
>  	 * Note this assert is technically racy as if the count is bogusly
>  	 * equal to one, then two CPUs racing to further drop it can both
> @@ -2010,6 +2010,7 @@ EXPORT_SYMBOL(iput);
>   */
>  void iput_not_last(struct inode *inode)
>  {
> +	VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_CLEAR), inode);
>  	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 2, inode);
>  
>  	WARN_ON(atomic_sub_return(1, &inode->i_count) == 0);
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

