Return-Path: <linux-fsdevel+bounces-44540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B3BA6A3C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E7E4606A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9923E224254;
	Thu, 20 Mar 2025 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SvBHbFHK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3i33QIYP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SvBHbFHK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3i33QIYP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C351DF258
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466838; cv=none; b=kmlziQAmEALP6NnLor96tENq88ic0HLdjHhFHGxdcaSxY2yXytIGHDMWtbtopW0IPN6fOtQqloWHQNvjDzqy2bpxJaDO5xJ6WJlr29ed37trV3oh8m5poAV5oSeqJWV4+Ubd5YuE9aWQ+SxWO2ryQRy1OE853XZ8kY/M3wnxTlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466838; c=relaxed/simple;
	bh=V5fHsl1+Wsx3gjE3TgqFspHEn2UUrGzi/Yhkoj0AhaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FstEIr+TIsELbBzEvsgRKfyDin07kJZcYyf5hunTjirTqQgkGMFaDc2eE6EHPMumtoYQB6Sm9DF1lgqaV6U50KFi9Cxw9y0UDAmOggaIpSCN8qDwyKAZUxxTxa2bCrBZAOmZkoUZPkBZa1pogL9kCd8e5jHuPJtV9kjT07ruNk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SvBHbFHK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3i33QIYP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SvBHbFHK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3i33QIYP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73FD41F388;
	Thu, 20 Mar 2025 10:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742466828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Hu5aG5Dj52/fX0bzhf5E053C69/7rKazk3pehl0bsI=;
	b=SvBHbFHKX5pV3WWp0/53KvNTKwUpZPZch8I0A5qjihfcn+CRJuobb4iioITV+qruZkbcND
	pFLOtdBVKMLjatNxNn2ETw7D/OcjtvARFDW+/yI23NQIv9+vHUbcZXUFqCZe0mORX7BWq5
	//xgz0CEGFqTa/Jvy2VDNGyW33GoleA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742466828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Hu5aG5Dj52/fX0bzhf5E053C69/7rKazk3pehl0bsI=;
	b=3i33QIYPSwPXzdQGSbYm+AlxO7B7k3dTl3pEPvaTq1jRchDeq4fW6Hgh3ciuwRVwjsm5N8
	NONl3lRYZIELf9Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SvBHbFHK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3i33QIYP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742466828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Hu5aG5Dj52/fX0bzhf5E053C69/7rKazk3pehl0bsI=;
	b=SvBHbFHKX5pV3WWp0/53KvNTKwUpZPZch8I0A5qjihfcn+CRJuobb4iioITV+qruZkbcND
	pFLOtdBVKMLjatNxNn2ETw7D/OcjtvARFDW+/yI23NQIv9+vHUbcZXUFqCZe0mORX7BWq5
	//xgz0CEGFqTa/Jvy2VDNGyW33GoleA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742466828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Hu5aG5Dj52/fX0bzhf5E053C69/7rKazk3pehl0bsI=;
	b=3i33QIYPSwPXzdQGSbYm+AlxO7B7k3dTl3pEPvaTq1jRchDeq4fW6Hgh3ciuwRVwjsm5N8
	NONl3lRYZIELf9Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66F02139D2;
	Thu, 20 Mar 2025 10:33:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8+24GAzv22fgDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 20 Mar 2025 10:33:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ED1A6A07B2; Thu, 20 Mar 2025 11:33:43 +0100 (CET)
Date: Thu, 20 Mar 2025 11:33:43 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: reduce work in fdget_pos()
Message-ID: <7trrmztdpoyqcbarrhir4kiayc7yrqfznfyrrt5f5flyfmgu6u@5sx3yapl7bcv>
References: <20250319215801.1870660-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319215801.1870660-1-mjguzik@gmail.com>
X-Rspamd-Queue-Id: 73FD41F388
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 19-03-25 22:58:01, Mateusz Guzik wrote:
> 1. predict the file was found
> 2. explicitly compare the ref to "one", ignoring the dead zone
> 
> The latter arguably improves the behavior to begin with. Suppose the
> count turned bad -- the previously used ref routine is going to check
> for it and return 0, indicating the count does not necessitate taking
> ->f_pos_lock. But there very well may be several users.
> 
> i.e. not paying for special-casing the dead zone improves semantics.
> 
> While here spell out each condition in a dedicated if statement. This
> has no effect on generated code.
> 
> Sizes are as follows (in bytes; gcc 13, x86-64):
> stock:		321
> likely(): 	298
> likely()+ref:	280
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> diff --git a/fs/file.c b/fs/file.c
> index ddefb5c80398..0e919bed6058 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1192,8 +1192,13 @@ struct fd fdget_raw(unsigned int fd)
>   */
>  static inline bool file_needs_f_pos_lock(struct file *file)
>  {
> -	return (file->f_mode & FMODE_ATOMIC_POS) &&
> -		(file_count(file) > 1 || file->f_op->iterate_shared);
> +	if (!(file->f_mode & FMODE_ATOMIC_POS))
> +		return false;
> +	if (__file_ref_read_raw(&file->f_ref) != FILE_REF_ONEREF)
> +		return true;
> +	if (file->f_op->iterate_shared)
> +		return true;
> +	return false;
>  }
>  
>  bool file_seek_cur_needs_f_lock(struct file *file)
> @@ -1211,7 +1216,7 @@ struct fd fdget_pos(unsigned int fd)
>  	struct fd f = fdget(fd);
>  	struct file *file = fd_file(f);
>  
> -	if (file && file_needs_f_pos_lock(file)) {
> +	if (likely(file) && file_needs_f_pos_lock(file)) {
>  		f.word |= FDPUT_POS_UNLOCK;
>  		mutex_lock(&file->f_pos_lock);
>  	}
> diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
> index 6ef92d765a66..7db62fbc0500 100644
> --- a/include/linux/file_ref.h
> +++ b/include/linux/file_ref.h
> @@ -208,4 +208,18 @@ static inline unsigned long file_ref_read(file_ref_t *ref)
>  	return c >= FILE_REF_RELEASED ? 0 : c + 1;
>  }
>  
> +/*
> + * __file_ref_read_raw - Return the value stored in ref->refcnt
> + * @ref: Pointer to the reference count
> + *
> + * Return: The raw value found in the counter
> + *
> + * A hack for file_needs_f_pos_lock(), you probably want to use
> + * file_ref_read() instead.
> + */
> +static inline unsigned long __file_ref_read_raw(file_ref_t *ref)
> +{
> +	return atomic_long_read(&ref->refcnt);
> +}
> +
>  #endif
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

