Return-Path: <linux-fsdevel+bounces-78727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO4DAnK2oWnmvwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:21:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D91511B9A69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1735318850E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C4F43635C;
	Fri, 27 Feb 2026 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="McM9intw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nPhduoPp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="McM9intw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nPhduoPp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE7C2E92D4
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205324; cv=none; b=bmbjVStckr7iNxwKeeWmTfx+FGuoxKf2K6KNgShLL0RFt0Y3aJLOOCY4yBzWRCT+D7xhno49v304TBpTa7ILFORRvBk2BnitIBY8UTleSPPjb9gYITEu42seO2TPe1oddeXISWhYvHl7E9xQLru7yzPLoV2iJID5LPWpqZmFsnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205324; c=relaxed/simple;
	bh=TUEnVQ+e6E/cvMi/ybZM8Jup4/PB0ad2mr8lILYEP1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwFAbAL5OvtwxWvHPPwOWagpFcNJDg5sropgIz+V0FepV3xhcwni1uMfvpZp4VfiVCx7xJ7Ly6uU2hIiGYXQQpwnXQxJOwagIOPvdZsV6cUKTDS7LrbDbnL3R4Jn8xi9LqeW/rmxetygImfwWS6gSJ3Rg+9MVYcTFU48N1cid6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=McM9intw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nPhduoPp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=McM9intw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nPhduoPp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F4145CD90;
	Fri, 27 Feb 2026 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772205321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n16DyrXNQJJWW+Jr2xePFGtnXxpA3QEZ+Wy5qwxXsU8=;
	b=McM9intw4dirxWmBikLUCFafM+qqOFKvkFzEzBQKIUIUo01I5KXX+IugLybO2xPitFE12y
	HYyw4WAS9OlflHpr6gRLel2LZHMVO6Bn6ar2N/CSETqJAFRxTCl9mZgE0Kp+D/5SwWaJuU
	JxeSRcRje66izI0nDY9WuHAnvrtwjdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772205321;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n16DyrXNQJJWW+Jr2xePFGtnXxpA3QEZ+Wy5qwxXsU8=;
	b=nPhduoPpt1VRceBdX36AOVfehD+5hdYNO3nYAZqf9TK0TM9u9kzDkUkPT//+UfWFUmdzsF
	JWnydrZzTp4qJJCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=McM9intw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nPhduoPp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772205321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n16DyrXNQJJWW+Jr2xePFGtnXxpA3QEZ+Wy5qwxXsU8=;
	b=McM9intw4dirxWmBikLUCFafM+qqOFKvkFzEzBQKIUIUo01I5KXX+IugLybO2xPitFE12y
	HYyw4WAS9OlflHpr6gRLel2LZHMVO6Bn6ar2N/CSETqJAFRxTCl9mZgE0Kp+D/5SwWaJuU
	JxeSRcRje66izI0nDY9WuHAnvrtwjdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772205321;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n16DyrXNQJJWW+Jr2xePFGtnXxpA3QEZ+Wy5qwxXsU8=;
	b=nPhduoPpt1VRceBdX36AOVfehD+5hdYNO3nYAZqf9TK0TM9u9kzDkUkPT//+UfWFUmdzsF
	JWnydrZzTp4qJJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EA413EA69;
	Fri, 27 Feb 2026 15:15:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l+XJIgm1oWk7GwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 15:15:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5A184A06D4; Fri, 27 Feb 2026 16:15:17 +0100 (CET)
Date: Fri, 27 Feb 2026 16:15:17 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 07/14] xattr: add xattr_permission_error()
Message-ID: <hexzz2e3fgb7ww2xzs4vf44od4dkbdhrcbfccscdz3gbf72dug@vzpbafbt7tzl>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-7-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-work-xattr-socket-v1-7-c2efa4f74cb7@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78727-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: D91511B9A69
X-Rspamd-Action: no action

On Mon 16-02-26 14:32:03, Christian Brauner wrote:
> Stop repeating the ?: in multiple places and use a simple helper for
> this.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/xattr.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 64803097e1dc..c4db8663c32e 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -106,6 +106,13 @@ int may_write_xattr(struct mnt_idmap *idmap, struct inode *inode)
>  	return 0;
>  }
>  
> +static inline int xattr_permission_error(int mask)
> +{
> +	if (mask & MAY_WRITE)
> +		return -EPERM;
> +	return -ENODATA;
> +}
> +
>  /*
>   * Check permissions for extended attribute access.  This is a bit complicated
>   * because different namespaces have very different rules.
> @@ -135,7 +142,7 @@ xattr_permission(struct mnt_idmap *idmap, struct inode *inode,
>  	 */
>  	if (!strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN)) {
>  		if (!capable(CAP_SYS_ADMIN))
> -			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
> +			return xattr_permission_error(mask);
>  		return 0;
>  	}
>  
> @@ -146,7 +153,7 @@ xattr_permission(struct mnt_idmap *idmap, struct inode *inode,
>  	 */
>  	if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)) {
>  		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> -			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
> +			return xattr_permission_error(mask);
>  		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
>  		    (mask & MAY_WRITE) &&
>  		    !inode_owner_or_capable(idmap, inode))
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

