Return-Path: <linux-fsdevel+bounces-59983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFB6B400D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 14:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1B03AA287
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 12:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8207328B4FD;
	Tue,  2 Sep 2025 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vhd1XTlm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1uVI3aN/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vhd1XTlm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1uVI3aN/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43238287507
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816703; cv=none; b=duGG0+N6WQBYfkR5mEkGEE/ll6dMLeFfHMetn9X7+ER/PrEGk6dSotDZKXhHa0/NJOYUcfGyuTolmpQu2COj6lyVIYgq3ip8RsEZcePa/sdkkd3f5f8Q7AIB4jj/DZr68Mentpkeo9xesAZMmXhOAiYvSAjaBexd2jwadG7FV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816703; c=relaxed/simple;
	bh=9K+g7w0hO/i96+GvfEk5WzWcOU4CN8QGA1fbFpnUEy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3ecrJhAeyONGG38KM3CB34h7IdFWurSkxLFJsuXSoRv/QcUilHAJZhf9Y/1L63feH03Z3E/f2oVaxcjuR0F9dE0HMVd1HGmhLwfAKZrndsa6UXgVFY61BbDPDmeEpN3OHa9NDPGgKwVz+oqFikG74dJm1K5yFPKLVWrPurKbM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vhd1XTlm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1uVI3aN/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vhd1XTlm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1uVI3aN/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3227A1F388;
	Tue,  2 Sep 2025 12:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756816699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uim0ZjWZwHcKLGxi3vNKiOW2k+GyzDkoknXd9vwm55k=;
	b=vhd1XTlmdus4joXcGbJPjjoRcVU6dr2vEZOpX5BhxaQParmgxnuTjRJVoTXJZZL3fyjVI1
	PS5A4DciJ5c5/iptNNDKldwsMAGYcHo9Gn9rj37jJoxC/Tlw+PucmzGK157GM2Cl2ErV4L
	h0w7QmvPo1QDpnqP+n/HzGeo/ig6W4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756816699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uim0ZjWZwHcKLGxi3vNKiOW2k+GyzDkoknXd9vwm55k=;
	b=1uVI3aN/hjnt4pKa3QUHKGRnCQEjaghnYPpDDRG02xO3wX4lh3eGRZIEgHso6d+ReBInek
	zXkOgeY+5xBkWYCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vhd1XTlm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="1uVI3aN/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756816699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uim0ZjWZwHcKLGxi3vNKiOW2k+GyzDkoknXd9vwm55k=;
	b=vhd1XTlmdus4joXcGbJPjjoRcVU6dr2vEZOpX5BhxaQParmgxnuTjRJVoTXJZZL3fyjVI1
	PS5A4DciJ5c5/iptNNDKldwsMAGYcHo9Gn9rj37jJoxC/Tlw+PucmzGK157GM2Cl2ErV4L
	h0w7QmvPo1QDpnqP+n/HzGeo/ig6W4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756816699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uim0ZjWZwHcKLGxi3vNKiOW2k+GyzDkoknXd9vwm55k=;
	b=1uVI3aN/hjnt4pKa3QUHKGRnCQEjaghnYPpDDRG02xO3wX4lh3eGRZIEgHso6d+ReBInek
	zXkOgeY+5xBkWYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC62313888;
	Tue,  2 Sep 2025 12:38:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /OT4LTrltmgaSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Sep 2025 12:38:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B18D4A0A9F; Tue,  2 Sep 2025 14:38:12 +0200 (CEST)
Date: Tue, 2 Sep 2025 14:38:12 +0200
From: Jan Kara <jack@suse.cz>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fsnotify: fix "rewriten"->"rewritten"
Message-ID: <qbbnykq6egvq2ah2mmmx42ohucmoqhs5zciq7rc5uvzb6ql3bq@5b4z32zjsa6r>
References: <20250808084213.230592-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808084213.230592-1-zhao.xichao@vivo.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3227A1F388
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.01

On Fri 08-08-25 16:42:13, Xichao Zhao wrote:
> Trivial fix to spelling mistake in comment text.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Thanks. I've added the fix to my tree.

								Honza

> ---
>  fs/notify/inotify/inotify_fsnotify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> index cd7d11b0eb08..7c326ec2e8a8 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -10,7 +10,7 @@
>   * Copyright 2006 Hewlett-Packard Development Company, L.P.
>   *
>   * Copyright (C) 2009 Eric Paris <Red Hat Inc>
> - * inotify was largely rewriten to make use of the fsnotify infrastructure
> + * inotify was largely rewritten to make use of the fsnotify infrastructure
>   */
>  
>  #include <linux/dcache.h> /* d_unlinked */
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

