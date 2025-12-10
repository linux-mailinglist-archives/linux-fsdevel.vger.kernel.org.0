Return-Path: <linux-fsdevel+bounces-71070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE09CB39D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 18:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6DE530647B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 17:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F054D327215;
	Wed, 10 Dec 2025 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xugMQ/2f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iOWmzvOu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xugMQ/2f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iOWmzvOu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C75E3271E6
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765387444; cv=none; b=qyyG1nvVXeSMjyeMVjVkeo9Nlkx9g8kQ949a5tcev4/D/PwT/2vsIw6I2TdiDct0/boWhvJxmmAytXsXmbcFVthVBcRKmYNLU7ShNoZ7DmUpH0QmUc1v6HGe761j2dJ4i4CoQmjfc/GRrh7FFxtU8U80Q5P0Z8i1Aw+1xbm+o00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765387444; c=relaxed/simple;
	bh=mTt/3hpGhqiF0biXvrM7X7jxILOa/TdZN4N8oJKaLMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrrFA1Iye9MN6DDTXwSgqzcbB7BYrNq94TkqrDXyG49R/1J+PSjCiLsXlbSaQvSUQGh9chus+q1KlkpQYjMUTwJPYRTgR3jYxGPZCbggCYy4gYN5CSrBh1rMAqQ6oK798wtB2bzkjl2VKq1aqylpgdvqhjo5bztTL3xpm/70J+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xugMQ/2f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iOWmzvOu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xugMQ/2f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iOWmzvOu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD41D5BEC9;
	Wed, 10 Dec 2025 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765387440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HYURJfcE2G4rQX35vTjWTw0Fs/pEES5m3V+030+9UE=;
	b=xugMQ/2fZiNV7FXq49Pox5dMrq+1ZVEx/n/ilifk2YCuigLgCANBNPCYuGmM2zW7j8gxoG
	8Csiy8pM9c9WNMG8RSXvYMFL6staBlC7XKgIgrYLWtAkNJFMWvWx/bGl+/nF9TMfKIpxhH
	7mB21xCnS0tuJTmkArIGwFkVY5KILS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765387440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HYURJfcE2G4rQX35vTjWTw0Fs/pEES5m3V+030+9UE=;
	b=iOWmzvOufx3E314+EM7DKBbO4xDTCcA9BIG2dzMZkqWNn3eBLUGhZpuDfSIS7qooEH7ISi
	1bejoteEVl4ErkDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765387440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HYURJfcE2G4rQX35vTjWTw0Fs/pEES5m3V+030+9UE=;
	b=xugMQ/2fZiNV7FXq49Pox5dMrq+1ZVEx/n/ilifk2YCuigLgCANBNPCYuGmM2zW7j8gxoG
	8Csiy8pM9c9WNMG8RSXvYMFL6staBlC7XKgIgrYLWtAkNJFMWvWx/bGl+/nF9TMfKIpxhH
	7mB21xCnS0tuJTmkArIGwFkVY5KILS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765387440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HYURJfcE2G4rQX35vTjWTw0Fs/pEES5m3V+030+9UE=;
	b=iOWmzvOufx3E314+EM7DKBbO4xDTCcA9BIG2dzMZkqWNn3eBLUGhZpuDfSIS7qooEH7ISi
	1bejoteEVl4ErkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C43913EA63;
	Wed, 10 Dec 2025 17:24:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3a3kL7CsOWn4DwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Dec 2025 17:24:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4F7EBA09DC; Wed, 10 Dec 2025 18:23:56 +0100 (CET)
Date: Wed, 10 Dec 2025 18:23:56 +0100
From: Jan Kara <jack@suse.cz>
To: Deepak Karn <dkarn@redhat.com>
Cc: Jan Kara <jack@suse.cz>, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Subject: Re: [PATCH v2] fs: add NULL check in drop_buffers() to prevent
 null-ptr-deref
