Return-Path: <linux-fsdevel+bounces-71201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9FCCB9796
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 18:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2125308CB47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 17:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36472F28F5;
	Fri, 12 Dec 2025 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sIfAb/p4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i8FQAv0c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sIfAb/p4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i8FQAv0c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B0926ED31
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765561653; cv=none; b=Q0VUdZNgfCKwAWXaxRWQyt/Pb8wlijpcfSSD6pPYDAV8mO6YphpM7CpQaSsbIufyv5AQSi+TWybYm9Asqhn3CL40oGP2xbcNTOfge23Zcu7vGWLHG2Bsa1HpXGe8sXHzFWH1CSG7Uhcfyz8Vc6g/dZjRelC6CerLbHn1etkQSnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765561653; c=relaxed/simple;
	bh=pHp1tKZUnIY8KWALYobGaDhHb8T3lndDTa6LcxB29Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTP1wuoSYaGcpZxOJDM0uolsBEunVPzPkxZd7Ee9IVORL+rktdaIzKtgxPnNnS85PKuVxiqugNKon8uEYTIya7CTpP3srqzEeuco6QJUYMl3U66H1VCu5eHpT1pPFU0Aucb9Z/31kKGdK/EZh9zXfyWiijIKxFy/ME99NMit8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sIfAb/p4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i8FQAv0c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sIfAb/p4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i8FQAv0c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8DF0E5BF66;
	Fri, 12 Dec 2025 17:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765561643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xm0B47SXvFdhP/mdCU4utvaKDziZRXpRGWDc4KmO5tU=;
	b=sIfAb/p4D3Wt0AuIHy9d4lz3SFq4gnO/6SFyhsTF2ygbY/Eu+3El5BBtY66KNg+Y6piL4z
	rYWZBY5/pUq8T7N0fOpeWLIqfvqt2e3OJGzzC6CfSUnFde4/QEwcX0lEFNNyJ3fCRbFooT
	oohQCd2J5rr/Xec8nt1eJiUa2yTIPdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765561643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xm0B47SXvFdhP/mdCU4utvaKDziZRXpRGWDc4KmO5tU=;
	b=i8FQAv0cWuXxk7dKE48gBkpOaAEnQfaDu/OTo34L6MeHMsWMaWjB6Y0P0voWhogAWknYjd
	/OesIp650MuRd8DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="sIfAb/p4";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=i8FQAv0c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765561643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xm0B47SXvFdhP/mdCU4utvaKDziZRXpRGWDc4KmO5tU=;
	b=sIfAb/p4D3Wt0AuIHy9d4lz3SFq4gnO/6SFyhsTF2ygbY/Eu+3El5BBtY66KNg+Y6piL4z
	rYWZBY5/pUq8T7N0fOpeWLIqfvqt2e3OJGzzC6CfSUnFde4/QEwcX0lEFNNyJ3fCRbFooT
	oohQCd2J5rr/Xec8nt1eJiUa2yTIPdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765561643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xm0B47SXvFdhP/mdCU4utvaKDziZRXpRGWDc4KmO5tU=;
	b=i8FQAv0cWuXxk7dKE48gBkpOaAEnQfaDu/OTo34L6MeHMsWMaWjB6Y0P0voWhogAWknYjd
	/OesIp650MuRd8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D2C53EA63;
	Fri, 12 Dec 2025 17:47:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NQ95HitVPGktegAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Dec 2025 17:47:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1B158A08F3; Fri, 12 Dec 2025 18:47:23 +0100 (CET)
Date: Fri, 12 Dec 2025 18:47:23 +0100
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Deepakkumar Karn <dkarn@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Liam.Howlett@oracle.com, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pagemap: Add alert to mapping_set_release_always() for
 mapping with no release_folio
Message-ID: <7pottkepdngwjiz6mi6rby67a2xpm65ulx3oflzhrv275efq3y@e64lbkl767eb>
References: <20251210200104.262523-1-dkarn@redhat.com>
 <aTnn68vLGxFxO8kv@casper.infradead.org>
 <5edukhcwwr6foo67isfum3az6ds6tcmgrifgthwtivho6ffjmw@qrxmadbaib3l>
 <aTwIAwjeSrALbVww@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTwIAwjeSrALbVww@casper.infradead.org>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 8DF0E5BF66
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Fri 12-12-25 12:18:11, Matthew Wilcox wrote:
> On Thu, Dec 11, 2025 at 10:23:13AM +0100, Jan Kara wrote:
> > On Wed 10-12-25 21:36:43, Matthew Wilcox wrote:
> > > On Thu, Dec 11, 2025 at 01:31:04AM +0530, Deepakkumar Karn wrote:
> > > >  static inline void mapping_set_release_always(struct address_space *mapping)
> > > >  {
> > > > +	/* Alert while setting the flag with no release_folio callback */
> > > 
> > > The comment is superfluous.
> > 
> > Agreed.
> > 
> > > > +	VM_WARN_ONCE(!mapping->a_ops->release_folio,
> > > > +		     "Setting AS_RELEASE_ALWAYS with no release_folio");
> > > 
> > > But you haven't said why we need to do this.  Surely the NULL pointer
> > > splat is enough to tell you that you did something stupid?
> > 
> > Well, but this will tell it much earlier and it will directly point to the
> > place were you've done the mistake (instead of having to figure out why
> > drop_buffers() is crashing on you). So I think this assert makes sense to
> > ease debugging and as kind of self-reminding documentation :).
> 
> Oh.  So the real problem here is this:
> 
>         if (mapping && mapping->a_ops->release_folio)
>                 return mapping->a_ops->release_folio(folio, gfp);
>         return try_to_free_buffers(folio);
> 
> We should have a block_release_folio(), change all the BH-based
> filesystems to add it to their aops, and then change
> filemap_release_folio() to do:
> 
> 	if (mapping)
> 		return mapping->a_ops->release_folio(folio, gfp);
> 	return true;

OK, yes, this would work for me and I agree it looks like a nice cleanup.

> (actually, can the !mapping case be hit?  surely this can't be called
> for folios which have already been truncated?)

You'd think ;). There's some usage of try_to_free_buffers() from the dark
ages predating git era in jbd2 (back then jbd) which is specifically run
when we are done with journalling buffers on a page that was truncated -
see fs/jbd2/commit.c:release_buffer_page(). Also there's an interesting
case in migrate_folio_unmap() which calls try_to_free_buffers() for a
truncated page. All the other users seem to have a valid mapping.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

