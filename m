Return-Path: <linux-fsdevel+bounces-46372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DDCA881B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 15:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6609172BFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 13:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A47323D2A8;
	Mon, 14 Apr 2025 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T/pvW068";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3nt0s0Hf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T/pvW068";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3nt0s0Hf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A023D29B
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637071; cv=none; b=CNKLrLArp3pZxRJvdnQqy169/cw0RxMz6cjJyev3AYRS9JCPBxgfsw59yEif8w3+t6LfBNX5QdrtYspLlMVe89BSgHFSZ8iEh4Y8xTawc56ds+o0eB1zDW7/LYN2VWDTmp+ev39KH39DibV7kBMZeHCtAmi7gWfPG90/V1+zdGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637071; c=relaxed/simple;
	bh=Hybz39FZma9Cyg3nKyz13PSchI9YPrOfhu5q7waKemo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=il+FzZjoTNvLYAtmC/B+G0akQ13+4Rov2cbQcnfRoemBqbbhgbJyStemVD8ZcDIPAf157DsEN4RM2IqvWGP+F5Bd85GMEkEjbuSeqP4cL06ljdGux9qr7+IU/Qr52liVX3O8rYYOtW7HCMnIS+De33H8FlhCbLYJH9Uk92ZWzMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T/pvW068; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3nt0s0Hf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T/pvW068; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3nt0s0Hf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5ED07218FE;
	Mon, 14 Apr 2025 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744637068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/XOuGgsFDfzaw3odh04S2DPENIai1JkJFf4sFeasm8=;
	b=T/pvW068HgdILPwwvVNRYkcex0xoq4V7gQ5onNJtLqU/Jp/aL6G1NYZ0MN6Yl1DmzksgsX
	3pOG9rmB53fvBYaauUB3Ez5Sl0y3qTofDy5OJRxD1Or1hkWvrmOzggyl6Nyx6hmTaJZSlp
	Uddqwos63sG8FgxGzxxQDBLa6ZcBn3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744637068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/XOuGgsFDfzaw3odh04S2DPENIai1JkJFf4sFeasm8=;
	b=3nt0s0Hf09loo9mAN8WSGKpMNLtm5/x682S3d1CydYo5iEvVGu1ki80z+yyfrZQ+4yYtcj
	rEd2mMHEwmRE/gAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744637068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/XOuGgsFDfzaw3odh04S2DPENIai1JkJFf4sFeasm8=;
	b=T/pvW068HgdILPwwvVNRYkcex0xoq4V7gQ5onNJtLqU/Jp/aL6G1NYZ0MN6Yl1DmzksgsX
	3pOG9rmB53fvBYaauUB3Ez5Sl0y3qTofDy5OJRxD1Or1hkWvrmOzggyl6Nyx6hmTaJZSlp
	Uddqwos63sG8FgxGzxxQDBLa6ZcBn3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744637068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/XOuGgsFDfzaw3odh04S2DPENIai1JkJFf4sFeasm8=;
	b=3nt0s0Hf09loo9mAN8WSGKpMNLtm5/x682S3d1CydYo5iEvVGu1ki80z+yyfrZQ+4yYtcj
	rEd2mMHEwmRE/gAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53242136A7;
	Mon, 14 Apr 2025 13:24:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9pNHFIwM/WckfAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Apr 2025 13:24:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1760DA094B; Mon, 14 Apr 2025 15:24:28 +0200 (CEST)
Date: Mon, 14 Apr 2025 15:24:28 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: improve codegen in link_path_walk()
Message-ID: <ayawbty4mgxuxkbncblr6xgl25ixjb34ywh3qxhozwuhxnr5t3@2fk4hmvtwuq3>
References: <20250412110935.2267703-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412110935.2267703-1-mjguzik@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Sat 12-04-25 13:09:35, Mateusz Guzik wrote:
> Looking at the asm produced by gcc 13.3 for x86-64:
> 1. may_lookup() usage was not optimized for succeeding, despite the
>    routine being inlined and rightfully starting with likely(!err)
> 2. the compiler assumed the path will have an indefinite amount of
>    slashes to skip, after which the result will be an empty name
> 
> As such:
> 1. predict may_lookup() succeeding
> 2. check for one slash, no explicit predicts. do roll forward with
>    skipping more slashes while predicting there is only one
> 3. predict the path to find was not a mere slash
> 
> This also has a side effect of shrinking the file:
> add/remove: 1/1 grow/shrink: 0/3 up/down: 934/-1012 (-78)
> Function                                     old     new   delta
> link_path_walk                                 -     934    +934
> path_parentat                                138     112     -26
> path_openat                                 4864    4823     -41
> path_lookupat                                418     374     -44
> link_path_walk.part.constprop                901       -    -901
> Total: Before=46639, After=46561, chg -0.17%
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks sensible. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> I'm looking at skipping perm checks with an "everybody can MAY_EXEC and
> there are no acls" bit for opflags. This crapper is a side effect of
> straighetning out the code before I get there.
> 
>  fs/namei.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 360a86ca1f02..40a636bbfa0c 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2424,9 +2424,12 @@ static int link_path_walk(const char *name, struct nameidata *nd)
>  	nd->flags |= LOOKUP_PARENT;
>  	if (IS_ERR(name))
>  		return PTR_ERR(name);
> -	while (*name=='/')
> -		name++;
> -	if (!*name) {
> +	if (*name == '/') {
> +		do {
> +			name++;
> +		} while (unlikely(*name == '/'));
> +	}
> +	if (unlikely(!*name)) {
>  		nd->dir_mode = 0; // short-circuit the 'hardening' idiocy
>  		return 0;
>  	}
> @@ -2439,7 +2442,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
>  
>  		idmap = mnt_idmap(nd->path.mnt);
>  		err = may_lookup(idmap, nd);
> -		if (err)
> +		if (unlikely(err))
>  			return err;
>  
>  		nd->last.name = name;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

