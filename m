Return-Path: <linux-fsdevel+bounces-61418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C04AB57EAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5CD188B2C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F3331CA68;
	Mon, 15 Sep 2025 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ou3VryN3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2mzOUJQM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZpPwxUC3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vLnaHrLV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FEC31CA65
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945695; cv=none; b=H1w1QWJUpwEjIwXCUOa/JxWD1IuzuZsRcKyfBHve9Eco+9wkG59Q6sp9xKOLkHzDnqJ+abd1/2C7uL7iSvidjzbtPOh9xYPjVNkuI3I6LpfaV3xcsIp5stYq+JAFMK9uZM60jhoMRlOpEdVhIa0drYvVPsRjPc06dw7fimRoLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945695; c=relaxed/simple;
	bh=kDdiKvRzZs74joM2c+r6TWVCJFJiOkwsvb50nM/IAIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuzKlePK2jCCIHjusx7prPvzidu/EpDe0LgOpZI8fCNhmHENTRxr2W+LRioPBXJcS/HKIs1HMQIuBoi55bR+cicP3YBRaeJiz2x75FP91RfdDGAJ1cevc/8YsCve6cQUxvl1zbhsUyNhmXhzumcXV/Ot9r2akMc89uNdnNotbG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ou3VryN3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2mzOUJQM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZpPwxUC3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vLnaHrLV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2AF5336A2;
	Mon, 15 Sep 2025 14:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757945691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GVDIBoXI5PkmR2yBJg4qG4wQKyhaIJX7uV/hEXmMXs8=;
	b=ou3VryN3TJFt4FY4IY62tzlkNxzTk2nIt77lDQi6F8qdKmm8KfDz2oMzo5KiJNvbZu0BCP
	xorF3RuI3QF6U2drqTeovq5cluMcOsI7T3au2RWRaK6202Lg/jibiwudC6KVnIvLe78UEA
	sXJMER7C4B6Snsz5tDTBr+ZM9XfSEL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757945691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GVDIBoXI5PkmR2yBJg4qG4wQKyhaIJX7uV/hEXmMXs8=;
	b=2mzOUJQM/311vHeI5LDaUx9gyVESMhWzGcoYTZ+ZitJz7aR2ydDyGQWIVXx8wMOKq4cLrj
	qFz6iELOKzW25VBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757945690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GVDIBoXI5PkmR2yBJg4qG4wQKyhaIJX7uV/hEXmMXs8=;
	b=ZpPwxUC3V8kU2mcYC0gzYq7KKGCV1/PHMiIpnC9eTP0qmLFdu9+nA2wft1zHj2tdpEnH12
	98/FlZ/gi4pwS/3BwFGalgSWPaz3DMnWGUyjZU0Z9kx9/Wj06w704rgpcKG7XiVb/1XrtC
	HssWZ0C4yLW1PvPT7CrVKgBus9gf/8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757945690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GVDIBoXI5PkmR2yBJg4qG4wQKyhaIJX7uV/hEXmMXs8=;
	b=vLnaHrLVPwh55KlAopRuS/32SIQqCJl+i+CPJCbsLR4gkvDVX3q13yii0LLUNbF6FADxnX
	jcTo6AJvypkuDbCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0A121368D;
	Mon, 15 Sep 2025 14:14:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gOGwKlofyGiBXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 14:14:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5B07CA0A06; Mon, 15 Sep 2025 16:14:50 +0200 (CEST)
Date: Mon, 15 Sep 2025 16:14:50 +0200
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
Message-ID: <aqu3yraxpt7h7rxjzzwvelcwvn7ehzufydhye57w6c6n2spddp@5pdsdhgfbxy5>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-24-1a247645cef5@kernel.org>
 <bh6wllwygal6hfdjbv3amgok2yxzjgmemyvzriqf2wos6b3plp@tvhvgz47mll3>
 <20250915-faken-rufen-db3c29188501@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-faken-rufen-db3c29188501@brauner>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

On Mon 15-09-25 15:54:26, Christian Brauner wrote:
> On Mon, Sep 15, 2025 at 02:11:55PM +0200, Jan Kara wrote:
> > On Fri 12-09-25 13:52:47, Christian Brauner wrote:
> > > Support the generic ns lookup infrastructure to support file handles for
> > > namespaces.
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ...
> > > @@ -200,6 +202,7 @@ static void free_user_ns(struct work_struct *work)
> > >  	do {
> > >  		struct ucounts *ucounts = ns->ucounts;
> > >  		parent = ns->parent;
> > > +		ns_tree_remove(ns);
> > >  		if (ns->gid_map.nr_extents > UID_GID_MAP_MAX_BASE_EXTENTS) {
> > >  			kfree(ns->gid_map.forward);
> > >  			kfree(ns->gid_map.reverse);
> > > @@ -218,7 +221,8 @@ static void free_user_ns(struct work_struct *work)
> > >  		retire_userns_sysctls(ns);
> > >  		key_free_user_ns(ns);
> > >  		ns_free_inum(&ns->ns);
> > > -		kmem_cache_free(user_ns_cachep, ns);
> > > +		/* Concurrent nstree traversal depends on a grace period. */
> > > +		kfree_rcu(ns, ns.ns_rcu);
> > 
> > So this is correct for now but it's a bit of a landmine. A lot of stuff
> > that ns references is kfreed before the RCU expires. Thus if you lookup ns
> > using id, then even if you're under RCU protection you have to be very
> > careful about what you can and cannot dereference. IMHO this deserves a
> > careful documentation at least or, preferably, split free_user_ns() into
> > pre and post-RCU period parts...
> 
> Right, the thing is that you cannot touch anything in any namespace
> structure without having an actual reference to it. IOW, the only thing
> that's valid under rcu is to access the reference count. That's the only
> guarantee that the _generic_ infrastructure gives _and_ expects. IOW, if
> one can get a live reference (inc_not_zero) that thing better be valid.
> 
> Individual namespace implementers may ofc provide additional guarantees
> but they are not transparent to the generic infrastructure.
> 
> Otherwise I fully agree.

I guess fair enough for this patch set so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

but longer term we might need to revisit this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

