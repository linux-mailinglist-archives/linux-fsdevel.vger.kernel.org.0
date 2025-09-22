Return-Path: <linux-fsdevel+bounces-62406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F14B917B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 15:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BB24238C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0807231196B;
	Mon, 22 Sep 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FhENcX+2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Luy+HAii";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FhENcX+2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Luy+HAii"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F672311969
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548560; cv=none; b=Z98NwIg3GEzIhXZ5KfkZmK0MAEwR3FsfjokFodCMTZs2KjLc3N0j+NoIwUl5KY/tFd6v6xZAhnTyCTzbPeD1Zudf6RZ3qTc2MhABfw+tjl4araecRpTMFYASIetYkVw6lj8atc5XAV0CwTx9U75fZP6A1uHa22UCZvWNttwoINs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548560; c=relaxed/simple;
	bh=c3SRUfwFTBNd/WapL7/xYrcDf8T59qm5qrM8W2uiC7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUsPqtsVboOETEmAC9fNiBQ52EAQlx2tuJdw5WhIs1cyr3sIdLLUzRZnoHFJikued3SmqH7OS0hZnibR1wXQS2L8ZxjV9OyTHCNiguAmOV96tBxkPCvSJMu/jYlRoOED0JY+5i6edCPNUoy6CNI5PQK4oDZpCjLj+rn1SsaJ4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FhENcX+2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Luy+HAii; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FhENcX+2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Luy+HAii; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D492C1F79A;
	Mon, 22 Sep 2025 13:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758548556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8h3t+wZFgUAPv3YURbLslHRbAwha4QcURiDpV2SIRFs=;
	b=FhENcX+2dZJXhgadeOMsEVbw+zoFfRLc+7I/jMFg4B3xyxTZ2zFgzS409dK/wm83awWo1q
	3IINTErjI37mlbpd85bIUBRqptzjhP9ZNDLmoIWsZjvu6fCM776KLZ0BOu7gmu95SsB2hh
	XJZIDUP6/0FuJFgQm+KtDYCc+MraDeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758548556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8h3t+wZFgUAPv3YURbLslHRbAwha4QcURiDpV2SIRFs=;
	b=Luy+HAiib0h2KpXtP0yKUwKK4O3ao1UhLqyAZmT0iv2ILN8Mpj292otA8XKKwq9g5xCbgR
	FAkLE1oubJYzpJDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758548556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8h3t+wZFgUAPv3YURbLslHRbAwha4QcURiDpV2SIRFs=;
	b=FhENcX+2dZJXhgadeOMsEVbw+zoFfRLc+7I/jMFg4B3xyxTZ2zFgzS409dK/wm83awWo1q
	3IINTErjI37mlbpd85bIUBRqptzjhP9ZNDLmoIWsZjvu6fCM776KLZ0BOu7gmu95SsB2hh
	XJZIDUP6/0FuJFgQm+KtDYCc+MraDeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758548556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8h3t+wZFgUAPv3YURbLslHRbAwha4QcURiDpV2SIRFs=;
	b=Luy+HAiib0h2KpXtP0yKUwKK4O3ao1UhLqyAZmT0iv2ILN8Mpj292otA8XKKwq9g5xCbgR
	FAkLE1oubJYzpJDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C21E813A63;
	Mon, 22 Sep 2025 13:42:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y+NhL0xS0WigfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Sep 2025 13:42:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 84F4CA07C4; Mon, 22 Sep 2025 15:42:32 +0200 (CEST)
Date: Mon, 22 Sep 2025 15:42:32 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] ns: add ns_debug()
Message-ID: <fq4cc7z5ojnfeztco7o7e6ux6sggxiykvhrjoo5xlmycffwi6f@vjhrsneu3qct>
References: <20250922-work-namespace-ns_common-fixes-v1-0-3c26aeb30831@kernel.org>
 <20250922-work-namespace-ns_common-fixes-v1-3-3c26aeb30831@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922-work-namespace-ns_common-fixes-v1-3-3c26aeb30831@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz,cmpxchg.org,suse.com,linutronix.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 22-09-25 14:42:37, Christian Brauner wrote:
> Add ns_debug() that asserts that the correct operations are used for the
> namespace type.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  kernel/nscommon.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index 7aa2be6a0c32..3cef89ddef41 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -2,6 +2,55 @@
>  
>  #include <linux/ns_common.h>
>  #include <linux/proc_ns.h>
> +#include <linux/vfsdebug.h>
> +
> +#ifdef CONFIG_DEBUG_VFS
> +static void ns_debug(struct ns_common *ns, const struct proc_ns_operations *ops)
> +{
> +	switch (ns->ops->type) {
> +#ifdef CONFIG_CGROUPS
> +	case CLONE_NEWCGROUP:
> +		VFS_WARN_ON_ONCE(ops != &cgroupns_operations);
> +		break;
> +#endif
> +#ifdef CONFIG_IPC_NS
> +	case CLONE_NEWIPC:
> +		VFS_WARN_ON_ONCE(ops != &ipcns_operations);
> +		break;
> +#endif
> +	case CLONE_NEWNS:
> +		VFS_WARN_ON_ONCE(ops != &mntns_operations);
> +		break;
> +#ifdef CONFIG_NET_NS
> +	case CLONE_NEWNET:
> +		VFS_WARN_ON_ONCE(ops != &netns_operations);
> +		break;
> +#endif
> +#ifdef CONFIG_PID_NS
> +	case CLONE_NEWPID:
> +		VFS_WARN_ON_ONCE(ops != &pidns_operations);
> +		break;
> +#endif
> +#ifdef CONFIG_TIME_NS
> +	case CLONE_NEWTIME:
> +		VFS_WARN_ON_ONCE(ops != &timens_operations);
> +		break;
> +#endif
> +#ifdef CONFIG_USER_NS
> +	case CLONE_NEWUSER:
> +		VFS_WARN_ON_ONCE(ops != &userns_operations);
> +		break;
> +#endif
> +#ifdef CONFIG_UTS_NS
> +	case CLONE_NEWUTS:
> +		VFS_WARN_ON_ONCE(ops != &utsns_operations);
> +		break;
> +#endif
> +	default:
> +		VFS_WARN_ON_ONCE(true);
> +	}
> +}
> +#endif
>  
>  int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops, int inum)
>  {
> @@ -12,6 +61,10 @@ int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
>  	RB_CLEAR_NODE(&ns->ns_tree_node);
>  	INIT_LIST_HEAD(&ns->ns_list_node);
>  
> +#ifdef CONFIG_DEBUG_VFS
> +	ns_debug(ns, ops);
> +#endif
> +
>  	if (inum) {
>  		ns->inum = inum;
>  		return 0;
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

