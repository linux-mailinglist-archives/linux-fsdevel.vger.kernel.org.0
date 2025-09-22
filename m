Return-Path: <linux-fsdevel+bounces-62383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D75EFB90015
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 12:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E03422685
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 10:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723992D97A1;
	Mon, 22 Sep 2025 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w5NOpySd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ae4+z26I";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w5NOpySd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ae4+z26I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ACB2264B2
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537085; cv=none; b=iU62GH/cPyBBcIAHFLFNMA6f4tTLsdATZxZMZTHhsQ5LRULLncLcBrQTLbzqsAwICS0/VhEGOy20ZfpY0kmKcVNdrI7rcLRs4bIf4rbvdIDBHdGypB3yTS5Jbps4p0zJXKKXXrfHMu2+19gAp+GhRDpWrlx+OyV0wEttJSDX1gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537085; c=relaxed/simple;
	bh=CaZm7k7XeA+qMqTVNZl5ZVdOJnFZTbp0EEhgCgVFqAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz7jZG3cHzYg2Aw7k2u+qqSx5WZtsmdAkk8vAWczyT5qQrUdYJY//WbJlEGTI6zHP8IB3+0QPSXXtvA/JJ2l2RzuPm3/nn4ilD8nMP4LhAOJoZ2MCY5bKAVzi7RUaeCz0gKtl4GSTylYFYKu9E0CVdMmLAV6z9yvcci1Mxp6DnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w5NOpySd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ae4+z26I; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w5NOpySd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ae4+z26I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BA65200E3;
	Mon, 22 Sep 2025 10:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758537082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TNPmno450eKsPUnaI8sigzSzVZ6H2+FqMAunLeCCCCA=;
	b=w5NOpySdnBNUYybp/u9sbeuAhz66khMx+4yyWl2lI7PVahYITnWS+1N0gVXulLgjmUE1Ob
	KucdrBeS7l+z9ww1S3jTrJWw8n8qmnnQfY1RT05h3yhnXndEFhSn9gjpp5AdvpKoOXuIA8
	VulV0nCMAMGHyprvUSIfubpE/MSHv6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758537082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TNPmno450eKsPUnaI8sigzSzVZ6H2+FqMAunLeCCCCA=;
	b=ae4+z26ILJgCyT5O6QGZZj9W1JTecl5uoBbVGxZs/0buan/RN0WBvowHJYsbVcmEk/ygGL
	n1vOxIc+Sm7eRpAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758537082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TNPmno450eKsPUnaI8sigzSzVZ6H2+FqMAunLeCCCCA=;
	b=w5NOpySdnBNUYybp/u9sbeuAhz66khMx+4yyWl2lI7PVahYITnWS+1N0gVXulLgjmUE1Ob
	KucdrBeS7l+z9ww1S3jTrJWw8n8qmnnQfY1RT05h3yhnXndEFhSn9gjpp5AdvpKoOXuIA8
	VulV0nCMAMGHyprvUSIfubpE/MSHv6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758537082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TNPmno450eKsPUnaI8sigzSzVZ6H2+FqMAunLeCCCCA=;
	b=ae4+z26ILJgCyT5O6QGZZj9W1JTecl5uoBbVGxZs/0buan/RN0WBvowHJYsbVcmEk/ygGL
	n1vOxIc+Sm7eRpAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 676F51388C;
	Mon, 22 Sep 2025 10:31:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S6PdGHol0WhjPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Sep 2025 10:31:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 25184A07C4; Mon, 22 Sep 2025 12:31:22 +0200 (CEST)
