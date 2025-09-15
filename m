Return-Path: <linux-fsdevel+bounces-61355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD49B57A19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A9C97A3768
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218EF302CB8;
	Mon, 15 Sep 2025 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bR13VG/y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cKqSdVk6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bR13VG/y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cKqSdVk6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4A3054CA
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938319; cv=none; b=o4fBAkNEs2M7tFYxrVaz9gQVS/fGbPv4e0V3EB0Ow7A6e8xZ649v3lBja72X7CCTa0lIu0jdZZ2jW0tomGY4zbUy+FBo1aMdwdCTsyBgCuTAXSIH1JOAEzCnQUsqw6+Ia85YrvmS1YRVjBsib1Tkx9ZCbkkY6FCuXa3uP70zNJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938319; c=relaxed/simple;
	bh=xlRPAJhIpH4XL1xNECA1LZs2RkYtgCf8hJ82IBt380o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lov3a7O6aYlrn90X0XeSjkx6ctvnvRB5ZUSySydZwfixuNdjDZxJbnvbInQ2DlC6hAQJWk3EqqRZ6vUkfmfoywwBfKXeR5rFm58MBDxsmMP6KS+r9iTIgd15XTP6TtRHSp/QhYOvP9tEKSlBdTXi5IP6bubyD0DTC4CzS89FUD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bR13VG/y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cKqSdVk6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bR13VG/y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cKqSdVk6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1573A1F8C3;
	Mon, 15 Sep 2025 12:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757938316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nzSUoqECYfRg+oyrfybo/qQ/BsSe+olVOPSSTCRTm6I=;
	b=bR13VG/ypFDAljAvyBvCy2YVXy/I/PORbr5tUkjn5F9r1crhzdkbUxHwewqmu20Pxx1gq/
	4gEvtZ9hwWLQVW318siwg1279Djdjbq6x0VyOI2LCkUb7JXi5CPYr8ZvATBs/ltW6mqyXS
	0oKJ2lNK0onk90zYoY6TNHWssCy9VwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757938316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nzSUoqECYfRg+oyrfybo/qQ/BsSe+olVOPSSTCRTm6I=;
	b=cKqSdVk60T9hGN8FTqcgtgMCBF1ftl1bM33V6q+QS90kH+GAxRuGGpcF0OPVG6u2dkAQaL
	hvSQhZ6yuQzFxQAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757938316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nzSUoqECYfRg+oyrfybo/qQ/BsSe+olVOPSSTCRTm6I=;
	b=bR13VG/ypFDAljAvyBvCy2YVXy/I/PORbr5tUkjn5F9r1crhzdkbUxHwewqmu20Pxx1gq/
	4gEvtZ9hwWLQVW318siwg1279Djdjbq6x0VyOI2LCkUb7JXi5CPYr8ZvATBs/ltW6mqyXS
	0oKJ2lNK0onk90zYoY6TNHWssCy9VwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757938316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nzSUoqECYfRg+oyrfybo/qQ/BsSe+olVOPSSTCRTm6I=;
	b=cKqSdVk60T9hGN8FTqcgtgMCBF1ftl1bM33V6q+QS90kH+GAxRuGGpcF0OPVG6u2dkAQaL
	hvSQhZ6yuQzFxQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08E921368D;
	Mon, 15 Sep 2025 12:11:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jpwqAowCyGhoNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 12:11:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BAC22A0A06; Mon, 15 Sep 2025 14:11:55 +0200 (CEST)
Date: Mon, 15 Sep 2025 14:11:55 +0200
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
Subject: Re: [PATCH v2 24/33] user: support ns lookup
Message-ID: <bh6wllwygal6hfdjbv3amgok2yxzjgmemyvzriqf2wos6b3plp@tvhvgz47mll3>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-24-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-24-1a247645cef5@kernel.org>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLbyy5b47ky7xssyr143sji8pp)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

On Fri 12-09-25 13:52:47, Christian Brauner wrote:
> Support the generic ns lookup infrastructure to support file handles for
> namespaces.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
...
> @@ -200,6 +202,7 @@ static void free_user_ns(struct work_struct *work)
>  	do {
>  		struct ucounts *ucounts = ns->ucounts;
>  		parent = ns->parent;
> +		ns_tree_remove(ns);
>  		if (ns->gid_map.nr_extents > UID_GID_MAP_MAX_BASE_EXTENTS) {
>  			kfree(ns->gid_map.forward);
>  			kfree(ns->gid_map.reverse);
> @@ -218,7 +221,8 @@ static void free_user_ns(struct work_struct *work)
>  		retire_userns_sysctls(ns);
>  		key_free_user_ns(ns);
>  		ns_free_inum(&ns->ns);
> -		kmem_cache_free(user_ns_cachep, ns);
> +		/* Concurrent nstree traversal depends on a grace period. */
> +		kfree_rcu(ns, ns.ns_rcu);

So this is correct for now but it's a bit of a landmine. A lot of stuff
that ns references is kfreed before the RCU expires. Thus if you lookup ns
using id, then even if you're under RCU protection you have to be very
careful about what you can and cannot dereference. IMHO this deserves a
careful documentation at least or, preferably, split free_user_ns() into
pre and post-RCU period parts...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