Message-ID: <cxnggvkjf7rdlif5xzbi6megywkpbqgbley6jsh2zupmwqyiqi@lwzocbqzur5a>
References: <20251208193024.GA89444@frogsfrogsfrogs>
 <20251208201333.528909-1-dkarn@redhat.com>
 <enzq67rnekrh7gycgvgjc4g5ryt7qvuamaqj3ndpmns5svosa4@ozcepp4lpyls>
 <CAO4qAqK-6jpiFXTdpoB-e144N=Ux0Hs+NOouM6cmVDzV8V-Dcw@mail.gmail.com>
 <ujd4c2sadpu3fsux2t667ef3zz2i2nyiqvhes4ahbtpay4ba3f@unn3uh57fxdk>
 <CAO4qAqLwo+K4qFgWxs6qJ2yKvc+su=SPXS6LC7gJLgfw0aNeyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO4qAqLwo+K4qFgWxs6qJ2yKvc+su=SPXS6LC7gJLgfw0aNeyA@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[e07658f51ca22ab65b4e];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Wed 10-12-25 20:59:00, Deepak Karn wrote:
> On Wed, Dec 10, 2025 at 3:25 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 09-12-25 22:00:04, Deepak Karn wrote:
> > > On Tue, Dec 9, 2025 at 4:48 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Tue 09-12-25 01:43:33, Deepakkumar Karn wrote:
> > > > > On Mon, 8 Dec 2025 11:30:24 -0800, Darrick J. Wong wrote:
> > > > > > > drop_buffers() dereferences the buffer_head pointer returned by
> > > > > > > folio_buffers() without checking for NULL. This leads to a null pointer
> > > > > > > dereference when called from try_to_free_buffers() on a folio with no
> > > > > > > buffers attached. This happens when filemap_release_folio() is called on
> > > > > > > a folio belonging to a mapping with AS_RELEASE_ALWAYS set but without
> > > > > > > release_folio address_space operation defined. In such case,
> > > > >
> > > > > > What user is that?  All the users of AS_RELEASE_ALWAYS in 6.18 appear to
> > > > > > supply a ->release_folio.  Is this some new thing in 6.19?
> > > > >
> > > > > AFS directories SET AS_RELEASE_ALWAYS but have not .release_folio.
> > > >
> > > > AFAICS AFS sets AS_RELEASE_ALWAYS only for symlinks but not for
> > > > directories? Anyway I agree AFS symlinks will have AS_RELEASE_ALWAYS but no
> > > > .release_folio callback. And this looks like a bug in AFS because AFAICT
> > > > there's no point in setting AS_RELEASE_ALWAYS when you don't have
> > > > .release_folio callback. Added relevant people to CC.
> > > >
> > > >                                                                 Honza
> > >
> > > Thank you for your response Jan. As you suggested, the bug is in AFS.
> > > Can we include this current defensive check in drop_buffers() and I can submit
> > > another patch to handle that bug of AFS we discussed?
> >
> > I'm not strongly opposed to that (although try_to_free_buffers() would seem
> > like a tad bit better place) but overall I don't think it's a great idea as
> > it would hide bugs. But perhaps with WARN_ON_ONCE() (to catch sloppy
> > programming) it would be a sensible hardening.
> >
> 
> Thanks Jan for your response. As suggested, adding WARN_ON_ONCE() will be
> more sensible.
> I just wanted to clarify my understanding, you are suggesting adding
> WARN_ON_ONCE() in try_to_free_buffers() as this highlights the issue and
> also solves the concern. If my understanding is wrong please let me know,
> I will share the updated patch.

Yes, I meant something like:

	if (WARN_ON_ONCE(!folio_buffers(folio)))
		return true;

in try_to_free_buffers(). 

> > Also I think mapping_set_release_always() should assert that
> > mapping->a_ops->release_folio is non-NULL to catch the problem early (once
> > you fix the AFS bug).
> >
> 
> I will address this in another patch for AFS.

Thanks. As a separate patch please :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

