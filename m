Return-Path: <linux-fsdevel+bounces-45945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CC6A7FBAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0308344181C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7225269D06;
	Tue,  8 Apr 2025 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1MI2amgF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kqjvPZMD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1MI2amgF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kqjvPZMD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FFC269B07
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107408; cv=none; b=DGFbDEEIYHeCZ1X9R6jYO+n98jHZlUMKQlciU122/1K+9lptlrR/6dLn34MBfT/HfmmTsP3lzXLN3bah+btXokbQajdr8nhoc1bMBG7tDgxBzZbQOzOS5vfhEbhUTFBtzkllMEiBeubRVF0z7POzmpdSEn6BhuiOUMHxBh/t/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107408; c=relaxed/simple;
	bh=ZbiKMFf4PV/LUGL4+hit/DjgthcSwajlZipFOnsaKzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCPzcTt+z5WztsvdXv/zBDKngDF31I5+H7wBHBktMXzYNSXSJTnNu/HyOqn1VIPh6yyXANXiXZ7aREseMZ7Q/fLpN7Y/yYmKiOMr6KepjSWYqV6HSY7uhqMy8b4VTGUmfsYYWYv4R06rDhL2auzUBaJ3VI4EVWRVAputD3pZOZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1MI2amgF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kqjvPZMD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1MI2amgF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kqjvPZMD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ACCE11F388;
	Tue,  8 Apr 2025 10:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744107404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YoJPBfgQKwkrD5HYWj1muePrTJ1JAM2jotAdWxyuqs4=;
	b=1MI2amgF95nu06Dllmx9DlZUZF4Ix7531c3CAe0uJ1nsn7CWvjhLL9P0pMcy3cHzpCYuG+
	vNfE1w97YsSbI3v8ATSFs28zAWY98rSs9LuehEOV44T44lpHYru3aW8V67acFpL9CzYplQ
	UhheKCQOUHhPYhk+a56XZoE3C3WbUG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744107404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YoJPBfgQKwkrD5HYWj1muePrTJ1JAM2jotAdWxyuqs4=;
	b=kqjvPZMDq04oDLv7u7kLdby9hHcDRuRbFZjBQeA78akA/prESesWbNNqQQipIHnXjvaZBe
	J4AdoNg9hRqWTICw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1MI2amgF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kqjvPZMD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744107404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YoJPBfgQKwkrD5HYWj1muePrTJ1JAM2jotAdWxyuqs4=;
	b=1MI2amgF95nu06Dllmx9DlZUZF4Ix7531c3CAe0uJ1nsn7CWvjhLL9P0pMcy3cHzpCYuG+
	vNfE1w97YsSbI3v8ATSFs28zAWY98rSs9LuehEOV44T44lpHYru3aW8V67acFpL9CzYplQ
	UhheKCQOUHhPYhk+a56XZoE3C3WbUG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744107404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YoJPBfgQKwkrD5HYWj1muePrTJ1JAM2jotAdWxyuqs4=;
	b=kqjvPZMDq04oDLv7u7kLdby9hHcDRuRbFZjBQeA78akA/prESesWbNNqQQipIHnXjvaZBe
	J4AdoNg9hRqWTICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A206813A1E;
	Tue,  8 Apr 2025 10:16:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oYCKJ4z39GdRcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Apr 2025 10:16:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6749CA098A; Tue,  8 Apr 2025 12:16:29 +0200 (CEST)
Date: Tue, 8 Apr 2025 12:16:29 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fs: predict not having to do anything in fdput()
Message-ID: <ykqfesjfwvqvqfcrgn5cpuqdayxf3r4z235uajbd7dmcdcopqu@jaxky5vifgov>
References: <20250406235806.1637000-1-mjguzik@gmail.com>
 <20250406235806.1637000-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406235806.1637000-2-mjguzik@gmail.com>
X-Rspamd-Queue-Id: ACCE11F388
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
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 07-04-25 01:58:05, Mateusz Guzik wrote:
> This matches the annotation in fdget().
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/file.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 302f11355b10..af1768d934a0 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -59,7 +59,7 @@ static inline struct fd CLONED_FD(struct file *f)
>  
>  static inline void fdput(struct fd fd)
>  {
> -	if (fd.word & FDPUT_FPUT)
> +	if (unlikely(fd.word & FDPUT_FPUT))
>  		fput(fd_file(fd));
>  }
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

