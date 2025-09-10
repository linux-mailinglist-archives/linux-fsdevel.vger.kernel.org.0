Return-Path: <linux-fsdevel+bounces-60815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F2EB51C17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC41188A4CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4C132ED33;
	Wed, 10 Sep 2025 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mVJeI9oJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tpySIQnR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mVJeI9oJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tpySIQnR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9D032BF24
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518854; cv=none; b=fMgXTYpyWyBim8Bdo2LP5lNRNrte+z8db7DO3ZDm+uuTPe0lv2WUwO9PTIuJ/KORHocBUOeZTc1ENYPGJwz+RGjJi8WJfex7I1v/6MbxtG2N+cbOq6gJ5JXEwTtIrvf4jHr010Dxko4woEbmnvZ/RtWf90mLE8nshCdpSGa7zNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518854; c=relaxed/simple;
	bh=MHt6EeAN+ZsciugCSDIrgVHFK2S33I8cWDZT3BZJAXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/jDWFMA8bDoGfv2uwNeJmDrFF71bjqrpzlEs4/iztDexuKTGVh7HxLtC/66N/Oad3ph7ZMYTEs0sGEUzP3Yaq/NciKj99LHN9nLraw61zcYGnLAy8RmMJ5hmEJymwaXwisVrcOfmNDRkXzMnzGdHsyau8xD3Bcw08vgZoyQ3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mVJeI9oJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tpySIQnR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mVJeI9oJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tpySIQnR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C64E613B5;
	Wed, 10 Sep 2025 15:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZDTY0n8P1mfxZXi4AoZ5HBICr1vPvF2/9R9+5Invzk=;
	b=mVJeI9oJa434eMRYr5k2CDCMhIO2xZZt8qIQnvJWPnhBWyWfz9O64c3Z1RWSrpBIR+6YNx
	kEl0G9DuuG3OwWy0OO7+o4U2NK+d9BcxvrpBNaxlyiDnB3bUSJJfW95kBRTVcqsvJj8uSI
	9dS9oek3JmD1tP8h1jrvJM1OjyqdEq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZDTY0n8P1mfxZXi4AoZ5HBICr1vPvF2/9R9+5Invzk=;
	b=tpySIQnRK9LuC8lvVbprS3V1A93jwNg1EOMV7P5Ukp2xXDoQU2R2Hqkeg9SSC+ZYbBL3Vw
	WZbMf9qiVYJsAEDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mVJeI9oJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tpySIQnR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZDTY0n8P1mfxZXi4AoZ5HBICr1vPvF2/9R9+5Invzk=;
	b=mVJeI9oJa434eMRYr5k2CDCMhIO2xZZt8qIQnvJWPnhBWyWfz9O64c3Z1RWSrpBIR+6YNx
	kEl0G9DuuG3OwWy0OO7+o4U2NK+d9BcxvrpBNaxlyiDnB3bUSJJfW95kBRTVcqsvJj8uSI
	9dS9oek3JmD1tP8h1jrvJM1OjyqdEq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZDTY0n8P1mfxZXi4AoZ5HBICr1vPvF2/9R9+5Invzk=;
	b=tpySIQnRK9LuC8lvVbprS3V1A93jwNg1EOMV7P5Ukp2xXDoQU2R2Hqkeg9SSC+ZYbBL3Vw
	WZbMf9qiVYJsAEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23EC613310;
	Wed, 10 Sep 2025 15:40:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PjjDCPCbwWgVOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Sep 2025 15:40:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A8CBFA0A2D; Wed, 10 Sep 2025 17:40:27 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:40:27 +0200
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
Subject: Re: [PATCH 06/32] ns: uniformly initialize ns_common
Message-ID: <7ds6qw5foldks66ddgbeefr2p2gs5hkclii6oefskfz5blhm7n@ia5ii3khqtar>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-6-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-6-4dd56e7359d8@kernel.org>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
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
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 3C64E613B5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Wed 10-09-25 16:36:51, Christian Brauner wrote:
> No point in cargo-culting the same code across all the different types.
> Use one common initializer.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/proc_ns.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
> index 5e1a4b378b79..dbb119bda097 100644
> --- a/include/linux/proc_ns.h
> +++ b/include/linux/proc_ns.h
> @@ -72,6 +72,22 @@ static inline int ns_alloc_inum(struct ns_common *ns)
>  	return proc_alloc_inum(&ns->inum);
>  }
>  
> +static inline int ns_common_init(struct ns_common *ns,
> +				 const struct proc_ns_operations *ops,
> +				 bool alloc_inum)
> +{
> +	if (alloc_inum) {
> +		int ret;
> +		ret = proc_alloc_inum(&ns->inum);
> +		if (ret)
> +			return ret;
> +	}
> +	refcount_set(&ns->count, 1);
> +	ns->stashed = NULL;
> +	ns->ops = ops;
> +	return 0;
> +}
> +
>  #define ns_free_inum(ns) proc_free_inum((ns)->inum)
>  
>  #define get_proc_ns(inode) ((struct ns_common *)(inode)->i_private)
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

