Return-Path: <linux-fsdevel+bounces-71092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E63FCB5538
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 10:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24A81300941E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 09:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498B72F12C7;
	Thu, 11 Dec 2025 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IP7T9IPj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tt/2V+hg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QFTwSK7P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hTvjh1fT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E223B233136
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765444559; cv=none; b=GcDk6lJPdLqNNCehEJ+XDMHjkFnRiW5TeH4+Zv9RR0t9bHFVzUyaC77eKNBp1MTzxJv072xEvSZemxnZIwnC22rP/GJvZmW+Ccq49NMTDvemjrm5XQhP7ScrdU/NwaLsg1yPne+9vk+O34//cJ10F7hzmwOrzqQLkN+xou7FV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765444559; c=relaxed/simple;
	bh=uTiPIene30O0WymqvU9cpZWbTETMqWZ2zrMNaV5Udpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnzeNzLLaaIcHJKt2JxWhQTLkDoIJgcthJu1JaPJ/g08OvYmDg91HuSr/1mi8zsvnp/79lQoBh2quWVtgQImvaKxZQgw8uTW//ak8qujdivBsdsqzdZk7rsBuBLftRlCyHY0gPaYtEe7XdrVuu9A7AXomp106Twzg0bNJL9g3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IP7T9IPj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tt/2V+hg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QFTwSK7P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hTvjh1fT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF0593397A;
	Thu, 11 Dec 2025 09:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765444556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yMIi79K2zhdoEqivpyiK2ugTVjLRw1deMrmMoGUva88=;
	b=IP7T9IPj7Bn+aimBWoyhesJk2NMyg4GOjRX4xdHaeUcifBRJGAYYY2PeGkncIeidPJZMD+
	oRu3+XGv3+3xeiUPjSnJSHoGYB/ZP28OHxyi69ROJVIeNHEMr9qOA4M5/TXc28ZKRVWTU+
	lXfNNV6WcD8CRp8Fl+8cxYUtpotOJUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765444556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yMIi79K2zhdoEqivpyiK2ugTVjLRw1deMrmMoGUva88=;
	b=Tt/2V+hgRD/l8yRKG+pxnkhedwnaKEza5081la+rw3Ec8sI/QbA5IyoMxfQ4Smfcs2qY/W
	z7DmX1tJuA71iNAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QFTwSK7P;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hTvjh1fT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765444554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yMIi79K2zhdoEqivpyiK2ugTVjLRw1deMrmMoGUva88=;
	b=QFTwSK7PM7Z/ZJe0MOAdTdJsJvmoNn03n3p0hBOTySiFyBVp8LwVOCKvYhZEDCpPW1AQGj
	uCqOcnAmSzPN7caeV+jekY91aFaj5MoNqGHb3phS3cJ6KzaRzMZgAC1nuQD6ty7IMXuoNM
	gWzlRxkXFqV7yOqnkAcN3hpV138f2f4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765444554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yMIi79K2zhdoEqivpyiK2ugTVjLRw1deMrmMoGUva88=;
	b=hTvjh1fTA5sYalthxoOYCi9QGAKxi+LEaCwdo0t1sZRf2TRNeUoZd02YZmmkUT06bkKwk+
	OfwNvoF6FgelMmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7F563EA63;
	Thu, 11 Dec 2025 09:15:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uNjoLMqLOmnIbwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Dec 2025 09:15:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 65E17A0A04; Thu, 11 Dec 2025 10:15:54 +0100 (CET)
Date: Thu, 11 Dec 2025 10:15:54 +0100
From: Jan Kara <jack@suse.cz>
To: Deepak Karn <dkarn@redhat.com>
Cc: Jan Kara <jack@suse.cz>, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Subject: Re: [PATCH v2] fs: add NULL check in drop_buffers() to prevent
 null-ptr-deref
