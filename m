Return-Path: <linux-fsdevel+bounces-30060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C669857CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 13:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD20B21E3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D7281AB4;
	Wed, 25 Sep 2024 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1lp+Pl2v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="of+h3bOa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1lp+Pl2v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="of+h3bOa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0963C36130
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262920; cv=none; b=UXVlCYtNcjhiyqPZmcm4cPKGyqsha8pZcTWYO1VgXN32/n9YsqeIPzWAfWOYTyG5m4j+3TTp9NahA+YC2BctGf+ImZ5H/ZQXmmacHgmsJy3npPMce9p574zgAVdq8Tg4JUZDPCW4ln3KCpDZqXM98BcA2yGKf+C+U7vjC9j0X6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262920; c=relaxed/simple;
	bh=QIeYbGxYwfu/0Oh00qmP8mhtMB0lab70SvD5adpHDZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxyPBeYZXxqWCPOPqjfE+9qrB0A11knhzSG02M6norSCMoC1syvTRikDeCGOXfZ4p90nueE4m9ajhaSGBFZHzq0mjWVAH3xuGh0sBEZpM46bKha28vdgS6yXbpqiw2vrv/6rgP3ZXQKJhdbDSNgGHr2tOWaIaKyzHA8skLjGxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1lp+Pl2v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=of+h3bOa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1lp+Pl2v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=of+h3bOa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0AD6921A99;
	Wed, 25 Sep 2024 11:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727262917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkQbdQhWHYMyqmvsbpPyrCutprZzgjA66QOrda6wrM8=;
	b=1lp+Pl2vDfJbnOWo8MEAzLYSskWAbp7gx57uWhOYrL9llVXd9ZE+UutC6BZb3LSyi5EtST
	65DnDiH3COQOmxpTYgKFfnIYppEdguHxS7jbsJmq0JIejWnh7TLx0oQJqMtnZVFcTcxE+D
	HJ8Ir3qlh0Mf6A2XlChj5/GnF0N6tvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727262917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkQbdQhWHYMyqmvsbpPyrCutprZzgjA66QOrda6wrM8=;
	b=of+h3bOazI8WLIYUuZlEfrxmOhDXoxssPgnMNE4hj+W50LhAFfbt6/QKtc/sBpn1Vq5Gnz
	VMPeG8DeABJYHcBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1lp+Pl2v;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=of+h3bOa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727262917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkQbdQhWHYMyqmvsbpPyrCutprZzgjA66QOrda6wrM8=;
	b=1lp+Pl2vDfJbnOWo8MEAzLYSskWAbp7gx57uWhOYrL9llVXd9ZE+UutC6BZb3LSyi5EtST
	65DnDiH3COQOmxpTYgKFfnIYppEdguHxS7jbsJmq0JIejWnh7TLx0oQJqMtnZVFcTcxE+D
	HJ8Ir3qlh0Mf6A2XlChj5/GnF0N6tvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727262917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkQbdQhWHYMyqmvsbpPyrCutprZzgjA66QOrda6wrM8=;
	b=of+h3bOazI8WLIYUuZlEfrxmOhDXoxssPgnMNE4hj+W50LhAFfbt6/QKtc/sBpn1Vq5Gnz
	VMPeG8DeABJYHcBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F031113793;
	Wed, 25 Sep 2024 11:15:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GCdPOsTw82bcNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Sep 2024 11:15:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 975D8A089B; Wed, 25 Sep 2024 13:15:16 +0200 (CEST)
Date: Wed, 25 Sep 2024 13:15:16 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
	syzbot+3b6b32dc50537a49bb4a@syzkaller.appspotmail.com
Subject: Re: [PATCH] epoll: annotate racy check
Message-ID: <20240925111516.rb7x7btig74y7nj3@quack3>
References: <20240925-fungieren-anbauen-79b334b00542@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925-fungieren-anbauen-79b334b00542@brauner>
X-Rspamd-Queue-Id: 0AD6921A99
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[3b6b32dc50537a49bb4a];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 25-09-24 11:05:16, Christian Brauner wrote:
> Epoll relies on a racy fastpath check during __fput() in
> eventpoll_release() to avoid the hit of pointlessly acquiring a
> semaphore. Annotate that race by using WRITE_ONCE() and READ_ONCE().
> 
> Link: https://lore.kernel.org/r/66edfb3c.050a0220.3195df.001a.GAE@google.com
> Reported-by: syzbot+3b6b32dc50537a49bb4a@syzkaller.appspotmail.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/eventpoll.c            | 3 ++-
>  include/linux/eventpoll.h | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index f53ca4f7fced..fa766695f886 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -823,7 +823,8 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
>  	to_free = NULL;
>  	head = file->f_ep;
>  	if (head->first == &epi->fllink && !epi->fllink.next) {
> -		file->f_ep = NULL;
> +		/* See eventpoll_release() for details. */
> +		WRITE_ONCE(file->f_ep, NULL);

There's one more write to file->f_ep in attach_epitem() which needs
WRITE_ONCE() as well to match the READ_ONCE() in other places. Otherwise
feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


>  		if (!is_file_epoll(file)) {
>  			struct epitems_head *v;
>  			v = container_of(head, struct epitems_head, epitems);
> diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
> index 3337745d81bd..0c0d00fcd131 100644
> --- a/include/linux/eventpoll.h
> +++ b/include/linux/eventpoll.h
> @@ -42,7 +42,7 @@ static inline void eventpoll_release(struct file *file)
>  	 * because the file in on the way to be removed and nobody ( but
>  	 * eventpoll ) has still a reference to this file.
>  	 */
> -	if (likely(!file->f_ep))
> +	if (likely(!READ_ONCE(file->f_ep)))
>  		return;
>  
>  	/*
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

