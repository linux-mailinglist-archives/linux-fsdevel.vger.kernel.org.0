Return-Path: <linux-fsdevel+bounces-52534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F5CAE3E21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228E47A312E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D62241674;
	Mon, 23 Jun 2025 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="feoY0ZMQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/kSgPVQo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="feoY0ZMQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/kSgPVQo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838CC23C390
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750678793; cv=none; b=jdqZGG6Vm6nQCF5+mBVKLg5jGNA7xkR/ZrWihhggkYOgDgmQWPYfMyId4q7UXmcM4Kl+0fq0FE5quv8i9i84/hsD7UScjOyETWQZRhjBiF6W9Vo9Vz0pay9jhxR1ea5DFHoWMxxT6bNBqUjkzA9xP2rW6P1JIq9M4DooMRymJvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750678793; c=relaxed/simple;
	bh=LYAUwMKIczA0B7ckIC7/uj2g/BXFuT92wHgXn2JLoVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0Vl/zkE4tElCRZBRPoHcRdcFiTqAb0zj8zlIH/bEAINMSI0ohPNZ5tzX/sVlUZZfAgN2ZpEAqBLx3r9Je9M49e7LWrcpfZIqmoY2gj87HPDdvNyJlfaujHbgRIFLpEiceYdkIpTU4qGlL/NS8USLoxNAb8V7wwX6J19Ye4CItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=feoY0ZMQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/kSgPVQo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=feoY0ZMQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/kSgPVQo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BBC1F1F385;
	Mon, 23 Jun 2025 11:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750678789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prpoXKbsNIY30xUEm2GgZqRi8prcfKUqQKBdRy67G84=;
	b=feoY0ZMQyP417iZSCyB/AXvP+5zXqTpZ6xE9qlkIdZx+P2AIpmXRuU7gduaewCDjcUjsTC
	DWjNAEMKUebBH/bAiM70v12zrhhc+MlYD6mNaBaIDX6hFCSADzl3chuUcbWOCHOKE3D4Df
	CnnJOwhdp/ouOq8SESyVe9wYz0K1XyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750678789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prpoXKbsNIY30xUEm2GgZqRi8prcfKUqQKBdRy67G84=;
	b=/kSgPVQo8SuoF8eBtU7XqvZR5irTudkRRJvalzcdzs7twlclC08n+NvIHbber+yw7SCsQz
	CnCxfpxcvODlD0Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750678789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prpoXKbsNIY30xUEm2GgZqRi8prcfKUqQKBdRy67G84=;
	b=feoY0ZMQyP417iZSCyB/AXvP+5zXqTpZ6xE9qlkIdZx+P2AIpmXRuU7gduaewCDjcUjsTC
	DWjNAEMKUebBH/bAiM70v12zrhhc+MlYD6mNaBaIDX6hFCSADzl3chuUcbWOCHOKE3D4Df
	CnnJOwhdp/ouOq8SESyVe9wYz0K1XyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750678789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prpoXKbsNIY30xUEm2GgZqRi8prcfKUqQKBdRy67G84=;
	b=/kSgPVQo8SuoF8eBtU7XqvZR5irTudkRRJvalzcdzs7twlclC08n+NvIHbber+yw7SCsQz
	CnCxfpxcvODlD0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC43613A27;
	Mon, 23 Jun 2025 11:39:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dzgHKgU9WWghMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Jun 2025 11:39:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 34F27A2A00; Mon, 23 Jun 2025 13:39:49 +0200 (CEST)
Date: Mon, 23 Jun 2025 13:39:49 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 5/9] fhandle: reflow get_path_anchor()
Message-ID: <oox4p46wsruz3v6dgfcxtk2gqpbqxypsrn2eplsital3zegcuq@ocklmxj5duxw>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-5-75899d67555f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623-work-pidfs-fhandle-v1-5-75899d67555f@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Level: 

On Mon 23-06-25 11:01:27, Christian Brauner wrote:
> Switch to a more common coding style.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fhandle.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index d8d32208c621..22edced83e4c 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -170,18 +170,22 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
>  
>  static int get_path_anchor(int fd, struct path *root)
>  {
> +	if (fd >= 0) {
> +		CLASS(fd, f)(fd);
> +		if (fd_empty(f))
> +			return -EBADF;
> +		*root = fd_file(f)->f_path;
> +		path_get(root);
> +		return 0;
> +	}
> +
>  	if (fd == AT_FDCWD) {
>  		struct fs_struct *fs = current->fs;
>  		spin_lock(&fs->lock);
>  		*root = fs->pwd;
>  		path_get(root);
>  		spin_unlock(&fs->lock);
> -	} else {
> -		CLASS(fd, f)(fd);
> -		if (fd_empty(f))
> -			return -EBADF;
> -		*root = fd_file(f)->f_path;
> -		path_get(root);
> +		return 0;
>  	}
>  
>  	return 0;
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

