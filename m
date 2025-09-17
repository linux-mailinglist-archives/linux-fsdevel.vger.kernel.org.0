Return-Path: <linux-fsdevel+bounces-61961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF05B81039
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 18:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ECF62A0369
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF720229B1F;
	Wed, 17 Sep 2025 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gFbpLFj+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gtlmibLO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PjD1+4Ol";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q/TIevOh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A0224B04
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126525; cv=none; b=VUmi8Z6bP+93TPjgEh71rkl8O1Rnx6Wkc9hSQdpfmNEhSPkfLOyQZgTPvIIgDJUgas3bzcsz1I7AhI5NVHpJ3DK3JZTOWG1JeJ2BwUQpvTku0dkm9crtXlSUSpaLZ/AX/6zPsQTiu4td5plNGxbEjCuYbiq3/ywatT3vcW+YU+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126525; c=relaxed/simple;
	bh=3bzbuf2TdiGrC0TNG9ZgtRS/e5A769JAIK6NlrY7Lr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQ0gCLhEaf0CypGlIYeXo9RTl+7z18YezqmTaxHvA4omgNYtItJd9nFyHPdkzMsXTDxokHFbTUdtIClYZWSrW2Mj+8D+zSm8VmtH2zvdL41em2yAKN3DPRjWpuh3vnme3QRT6IUUnu0nVx1T6SEHMzySx6T79x/0sDKq28pIcn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gFbpLFj+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gtlmibLO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PjD1+4Ol; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q/TIevOh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E793320D7C;
	Wed, 17 Sep 2025 16:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758126522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kbLwGr2Tk1p277N0IGSkxxjAe8nYGHmpY42SElvUgD8=;
	b=gFbpLFj+ERyvaWQ5cn1hWsISRsBd3JdcksWILtWpv0ql3Mlp1dtYSaNxrVklrcDEMPYnj1
	wWe18WY/4Hb88kRI4nBCn0WLSC9DgK/O4RF0PFX+r1uBfuAGg4kKxdtP7S0iFP2GtcrGin
	Wd1K4RKctLvHfM/AwcpoI7nlwCkdmWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758126522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kbLwGr2Tk1p277N0IGSkxxjAe8nYGHmpY42SElvUgD8=;
	b=gtlmibLOqcmBd5EKfu7zDCLSx2uVybh6FNjx0gU/hq7TY7t0R+ENze0BCFvzhDeGA/j0Pj
	ukkPue+UrnG1HgAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PjD1+4Ol;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Q/TIevOh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758126521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kbLwGr2Tk1p277N0IGSkxxjAe8nYGHmpY42SElvUgD8=;
	b=PjD1+4Olh+R77W1oaCIhSx2Z/3gMnB6yD/rq9UeT4NCMQOPVb6dWt4XVbCA42yU/yZGYYg
	E3pz87Yv8aCIeqmo93B5WVh0pRBrwgqd/gX1CBlVCzkZcAQw/f+0hMMUBXDSvQAXGOeav2
	+0T7Jdbi7ONPwB3aKnmegSGK+8+6zM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758126521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kbLwGr2Tk1p277N0IGSkxxjAe8nYGHmpY42SElvUgD8=;
	b=Q/TIevOhZPPqxS+YiOw0kGYk+G8F9+aqBxx7lMGkANqj1j7Mcn1ipPf03dL5dmuLsQlEgs
	S4/IdZckIEuwvBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D98C91368D;
	Wed, 17 Sep 2025 16:28:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vlAbNbnhymglMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Sep 2025 16:28:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 69A2CA083B; Wed, 17 Sep 2025 18:28:37 +0200 (CEST)
Date: Wed, 17 Sep 2025 18:28:37 +0200
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
Subject: Re: [PATCH 2/9] mnt: expose pointer to init_mnt_ns
Message-ID: <oqtggwqink4kthsxiv6tv6q6l7tgykosz3tenek2vejqfiuqzl@drczxzwwucfi>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-2-1b3bda8ef8f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-work-namespace-ns_common-v1-2-1b3bda8ef8f2@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E793320D7C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL9r1cnt7e4118fjryeg1c95sa)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz,cmpxchg.org,suse.com,linutronix.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.51

On Wed 17-09-25 12:28:01, Christian Brauner wrote:
> There's various scenarios where we need to know whether we are in the
> initial set of namespaces or not to e.g., shortcut permission checking.
> All namespaces expose that information. Let's do that too.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Right. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c                | 2 ++
>  include/linux/mnt_namespace.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a68998449698..c8251545d57e 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -81,6 +81,7 @@ static DECLARE_RWSEM(namespace_sem);
>  static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
>  static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
>  static struct mnt_namespace *emptied_ns; /* protected by namespace_sem */
> +struct mnt_namespace *init_mnt_ns;
>  
>  #ifdef CONFIG_FSNOTIFY
>  LIST_HEAD(notify_list); /* protected by namespace_sem */
> @@ -6037,6 +6038,7 @@ static void __init init_mount_tree(void)
>  	set_fs_root(current->fs, &root);
>  
>  	ns_tree_add(ns);
> +	init_mnt_ns = ns;
>  }
>  
>  void __init mnt_init(void)
> diff --git a/include/linux/mnt_namespace.h b/include/linux/mnt_namespace.h
> index 70b366b64816..7e23c8364a9c 100644
> --- a/include/linux/mnt_namespace.h
> +++ b/include/linux/mnt_namespace.h
> @@ -11,6 +11,8 @@ struct fs_struct;
>  struct user_namespace;
>  struct ns_common;
>  
> +extern struct mnt_namespace *init_mnt_ns;
> +
>  extern struct mnt_namespace *copy_mnt_ns(unsigned long, struct mnt_namespace *,
>  		struct user_namespace *, struct fs_struct *);
>  extern void put_mnt_ns(struct mnt_namespace *ns);
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