Message-ID: <nydy7jjlfh3komccku32keyyr7mr22j735toad6swucslycyci@rcc5f6vzufvc>
References: <20251208193024.GA89444@frogsfrogsfrogs>
 <20251208201333.528909-1-dkarn@redhat.com>
 <enzq67rnekrh7gycgvgjc4g5ryt7qvuamaqj3ndpmns5svosa4@ozcepp4lpyls>
 <CAO4qAqK-6jpiFXTdpoB-e144N=Ux0Hs+NOouM6cmVDzV8V-Dcw@mail.gmail.com>
 <ujd4c2sadpu3fsux2t667ef3zz2i2nyiqvhes4ahbtpay4ba3f@unn3uh57fxdk>
 <CAO4qAqLwo+K4qFgWxs6qJ2yKvc+su=SPXS6LC7gJLgfw0aNeyA@mail.gmail.com>
 <cxnggvkjf7rdlif5xzbi6megywkpbqgbley6jsh2zupmwqyiqi@lwzocbqzur5a>
 <CAO4qAq+YJwTgmU=QjAhfxqpKsXJ1sjSz+pniWdW8Yr9zeLGePg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO4qAq+YJwTgmU=QjAhfxqpKsXJ1sjSz+pniWdW8Yr9zeLGePg@mail.gmail.com>
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
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[e07658f51ca22ab65b4e];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: CF0593397A
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Wed 10-12-25 23:20:23, Deepak Karn wrote:
> On Wed, Dec 10, 2025 at 10:54 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 10-12-25 20:59:00, Deepak Karn wrote:
> > > On Wed, Dec 10, 2025 at 3:25 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Tue 09-12-25 22:00:04, Deepak Karn wrote:
> > > > > On Tue, Dec 9, 2025 at 4:48 PM Jan Kara <jack@suse.cz> wrote:
> > > > > >
> > > > > > On Tue 09-12-25 01:43:33, Deepakkumar Karn wrote:
> > > > > > > On Mon, 8 Dec 2025 11:30:24 -0800, Darrick J. Wong wrote:
> > > > > > > > > drop_buffers() dereferences the buffer_head pointer returned by
> > > > > > > > > folio_buffers() without checking for NULL. This leads to a null pointer
> > > > > > > > > dereference when called from try_to_free_buffers() on a folio with no
> > > > > > > > > buffers attached. This happens when filemap_release_folio() is called on
> > > > > > > > > a folio belonging to a mapping with AS_RELEASE_ALWAYS set but without
> > > > > > > > > release_folio address_space operation defined. In such case,
> > > > > > >
> > > > > > > > What user is that?  All the users of AS_RELEASE_ALWAYS in 6.18 appear to
> > > > > > > > supply a ->release_folio.  Is this some new thing in 6.19?
> > > > > > >
> > > > > > > AFS directories SET AS_RELEASE_ALWAYS but have not .release_folio.
> > > > > >
> > > > > > AFAICS AFS sets AS_RELEASE_ALWAYS only for symlinks but not for
> > > > > > directories? Anyway I agree AFS symlinks will have AS_RELEASE_ALWAYS but no
> > > > > > .release_folio callback. And this looks like a bug in AFS because AFAICT
> > > > > > there's no point in setting AS_RELEASE_ALWAYS when you don't have
> > > > > > .release_folio callback. Added relevant people to CC.
> > > > > >
> > > > > >                                                                 Honza
> > > > >
> > > > > Thank you for your response Jan. As you suggested, the bug is in AFS.
> > > > > Can we include this current defensive check in drop_buffers() and I can submit
> > > > > another patch to handle that bug of AFS we discussed?
> > > >
> > > > I'm not strongly opposed to that (although try_to_free_buffers() would seem
> > > > like a tad bit better place) but overall I don't think it's a great idea as
> > > > it would hide bugs. But perhaps with WARN_ON_ONCE() (to catch sloppy
> > > > programming) it would be a sensible hardening.
> > > >
> > >
> > > Thanks Jan for your response. As suggested, adding WARN_ON_ONCE() will be
> > > more sensible.
> > > I just wanted to clarify my understanding, you are suggesting adding
> > > WARN_ON_ONCE() in try_to_free_buffers() as this highlights the issue and
> > > also solves the concern. If my understanding is wrong please let me know,
> > > I will share the updated patch.
> >
> > Yes, I meant something like:
> >
> >         if (WARN_ON_ONCE(!folio_buffers(folio)))
> >                 return true;
> >
> > in try_to_free_buffers().
> >
> 
> Yes this is what I am also going for, just a minor change that I was
> going to return false.
> 
> Reason:
> From the flow it should return false whenever failed to free buffers /
> operation couldn't complete. Do you think otherwise.

Well, it's rather we should return false when the page cannot be freed
because we were unable to free the buffers. When folio_buffers() are NULL,
the page *can* be freed so we should be returning true in that case.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

