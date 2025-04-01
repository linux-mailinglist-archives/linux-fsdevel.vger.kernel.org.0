Return-Path: <linux-fsdevel+bounces-45466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D1FA780E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 18:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539B8188A919
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2982920E005;
	Tue,  1 Apr 2025 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eg2scSfM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f/38+Ph+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eg2scSfM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f/38+Ph+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05968F54
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526649; cv=none; b=QXoVNU5dJN5es/7zonFWUXRRSGRbysmvLoTUeaZfmTwq6A/0ziVaAc5yFEFkFZSe7CwmLIpHZtKkgj+rSh9h3VqNiOjTeUzu1z7ibdCOxahPC0vbm+cpFQpta8dwuEaVM1cHwGggzf4T53sAGxtW0cPHR9yJaokYcfU2Y4UTiJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526649; c=relaxed/simple;
	bh=MMl9sZ9TcvXoN/08mrc3Yi4oTPDGQrQlahZ4ufL1nOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRVbO6D1L27rCx0HtSZ4gXRNLLQ5eADhKnxkT1opTYXhF50tiVHo0gsf1RViSGBiMqv1wEADR8xybu4GI6k8ktO9zOv73qkZ7v2h4kGJKhk06tpNmX4LIbBbuzhghv9ZJi0m4wTOYU3cLaiCasgm4l/UQOMdekt4ZnWh6JG565s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eg2scSfM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f/38+Ph+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eg2scSfM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f/38+Ph+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B31D21F38E;
	Tue,  1 Apr 2025 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743526644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayzTNmVENLwndkYJft8i/VMZKbCBHIAmAoLlfoj6JYQ=;
	b=Eg2scSfMkFYdEHN/N6BO31Bxw8Nyj6glw0IFjcvw2GZ9uUMVpht84e/YTzbYtPr5bAbRg7
	hy9N6si804sZxJsKGuBmKcUXMdcSrAPg+/jcg+rPCkojPjYrLvIy7I/sbFAbTT0QQfvYZ+
	mdADexIvOZkjr3V2H67BUc85A+/QuOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743526644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayzTNmVENLwndkYJft8i/VMZKbCBHIAmAoLlfoj6JYQ=;
	b=f/38+Ph+vbt+nvyT2hsUhChjs1hfvfza0Cn9YulLycc7GgeScyh+Ue+5qcxnpwOdvKrrgc
	i6ZAhTIQJxee8ZBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Eg2scSfM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="f/38+Ph+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743526644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayzTNmVENLwndkYJft8i/VMZKbCBHIAmAoLlfoj6JYQ=;
	b=Eg2scSfMkFYdEHN/N6BO31Bxw8Nyj6glw0IFjcvw2GZ9uUMVpht84e/YTzbYtPr5bAbRg7
	hy9N6si804sZxJsKGuBmKcUXMdcSrAPg+/jcg+rPCkojPjYrLvIy7I/sbFAbTT0QQfvYZ+
	mdADexIvOZkjr3V2H67BUc85A+/QuOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743526644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayzTNmVENLwndkYJft8i/VMZKbCBHIAmAoLlfoj6JYQ=;
	b=f/38+Ph+vbt+nvyT2hsUhChjs1hfvfza0Cn9YulLycc7GgeScyh+Ue+5qcxnpwOdvKrrgc
	i6ZAhTIQJxee8ZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41FB113691;
	Tue,  1 Apr 2025 16:57:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nIzQD/Qa7GdDFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Apr 2025 16:57:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 167F3A07E6; Tue,  1 Apr 2025 18:57:19 +0200 (CEST)
Date: Tue, 1 Apr 2025 18:57:19 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	rafael@kernel.org, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, djwong@kernel.org, 
	pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
	boqun.feng@gmail.com
Subject: Re: [PATCH 0/6] power: wire-up filesystem freeze/thaw with
 suspend/resume
