Return-Path: <linux-fsdevel+bounces-31425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13A999653F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 11:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DD81F23597
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 09:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5765918FDAA;
	Wed,  9 Oct 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="t43BIip7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7018E03C
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465807; cv=none; b=uJa9Eyy92smw58nRJVClHkxXGeIU9InjpcQ+LYgpc0rkF3RxMPMoDiRWOrOgOXqZcoh4IhUuTZbjNQBaO2UK/u5CBRodWEGzFeQu5A+CpCyDt24roldHtToQoMJrkAF8Y8u45PtA3/EdLgpfah1hwEdgT0PA3N6dNabBsLsyc5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465807; c=relaxed/simple;
	bh=ONtueM1gqREWHqmOIvRzqtdC3Krgfse7HXNTxHKZ38M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=badWaIEi2SLEqYcvs+ypT3GbJI3mqHKvLrAIExloHPffkSb1Q3tdBar4V3pH4w54S/DkKt7b62aHnuhmAfv3OdNCU+/7RQoQAz5tQH9X9KQsJX/3C7LWK/G8AIifyE+cGCSbHdyqIFhJHi62a4lhxE/1WzpUIFZ+2Uc39srtZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=t43BIip7; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XNnVn5rf8zmZT;
	Wed,  9 Oct 2024 11:23:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728465793;
	bh=9XSgRXbHiCpJWmwmNiOoFAhALnNoTndsEpArLPQ0BE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t43BIip7VaLyq7+fs5XgJmklzq0feIE2XM2ftXWXeEE88/ACSDLS9RZ0ItFHZ0I8c
	 sbDuql08eOZ9rIXDneggHKjfl2H4Kd2gB4oUvsH+RVKDBRli0W5TEfM8DCHe+KnuWw
	 65T9TnC+2qlltFJEcyZeyEqha6Q57gQxHOUWPxn8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XNnVj2fnLzgMT;
	Wed,  9 Oct 2024 11:23:09 +0200 (CEST)
Date: Wed, 9 Oct 2024 11:23:06 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Dave Chinner <david@fromorbit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	kent.overstreet@linux.dev, Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>, 
	Kees Cook <keescook@chromium.org>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <20241009.ahqu6AeW3cow@digikod.net>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
 <ZwRvshM65rxXTwxd@dread.disaster.area>
 <CAHk-=wi5ZpW73nLn5h46Jxcng6wn_bCUxj6JjxyyEMAGzF5KZg@mail.gmail.com>
 <20241008.Pohc0dixeiZ8@digikod.net>
 <ZwXMdqxz5PWNjW3C@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwXMdqxz5PWNjW3C@dread.disaster.area>
X-Infomaniak-Routing: alpha

