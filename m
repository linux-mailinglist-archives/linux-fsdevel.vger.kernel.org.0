Return-Path: <linux-fsdevel+bounces-13778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7931873DDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 18:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3D028292A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 17:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A1613C9C9;
	Wed,  6 Mar 2024 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vUvbyqbU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+d78mB/6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vUvbyqbU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+d78mB/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8931361C1
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747966; cv=none; b=mg17RfWW2EzPfG1G5Vc6cuEHIudap8aY8EZJq8p0szO7cV/uhwt9C078FuhYkTdoBe0DWP9CP2jQcBY9as+H4ussNtN7NkUxqkKLaeutVavc0ZtJhrCjXG2w8PC/hu2YShm2GGWHbKudHxW2kbTVpoWu20YgNrF0KUT/CYkGJx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747966; c=relaxed/simple;
	bh=vipfWaQOVzuxcQlzBInz5qhLII8YdQje+MKkkSn50dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZp2J4HnVkduvDZeb6trNYL4opJRzunvzkGuOozuaCAQ6Cia2N87wDbs/9utnp7gIIIK74rIo3W9Pfi9NUiOAM3TGtSMNlI7BV2qh9SbcuxhlDVupamAuaUWo1Z2YY8jTTVWeoPX/CVGCI+vipfzeuNHrFjOqdn5u1qSYr6tAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vUvbyqbU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+d78mB/6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vUvbyqbU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+d78mB/6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 191DA4709;
	Wed,  6 Mar 2024 17:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709747963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j2/7ldqJoaU9rDe1ODoqxwgchjQ0U8xlBrPCs4LjQM8=;
	b=vUvbyqbUNM73Hqm+mfJVcxYuDrhQLXt0nSYSwuCCvzw7P/loAjb0xdGeJBQa/bbRinsyhB
	/SPmQo5/hohedqcukO6AXMcP/khbxhQhi/+A8pmwOnqCPUs66tXyaDceW0IZaaQBSqjMwk
	JDxqRXKFxvsUZ7UJJQX5AtKCVuYGqYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709747963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j2/7ldqJoaU9rDe1ODoqxwgchjQ0U8xlBrPCs4LjQM8=;
	b=+d78mB/66P2NdP6sKqsN4iYh0B/VdCF0Rfe3GU7vGSCNz0yrzc8B9j9LmW5RuWLXGhFQwv
	nFOaLIeHDKVg26CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709747963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j2/7ldqJoaU9rDe1ODoqxwgchjQ0U8xlBrPCs4LjQM8=;
	b=vUvbyqbUNM73Hqm+mfJVcxYuDrhQLXt0nSYSwuCCvzw7P/loAjb0xdGeJBQa/bbRinsyhB
	/SPmQo5/hohedqcukO6AXMcP/khbxhQhi/+A8pmwOnqCPUs66tXyaDceW0IZaaQBSqjMwk
	JDxqRXKFxvsUZ7UJJQX5AtKCVuYGqYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709747963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j2/7ldqJoaU9rDe1ODoqxwgchjQ0U8xlBrPCs4LjQM8=;
	b=+d78mB/66P2NdP6sKqsN4iYh0B/VdCF0Rfe3GU7vGSCNz0yrzc8B9j9LmW5RuWLXGhFQwv
	nFOaLIeHDKVg26CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F3EF13A79;
	Wed,  6 Mar 2024 17:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +g+0A/uu6GXVHQAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 06 Mar 2024 17:59:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A7EBEA0803; Wed,  6 Mar 2024 18:59:18 +0100 (CET)
Date: Wed, 6 Mar 2024 18:59:18 +0100
From: Jan Kara <jack@suse.cz>
To: Winston Wen <wentao@uniontech.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	Vivek Trivedi <t.vivek@samsung.com>,
	Orion Poplawski <orion@nwra.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: allow freeze when waiting response for
 permission events
Message-ID: <20240306175918.bvipf63nfk2d3ocw@quack3>
References: <BD33543C483B89AB+20240305061804.1186796-1-wentao@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD33543C483B89AB+20240305061804.1186796-1-wentao@uniontech.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vUvbyqbU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="+d78mB/6"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,gmail.com,samsung.com,nwra.com,infradead.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[29.75%]
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: 191DA4709
X-Spam-Flag: NO

On Tue 05-03-24 14:18:04, Winston Wen wrote:
> This is a long-standing issue that uninterruptible sleep in fanotify
> could make system hibernation fail if the usperspace server gets frozen
> before the process waiting for the response (as reported e.g. [1][2]).
> 
> A few years ago, there was an attempt to switch to interruptible sleep
> while waiting [3], but that would lead to EINTR returns from open(2)
> and break userspace [4], so it's been changed to only killable [5].
> 
> And the core freezer logic had been rewritten [6][7] in v6.1, allowing
> freezing in uninterrupted sleep, so we can solve this problem now.
> 
> [1] https://lore.kernel.org/lkml/1518774280-38090-1-git-send-email-t.vivek@samsung.com/
> [2] https://lore.kernel.org/lkml/c1bb16b7-9eee-9cea-2c96-a512d8b3b9c7@nwra.com/
> [3] https://lore.kernel.org/linux-fsdevel/20190213145443.26836-1-jack@suse.cz/
> [4] https://lore.kernel.org/linux-fsdevel/d0031e3a-f050-0832-fa59-928a80ffd44b@nwra.com/
> [5] https://lore.kernel.org/linux-fsdevel/20190221105558.GA20921@quack2.suse.cz/
> [6] https://lore.kernel.org/lkml/20220822114649.055452969@infradead.org/
> [7] https://lore.kernel.org/lkml/20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com/
> 
> Signed-off-by: Winston Wen <wentao@uniontech.com>

Thanks and I'm glad this has finally a workable solution (keeping fingers
crossed ;)). I've added the patch to my tree.

								Honza

> ---
>  fs/notify/fanotify/fanotify.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 1e4def21811e..285beaf5bc09 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -228,8 +228,10 @@ static int fanotify_get_response(struct fsnotify_group *group,
>  
>  	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
>  
> -	ret = wait_event_killable(group->fanotify_data.access_waitq,
> -				  event->state == FAN_EVENT_ANSWERED);
> +	ret = wait_event_state(group->fanotify_data.access_waitq,
> +				  event->state == FAN_EVENT_ANSWERED,
> +				  TASK_KILLABLE|TASK_FREEZABLE);
> +
>  	/* Signal pending? */
>  	if (ret < 0) {
>  		spin_lock(&group->notification_lock);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

