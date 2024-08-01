Return-Path: <linux-fsdevel+bounces-24831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFDA94526D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 19:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CD5282C6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 17:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543EA1B9B3A;
	Thu,  1 Aug 2024 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bxZbgN6F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="McW7tnEA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q2/+nv3s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W8bX5V74"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018CD1B32D9
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722535160; cv=none; b=Fx8ma33pNOASQhKZka5Z/a0EaWhR3nvR1AdpSwbDeStZ9SSpjZLzrFa794wYXfwRKEDJ8GDzcJpnzGo3hkuNzx5YUkgNzG2TvGcOP6EkDO1H140IHSu924pFfjoz87lPv94cebHfi1MsDySD8RLskmOCcy56edNRWcghi1nEoTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722535160; c=relaxed/simple;
	bh=MIESSIONJkVwVN1Ey2JlrfLxsayGf6wPTUstto3ugRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwz9YIAH3eM2owxYEp4HaznAOccx9f0JtTBjgoL2Iznpz4I/ByzPoITh6CXwTMZ3xCB/sfY9s1dB/uKjrwQF2hrfH0U25FoBdjIbt2Wz9pMvUqqU6N1eYw2IVG/b+GNIGe9Vc/W0JtRXJQgXTxKye7CH2TtbB5+dFhyQDMuLktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bxZbgN6F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=McW7tnEA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q2/+nv3s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W8bX5V74; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF4D91F8D4;
	Thu,  1 Aug 2024 17:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722535157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Vty6lILh6VlsIxeH0BRhAvWLDOka1mNfSUQYF2tDgw=;
	b=bxZbgN6FLiesDwSgn1pfl7S4vkbAHziWaZj/N60PRgIyuZQsxn0IcU883WaKD1AND4LEGd
	CQTJ0hYI8AUHkarw2/UWn/IRkcnOgaYRmC6zw9InGh7mk+afPPuwgD5AC456aBTT48JTf6
	QhmwtFJWmmdlZWA/UTWdN5/sD0y0A9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722535157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Vty6lILh6VlsIxeH0BRhAvWLDOka1mNfSUQYF2tDgw=;
	b=McW7tnEAmfrPms7ExQ2fbh65akk4rlTVhK+4njyJrfiQ4NN8RysM7IRPIiJCS2vcijjrqx
	iAzg1SDHt62Cx1Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="q2/+nv3s";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=W8bX5V74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722535156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Vty6lILh6VlsIxeH0BRhAvWLDOka1mNfSUQYF2tDgw=;
	b=q2/+nv3swzM0BzqKj7wMLFCnF2LGFngm6lcVahCLmQ8ao7JG9z/f7FjZ+YURYVLuBMcOsY
	t7iGk90guavdk0rYF/XWpPomDF7kI7PhP7hjU/vsmbbsSUj/YCgBXznns9Zz4Q4BAenVhL
	6jGYmA8FkU+j/SCuwZ9uecRk/ym6GKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722535156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Vty6lILh6VlsIxeH0BRhAvWLDOka1mNfSUQYF2tDgw=;
	b=W8bX5V742basVgo6JM0YC1VdjqZIrfyrDZ8Zs0QNPC97OkgSPZrG+/hVg5RMw6fZ10VbD1
	XWMQ5X4zlKz1U+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1712136CF;
	Thu,  1 Aug 2024 17:59:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SqvENvTMq2auPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Aug 2024 17:59:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7DF96A08CB; Thu,  1 Aug 2024 19:59:12 +0200 (CEST)
Date: Thu, 1 Aug 2024 19:59:12 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 01/10] fanotify: don't skip extra event info if no
 info_mode is set
Message-ID: <20240801175912.iowqorsgweidtcih@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <adfd31f369528c9958922d901fbe8eba48dfe496.1721931241.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfd31f369528c9958922d901fbe8eba48dfe496.1721931241.git.josef@toxicpanda.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EF4D91F8D4
X-Spam-Score: -3.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim]

On Thu 25-07-24 14:19:38, Josef Bacik wrote:
> Previously we would only include optional information if you requested
> it via an FAN_ flag at fanotify_init time (FAN_REPORT_FID for example).
> However this isn't necessary as the event length is encoded in the
> metadata, and if the user doesn't want to consume the information they
> don't have to.

So I somewhat disagree with this statement because historically there was
fanotify userspace that completely ignored event length reported in the
event and assumed particular hardcoded constant that was working for years.
That's why we are careful and add info to *existing* events only if
userspace explicitely asks for it (by which it obviously also acknowledges
that it is ready to parse/skip it). Now here we are adding range info only
to new events so preexisting userspace isn't a problem in this case. And I
agree it is kind of pointless to add a new flag, just to be able to tell
you want info without which these events are pointless.

Also as far as I can tell these changes will not result in any new info
records to be generated for existing events. So I would just change the
description to something like:

New pre-content events will be path events but they will also carry
additional range information. Remove the optimization to skip checking
whether info structures need to be generated for path events. This results
in no change in generated info structures for existing events.

								Honza

>  With the PRE_ACCESS events we will always generate range
> information, so drop this check in order to allow this extra
> information to be exported without needing to have another flag.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 9ec313e9f6e1..2e2fba8a9d20 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -160,9 +160,6 @@ static size_t fanotify_event_len(unsigned int info_mode,
>  	int fh_len;
>  	int dot_len = 0;
>  
> -	if (!info_mode)
> -		return event_len;
> -
>  	if (fanotify_is_error_event(event->mask))
>  		event_len += FANOTIFY_ERROR_INFO_LEN;
>  
> @@ -740,12 +737,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  	if (fanotify_is_perm_event(event->mask))
>  		FANOTIFY_PERM(event)->fd = fd;
>  
> -	if (info_mode) {
> -		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
> -						buf, count);
> -		if (ret < 0)
> -			goto out_close_fd;
> -	}
> +	ret = copy_info_records_to_user(event, info, info_mode, pidfd,
> +					buf, count);
> +	if (ret < 0)
> +		goto out_close_fd;
>  
>  	if (f)
>  		fd_install(fd, f);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

