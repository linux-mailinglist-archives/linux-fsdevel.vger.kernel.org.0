Return-Path: <linux-fsdevel+bounces-61396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA04B57CD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CB41AA0A78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC3A3128DE;
	Mon, 15 Sep 2025 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g8Gyu9zn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0t6zffSp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DogmMKlv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rb1GbvZ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66A33128C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942728; cv=none; b=CpoayafD+icweV7eLxA1Re8wFHmPQRcltqibY/osOfon9/b8c2NM9Jrj4FhkbKDMF7R7jFN4Nw6XADDEsvamzMHB8BZ7JtCBLjca0ZsDHl56ou0Y7UC5v+WRGauWj8p+GFb5WbLigzs0GVsr5PjVN3yMS5vZu3G67+KvM6CVgZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942728; c=relaxed/simple;
	bh=X0TOCZxXAacV5UY+tvG2AfFjjUdiuP3hBh1fdqjczUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLk6h9bi7s4BCwBhi1Psm5ELoLVWrjF4o4n37Z95OAEb7ltbZ1qtCDNiHID3AkqXIN0tSTGJn07ELt4qcOgckvVgwdlRUJGUPZfEp+qRBmwn1FTK/KWPMtd4FuwTpNnQoN3rrur5/D6cDzeQe65BDqPvdztAJBDskk6S3Oi8ssM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g8Gyu9zn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0t6zffSp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DogmMKlv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rb1GbvZ8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7026336A2;
	Mon, 15 Sep 2025 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757942725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdqwXF95v5+cBIN5km+b6uLUwL6CiQT8aqnzh2dXgmM=;
	b=g8Gyu9znowZysx8H26AteaCBYjp9Q9maHyK62RS3Ker3gaW7H8o5tBKEOi8lOSATG6I5av
	+Yex0EDkpNfiUIv7WMKnUJ2fliXC6QlQgAebHLHLgOLsN1Q1wKrKIXsmxk2u58ckxU5623
	1eMeTPJsxIK42Ev0lNRQcDTf0fT7C4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757942725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdqwXF95v5+cBIN5km+b6uLUwL6CiQT8aqnzh2dXgmM=;
	b=0t6zffSpUcqzh4SOni1oKpQu8YYsQkxFbcs9inKU4HnXYSv3qaGxnNKQf4Ib3DBt/gGn1D
	zXpARsLGTgEsLzAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DogmMKlv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rb1GbvZ8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757942724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdqwXF95v5+cBIN5km+b6uLUwL6CiQT8aqnzh2dXgmM=;
	b=DogmMKlv4uPZl3MwmdLdGeFgMViYJTX8+bPUUtbVhFn3Tgvm7FZYCaSl/462/ioJQor7d1
	OVMjb2H2fPcvFy79a0Hs93M8DbOlsWFtPRgzGxdE5/dvBKk/R58McrR0pAsQb6ljdkM4OY
	BSPbqqtwHKb1hXYsOJWBgxkfrOA4eoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757942724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdqwXF95v5+cBIN5km+b6uLUwL6CiQT8aqnzh2dXgmM=;
	b=rb1GbvZ8j8JF08umlPvgYfrfT9ZZ/JkBeCNZHO1VIEnqe+RCYoOSrID/gMZQ86cqdcymmx
	HVS/vKvguJGJypDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6E521372E;
	Mon, 15 Sep 2025 13:25:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HcyjLMQTyGghTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 13:25:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4A670A0A06; Mon, 15 Sep 2025 15:25:20 +0200 (CEST)
Date: Mon, 15 Sep 2025 15:25:20 +0200
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
Subject: Re: [PATCH v2 28/33] nsfs: support file handles
Message-ID: <4gsrbaiqrt3ymcze7rm6ec2oy25ernllidg2i3rkrsqh6q5deu@7bozrym7omj4>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-28-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-28-1a247645cef5@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C7026336A2
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
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email]
X-Spam-Score: -2.51

