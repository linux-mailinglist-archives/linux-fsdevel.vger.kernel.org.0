Return-Path: <linux-fsdevel+bounces-75000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJEtI0j0cWmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:56:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0927B64E08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 877517E7CDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1159F3DAC13;
	Thu, 22 Jan 2026 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f4DgHewK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="efzkAzMk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BEH+CXeC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OGVGYSOw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D6738E111
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075293; cv=none; b=F7hTyHpk2oiwGqZbpmesqHtBYQ4XXQWKOJ10y1xM6e1UtzO/+Sb3NRQtXbAJuC+9gA/AhTQyHpDAS9fZznepeZwvch4mkkAd+jP35bt+O4/YI19D1aD5i9UTFTH7dbHDsRn7KHzsLxt/Kvm0jBgUHUbp9fJjRax2WKUS44ZsK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075293; c=relaxed/simple;
	bh=twqDE2V0409H7nIc+95Kzzfc0KkM3td1nA7+U/3MFAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPcYFpmiP+pmOz9pBMwY3s7vSWlmtMMUorQZIxbvcdWCccfSdknL8X+f32BDU5iPQ60RcI3geRnMhVEtZxHKuCmmkJBSs0xZwHT3P3FzUW+WNFvOLru8qexW955i5d0EOEKQoz9FbYnL3Yth7Yhoj2bIWWW3jjCshT1F6Q4ZjPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f4DgHewK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=efzkAzMk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BEH+CXeC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OGVGYSOw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1635833709;
	Thu, 22 Jan 2026 09:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769075290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+vwBIZDGrvfvhlYosQV+F/JmbSCHcbajYdN3+3PSEA=;
	b=f4DgHewKdvRZ6/iVyc1EYwIQFnpVCxFSSO+cJS9IuqJwjCW2Wc8l4AHrLCJadANHlawqx+
	kF9KnFriceEv0H1G3gD5f76vzNSV6Mxj1RumrdSmpGZR1W/13cV4dZ37caA0ANCRmvrZmD
	7VT1PpTLR1lxG4P8XOReB+tZ+aqS0TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769075290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+vwBIZDGrvfvhlYosQV+F/JmbSCHcbajYdN3+3PSEA=;
	b=efzkAzMkUybZk9QrEEKAylB6wCJmTWaFCcvkD6Lr4ZgXGCKHnG/Nh77RGkAjDMd2lBqI8s
	2uc+l99Rlu0pmFDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769075289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+vwBIZDGrvfvhlYosQV+F/JmbSCHcbajYdN3+3PSEA=;
	b=BEH+CXeCnokWamQOHDtp6QX6DOKOAomO2tKbiAZskfc7upAoaOm14a7QIdNCb5kmBUHrAi
	PecPcBesGghUxuZu1u/ul+1tL92DZmrqvztGtxL2Q6LdLCbAEqQxVDf/O1V6xdo0l5eu/Q
	qVatxQH2akL46q5g6Wo6Xoh0fVaUZBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769075289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+vwBIZDGrvfvhlYosQV+F/JmbSCHcbajYdN3+3PSEA=;
	b=OGVGYSOw/kxk3r+bIvOwlybab5Gc42dwS0XsDEiCtmG8FdGm/WWWGN+7LrKu/UkzpXf0tF
	6XYaa9wBI2mZGiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE80313978;
	Thu, 22 Jan 2026 09:48:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bYaSKljycWk7DwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Jan 2026 09:48:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 49529A0C12; Thu, 22 Jan 2026 10:40:35 +0100 (CET)
Date: Thu, 22 Jan 2026 10:40:35 +0100
From: Jan Kara <jack@suse.cz>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] fs: reset read-only fsflags together with xflags
Message-ID: <xg3perwgtxrm37begxk6fll5zt43p6zuebvsfyj3hqjhozlokt@5xjc7thn7eaq>
References: <20260121193645.3611716-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121193645.3611716-1-aalbersh@kernel.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-75000-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0927B64E08
X-Rspamd-Action: no action

On Wed 21-01-26 20:36:43, Andrey Albershteyn wrote:
> While setting file attributes, the read-only flags are reset
> for ->xflags, but not for ->flags if flag is shared between both. This
> is fine for now as all read-only xflags don't overlap with flags.
> However, for any read-only shared flag this will create inconsistency
> between xflags and flags. The non-shared flag will be reset in
> vfs_fileattr_set() to the current value, but shared one is past further
							     ^^ passed
> to ->fileattr_set.
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> The shared read-only flag is going to be added for fsverity. The one for ->flags
> already exists.
> 
> [1]: https://lore.kernel.org/linux-xfs/20260119165644.2945008-2-aalbersh@kernel.org/
> 
> ---
>  fs/file_attr.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 13cdb31a3e94..bed5442fa6fa 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -142,8 +142,7 @@ static int file_attr_to_fileattr(const struct file_attr *fattr,
>  	if (fattr->fa_xflags & ~mask)
>  		return -EINVAL;
>  
> -	fileattr_fill_xflags(fa, fattr->fa_xflags);
> -	fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
> +	fileattr_fill_xflags(fa, fattr->fa_xflags & ~FS_XFLAG_RDONLY_MASK);
>  	fa->fsx_extsize = fattr->fa_extsize;
>  	fa->fsx_projid = fattr->fa_projid;
>  	fa->fsx_cowextsize = fattr->fa_cowextsize;
> @@ -163,8 +162,7 @@ static int copy_fsxattr_from_user(struct file_kattr *fa,
>  	if (xfa.fsx_xflags & ~mask)
>  		return -EOPNOTSUPP;
>  
> -	fileattr_fill_xflags(fa, xfa.fsx_xflags);
> -	fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
> +	fileattr_fill_xflags(fa, xfa.fsx_xflags & ~FS_XFLAG_RDONLY_MASK);
>  	fa->fsx_extsize = xfa.fsx_extsize;
>  	fa->fsx_nextents = xfa.fsx_nextents;
>  	fa->fsx_projid = xfa.fsx_projid;
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

