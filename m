Return-Path: <linux-fsdevel+bounces-49855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14336AC4220
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 17:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E8A3A5ABD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5FD212B0C;
	Mon, 26 May 2025 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0InCDyjy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j9EZaeeI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ogj4E6SA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0iB73iOw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9651EEA47
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748272256; cv=none; b=ou1zlCoihzqabagUJd34knYTDrmiqXfovZfyII5KhF4IzowI3sEPa3K58L9lcG9YDEdXKX8yMb/DwWgVLbmviWUFPxzwpLnAPgkq7oOATHNqB7Y8r2l3k6OkfcL88u5WIvbjrqgodNzUl1L/FbL5nqO4PxRJGBbrW2nhgjRR4MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748272256; c=relaxed/simple;
	bh=Y1iFnrsRuHUFnKJWxto2FTNUyRW5q3ZY79BDxMJUhmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4OlR1w5aIW1Bpz9URb+FpnAK2nHay63L3g7EBAzhgD7nAUG8tMDO22RzajJS5Uui+YWy8HU/UIMw8RrZYRIUtMBZ4UZKaMQHs09VmkcHmpRd4N1QpaDlOaGciGxfqoCZKqEzAIT7t0AwD7WSxw4fHGZ2PEWJ0glDAIXuSMQmH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0InCDyjy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j9EZaeeI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ogj4E6SA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0iB73iOw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D7DF21F893;
	Mon, 26 May 2025 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748272253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gLu3ivbcZDIdA5BWN56MA+IZ+NIHuMmbWLH5x9DwGhI=;
	b=0InCDyjy1XfTZZn9oC8x8i6oWywTow3fV6sNUveVF1ug3xgZCH92Mg6V/WdS7Sx/x67dWe
	9lbuQix296B9pg4qW8W2VOIvs5hUEKdEjBzM3HL2qUcIEs4wk1J4dLiXDYCrqgxegueVWc
	W/iHFYMTV2ym7evUrHEVBqrx1/04ync=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748272253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gLu3ivbcZDIdA5BWN56MA+IZ+NIHuMmbWLH5x9DwGhI=;
	b=j9EZaeeIpms0gpkR/iNP5Js0uqoQUkHZSnDqNulex6VZUIVo/XTaN4Tj8XhZ2SEpk5dY1U
	WhU5EQ8NK0B51UBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748272252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gLu3ivbcZDIdA5BWN56MA+IZ+NIHuMmbWLH5x9DwGhI=;
	b=ogj4E6SAfC5KCrs17BSaZInvI7ottkGw+NKznDh/Srfd1PjIMohLErJ0Rjw07jUiuCY8RY
	9R3A4QRURwjEZ5V+Giz5Un88krkGxOFNgEFmIOeL53P31qWDHDU1129OMA/HWZChs0AM7t
	+R0RyoetV6XmKYlxFDYi9oMaV852gkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748272252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gLu3ivbcZDIdA5BWN56MA+IZ+NIHuMmbWLH5x9DwGhI=;
	b=0iB73iOwul6LUYhk1UlXS/5W/lTNgBRS4NpKnPZEDXNKyPr8xj70tqzGyIENzjK9Lvb9tp
	MUTTiAn8i1CstTAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAC4513964;
	Mon, 26 May 2025 15:10:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V712MXyENGh9XAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 May 2025 15:10:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7CA09A09B7; Mon, 26 May 2025 17:10:48 +0200 (CEST)
Date: Mon, 26 May 2025 17:10:48 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Aleksa Sarai <cyphar@cyphar.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] exportfs: require ->fh_to_parent() to encode connectable
 file handles
Message-ID: <wdyxpgigsa7fpabv7cb5zeceinqxxhz3jucefse5z47kkfs5ke@p6wpr7ecnwq5>
References: <20250525104731.1461704-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250525104731.1461704-1-amir73il@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Sun 25-05-25 12:47:31, Amir Goldstein wrote:
> When user requests a connectable file handle explicitly with the
> AT_HANDLE_CONNECTABLE flag, fail the request if filesystem (e.g. nfs)
> does not know how to decode a connected non-dir dentry.
> 
> Fixes: c374196b2b9f ("fs: name_to_handle_at() support for "explicit connectable" file handles")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/exportfs.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Christian,
> 
> This fixes fstest failures with nfs client (re-export)
> reported by Zoro [1].
> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/fstests/20250525053604.k466kgfcumw2s2qx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> 
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index fc93f0abf513..25c4a5afbd44 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -314,6 +314,9 @@ static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
>  static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
>  					  int fh_flags)
>  {
> +	if (!nop)
> +		return false;
> +
>  	/*
>  	 * If a non-decodeable file handle was requested, we only need to make
>  	 * sure that filesystem did not opt-out of encoding fid.
> @@ -321,6 +324,13 @@ static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
>  	if (fh_flags & EXPORT_FH_FID)
>  		return exportfs_can_encode_fid(nop);
>  
> +	/*
> +	 * If a connectable file handle was requested, we need to make sure that
> +	 * filesystem can also decode connected file handles.
> +	 */
> +	if ((fh_flags & EXPORT_FH_CONNECTABLE) && !nop->fh_to_parent)
> +		return false;
> +
>  	/*
>  	 * If a decodeable file handle was requested, we need to make sure that
>  	 * filesystem can also decode file handles.
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

