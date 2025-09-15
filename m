Return-Path: <linux-fsdevel+bounces-61315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C7BB578F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92796442E9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2332C30102C;
	Mon, 15 Sep 2025 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="agVcmh8O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GZfNCJW2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M3N+LDGW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6AmqcYNO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19CC2FE060
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936935; cv=none; b=NOE2XoqVndvhXf/Yi6tfybHp3vZemFNMo10Zb1+cskjQpL3EhcoyXgmwYicbzcSlAHpDmBntIsi3/DZycWVg5QgYZ8cCZaC2cYpTS3oCKlu/ay1LiGAHhiiYB2tFKgZ9HUFuTVilJ/3Wap0WY2LWM1HEI+4Wx1gTJTkoWHNEL6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936935; c=relaxed/simple;
	bh=5ELWNAAkYG44yfI5zcTMTxvStjqewt/R8qc6dUxrHYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYio0YWaeQEByWDIOrxDZterILxSEZxJnaD7GFddPVZlij04hj9czc5wEJjD9lv6mEGgS/mOU7qSDGSrbXKMG58Cu63eP4hH3CML9ofChrLRVLMHp+Bxa3zB5G0QPXNvDZx0REVN0IiZZVMDZ6yl/BXPeBicYDaiwrw8Yvun9AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=agVcmh8O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GZfNCJW2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M3N+LDGW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6AmqcYNO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D555E1F7B2;
	Mon, 15 Sep 2025 11:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757936932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYCT30aMf5AWqaSHpzlyTwCICjVwekEoMr6JJ+kLupI=;
	b=agVcmh8O+T6wKnCEWRf7rhXRzfbIqYqotnouG5EASg6+1mbbjy/PyUX6k+YIAsNOd8u95D
	vbN3HR/bGqVfMcxv8QZFzBuPG/yKeMdtadVrmhpeEaA+93U7llEjS4BYFwImO/qWlzd5AT
	KD10oBotCg58UAByEcN4tJGC0gM8l0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757936932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYCT30aMf5AWqaSHpzlyTwCICjVwekEoMr6JJ+kLupI=;
	b=GZfNCJW2UNo6GviejW/6uMoZjdhFOaxwr1LL0u+bH5ZIvNJWJyFrHQE2xqqJoQX6A7LWQS
	q7ON4rOUQ0NdbkCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M3N+LDGW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6AmqcYNO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757936931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYCT30aMf5AWqaSHpzlyTwCICjVwekEoMr6JJ+kLupI=;
	b=M3N+LDGWuHOUSMXfr0+vCFig9k2c3UNaSCay0FAlWhD08OKHdHUHMMa1TATHS/lTbqAFRt
	87sUD3sMM5fMU8CpClFDurSF+oTh401Hpf5Z14JR+6/h8nhmtx/wIUfVIU6w6hCH5rDI0U
	3zsGRB4trOFm/PuEtBFfc4naSQap2hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757936931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYCT30aMf5AWqaSHpzlyTwCICjVwekEoMr6JJ+kLupI=;
	b=6AmqcYNOHjYP07uJd4dNZoZI8YcO2/FMLRUjOxmgP7qvth5JN0hvYnImNNK3wsHKjrsJTR
	V2VtivsSRi8bG2CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF7541368D;
	Mon, 15 Sep 2025 11:48:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tLVwLiP9x2iOLAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 11:48:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 72FB3A0A06; Mon, 15 Sep 2025 13:48:51 +0200 (CEST)
Date: Mon, 15 Sep 2025 13:48:51 +0200
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
Subject: Re: [PATCH v2 18/33] mnt: support ns lookup
Message-ID: <4hey7blvy6dfk22kargj46oevtrnk6nccbgjrbk3xvctvbfhdt@jimfucryj25d>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-18-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-18-1a247645cef5@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D555E1F7B2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Fri 12-09-25 13:52:41, Christian Brauner wrote:
> Move the mount namespace to the generic ns lookup infrastructure.
> This allows us to drop a bunch of members from struct mnt_namespace.
>                                                                       t
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Just one nit below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -4185,11 +4107,11 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
>  		return ERR_PTR(ret);
>  	}
>  	if (!anon)
> -		new_ns->seq = atomic64_inc_return(&mnt_ns_seq);
> +		ns_tree_gen_id(&new_ns->ns);
> +	RB_CLEAR_NODE(&new_ns->ns.ns_tree_node);
> +	INIT_LIST_HEAD(&new_ns->ns.ns_list_node);

Why do you initialize ns_tree_node and ns_list_node here when
ns_init_common() already initialized them?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