Date: Mon, 22 Sep 2025 12:31:22 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ns: use inode initializer for initial namespaces
Message-ID: <mmodp3putle4benhakn4cjl2qyominpyz5octsh5azfo5n6nbd@wr4v7ylvofpz>
References: <20250919-erbeben-wirken-283389ef529b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-erbeben-wirken-283389ef529b@brauner>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Fri 19-09-25 12:06:11, Christian Brauner wrote:
> Just use the common helper we have.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Not sure if this is a big win when the ino is in the initializer but
whatever. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c           | 2 +-
>  init/version-timestamp.c | 2 +-
>  ipc/msgutil.c            | 2 +-
>  kernel/cgroup/cgroup.c   | 2 +-
>  kernel/pid.c             | 2 +-
>  kernel/time/namespace.c  | 2 +-
>  kernel/user.c            | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 699b8c770c47..410b5fce1633 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -6012,7 +6012,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
>  }
>  
>  struct mnt_namespace init_mnt_ns = {
> -	.ns.inum	= PROC_MNT_INIT_INO,
> +	.ns.inum	= ns_init_inum(&init_mnt_ns),
>  	.ns.ops		= &mntns_operations,
>  	.user_ns	= &init_user_ns,
>  	.ns.count	= REFCOUNT_INIT(1),
> diff --git a/init/version-timestamp.c b/init/version-timestamp.c
> index 043cbf80a766..8e335d54745d 100644
> --- a/init/version-timestamp.c
> +++ b/init/version-timestamp.c
> @@ -18,7 +18,7 @@ struct uts_namespace init_uts_ns = {
>  		.domainname	= UTS_DOMAINNAME,
>  	},
>  	.user_ns = &init_user_ns,
> -	.ns.inum = PROC_UTS_INIT_INO,
> +	.ns.inum = ns_init_inum(&init_uts_ns),
>  #ifdef CONFIG_UTS_NS
>  	.ns.ops = &utsns_operations,
>  #endif
> diff --git a/ipc/msgutil.c b/ipc/msgutil.c
> index bbf61275df41..0fa5aef5fc03 100644
> --- a/ipc/msgutil.c
> +++ b/ipc/msgutil.c
> @@ -29,7 +29,7 @@ DEFINE_SPINLOCK(mq_lock);
>  struct ipc_namespace init_ipc_ns = {
>  	.ns.count = REFCOUNT_INIT(1),
>  	.user_ns = &init_user_ns,
> -	.ns.inum = PROC_IPC_INIT_INO,
> +	.ns.inum = ns_init_inum(&init_ipc_ns),
>  #ifdef CONFIG_IPC_NS
>  	.ns.ops = &ipcns_operations,
>  #endif
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 092e6bf081ed..1f2dde3ffc15 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -222,7 +222,7 @@ struct cgroup_namespace init_cgroup_ns = {
>  	.ns.count	= REFCOUNT_INIT(2),
>  	.user_ns	= &init_user_ns,
>  	.ns.ops		= &cgroupns_operations,
> -	.ns.inum	= PROC_CGROUP_INIT_INO,
> +	.ns.inum	= ns_init_inum(&init_cgroup_ns),
>  	.root_cset	= &init_css_set,
>  };
>  
> diff --git a/kernel/pid.c b/kernel/pid.c
> index c45a28c16cd2..9a803a511d63 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -77,7 +77,7 @@ struct pid_namespace init_pid_ns = {
>  	.level = 0,
>  	.child_reaper = &init_task,
>  	.user_ns = &init_user_ns,
> -	.ns.inum = PROC_PID_INIT_INO,
> +	.ns.inum = ns_init_inum(&init_pid_ns),
>  #ifdef CONFIG_PID_NS
>  	.ns.ops = &pidns_operations,
>  #endif
> diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
> index ce8e952104a7..f58f64bab28b 100644
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -482,7 +482,7 @@ const struct proc_ns_operations timens_for_children_operations = {
>  struct time_namespace init_time_ns = {
>  	.ns.count	= REFCOUNT_INIT(3),
>  	.user_ns	= &init_user_ns,
> -	.ns.inum	= PROC_TIME_INIT_INO,
> +	.ns.inum	= ns_init_inum(&init_time_ns),
>  	.ns.ops		= &timens_operations,
>  	.frozen_offsets	= true,
>  };
> diff --git a/kernel/user.c b/kernel/user.c
> index f46b1d41163b..14a59e53b20c 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -68,7 +68,7 @@ struct user_namespace init_user_ns = {
>  	.ns.count = REFCOUNT_INIT(3),
>  	.owner = GLOBAL_ROOT_UID,
>  	.group = GLOBAL_ROOT_GID,
> -	.ns.inum = PROC_USER_INIT_INO,
> +	.ns.inum = ns_init_inum(&init_user_ns),
>  #ifdef CONFIG_USER_NS
>  	.ns.ops = &userns_operations,
>  #endif
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

