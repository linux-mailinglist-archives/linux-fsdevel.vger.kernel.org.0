Return-Path: <linux-fsdevel+bounces-25298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3764494A820
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB50281070
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BD01E674E;
	Wed,  7 Aug 2024 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P2RZQvx9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F5T0QIp2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P2RZQvx9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F5T0QIp2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4FE1E3CBE;
	Wed,  7 Aug 2024 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035398; cv=none; b=AAvR37xwf4j+APbMbBp9wYAoiMZyXiVDQRU9jkS7zcR+jTK9gi9qYUpCIwydw7HW0dCleLE5vwwhn5hs3dikAGIAUUzXNndcYXCqdS48uT7qneoauhOGxyeTY5TyzJwsci12H7OVPcTCRAsZ8LmyNsTECVb4oXyTbH3FgvLEseU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035398; c=relaxed/simple;
	bh=jAP3UPV8S7dAg52wzDeIKI73r8ibmTUCvbRmjAy8WdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiyHaYRTEvs5NsFXZwb09JIsjoW3sClzt9SYv3gKxG7h+iUVWOrlDbNrYx+fGD8cgc2P973hOmLJsEzCrGNNGX7O0OafscUQ/OgFsIrXnzVG3v0S+kEXRSu+zcvZezbqOvINUvApUeNuSvFIIWguqe0DR42USDwYh3LLYJdBYlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P2RZQvx9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F5T0QIp2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P2RZQvx9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F5T0QIp2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1532B1F396;
	Wed,  7 Aug 2024 12:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723035394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ef6g7R8oFl691anvsvAI4zaSbxmFbfpd2rm1KW+VcIg=;
	b=P2RZQvx9cv0poYr2J5oIp+sNFASV09NUbDlv3rsVT987H1s8Dui6fVYAdgI/rbwfDegpzi
	2fU6W9iRgUzXqznyfAIxtwX7mqG5O70wRKAer5+++Ysz+q60avrywH0OMuMrA6OqjLqgpU
	IMU5neRLwWRJzm+59HJLycBNZ4yZTRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723035394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ef6g7R8oFl691anvsvAI4zaSbxmFbfpd2rm1KW+VcIg=;
	b=F5T0QIp2RkOQJd63D7qqB+fi5ZcpQ2pMyJ+YpAsFoQQGIgCV3QmvOdLrhm/RVwMzqddUpN
	bmBNwW1Rq0EMHZAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=P2RZQvx9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=F5T0QIp2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723035394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ef6g7R8oFl691anvsvAI4zaSbxmFbfpd2rm1KW+VcIg=;
	b=P2RZQvx9cv0poYr2J5oIp+sNFASV09NUbDlv3rsVT987H1s8Dui6fVYAdgI/rbwfDegpzi
	2fU6W9iRgUzXqznyfAIxtwX7mqG5O70wRKAer5+++Ysz+q60avrywH0OMuMrA6OqjLqgpU
	IMU5neRLwWRJzm+59HJLycBNZ4yZTRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723035394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ef6g7R8oFl691anvsvAI4zaSbxmFbfpd2rm1KW+VcIg=;
	b=F5T0QIp2RkOQJd63D7qqB+fi5ZcpQ2pMyJ+YpAsFoQQGIgCV3QmvOdLrhm/RVwMzqddUpN
	bmBNwW1Rq0EMHZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A85913297;
	Wed,  7 Aug 2024 12:56:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7kiQAgJvs2a1SgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 12:56:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BBFA2A0762; Wed,  7 Aug 2024 14:56:33 +0200 (CEST)
Date: Wed, 7 Aug 2024 14:56:33 +0200
From: Jan Kara <jack@suse.cz>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, sdf@google.com, edumazet@google.com,
	kuba@kernel.org, mkarsten@uwaterloo.ca,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH net-next] eventpoll: Don't re-zero eventpoll fields
Message-ID: <20240807125633.dlwr6rx6yzl4ippv@quack3>
References: <20240807105231.179158-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807105231.179158-1-jdamato@fastly.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 1532B1F396

On Wed 07-08-24 10:52:31, Joe Damato wrote:
> Remove redundant and unnecessary code.
> 
> ep_alloc uses kzalloc to create struct eventpoll, so there is no need to
> set fields to defaults of 0. This was accidentally introduced in commit
> 85455c795c07 ("eventpoll: support busy poll per epoll instance") and
> expanded on in follow-up commits.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Martin Karsten <mkarsten@uwaterloo.ca>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/eventpoll.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index f53ca4f7fced..6c0a1e9715ea 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -2200,11 +2200,6 @@ static int do_epoll_create(int flags)
>  		error = PTR_ERR(file);
>  		goto out_free_fd;
>  	}
> -#ifdef CONFIG_NET_RX_BUSY_POLL
> -	ep->busy_poll_usecs = 0;
> -	ep->busy_poll_budget = 0;
> -	ep->prefer_busy_poll = false;
> -#endif
>  	ep->file = file;
>  	fd_install(fd, file);
>  	return fd;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

