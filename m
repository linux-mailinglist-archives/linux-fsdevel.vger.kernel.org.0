Return-Path: <linux-fsdevel+bounces-61341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DEFB579D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5AC1A208D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9729D305940;
	Mon, 15 Sep 2025 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LFaKUbri";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LO/X1Iyc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LFaKUbri";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LO/X1Iyc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682512FFDFE
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937878; cv=none; b=pkh/CONcjRLCkjAclvQGP2Kidwr3NDBvWy7PSVYMK5jOMSCfXAul3kMOzNcZzM8vOl6q7Pa3ADHPDdaill0E/QZyvvwqy0uIyWLMSN7rcSoBwF6/BAEk6LZZlvpX60HAE4U4p26daNChkk/Q3dL/ftzqIosFPMeRYRCTOuzRh/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937878; c=relaxed/simple;
	bh=TKLHmSn143LM+CSvnv0ajKbCEGc8gLJieCMukbTN57E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIHbDR0HPppTEeWpKSLYtx9YjfyPeQ46Jnep7lwGD6D0NO9PfO+QbPl4F9AWhiSdJXgb2nGCjaRYnFWy4145LnezX8D/XJgoLeglZejoVpWMGI6uhgGjJVrPIh3W7V/rOLhckcem2aS4PnF2OzTtdDJbest1rKCKrYrQ9676UBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LFaKUbri; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LO/X1Iyc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LFaKUbri; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LO/X1Iyc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB63D1F8B0;
	Mon, 15 Sep 2025 12:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757937874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j9D5JOnLIGbPLQ/ZIcQ3I5eG7ibeoSdEgH4Y40mwguw=;
	b=LFaKUbriuaxssWc8aokQp8aBdO5TFiQa516sK7E7ihAXh2g/DK4jqW6kI+epGTMnS1LdE7
	6EoFH/IiFbci7tLAVS/6qNQMgmCrfvyPOTjXKcVi8xMgypqR9K099hz/lKNSpiqN9K93O8
	VRRidbdQ6EatjuaGW1bHbTtMuDC98QI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757937874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j9D5JOnLIGbPLQ/ZIcQ3I5eG7ibeoSdEgH4Y40mwguw=;
	b=LO/X1Iyc/VcnKo9OryF2429eTlNPVbA+Eny5LvFxhOezsRRq1CBVHPQ7FmYysF2pdFLrvT
	BtqI0oeRiPClKeDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LFaKUbri;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="LO/X1Iyc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757937874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j9D5JOnLIGbPLQ/ZIcQ3I5eG7ibeoSdEgH4Y40mwguw=;
	b=LFaKUbriuaxssWc8aokQp8aBdO5TFiQa516sK7E7ihAXh2g/DK4jqW6kI+epGTMnS1LdE7
	6EoFH/IiFbci7tLAVS/6qNQMgmCrfvyPOTjXKcVi8xMgypqR9K099hz/lKNSpiqN9K93O8
	VRRidbdQ6EatjuaGW1bHbTtMuDC98QI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757937874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j9D5JOnLIGbPLQ/ZIcQ3I5eG7ibeoSdEgH4Y40mwguw=;
	b=LO/X1Iyc/VcnKo9OryF2429eTlNPVbA+Eny5LvFxhOezsRRq1CBVHPQ7FmYysF2pdFLrvT
	BtqI0oeRiPClKeDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CDAB1398D;
	Mon, 15 Sep 2025 12:04:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eadJJtIAyGgGMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 12:04:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5930AA0A06; Mon, 15 Sep 2025 14:04:34 +0200 (CEST)
Date: Mon, 15 Sep 2025 14:04:34 +0200
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
Subject: Re: [PATCH v2 22/33] pid: support ns lookup
Message-ID: <f2sbqcorwm7x6weiduhectcrlwedcnpppfhiepjcmeij2xq5bv@j7yrhpkgjzr7>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-22-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-22-1a247645cef5@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: AB63D1F8B0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RL9r1cnt7e4118fjryeg1c95sa)];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -2.51

On Fri 12-09-25 13:52:45, Christian Brauner wrote:
> Support the generic ns lookup infrastructure to support file handles for
> namespaces.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  kernel/pid_namespace.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 20ce4052d1c5..228ae20299f9 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -23,6 +23,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/sched/signal.h>
>  #include <linux/idr.h>
> +#include <linux/nstree.h>
>  #include <uapi/linux/wait.h>
>  #include "pid_sysctl.h"
>  
> @@ -122,6 +123,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
>  	ns->memfd_noexec_scope = pidns_memfd_noexec_scope(parent_pid_ns);
>  #endif
>  
> +	ns_tree_add(ns);
>  	return ns;
>  
>  out_free_inum:
> @@ -147,6 +149,7 @@ static void delayed_free_pidns(struct rcu_head *p)
>  
>  static void destroy_pid_namespace(struct pid_namespace *ns)
>  {
> +	ns_tree_remove(ns);
>  	unregister_pidns_sysctls(ns);
>  
>  	ns_free_inum(&ns->ns);
> @@ -473,6 +476,7 @@ static __init int pid_namespaces_init(void)
>  #endif
>  
>  	register_pid_ns_sysctl_table_vm();
> +	ns_tree_add(&init_pid_ns);
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

