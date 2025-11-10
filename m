Return-Path: <linux-fsdevel+bounces-67666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67072C4609A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 11:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 442344E3BCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251CD307AF9;
	Mon, 10 Nov 2025 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D5z2Zj3k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g/FryuTa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D5z2Zj3k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g/FryuTa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1613064A0
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771632; cv=none; b=I7d4sRPWsGfyzI8cd+RW7xxMyh1c3B/iRSOabby9Z3QZGbfxfYtkKoUZtmDd5zT746wheIcNQ/JyPxwGtmXvAQMYjclXv/dxftMGPrOtF34klXk47rclugM01tnNV6n/m+wmITtSUqiUDp+G29Mzb5IHvcLtj+aI0Ns6M05x4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771632; c=relaxed/simple;
	bh=6kB2xULq4VPSE5R+aPnRvDtU8g6MexsPT65jN9gJrQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGGlphr3tsRV8+BqpynSdaWe+9z137/TNwA7TIQ3eV7JksV+5Mm0IlhSmeBROpreJ80Vq7d080pj4ZTe9h0S724puUVmt8GPHbIrsZH5qF3o7nvChM5qivKJfKgU+Wjz0nGPvDhdGVWaZrzZZBfluQigbt4TjdPvPf99aAuOyns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D5z2Zj3k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g/FryuTa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D5z2Zj3k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g/FryuTa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B105C1F397;
	Mon, 10 Nov 2025 10:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762771628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oSaZ6VaP53rMXohoSY8aRFtwHLcuaZ0UuLm83kEe00Q=;
	b=D5z2Zj3kBt9WgPrnaB2gQFSfdAhMb3jBFz8mhv9valKRwfzqAHOVZxXtnxximDNt3uR6d0
	6X5Xp5BWQrSwj+UF2I5zH3B7zP/jOkRo7UVZYG6HS3N0HJNud5xfsD3Yk9IqIzm5PdEKAA
	Pjt+QLHoEGK2GzT0dDAb+oeC504ciIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762771628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oSaZ6VaP53rMXohoSY8aRFtwHLcuaZ0UuLm83kEe00Q=;
	b=g/FryuTai35RXBh9o//OftRdb3bEZnSTDyiOwWDJtu2nUjF8SOZ6gG7dNGmnKU0CYuQQsY
	WmfhSIYkE7pdz7Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=D5z2Zj3k;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="g/FryuTa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762771628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oSaZ6VaP53rMXohoSY8aRFtwHLcuaZ0UuLm83kEe00Q=;
	b=D5z2Zj3kBt9WgPrnaB2gQFSfdAhMb3jBFz8mhv9valKRwfzqAHOVZxXtnxximDNt3uR6d0
	6X5Xp5BWQrSwj+UF2I5zH3B7zP/jOkRo7UVZYG6HS3N0HJNud5xfsD3Yk9IqIzm5PdEKAA
	Pjt+QLHoEGK2GzT0dDAb+oeC504ciIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762771628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oSaZ6VaP53rMXohoSY8aRFtwHLcuaZ0UuLm83kEe00Q=;
	b=g/FryuTai35RXBh9o//OftRdb3bEZnSTDyiOwWDJtu2nUjF8SOZ6gG7dNGmnKU0CYuQQsY
	WmfhSIYkE7pdz7Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A53E914359;
	Mon, 10 Nov 2025 10:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id po9SKKzCEWkmNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Nov 2025 10:47:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5F44CA28B1; Mon, 10 Nov 2025 11:47:08 +0100 (CET)
Date: Mon, 10 Nov 2025 11:47:08 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: move inode fields used during fast path lookup
 closer together
Message-ID: <x72nqrebxd5ng6gfxkmod2arzoplm27su2lscyhk6pp2e54zmm@nvnfxzr4lxss>
References: <20251109121931.1285366-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109121931.1285366-1-mjguzik@gmail.com>
X-Rspamd-Queue-Id: B105C1F397
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Sun 09-11-25 13:19:31, Mateusz Guzik wrote:
> This should avoid *some* cache misses.
> 
> Successful path lookup is guaranteed to load at least ->i_mode,
> ->i_opflags and ->i_acl. At the same time the common case will avoid
> looking at more fields.
> 
> struct inode is not guaranteed to have any particular alignment, notably
> ext4 has it only aligned to 8 bytes meaning nearby fields might happen
> to be on the same or only adjacent cache lines depending on luck (or no
> luck).
> 
> According to pahole:
>         umode_t                    i_mode;               /*     0     2 */
>         short unsigned int         i_opflags;            /*     2     2 */
>         kuid_t                     i_uid;                /*     4     4 */
>         kgid_t                     i_gid;                /*     8     4 */
>         unsigned int               i_flags;              /*    12     4 */
>         struct posix_acl *         i_acl;                /*    16     8 */
>         struct posix_acl *         i_default_acl;        /*    24     8 */
> 
> ->i_acl is unnecessarily separated by 8 bytes from the other fields.
> With struct inode being offset 48 bytes into the cacheline this means an
> avoidable miss. Note it will still be there for the 56 byte case.
> 
> New layout:
>         umode_t                    i_mode;               /*     0     2 */
>         short unsigned int         i_opflags;            /*     2     2 */
>         unsigned int               i_flags;              /*     4     4 */
>         struct posix_acl *         i_acl;                /*     8     8 */
>         struct posix_acl *         i_default_acl;        /*    16     8 */
>         kuid_t                     i_uid;                /*    24     4 */
>         kgid_t                     i_gid;                /*    28     4 */
> 
> I verified with pahole there are no size or hole changes.
> 
> This is stopgap until someone(tm) sanitizes the layout in the first
> place, allocation methods aside.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks sensible. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> > Successful path lookup is guaranteed to load at least ->i_mode,
> > ->i_opflags and ->i_acl. At the same time the common case will avoid
> > looking at more fields.
> 
> While this is readily apparent with my patch to add dedicated MAY_EXEC
> handling, this is already true for the stock kernel.
> 
>  include/linux/fs.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index bd0740e3bfcb..314a1349747b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -790,14 +790,13 @@ struct inode_state_flags {
>  struct inode {
>  	umode_t			i_mode;
>  	unsigned short		i_opflags;
> -	kuid_t			i_uid;
> -	kgid_t			i_gid;
>  	unsigned int		i_flags;
> -
>  #ifdef CONFIG_FS_POSIX_ACL
>  	struct posix_acl	*i_acl;
>  	struct posix_acl	*i_default_acl;
>  #endif
> +	kuid_t			i_uid;
> +	kgid_t			i_gid;
>  
>  	const struct inode_operations	*i_op;
>  	struct super_block	*i_sb;
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

