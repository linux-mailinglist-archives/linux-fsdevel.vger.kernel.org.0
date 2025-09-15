Return-Path: <linux-fsdevel+bounces-61335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A039FB579C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DD518977FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023D3305E28;
	Mon, 15 Sep 2025 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G5LEHeOc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tmO6hzn+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G5LEHeOc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tmO6hzn+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2396E2FE56D
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937779; cv=none; b=Vlt5jf6WWKQ3yfqqsc4hnlzrurD+NenuB4grD4nSnl910RKuAHp2Gvp40XN61DrKWSyOZfKn/iLQJIM2f90jiEqkYS48D1ek2+iYCFOu1E36s257KOlZflzz+YF5xR4vXhQjn2V5AoR4PtnoZpC//Deor9onkd2SMiNoLUFUYvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937779; c=relaxed/simple;
	bh=+TXlkW8Z3UjSMZ3mMju3NMVNIYxFe88jYkREYv69f+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ec1qik3ZU2s/DA43kPXz/1m1nB9BhQqULFhVlrgjLB+VV1s8SIwDs4CDxGsFzqV++hz91GD4NK6CmWl+ex0ynuOetW5E2xl0M0hC7UZZeyaeR0w449kPLadWib7XIMYhju6Lmacnb9eAdOgoJ7A4MSCLF5QX5Mj3YHW9h2xzX/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G5LEHeOc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tmO6hzn+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G5LEHeOc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tmO6hzn+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DE611FBB6;
	Mon, 15 Sep 2025 12:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757937774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n4kQtIN3mYgRKrDJiQ9BwBRP12ov3svY5yzZj6ZIIOg=;
	b=G5LEHeOc4LutebZENufLhfqnfVCy0DC7ZzbyrqJSQKM8IExvUY7oCGeZxcrly/RwHEVhdx
	A0BDBmj8ooTzsHuWTdWZxCh7chdVV67OdabDs1Lkn4vW/yPvmKtKbV5qINJxM4zxpBdYqr
	mHDcnIlX+TuEZofqUD78HgHUsHJlMqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757937774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n4kQtIN3mYgRKrDJiQ9BwBRP12ov3svY5yzZj6ZIIOg=;
	b=tmO6hzn+Vh77WECRkM+ywqy3/rTVGqyqeSvvRJWOl7ZJ8+4QSvYog2Xo9YmYJjmtT2k1mf
	2Sq1btCCvhGWckBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G5LEHeOc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tmO6hzn+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757937774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n4kQtIN3mYgRKrDJiQ9BwBRP12ov3svY5yzZj6ZIIOg=;
	b=G5LEHeOc4LutebZENufLhfqnfVCy0DC7ZzbyrqJSQKM8IExvUY7oCGeZxcrly/RwHEVhdx
	A0BDBmj8ooTzsHuWTdWZxCh7chdVV67OdabDs1Lkn4vW/yPvmKtKbV5qINJxM4zxpBdYqr
	mHDcnIlX+TuEZofqUD78HgHUsHJlMqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757937774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n4kQtIN3mYgRKrDJiQ9BwBRP12ov3svY5yzZj6ZIIOg=;
	b=tmO6hzn+Vh77WECRkM+ywqy3/rTVGqyqeSvvRJWOl7ZJ8+4QSvYog2Xo9YmYJjmtT2k1mf
	2Sq1btCCvhGWckBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D6611398D;
	Mon, 15 Sep 2025 12:02:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OMMrB24AyGhFMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 12:02:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B8722A0A06; Mon, 15 Sep 2025 14:02:45 +0200 (CEST)
Date: Mon, 15 Sep 2025 14:02:45 +0200
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
Subject: Re: [PATCH v2 21/33] net: support ns lookup
Message-ID: <qdxj5g326tpu3sczuhveknkvcsn6a3rngfm6plmwmbq22oof6e@qcapgrdp4n3x>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-21-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-21-1a247645cef5@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2DE611FBB6
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Score: -2.51

On Fri 12-09-25 13:52:44, Christian Brauner wrote:
> Support the generic ns lookup infrastructure to support file handles for
> namespaces.
> 
> The network namespace has a separate list with different lifetime rules
> which we can just leave in tact. We have a similar concept for mount
> namespaces as well where it is on two differenet lists for different
> purposes.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Just some nits below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index 025a7574b275..42075748dff1 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -11,6 +11,7 @@
>  #include <linux/list.h>
>  #include <linux/sysctl.h>
>  #include <linux/uidgid.h>
> +#include <linux/nstree.h>
>  
>  #include <net/flow.h>
>  #include <net/netns/core.h>

Why this include?

> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 5fb7bd8ac45a..169ec22c4758 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -20,6 +20,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/uidgid.h>
>  #include <linux/proc_fs.h>
> +#include <linux/nstree.h>
>  
>  #include <net/aligned_data.h>
>  #include <net/sock.h>
> @@ -445,7 +446,7 @@ static __net_init int setup_net(struct net *net)
>  	LIST_HEAD(net_exit_list);
>  	int error = 0;
>  
> -	net->net_cookie = atomic64_inc_return(&net_aligned_data.net_cookie);
> +	net->net_cookie = ns_tree_gen_id(&net->ns);

net_cookie seems to be unused now and can be deleted?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

