Return-Path: <linux-fsdevel+bounces-16014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FEB896D8F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 13:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D299293321
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EE013AA35;
	Wed,  3 Apr 2024 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J4Z6frUR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kz/GSfhV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8C4136E3E;
	Wed,  3 Apr 2024 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142110; cv=none; b=F3Gc7xi7w3xv5lsopgQvEpGgb5sn53IbgdI48cSSzK+2Y8iS05Y3y5M81j66GQyRpU1XwjzFRvzrA8G/A7aJvqU+lv0aDIfq9Brrexa3X2mR9/cHr7BaCZ+owFEuESQUQIJPm0OwUgqRb255WSyb8vjKrejzzzPyC7WgzXZwvQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142110; c=relaxed/simple;
	bh=9GEI1T/BIb0u7Ba49sNT+VonlJl0tLoBbS/sysht5MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cY/zN0mIYOLVa5OqfhI4LyzcwuZAE8ucfMDnV5qbn7T0N0dgwfVy2k02M4qQBlcJ+frnFLQkEfrO3d/qmXIODncHKy0guKJbfPrrUgo9fuCxB+wNiF2//dsRp7Mh8kh+5eG2J/4XCnW23l8GKDNVJ4QDBmhIFbg/TT7gzSA5rrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J4Z6frUR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kz/GSfhV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 048235C3F0;
	Wed,  3 Apr 2024 11:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712142107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FgZn5hYEs65OLn3ywWKO1gDe5MG1D6Nrstl+kPl9Poc=;
	b=J4Z6frUR/8obCyGpnSxbAb9nCV2IS78j/k203bzTcYKhseC2bgc3LfKSg/auF1VGESCERG
	Ue2SrDUnH6pB1baXHB4G/BTot8qs0+CiAsBQ2Z0mkcpT51C8zBU12RjDSdeDXDJc6AG7LE
	sWXDPwxbiDKbYGrx2ja1HkWhufrD5AA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712142107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FgZn5hYEs65OLn3ywWKO1gDe5MG1D6Nrstl+kPl9Poc=;
	b=kz/GSfhV2006TD+nW8pIrHnl05uFCu4rjoPjns2Orc6r43p7jOGz/vysjbNLq079iGKWDX
	Rylnc/LteJgdnBDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EDCF213357;
	Wed,  3 Apr 2024 11:01:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id JiMMOho3DWYHGgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 03 Apr 2024 11:01:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C8FDA0814; Wed,  3 Apr 2024 13:01:46 +0200 (CEST)
Date: Wed, 3 Apr 2024 13:01:46 +0200
From: Jan Kara <jack@suse.cz>
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/dcache: Re-use value stored to dentry->d_flags
 instead of re-reading
Message-ID: <20240403110146.axoxzqr4zwoeyyas@quack3>
References: <tencent_5E187BD0A61BA28605E85405F15228254D0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5E187BD0A61BA28605E85405F15228254D0A@qq.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.45 / 50.00];
	BAYES_HAM(-0.66)[82.76%];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.18)[-0.916];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org];
	R_DKIM_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Score: -0.45
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 048235C3F0

On Wed 03-04-24 10:10:08, linke li wrote:
> Currently, the __d_clear_type_and_inode() writes the value flags to
> dentry->d_flags, then immediately re-reads it in order to use it in a if
> statement. This re-read is useless because no other update to 
> dentry->d_flags can occur at this point.
> 
> This commit therefore re-use flags in the if statement instead of
> re-reading dentry->d_flags.
> 
> Signed-off-by: linke li <lilinke99@qq.com>

Indeed, this seems pointless and actually a bit confusing. Feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index b813528fb147..79da415d7995 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -355,7 +355,7 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
>  	flags &= ~DCACHE_ENTRY_TYPE;
>  	WRITE_ONCE(dentry->d_flags, flags);
>  	dentry->d_inode = NULL;
> -	if (dentry->d_flags & DCACHE_LRU_LIST)
> +	if (flags & DCACHE_LRU_LIST)
>  		this_cpu_inc(nr_dentry_negative);
>  }
>  
> -- 
> 2.39.3 (Apple Git-146)
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

