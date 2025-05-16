Return-Path: <linux-fsdevel+bounces-49232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93519AB99E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2612F1BC332B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 10:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1178623507C;
	Fri, 16 May 2025 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G/xW6hKo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yenVOTit";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CKWmRg5V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fy5e7FJz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736D235064
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390383; cv=none; b=S2plJCX5uIGobgnoLFrsWstnv94TZW/m8mYl27kDC68ilwmCnkfEwxKy8OLIPm631bwtiJ8ky3CaIbOkwEboSUyp9W5+/o4iwr0hmKjM4yrjBt0MnCfCBUIgTCrUIP0DO2JdtfkEmNEdz4Xuz/TAlcuk+j01PLqsY3+TN13mO/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390383; c=relaxed/simple;
	bh=Qd5OHz68TL+qhtqYAwRqfdjGPkzqTAYGzrOKfS/Mpj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nj0btKRnbScbqOkzq4U+FdTiYKnjr+OZPQpre+clpLwXrReGXcnBFz20cxb32YAuP5ls5aJSuVMlBsLWg5xzLiPBgFLWw7MBltHrrkKXEFhbPaL9RlZIpHV5aRSPcipDpSuYhbW8sEota+Lg8eiGvjrMYXw4dQUVaKWBVWsBdEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G/xW6hKo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yenVOTit; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CKWmRg5V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fy5e7FJz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D24E41F7EE;
	Fri, 16 May 2025 10:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747390380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xxM9KrxnONZDCqo4vvVvPmj5MMjdqHwYFcd7PfQnC3Q=;
	b=G/xW6hKoK0FVNqKMoKN5cnoU9b35oDJR9tWhIDhvV+l9CoGoI9asLPRQtFCJPBAdauGd1i
	yfzYBv5oeCBezi2ZJ1SIs7OMiv6xvydOYtLmaQGNKUILJCjUQfZaCMkyWhxZxIgIqsO8CY
	qi9z3ucGZVfik+0gp1K/WzueroFrc98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747390380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xxM9KrxnONZDCqo4vvVvPmj5MMjdqHwYFcd7PfQnC3Q=;
	b=yenVOTitvVMhJ9Vnzw6NSxOkptI/dI6Q33cALVgDElJ4NiVPIJDp5oyzB9wS8EtPVxgQCo
	UopjqYn8HSGuOVBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CKWmRg5V;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Fy5e7FJz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747390379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xxM9KrxnONZDCqo4vvVvPmj5MMjdqHwYFcd7PfQnC3Q=;
	b=CKWmRg5Vld1B6UNPxQg1bLy3iTJ1LDbVPH1DGe9BNH6aPUmvQRbFMTE2Q7s7tA40tZ/xIT
	DqqJnCDEFSFp92e3ksMUPsmltipDjU8REXFDfucyidzXoeL+lNC2c+KvxwLu305gh4nkp2
	T8lJiIzfngea8OVOxb8kzRD0eeYlzBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747390379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xxM9KrxnONZDCqo4vvVvPmj5MMjdqHwYFcd7PfQnC3Q=;
	b=Fy5e7FJzpEucGFq/8u7y92wXoyxvZuy5cUQ9FeG6YpDl83eb0j8Pdo9KRRJKXSGuQinh3Y
	9BiEhnFdA4V3eHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6B6113977;
	Fri, 16 May 2025 10:12:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6cyBMKsPJ2jiewAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 16 May 2025 10:12:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 835CFA09DD; Fri, 16 May 2025 12:12:59 +0200 (CEST)
Date: Fri, 16 May 2025 12:12:59 +0200
From: Jan Kara <jack@suse.cz>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] fs/buffer: avoid redundant lookup in getblk slowpath
Message-ID: <hjjkstrkljfsx2jxhlgif4jsox6lsaute6tx4bhk3yufxqs5re@qo3zuncbozph>
References: <20250515173925.147823-1-dave@stgolabs.net>
 <20250515173925.147823-3-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515173925.147823-3-dave@stgolabs.net>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D24E41F7EE
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action

On Thu 15-05-25 10:39:23, Davidlohr Bueso wrote:
> __getblk_slow() already implies failing a first lookup
> as the fastpath, so try to create the buffers immediately
> and avoid the redundant lookup. This saves 5-10% of the
> total cost/latency of the slowpath.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 5a4342881f3b..b02cced96529 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1139,15 +1139,15 @@ __getblk_slow(struct block_device *bdev, sector_t block,
>  	for (;;) {
>  		struct buffer_head *bh;
>  
> +		if (!grow_buffers(bdev, block, size, gfp))
> +			return NULL;
> +
>  		if (blocking)
>  			bh = __find_get_block_nonatomic(bdev, block, size);
>  		else
>  			bh = __find_get_block(bdev, block, size);
>  		if (bh)
>  			return bh;
> -
> -		if (!grow_buffers(bdev, block, size, gfp))
> -			return NULL;
>  	}
>  }
>  
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

