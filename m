Return-Path: <linux-fsdevel+bounces-60489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112E6B488DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CB31642F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 09:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042242F3C30;
	Mon,  8 Sep 2025 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fCel1wkX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9LY6+rRq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fCel1wkX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9LY6+rRq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086CB2EB5BF
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324594; cv=none; b=OUMkabpCRCJhwuaQB7knDPr93vVcx2L91dPxXN8FnXEw8rLCfElmrhB+LnZ1sl0JsRIGixd15wtXLujeyRyLDsZ7+qNv7QbKunURfqE4I3UxJdIc1F7bwJ8nLOajg4DHJldahY54D4ERZM1JZIBhwo6Qw+cKV/uQSYV9T/JQEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324594; c=relaxed/simple;
	bh=05AQnvp385taVxlCf0jMjjarnC0lzXQH06c7HURPB/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMBcPwmBDpoYvylfXacnVN2UKCkU4ZmM70MDHVAHAsxnGsSSSxFYvHnib3aB3yKvvea3dvoTslVZK0YayuffbgH5MxsmWoSsPqv1GvinnaO3lIscphx30wEl04PWnlMjR3MYjicZKyb0rVh82duu8IJ4hWcDcB4+0mY5YvITyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fCel1wkX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9LY6+rRq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fCel1wkX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9LY6+rRq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D4A316D4C;
	Mon,  8 Sep 2025 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMJuD2FFA6qLrLUw153O3tqt0ZSz0/RTRaYLJbw0964=;
	b=fCel1wkXrWFy0H9fZAjz2bOpjmi0P83s5xOsS8jd7F9UDSeLv7w8lgLXWoFLQujEUvE9Is
	DZAcS8ZzsaScJvFfs3A5fxtvxE4HWdgQNpGA1iCKZ5pKmMAx4fKmGxh4esyfQ5gaz3CRfc
	9pQb4SN0WCmZPlyFwXILgMbuutc4NlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMJuD2FFA6qLrLUw153O3tqt0ZSz0/RTRaYLJbw0964=;
	b=9LY6+rRqErJQKVD60bVDkwgY0+cOawY0mff7G2Jr1UJoiM7+SDngUxpvaKe89mtjrM51kA
	lBPhEeUx9pZcuTDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMJuD2FFA6qLrLUw153O3tqt0ZSz0/RTRaYLJbw0964=;
	b=fCel1wkXrWFy0H9fZAjz2bOpjmi0P83s5xOsS8jd7F9UDSeLv7w8lgLXWoFLQujEUvE9Is
	DZAcS8ZzsaScJvFfs3A5fxtvxE4HWdgQNpGA1iCKZ5pKmMAx4fKmGxh4esyfQ5gaz3CRfc
	9pQb4SN0WCmZPlyFwXILgMbuutc4NlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMJuD2FFA6qLrLUw153O3tqt0ZSz0/RTRaYLJbw0964=;
	b=9LY6+rRqErJQKVD60bVDkwgY0+cOawY0mff7G2Jr1UJoiM7+SDngUxpvaKe89mtjrM51kA
	lBPhEeUx9pZcuTDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3172F13869;
	Mon,  8 Sep 2025 09:43:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QcQMDC6lvmjSbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Sep 2025 09:43:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E983DA0A2D; Mon,  8 Sep 2025 11:43:05 +0200 (CEST)
Date: Mon, 8 Sep 2025 11:43:05 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 09/21] check_export(): constify path argument
Message-ID: <z56dhwdctwyvhgsxathpz5pypu7mswla5r7vtrobrvhetf6mxd@fkyit364vny2>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-9-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-9-viro@zeniv.linux.org.uk>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Sat 06-09-25 10:11:25, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/nfsd/export.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index dffb24758f60..caa695c06efb 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -402,7 +402,7 @@ static struct svc_export *svc_export_update(struct svc_export *new,
>  					    struct svc_export *old);
>  static struct svc_export *svc_export_lookup(struct svc_export *);
>  
> -static int check_export(struct path *path, int *flags, unsigned char *uuid)
> +static int check_export(const struct path *path, int *flags, unsigned char *uuid)
>  {
>  	struct inode *inode = d_inode(path->dentry);
>  
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

