Return-Path: <linux-fsdevel+bounces-60484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DDFB488C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38ADC3C4AB6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 09:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59172EE61D;
	Mon,  8 Sep 2025 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tPJhrXA8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/NWzhZVW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m/OHING5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KbdMN2vz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2763D2FB080
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324402; cv=none; b=rkgOe1Tw/Cucdwknx7jpOoxFYmCDr2ZxQbzAnpVUWPSJr1+uLGHH1tI8RGf+zeE6qS7qkHMV9WJnMpQtfpKjE3roq0j82PnwuI6f5Ehh7YMKW1KQZCTf9m+dop9xOc3ynO+RWYcfXhNmWmxeEr+RJRhGqzNsXeArPqLfAT66OaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324402; c=relaxed/simple;
	bh=kzU/53yRMbm0BObJIOFBelMtAou6fSSVUXsxKs9mKmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfVpkyOel3dXbxIWuwUqafEjtItc05UsAdheTlmwc8G/1O+CZHlyflg9amRVBa9R0jby7G7zxfxlc3qsEY+1ZRLmIkG6PZs5zIqTPqafmm4Q5Nw4wWK+6tmmVh0BiV2GINp7xVnL0CyhknFzO4a03zLPcHR/x5vYMqzsIY0DSpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tPJhrXA8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/NWzhZVW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m/OHING5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KbdMN2vz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 778B124A75;
	Mon,  8 Sep 2025 09:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a7O6PTjSBSS4mmelq6JptnNPfknThsdaHYvFQ5zPFWw=;
	b=tPJhrXA8thtJRgNLTi1DAGUrExz5TXKI4A3IxvNbgLlGdtCNPUxsMSVXdXk2GqKoFg4QQ2
	e0SG2kuopJICp3XK2cn++HRzH4rQI72pjis7Zy3Bq8BuYf38YYT77mSoIuY/b/x4ZIovvN
	ApMsKBkHKjqWRjtrvD6PFpYEkIVGjIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a7O6PTjSBSS4mmelq6JptnNPfknThsdaHYvFQ5zPFWw=;
	b=/NWzhZVW34zW4fuiFLza2ute6aE4kjAZe6n7zw9pbj6/hiRmlr6Q4BJh1x9PqFNrTO5l4d
	zn0GSM32NoQZb/Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="m/OHING5";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KbdMN2vz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a7O6PTjSBSS4mmelq6JptnNPfknThsdaHYvFQ5zPFWw=;
	b=m/OHING5ip/BcgqseAPZMmeK9mSBXv3umi4MZlK2w6UV42CAGm4JvSKIXV+fO3Irrirbkh
	DTo1m+y5JDqahW/C5YLn/lVeJSjooeY/JG6WrToqm5kRp2jLL13BRLaQujwvfdvnk/YmQN
	7VLIwvl0ceGemYN90bLlUMCFe9eGTAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a7O6PTjSBSS4mmelq6JptnNPfknThsdaHYvFQ5zPFWw=;
	b=KbdMN2vz3gab/965LxXXIgZIPZMEcOuBwV/Q7frJDt6MEcU1fCE5uK7r7sn8anLZSxJg6B
	Mrq+RTB8ZTXCdIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 619EC13869;
	Mon,  8 Sep 2025 09:39:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ShTNF2ykvmjbbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Sep 2025 09:39:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 17D3FA0A2D; Mon,  8 Sep 2025 11:39:56 +0200 (CEST)
Date: Mon, 8 Sep 2025 11:39:56 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 03/21] filename_lookup(): constify root argument
Message-ID: <fxaacoi2setpklhke443myxnyxdeyyqz2cud7xpzywb5ahc6uw@tafwj27k5kqm>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-3-viro@zeniv.linux.org.uk>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,suse.cz,linux-foundation.org,gmail.com,oracle.com,apparmor.net];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 778B124A75
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Sat 06-09-25 10:11:19, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/internal.h | 2 +-
>  fs/namei.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index 38e8aab27bbd..d7c86d9d94b9 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -53,7 +53,7 @@ extern int finish_clean_context(struct fs_context *fc);
>   * namei.c
>   */
>  extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
> -			   struct path *path, struct path *root);
> +			   struct path *path, const struct path *root);
>  int do_rmdir(int dfd, struct filename *name);
>  int do_unlinkat(int dfd, struct filename *name);
>  int may_linkat(struct mnt_idmap *idmap, const struct path *link);
> diff --git a/fs/namei.c b/fs/namei.c
> index cd43ff89fbaa..869976213b0c 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2673,7 +2673,7 @@ static int path_lookupat(struct nameidata *nd, unsigned flags, struct path *path
>  }
>  
>  int filename_lookup(int dfd, struct filename *name, unsigned flags,
> -		    struct path *path, struct path *root)
> +		    struct path *path, const struct path *root)
>  {
>  	int retval;
>  	struct nameidata nd;
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

