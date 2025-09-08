Return-Path: <linux-fsdevel+bounces-60485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618C3B488D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC1B3C6D74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 09:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6F22F83BE;
	Mon,  8 Sep 2025 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FxyuJ89H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f98bWT8T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FxyuJ89H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f98bWT8T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E044D2F3C28
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324446; cv=none; b=iPbRln2pEicsJoOzkEsZOr9QLoo0e3DA6KdaSfy5e1EhcdkV0K++kEZz+3X4btsJ6HH0M3W5xDKqmgu5qh1LoZidebBI47gxl9jdSd6cNtkr1TDlfvUX2ST3kmVG0T2aUEIge2XxRLi6bia21WRwzmH8OQLqtzTIWuFMmTWYWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324446; c=relaxed/simple;
	bh=kG4j3mgyB7C4symGfc9htBn0NTJiaOgiluWkklscpVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yj9TUYIy/4rDzAkhP7RRdA2D9uLfEc3LGOHCyr5ZVwwj7zJIfhUMPFU4B0EFIAKRzF5Veu84OM9UE+MmdyBGedhYf1NcSefFUcYDYY77x+FncOkjMP2M8IXvDG9hG0tnmCj2TTakSeSBTpDDRGh7+w1RJJtxTKTYZpSlZOorKIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FxyuJ89H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f98bWT8T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FxyuJ89H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f98bWT8T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D920F23C97;
	Mon,  8 Sep 2025 09:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3i8BSfTj3QbPGZAZiCkjf23p8I0IAoCSGqOqA641Nes=;
	b=FxyuJ89H+iLIg/kkqwzce7bx+wQ7RvKDkhErELKmIVEJsAsiGAhftlwZzSdwZ7NmTS7xcA
	AF4jsohyvZBoEgLBvfEvM7AeJ3S1eP2xglKGe4Yl0pH1JDvEU9u9rXNo3tu9p/Qbsd9LcV
	foOKq4hR++VEBViSYOyDToTAY5oTDVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3i8BSfTj3QbPGZAZiCkjf23p8I0IAoCSGqOqA641Nes=;
	b=f98bWT8Ti9Y0nfNKnjmLzwEKU1ez1KqAb4L14aVYxbKIAsldHanrK6/Lqr9k+vUADT8XGY
	Ib485vmkLhaQeTAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3i8BSfTj3QbPGZAZiCkjf23p8I0IAoCSGqOqA641Nes=;
	b=FxyuJ89H+iLIg/kkqwzce7bx+wQ7RvKDkhErELKmIVEJsAsiGAhftlwZzSdwZ7NmTS7xcA
	AF4jsohyvZBoEgLBvfEvM7AeJ3S1eP2xglKGe4Yl0pH1JDvEU9u9rXNo3tu9p/Qbsd9LcV
	foOKq4hR++VEBViSYOyDToTAY5oTDVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3i8BSfTj3QbPGZAZiCkjf23p8I0IAoCSGqOqA641Nes=;
	b=f98bWT8Ti9Y0nfNKnjmLzwEKU1ez1KqAb4L14aVYxbKIAsldHanrK6/Lqr9k+vUADT8XGY
	Ib485vmkLhaQeTAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C320B13869;
	Mon,  8 Sep 2025 09:40:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NOypL5mkvmgpbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Sep 2025 09:40:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5621AA0A2D; Mon,  8 Sep 2025 11:40:41 +0200 (CEST)
Date: Mon, 8 Sep 2025 11:40:41 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 04/21] done_path_create(): constify path argument
Message-ID: <jvmr5ejuhegq7nwm556iuycobaltzdwd6kjep7nmp65c6i6z32@vpscz6plknje>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-4-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-4-viro@zeniv.linux.org.uk>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,suse.cz,linux-foundation.org,gmail.com,oracle.com,apparmor.net];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Sat 06-09-25 10:11:20, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c            | 2 +-
>  include/linux/namei.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 869976213b0c..3eb0408e3400 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4170,7 +4170,7 @@ struct dentry *kern_path_create(int dfd, const char *pathname,
>  }
>  EXPORT_SYMBOL(kern_path_create);
>  
> -void done_path_create(struct path *path, struct dentry *dentry)
> +void done_path_create(const struct path *path, struct dentry *dentry)
>  {
>  	if (!IS_ERR(dentry))
>  		dput(dentry);
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 5d085428e471..75c0b665fbd4 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -60,7 +60,7 @@ extern int kern_path(const char *, unsigned, struct path *);
>  
>  extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
>  extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
> -extern void done_path_create(struct path *, struct dentry *);
> +extern void done_path_create(const struct path *, struct dentry *);
>  extern struct dentry *kern_path_locked(const char *, struct path *);
>  extern struct dentry *kern_path_locked_negative(const char *, struct path *);
>  extern struct dentry *user_path_locked_at(int , const char __user *, struct path *);
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

