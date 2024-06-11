Return-Path: <linux-fsdevel+bounces-21429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB34E903A91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 13:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481AE2820BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 11:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8C417C23B;
	Tue, 11 Jun 2024 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KIRuJDWc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W2Czjrfv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a2XAqvI9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WfrglvM2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E813717B4F9;
	Tue, 11 Jun 2024 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106014; cv=none; b=PsuJNjdW040F9AkQ+/Spi2dY+GNmxqkpzD2tYM3iziO/wmx/r/DB9ISZ5L8CBKfFZr3M8NezG7JvevIHYvHKOle3H/px+oXfxhD0R9rDbpTHPl2sTVFRh3m4ttgGytYUjjuaO51ltLX+UOuKAa7GeODH+bjgSrA4YdWdihZMhnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106014; c=relaxed/simple;
	bh=2iEWoOFwjNB/5le8qLnLO2p7knyI+HsxMB0pfPnUwpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1KJSCRcQGBz6YJoMqhO7VxfcoADUCelDQaLse/O7oJVicZZFRs33tJxp7R09pXn9GiTPIH6qeY6vuMC6Ocw8RX1kDLtN2yBj7uo4QPPZHhSldZqWSSrhdgJvw0fqkW4EOOToohrMcM6Rttk8A0tIhxbS28V7BfFOVhHSD+AE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KIRuJDWc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W2Czjrfv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a2XAqvI9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WfrglvM2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D27B63372D;
	Tue, 11 Jun 2024 11:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718106011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VuNdVP+FE8Ffp4//nCAFUw0S3DEwFjW+72zNAQF/tLI=;
	b=KIRuJDWcwRSMre8IPCVsgCLpMA4iemriNkNGcH0rXEZdbGIbjOMG06jhMqXrI7LHgjQn8+
	9WGCh81IAGwWwAQgDT71Bsmr/AF5Nuo+zqCpVDBcMmzp9SB2Vqf24ouZFIlf4ozLMH0AEl
	bBXZqkeDw2Oq/rSjXoBkWoGexWUeCTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718106011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VuNdVP+FE8Ffp4//nCAFUw0S3DEwFjW+72zNAQF/tLI=;
	b=W2Czjrfv6JWDdnqdNLv3RKyACI0JgSgmxtE3ttmD9XiPGOcEx+XflKRsMBi+O2ufjr8XK5
	2+ZGvrYsqI5o9lCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a2XAqvI9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WfrglvM2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718106010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VuNdVP+FE8Ffp4//nCAFUw0S3DEwFjW+72zNAQF/tLI=;
	b=a2XAqvI9BR4ZfPmi6rdVQ2W1OagsobpGWZbrEkqPlefvmcscrPTVWDg46CieR4NtpJ+Zr6
	sv2syeRUO0ptAddgOgyRMa+BocLGhhBRISiKLL61vUxcX+nlv/n4tZnXyOTrgUdmwHaeTc
	JCSqzQRQNlTGhYBVnE6a5jp4sFcRpww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718106010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VuNdVP+FE8Ffp4//nCAFUw0S3DEwFjW+72zNAQF/tLI=;
	b=WfrglvM2iMHmniAf4NUpxZxoMPETFH6D7BcHhNmxiAXQAOaPcfuFUwEybFX508PHEWAw+/
	QDRHV0+oVGwa8UBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7F4A13A55;
	Tue, 11 Jun 2024 11:40:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RrrKMJo3aGaEHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Jun 2024 11:40:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 688DFA0886; Tue, 11 Jun 2024 13:40:06 +0200 (CEST)
Date: Tue, 11 Jun 2024 13:40:06 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
	brauner@kernel.org, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: partially sanitize i_state zeroing on inode creation
Message-ID: <20240611114006.swwo2o7cldvp2wyy@quack3>
References: <20240611041540.495840-1-mjguzik@gmail.com>
 <20240611100222.htl43626sklgso5p@quack3>
 <kge4tzrxi2nxz7zg3j2qxgvnf4fcaywtlckgsc7d52eubvzmj4@zwmwknndha5y>
 <ZmgtaGglOL33Wkzr@dread.disaster.area>
 <q5xcdmugfoccgu2cs5n7ku6asyaslunm2tty6r757cc2jkqjnm@g6cl4rayvxcq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q5xcdmugfoccgu2cs5n7ku6asyaslunm2tty6r757cc2jkqjnm@g6cl4rayvxcq>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D27B63372D
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]

On Tue 11-06-24 13:26:45, Mateusz Guzik wrote:
> On Tue, Jun 11, 2024 at 08:56:40PM +1000, Dave Chinner wrote:
> > On Tue, Jun 11, 2024 at 12:23:59PM +0200, Mateusz Guzik wrote:
> > > I did not patch inode_init_always because it is exported and xfs uses it
> > > in 2 spots, only one of which zeroing the thing immediately after.
> > > Another one is a little more involved, it probably would not be a
> > > problem as the value is set altered later anyway, but I don't want to
> > > mess with semantics of the func if it can be easily avoided.
> > 
> > Better to move the zeroing to inode_init_always(), do the basic
> > save/restore mod to xfs_reinit_inode(), and let us XFS people worry
> > about whether inode_init_always() is the right thing to be calling
> > in their code...
> > 
> > All you'd need to do in xfs_reinit_inode() is this
> > 
> > +	unsigned long	state = inode->i_state;
> > 
> > 	.....
> > 	error = inode_init_always(mp->m_super, inode);
> > 	.....
> > +	inode->i_state = state;
> > 	.....
> > 
> > And it should behave as expected.
> > 
> 
> Ok, so what would be the logistics of submitting this?
> 
> Can I submit one patch which includes the above + i_state moved to
> inode_init_always?
> 
> Do I instead ship a two-part patchset, starting with the xfs change and
> stating it was your idea?
> 
> Something else?

Well, I'd do it as 4 patches actually:

1) xfs i_state workaround in xfs_reinit_inode()
2) add i_state zeroing to inode_init_always(), drop pointless zeroing from
VFS.
3) drop now pointless zeroing from xfs
4) drop now pointless zeroing from bcachefs

This way also respective maintainers can easily ack the bits they care about.
I can live with two as you suggest since the changes are tiny but four is
IMHO a "proper" way to do things ;).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