On Fri 12-09-25 13:52:51, Christian Brauner wrote:
> A while ago we added support for file handles to pidfs so pidfds can be
> encoded and decoded as file handles. Userspace has adopted this quickly
> and it's proven very useful. Implement file handles for namespaces as
> well.
> 
> A process is not always able to open /proc/self/ns/. That requires
> procfs to be mounted and for /proc/self/ or /proc/self/ns/ to not be
> overmounted. However, userspace can always derive a namespace fd from
> a pidfd. And that always works for a task's own namespace.
> 
> There's no need to introduce unnecessary behavioral differences between
> /proc/self/ns/ fds, pidfd-derived namespace fds, and file-handle-derived
> namespace fds. So namespace file handles are always decodable if the
> caller is located in the namespace the file handle refers to.
> 
> This also allows a task to e.g., store a set of file handles to its
> namespaces in a file on-disk so it can verify when it gets rexeced that
> they're still valid and so on. This is akin to the pidfd use-case.
> 
> Or just plainly for namespace comparison reasons where a file handle to
> the task's own namespace can be easily compared against others.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

...

> +	switch (ns->ops->type) {
> +#ifdef CONFIG_CGROUPS
> +	case CLONE_NEWCGROUP:
> +		if (!current_in_namespace(to_cg_ns(ns)))
> +			owning_ns = to_cg_ns(ns)->user_ns;
> +		break;
> +#endif
> +#ifdef CONFIG_IPC_NS
> +	case CLONE_NEWIPC:
> +		if (!current_in_namespace(to_ipc_ns(ns)))
> +			owning_ns = to_ipc_ns(ns)->user_ns;
> +		break;
> +#endif
> +	case CLONE_NEWNS:
> +		if (!current_in_namespace(to_mnt_ns(ns)))
> +			owning_ns = to_mnt_ns(ns)->user_ns;
> +		break;
> +#ifdef CONFIG_NET_NS
> +	case CLONE_NEWNET:
> +		if (!current_in_namespace(to_net_ns(ns)))
> +			owning_ns = to_net_ns(ns)->user_ns;
> +		break;
> +#endif
> +#ifdef CONFIG_PID_NS
> +	case CLONE_NEWPID:
> +		if (!current_in_namespace(to_pid_ns(ns))) {
> +			owning_ns = to_pid_ns(ns)->user_ns;
> +		} else if (!READ_ONCE(to_pid_ns(ns)->child_reaper)) {
> +			ns->ops->put(ns);
> +			return ERR_PTR(-EPERM);
> +		}
> +		break;
> +#endif
> +#ifdef CONFIG_TIME_NS
> +	case CLONE_NEWTIME:
> +		if (!current_in_namespace(to_time_ns(ns)))
> +			owning_ns = to_time_ns(ns)->user_ns;
> +		break;
> +#endif
> +#ifdef CONFIG_USER_NS
> +	case CLONE_NEWUSER:
> +		if (!current_in_namespace(to_user_ns(ns)))
> +			owning_ns = to_user_ns(ns);
> +		break;
> +#endif
> +#ifdef CONFIG_UTS_NS
> +	case CLONE_NEWUTS:
> +		if (!current_in_namespace(to_uts_ns(ns)))
> +			owning_ns = to_uts_ns(ns)->user_ns;
> +		break;
> +#endif

Frankly, switches like these are asking for more Generic usage ;) But ok
for now.

> +	default:
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
> +	if (owning_ns && !ns_capable(owning_ns, CAP_SYS_ADMIN)) {
> +		ns->ops->put(ns);
> +		return ERR_PTR(-EPERM);
> +	}
> +
> +	/* path_from_stashed() unconditionally consumes the reference. */
> +	ret = path_from_stashed(&ns->stashed, nsfs_mnt, ns, &path);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return no_free_ptr(path.dentry);

Ugh, so IMO this is very subtle because we declare

	struct path path __free(path_put)

but then do no_free_ptr(path.dentry). I really had to lookup implementation
of no_free_ptr() to check whether we are leaking mnt reference here or not
(we are not). But that seems as an implementation detail we shouldn't
better rely on? Wouldn't be:

	return dget(path.dentry);

much clearer (and sligthly less efficient, I know, but who cares)?

Otherwise looks good to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

