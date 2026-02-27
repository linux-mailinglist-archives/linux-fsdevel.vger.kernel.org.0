Return-Path: <linux-fsdevel+bounces-78728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIDcJie3oWm+vwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:24:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 373E71B9B7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA990316764D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CACD4266A1;
	Fri, 27 Feb 2026 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2FuJYGnS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="euG43Sf6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2FuJYGnS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="euG43Sf6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA42F287247
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205372; cv=none; b=so1djEelzKYl3HOR38kQeJtfDwMQ0GOldJh9n3SeyO5L6KQ1ABeBi3ulipQ5+U5K0+LPHimuKpigs8zSNKsSYyMxVFY974dr0B4MDMME87F4KIuzrxgzz/zA7AfPQhYrlZDbWj+8jHbNSjGP+VhAiNYs+0xG9/QbwT128QzzkxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205372; c=relaxed/simple;
	bh=yHY9kiJhp8lRvMni6c7YotiQgHXml7FuUtYy2y4U+i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFmF53IXQDGt/Q1A3qFOulxI5n1bQNmyym9HPv+R4Ncldj85ImTGOHBq4N59ixz8YlcG9O3+9DAbpqiMRZAx2mCYBvkypISXzoeR13NrLXiE2E3HxFKA/u+4Qo4VJlGVth2NYnVRfJi2AX8+W0YryZYhviSLwpyHKziEoJ1kKHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2FuJYGnS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=euG43Sf6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2FuJYGnS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=euG43Sf6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 345DB5CFC1;
	Fri, 27 Feb 2026 15:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772205369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5bT/5Ey+UiP9GkCUmIfSuz5KQqLzi1KyS/67r+nhyFs=;
	b=2FuJYGnSwUJoxXJIPxzWy6iFa8O7PJR2pTuSP7UVBdgGiD9vKncPMG6CgPzCKTFxIKlzPW
	z/4CRcsr4Em7WbXSVuwoKQrQxfyPlZWl1qkH0ytj5QxrAjs/ZXbPr41RF4ER4VEvKPjU/F
	LlND7a++E9FOJhZBVXMY8PQG7sXFSqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772205369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5bT/5Ey+UiP9GkCUmIfSuz5KQqLzi1KyS/67r+nhyFs=;
	b=euG43Sf6v7MU+Xhf66zBmyXAAuu8uH+ZbLtijhXAJUpqP3U0Ki2m/xLStH40vWH2xOzVtM
	EWXK9XSHIVpFJKCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772205369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5bT/5Ey+UiP9GkCUmIfSuz5KQqLzi1KyS/67r+nhyFs=;
	b=2FuJYGnSwUJoxXJIPxzWy6iFa8O7PJR2pTuSP7UVBdgGiD9vKncPMG6CgPzCKTFxIKlzPW
	z/4CRcsr4Em7WbXSVuwoKQrQxfyPlZWl1qkH0ytj5QxrAjs/ZXbPr41RF4ER4VEvKPjU/F
	LlND7a++E9FOJhZBVXMY8PQG7sXFSqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772205369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5bT/5Ey+UiP9GkCUmIfSuz5KQqLzi1KyS/67r+nhyFs=;
	b=euG43Sf6v7MU+Xhf66zBmyXAAuu8uH+ZbLtijhXAJUpqP3U0Ki2m/xLStH40vWH2xOzVtM
	EWXK9XSHIVpFJKCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B2333EA69;
	Fri, 27 Feb 2026 15:16:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bSiECjm1oWmDHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 15:16:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EC09AA06D4; Fri, 27 Feb 2026 16:16:04 +0100 (CET)
Date: Fri, 27 Feb 2026 16:16:04 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 05/14] pidfs: adapt to rhashtable-based simple_xattrs
Message-ID: <zfwhp3c4mtf4b7gw4qmxayfqrzf4h723s2vfjpfid62yfjz2zt@6ali24hx3ihp>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-5-c2efa4f74cb7@kernel.org>
 <qxctwu77wp7gv4ua3hn6kg7r2vt57laomn3ebjisemzzaybagy@mvoo2wpvu2ux>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qxctwu77wp7gv4ua3hn6kg7r2vt57laomn3ebjisemzzaybagy@mvoo2wpvu2ux>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78728-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 373E71B9B7E
X-Rspamd-Action: no action

On Fri 27-02-26 16:09:15, Jan Kara wrote:
> On Mon 16-02-26 14:32:01, Christian Brauner wrote:
> > Adapt pidfs to use the rhashtable-based xattr path by switching from a
> > dedicated slab cache to simple_xattrs_alloc().
> > 
> > Previously pidfs used a custom kmem_cache (pidfs_xattr_cachep) that
> > allocated a struct containing an embedded simple_xattrs plus
> > simple_xattrs_init(). Replace this with simple_xattrs_alloc() which
> > combines kzalloc + rhashtable_init, and drop the dedicated slab cache
> > entirely.
> > 
> > Use simple_xattr_free_rcu() for replaced xattr entries to allow
> > concurrent RCU readers to finish.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> One question below:
> 
> > +static LLIST_HEAD(pidfs_free_list);
> > +
> > +static void pidfs_free_attr_work(struct work_struct *work)
> > +{
> > +	struct pidfs_attr *attr, *next;
> > +	struct llist_node *head;
> > +
> > +	head = llist_del_all(&pidfs_free_list);
> > +	llist_for_each_entry_safe(attr, next, head, pidfs_llist) {
> > +		struct simple_xattrs *xattrs = attr->xattrs;
> > +
> > +		if (xattrs) {
> > +			simple_xattrs_free(xattrs, NULL);
> > +			kfree(xattrs);
> > +		}
> > +		kfree(attr);
> > +	}
> > +}
> > +
> > +static DECLARE_WORK(pidfs_free_work, pidfs_free_attr_work);
> > +
> 
> So you bother with postponing the freeing to a scheduled work because
> put_pid() can be called from a context where acquiring rcu to iterate
> rhashtable would not be possible? Frankly I have hard time imagining such
> context (where previous rbtree code wouldn't have issues as well), in
> particular because AFAIR rcu is safe to arbitrarily nest. What am I
> missing?

Ah, I've now found out rhashtable_free_and_destroy() can sleep and that's
likely the reason. OK. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