Message-ID: <5tiim72iyudzgmjbyvavfumprrifydt2mfb3h3wycsnqybek23@2ftdyt47yhyl>
References: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
 <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
 <s6rnz3ysjlu3rp6m56vua3vnlj53hbgxbbe3nj7v2ib5fg4l2i@py4pkvsgk2lr>
 <20250401-kindisch-lagen-cd19c8f66103@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401-kindisch-lagen-cd19c8f66103@brauner>
X-Rspamd-Queue-Id: B31D21F38E
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
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
	RCPT_COUNT_TWELVE(0.00)[17];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,kernel.org,hansenpartnership.com,infradead.org,fromorbit.com,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Tue 01-04-25 15:03:33, Christian Brauner wrote:
> On Tue, Apr 01, 2025 at 11:32:49AM +0200, Jan Kara wrote:
> > On Tue 01-04-25 02:32:45, Christian Brauner wrote:
> > > The whole shebang can also be found at:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.freeze
> > > 
> > > I know nothing about power or hibernation. I've tested it as best as I
> > > could. Works for me (TM).
> > > 
> > > I need to catch some actual sleep now...
> > > 
> > > ---
> > > 
> > > Now all the pieces are in place to actually allow the power subsystem to
> > > freeze/thaw filesystems during suspend/resume. Filesystems are only
> > > frozen and thawed if the power subsystem does actually own the freeze.
> > > 
> > > Othwerwise it risks thawing filesystems it didn't own. This could be
> > > done differently be e.g., keeping the filesystems that were actually
> > > frozen on a list and then unfreezing them from that list. This is
> > > disgustingly unclean though and reeks of an ugly hack.
> > > 
> > > If the filesystem is already frozen by the time we've frozen all
> > > userspace processes we don't care to freeze it again. That's userspace's
> > > job once the process resumes. We only actually freeze filesystems if we
> > > absolutely have to and we ignore other failures to freeze.
> > 
> > Hum, I don't follow here. I supposed we'll use FREEZE_MAY_NEST |
> > FREEZE_HOLDER_KERNEL for freezing from power subsystem. As far as I
> > remember we have specifically designed nesting of freeze counters so that
> > this way power subsystem can be sure freezing succeeds even if the
> > filesystem is already frozen (by userspace or the kernel) and similarly
> > power subsystem cannot thaw a filesystem frozen by somebody else. It will
> > just drop its freeze refcount... What am I missing?
> 
> If we have 10 filesystems and suspend/hibernate manges to freeze 5 and
> then fails on the 6th for whatever odd reason (current or future) then
> power needs to undo the freeze of the first 5 filesystems. We can't just
> walk the list again because while it's unlikely that a new filesystem
> got added in the meantime we still cannot tell what filesystems the
> power subsystem actually managed to get a freeze reference count on that
> we need to drop during thaw.
> 
> There's various ways out of this ugliness. Either we record the
> filesystems the power subsystem managed to freeze on a temporary list in
> the callbacks and then walk that list backwards during thaw to undo the
> freezing or we make sure that the power subsystem just actually
> exclusively freezes things it can freeze and marking such filesystems as
> being owned by power for the duration of the suspend or resume cycle. I
> opted for the latter as that seemed the clean thing to do even if it
> means more code changes. What are your thoughts on this?

Ah, I see. Thanks for explanation. So failure to freeze filesystem should
be rare (mostly only due to IO errors or similar serious issues) hence
I'd consider failing hibernation in case we fail to freeze some filesystem
appropriate. The function that's walking all superblocks and freezing them
could just walk from the superblock where freezing failed towards the end
and thaw all filesystems. That way the function also has the nice property
that it either freezes everything or keeps things as they were.

But you've touched on an interesting case I didn't consider: New
superblocks can be added to the end of the list while we are walking it.
These superblocks will not be frozen and on resume (or error recovery) this
will confuse things. Your "freeze owner" stuff deals with this problem
nicely. Somewhat lighter fix for this may be to provide the superblock to
start from / end with to these loops iterating and freezing / thawing
superblocks. It doesn't seem too hacky but if you prefer your freeze owner
approach I won't object.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

