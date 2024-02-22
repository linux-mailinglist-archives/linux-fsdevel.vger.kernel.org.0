Return-Path: <linux-fsdevel+bounces-12443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AE985F663
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A613F287B5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 11:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57403FE2C;
	Thu, 22 Feb 2024 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TDUdQYpm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UHp0fn4H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TDUdQYpm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UHp0fn4H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88432182D2;
	Thu, 22 Feb 2024 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599709; cv=none; b=hKNXjB9ZVuyciq6fo71YNCVPxTE1w7tYgucbeXGyPCtlGq9/ZJj/jO8j6QBchhJCyYzpXQg5nRtyf6yGmU9jlR2TRerJjieOxwNQzXt/wXe0vx6xk/DSXJNcziFwXZ06O33c0/00kqebBjpHoJwbWOvyftVxcDCk2isZ9L5C9kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599709; c=relaxed/simple;
	bh=uypqJ4fFQ77C+nUKIm+0Q6hsjDxZIHQh+EoFhOxiisU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1WlnazthpxsqdlzI07J8FeoprafxAsekiYDhvS6L5N+XnV+d+OHY2OV84YWhcYDwa7qRT4ZaTpsgPuY9zNQOY3nN7C58Iu+ZunqlgwIJw6IfnJDXhgf8G0bwdGJTSN1xLJH4yAnJIwDlgmm0L3Sh5R4CRZPLUkbS/z6atlpRDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TDUdQYpm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UHp0fn4H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TDUdQYpm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UHp0fn4H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 620301FB9A;
	Thu, 22 Feb 2024 11:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708599703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=57n3UQkx8/XYTnaB10q60NOgFC3ggZDEpt6Gg1dxT1o=;
	b=TDUdQYpmzi2LnpQDGxgFVneXvhJPUrBy1zz7J4cI/HqcRStOy37Njl5UytajVBojefqVEc
	vMmWM9Vn3uy3A4chu1o0y2wI3hQ6IfUdGP97Ck6I+z8l4XxnlUg9IKBBkWD5NZe7KbaGpx
	P+p4LHlYh2vMZF59LhfFMxSmYlqT2XI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708599703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=57n3UQkx8/XYTnaB10q60NOgFC3ggZDEpt6Gg1dxT1o=;
	b=UHp0fn4Hfcs/SmbunYu7BfAuZ3N2FGlDCmXctHYuAGXnvbApAxULRsNgAmWe48PGYFs3kl
	L0nrxLNLlfFUuNDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708599703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=57n3UQkx8/XYTnaB10q60NOgFC3ggZDEpt6Gg1dxT1o=;
	b=TDUdQYpmzi2LnpQDGxgFVneXvhJPUrBy1zz7J4cI/HqcRStOy37Njl5UytajVBojefqVEc
	vMmWM9Vn3uy3A4chu1o0y2wI3hQ6IfUdGP97Ck6I+z8l4XxnlUg9IKBBkWD5NZe7KbaGpx
	P+p4LHlYh2vMZF59LhfFMxSmYlqT2XI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708599703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=57n3UQkx8/XYTnaB10q60NOgFC3ggZDEpt6Gg1dxT1o=;
	b=UHp0fn4Hfcs/SmbunYu7BfAuZ3N2FGlDCmXctHYuAGXnvbApAxULRsNgAmWe48PGYFs3kl
	L0nrxLNLlfFUuNDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5573B13419;
	Thu, 22 Feb 2024 11:01:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6IXYFJcp12XxNQAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 22 Feb 2024 11:01:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E8EB4A0807; Thu, 22 Feb 2024 12:01:38 +0100 (CET)
Date: Thu, 22 Feb 2024 12:01:38 +0100
From: Jan Kara <jack@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>,
	linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF TOPIC] statx extensions for subvol/snapshot
 filesystems & more
Message-ID: <20240222110138.ckai4sxiin3a74ku@quack3>
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
 <20240221210811.GA1161565@perftesting>
 <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
 <w534uujga5pqcbhbc5wad7bdt5lchxu6gcmwvkg6tdnkhnkujs@wjqrhv5uqxyx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w534uujga5pqcbhbc5wad7bdt5lchxu6gcmwvkg6tdnkhnkujs@wjqrhv5uqxyx>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu 22-02-24 04:42:07, Kent Overstreet wrote:
> On Thu, Feb 22, 2024 at 10:14:20AM +0100, Miklos Szeredi wrote:
> > On Wed, 21 Feb 2024 at 22:08, Josef Bacik <josef@toxicpanda.com> wrote:
> > >
> > > On Wed, Feb 21, 2024 at 04:06:34PM +0100, Miklos Szeredi wrote:
> > > > On Wed, 21 Feb 2024 at 01:51, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > > >
> > > > > Recently we had a pretty long discussion on statx extensions, which
> > > > > eventually got a bit offtopic but nevertheless hashed out all the major
> > > > > issues.
> > > > >
> > > > > To summarize:
> > > > >  - guaranteeing inode number uniqueness is becoming increasingly
> > > > >    infeasible, we need a bit to tell userspace "inode number is not
> > > > >    unique, use filehandle instead"
> > > >
> > > > This is a tough one.   POSIX says "The st_ino and st_dev fields taken
> > > > together uniquely identify the file within the system."
> > > >
> > >
> > > Which is what btrfs has done forever, and we've gotten yelled at forever for
> > > doing it.  We have a compromise and a way forward, but it's not a widely held
> > > view that changing st_dev to give uniqueness is an acceptable solution.  It may
> > > have been for overlayfs because you guys are already doing something special,
> > > but it's not an option that is afforded the rest of us.
> > 
> > Overlayfs tries hard not to use st_dev to give uniqueness and instead
> > partitions the 64bit st_ino space within the same st_dev.  There are
> > various fallback cases, some involve switching st_dev and some using
> > non-persistent st_ino.
> 
> Yeah no, you can't crap multiple 64 bit inode number spaces into 64
> bits: pigeonhole principle.
> 
> We need something better than "hacks".

I agree we should have a better long-term plan than finding ways how to
cram things into 64-bits inos. However I don't see a realistic short-term
solution other than that.

To explicit: Currently, tar and patch and very likely other less well-known
tools are broken on bcachefs due to non-unique inode numbers. If you want
ot fix them, either you find ways how bcachefs can cram things into 64-bit
ino_t or you go and modify these tools (or prod maintainers or whatever) to
not depend on ino_t for uniqueness. The application side of things isn't
going to magically fix itself by us telling "bad luck, ino_t isn't unique
anymore".

> > What overlayfs does may or may not be applicable to btrfs/bcachefs,
> > but that's not my point.  My point is that adding a flag to statx does
> > not solve anything.   You can't just say that from now on btrfs
> > doesn't have use unique st_ino/st_dev because we've just indicated
> > that in statx and everything is fine.   That will trigger the
> > no-regressions rule and then it's game over.  At least I would expect
> > that to happen.
> > 
> > What we can do instead is introduce a new API that is better,
> 
> This isn't a serious proposal.

I think for "unique inode identifier" we don't even have to come up with
new APIs. The file handle + fsid pair is an established way to do this,
fanotify successfully uses this as object identifier and Amir did quite
some work for this to be usable for vast majority of filesystems (including
virtual ones). The problem is with rewriting all these applications to use
it. If statx flag telling whether inode numbers are unique helps with that,
sure we can add it, but that seems like a trivial part of the problem.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

