Return-Path: <linux-fsdevel+bounces-60488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09881B488DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF22B3BEE67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 09:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D982F6188;
	Mon,  8 Sep 2025 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XRQlzaH4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J3jhSJSh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XRQlzaH4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J3jhSJSh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264F22F60B5
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324555; cv=none; b=XMwgP64BbcTNHETNNXPe3cgbqQoGN6n15CpQq+9AFiRJhDhlZGbOuLT3V8lvvtqgOa/odKAmLau7X3GcBc6JaX4exBGNkDX/SIP0PrY8loq4+M8WaHyn169byPIIXfm8s3mB546SmT+efUU5THOVZYC//kPhME+fBQspNpDnyT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324555; c=relaxed/simple;
	bh=yz5J/JK+/evbBjaiv21VlMTdkVGsJ6g7StCBfcxkLwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzlblVsU7nGcKpdNpcugVZDPPbyBpfgggANom1RKKeCuijngAE5xvRr82EtNXoOmrEBI7UIIqE3ypgd+k3ZaC5/AlUXnVqFQnWqx7d0LGY8ThFbojHyG+2006vf0bTZZ9AjT/trlWK4pBc1Y+gWuRc80KZflllIPUyyepaLvBnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XRQlzaH4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J3jhSJSh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XRQlzaH4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J3jhSJSh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C46A21B01;
	Mon,  8 Sep 2025 09:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nRTodqyVzBpE3BAcuOvGYY7I/sMZ2r8UjDUt80W4UJA=;
	b=XRQlzaH4ek/w5P4wPIgWSm0ozY6EYhl/bO0/vr5BM0pRwBP10pELaCRf2pSlltrGdltLAK
	i6yKT8W/UsuiuJ8J67nft2h5NHyS7mTe+PVcSbwsNqH+8Cqw52+wb/jgGHdkCC84uLLhY3
	GkFMfGD3Q0h/BHR0dCjxTO59dB7jE7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nRTodqyVzBpE3BAcuOvGYY7I/sMZ2r8UjDUt80W4UJA=;
	b=J3jhSJShA++9NVJya1EC3QrOrG20tx+IhgHUordVwHlO/gPWBdRPSqsB1pWmuaUSZU36WL
	tUXQE8ejKTzdIEAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XRQlzaH4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=J3jhSJSh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nRTodqyVzBpE3BAcuOvGYY7I/sMZ2r8UjDUt80W4UJA=;
	b=XRQlzaH4ek/w5P4wPIgWSm0ozY6EYhl/bO0/vr5BM0pRwBP10pELaCRf2pSlltrGdltLAK
	i6yKT8W/UsuiuJ8J67nft2h5NHyS7mTe+PVcSbwsNqH+8Cqw52+wb/jgGHdkCC84uLLhY3
	GkFMfGD3Q0h/BHR0dCjxTO59dB7jE7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nRTodqyVzBpE3BAcuOvGYY7I/sMZ2r8UjDUt80W4UJA=;
	b=J3jhSJShA++9NVJya1EC3QrOrG20tx+IhgHUordVwHlO/gPWBdRPSqsB1pWmuaUSZU36WL
	tUXQE8ejKTzdIEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EB2E13869;
	Mon,  8 Sep 2025 09:42:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ni5ODwilvminbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Sep 2025 09:42:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F08ADA0A2D; Mon,  8 Sep 2025 11:42:31 +0200 (CEST)
Date: Mon, 8 Sep 2025 11:42:31 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 08/21] export_operations->open(): constify path argument
Message-ID: <cvdb6tcpmkym3evhhrsk5yn2inihkns67wswk7g7zgpo4uqwv5@xfmeo3s46i7y>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-8-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-8-viro@zeniv.linux.org.uk>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4C46A21B01
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:email,linux.org.uk:email]
X-Spam-Score: -4.01

On Sat 06-09-25 10:11:24, Al Viro wrote:
> for the method and its sole instance...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/pidfs.c               | 2 +-
>  include/linux/exportfs.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 108e7527f837..5af4fee288ea 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -847,7 +847,7 @@ static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
>  	return 0;
>  }
>  
> -static struct file *pidfs_export_open(struct path *path, unsigned int oflags)
> +static struct file *pidfs_export_open(const struct path *path, unsigned int oflags)
>  {
>  	/*
>  	 * Clear O_LARGEFILE as open_by_handle_at() forces it and raise
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index cfb0dd1ea49c..f43c83e0b8c5 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -270,7 +270,7 @@ struct export_operations {
>  	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
>  			     int nr_iomaps, struct iattr *iattr);
>  	int (*permission)(struct handle_to_path_ctx *ctx, unsigned int oflags);
> -	struct file * (*open)(struct path *path, unsigned int oflags);
> +	struct file * (*open)(const struct path *path, unsigned int oflags);
>  #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
>  #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
>  #define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unlink */
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

