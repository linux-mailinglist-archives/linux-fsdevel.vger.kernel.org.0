Return-Path: <linux-fsdevel+bounces-71675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED408CCCBE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 17:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6758E301A9DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 16:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D30E376BDE;
	Thu, 18 Dec 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vCFeVmvv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ze8L9+lV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wy5fTfwJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QXKpuuaI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2876376BCC
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073640; cv=none; b=cJjICBQcHsjL4I5Karz5LuaoDGI29hVy38Yyk5tO9fhI2mlm/10ser93MI17VU+sPNPmFZ1wLP0h2Z/Nv5Xe8HhYxyLUu3LtU2SGDyqtEmWsXkOH/VgDbEq6s/ia6VUZ/j5LwYAFbJNgwxFaNAaeUMh1+fB/Ku6pwu/k0RyB/ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073640; c=relaxed/simple;
	bh=LMJVWznMkfQPO6gFuSTkCE78WJYbfXYqsSVReVi8Sh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUDk7cxh4ojeK+zAiPB8rFLpRG1TvsV4BLzj+qljBpY20P3tluqBVDB8pWTtOJbg2gEhaGF3uId4Fxl6OWPi8qyiKQCh6t4gLGDKkTSuGaZm6RnPWUDTvjm+YH4FNjE8QMS9sctiIK+2pJCePrwLTi8rB0XMSgVQ/HZ4Jt3K8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vCFeVmvv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ze8L9+lV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wy5fTfwJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QXKpuuaI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B42D33697;
	Thu, 18 Dec 2025 16:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766073634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=70dimoF0qt26PdhlsykZjFrCtPMhHRTo9s0GTpdZUK8=;
	b=vCFeVmvvCIJzKxeRYw8O5DlSFlP3edpQP6osjn1Wuwj3aIiDSuDtwd650wfa2KmzRbmh5R
	d3AY2+XhjH0EBtutr5m36z8xGTB6gk9HFUU+f2GN1WjyGw/7AIKWXyRZRwDfNTDdWBDh6U
	2u7/b6uMIRooy/gxDNmUWuorUFzer3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766073634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=70dimoF0qt26PdhlsykZjFrCtPMhHRTo9s0GTpdZUK8=;
	b=ze8L9+lV/N7v+v/3ZmnXx60xYdH4PLTvmYb/msVusaBgCRJJVn2BfG3WiBx7xT7UiMA1fl
	m9INDEE6Hhd0/1Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Wy5fTfwJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QXKpuuaI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766073633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=70dimoF0qt26PdhlsykZjFrCtPMhHRTo9s0GTpdZUK8=;
	b=Wy5fTfwJ+Gn1pABFA7sS2pQZhBbF40tmhYGCcyQtU9X1CLRvpWyX3bBE8Ek0HfMaNdDeSz
	M5535EqsIs1fjIyuiRSCsj5l/XzJLYzs1xx+n1QQv7dhacurSKy2GtTL/LjBXJjKCEwJyT
	P1mZl5jYseJSima2DEJghrto6llimxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766073633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=70dimoF0qt26PdhlsykZjFrCtPMhHRTo9s0GTpdZUK8=;
	b=QXKpuuaI6Y8ZQVjoEJfUFGgSCPf09gSwXoCVr5HpNaSf/WU3Mz1opROMY/TbtMBYMSRUdJ
	6AlFbJM9xBnPOGAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81CEA3EA63;
	Thu, 18 Dec 2025 16:00:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wsmqHyElRGkdJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Dec 2025 16:00:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3A544A0918; Thu, 18 Dec 2025 17:00:29 +0100 (CET)
Date: Thu, 18 Dec 2025 17:00:29 +0100
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Replace simple_strtoul with kstrtoul in
 set_ihash_entries
Message-ID: <6kdimohxkz6rdmamer7mijpu3kie2ec6lilikglyo2jvpdesqt@mu4gejir4slj>
References: <20251218112144.225301-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218112144.225301-2-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 8B42D33697
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Thu 18-12-25 12:21:45, Thorsten Blum wrote:
> Replace simple_strtoul() with the recommended kstrtoul() for parsing the
> 'ihash_entries=' boot parameter.
> 
> Check the return value of kstrtoul() and reject invalid values. This
> adds error handling while preserving behavior for existing valid values,
> and removes use of the deprecated simple_strtoul() helper.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 521383223d8a..a6df537eb856 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2531,10 +2531,7 @@ static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_lock
>  static __initdata unsigned long ihash_entries;
>  static int __init set_ihash_entries(char *str)
>  {
> -	if (!str)
> -		return 0;
> -	ihash_entries = simple_strtoul(str, &str, 0);
> -	return 1;
> +	return kstrtoul(str, 0, &ihash_entries) == 0;
>  }
>  __setup("ihash_entries=", set_ihash_entries);
>  
> -- 
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

