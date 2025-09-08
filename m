Return-Path: <linux-fsdevel+bounces-60490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAD4B488F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40672161E70
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 09:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653882EB5D1;
	Mon,  8 Sep 2025 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="reIWuIzR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yuwBv6CO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WGnU76kO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iir4n4Dm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F822EC54E
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324769; cv=none; b=KUWBa13PifNMleBjupTT9MshLdcF3fHfz3NgTFZNJJ6sdOnudBs0s1E6QEgPW3D2zeYOi2NQNb7yHKOIpUBlVVbrAqeTsrXL5PPXLHfr/FEd0EBftf1mnUCeCvic9Wi6Gxp8n7CsNejWOf9jYzaCv4LhMtvcHxTuu6LCrI/XV9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324769; c=relaxed/simple;
	bh=xNqZ8VitTKAI9+ATzdJfK9JJWLrbFilIPV0tA9GyYlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N17heBjmmNVRoGQ9WbkymU0S4C6DF94/4zPvkInJMoMu/WA3i5wylvOItG863C/8lR0fdxXsz8F+4UVhRVl8VC8dAyxKwrjeXMdj9FZHFW3mrYbr2DrvlJzxg0jrUflKdFLeTvS55w9uBtGADjudmB5dRTAqzt58WqyqwFeY5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=reIWuIzR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yuwBv6CO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WGnU76kO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iir4n4Dm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A298226826;
	Mon,  8 Sep 2025 09:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ehZvpI09/4ebbLc8yOBJXh2qqSlrPzTL3uHxDcU27fU=;
	b=reIWuIzRF32VvIgfJwIJkD/F9p/8/SPGAsNR/XNQX4y3zCOUhg4Hyi1Aos+tTgXJc5VJtV
	89xufFSvRYtxHZmFiSTUgZnBvA5NwhDaENc8xGdv44uhr51OZF7yXmIMe8KROkAdq1OCp2
	8U2n0aiYjXMHRq9YItcssfyUAnynkOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ehZvpI09/4ebbLc8yOBJXh2qqSlrPzTL3uHxDcU27fU=;
	b=yuwBv6CO0gwVNBDFnp6B8zE5jK8c2gXFJ9U1sD/e5JoyApBXekGYqZh5j6me8JKsgi+IIa
	usNnRBWyZCIEENAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WGnU76kO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iir4n4Dm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ehZvpI09/4ebbLc8yOBJXh2qqSlrPzTL3uHxDcU27fU=;
	b=WGnU76kODyo9NThRMMN4k7iMo3KakR51aUHdnllwLdN/F2Go/J2fYyPkTEAwxXZrVMjioo
	oBAm44geQoncxTLmNfCoYqaDntnP/t+VfmkIfb9jPXtiM7UJEg8SikgsXZzdoeBhPB99o3
	QZG4bM+8jiVhtLJVM4tk6v2ybQlU25k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ehZvpI09/4ebbLc8yOBJXh2qqSlrPzTL3uHxDcU27fU=;
	b=iir4n4DmtPA24hvajYQ/fHTsVjI0Zou/1WRZ8vjgY2YNHHWGEHHgGxu5pIUcFH7SqWXrlG
	IivOPNK/zSKAUqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97E3D13869;
	Mon,  8 Sep 2025 09:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fEkUJdylvmi8bgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Sep 2025 09:46:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5AAA0A0A2D; Mon,  8 Sep 2025 11:46:04 +0200 (CEST)
Date: Mon, 8 Sep 2025 11:46:04 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 21/21] configfs:get_target() - release path as soon as we
 grab configfs_item reference
Message-ID: <kxkfbxnqbmikguq2qggevtb6wip7sfjj4yecntqdoydslue2xb@robzbvqysmfs>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-21-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-21-viro@zeniv.linux.org.uk>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: A298226826
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Sat 06-09-25 10:11:37, Al Viro wrote:
> ... and get rid of path argument - it turns into a local variable in get_target()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/symlink.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
> index 69133ec1fac2..f3f79c67add5 100644
> --- a/fs/configfs/symlink.c
> +++ b/fs/configfs/symlink.c
> @@ -114,26 +114,21 @@ static int create_link(struct config_item *parent_item,
>  }
>  
>  
> -static int get_target(const char *symname, struct path *path,
> -		      struct config_item **target, struct super_block *sb)
> +static int get_target(const char *symname, struct config_item **target,
> +		      struct super_block *sb)
>  {
> +	struct path path __free(path_put) = {};
>  	int ret;
>  
> -	ret = kern_path(symname, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, path);
> -	if (!ret) {
> -		if (path->dentry->d_sb == sb) {
> -			*target = configfs_get_config_item(path->dentry);
> -			if (!*target) {
> -				ret = -ENOENT;
> -				path_put(path);
> -			}
> -		} else {
> -			ret = -EPERM;
> -			path_put(path);
> -		}
> -	}
> -
> -	return ret;
> +	ret = kern_path(symname, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &path);
> +	if (ret)
> +		return ret;
> +	if (path.dentry->d_sb != sb)
> +		return -EPERM;
> +	*target = configfs_get_config_item(path.dentry);
> +	if (!*target)
> +		return -ENOENT;
> +	return 0;
>  }
>  
>  
> @@ -141,7 +136,6 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  		     struct dentry *dentry, const char *symname)
>  {
>  	int ret;
> -	struct path path;
>  	struct configfs_dirent *sd;
>  	struct config_item *parent_item;
>  	struct config_item *target_item = NULL;
> @@ -188,7 +182,7 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	 *  AV, a thoroughly annoyed bastard.
>  	 */
>  	inode_unlock(dir);
> -	ret = get_target(symname, &path, &target_item, dentry->d_sb);
> +	ret = get_target(symname, &target_item, dentry->d_sb);
>  	inode_lock(dir);
>  	if (ret)
>  		goto out_put;
> @@ -210,7 +204,6 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	}
>  
>  	config_item_put(target_item);
> -	path_put(&path);
>  
>  out_put:
>  	config_item_put(parent_item);
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

