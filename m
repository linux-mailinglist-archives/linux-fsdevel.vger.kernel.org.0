Return-Path: <linux-fsdevel+bounces-37723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBD09F633F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 11:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E168162722
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BB019E99C;
	Wed, 18 Dec 2024 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ttSpTeQL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oBsShNME";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ttSpTeQL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oBsShNME"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758E19AD87;
	Wed, 18 Dec 2024 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734518113; cv=none; b=hNvxO48IoF8k2hKLtu3hXkMmpDQz1w0z5kpGUMHEjjN2xPxa2IhsjdBjMAPFDoZy/yrVAUWZFlXYjWsj/NynWHO6gtK6WSIaMqM+LfCLyWh3PsvOZLGyCO8yBRB/fEyA6KIWG8k9vkC2Ss8ncSl1HvdPaJNZLJEwO0GUvB0EAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734518113; c=relaxed/simple;
	bh=dZ1AzfRoyRVND4selkUnH/Jly1rO3LIsDM7xQj/T1Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3k0KQn9o/N7AFPUJn6OepFqwFCAVsBUMrK3WABzfxTxrD8hm9qnCbVUeZjJRaV7O6+wtWN2MgMad+lCHX3M8nZl2/Gs/j89TJBlc6VMkanicKdXt5YUq98G+46CY/E3l+GsTurnhgjIXdWjgGrOihCxfKgx3qgX2caXBbGL4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ttSpTeQL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oBsShNME; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ttSpTeQL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oBsShNME; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3179F1F396;
	Wed, 18 Dec 2024 10:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734518109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+SmraYU0h+R7YCPPlMGaG1Hg/PjgKkoqnUIyFTwpyk=;
	b=ttSpTeQLHLmMOS7+7W0pWsrs5k7lSomZ+Pb8NIJNDCL3E8aaL9dTZX09qVA9zbMWH1vcJI
	8cxkTtkGlpOTbvzESYM66LLlKFv620JgYxJKrHoQMKwJaFN+7Bo7c0ApESa+eKT+1/xDml
	vZDZ2ZrxgzQSmTZAN1qOAVsxnObRlzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734518109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+SmraYU0h+R7YCPPlMGaG1Hg/PjgKkoqnUIyFTwpyk=;
	b=oBsShNME3vSE3+NM3vqCO77XtSKQx0GvsfuQEmOZCb0MStB6hy8dsZFRMhFNvgJUYbxINU
	m25cMoZfQCjWP/AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734518109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+SmraYU0h+R7YCPPlMGaG1Hg/PjgKkoqnUIyFTwpyk=;
	b=ttSpTeQLHLmMOS7+7W0pWsrs5k7lSomZ+Pb8NIJNDCL3E8aaL9dTZX09qVA9zbMWH1vcJI
	8cxkTtkGlpOTbvzESYM66LLlKFv620JgYxJKrHoQMKwJaFN+7Bo7c0ApESa+eKT+1/xDml
	vZDZ2ZrxgzQSmTZAN1qOAVsxnObRlzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734518109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+SmraYU0h+R7YCPPlMGaG1Hg/PjgKkoqnUIyFTwpyk=;
	b=oBsShNME3vSE3+NM3vqCO77XtSKQx0GvsfuQEmOZCb0MStB6hy8dsZFRMhFNvgJUYbxINU
	m25cMoZfQCjWP/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 281B3137CF;
	Wed, 18 Dec 2024 10:35:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Uw3ECV2lYmfaWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Dec 2024 10:35:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DE97EA0935; Wed, 18 Dec 2024 11:35:08 +0100 (CET)
Date: Wed, 18 Dec 2024 11:35:08 +0100
From: Jan Kara <jack@suse.cz>
To: Kees Cook <kees@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] inotify: Use strscpy() for event->name copies
Message-ID: <20241218103508.zxk5th7eqo4okkwt@quack3>
References: <20241216224507.work.859-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216224507.work.859-kees@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 16-12-24 14:45:15, Kees Cook wrote:
> Since we have already allocated "len + 1" space for event->name, make sure
> that name->name cannot ever accidentally cause a copy overflow by calling
> strscpy() instead of the unbounded strcpy() routine. This assists in
> the ongoing efforts to remove the unsafe strcpy() API[1] from the kernel.
> 
> Link: https://github.com/KSPP/linux/issues/88 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Thanks. Added to my tree.

								Honza

> ---
> Cc: Jan Kara <jack@suse.cz>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/notify/inotify/inotify_fsnotify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> index 993375f0db67..cd7d11b0eb08 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -121,7 +121,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
>  	event->sync_cookie = cookie;
>  	event->name_len = len;
>  	if (len)
> -		strcpy(event->name, name->name);
> +		strscpy(event->name, name->name, event->name_len + 1);
>  
>  	ret = fsnotify_add_event(group, fsn_event, inotify_merge);
>  	if (ret) {
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

