Return-Path: <linux-fsdevel+bounces-41195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F63A2C35B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA5F3A9F90
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 13:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00B91EE7B1;
	Fri,  7 Feb 2025 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XfxMA52n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c4sBT9Fu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AJwhA2FN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PNp4UKkA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F689454;
	Fri,  7 Feb 2025 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738934177; cv=none; b=DgC48jJx3tQ73yDm9u8REqaKVBXMrspBLHwjjLclwSEZzLEWHpCl6PNOcppxMzw+YT1H6BAQfki8px3LMpUHOFJVXjTqxOiKAXN42NVc+dLUgoV1eG3CYsVMau3+ki2JnGnSvlRVcJEEgT3BqYtg2Gnp7V+auvyLYc33F8UZ84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738934177; c=relaxed/simple;
	bh=ad6L8KZhhlFlWsOnfNIyBsWkUcMfnbzE+H5rfDNcp38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+FVW2WTev0qdF4laYKyiYn+b7KKBtVReLcd+RYcniFx89x4hmgzvgmwVDsIeOvHvP76BkulzOUiIF8jREKzZdK3ARnDyeIm/P/621++62mkg6bK8XoTZtXCYI7BZ9U3DQsk3WqSbsVWLpcklZejIXsuJoOXdOkHYCpz0vuwsp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XfxMA52n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c4sBT9Fu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AJwhA2FN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PNp4UKkA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98BAA1F443;
	Fri,  7 Feb 2025 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738934173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/z4w9FGJlh+2dG3QbW9TFILDEBApf7exFWfy+0L2cjk=;
	b=XfxMA52n1s1Gs6p0cIN/k+tnqNsUp+iYM4FoP5RTWbn5YGJ/eHKp/TlShFtu7t6AtAi2Co
	OpB8H3SFLE08GVzgY3KU5PntCFAGM/6RJbY+iAmIOkDUbJD6qXnvBoA+pXMe4njH9Bvu+Q
	s38EVY8IGljURkd4tYKvyuZ8fWIZ+og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738934173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/z4w9FGJlh+2dG3QbW9TFILDEBApf7exFWfy+0L2cjk=;
	b=c4sBT9FuvWAmEVbiOPAmdIHon4UDjgNkrgLEAVFbcT7fPxvQ17yR79770niwnpi3VmMIgU
	xQOpZWirLyXKojCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738934172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/z4w9FGJlh+2dG3QbW9TFILDEBApf7exFWfy+0L2cjk=;
	b=AJwhA2FNGE2Q90rp06MDdf6+5N8kZYHtEJIZ1RbcoW9MOEiDTFB1AAiugTbD+f06sucQX8
	DSO6N9gtulWVX2zIaB9QN5AaJn7ign88LdYU2NU1iZQhS14/oFrnCjkvvHywrlRZZmUDJ1
	F6sPwE0I4ym419rHRi+d8IZ2YQf4Jzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738934172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/z4w9FGJlh+2dG3QbW9TFILDEBApf7exFWfy+0L2cjk=;
	b=PNp4UKkATY7ZJk4eFZz496eSEAsS6EPmNAd+lp2fv11yIo96bUECcgwGOUc31p4AFdXzjI
	TCxzzQzpR1v+pFBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8934513694;
	Fri,  7 Feb 2025 13:16:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ILR9IZwHpmexJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 07 Feb 2025 13:16:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2908BA28E7; Fri,  7 Feb 2025 14:16:12 +0100 (CET)
Date: Fri, 7 Feb 2025 14:16:12 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] vfs: use the new debug macros in
 inode_set_cached_link()
Message-ID: <wbwbg2iwmdrzaivcgove6id23kz7bpxly4ez4ifiyv6mpjgkje@52zoibdf4hzr>
References: <20250206170307.451403-1-mjguzik@gmail.com>
 <20250206170307.451403-4-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206170307.451403-4-mjguzik@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 06-02-25 18:03:07, Mateusz Guzik wrote:
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 034745af9702..e71d58c7f59c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -792,19 +792,8 @@ struct inode {
>  
>  static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
>  {
> -	int testlen;
> -
> -	/*
> -	 * TODO: patch it into a debug-only check if relevant macros show up.
> -	 * In the meantime, since we are suffering strlen even on production kernels
> -	 * to find the right length, do a fixup if the wrong value got passed.
> -	 */
> -	testlen = strlen(link);
> -	if (testlen != linklen) {
> -		WARN_ONCE(1, "bad length passed for symlink [%s] (got %d, expected %d)",
> -			  link, linklen, testlen);
> -		linklen = testlen;
> -	}
> +	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
> +	VFS_WARN_ON_INODE(inode->i_opflags & IOP_CACHED_LINK, inode);
>  	inode->i_link = link;
>  	inode->i_linklen = linklen;
>  	inode->i_opflags |= IOP_CACHED_LINK;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

