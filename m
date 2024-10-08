Return-Path: <linux-fsdevel+bounces-31337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 389BC994CEE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 15:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5952C1C2517A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 13:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B7E1DF26D;
	Tue,  8 Oct 2024 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="pEre8go+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8931DED6F;
	Tue,  8 Oct 2024 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392358; cv=none; b=fvDhCTXfuVIWYXlr9k1G8Oa3kCVhioP3saNi20HCs5RmDEeoLOaBKVpnRHvmnb+OiX/5hOIgCTEJYUIm/Kj8WZ1KSlSDRI3htHxDjAvShebuHapGkPok2xBg37mDZh2YimxxQAoa9SG1P9V3mXBcG2gb152M6V4uITEoFVPax5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392358; c=relaxed/simple;
	bh=XEQ84zSaVaFCcNhIzuJn6oUzj6Js6KHVuGb3P1chFyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfukeAsOMhz+JDGiSw/GRCnLLlBNZFAyrxEA4YBGz5NgE8SPfwTfDjzSmTig27CiiG/Umyec+7CheO/3c49MicAoQmW9bFoeIxDXuvLuAl2qHJwcTnFWte6WhvVOPJyTtkXr/jS0DNleCQI2vaXx/90iKUNnXFhP2AYSbbNL9ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=pEre8go+; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XNGLS0FSsz4X7;
	Tue,  8 Oct 2024 14:59:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728392351;
	bh=lubKm596ajxruAowyOac0GqBl8F51f/htwsSzeT4WHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEre8go+mybnR8ts9txJRzOFe7SezCcGaT0Pca6Uro5RQz3NmFZstJNFsr1yAZiiD
	 zdu4NDVN38vP5KFqwymW4L2skhrA9eQN1UkeP547Rfi34OyNw8IjMTzk9AU7SX3sMN
	 p05+vrFJtJvzdlox7dQDOowI6oDXivNjkPFjhy7U=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XNGLQ6mfKzMvr;
	Tue,  8 Oct 2024 14:59:10 +0200 (CEST)
Date: Tue, 8 Oct 2024 14:59:07 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev, Jann Horn <jannh@google.com>, 
	Serge Hallyn <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <20241008.Pohc0dixeiZ8@digikod.net>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
 <ZwRvshM65rxXTwxd@dread.disaster.area>
 <CAHk-=wi5ZpW73nLn5h46Jxcng6wn_bCUxj6JjxyyEMAGzF5KZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi5ZpW73nLn5h46Jxcng6wn_bCUxj6JjxyyEMAGzF5KZg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Oct 07, 2024 at 05:28:57PM -0700, Linus Torvalds wrote:
> On Mon, 7 Oct 2024 at 16:33, Dave Chinner <david@fromorbit.com> wrote:
> >
> > There may be other inode references being held that make
> > the inode live longer than the dentry cache. When should the
> > fsnotify marks be removed from the inode in that case? Do they need
> > to remain until, e.g, writeback completes?
> 
> Note that my idea is to just remove the fsnotify marks when the dentry
> discards the inode.
> 
> That means that yes, the inode may still have a lifetime after the
> dentry (because of other references, _or_ just because I_DONTCACHE
> isn't set and we keep caching the inode).
> 
> BUT - fsnotify won't care. There won't be any fsnotify marks on that
> inode any more, and without a dentry that points to it, there's no way
> to add such marks.
> 
> (A new dentry may be re-attached to such an inode, and then fsnotify
> could re-add new marks, but that doesn't change anything - the next
> time the dentry is detached, the marks would go away again).
> 
> And yes, this changes the timing on when fsnotify events happen, but
> what I'm actually hoping for is that Jan will agree that it doesn't
> actually matter semantically.
> 
> > > Then at umount time, the dentry shrinking will deal with all live
> > > dentries, and at most the fsnotify layer would send the FS_UNMOUNT to
> > > just the root dentry inodes?
> >
> > I don't think even that is necessary, because
> > shrink_dcache_for_umount() drops the sb->s_root dentry after
> > trimming the dentry tree. Hence the dcache drop would cleanup all
> > inode references, roots included.
> 
> Ahh - even better.
> 
> I didn't actually look very closely at the actual umount path, I was
> looking just at the fsnotify_inoderemove() place in
> dentry_unlink_inode() and went "couldn't we do _this_ instead?"
> 
> > > Wouldn't that make things much cleaner, and remove at least *one* odd
> > > use of the nasty s_inodes list?
> >
> > Yes, it would, but someone who knows exactly when the fsnotify
> > marks can be removed needs to chime in here...
> 
> Yup. Honza?
> 
> (Aside: I don't actually know if you prefer Jan or Honza, so I use
> both randomly and interchangeably?)
> 
> > > I have this feeling that maybe we can just remove the other users too
> > > using similar models. I think the LSM layer use (in landlock) is bogus
> > > for exactly the same reason - there's really no reason to keep things
> > > around for a random cached inode without a dentry.
> >
> > Perhaps, but I'm not sure what the landlock code is actually trying
> > to do.

In Landlock, inodes (see landlock_object) may be referenced by several
rulesets, either tied to a task's cred or a ruleset's file descriptor.
A ruleset may outlive its referenced inodes, and this should not block
related umounts.  security_sb_delete() is used to gracefully release
such references.

> 
> Yeah, I wouldn't be surprised if it's just confused - it's very odd.
> 
> But I'd be perfectly happy just removing one use at a time - even if
> we keep the s_inodes list around because of other users, it would
> still be "one less thing".
> 
> > Hence, to me, the lifecycle and reference counting of inode related
> > objects in landlock doesn't seem quite right, and the use of the
> > security_sb_delete() callout appears to be papering over an internal
> > lifecycle issue.
> >
> > I'd love to get rid of it altogether.

I'm not sure to fully understand the implications for now, but it would
definitely be good to simplify this lifetime management.  The only
requirement for Landlock is that inodes references should live as long
as the related inodes are accessible by user space or already in use.
The sooner these references are removed from related ruleset, the
better.

> 
> Yeah, I think the inode lifetime is just so random these days that
> anything that depends on it is questionable.
> 
> The quota case is probably the only thing where the inode lifetime
> *really* makes sense, and that's the one where I looked at the code
> and went "I *hope* this can be converted to traversing the dentry
> tree", but at the same time it did look sensible to make it be about
> inodes.
> 
> If we can convert the quota side to be based on dentry lifetimes, it
> will almost certainly then have to react to the places that do
> "d_add()" when re-connecting an inode to a dentry at lookup time.
> 
> So yeah, the quota code looks worse, but even if we could just remove
> fsnotify and landlock, I'd still be much happier.
> 
>              Linus

