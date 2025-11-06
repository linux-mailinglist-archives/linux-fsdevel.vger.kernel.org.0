Return-Path: <linux-fsdevel+bounces-67277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54575C3A384
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 11:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3C14278F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 10:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED1330CDB7;
	Thu,  6 Nov 2025 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oj6PZ1XT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5M8BwnlH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nx0DTY83";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9bQMqnV0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CE2E11D7
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424031; cv=none; b=anio77s/3ANNzV2xsKuIsg4UhX2NaLjv2nAFjitFKDUPcS6094GLYTgXkZ3OIlZYRrM8pJVDGD7/9v23zMxfo36yjxcARk1HOtqQG88U9r/VGbWVihDxEZO8gKmCq0YOy1EFu09YQqbbbJAVdImGWNtxEmJnrx2RHq0oSGaGBpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424031; c=relaxed/simple;
	bh=2Dqgj3ARMAZloy2d+yx/6Dy8TnZquGzcUD0JkFUNwII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PX0ouTzSDXMjUlYeT2QH1RWIbIUdnOxixXnx7bWZ50SAp3g6cyi8UnVYYFxme7tqz8jIxIWiF+gUDP5AuFSXfFGhrYmQGPPBjIRLF/U8oJTxJJz24iYf8M3s5OHc1Y3FQ1wIitRQLJcIwl6pu924xHNjzzFhTouLukIg8/FiFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oj6PZ1XT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5M8BwnlH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nx0DTY83; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9bQMqnV0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 61EE3211D5;
	Thu,  6 Nov 2025 10:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762424027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U0qet8K6rw8ALVRCEQwaBHLS2xzMNx2BB/UQa7MLpbs=;
	b=Oj6PZ1XTq4UzibZQTggjGDCDIdQUUr3p4bKVGq3KeiY+gJyO00L7dqKgzfjgu0crbD8/ri
	3NZ1ZQLZ7O3ZBf2OXPZATSRhnbzvrGaEFq2t/ie7uS78hS25ltqjzSZAeP5/wHZduHs9PY
	SG+Ri+XJ/LcmcVgbd51R/FYTzVq9L6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762424027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U0qet8K6rw8ALVRCEQwaBHLS2xzMNx2BB/UQa7MLpbs=;
	b=5M8BwnlHLndGMvwDk5mpe+Rt9KkB9G7slMuZd7+5+qzD6IZNwhaT+PM1Z8GgpwJSZM7CJt
	7M6W4Mp2I3FLwlCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Nx0DTY83;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9bQMqnV0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762424026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U0qet8K6rw8ALVRCEQwaBHLS2xzMNx2BB/UQa7MLpbs=;
	b=Nx0DTY839ZnecFDxZZ79zBc2DMcKWlosUysgEy0IHbFg1EEN6S92aap4/8fga/JpdJkRq7
	HPopxbu1UFIvChYFGc1MPtnXgabWAUo1Fb1sAduhamMlnxfaXc9Uf3Pkf+Tv63Z9psldT8
	5GfclCnqcvTghtR422vYNbQ1QGNUdmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762424026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U0qet8K6rw8ALVRCEQwaBHLS2xzMNx2BB/UQa7MLpbs=;
	b=9bQMqnV04NrR5LKNKTBGCaW47u4LnmUt2oKcRRiP0yw1XKo872G2Es/4kU/uebx2XCW2GB
	lB6vClfsKg7yt6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 496F813A31;
	Thu,  6 Nov 2025 10:13:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kCOaEdp0DGluQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Nov 2025 10:13:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CDE27A0948; Thu,  6 Nov 2025 11:13:45 +0100 (CET)
Date: Thu, 6 Nov 2025 11:13:45 +0100
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	cem@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, gabriel@krisman.be, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/6] iomap: report file IO errors to fsnotify
Message-ID: <flgcbd3bzaa6sdlnspub7htwyengcuuadbcws32edns7z5fpgr@kyjoo4tf7qyf>
References: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
 <176230366453.1647991.17002688390201603817.stgit@frogsfrogsfrogs>
 <ewqcnrecsvpi5wy3mufy3swnf46ejnz4kc5ph2eb4iriftdddi@mamiprlrvi75>
 <CAOQ4uxhfrHNk+b=BW5o7We=jC7ob4JbuL4vQz8QhUKD0VaRP=A@mail.gmail.com>
 <g2xevmkixxjturg47qv4gokvxvbah275z5slweehj2pvesl3zs@ordfml4v7gaa>
 <20251105182808.GC196370@frogsfrogsfrogs>
 <20251105194138.GK196362@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105194138.GK196362@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 61EE3211D5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,kernel.org,lst.de,vger.kernel.org,krisman.be];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Wed 05-11-25 11:41:38, Darrick J. Wong wrote:
> On Wed, Nov 05, 2025 at 10:28:08AM -0800, Darrick J. Wong wrote:
> > On Wed, Nov 05, 2025 at 03:24:41PM +0100, Jan Kara wrote:
> > > On Wed 05-11-25 12:14:52, Amir Goldstein wrote:
> > > > 
> > > > ...
> > > > We recently discovered that fsnotify_sb_error() calls are exposed to
> > > > races with generic_shutdown_super():
> > > > https://lore.kernel.org/linux-fsdevel/scmyycf2trich22v25s6gpe3ib6ejawflwf76znxg7sedqablp@ejfycd34xvpa/
> > 
> > Hrmm.  I've noticed that ever since I added this new patchset, I've been
> > getting more instances of outright crashes in the timer code, or
> > workqueue lockups.  I wonder if that UAF is what's going on here...
> > 
> > > > Will punting all FS_ERROR events to workqueue help to improve this
> > > > situation or will it make it worse?
> > > 
> > > Worse. But you raise a really good point which I've missed during my
> > > review. Currently there's nothing which synchronizes pending works with
> > > superblock getting destroyed with obvious UAF issues already in
> > > handle_sb_error().
> > 
> > I wonder, could __sb_error call get_active_super() to obtain an active
> > reference to the sb, and then deactivate_super() it in the workqueue
> > callback?  If we can't get an active ref then we presume that the fs is
> > already shutting down and don't send the event.
> 
> ...and now that I've actually tried it, I realize that we can't actually
> call get_active_super because it can sleep waiting for s_umount and
> SB_BORN.  Maybe we could directly atomic_inc_not_zero(&sb->s_active)
> adn trust that the caller has an active ref to the sb?  I think that's
> true for anyone calling __sb_error with a non-null inode.

Well, the side-effects of holding active sb reference from some workqueue
item tend to hit back occasionally (like when userspace assumes the device
isn't used anymore but it in fact still is because of the active
reference). Every time we tried something like this (last time it was with
iouring I believe) some user came back and complained his setup broke. In
this case it should be really rare but still I think it's better to avoid
it if we can (plus I'm not sure what you'd like to do for __sb_error()
callers that don't get the inode and thus active reference isn't really
guaranteed - they still need the protection against umount so that
handle_sb_error() can do the notifier callchain thing).

So I think a better solution might be that generic_shutdown_super() waits
for pending error notifications after clearing SB_ACTIVE before umount
proceeds further and __sb_error() just starts discarding new notifications
as soon as we see SB_ACTIVE is clear.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

