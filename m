Return-Path: <linux-fsdevel+bounces-62571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0336BB99A2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C0419C5182
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E562FE567;
	Wed, 24 Sep 2025 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G3x7KIEw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="//4PyFpS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G3x7KIEw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="//4PyFpS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255542E62C6
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714417; cv=none; b=TYA4dNPGUTcPk9Mpltqd4JIvuCXSIm/eDdSP++VSv+0Ggy57+NAS51TY4mQT024cNXzzpsisYUfx/j/L3XMzXzNjGYucCxVTvG6wFJ/8elVY09m0U2jLLDymyD5zpFOvpLxDgPuDro7NCfxMN5Z0+V6PwNQw3tJzMvcHueUj4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714417; c=relaxed/simple;
	bh=EEZTGeWk9yETXV/uvz0IPqsCHoskbEGTZXd7NaAQGsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbwEfWFlBf+ETHGOCMVk/ZohZwA37e8EZnPSKnWuXmowNIFG+HZLMAkBdGiLXF5RMj1Xfhgy83FDS1V6+Pe2yJW92jwM0K1VH/HWDjSay9e/jnRa6MCC53B8T3/LvoDqdGuwJ2aJghHJLRua6Mfp/Jxua5bvx9UVkVSYXEYKuVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G3x7KIEw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=//4PyFpS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G3x7KIEw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=//4PyFpS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62576340A0;
	Wed, 24 Sep 2025 11:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758714414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0jYWdJo3CZSYIJJiMuZ0EqgjFcghBaX69ELG4cO1E8s=;
	b=G3x7KIEwywBvqzhb77znSUa9z7d1m+UHzZLcLVWmDFZHNf3M58auvcUbzNxhUT7+vZxSlb
	1EE5FIjO7/Q2Me5Q4b7OHPfaLZB3N4MjUoZxzlWlGmUWZwJN1mBamu1/6cnQbyfUHbhiuj
	n8vFaAj4edJ7dnbj2bYjzQmntc6pjn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758714414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0jYWdJo3CZSYIJJiMuZ0EqgjFcghBaX69ELG4cO1E8s=;
	b=//4PyFpSGYhbEC7We1r3KCsdw6NAoEJjYPeWaKngdJMM7Qu/s3nzXqjfVb0LW/RA5CbfMD
	wbbvfZRtF18H9nCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G3x7KIEw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="//4PyFpS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758714414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0jYWdJo3CZSYIJJiMuZ0EqgjFcghBaX69ELG4cO1E8s=;
	b=G3x7KIEwywBvqzhb77znSUa9z7d1m+UHzZLcLVWmDFZHNf3M58auvcUbzNxhUT7+vZxSlb
	1EE5FIjO7/Q2Me5Q4b7OHPfaLZB3N4MjUoZxzlWlGmUWZwJN1mBamu1/6cnQbyfUHbhiuj
	n8vFaAj4edJ7dnbj2bYjzQmntc6pjn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758714414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0jYWdJo3CZSYIJJiMuZ0EqgjFcghBaX69ELG4cO1E8s=;
	b=//4PyFpSGYhbEC7We1r3KCsdw6NAoEJjYPeWaKngdJMM7Qu/s3nzXqjfVb0LW/RA5CbfMD
	wbbvfZRtF18H9nCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A5C613ADA;
	Wed, 24 Sep 2025 11:46:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DasbEi7a02gQRAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Sep 2025 11:46:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EDFD8A0A9A; Wed, 24 Sep 2025 13:46:53 +0200 (CEST)
Date: Wed, 24 Sep 2025 13:46:53 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] nstree: make struct ns_tree private
Message-ID: <3wstxh4522vxbysmtisvvocuuj6wvldy57bskwpeulaeolvk4y@oqri2hz4gpfy>
References: <20250924-work-namespaces-fixes-v1-0-8fb682c8678e@kernel.org>
 <20250924-work-namespaces-fixes-v1-1-8fb682c8678e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-work-namespaces-fixes-v1-1-8fb682c8678e@kernel.org>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz,cmpxchg.org,suse.com,linutronix.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 62576340A0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Wed 24-09-25 13:33:58, Christian Brauner wrote:
> Don't expose it directly. There's no need to do that.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/nstree.h | 13 -------------
>  kernel/nstree.c        | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/nstree.h b/include/linux/nstree.h
> index 29ad6402260c..8b8636690473 100644
> --- a/include/linux/nstree.h
> +++ b/include/linux/nstree.h
> @@ -9,19 +9,6 @@
>  #include <linux/rculist.h>
>  #include <linux/cookie.h>
>  
> -/**
> - * struct ns_tree - Namespace tree
> - * @ns_tree: Rbtree of namespaces of a particular type
> - * @ns_list: Sequentially walkable list of all namespaces of this type
> - * @ns_tree_lock: Seqlock to protect the tree and list
> - */
> -struct ns_tree {
> -	struct rb_root ns_tree;
> -	struct list_head ns_list;
> -	seqlock_t ns_tree_lock;
> -	int type;
> -};
> -
>  extern struct ns_tree cgroup_ns_tree;
>  extern struct ns_tree ipc_ns_tree;
>  extern struct ns_tree mnt_ns_tree;
> diff --git a/kernel/nstree.c b/kernel/nstree.c
> index bbe8bedc924c..113d681857f1 100644
> --- a/kernel/nstree.c
> +++ b/kernel/nstree.c
> @@ -4,6 +4,19 @@
>  #include <linux/proc_ns.h>
>  #include <linux/vfsdebug.h>
>  
> +/**
> + * struct ns_tree - Namespace tree
> + * @ns_tree: Rbtree of namespaces of a particular type
> + * @ns_list: Sequentially walkable list of all namespaces of this type
> + * @ns_tree_lock: Seqlock to protect the tree and list
> + */
> +struct ns_tree {
> +       struct rb_root ns_tree;
> +       struct list_head ns_list;
> +       seqlock_t ns_tree_lock;
> +       int type;
> +};
> +
>  struct ns_tree mnt_ns_tree = {
>  	.ns_tree = RB_ROOT,
>  	.ns_list = LIST_HEAD_INIT(mnt_ns_tree.ns_list),
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

