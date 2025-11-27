Return-Path: <linux-fsdevel+bounces-70028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C33C8EA3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD0F3A907F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9508E32AABD;
	Thu, 27 Nov 2025 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kzsuk6YX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S9WoM2Pw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x8QM9TDr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3mW/FaUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D307B31196D
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251577; cv=none; b=Uy8yxROH3LxdPgR9j/YpnObmaapBfdCs/ErZkzRqoacjpbrfoAK+BURoNmHtg0gdr2IIzC87DI7ZP6jxTUVeoa01GSThLwngU1216GN3ZKaG4gBzvGn+BBwBppJpioi7AwhF3BXeFNXSCtZUALjhiOSeStlqNDMeESU2IsWjbYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251577; c=relaxed/simple;
	bh=7OtTbGLbewny/vLSeIdMKaDh2y/5Hyi18CN3Zax6F3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aY6TL/+N9sjlEWsVgGaP7WuzWOXnMIS3o2tmizQLWgYkb6w0uuHyftTZ9+B1u9BgnlHjfVuEPxNNtf1oPkINZ0QVaJQzIuw7zqyHEs1+KeU2l1sr0G3Ic9esDbdVbsh5PY/3NbDJN+dqbtgitrKz5ssMRcku/aRvtxKFCRhystY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kzsuk6YX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S9WoM2Pw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x8QM9TDr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3mW/FaUW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B82E033683;
	Thu, 27 Nov 2025 13:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764251573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FH9An5hbsvK1jAqRSj8Xt05b5JLN74Uv0MthGjBGu/E=;
	b=kzsuk6YXfu/lMzc/aTvt9TbOfk98SJYwE57NnybiaVQGj8VRZ81m828GuiYuaJnMfycbOe
	7+OVnpFGSMMrAv9ZuojBEI4+ciCrWRVLpW0yIQ3fudjlZAY3WkBNuwTdl+eCNVUsr/mMf7
	8u2y+Ax+aQMC+Xl8J9YFl2yNfHYpc1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764251573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FH9An5hbsvK1jAqRSj8Xt05b5JLN74Uv0MthGjBGu/E=;
	b=S9WoM2Pw0Ad9H+KQtunRthqDfYAtvEuy1oa9RWIJ5IVvN4jacBLDyNaqkyg0udKrIN/oVa
	kIUCc1xBdrqVIEAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x8QM9TDr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="3mW/FaUW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764251571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FH9An5hbsvK1jAqRSj8Xt05b5JLN74Uv0MthGjBGu/E=;
	b=x8QM9TDrJseUIq6WA0yw0RnQGAV2LbvaDIhmFS1kC2HDUOtHkcFr5mOGR2sD5wCluOdRaE
	YF2NfbmyinxgtdV/aP27i+LI7pvfn3NhcoLLUIooEQGnX6FuyE/KdM2NU/8dWmRbxzKvMV
	vSjItDFRXzEaZJEYJNx1699wgak5r0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764251571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FH9An5hbsvK1jAqRSj8Xt05b5JLN74Uv0MthGjBGu/E=;
	b=3mW/FaUWVLV1FYSK4oIYZojjsgC/oK9ZjCsUYOTsrY29lAsK0/o1gEKDS2dcUegIpAYNuc
	B7wtayDpxrmk0IDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A25323EA63;
	Thu, 27 Nov 2025 13:52:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 45GWJ7NXKGm+ZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 13:52:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CDFFCA0C94; Thu, 27 Nov 2025 14:52:50 +0100 (CET)
Date: Thu, 27 Nov 2025 14:52:50 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] dcache: predict the name matches if parent and length
 also match
Message-ID: <3xwv7kza6hgxfzzsmyoolno4yygiqses4rutu3n2l2qqrf56ry@p7hs7s5yik2t>
References: <20251127122412.4131818-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127122412.4131818-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email]
X-Spam-Level: 
X-Spam-Score: -4.01
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B82E033683
X-Rspamd-Action: no action
X-Spam-Flag: NO

On Thu 27-11-25 13:24:12, Mateusz Guzik wrote:
> dentry_cmp() has predicts inside, but they were not enough to convince
> the compiler.
> 
> As for difference in asm, some of the code is reshuffled and there is
> one less unconditional jump to get there.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

I've checked and on my laptop the dentry hash table has ~2 million entries.
This means we'll be getting hash collisions within a directory for
directories on the order of thousands entries. And until we get to hundreds
of thousands of entries in a directory, the collisions of entries will be
still rare. So I guess that's rare enough. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> i know it's late, but given the non-semantic-modifying nature of the
> change, i think it can still make it for 6.19
> 
>  fs/dcache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 23d1752c29e6..bc84f89156fa 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2346,7 +2346,7 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
>  			continue;
>  		if (dentry->d_name.hash_len != hashlen)
>  			continue;
> -		if (dentry_cmp(dentry, str, hashlen_len(hashlen)) != 0)
> +		if (unlikely(dentry_cmp(dentry, str, hashlen_len(hashlen)) != 0))
>  			continue;
>  		*seqp = seq;
>  		return dentry;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

