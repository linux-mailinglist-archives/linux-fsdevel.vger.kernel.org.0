Return-Path: <linux-fsdevel+bounces-12448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF185F760
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D321C211CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 11:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B6C45BEB;
	Thu, 22 Feb 2024 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GxRql0GQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eH+HrikD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GxRql0GQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eH+HrikD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4B6405CE;
	Thu, 22 Feb 2024 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602261; cv=none; b=h5d0F2v/IkJVcmiWLMHwb6cjQwxZ9ySN00uNSD70OWWDsCiMPrtBuZwbqCBH89e71zFjQV30cOWYzxXXdyuUbx6Bied6/48ZJDi6RWMaZoy6A+IcHFRXQrnrluZ8QvKc6fbYLZBg/dKJX2phK+SSUQ9Vn/3LbjUuJe5gVr19DSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602261; c=relaxed/simple;
	bh=60OEQh8O8xUBuyXADpm7mF+KjKWqxvHIH7CFVVDduFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cc5yFeCFIwem0EMX2fMitadI7STTPZ3x/X79pKdiUXUSwzFRwH2FP52nneK+mPmNA2SXUWis50oqPpwjK9VdaiEs+I8P75uZuIUjUfNOnFrge3N5Czx5PB5VoiSjthBEj4Ug1f54qqtq4X22K4qovW9kzEvSyF1R+v2XnlH4Ox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GxRql0GQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eH+HrikD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GxRql0GQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eH+HrikD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C3B071F457;
	Thu, 22 Feb 2024 11:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708602257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xoJ6ykOvvUooYrKIs+fFW78KArCQfq5m9jqujK8AT8E=;
	b=GxRql0GQN3kZ+yJ+otqo12KJcytm8iR3GDBEyzgH/ko4tHxaQGCUGGXUqHpLUKzFEy1V7F
	/qv0Sw/VxgIYENs8vjnDUV/6mcw9FJgE4s3W8bNvmz7NtnjS8tGsPXJafUHbjEJ9MwG1b+
	h22OkGgAV+Sa0O3vK38Dj6J3zlX5qFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708602257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xoJ6ykOvvUooYrKIs+fFW78KArCQfq5m9jqujK8AT8E=;
	b=eH+HrikD7HaZ+vBU6osfGw2xTbRl8qJjN94PyPQvhdYW1VVQDtatc5+v4cn1MiiP2d4s2p
	8DR+FtyyaSRulzBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708602257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xoJ6ykOvvUooYrKIs+fFW78KArCQfq5m9jqujK8AT8E=;
	b=GxRql0GQN3kZ+yJ+otqo12KJcytm8iR3GDBEyzgH/ko4tHxaQGCUGGXUqHpLUKzFEy1V7F
	/qv0Sw/VxgIYENs8vjnDUV/6mcw9FJgE4s3W8bNvmz7NtnjS8tGsPXJafUHbjEJ9MwG1b+
	h22OkGgAV+Sa0O3vK38Dj6J3zlX5qFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708602257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xoJ6ykOvvUooYrKIs+fFW78KArCQfq5m9jqujK8AT8E=;
	b=eH+HrikD7HaZ+vBU6osfGw2xTbRl8qJjN94PyPQvhdYW1VVQDtatc5+v4cn1MiiP2d4s2p
	8DR+FtyyaSRulzBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B8D0313A6B;
	Thu, 22 Feb 2024 11:44:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id jSIbLZEz12X9PgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 22 Feb 2024 11:44:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 62015A0807; Thu, 22 Feb 2024 12:44:17 +0100 (CET)
Date: Thu, 22 Feb 2024 12:44:17 +0100
From: Jan Kara <jack@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
	Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org, linux-btrfs@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF TOPIC] statx extensions for subvol/snapshot
 filesystems & more
Message-ID: <20240222114417.wpcdkgsed7wklv3h@quack3>
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
 <20240221210811.GA1161565@perftesting>
 <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
 <w534uujga5pqcbhbc5wad7bdt5lchxu6gcmwvkg6tdnkhnkujs@wjqrhv5uqxyx>
 <20240222110138.ckai4sxiin3a74ku@quack3>
 <u4btyvpsohnf77r5rm43tz426u3advjc4goea4obt2wtv6xyog@7bukhgoyumed>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u4btyvpsohnf77r5rm43tz426u3advjc4goea4obt2wtv6xyog@7bukhgoyumed>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Thu 22-02-24 06:27:14, Kent Overstreet wrote:
> On Thu, Feb 22, 2024 at 12:01:38PM +0100, Jan Kara wrote:
> > On Thu 22-02-24 04:42:07, Kent Overstreet wrote:
> > > On Thu, Feb 22, 2024 at 10:14:20AM +0100, Miklos Szeredi wrote:
> > > > On Wed, 21 Feb 2024 at 22:08, Josef Bacik <josef@toxicpanda.com> wrote:
> > > > >
> > > > > On Wed, Feb 21, 2024 at 04:06:34PM +0100, Miklos Szeredi wrote:
> > > > > > On Wed, 21 Feb 2024 at 01:51, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > > > > >
> > > > > > > Recently we had a pretty long discussion on statx extensions, which
> > > > > > > eventually got a bit offtopic but nevertheless hashed out all the major
> > > > > > > issues.
> > > > > > >
> > > > > > > To summarize:
> > > > > > >  - guaranteeing inode number uniqueness is becoming increasingly
> > > > > > >    infeasible, we need a bit to tell userspace "inode number is not
> > > > > > >    unique, use filehandle instead"
> > > > > >
> > > > > > This is a tough one.   POSIX says "The st_ino and st_dev fields taken
> > > > > > together uniquely identify the file within the system."
> > > > > >
> > > > >
> > > > > Which is what btrfs has done forever, and we've gotten yelled at forever for
> > > > > doing it.  We have a compromise and a way forward, but it's not a widely held
> > > > > view that changing st_dev to give uniqueness is an acceptable solution.  It may
> > > > > have been for overlayfs because you guys are already doing something special,
> > > > > but it's not an option that is afforded the rest of us.
> > > > 
> > > > Overlayfs tries hard not to use st_dev to give uniqueness and instead
> > > > partitions the 64bit st_ino space within the same st_dev.  There are
> > > > various fallback cases, some involve switching st_dev and some using
> > > > non-persistent st_ino.
> > > 
> > > Yeah no, you can't crap multiple 64 bit inode number spaces into 64
> > > bits: pigeonhole principle.
> > > 
> > > We need something better than "hacks".
> > 
> > I agree we should have a better long-term plan than finding ways how to
> > cram things into 64-bits inos. However I don't see a realistic short-term
> > solution other than that.
> > 
> > To explicit: Currently, tar and patch and very likely other less well-known
> > tools are broken on bcachefs due to non-unique inode numbers. If you want
> > ot fix them, either you find ways how bcachefs can cram things into 64-bit
> > ino_t or you go and modify these tools (or prod maintainers or whatever) to
> > not depend on ino_t for uniqueness. The application side of things isn't
> > going to magically fix itself by us telling "bad luck, ino_t isn't unique
> > anymore".
> 
> My intent is to make a real effort towards getting better interfaces
> going, prod those maintainers, _then_ look at adding those hacks (that
> will necessarily be short term solutions since 64 bits is already
> looking cramped).

OK, fine by me :) So one thing is still not quite clear to me - how do you
expect the INO_NOT_UNIQUE flag to be used by these apps? Do you expect them
to use st_dev + st_ino by default and fall back to fsid + fhandle only when
INO_NOT_UNIQUE is set?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

