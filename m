Return-Path: <linux-fsdevel+bounces-25445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FF194C367
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 19:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4DE1F22DAF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD820190684;
	Thu,  8 Aug 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dFnXEJHT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cVmzgLsC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dFnXEJHT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cVmzgLsC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD1382C7E;
	Thu,  8 Aug 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137095; cv=none; b=isbZMG0RPNks1BiJnu3XcF30BcYtuolHVW/aoxu/IuHi8VtqRvRSOx9acRNeyUFka1GgpIkMR4inPz/kaxOcFcQZlBCtryqD8gWDZZjD7Q87Z3cwG0Ocr248jp7vj7jo9AVpOoxY2hfe9u3DIPPE7NvqV/ETf4aKgIeFspwqmYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137095; c=relaxed/simple;
	bh=+T3bznHcwl2sKilN3Rsk+DfoLt8TfQPY+ISGsMgYDh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8r7tIAqFDDpqXVcmAL4Wr37wO/JqcuO7cHZKpxASc/rnQAAu3AEKZRqkonLkPDVSaUgflqdj942ZeQWkLxF37/Ek9QBnCBrvzwVCER1xWIdOys6FmNNXfD+NMglDDI4UuKMePxXnQNO3LVxA+R6LTGjtOL19aPDlbx9SyyePP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dFnXEJHT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cVmzgLsC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dFnXEJHT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cVmzgLsC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 23ED921D67;
	Thu,  8 Aug 2024 17:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723137091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5KTl0zSOhEJ1SLkg5NmIdRLgqbBvRlP3mDGSRHB+0k=;
	b=dFnXEJHTMfpNYIgxAQsbpZmail4sTGUCTpwSHbU9tEw3uDnx7AffsMpIC+v+1a0CEvXTWA
	d28+ZwDBhojLYle4HliUFcZmJjbH/yYkapQwtT6yaIxrieRWrdeXN0RX1c/+hvVUs6j193
	TF9ZbkS1nCyZvLKGWgy32bjc9yKlIso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723137091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5KTl0zSOhEJ1SLkg5NmIdRLgqbBvRlP3mDGSRHB+0k=;
	b=cVmzgLsCC9zEemztN6gWR1Fw2f5/Bghwif7nD3DqqEOiBtqQO8knrP2KeAYWR+g2gB3krj
	Cd7CjBhHfLABhJAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dFnXEJHT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cVmzgLsC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723137091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5KTl0zSOhEJ1SLkg5NmIdRLgqbBvRlP3mDGSRHB+0k=;
	b=dFnXEJHTMfpNYIgxAQsbpZmail4sTGUCTpwSHbU9tEw3uDnx7AffsMpIC+v+1a0CEvXTWA
	d28+ZwDBhojLYle4HliUFcZmJjbH/yYkapQwtT6yaIxrieRWrdeXN0RX1c/+hvVUs6j193
	TF9ZbkS1nCyZvLKGWgy32bjc9yKlIso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723137091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5KTl0zSOhEJ1SLkg5NmIdRLgqbBvRlP3mDGSRHB+0k=;
	b=cVmzgLsCC9zEemztN6gWR1Fw2f5/Bghwif7nD3DqqEOiBtqQO8knrP2KeAYWR+g2gB3krj
	Cd7CjBhHfLABhJAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1516813876;
	Thu,  8 Aug 2024 17:11:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d84eBUP8tGblOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Aug 2024 17:11:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B2D4FA0851; Thu,  8 Aug 2024 19:11:30 +0200 (CEST)
Date: Thu, 8 Aug 2024 19:11:30 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	audit@vger.kernel.org
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
Message-ID: <20240808171130.5alxaa5qz3br6cde@quack3>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <20240807-erledigen-antworten-6219caebedc0@brauner>
 <d682e7c2749f8e8c74ea43b8893a17bd6e9a0007.camel@kernel.org>
 <20240808-karnickel-miteinander-d4fa6cd5f3c7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808-karnickel-miteinander-d4fa6cd5f3c7@brauner>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,linux-foundation.org,gmail.com,toxicpanda.com,vger.kernel.org,paul-moore.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: 23ED921D67

