Return-Path: <linux-fsdevel+bounces-71764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6086FCD0FC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 17:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4940300AB10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8136357A49;
	Fri, 19 Dec 2025 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E5kLKTV5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iEzaOIUn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ulz9yl/A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vFafkBbo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC3279329
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766162657; cv=none; b=iWFI5AxV+Hb1deELqAh3tHlcawXOEpInQ6OOdA3GtE3VSYjMT36TpqaT+ck9zEWmScKKtyaDzkzJ3jsvRWLrrUjvz8/VX2cSnu9KgfTiVKbHarnf2DtjxMBDajt3NUX/u9+pf+11qRyQj1pwBCL2+C20ePkcdm1NOV8vRR773dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766162657; c=relaxed/simple;
	bh=/SA8BO5pcZU7nxPkHSUjcM7veo7CHMmlsgzuRXGYpTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJatk6AJH4Brse4pyjaSt/rKsrNsELTnR3IKO4z18ixgovfkgV8vtWnBcmxiTbXwRLf6/qphk6kdOCweDPn0EWLvZwCWi+yvx8Ud4NpHTu7BpkIsACvHWc3+o7NBIKMX22n58oUbQIZ3AgFgX9SZBJi4UT8ECjnEPL8ueLdeZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E5kLKTV5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iEzaOIUn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ulz9yl/A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vFafkBbo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A70A85BD39;
	Fri, 19 Dec 2025 16:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766162653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BU2bxWjtZlWExv8F9zSmSFljkh+TvEiP7wR4/g4A3eI=;
	b=E5kLKTV5VAtBfKPeq3U28zJXlGTlUicqy1QPoII/EM9m5jbhR/oT4fcGQChaoGMgYG4nGt
	UjHF4+kz5n26gnwd3iKQzzwhzkytIE/Dbdi6BBHerFswgmlTmUiwb7sCKuy+nyZmaUvqyv
	kHHW+ZjefZWJBiJV6ZI7g3hydaa6jEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766162653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BU2bxWjtZlWExv8F9zSmSFljkh+TvEiP7wR4/g4A3eI=;
	b=iEzaOIUnVmefbuWqLwY9zKA7oNQtVBIVGms6sdZi06+zKLe6NtPATexmNcZNbOoA0Ct1GB
	zDQUzWyUFkneLBDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Ulz9yl/A";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vFafkBbo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766162652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BU2bxWjtZlWExv8F9zSmSFljkh+TvEiP7wR4/g4A3eI=;
	b=Ulz9yl/AmPrZE0sF+Nhi4m/8h0Y8tzJsZvMd/w2Xynr0zUrAU2iQ/WGfVdd/JiAMDhuDZM
	5wibrMBXDvXP+sdZPkTccOH9glwB0p7AOd4IVXA57JVkyAdh9FEB+8d6qHK8vWUDkKFray
	FzxA1GIEt/C3WLQcrrEqy+a6Qc/nH/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766162652;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BU2bxWjtZlWExv8F9zSmSFljkh+TvEiP7wR4/g4A3eI=;
	b=vFafkBborbGHkQk5/L2mBMp6jIasjDY1BCFy68+f7WaUUm2ceRSsvz+RTNyNDLcJedVnYq
	EJTIGIUWKCtyViBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BFA33EA63;
	Fri, 19 Dec 2025 16:44:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jMrkIdyARWmHVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Dec 2025 16:44:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3A40EA090B; Fri, 19 Dec 2025 17:44:04 +0100 (CET)
Date: Fri, 19 Dec 2025 17:44:04 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, yi.zhang@huawei.com, yizhang089@gmail.com, 
	libaokun1@huawei.com, yangerkun@huawei.com, yukuai@fnnas.com
Subject: Re: [PATCH -next 6/7] ext4: simply the mapping query logic in
 ext4_iomap_begin()
Message-ID: <rixkslnrchbru4bx3jzox5qxctabams37idsxtexenculvivhy@u2ywm4ojxycg>
References: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
 <20251213022008.1766912-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213022008.1766912-7-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,huawei.com,fnnas.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: A70A85BD39
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Sat 13-12-25 10:20:07, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In the write path mapping check of ext4_iomap_begin(), the return value
> 'ret' should never greater than orig_mlen. If 'ret' equals 'orig_mlen',
> it can be returned directly without checking IOMAP_ATOMIC.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 88144e2ce3e2..39348ee46e5c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3815,15 +3815,15 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		 */
>  		if (offset + length <= i_size_read(inode)) {
>  			ret = ext4_map_blocks(NULL, inode, &map, 0);
> -			/*
> -			 * For atomic writes the entire requested length should
> -			 * be mapped.
> -			 */
>  			if ((map.m_flags & EXT4_MAP_MAPPED) ||
>  			    (!(flags & IOMAP_DAX) &&
>  			     (map.m_flags & EXT4_MAP_UNWRITTEN))) {
> -				if ((!(flags & IOMAP_ATOMIC) && ret > 0) ||
> -				   (flags & IOMAP_ATOMIC && ret >= orig_mlen))
> +				/*
> +				 * For atomic writes the entire requested
> +				 * length should be mapped.
> +				 */
> +				if (ret == orig_mlen ||
> +				    (!(flags & IOMAP_ATOMIC) && ret > 0))
>  					goto out;
>  			}
>  			map.m_len = orig_mlen;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

