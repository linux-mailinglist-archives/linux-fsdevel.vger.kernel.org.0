Return-Path: <linux-fsdevel+bounces-60151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9C2B421B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 15:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94ED91A83FC5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 13:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B46F3090DB;
	Wed,  3 Sep 2025 13:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t6CQIDOw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WPLF8Jl+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t6CQIDOw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WPLF8Jl+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8952D308F3D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906320; cv=none; b=ezccgcvnK5vzSKKO7CqEblexuUxkeJYwxOXmI4UZS8e5uVQ3NsolA95zu2Ne1YIXK6XMgbVLtoOjS39NENRfcEOcNyfHs2rEHmILfdJ/koaDf2rDmg+e/WaEZi+47q+8XA+nJWEZSsZQUgLANSEppQXjas/GZDMvt03x4jPWZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906320; c=relaxed/simple;
	bh=aSnS4pvSDH/7u/cUFs0wyGPAIN8XB1S6cH0Hhkf7X2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qs6f1LbmpwmEchDXapCl4/sCkBEmIS6QaVpKb6WEWwDnSMfQnanvqTzhUgMb/xRtk5D+J80ecqRfGUS+iIeigBZEhev11rgNwisZ6dMxyJrwVQaANmbh6d1ldPrFtAzZl6kD0pk6HYMLgvRn7FwNOGr0IOMRmWWn9TIf+owPn2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t6CQIDOw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WPLF8Jl+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t6CQIDOw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WPLF8Jl+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B6A25211A5;
	Wed,  3 Sep 2025 13:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756906316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6EB2W1pLl4m1e5pdwO9j0i4xflpTmsKnJvOETtyCf/4=;
	b=t6CQIDOw5YkTvwNeljQgxRsfAnsJy41Amk6T/BubjysfOI0nJUu3swT6iEs6ShFZmjaHwF
	zA/Q0pH00EHbVTYnRCJCQPGlitC9sQtwTh0SSeIZXSDmwqH4YEU391xAk6xh/8cR+TRLUp
	G0CRo0UysuI7NEfep2dJjVsJjaGXfRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756906316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6EB2W1pLl4m1e5pdwO9j0i4xflpTmsKnJvOETtyCf/4=;
	b=WPLF8Jl+q2lN645zRfrKozTTpWDVYYKr5uFivyynhlk1ELWtzHxEfaAt6+WAq5NRRGZ2K6
	CbDnPE2wPtou4yCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=t6CQIDOw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WPLF8Jl+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756906316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6EB2W1pLl4m1e5pdwO9j0i4xflpTmsKnJvOETtyCf/4=;
	b=t6CQIDOw5YkTvwNeljQgxRsfAnsJy41Amk6T/BubjysfOI0nJUu3swT6iEs6ShFZmjaHwF
	zA/Q0pH00EHbVTYnRCJCQPGlitC9sQtwTh0SSeIZXSDmwqH4YEU391xAk6xh/8cR+TRLUp
	G0CRo0UysuI7NEfep2dJjVsJjaGXfRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756906316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6EB2W1pLl4m1e5pdwO9j0i4xflpTmsKnJvOETtyCf/4=;
	b=WPLF8Jl+q2lN645zRfrKozTTpWDVYYKr5uFivyynhlk1ELWtzHxEfaAt6+WAq5NRRGZ2K6
	CbDnPE2wPtou4yCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A04D313888;
	Wed,  3 Sep 2025 13:31:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xx0iJ0xDuGhKQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Sep 2025 13:31:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1DA19A0809; Wed,  3 Sep 2025 15:31:56 +0200 (CEST)
Date: Wed, 3 Sep 2025 15:31:56 +0200
From: Jan Kara <jack@suse.cz>
To: Diangang Li <lidiangang@bytedance.com>
Cc: jack@suse.cz, amir73il@gmail.com, stephen.s.brennan@oracle.com, 
	changfengnan@bytedance.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/1] fsnotify: clear PARENT_WATCHED flags lazily for v5.4
Message-ID: <ownanwiqdhijstazux3j5jsawdyw6tcgjufk6zrejppnqyoy7d@hdqmfb4q7wpz>
References: <20250903093413.3434-1-lidiangang@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903093413.3434-1-lidiangang@bytedance.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B6A25211A5
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,oracle.com,bytedance.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.01

On Wed 03-09-25 17:34:12, Diangang Li wrote:
> Hi Amir, Jan, et al,
> 
> Commit `41f49be2e51a71` ("fsnotify: clear PARENT_WATCHED flags lazily")
> has resolved the softlockup in `__fsnotify_parent` when there are millions
> of negative dentries. The Linux kernel CVE team has assigned CVE-2024-47660
> to this issue[1]. I noticed that the CVE patch was only backported to the
> 5.10 stable tree, and not to 5.4. Is there any specific reason or analysis
> regarding the 5.4 branch? We have encountered this issue in our production
> environments running kernel 5.4. After manually applying and deconflicting
> this patch, the problem was resolved.
> 
> Any comments or suggestions regarding this backport would be appreciated.

I don't have any objections against including this in 5.4-stable branch.
Probably it was not applied because of some patch conflict. Feel free to
send the backport to stable@vger.kernel.org, I believe Greg will gladly
pickup the patch.

								Honza

> 
> Thanks,
> Diangang
> 
> [1]: https://lore.kernel.org/all/2024100959-CVE-2024-47660-2d61@gregkh/
> 
> Amir Goldstein (1):
>   fsnotify: clear PARENT_WATCHED flags lazily
> 
>  fs/notify/fsnotify.c             | 31 +++++++++++++++++++++----------
>  fs/notify/fsnotify.h             |  2 +-
>  fs/notify/mark.c                 | 32 +++++++++++++++++++++++++++++---
>  include/linux/fsnotify_backend.h |  8 +++++---
>  4 files changed, 56 insertions(+), 17 deletions(-)
> 
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

