Return-Path: <linux-fsdevel+bounces-66945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ECEC30FF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E530634D696
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B872EF64F;
	Tue,  4 Nov 2025 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gx4o2sOw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vow9pMVP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zwFZ1DBS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1gL6Hy3z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5C2D5938
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259559; cv=none; b=FMoeF4tJnxHYrxS0X7k+GVOnM4nzYLcCq0JVlwkqct56thgh6RWkVTFHXfUqlZN1nZTP28PXI1xvKlAp9fMI7rehQWVL1g82PxxpqK2uynrsMwbiEhjeaFCr3Imux1EVEMtXhVF/zgKz1tB46ozE++VtqEQzS1bcMKCHcIfoQqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259559; c=relaxed/simple;
	bh=NJE+vfTfgfj/EUtcMYHZXNMi1RLJXxQBduw+z1XNFxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bB/4uLd6BIslzPRZE9wYT7RN+Kd3kkEY4eV6QTv0+VGJ3cGpV2FBtSSkRBQK6ojFGy+vvD4NwfbFAzt4Ddkyv51VwGGVOB59fjjRosqSIqkVN8OABCR6Mo6frklCdOGhrtdHYI9Ra1RzWbbpAL+cG5adF7hEFuNythPVlFdwlmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gx4o2sOw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vow9pMVP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zwFZ1DBS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1gL6Hy3z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 993EE211BA;
	Tue,  4 Nov 2025 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762259555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YE5+k0V1VuDoT27DY4Y8pJ+4L58ibqvTkOEKOb/b8dM=;
	b=gx4o2sOwV/RlEEaMKBxK2dj0gTtmafrIb4oXtPH66F1O20rpYjSGv0HYm5LEc0JkJyl33U
	z28wKiUQWKgZhXyJvBBVlOcUDTn0B6LsXzE2+2XfYQAehNtWfNJwrvo+dM5Bd9D4P/QW9q
	Q9cRWvD1RzkJbI83NCSfPRCdX9aoBQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762259555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YE5+k0V1VuDoT27DY4Y8pJ+4L58ibqvTkOEKOb/b8dM=;
	b=Vow9pMVPRVf7UZJr1RaHuD936BhIfC56FUGXC6zwvsapbrcCZPGCuoLdPqaOvaPquPjMEx
	PgZY7G0aITXm5vBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zwFZ1DBS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1gL6Hy3z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762259554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YE5+k0V1VuDoT27DY4Y8pJ+4L58ibqvTkOEKOb/b8dM=;
	b=zwFZ1DBSpCAP6F4+ipYPO5gnPicHzMPCsX1Adplf+yZN6Gfj0wKVjU+pF2ID+vlaNW2IfR
	la1Ylgz1tOjL8RL7B9luyAwpUB0BpXigT96zT0i0LVle511CmULXai6uuw3CIDng7J3qHi
	EEjWVS6riz3/RylwKqYGp1MxdP2WHOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762259554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YE5+k0V1VuDoT27DY4Y8pJ+4L58ibqvTkOEKOb/b8dM=;
	b=1gL6Hy3ze68oZYdIE9+34YEmP1WsjsFG2Ox4H/Qt7CslEij/S3Hsbx7shsn1fU3J3y+2t7
	LcrFOEGLZOrgl/Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DEE0136D1;
	Tue,  4 Nov 2025 12:32:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D/WiImLyCWn3VQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 12:32:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3D951A28E6; Tue,  4 Nov 2025 13:32:34 +0100 (CET)
Date: Tue, 4 Nov 2025 13:32:34 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 7/8] open: use super write guard in do_ftruncate()
Message-ID: <lq4acfdaiuave42srs6akk3bxmidlaqgxxgdrlgpi6rznxzu5o@2xzkxywc6s2r>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-7-5108ac78a171@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-work-guards-v1-7-5108ac78a171@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 993EE211BA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Tue 04-11-25 13:12:36, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/open.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 3d64372ecc67..1d73a17192da 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -191,12 +191,9 @@ int do_ftruncate(struct file *file, loff_t length, int small)
>  	if (error)
>  		return error;
>  
> -	sb_start_write(inode->i_sb);
> -	error = do_truncate(file_mnt_idmap(file), dentry, length,
> -			    ATTR_MTIME | ATTR_CTIME, file);
> -	sb_end_write(inode->i_sb);
> -
> -	return error;
> +	scoped_guard(super_write, inode->i_sb)
> +		return do_truncate(file_mnt_idmap(file), dentry, length,
> +				   ATTR_MTIME | ATTR_CTIME, file);
>  }
>  
>  int do_sys_ftruncate(unsigned int fd, loff_t length, int small)
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

