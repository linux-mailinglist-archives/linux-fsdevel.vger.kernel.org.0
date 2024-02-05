Return-Path: <linux-fsdevel+bounces-10255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C564E849789
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 11:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D20AFB262BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 10:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD589168CD;
	Mon,  5 Feb 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0NmPUl2l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a2wU2Jsi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0NmPUl2l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a2wU2Jsi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474581429E;
	Mon,  5 Feb 2024 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127772; cv=none; b=BM6ivH4hE51g/m7xvAslLlckAtYMJQoOR+SE1oITURpMzs8u7eE/iI4sBdJspkY4UmmPb4d7CmpeMweyrEg+eoQ8HxtO0kWxQbgyN4l4QMQKizWRcfhJd/uSPw7lxdwDfV4K2IPycNbJeF9fTacOhkxSsr+QUQ2ssyLm8WEVh9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127772; c=relaxed/simple;
	bh=4lJmjeGnsuESibq4dkXn4aEwYKCDtRtnV3ik8Ze43YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IW8zLK/dEqXUJc/lg1mf/qOxSnFkPR/4uqlDhT3V+jg27qOrgVtI/41dDNg6bKA6GJWF5DwX+X6k15ma4LpMN/Lia8mnde3d7yhGkj32o4IGFXnoDrIuB6f0dOfF+uQ1MRk9yuOMYlcWe9SwYQ6poFHUI0prkZ/BPO3epYL8b8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0NmPUl2l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a2wU2Jsi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0NmPUl2l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a2wU2Jsi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68A761F8AE;
	Mon,  5 Feb 2024 10:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707127768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xeAME5NJejmJ4/yncKQREcQWWC8NXPkaZdoWiVbdd10=;
	b=0NmPUl2lfDqYVyYzOjo1vTt3dIIQb2/H6htvcRok60CBOdaultS7Li0P3XJ3uT77aKafoa
	YMG9+kq7m5jcwUWI+bZMaqMq40YBJB7V5dXvUgbAHiXUnuf1+XIy6RRS2TE7XT/poxoW2s
	lJadgenBfXH1vXms6QedkM+JMtPRpiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707127768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xeAME5NJejmJ4/yncKQREcQWWC8NXPkaZdoWiVbdd10=;
	b=a2wU2JsihZ7r0qS4ifZseKKcW3AB5l/OQWpxMAGukvELCRrEc+PcSNPdKQJs925fbWkhs9
	VswdBMoSOVOii6Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707127768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xeAME5NJejmJ4/yncKQREcQWWC8NXPkaZdoWiVbdd10=;
	b=0NmPUl2lfDqYVyYzOjo1vTt3dIIQb2/H6htvcRok60CBOdaultS7Li0P3XJ3uT77aKafoa
	YMG9+kq7m5jcwUWI+bZMaqMq40YBJB7V5dXvUgbAHiXUnuf1+XIy6RRS2TE7XT/poxoW2s
	lJadgenBfXH1vXms6QedkM+JMtPRpiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707127768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xeAME5NJejmJ4/yncKQREcQWWC8NXPkaZdoWiVbdd10=;
	b=a2wU2JsihZ7r0qS4ifZseKKcW3AB5l/OQWpxMAGukvELCRrEc+PcSNPdKQJs925fbWkhs9
	VswdBMoSOVOii6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E79E136F5;
	Mon,  5 Feb 2024 10:09:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bl8LF9izwGXGKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Feb 2024 10:09:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E5A6A0809; Mon,  5 Feb 2024 11:09:24 +0100 (CET)
Date: Mon, 5 Feb 2024 11:09:23 +0100
From: Jan Kara <jack@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/4] fs/pipe: Convert to lockdep_cmp_fn
Message-ID: <20240205100923.3vb3p247c5q2a5qe@quack3>
References: <20240127020833.487907-1-kent.overstreet@linux.dev>
 <20240127020833.487907-2-kent.overstreet@linux.dev>
 <20240202120357.tfjdri5rfd2onajl@quack3>
 <3nakly5rpn4eomhlxlzutvrisasm6yzqaccrfpnpw2lenxzfmy@vpft5f4osnye>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3nakly5rpn4eomhlxlzutvrisasm6yzqaccrfpnpw2lenxzfmy@vpft5f4osnye>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:email,linux.org.uk:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,infradead.org,gmail.com,zeniv.linux.org.uk,kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Fri 02-02-24 07:47:50, Kent Overstreet wrote:
> On Fri, Feb 02, 2024 at 01:03:57PM +0100, Jan Kara wrote:
> > On Fri 26-01-24 21:08:28, Kent Overstreet wrote:
> > > *_lock_nested() is fundamentally broken; lockdep needs to check lock
> > > ordering, but we cannot device a total ordering on an unbounded number
> > > of elements with only a few subclasses.
> > > 
> > > the replacement is to define lock ordering with a proper comparison
> > > function.
> > > 
> > > fs/pipe.c was already doing everything correctly otherwise, nothing
> > > much changes here.
> > > 
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > 
> > I had to digest for a while what this new lockdep lock ordering feature is
> > about. I have one pending question - what is the motivation of this
> > conversion of pipe code? AFAIU we don't have any problems with lockdep
> > annotations on pipe->mutex because there are always only two subclasses?
> 
> It's one of the easier conversions to do, and ideally /all/ users of
> subclasses would go away.
> 
> Start with the easier ones, figure out those patterns, then the
> harder...

I see, thanks for explanation. So in the pipes case I actually like that
the patch makes the locking less obfuscated with lockdep details (to which
I'm mostly used to but still ;)). So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

for this patch. I'm not 100% convinced it will be always possible to
replace subclasses with the new ordering mechanism but I guess time will
show.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

