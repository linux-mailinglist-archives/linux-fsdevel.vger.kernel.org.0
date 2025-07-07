Return-Path: <linux-fsdevel+bounces-54078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336FDAFB127
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBC117F339
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D99288CAA;
	Mon,  7 Jul 2025 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hJX3sVfU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ot91G42S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hJX3sVfU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ot91G42S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E949B1DE8BB
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751883966; cv=none; b=dVPUe34WIFAwjjUTi173WsWLsQqtzfeOy1dZd7RaylOwxIhCQWd4oHKVsErP3G0TDipVmM8aPfdnPnsl+y/82NR2J5Xz7dDx3lM4tpxorl9MA+6nHsEjnOlklNrL73Y7+HZS7TGEoJ83p0iWoR+4ICWsGBl7WrspsNqI+P7keek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751883966; c=relaxed/simple;
	bh=ZzD4cbLdVVYO7LbV+CmWKkPxZKk2dAQ4dZVdXFGSvZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzYFeHSbf4Tktc5EKCvCuYExSktCjIlTldbS5sAnEBVVuTKh1sByVghvD2911lM2RAUFXgbFpFSyj66cT2F2UH5mS7gJhOJkcBZdOa9P/FODNqnxhgK7Khpmq7Koo2XmRnyQULlugkahWDBnq5bP0QZDeZdULXv+m/14ajbUzPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hJX3sVfU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ot91G42S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hJX3sVfU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ot91G42S; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DDEA31F393;
	Mon,  7 Jul 2025 10:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751883961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vq7gfA2e2D8LabcfAA4PNqsBwgfEQmhgsPG+gdPBLQs=;
	b=hJX3sVfUkAiRh81cUhA/zTdw/SALq/ytcC/F+MTMXmG5BgsVVEmSXiHNV6WEXruBFzBafF
	gKEob0ntZUKlDe15msTWUbcMVbbprfI8/oXsMwNrXqsVI7/ogTvVoH0dUXzIwfATk4VfhG
	id2pJyPPCItb/PvJxVnCvY5bjQMO4Mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751883961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vq7gfA2e2D8LabcfAA4PNqsBwgfEQmhgsPG+gdPBLQs=;
	b=Ot91G42ST8l1ZnmtwS1sFV3pF46pDOS/MMWfudoaXvu4Kpr79X08q3yu/pWw5rm4Wce0SB
	zQ6cYzeCE7Ld/1Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751883961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vq7gfA2e2D8LabcfAA4PNqsBwgfEQmhgsPG+gdPBLQs=;
	b=hJX3sVfUkAiRh81cUhA/zTdw/SALq/ytcC/F+MTMXmG5BgsVVEmSXiHNV6WEXruBFzBafF
	gKEob0ntZUKlDe15msTWUbcMVbbprfI8/oXsMwNrXqsVI7/ogTvVoH0dUXzIwfATk4VfhG
	id2pJyPPCItb/PvJxVnCvY5bjQMO4Mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751883961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vq7gfA2e2D8LabcfAA4PNqsBwgfEQmhgsPG+gdPBLQs=;
	b=Ot91G42ST8l1ZnmtwS1sFV3pF46pDOS/MMWfudoaXvu4Kpr79X08q3yu/pWw5rm4Wce0SB
	zQ6cYzeCE7Ld/1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CED3813757;
	Mon,  7 Jul 2025 10:26:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F553Mrmga2h8XAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Jul 2025 10:26:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7F6E6A0990; Mon,  7 Jul 2025 12:26:01 +0200 (CEST)
Date: Mon, 7 Jul 2025 12:26:01 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] MNT_WRITE_HOLD mess
Message-ID: <svxxqv4s7zmwnbzjssuspozpz4bmgpsikcdoxiio6lcx54bs2g@f6sclsrjp4jp>
References: <20250704194414.GR1880847@ZenIV>
 <CAHk-=wgurLEukSdbUPk28rW=hsVGMxE4zDOCZ3xxY3ee3oGyoQ@mail.gmail.com>
 <20250704202337.GT1880847@ZenIV>
 <20250705000114.GU1880847@ZenIV>
 <20250705185359.GZ1880847@ZenIV>
 <20250705232621.GA1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705232621.GA1880847@ZenIV>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Sun 06-07-25 00:26:21, Al Viro wrote:
> On Sat, Jul 05, 2025 at 07:53:59PM +0100, Al Viro wrote:
> > On Sat, Jul 05, 2025 at 01:01:14AM +0100, Al Viro wrote:
> > 
> > > FWIW, several observations around that thing:
> > > 	* mnt_get_write_access(), vfs_create_mount() and clone_mnt()
> > > definitely do not need to touch the seqcount component of mount_lock.
> > > read_seqlock_excl() is enough there.
> > > 	* AFAICS, the same goes for sb_prepare_remount_readonly(),
> > > do_remount() and do_reconfigure_mnt() - no point bumping the seqcount
> > > side of mount_lock there; only spinlock is needed.
> > > 	* failure exit in mount_setattr_prepare() needs only clearing the
> > > bit; smp_wmb() is pointless there (especially done for each mount involved).
> > 
> > The following appears to work; writing docs now...
> 
> 	More fun questions in the area: is there any reason we have mnt_want_write()
> doing
> int mnt_want_write(struct vfsmount *m)
> {
>         int ret;
> 
>         sb_start_write(m->mnt_sb);
>         ret = mnt_get_write_access(m);
>         if (ret)
>                 sb_end_write(m->mnt_sb);
>         return ret;
> }
> rather than
> int mnt_want_write(struct vfsmount *m)
> {
>         int ret = mnt_get_write_access(m);
> 	if (!ret)
> 		sb_start_write(m->mnt_sb);
>         return ret;
> }
> 
> 	Note that mnt_want_write_file() on e.g. a regular file opened
> for write will have sb_start_write() done with mnt_get_write_access()
> already in place since open(2).  So the nesting shouldn't be an issue
> here...  The same order (mount then superblock) is used for overlayfs
> copyup, for that matter.
> 
> 	So if it's a matter of waiting for thaw with mount write
> count already incremented, simple echo foo > pathname would already
> demonstrate the same, no matter of which order mnt_want_write() uses.
> What am I missing there?
> 
> 	IIRC, that was Jan's stuff... <checks git log> yep - eb04c28288bb
> "fs: Add freezing handling to mnt_want_write() / mnt_drop_write()" is
> where it came from...

I was thinking about this for some time. I think it was just a pure caution
to hold as few resources as possible when waiting for fs to thaw - in
particular I think I wanted to avoid returning EBUSY when remounting
mountpoint of a frozen fs just because there's somebody blocked in
mnt_want_write() waiting for fs to thaw. And yes, when there's file open
for writing, we will wait for fs to thaw with write count elevated but in
that case EBUSY from remount is kind of expected outcome anyway. I was more
concerned about cases like mkdir etc. So overall I wouldn't say there's a
strong reason for the ordering I've chosen, it just seemed a bit more user
friendly.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

