Return-Path: <linux-fsdevel+bounces-41227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3AFA2C7D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 16:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C45037A5083
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AD323C8A6;
	Fri,  7 Feb 2025 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lNdXuABb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7g3XQoA6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lNdXuABb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7g3XQoA6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D4D23C8A5
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738943461; cv=none; b=aaP9/3zZIhEF/axduHe1g7T7Wy81IpYXBylNkLe+c1MzlXOeAHVwXFVUW+5VNcAvqbM1OSGBJPlmYLxbGYuhyNHgHpCoK6i9cxM0cqKVL/XKeSldn3UUGo7F0aTal809EWdWlfAf3u2Bls5rr828B5AWbaW1fU0NcDFeOaQqRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738943461; c=relaxed/simple;
	bh=WB7CajrSvz+5c3QtqgJUW6zOoqGOw0YJJy8daKxqnUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFrZqGeI2MhlKYDaJPdQv72h/gXVAQDDthlAouzwz7Ok++WHIs8HoA9n1k06tzACJAD7/hStlwIhqf8ixCbhjxI8ttjXdEM2F80sm9y4bjh4pCgK1aintBI4iz1fM1vvcHYbpjtGkV7F8YTK/lyQNeVIUIOuZcLAC0XkcxdWxis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lNdXuABb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7g3XQoA6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lNdXuABb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7g3XQoA6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2091D21133;
	Fri,  7 Feb 2025 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738943457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0sSB4KGjhn/L4uRWgZq/yNklplIyybujERpUfnBDMl4=;
	b=lNdXuABb7Gf1ad+Ah7MOxjrvWTb+2bwkUGY6wrJMT993zgYdGwCs3Ox5BhC7TVdmNALHYR
	0F/GOvi1mp+IlTcMaitQlAW+1rDub3/VNSpvepWeTbtKErKNlCrtWccgYw1Uist+s8AjTV
	dNEBcxysZo5F2AHEIWEwxICE676LAAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738943457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0sSB4KGjhn/L4uRWgZq/yNklplIyybujERpUfnBDMl4=;
	b=7g3XQoA6m3aSnf1ng3UB//WWthNkhZjnZvP6rMbzvTSzy6biFTI9o6SfjzGmS+To/lI/Q9
	zSjYzsehFEOrGvCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lNdXuABb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7g3XQoA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738943457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0sSB4KGjhn/L4uRWgZq/yNklplIyybujERpUfnBDMl4=;
	b=lNdXuABb7Gf1ad+Ah7MOxjrvWTb+2bwkUGY6wrJMT993zgYdGwCs3Ox5BhC7TVdmNALHYR
	0F/GOvi1mp+IlTcMaitQlAW+1rDub3/VNSpvepWeTbtKErKNlCrtWccgYw1Uist+s8AjTV
	dNEBcxysZo5F2AHEIWEwxICE676LAAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738943457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0sSB4KGjhn/L4uRWgZq/yNklplIyybujERpUfnBDMl4=;
	b=7g3XQoA6m3aSnf1ng3UB//WWthNkhZjnZvP6rMbzvTSzy6biFTI9o6SfjzGmS+To/lI/Q9
	zSjYzsehFEOrGvCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10E5413694;
	Fri,  7 Feb 2025 15:50:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YKwYBOErpmf+UwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 07 Feb 2025 15:50:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 804CFA28EB; Fri,  7 Feb 2025 16:50:52 +0100 (CET)
Date: Fri, 7 Feb 2025 16:50:52 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH] fs: don't needlessly acquire f_lock
Message-ID: <hn5go2srp6csjkckh3sgru7moukgsa3glsvc6bwd5leabzamw6@osxrfpjw5wqq>
References: <20250207-daten-mahlzeit-99d2079864fb@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-daten-mahlzeit-99d2079864fb@brauner>
X-Rspamd-Queue-Id: 2091D21133
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,suse.cz,zeniv.linux.org.uk,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 07-02-25 15:10:33, Christian Brauner wrote:
> Before 2011 there was no meaningful synchronization between
> read/readdir/write/seek. Only in commit
> ef3d0fd27e90 ("vfs: do (nearly) lockless generic_file_llseek")
> synchronization was added for SEEK_CUR by taking f_lock around
> vfs_setpos().
> 
> Then in 2014 full synchronization between read/readdir/write/seek was
> added in commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX")
> by introducing f_pos_lock for regular files with FMODE_ATOMIC_POS and
> for directories. At that point taking f_lock became unnecessary for such
> files.
> 
> So only acquire f_lock for SEEK_CUR if this isn't a file that would have
> acquired f_pos_lock if necessary.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

...

>  	if (whence == SEEK_CUR) {
> +		bool locked;
> +
>  		/*
> -		 * f_lock protects against read/modify/write race with
> -		 * other SEEK_CURs. Note that parallel writes and reads
> -		 * behave like SEEK_SET.
> +		 * If the file requires locking via f_pos_lock we know
> +		 * that mutual exclusion for SEEK_CUR on the same file
> +		 * is guaranteed. If the file isn't locked, we take
> +		 * f_lock to protect against f_pos races with other
> +		 * SEEK_CURs.
>  		 */
> -		guard(spinlock)(&file->f_lock);
> -		return vfs_setpos(file, file->f_pos + offset, maxsize);
> +		locked = (file->f_mode & FMODE_ATOMIC_POS) ||
> +			 file->f_op->iterate_shared;

As far as I understand the rationale this should match to
file_needs_f_pos_lock() (or it can possibly be weaker) but it isn't obvious
to me that's the case. After thinking about possibilities, I could convince
myself that what you suggest is indeed safe but the condition being in two
completely independent places and leading to subtle bugs if it gets out of
sync seems a bit fragile to me.

								Honza

> +		if (!locked)
> +			spin_lock(&file->f_lock);
> +		offset = vfs_setpos(file, file->f_pos + offset, maxsize);
> +		if (!locked)
> +			spin_unlock(&file->f_lock);
> +		return offset;
>  	}
>  
>  	return vfs_setpos(file, offset, maxsize);
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

