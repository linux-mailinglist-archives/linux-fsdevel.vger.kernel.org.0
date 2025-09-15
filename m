Return-Path: <linux-fsdevel+bounces-61325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AB6B57986
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EA527AECC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB8E30597B;
	Mon, 15 Sep 2025 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2ox7bi6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0EiDIzy6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2ox7bi6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0EiDIzy6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1293054F4
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937371; cv=none; b=RJo5noJJZszGEW8tCOvz1XsSq9zjvxuQnxiRsC3A1jXKcHu2VSOeIhsJlkAVuORGj8ohYDiiJM0MhVxnGLRXnJJB+msXARvV8HkFHlIfoEGinRmxmWII1i81EPg/r/IPHq1uqU6eBToRNRYo7e1sCty5HM5zWndotgHpvyUDamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937371; c=relaxed/simple;
	bh=5SAy/S59Ggt2UmfhtOFXBr5ELUioyjA5s3aED7Xeeos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ7CB21lOE+mnDiWXAOoqQyb/1b2Qm+WYKn/+0zNmkXppIycUTdCrEUw2gYKQb26Go3An/Ub7qk52F5+wrmTg4VjqAlTHTU2xQFQE9ghMblhNLUwi6NaiS8m1SYFrf112eXkkOJpenohkrU4nuYr3yo94HE3RrZTpK1xnms46t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2ox7bi6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0EiDIzy6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2ox7bi6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0EiDIzy6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 839C822339;
	Mon, 15 Sep 2025 11:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757937366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+z+lg2jxjASLKgxCba39b2tKjXVlPJRr+xqYq4raTBc=;
	b=B2ox7bi6NUMgJ+T/1CsbN7mDx8d1PSmXDvbK1WZAIDXeoQhX7WrX3+iwe+rkvFsacz02B1
	WCbK06c7/JLcwESpaIVe4PMYn1j3P5DnuUJKZfRupACek5f+6Yry8JmXxUPUNUv+LvACvz
	u7TxkBDbwevGf1IkFyyFp7RY3KUo5Dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757937366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+z+lg2jxjASLKgxCba39b2tKjXVlPJRr+xqYq4raTBc=;
	b=0EiDIzy6zY++3QYnAjOBmClD+2RL6eM0TF0QQVRidGcpuwpmCoCwlFRWZ7A7j6tWxW6AW2
	YVtKkDPnRSh8rwCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=B2ox7bi6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0EiDIzy6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757937366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+z+lg2jxjASLKgxCba39b2tKjXVlPJRr+xqYq4raTBc=;
	b=B2ox7bi6NUMgJ+T/1CsbN7mDx8d1PSmXDvbK1WZAIDXeoQhX7WrX3+iwe+rkvFsacz02B1
	WCbK06c7/JLcwESpaIVe4PMYn1j3P5DnuUJKZfRupACek5f+6Yry8JmXxUPUNUv+LvACvz
	u7TxkBDbwevGf1IkFyyFp7RY3KUo5Dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757937366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+z+lg2jxjASLKgxCba39b2tKjXVlPJRr+xqYq4raTBc=;
	b=0EiDIzy6zY++3QYnAjOBmClD+2RL6eM0TF0QQVRidGcpuwpmCoCwlFRWZ7A7j6tWxW6AW2
	YVtKkDPnRSh8rwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 708CB1368D;
	Mon, 15 Sep 2025 11:56:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DnJ+G9b+x2jaLgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 11:56:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 14C9DA0A06; Mon, 15 Sep 2025 13:56:06 +0200 (CEST)
Date: Mon, 15 Sep 2025 13:56:06 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 20/33] ipc: support ns lookup
Message-ID: <mz25i4gk6wx2634wn7eb6l4ft2vh4gjhqq7zagajyjdq7rt4kv@u3r35wjzavy3>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-20-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-20-1a247645cef5@kernel.org>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL9r1cnt7e4118fjryeg1c95sa)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 839C822339
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Fri 12-09-25 13:52:43, Christian Brauner wrote:
> Support the generic ns lookup infrastructure to support file handles for
> namespaces.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  ipc/msgutil.c   | 1 +
>  ipc/namespace.c | 3 +++
>  ipc/shm.c       | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/ipc/msgutil.c b/ipc/msgutil.c
> index c7be0c792647..bbf61275df41 100644
> --- a/ipc/msgutil.c
> +++ b/ipc/msgutil.c
> @@ -15,6 +15,7 @@
>  #include <linux/proc_ns.h>
>  #include <linux/uaccess.h>
>  #include <linux/sched.h>
> +#include <linux/nstree.h>
>  
>  #include "util.h"
>  
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index d4188a88ee57..9f923c1a1eb3 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -15,6 +15,7 @@
>  #include <linux/mount.h>
>  #include <linux/user_namespace.h>
>  #include <linux/proc_ns.h>
> +#include <linux/nstree.h>
>  #include <linux/sched/task.h>
>  
>  #include "util.h"
> @@ -85,6 +86,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
>  
>  	sem_init_ns(ns);
>  	shm_init_ns(ns);
> +	ns_tree_add(ns);
>  
>  	return ns;
>  
> @@ -201,6 +203,7 @@ void put_ipc_ns(struct ipc_namespace *ns)
>  		mq_clear_sbinfo(ns);
>  		spin_unlock(&mq_lock);
>  
> +		ns_tree_remove(ns);
>  		if (llist_add(&ns->mnt_llist, &free_ipc_list))
>  			schedule_work(&free_ipc_work);
>  	}
> diff --git a/ipc/shm.c b/ipc/shm.c
> index a9310b6dbbc3..3db36773dd10 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -45,6 +45,7 @@
>  #include <linux/mount.h>
>  #include <linux/ipc_namespace.h>
>  #include <linux/rhashtable.h>
> +#include <linux/nstree.h>
>  
>  #include <linux/uaccess.h>
>  
> @@ -148,6 +149,7 @@ void shm_exit_ns(struct ipc_namespace *ns)
>  static int __init ipc_ns_init(void)
>  {
>  	shm_init_ns(&init_ipc_ns);
> +	ns_tree_add(&init_ipc_ns);
>  	return 0;
>  }
>  
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

