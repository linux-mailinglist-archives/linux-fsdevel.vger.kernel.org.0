Return-Path: <linux-fsdevel+bounces-20807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81838D80E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3931C21C5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 11:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3A784039;
	Mon,  3 Jun 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e7VpV3zs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B5L/F2DY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ose4pF9G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TC39YB7Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9019E;
	Mon,  3 Jun 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413532; cv=none; b=QcFXCsELasud+V/EiplReys4U3aaKE6X7JDi8WLpscrWGv1MgyFHuhiZEm5iZuXLyLRPZe6KdANYs3qKgjPtAcs+U5H200PbzOAGysBoJSzhKs7cc2C0SV6w9PkRcmyMU5UpnxJ6ZKjU/6G9+OmsIU6gfVbI69aZvSX+oOuLrg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413532; c=relaxed/simple;
	bh=Z/kN2v+vYtxWp9RIZ2oSiu3+w1DhZNB4wkdQ143Vr0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sle9sQB2G575W4+HU6K/1P10iaadosDMwXzGyI/JWB1VIpld2tBx90rMtBmyhtG9VVgsrYoz8qL9oj3gvpxZGVxZQ4A589eTF88snaQfvPYhX68Am1tUfTOMpY1ko9o/7lK0AZhKgLkXhzlkgrMBlLlTfcbcJeE1rLbla2tYeAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e7VpV3zs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B5L/F2DY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ose4pF9G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TC39YB7Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E6EE520032;
	Mon,  3 Jun 2024 11:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717413529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7x+DjdWOAhVr3HrnwN5lbbMnHsmhdZvdjrufKWRKMxY=;
	b=e7VpV3zs2jh+wmbrUdLnR26tJzGo2RKy3ZFsqf0mnVPCJlUvIucThKrDFs1rU1jWtTP+yu
	iNgowpia0gANIlcEpA3QgQbV6TPlyHvj1qHrrT3hDzuuLDLQyl2salwDdrGrKksBDQHymK
	R9h4Q5T81O/V0w5/FmhEjf9RQiLL5NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717413529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7x+DjdWOAhVr3HrnwN5lbbMnHsmhdZvdjrufKWRKMxY=;
	b=B5L/F2DYaT9ZV5fIfhTflOgVFOXiQEUcfY/X5RwOZs01JsHCrAQjxFJcPNP9qoD4RUAWiq
	QxGVRDPT420hOzCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ose4pF9G;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TC39YB7Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717413528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7x+DjdWOAhVr3HrnwN5lbbMnHsmhdZvdjrufKWRKMxY=;
	b=Ose4pF9G29NVZPwO90i+1qNfs6QpxTCF5o7IkLhxYu4x41Y66IQXPJV4ycQANu5JXeETeY
	6afuL1MP1e7r7x8ZQUiGNc9uxR8ZiSAOQ6b3uy1OnXoPXQulIdN6JXnJJEshz2vPyed/Xn
	vGS4qCT2FodIFzV2k2PZYvfAnqsKTkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717413528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7x+DjdWOAhVr3HrnwN5lbbMnHsmhdZvdjrufKWRKMxY=;
	b=TC39YB7QGP3fbWt9znHOLLLqnPvKa+zz9NdPDlwUVWewicmzUccizkYdlY8VQNJtoOTvr7
	ksULYXT31/JvqABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D90E713A93;
	Mon,  3 Jun 2024 11:18:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7oKvNJimXWZyJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Jun 2024 11:18:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 816E8A087F; Mon,  3 Jun 2024 13:18:44 +0200 (CEST)
Date: Mon, 3 Jun 2024 13:18:44 +0200
From: Jan Kara <jack@suse.cz>
To: Youling Tang <youling.tang@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] fs/direct-io: Remove linux/prefetch.h include
Message-ID: <20240603111844.l4g2yk5q6z23cz3n@quack3>
References: <20240603014834.45294-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603014834.45294-1-youling.tang@linux.dev>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-2.98)[99.92%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E6EE520032
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.99

On Mon 03-06-24 09:48:34, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> After commit c22198e78d52 ("direct-io: remove random prefetches"), Nothing
> in this file needs anything from `linux/prefetch.h`.
> 
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/direct-io.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index b0aafe640fa4..bbd05f1a2145 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -37,7 +37,6 @@
>  #include <linux/rwsem.h>
>  #include <linux/uio.h>
>  #include <linux/atomic.h>
> -#include <linux/prefetch.h>
>  
>  #include "internal.h"
>  
> @@ -1121,11 +1120,6 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	struct blk_plug plug;
>  	unsigned long align = offset | iov_iter_alignment(iter);
>  
> -	/*
> -	 * Avoid references to bdev if not absolutely needed to give
> -	 * the early prefetch in the caller enough time.
> -	 */
> -
>  	/* watch out for a 0 len io from a tricksy fs */
>  	if (iov_iter_rw(iter) == READ && !count)
>  		return 0;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

