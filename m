Return-Path: <linux-fsdevel+bounces-36273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A40F9E07D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 17:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6FE281D97
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 16:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D05D13E04B;
	Mon,  2 Dec 2024 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1lKZRHzy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SJ9YJfWV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1lKZRHzy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SJ9YJfWV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22112B640;
	Mon,  2 Dec 2024 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155265; cv=none; b=ZvruAVRsuBePnN3NDVg5OvOikVsEvF7rZ8VVcWz0YprPFxDQsLRiq/5GZjLbQr7kDuo+rsc08aauOLAOdwVxVaIEdUMlIZ8P3xDykC33Akon3Y4//q9KUuOD4OAf/dKL27yLOQSM6NlPY1C9QRdyRdjhTds4mwk5Eokd2gONw4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155265; c=relaxed/simple;
	bh=MOS7CERrsh+af6jAUtNSz53cnqE9D/M6tL+djgulGTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aADd+H8ttlO6uV1wPZFuXFX3JhUK0/U16GLg3vSgV5FXo1+EQLYK5SLz6JMb5J3Ujnb8eeZIeDmmDMOTfBjfMZQbgrxxyXv80jmbA7anUNRSvecqwmi//d7Vw+2AgWfkkIoJUwYShD5rd2gSEYq0ubLJWRSYbb0JpGhGUe9X0rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1lKZRHzy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SJ9YJfWV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1lKZRHzy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SJ9YJfWV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4175E1F396;
	Mon,  2 Dec 2024 16:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733155261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cSQilYg7QbhZdhVp88ChpDOn18er2yWDyruUkqZyLWs=;
	b=1lKZRHzyuwldXwr4vpU9u4EFqSS8DBGkbga54iCLQLVz+T4msUiJP7F7gQ8eIs3Wp0n+PU
	JjA9MZP+xt8QU0FCcO3brZ2F2pfHVEzAXxFcbXCnQipgTUPdntpGJMlSHNIl9eXM9yp9o7
	ssSWFpIpkM5LQXtSgi/LWgysk9rWb8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733155261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cSQilYg7QbhZdhVp88ChpDOn18er2yWDyruUkqZyLWs=;
	b=SJ9YJfWVoj9gSIpnlHXzaENP3nZ0RZteqFFcym3AJWbn8EmH2a8mj5YCSOmsad91uqzICF
	xCQu4rADPeUnaJCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1lKZRHzy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SJ9YJfWV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733155261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cSQilYg7QbhZdhVp88ChpDOn18er2yWDyruUkqZyLWs=;
	b=1lKZRHzyuwldXwr4vpU9u4EFqSS8DBGkbga54iCLQLVz+T4msUiJP7F7gQ8eIs3Wp0n+PU
	JjA9MZP+xt8QU0FCcO3brZ2F2pfHVEzAXxFcbXCnQipgTUPdntpGJMlSHNIl9eXM9yp9o7
	ssSWFpIpkM5LQXtSgi/LWgysk9rWb8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733155261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cSQilYg7QbhZdhVp88ChpDOn18er2yWDyruUkqZyLWs=;
	b=SJ9YJfWVoj9gSIpnlHXzaENP3nZ0RZteqFFcym3AJWbn8EmH2a8mj5YCSOmsad91uqzICF
	xCQu4rADPeUnaJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3057713A31;
	Mon,  2 Dec 2024 16:01:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ksGDC73ZTWe+PAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Dec 2024 16:01:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D934CA07B4; Mon,  2 Dec 2024 17:01:00 +0100 (CET)
Date: Mon, 2 Dec 2024 17:01:00 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 4/6] fhandle: pull CAP_DAC_READ_SEARCH check into
 may_decode_fh()
Message-ID: <20241202160100.sswfmbxiah2sglsc@quack3>
References: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
 <20241129-work-pidfs-file_handle-v1-4-87d803a42495@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129-work-pidfs-file_handle-v1-4-87d803a42495@kernel.org>
X-Rspamd-Queue-Id: 4175E1F396
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[e43.eu,gmail.com,kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 29-11-24 14:38:03, Christian Brauner wrote:
> There's no point in keeping it outside of that helper. This way we have
> all the permission pieces in one place.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fhandle.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index c00d88fb14e16654b5cbbb71760c0478eac20384..031ad5592a0beabcc299436f037ad5fe626332e6 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -298,6 +298,9 @@ static inline bool may_decode_fh(struct handle_to_path_ctx *ctx,
>  {
>  	struct path *root = &ctx->root;
>  
> +	if (capable(CAP_DAC_READ_SEARCH))
> +		return true;
> +
>  	/*
>  	 * Restrict to O_DIRECTORY to provide a deterministic API that avoids a
>  	 * confusing api in the face of disconnected non-dir dentries.
> @@ -337,7 +340,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>  	if (retval)
>  		goto out_err;
>  
> -	if (!capable(CAP_DAC_READ_SEARCH) && !may_decode_fh(&ctx, o_flags)) {
> +	if (!may_decode_fh(&ctx, o_flags)) {
>  		retval = -EPERM;
>  		goto out_path;
>  	}
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

