Return-Path: <linux-fsdevel+bounces-61968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C49B8112F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 18:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F19167B4FD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F0F2FB998;
	Wed, 17 Sep 2025 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mBK7gO1t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RGbVzhw7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mBK7gO1t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RGbVzhw7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2302773E9
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127524; cv=none; b=uo9/t65q6AZcf4K4sdoLhcoeUQ6WD62HUTm4OMEsfJ6lfngtJKmzR8go/6qfavzGiX3Vtcv0D6OkaFZ0hmS+m2uVPHTo0nbp6x2oxWeRvRKW0iCn80qwYWAsDRA3Wkc0HGc4927Bma1Qml+ZnVu7fFz8EGSp8RhgU6F3wtrbbrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127524; c=relaxed/simple;
	bh=uYUc+SSJCWLgbh/+WRSu9C/gqTvfR7PLujHxWfgfBww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYbC+EhC/x8hNMBz+c24y5T4KtrPSu5mEHXxp/SWEoIVk6Kz0KAc1VcBWlfjKD57XwS2DQRiaBO+g/ilVym3DCHP5rsoFlLOU1raGXQKwItqCr3uRnWTGbf/W1NE88/FzXUly+rROLDB2D+YzeblTXS2/6WpBnULgi48nrYOiVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mBK7gO1t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RGbVzhw7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mBK7gO1t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RGbVzhw7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 868B920CCF;
	Wed, 17 Sep 2025 16:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758127520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Bp8Go5rdsl2s4/DveaRnepGB9XRFDOIIjd/3pjEQhk=;
	b=mBK7gO1tSk2oJYQTm0Bz/a3POPx8osq5QUAxF6aeOI5JmP2yo8A+1dIF9xosG+5ujgG7la
	LwQoM7nt6cPOInJPg5iC7nGO1C/tFbm0O9vXUTpW9vfjRAt+LJLV9WwPW4xLQUPWs2BJM1
	xV2E8e/eUW/MI1RYLTzgA5f3UB866Pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758127520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Bp8Go5rdsl2s4/DveaRnepGB9XRFDOIIjd/3pjEQhk=;
	b=RGbVzhw7oZQmfXmQU4x5KrXIFR+1/1xgEdCemVIq0XGEVtkccO6RAaEmPehEidU2ZzLpAc
	NmQv4dYu/wkmvJBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758127520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Bp8Go5rdsl2s4/DveaRnepGB9XRFDOIIjd/3pjEQhk=;
	b=mBK7gO1tSk2oJYQTm0Bz/a3POPx8osq5QUAxF6aeOI5JmP2yo8A+1dIF9xosG+5ujgG7la
	LwQoM7nt6cPOInJPg5iC7nGO1C/tFbm0O9vXUTpW9vfjRAt+LJLV9WwPW4xLQUPWs2BJM1
	xV2E8e/eUW/MI1RYLTzgA5f3UB866Pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758127520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Bp8Go5rdsl2s4/DveaRnepGB9XRFDOIIjd/3pjEQhk=;
	b=RGbVzhw7oZQmfXmQU4x5KrXIFR+1/1xgEdCemVIq0XGEVtkccO6RAaEmPehEidU2ZzLpAc
	NmQv4dYu/wkmvJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 729C31368D;
	Wed, 17 Sep 2025 16:45:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bx5jG6Dlymj/NgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Sep 2025 16:45:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F3BCEA083B; Wed, 17 Sep 2025 18:45:11 +0200 (CEST)
Date: Wed, 17 Sep 2025 18:45:11 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jakub Kicinski <kuba@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 6/9] mnt: simplify ns_common_init() handling
Message-ID: <syskz2nr23sqc27swfxwbvlbnnf7tgglrbn52vjoxd2bn3ryyv@id7hurupxcuy>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-6-1b3bda8ef8f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-work-namespace-ns_common-v1-6-1b3bda8ef8f2@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz,cmpxchg.org,suse.com,linutronix.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Wed 17-09-25 12:28:05, Christian Brauner wrote:
> Assign the reserved MNT_NS_ANON_INO sentinel to anonymous mount
> namespaces and cleanup the initial mount ns allocation. This is just a
> preparatory patch and the ns->inum check in ns_common_init() will be
> dropped in the next patch.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

...
> ---
>  fs/namespace.c    | 7 ++++---
>  kernel/nscommon.c | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index c8251545d57e..09e4ecd44972 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4104,6 +4104,8 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> +	if (anon)
> +		new_ns->ns.inum = MNT_NS_ANON_INO;
>  	ret = ns_common_init(&new_ns->ns, &mntns_operations, !anon);
>  	if (ret) {
>  		kfree(new_ns);
> @@ -6020,10 +6022,9 @@ static void __init init_mount_tree(void)
>  	if (IS_ERR(mnt))
>  		panic("Can't create rootfs");
>  
> -	ns = alloc_mnt_ns(&init_user_ns, true);
> +	ns = alloc_mnt_ns(&init_user_ns, false);
>  	if (IS_ERR(ns))
>  		panic("Can't allocate initial namespace");
> -	ns->ns.inum = PROC_MNT_INIT_INO;
>  	m = real_mount(mnt);
>  	ns->root = m;
>  	ns->nr_mounts = 1;
> @@ -6037,7 +6038,7 @@ static void __init init_mount_tree(void)
>  	set_fs_pwd(current->fs, &root);
>  	set_fs_root(current->fs, &root);
>  
> -	ns_tree_add(ns);
> +	ns_tree_add_raw(ns);

But we don't have ns->ns_id set by anything now? Or am I missing something?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

