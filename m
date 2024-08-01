Return-Path: <linux-fsdevel+bounces-24826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BC4945162
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 19:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF1DFB276E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9041B3F3D;
	Thu,  1 Aug 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="altDG89D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y6YP8kBE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="altDG89D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y6YP8kBE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635071EB4B1
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722532798; cv=none; b=fKGEUR0unhKrsq8DUu8Kl9X9uS3BaC0Z4aSHLYdJnPmufLaoDJz9kHM2mJ7AePcWudCZyrjsjSc7nyopSWi+H5ckrAjRFuUCn+Cz3q+qEO46Tigesv1kDSfxq828jcj4j/A0l+/w42LKHD7IlqlFdDblctni12Sozs64dDVBWYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722532798; c=relaxed/simple;
	bh=uGctWf4MpSH6eLGURwyBVSoJhrZIa++Lpgl6szmgN+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pU4zYhHoUXbRev4uLOIKaumCOgAHH+Yg3TH8CzzSytRd3BJdxKrUgD46UyalNUWWXfBnKS1NW2j/mBOZ2a2AWL9TKhLd9ZpoyBS5RDZN02gzV3zhpg2/j3D2iO6Qs16fYodlpslkjb6vHB71SQ7u/Pv72yzaQhIYZX19YEDy11Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=altDG89D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y6YP8kBE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=altDG89D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y6YP8kBE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9D56E1FB65;
	Thu,  1 Aug 2024 17:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722532794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AUQb72yKsPn0v9DfEJu6bL/IW36thatU7Gs4lKGGE88=;
	b=altDG89DfvCILzodRdl0Dn+u0XaaiI75rTLGVL3WCmtMxUVpEwbZ7hIiWA9oS2tuxVq/Va
	Zqr06VhJbwPx28rVkelEEgm8Cm/v93B7eR10oy/kz8oXlet+K83hVSteAFIwM+hmcVIlWY
	otkE9dYg5BkOySNQ5r68QmtnUsW5WRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722532794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AUQb72yKsPn0v9DfEJu6bL/IW36thatU7Gs4lKGGE88=;
	b=y6YP8kBE/nexmQCnbHyEJlbTx+EuXtpQHVQVnOBerGj39M1OOcVL4P8wMc1WKisG/kjHgU
	JLOptqm0tu6m6IDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722532794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AUQb72yKsPn0v9DfEJu6bL/IW36thatU7Gs4lKGGE88=;
	b=altDG89DfvCILzodRdl0Dn+u0XaaiI75rTLGVL3WCmtMxUVpEwbZ7hIiWA9oS2tuxVq/Va
	Zqr06VhJbwPx28rVkelEEgm8Cm/v93B7eR10oy/kz8oXlet+K83hVSteAFIwM+hmcVIlWY
	otkE9dYg5BkOySNQ5r68QmtnUsW5WRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722532794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AUQb72yKsPn0v9DfEJu6bL/IW36thatU7Gs4lKGGE88=;
	b=y6YP8kBE/nexmQCnbHyEJlbTx+EuXtpQHVQVnOBerGj39M1OOcVL4P8wMc1WKisG/kjHgU
	JLOptqm0tu6m6IDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F48A136CF;
	Thu,  1 Aug 2024 17:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uV+hIrrDq2Z4NAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Aug 2024 17:19:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3AA7DA08CB; Thu,  1 Aug 2024 19:19:50 +0200 (CEST)
Date: Thu, 1 Aug 2024 19:19:50 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 07/10] fanotify: rename a misnamed constant
Message-ID: <20240801171950.stcczm6nvi44mqt3@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <20137566913a612692aaa0a9c79bb0345e94c26d.1721931241.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20137566913a612692aaa0a9c79bb0345e94c26d.1721931241.git.josef@toxicpanda.com>
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Thu 25-07-24 14:19:44, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> FANOTIFY_PIDFD_INFO_HDR_LEN is not the length of the header.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 3a7101544f30..5ece186d5c50 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -119,7 +119,7 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
>  #define FANOTIFY_EVENT_ALIGN 4
>  #define FANOTIFY_FID_INFO_HDR_LEN \
>  	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
> -#define FANOTIFY_PIDFD_INFO_HDR_LEN \
> +#define FANOTIFY_PIDFD_INFO_LEN \

OK, but then FANOTIFY_FID_INFO_HDR_LEN should be renamed as well? Or what's
the difference?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

