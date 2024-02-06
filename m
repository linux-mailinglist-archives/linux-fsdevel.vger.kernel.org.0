Return-Path: <linux-fsdevel+bounces-10439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFCD84B275
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 11:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3DD1C232FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 10:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E20E12E1E9;
	Tue,  6 Feb 2024 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gwLvPDIF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o3eolBuK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gwLvPDIF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o3eolBuK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A45212E1D1
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215190; cv=none; b=ZPz2V+xXtBboT+MwngZ+N0Vwm94aJ5HWj+YnOo5s4hl1/lt6w4kq38ecII1JfCs26Dl5BRBlLXPmrG2CaXp064C1ScrN/WUF6t0tRJO26hRwqDjiakj6y5mc8AWV5WxKSO2WgWYP8g8VL+0Quttcj1JlA5+3YuyVcC3MTmMAwPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215190; c=relaxed/simple;
	bh=llzqAYcI6dIQCkjxO/hj9r5AVyxcGEM3OUvwTxHb3oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAS99rKzaaiKB9tmnH5OeGrlRt/fDUmPS2NVKBwTQ0uCE2x8milCdsCrAu7UDTeHgqnRw9GiH90QIiYhrkRClSWyjgKf5nId1+KTAUCJZiECg69RefFd53cViT6qC7Try/aNfzsuYJOaW/TcDMqdpSnfCVZKp2+zk8XlPhsYNIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gwLvPDIF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o3eolBuK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gwLvPDIF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o3eolBuK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 69DA31FB71;
	Tue,  6 Feb 2024 10:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707215186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=etH+e9Q0Nc6KvT3+p2GmIggYln3XoSK1R34oU8EtHyg=;
	b=gwLvPDIFOV/NM3S6R539Zz6BxBhZexzSinFUrg/nXqVkg7gpJ6IXo9M15AxsIHBtuJz6GC
	4z20g/cZwuQKnTKvzN3/ddkzN8pZBt4t5tIuXrOpowjeM45EMnTmlS+Ctb5yty9eulwF44
	TLc5G4mkWFDc51GGOazsiFXaN3ffVHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707215186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=etH+e9Q0Nc6KvT3+p2GmIggYln3XoSK1R34oU8EtHyg=;
	b=o3eolBuK5/qLA9Iz8rk35t6FJHf2ywGufNW59m7TkJ8mhNJJcvcLzoAFC5eGiR6WbfPq2I
	qxJb+r3pcGtfYUAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707215186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=etH+e9Q0Nc6KvT3+p2GmIggYln3XoSK1R34oU8EtHyg=;
	b=gwLvPDIFOV/NM3S6R539Zz6BxBhZexzSinFUrg/nXqVkg7gpJ6IXo9M15AxsIHBtuJz6GC
	4z20g/cZwuQKnTKvzN3/ddkzN8pZBt4t5tIuXrOpowjeM45EMnTmlS+Ctb5yty9eulwF44
	TLc5G4mkWFDc51GGOazsiFXaN3ffVHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707215186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=etH+e9Q0Nc6KvT3+p2GmIggYln3XoSK1R34oU8EtHyg=;
	b=o3eolBuK5/qLA9Iz8rk35t6FJHf2ywGufNW59m7TkJ8mhNJJcvcLzoAFC5eGiR6WbfPq2I
	qxJb+r3pcGtfYUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5414F139D8;
	Tue,  6 Feb 2024 10:26:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fkCDFFIJwmXpfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Feb 2024 10:26:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3780CA0809; Tue,  6 Feb 2024 11:26:22 +0100 (CET)
Date: Tue, 6 Feb 2024 11:26:22 +0100
From: Jan Kara <jack@suse.cz>
To: Huang Xiaojia <huangxiaojia2@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	yuehaibing@huawei.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH-next] epoll: Remove ep_scan_ready_list() in comments
Message-ID: <20240206102622.7trt75wozopc3lzy@quack3>
References: <20240206014353.4191262-1-huangxiaojia2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206014353.4191262-1-huangxiaojia2@huawei.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.33 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.73)[83.75%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.33

On Tue 06-02-24 09:43:53, Huang Xiaojia wrote:
> Since commit 443f1a042233 ("lift the calls of ep_send_events_proc()
> into the callers"), ep_scan_ready_list() has been removed.
> But there are still several in comments. All of them should
> be replaced with other caller functions.
> 
> Signed-off-by: Huang Xiaojia <huangxiaojia2@huawei.com>

Not really eventpoll expert but from a cursory look this looks fine to me.
Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

One nit below:


> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -206,7 +206,7 @@ struct eventpoll {
>  	 */
>  	struct epitem *ovflist;
>  
> -	/* wakeup_source used when ep_scan_ready_list is running */
> +	/* wakeup_source used when ep_send_events or __ep_eventpoll_poll is running */

Please wrap this comment like:

	/*
	 * wakeup_source - used when ep_send_events or __ep_eventpoll_poll is
	 * running
	 */

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

