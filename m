Return-Path: <linux-fsdevel+bounces-22853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B452891DC28
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D640C1C203B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DF912C52E;
	Mon,  1 Jul 2024 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yCvQyUXA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a+lbrj8e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yCvQyUXA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a+lbrj8e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938992D03B;
	Mon,  1 Jul 2024 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828942; cv=none; b=c4PUyBL/AkqgRugyGovbHIlhodpHzr/3VMh8dEVP+zDeH28Yn1bP8aB5lr+zUS5AFWu5XWKNPOpCnwOjI8XgTLIRBOLDYJe5tRHSWecZt/ys9Do9qCpP5vjmodsKcqbMRHhGp5qUqo4zddn3fLUHOOm5/iMEc1rt/82pJr9mnwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828942; c=relaxed/simple;
	bh=U4DbQtuzQ+uMggYZUwgmOrbcZxTv1B12NqqFPf9l6bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oM+7IW4ZFrJS3xqIpPnKMLra453QOInDCQuPXocJrKsY1G++8MnidZxGvF3q+Viom8mnrOPMs3he9iHh4kCBFgO6foUYMFRL57R+Cl7DgxKWti8+9smgieNNtk5hIglwV5sma/DRlZLh4iLKX79CnBxBZBJhwEY6E5x9yewMdnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yCvQyUXA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a+lbrj8e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yCvQyUXA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a+lbrj8e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A3ABB1F828;
	Mon,  1 Jul 2024 10:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719828936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/TRMhm8+wYDdVD+A+j/RgDwMqo/Ch98fNThchTyh0Y=;
	b=yCvQyUXA5jwPRCTdBZBr277+kFFsUgxEh79yUILlsAx1D3GhsP3s8WPaBN822dI3roevx5
	zqO8dRL+ZBBOyWfWn1Ejv4mClOxi0TcDGGD96QI8J/tM1LK5liqubFAW9BmYd4OAmmkpo5
	V1hLn/IedM6dLDgrOU8OiK4p0153GZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719828936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/TRMhm8+wYDdVD+A+j/RgDwMqo/Ch98fNThchTyh0Y=;
	b=a+lbrj8eW3qqE3DwytjgzR01WBdjOhft4pwQLb4WCjGacQoXhgtWS54iHdqey+dBVv3fcX
	3BRMs6Oizmg19BAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719828936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/TRMhm8+wYDdVD+A+j/RgDwMqo/Ch98fNThchTyh0Y=;
	b=yCvQyUXA5jwPRCTdBZBr277+kFFsUgxEh79yUILlsAx1D3GhsP3s8WPaBN822dI3roevx5
	zqO8dRL+ZBBOyWfWn1Ejv4mClOxi0TcDGGD96QI8J/tM1LK5liqubFAW9BmYd4OAmmkpo5
	V1hLn/IedM6dLDgrOU8OiK4p0153GZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719828936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/TRMhm8+wYDdVD+A+j/RgDwMqo/Ch98fNThchTyh0Y=;
	b=a+lbrj8eW3qqE3DwytjgzR01WBdjOhft4pwQLb4WCjGacQoXhgtWS54iHdqey+dBVv3fcX
	3BRMs6Oizmg19BAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 951EF139C2;
	Mon,  1 Jul 2024 10:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T4cfJMiBgmZ+JAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Jul 2024 10:15:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 45BE8A088E; Mon,  1 Jul 2024 12:15:36 +0200 (CEST)
Date: Mon, 1 Jul 2024 12:15:36 +0200
From: Jan Kara <jack@suse.cz>
To: Alexander Larsson <alexl@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Ian Kent <ikent@redhat.com>,
	Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk,
	raven@themaw.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Eric Chanudet <echanude@redhat.com>
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
Message-ID: <20240701101536.jb452t25xds6x7f3@quack3>
References: <Znx-WGU5Wx6RaJyD@casper.infradead.org>
 <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
 <d1b449cb-7ff8-4953-84b9-04dd56ddb187@redhat.com>
 <20240628-gelingen-erben-0f6e14049e68@brauner>
 <CAL7ro1HtzvcuQbRpdtYAG1eK+0tekKYaTh-L_8FqHv_JrSFcZg@mail.gmail.com>
 <97cf3ef4-d2b4-4cb0-9e72-82ca42361b13@redhat.com>
 <20240701-zauber-holst-1ad7cadb02f9@brauner>
 <CAL7ro1FOYPsN3Y18tgHwpg+VB=rU1XB8Xds9P89Mh4T9N98jyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL7ro1FOYPsN3Y18tgHwpg+VB=rU1XB8Xds9P89Mh4T9N98jyA@mail.gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Mon 01-07-24 10:41:40, Alexander Larsson wrote:
> On Mon, Jul 1, 2024 at 7:50 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > > I always thought the rcu delay was to ensure concurrent path walks "see" the
> > >
> > > umount not to ensure correct operation of the following mntput()(s).
> > >
> > >
> > > Isn't the sequence of operations roughly, resolve path, lock, deatch,
> > > release
> > >
> > > lock, rcu wait, mntput() subordinate mounts, put path.
> >
> > The crucial bit is really that synchronize_rcu_expedited() ensures that
> > the final mntput() won't happen until path walk leaves RCU mode.
> >
> > This allows caller's like legitimize_mnt() which are called with only
> > the RCU read-lock during lazy path walk to simple check for
> > MNT_SYNC_UMOUNT and see that the mnt is about to be killed. If they see
> > that this mount is MNT_SYNC_UMOUNT then they know that the mount won't
> > be freed until an RCU grace period is up and so they know that they can
> > simply put the reference count they took _without having to actually
> > call mntput()_.
> >
> > Because if they did have to call mntput() they might end up shutting the
> > filesystem down instead of umount() and that will cause said EBUSY
> > errors I mentioned in my earlier mails.
> 
> But such behaviour could be kept even without an expedited RCU sync.
> Such as in my alternative patch for this:
> https://www.spinics.net/lists/linux-fsdevel/msg270117.html
> 
> I.e. we would still guarantee the final mput is called, but not block
> the return of the unmount call.

So FWIW the approach of handing off the remainder of namespace_unlock()
into rcu callback for lazy unmount looks workable to me. Just as Al Viro
pointed out you cannot do all the stuff right from the RCU callback as the
context doesn't allow all the work to happen there, so you just need to
queue work from RCU callback and then do the real work from there (but OTOH
you can avoid the task work in mnput_noexpire() in that case - will need a
bit of refactoring).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