On Wed, Oct 09, 2024 at 11:21:10AM +1100, Dave Chinner wrote:
> On Tue, Oct 08, 2024 at 02:59:07PM +0200, Mickaël Salaün wrote:
> > On Mon, Oct 07, 2024 at 05:28:57PM -0700, Linus Torvalds wrote:
> > > On Mon, 7 Oct 2024 at 16:33, Dave Chinner <david@fromorbit.com> wrote:
> > > >
> > > > There may be other inode references being held that make
> > > > the inode live longer than the dentry cache. When should the
> > > > fsnotify marks be removed from the inode in that case? Do they need
> > > > to remain until, e.g, writeback completes?
> > > 
> > > Note that my idea is to just remove the fsnotify marks when the dentry
> > > discards the inode.
> > > 
> > > That means that yes, the inode may still have a lifetime after the
> > > dentry (because of other references, _or_ just because I_DONTCACHE
> > > isn't set and we keep caching the inode).
> > > 
> > > BUT - fsnotify won't care. There won't be any fsnotify marks on that
> > > inode any more, and without a dentry that points to it, there's no way
> > > to add such marks.
> > > 
> > > (A new dentry may be re-attached to such an inode, and then fsnotify
> > > could re-add new marks, but that doesn't change anything - the next
> > > time the dentry is detached, the marks would go away again).
> > > 
> > > And yes, this changes the timing on when fsnotify events happen, but
> > > what I'm actually hoping for is that Jan will agree that it doesn't
> > > actually matter semantically.
> > > 
> > > > > Then at umount time, the dentry shrinking will deal with all live
> > > > > dentries, and at most the fsnotify layer would send the FS_UNMOUNT to
> > > > > just the root dentry inodes?
> > > >
> > > > I don't think even that is necessary, because
> > > > shrink_dcache_for_umount() drops the sb->s_root dentry after
> > > > trimming the dentry tree. Hence the dcache drop would cleanup all
> > > > inode references, roots included.
> > > 
> > > Ahh - even better.
> > > 
> > > I didn't actually look very closely at the actual umount path, I was
> > > looking just at the fsnotify_inoderemove() place in
> > > dentry_unlink_inode() and went "couldn't we do _this_ instead?"
> > > 
> > > > > Wouldn't that make things much cleaner, and remove at least *one* odd
> > > > > use of the nasty s_inodes list?
> > > >
> > > > Yes, it would, but someone who knows exactly when the fsnotify
> > > > marks can be removed needs to chime in here...
> > > 
> > > Yup. Honza?
> > > 
> > > (Aside: I don't actually know if you prefer Jan or Honza, so I use
> > > both randomly and interchangeably?)
> > > 
> > > > > I have this feeling that maybe we can just remove the other users too
> > > > > using similar models. I think the LSM layer use (in landlock) is bogus
> > > > > for exactly the same reason - there's really no reason to keep things
> > > > > around for a random cached inode without a dentry.
> > > >
> > > > Perhaps, but I'm not sure what the landlock code is actually trying
> > > > to do.
> > 
> > In Landlock, inodes (see landlock_object) may be referenced by several
> > rulesets, either tied to a task's cred or a ruleset's file descriptor.
> > A ruleset may outlive its referenced inodes, and this should not block
> > related umounts.  security_sb_delete() is used to gracefully release
> > such references.
> 
> Ah, there's the problem. The ruleset is persistent, not the inode.
> Like fsnotify, the life cycle and reference counting is upside down.
> The inode should cache the ruleset rather than the ruleset pinning
> the inode.

A ruleset needs to takes a reference to the inode as for an opened file
and keep it "alive" as long as it may be re-used by user space (i.e. as
long as the superblock exists).  One of the goal of a ruleset is to
identify inodes as long as they are accessible.  When a sandboxed
process request to open a file, its sandbox's ruleset checks against the
referenced inodes (in a nutshell).

In practice, rulesets reference a set of struct landlock_object which
references an inode or not (if it vanished).  There is only one
landlock_object referenced per inode.  This makes it possible to have a
dynamic N:M mapping between rulesets and inodes which enables a ruleset
to be deleted before its referenced inodes, or the other way around.

> 
> See my reply to Jan about fsnotify.
> 
> > > Yeah, I wouldn't be surprised if it's just confused - it's very odd.
> > > 
> > > But I'd be perfectly happy just removing one use at a time - even if
> > > we keep the s_inodes list around because of other users, it would
> > > still be "one less thing".
> > > 
> > > > Hence, to me, the lifecycle and reference counting of inode related
> > > > objects in landlock doesn't seem quite right, and the use of the
> > > > security_sb_delete() callout appears to be papering over an internal
> > > > lifecycle issue.
> > > >
> > > > I'd love to get rid of it altogether.
> > 
> > I'm not sure to fully understand the implications for now, but it would
> > definitely be good to simplify this lifetime management.  The only
> > requirement for Landlock is that inodes references should live as long
> > as the related inodes are accessible by user space or already in use.
> > The sooner these references are removed from related ruleset, the
> > better.
> 
> I'm missing something.  Inodes are accessible to users even when
> they are not in cache - we just read them from disk and instantiate
> a new VFS inode.
> 
> So how do you attach the correct ruleset to a newly instantiated
> inode?

We can see a Landlock ruleset as a set of weakly opened files/inodes.  A
Landolck ruleset call iget() to keep the related VFS inodes alive, which
means that when user space opens a file pointing to the same inode, the
same VFS inode will be re-used and then we can match it against a ruleset.

> 
> i.e. If you can find the ruleset for any given inode that is brought
> into cache (e.g. opening an existing, uncached file), then why do
> you need to take inode references so they are never evicted?

A landlock_object only keep a reference to an inode, not to the rulesets
pointing to it:
* inode -> 1 landlock_object or NULL
* landlock_object -> 1 inode or NULL
* ruleset -> N landlock_object

There are mainly two different operations:
1. Match 1 inode against a set of N inode references (i.e. a ruleset).
2. Drop the references of N rulesets (in practice 1 intermediate
   landlock_object) pointing to 1 inode.

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

