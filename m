Return-Path: <linux-fsdevel+bounces-75266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ai+BC9ac2nruwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:23:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A9E74F53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9470D3008E5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B50328B4E;
	Fri, 23 Jan 2026 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TxBaLp8y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xgl5h5sl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TxBaLp8y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xgl5h5sl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED082765C4
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769167401; cv=none; b=HcZ25wi4pdtBJUmpYqHexKlgkac3q2WZOIg1YIxtxAhwjZzXpRdaEoXEWDddeIIwV7dC6HCDzIOMJVFwbPSSC+R8vUtUsjc/36CIMtNlqygE3uZc7MFfEhTjWCO6lpaYbOZPXDbX/AyND1YbEwutlD4AqkaQzFnPaReeKnuoXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769167401; c=relaxed/simple;
	bh=ZaE7ZlMQOvTvG+JpG5lJyp/mvUCeTunglvTaLr7aGQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl7ExIQcXjpwXgmgRc3dFXZqwYzX1t2jWI+rZjWrdYxMcbCXtml/DoBnGyZZ2BWPkLtCMIZCJYhpJ8nAUbU5FKFIiyNU5bXtqSIgn4hDnStxv6YpwC9+BIlO1YhNmukplm49rzNC2mbDewzKhCR1e3vkBjAExm2R4S4EPr7e8vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TxBaLp8y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xgl5h5sl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TxBaLp8y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xgl5h5sl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1CE5337BD;
	Fri, 23 Jan 2026 11:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769167398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laPXRhbQffCqDMeTGHoUi06SV5IQhdxKtJs5tGMk+5Y=;
	b=TxBaLp8y5tvDNDQkhmXVQw37PyP2mDu/3RXA5ZtAyaQIS72ocSLJW6B29xXRfokHOys4HO
	hYGOmjtCvp4sCo6YWaSl153LsZpIFdd72qqIWuG1+Z3CP8rwhdB+vSpuJPFQDeDGByn1bv
	8yEhhelfz98cwpdmZKh2FHsEseh/bB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769167398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laPXRhbQffCqDMeTGHoUi06SV5IQhdxKtJs5tGMk+5Y=;
	b=Xgl5h5slp8WU40AGPEeO58FzGZ1WpDYpeNV8zB2ct7amnLONt+ojmwqleSsId5AKRJS2n5
	OBobuWeqrKg1TXDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TxBaLp8y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Xgl5h5sl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769167398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laPXRhbQffCqDMeTGHoUi06SV5IQhdxKtJs5tGMk+5Y=;
	b=TxBaLp8y5tvDNDQkhmXVQw37PyP2mDu/3RXA5ZtAyaQIS72ocSLJW6B29xXRfokHOys4HO
	hYGOmjtCvp4sCo6YWaSl153LsZpIFdd72qqIWuG1+Z3CP8rwhdB+vSpuJPFQDeDGByn1bv
	8yEhhelfz98cwpdmZKh2FHsEseh/bB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769167398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laPXRhbQffCqDMeTGHoUi06SV5IQhdxKtJs5tGMk+5Y=;
	b=Xgl5h5slp8WU40AGPEeO58FzGZ1WpDYpeNV8zB2ct7amnLONt+ojmwqleSsId5AKRJS2n5
	OBobuWeqrKg1TXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E9751395E;
	Fri, 23 Jan 2026 11:23:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ufHMIiZac2nbawAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 23 Jan 2026 11:23:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 50200A0A1B; Fri, 23 Jan 2026 12:23:18 +0100 (CET)
Date: Fri, 23 Jan 2026 12:23:18 +0100
From: Jan Kara <jack@suse.cz>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, yuanql9@chinatelecom.cn
Subject: Re: [PATCH v2] fs/file: optimize close_range() complexity from O(N)
 to O(Sparse)
Message-ID: <q6u5g43rs4jbgdfcqf4jbfi655rlpzn3wczmbew4tk5nozjvw4@imp7l33yhx6o>
References: <20260122171408.GF3183987@ZenIV>
 <20260123081221.659125-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123081221.659125-1-realwujing@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75266-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,chinatelecom.cn:email,suse.com:email,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 21A9E74F53
X-Rspamd-Action: no action

On Fri 23-01-26 03:12:21, Qiliang Yuan wrote:
> In close_range(), the kernel traditionally performs a linear scan over the
> [fd, max_fd] range, resulting in O(N) complexity where N is the range size.
> For processes with sparse FD tables, this is inefficient as it checks many
> unallocated slots.
> 
> This patch optimizes __range_close() by using find_next_bit() on the
> open_fds bitmap to skip holes. This shifts the algorithmic complexity from
> O(Range Size) to O(Active FDs), providing a significant performance boost
> for large-range close operations on sparse file descriptor tables.
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>

Thanks for the patch! It looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2:
>   - Recalculate fdt after re-acquiring file_lock to avoid UAF if the
>     table is expanded/reallocated during filp_close() or cond_resched().
> v1:
>   - Initial optimization using find_next_bit() on open_fds bitmap to
>     skip holes, improving complexity to O(Active FDs).
> 
>  fs/file.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 0a4f3bdb2dec..51ddcff0081a 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -777,23 +777,29 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
>  				 unsigned int max_fd)
>  {
>  	struct file *file;
> +	struct fdtable *fdt;
>  	unsigned n;
>  
>  	spin_lock(&files->file_lock);
> -	n = last_fd(files_fdtable(files));
> +	fdt = files_fdtable(files);
> +	n = last_fd(fdt);
>  	max_fd = min(max_fd, n);
>  
> -	for (; fd <= max_fd; fd++) {
> +	for (fd = find_next_bit(fdt->open_fds, max_fd + 1, fd);
> +	     fd <= max_fd;
> +	     fd = find_next_bit(fdt->open_fds, max_fd + 1, fd + 1)) {
>  		file = file_close_fd_locked(files, fd);
>  		if (file) {
>  			spin_unlock(&files->file_lock);
>  			filp_close(file, files);
>  			cond_resched();
>  			spin_lock(&files->file_lock);
> +			fdt = files_fdtable(files);
>  		} else if (need_resched()) {
>  			spin_unlock(&files->file_lock);
>  			cond_resched();
>  			spin_lock(&files->file_lock);
> +			fdt = files_fdtable(files);
>  		}
>  	}
>  	spin_unlock(&files->file_lock);
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

