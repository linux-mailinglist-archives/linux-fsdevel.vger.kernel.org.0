Return-Path: <linux-fsdevel+bounces-78729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHaNM1S2oWm+vwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:20:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EEA1B9A36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82A80307FB6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6865943DA31;
	Fri, 27 Feb 2026 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kzk8gPWI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kdZmmjlN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kzk8gPWI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kdZmmjlN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D51A43CEE8
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205465; cv=none; b=kaN9vygn8VztewsBa1es414zILpjfDJWC2zF87+qBPU+UJeti84P6Mjb6C25085vLkgVZLNYtVXxAGhRWsPNP89B6vXF9gyJL7f2kaJ7r34Tw/cxGxO5+pY/9mMVzUgzqIb8URRv0uO9Pt6pfkmLRmVVcaBdY+gkiiBfu0Qcyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205465; c=relaxed/simple;
	bh=1EQbchnE0Xj8tyBwZky+9p52xepPD11AfXFdER2pDW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAQWkn6EnLj8ppE1DU9r2sMY8hBYKh4mY9iMNHw52dnF8HA4TnuMH8obSRGRjxkhl+U41/NoHd+jK8w4vo1tH8E7lqCafTpWYLvSl8EXIe/5gDe9jeutHW+10rnqYyHaRVn/OXztM+u/uR35H5SaRAPsjiG68jtBUdb21WubBgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kzk8gPWI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kdZmmjlN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kzk8gPWI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kdZmmjlN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D6C65C6FA;
	Fri, 27 Feb 2026 15:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772205462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1h6dSP2R/hvvqdXyOgaHEygft4A0JhA++XIXdBxaDAA=;
	b=kzk8gPWIke67mRHYIeZTdnV0jWr344Ixrz5IqeP5IIO+Y5n3kE/53ezEwVrJh9EpgoDe4K
	q7/Q+/4cTBks0IR0DGcmKi8fSGYgAnGdM1ug3/77u79xuh65V5FBcegAwYd1iOYuHMVmxm
	njUPjtue30o7ac0D3dqO9YeT1fb7XyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772205462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1h6dSP2R/hvvqdXyOgaHEygft4A0JhA++XIXdBxaDAA=;
	b=kdZmmjlND/j+ZWuvLQ3rN9lnNuW6iUXWPzobKzWqIBNyaZHr4+G66FpCj6RI+xTlfWIvpN
	BnCkBmQWLaFiXDDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772205462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1h6dSP2R/hvvqdXyOgaHEygft4A0JhA++XIXdBxaDAA=;
	b=kzk8gPWIke67mRHYIeZTdnV0jWr344Ixrz5IqeP5IIO+Y5n3kE/53ezEwVrJh9EpgoDe4K
	q7/Q+/4cTBks0IR0DGcmKi8fSGYgAnGdM1ug3/77u79xuh65V5FBcegAwYd1iOYuHMVmxm
	njUPjtue30o7ac0D3dqO9YeT1fb7XyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772205462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1h6dSP2R/hvvqdXyOgaHEygft4A0JhA++XIXdBxaDAA=;
	b=kdZmmjlND/j+ZWuvLQ3rN9lnNuW6iUXWPzobKzWqIBNyaZHr4+G66FpCj6RI+xTlfWIvpN
	BnCkBmQWLaFiXDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52E123EA69;
	Fri, 27 Feb 2026 15:17:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z3M6FJa1oWmzHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 15:17:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1B44AA06D4; Fri, 27 Feb 2026 16:17:42 +0100 (CET)
Date: Fri, 27 Feb 2026 16:17:42 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 08/14] xattr: switch xattr_permission() to switch
 statement
Message-ID: <wvsbhwgtkeq77v5p6nwctpybzrie7m37xd27j3hmpwgoyuoltv@7vqndacm67tr>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-8-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-work-xattr-socket-v1-8-c2efa4f74cb7@kernel.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78729-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A1EEA1B9A36
X-Rspamd-Action: no action

On Mon 16-02-26 14:32:04, Christian Brauner wrote:
> Simplify the codeflow by using a switch statement that switches on
> S_IFMT.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/xattr.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index c4db8663c32e..328ed7558dfc 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -152,12 +152,20 @@ xattr_permission(struct mnt_idmap *idmap, struct inode *inode,
>  	 * privileged users can write attributes.
>  	 */
>  	if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)) {
> -		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> -			return xattr_permission_error(mask);
> -		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
> -		    (mask & MAY_WRITE) &&
> -		    !inode_owner_or_capable(idmap, inode))
> +		switch (inode->i_mode & S_IFMT) {
> +		case S_IFREG:
> +			break;
> +		case S_IFDIR:
> +			if (!(inode->i_mode & S_ISVTX))
> +				break;
> +			if (!(mask & MAY_WRITE))
> +				break;
> +			if (inode_owner_or_capable(idmap, inode))
> +				break;
>  			return -EPERM;
> +		default:
> +			return xattr_permission_error(mask);
> +		}
>  	}
>  
>  	return inode_permission(idmap, inode, mask);
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

