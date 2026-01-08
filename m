Return-Path: <linux-fsdevel+bounces-72863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C17AD03CD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84FDF3187708
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287602DC322;
	Thu,  8 Jan 2026 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qz9pm/hC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OfqF8fF3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qz9pm/hC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OfqF8fF3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0F450097E
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767883965; cv=none; b=AyXX+BUBNZz2R2fCcW6IZFwB7IDOSZLj/HPFvM6s32bRpRXZ6hUDvEYQomHhUmwTxJGO9o0OwSgTp8TSW8Lr4oVTq2R0YZT7YRIWA79Hz6PLurZ1j7f7RIIi7QsWGW7vpgiqiTC+Q+SKnzIk7G1Pk08rH1XYwhotaMa9cBO7eyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767883965; c=relaxed/simple;
	bh=cO621mnjFcoQyLOAtXlQSioDOCGoJQMyXQY0Q+B5ao0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHUS10agkeUzrg2fhwCmBHBnNSdEQOoZKSgqmGuHmoXpUiCq2PpAuyO1fqA7/AXpWn1VOHqmZHtJ51ixLSED6wYbkBfWpAfokaklvlWB3pXzobqvr1hMh8XkWjpawkGjYCXAL84Trs6lcFPBCHskn45pyESRtJQiAlQmPT866jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qz9pm/hC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OfqF8fF3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qz9pm/hC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OfqF8fF3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB8C234317;
	Thu,  8 Jan 2026 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767883961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9P33gJY6cdcXN4gsUXWmBD42uSLmlczLJOrjbAI4OM=;
	b=Qz9pm/hCHTSUWo9rtJ2/Jng0zUmzJWuIwxi4q6xl4CDS/kPrVHtkMCYd5m9BjL3OzFgP0W
	kxmUVfymumLeU0nI0+R4A3V+saA0+Hd9JUeuRxweJ6TYb2nQWO0Yu6rtncrZQac5yRFxuE
	RVXJVL38BcSVvSsNtX/Rrd3WaXBuj9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767883961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9P33gJY6cdcXN4gsUXWmBD42uSLmlczLJOrjbAI4OM=;
	b=OfqF8fF3RxT47hd6FBMNm1jpI+4J1xzwkIF7TvlX+xvC+3r9cQl81KqcyicKzKLxnYoss1
	LSXgi+FUcUjXOTCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Qz9pm/hC";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OfqF8fF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767883961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9P33gJY6cdcXN4gsUXWmBD42uSLmlczLJOrjbAI4OM=;
	b=Qz9pm/hCHTSUWo9rtJ2/Jng0zUmzJWuIwxi4q6xl4CDS/kPrVHtkMCYd5m9BjL3OzFgP0W
	kxmUVfymumLeU0nI0+R4A3V+saA0+Hd9JUeuRxweJ6TYb2nQWO0Yu6rtncrZQac5yRFxuE
	RVXJVL38BcSVvSsNtX/Rrd3WaXBuj9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767883961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9P33gJY6cdcXN4gsUXWmBD42uSLmlczLJOrjbAI4OM=;
	b=OfqF8fF3RxT47hd6FBMNm1jpI+4J1xzwkIF7TvlX+xvC+3r9cQl81KqcyicKzKLxnYoss1
	LSXgi+FUcUjXOTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 996583EA63;
	Thu,  8 Jan 2026 14:52:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EhZuJbnEX2l9WwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Jan 2026 14:52:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5DC23A09CF; Thu,  8 Jan 2026 15:52:41 +0100 (CET)
Date: Thu, 8 Jan 2026 15:52:41 +0100
From: Jan Kara <jack@suse.cz>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.or, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: add <linux/init_task.h> for 'init_fs'
Message-ID: <ykobzabaopivf4ltmayktpobcd77dyf243moioqjiaydapugd2@sucwmv52we3h>
References: <20260108115856.238027-1-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108115856.238027-1-ben.dooks@codethink.co.uk>
X-Spam-Score: -4.01
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:email];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AB8C234317
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Thu 08-01-26 11:58:56, Ben Dooks wrote:
> The init_fs symbol is defined in <linux/init_task.h> but was
> not included in fs/fs_struct.c so fix by adding the include.
> 
> Fixes the following sparse warning:
> fs/fs_struct.c:150:18: warning: symbol 'init_fs' was not declared. Should it be static?
> 
> Fixes: 3e93cd671813e ("Take fs_struct handling to new file")
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs_struct.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fs_struct.c b/fs/fs_struct.c
> index b8c46c5a38a0..394875d06fd6 100644
> --- a/fs/fs_struct.c
> +++ b/fs/fs_struct.c
> @@ -6,6 +6,7 @@
>  #include <linux/path.h>
>  #include <linux/slab.h>
>  #include <linux/fs_struct.h>
> +#include <linux/init_task.h>
>  #include "internal.h"
>  
>  /*
> -- 
> 2.37.2.352.g3c44437643
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

