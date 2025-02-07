Return-Path: <linux-fsdevel+bounces-41160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 267CAA2BB8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 07:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F7EA7A4A0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 06:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1BC18CBFC;
	Fri,  7 Feb 2025 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dm9gYeaX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PPTBMNbK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dm9gYeaX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PPTBMNbK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB909155321;
	Fri,  7 Feb 2025 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738910078; cv=none; b=Q0nzF316BTn0wVgF/lv1xSqTpi6NAteOy3N/Zj8oplhRl3IBDxVxv7N+NwtvA0bmwvbjmnfTkRsN2I/m1KLhpfiQxhPFG07B0q0rdU/mtHQdLhZj5ACIYubVBfJ4rqIXnpBG4LMzFz1PyPqbBB/y4Q3sJrx0my5IA3WII0VV2Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738910078; c=relaxed/simple;
	bh=9zL1JCJ81HG6MYwMvRcPGSa34p9m+XY7JnkhgZLFcio=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=eeou4soX9L7IL2aLe79YiMCMP3JfCozzjMTyiJ+7PDp+Roq6E9TB6usKqxS//deaLOX76f7CFyFrM+2VNd2kZIys42XITvwHtz9uSM0T9q4SgFqFvdG1mojyfujpDBFN2s5eYdY7d/siXp7FHp/7mryz2PnLhKr3B6YIrZNksKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dm9gYeaX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PPTBMNbK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dm9gYeaX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PPTBMNbK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A72611F38D;
	Fri,  7 Feb 2025 06:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738910073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46HnAIGhPyKnbml6GeZ1Ul4m30WJZV3aL7KJwlh5X/4=;
	b=dm9gYeaX0sCzV0EI5zAqmyQo8+JOWiAwDQ/bzQ02e5ceVLPswc5u8YHt8ZqNipLBtvoTpX
	r2SMopwQ+QowwAGyLeqmv9ZSvqpCjFGSjzLJrOQs+B9JMTt6mvGxAy8c5wkDVn94gKw465
	ZRJiT9pxGaIw8a2ZpYLnZVTLrLBNDmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738910073;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46HnAIGhPyKnbml6GeZ1Ul4m30WJZV3aL7KJwlh5X/4=;
	b=PPTBMNbKghjtLgepYoiJeLmPisaIzGT/PHP/1aAF86ndNZDrS30yuepNzqikcJiySCNQp8
	ddPnemhxdv7KmZBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dm9gYeaX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PPTBMNbK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738910073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46HnAIGhPyKnbml6GeZ1Ul4m30WJZV3aL7KJwlh5X/4=;
	b=dm9gYeaX0sCzV0EI5zAqmyQo8+JOWiAwDQ/bzQ02e5ceVLPswc5u8YHt8ZqNipLBtvoTpX
	r2SMopwQ+QowwAGyLeqmv9ZSvqpCjFGSjzLJrOQs+B9JMTt6mvGxAy8c5wkDVn94gKw465
	ZRJiT9pxGaIw8a2ZpYLnZVTLrLBNDmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738910073;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46HnAIGhPyKnbml6GeZ1Ul4m30WJZV3aL7KJwlh5X/4=;
	b=PPTBMNbKghjtLgepYoiJeLmPisaIzGT/PHP/1aAF86ndNZDrS30yuepNzqikcJiySCNQp8
	ddPnemhxdv7KmZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED901139CB;
	Fri,  7 Feb 2025 06:34:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pJ8pJ3KppWdxKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 06:34:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Kent Overstreet" <kent.overstreet@linux.dev>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Steve French" <sfrench@samba.org>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Tom Talpey" <tom@talpey.com>, "Paul Moore" <paul@paul-moore.com>,
 "Eric Paris" <eparis@redhat.com>, linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH 1/2] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
In-reply-to: <7mxksfnkamzqromejfknfsat6cah4taggprj3wxdoputvvwc7f@qnjsm36bsrex>
References:
 <>, <7mxksfnkamzqromejfknfsat6cah4taggprj3wxdoputvvwc7f@qnjsm36bsrex>
Date: Fri, 07 Feb 2025 17:34:23 +1100
Message-id: <173891006340.22054.12479197204884946914@noble.neil.brown.name>
X-Rspamd-Queue-Id: A72611F38D
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 07 Feb 2025, Kent Overstreet wrote:
> On Fri, Feb 07, 2025 at 03:53:52PM +1100, NeilBrown wrote:
> > On Fri, 07 Feb 2025, Kent Overstreet wrote:
> > > On Fri, Feb 07, 2025 at 02:36:47PM +1100, NeilBrown wrote:
> > > > No callers of kern_path_locked() or user_path_locked_at() want a
> > > > negative dentry.  So change them to return -ENOENT instead.  This
> > > > simplifies callers.
> > > > 
> > > > This results in a subtle change to bcachefs in that an ioctl will now
> > > > return -ENOENT in preference to -EXDEV.  I believe this restores the
> > > > behaviour to what it was prior to
> > > 
> > > I'm not following how the code change matches the commit message?
> > 
> > Maybe it doesn't.  Let me checked.
> > 
> > Two of the possible error returns from bch2_ioctl_subvolume_destroy(),
> > which implements the BCH_IOCTL_SUBVOLUME_DESTROY ioctl, are -ENOENT and
> > -EXDEV.
> > 
> > -ENOENT is returned if the path named in arg.dst_ptr cannot be found.
> > -EXDEV is returned if the filesystem on which that path exists is not
> >  the one that the ioctl is called on.
> > 
> > If the target filesystem is "/foo" and the path given is "/bar/baz" and
> > /bar exists but /bar/baz does not, then user_path_locked_at or
> > user_path_at will return a negative dentry corresponding to the
> > (non-existent) name "baz" in /bar.
> > 
> > In this case the dentry exists so the filesystem on which it was found
> > can be tested, but the dentry is negative.  So both -ENOENT and -EXDEV
> > are credible return values.
> > 
> > 
> > - before bbe6a7c899e7 the -EXDEV is tested immediately after the call
> >   to user_path_att() so there is no chance that ENOENT will be returned.
> >   I cannot actually find where ENOENT could be returned ...  but that
> >   doesn't really matter now.
> > 
> > - after that patch .... again the -EXDEV test comes first. That isn't
> >   what I remember.  I must have misread it.
> > 
> > - after my patch user_path_locked_at() will return -ENOENT if the whole
> >   name cannot be found.  So now you get -ENOENT instead of -EXDEV.
> > 
> > So with my patch, ENOENT always wins, and it was never like that before.
> > Thanks for challenging me!
> 
> How do you always manage to be unfailingly polite? :)

My dad impressed the value of politeness on me at an early age.  It is
an effective way of manipulating people!

> 
> > 
> > Do you think there could be a problem with changing the error returned
> > in this circumstance? i.e. if you try to destroy a subvolume with a
> > non-existant name on a different filesystem could getting -ENOENT
> > instead of -EXDEV be noticed?
> 
> -EXDEV is the standard error code for "we're crossing a filesystem
> boundary and we can't or aren't supposed to be", so no, let's not change
> that.
> 

OK.  As bcachefs is the only user of user_path_locked_at() it shouldn't
be too hard.

Thanks,
NeilBrown

