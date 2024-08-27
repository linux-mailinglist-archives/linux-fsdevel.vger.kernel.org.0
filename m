Return-Path: <linux-fsdevel+bounces-27405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2839613E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258201C23426
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21531CB142;
	Tue, 27 Aug 2024 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xq2LezdK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OhXgiVrx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xq2LezdK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OhXgiVrx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48971C7B6F;
	Tue, 27 Aug 2024 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775719; cv=none; b=h/y9OlVz7+IuLaQ72MMUxVfeo1GSOH3ZQhJlAv9BoyEJfzMc2DvuOKc2SDpfr0tDEndNfrST9UoBo2wXxB7wmXbSUBIo2Nq9oJmt4DIRpP5fVE5d4dvj0eQSZqKh/adUVlGfn+eBNfG2yAtdYEQSPCNX/6Yhkn5CQHNYMCtyMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775719; c=relaxed/simple;
	bh=QWoC0mZ8s76q1VAp4E+wOSKpSwB3GcMGWCf6cuGzHwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRbV5tMd7l3DPnbX93UUXEwYh1eCK1ZTzhtAiFEkJKSRxAalTfHb3Z/o+g4M6f4P930COuuICpvDNpif7VhibvHxF7VWUUOE/xzaBa7kEzt1yRZWCdf1jvVUsjUm7jM3Z5dpoJOLQoA4vAWOsaoV+Bv4wmAL021EOt9H4ngBgDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xq2LezdK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OhXgiVrx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xq2LezdK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OhXgiVrx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02F4E219CC;
	Tue, 27 Aug 2024 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724775715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlcfyjGLWDtkvfPU7gcTYpZxDQ8jofQsYc9kS1WYV/g=;
	b=xq2LezdKqlQglTeP0M5hOZLLgxhwxrTE2WRjmt5tyDq0rnjyeXvSSAlRYkw8YGWlN5C2KE
	oqdQdvJHFFZASbEJ1VcOfYRewM6ci2Spwq98RS6KhWDy+jZdL8vccVAOy5AMUvWaF4mXii
	yZUNNrrDsxz9P7qhf0mvMi08am8V4EM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724775715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlcfyjGLWDtkvfPU7gcTYpZxDQ8jofQsYc9kS1WYV/g=;
	b=OhXgiVrx0A0Vc5umn6eftjRtsT90GisUxozjGbU8Fuc4MSD5eS8vTbfd8lGBr/I0I3g35/
	s3Y0nSDrt7r+ZZCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xq2LezdK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OhXgiVrx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724775715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlcfyjGLWDtkvfPU7gcTYpZxDQ8jofQsYc9kS1WYV/g=;
	b=xq2LezdKqlQglTeP0M5hOZLLgxhwxrTE2WRjmt5tyDq0rnjyeXvSSAlRYkw8YGWlN5C2KE
	oqdQdvJHFFZASbEJ1VcOfYRewM6ci2Spwq98RS6KhWDy+jZdL8vccVAOy5AMUvWaF4mXii
	yZUNNrrDsxz9P7qhf0mvMi08am8V4EM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724775715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlcfyjGLWDtkvfPU7gcTYpZxDQ8jofQsYc9kS1WYV/g=;
	b=OhXgiVrx0A0Vc5umn6eftjRtsT90GisUxozjGbU8Fuc4MSD5eS8vTbfd8lGBr/I0I3g35/
	s3Y0nSDrt7r+ZZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA4A013A44;
	Tue, 27 Aug 2024 16:21:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c+UrOSL9zWbaNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 27 Aug 2024 16:21:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 85B0DA0968; Tue, 27 Aug 2024 18:21:50 +0200 (CEST)
Date: Tue, 27 Aug 2024 18:21:50 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk,
	mhiramat@kernel.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH] writeback: Refine the show_inode_state() macro definition
Message-ID: <20240827162150.rzgnguesq44yqd57@quack3>
References: <20240820095229.380539-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240820095229.380539-1-sunjunchao2870@gmail.com>
X-Rspamd-Queue-Id: 02F4E219CC
X-Spam-Level: 
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
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 20-08-24 17:52:29, Julian Sun wrote:
> Currently, the show_inode_state() macro only prints
> part of the state of inode->i_state. Let’s improve it
> to display more of its state.
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  include/trace/events/writeback.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Yeah, it could be useful at times. Some comments below.

> @@ -20,7 +20,16 @@
>  		{I_CLEAR,		"I_CLEAR"},		\
>  		{I_SYNC,		"I_SYNC"},		\
>  		{I_DIRTY_TIME,		"I_DIRTY_TIME"},	\
> -		{I_REFERENCED,		"I_REFERENCED"}		\
> +		{I_REFERENCED,		"I_REFERENCED"},	\
> +		{I_DIO_WAKEUP,	"I_DIO_WAKEUP"},	\

I_DIO_WAKEUP is never set and is being removed, please don't put it here.

> +		{I_LINKABLE,	"I_LINKABLE"},	\
> +		{I_DIRTY_TIME,	"I_DIRTY_TIME"},	\

Um, I_DIRTY_TIME is already included.

> +		{I_WB_SWITCH,	"I_WB_SWITCH"},	\
> +		{I_OVL_INUSE,	"I_OVL_INUSE"},	\
> +		{I_CREATING,	"I_CREATING"},	\
> +		{I_DONTCACHE,	"I_DONTCACHE"},	\
> +		{I_SYNC_QUEUED,	"I_SYNC_QUEUED"},	\
> +		{I_PINNING_NETFS_WB, "I_PINNING_NETFS_WB"} \
>  	)

Otherwise the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