On Thu 08-08-24 12:36:07, Christian Brauner wrote:
> On Wed, Aug 07, 2024 at 10:36:58AM GMT, Jeff Layton wrote:
> > On Wed, 2024-08-07 at 16:26 +0200, Christian Brauner wrote:
> > > > +static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
> > > > +{
> > > > +	struct dentry *dentry;
> > > > +
> > > > +	if (open_flag & O_CREAT) {
> > > > +		/* Don't bother on an O_EXCL create */
> > > > +		if (open_flag & O_EXCL)
> > > > +			return NULL;
> > > > +
> > > > +		/*
> > > > +		 * FIXME: If auditing is enabled, then we'll have to unlazy to
> > > > +		 * use the dentry. For now, don't do this, since it shifts
> > > > +		 * contention from parent's i_rwsem to its d_lockref spinlock.
> > > > +		 * Reconsider this once dentry refcounting handles heavy
> > > > +		 * contention better.
> > > > +		 */
> > > > +		if ((nd->flags & LOOKUP_RCU) && !audit_dummy_context())
> > > > +			return NULL;
> > > 
> > > Hm, the audit_inode() on the parent is done independent of whether the
> > > file was actually created or not. But the audit_inode() on the file
> > > itself is only done when it was actually created. Imho, there's no need
> > > to do audit_inode() on the parent when we immediately find that file
> > > already existed. If we accept that then this makes the change a lot
> > > simpler.
> > > 
> > > The inconsistency would partially remain though. When the file doesn't
> > > exist audit_inode() on the parent is called but by the time we've
> > > grabbed the inode lock someone else might already have created the file
> > > and then again we wouldn't audit_inode() on the file but we would have
> > > on the parent.
> > > 
> > > I think that's fine. But if that's bothersome the more aggressive thing
> > > to do would be to pull that audit_inode() on the parent further down
> > > after we created the file. Imho, that should be fine?...
> > > 
> > > See https://gitlab.com/brauner/linux/-/commits/vfs.misc.jeff/?ref_type=heads
> > > for a completely untested draft of what I mean.
> > 
> > Yeah, that's a lot simpler. That said, my experience when I've worked
> > with audit in the past is that people who are using it are _very_
> > sensitive to changes of when records get emitted or not. I don't like
> > this, because I think the rules here are ad-hoc and somewhat arbitrary,
> > but keeping everything working exactly the same has been my MO whenever
> > I have to work in there.
> > 
> > If a certain access pattern suddenly generates a different set of
> > records (or some are missing, as would be in this case), we might get
> > bug reports about this. I'm ok with simplifying this code in the way
> > you suggest, but we may want to do it in a patch on top of mine, to
> > make it simple to revert later if that becomes necessary.
> 
> Fwiw, even with the rearranged checks in v3 of the patch audit records
> will be dropped because we may find a positive dentry but the path may
> have trailing slashes. At that point we just return without audit
> whereas before we always would've done that audit.
> 
> Honestly, we should move that audit event as right now it's just really
> weird and see if that works. Otherwise the change is somewhat horrible
> complicating the already convoluted logic even more.
> 
> So I'm appending the patches that I have on top of your patch in
> vfs.misc. Can you (other as well ofc) take a look and tell me whether
> that's not breaking anything completely other than later audit events?

The changes look good as far as I'm concerned but let me CC audit guys if
they have some thoughts regarding the change in generating audit event for
the parent. Paul, does it matter if open(O_CREAT) doesn't generate audit
event for the parent when we are failing open due to trailing slashes in
the pathname? Essentially we are speaking about moving:

	audit_inode(nd->name, dir, AUDIT_INODE_PARENT);

from open_last_lookups() into lookup_open().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

