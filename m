Return-Path: <linux-fsdevel+bounces-31442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101D9996D75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EC41F25A46
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75DA19CC34;
	Wed,  9 Oct 2024 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="crvdWXyh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fgp6lUcV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IARbM3ta";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QvcFD3FD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2B224DC;
	Wed,  9 Oct 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483502; cv=none; b=sNy0IA75XOTDorT9PljOWzKrztJP9wbiI1nW2o3w6OrG919qZ9Y1ckdiULXtvx0J9ww9GCJIkoM2mXJ83cddYeHvAXAU+Z3vilt0/rYcIpS5XWDgQE9bDa/XVYNH9f03qdj0rcg18SVsfOCB/7AkbgcpUlSnr/TooaEwMdhFv40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483502; c=relaxed/simple;
	bh=FRUgZ1z6/oVtTFBZDJTBIA3TctIjFzAKEl8fy4a2DVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9bFdEG+XNQAIpMtQR2JpZc2w+DwVPZlKebIo0ldI/qPQaREltjzt71nLTZMCBV/rHd5+ToDlMLDbVEzKLv0DqfWFo0YKIzeTFCDRUYTEvJDVZ/8sCSp+5qZ7WsWOJSnXE4vDabp0mt+/oYxe2NhH9BoTchR2Ajfdfw833o9qw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=crvdWXyh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fgp6lUcV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IARbM3ta; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QvcFD3FD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E33601F7C8;
	Wed,  9 Oct 2024 14:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728483498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6cQrJaOGp2rSSkyDZzchdcb/jjhQ7UZU+O1phg3BDo=;
	b=crvdWXyhpPAVd34KQtO/pP/iqGgjpYSE5Pi564gMS7pMwr63bs6A3cl6uqimnPL/koa9dU
	Op6w3UnWVSu68WXpcRWKsnYJEd3Twlu5rCG8TLYq6LHAczGZkKSM9BbCoRi0ESO/mU+8v4
	Rvil6MPr7ASqzFuuPb5g+VWy+KBnrXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728483498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6cQrJaOGp2rSSkyDZzchdcb/jjhQ7UZU+O1phg3BDo=;
	b=fgp6lUcV5xAVwRjpd6aYT6zmvTRVDaGAu5hZOXYslmiHq0J/3gmvKIW/JTuyMyXpS4CnhI
	2NWg4bp7BWfOsYAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728483497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6cQrJaOGp2rSSkyDZzchdcb/jjhQ7UZU+O1phg3BDo=;
	b=IARbM3taso3Mrd5eCQu3ZqjZzvP97dUoHrLNimC7jlKEmf9DW4u2YB6/DSBMIw2lq5grr3
	M6rlLW9xNP17/MO2/defdL4vBbDoCFfveIx62a+N1QJov4T4CkNty2IJR0H27Y/VePzytU
	LuRPspTT0Vtotj19+mXqocyUAc4khrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728483497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6cQrJaOGp2rSSkyDZzchdcb/jjhQ7UZU+O1phg3BDo=;
	b=QvcFD3FDsXEodY8jE64gI4IxSK8RxzEIky9uIbMkfl2Bo4j6627N0Y+IYCovlHYr+nbHKq
	YuCFH7suf2fqElAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8044136BA;
	Wed,  9 Oct 2024 14:18:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pAfMMKmQBmfjQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Oct 2024 14:18:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4FA05A0896; Wed,  9 Oct 2024 16:18:17 +0200 (CEST)
Date: Wed, 9 Oct 2024 16:18:17 +0200
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <20241009141817.uwh3xwkhpqmdxpv2@quack3>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
 <ZwRvshM65rxXTwxd@dread.disaster.area>
 <CAOQ4uxgzPM4e=Wc=UVe=rpuug=yaWwu5zEtLJmukJf6d7MUJow@mail.gmail.com>
 <20241008112344.mzi2qjpaszrkrsxg@quack3>
 <ZwXDzKGj6Bp28kYe@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwXDzKGj6Bp28kYe@dread.disaster.area>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,linux-foundation.org,infradead.org,vger.kernel.org,linux.dev,linux.microsoft.com,google.com,hallyn.com,chromium.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 09-10-24 10:44:12, Dave Chinner wrote:
> On Tue, Oct 08, 2024 at 01:23:44PM +0200, Jan Kara wrote:
> > On Tue 08-10-24 10:57:22, Amir Goldstein wrote:
> > > On Tue, Oct 8, 2024 at 1:33 AM Dave Chinner <david@fromorbit.com> wrote:
> > > >
> > > > On Mon, Oct 07, 2024 at 01:37:19PM -0700, Linus Torvalds wrote:
> > > > > On Thu, 3 Oct 2024 at 04:57, Jan Kara <jack@suse.cz> wrote:
> > > > > >
> > > > > > Fair enough. If we go with the iterator variant I've suggested to Dave in
> > > > > > [1], we could combine the evict_inodes(), fsnotify_unmount_inodes() and
> > > > > > Landlocks hook_sb_delete() into a single iteration relatively easily. But
> > > > > > I'd wait with that convertion until this series lands.
> > > > >
> > > > > Honza, I looked at this a bit more, particularly with an eye of "what
> > > > > happens if we just end up making the inode lifetimes subject to the
> > > > > dentry lifetimes" as suggested by Dave elsewhere.
> > > >
> > > > ....
> > > >
> > > > > which makes the fsnotify_inode_delete() happen when the inode is
> > > > > removed from the dentry.
> > > >
> > > > There may be other inode references being held that make
> > > > the inode live longer than the dentry cache. When should the
> > > > fsnotify marks be removed from the inode in that case? Do they need
> > > > to remain until, e.g, writeback completes?
> > > >
> > > 
> > > fsnotify inode marks remain until explicitly removed or until sb
> > > is unmounted (*), so other inode references are irrelevant to
> > > inode mark removal.
> > > 
> > > (*) fanotify has "evictable" inode marks, which do not hold inode
> > > reference and go away on inode evict, but those mark evictions
> > > do not generate any event (i.e. there is no FAN_UNMOUNT).
> > 
> > Yes. Amir beat me with the response so let me just add that FS_UMOUNT event
> > is for inotify which guarantees that either you get an event about somebody
> > unlinking the inode (e.g. IN_DELETE_SELF) or event about filesystem being
> > unmounted (IN_UMOUNT) if you place mark on some inode. I also don't see how
> > we would maintain this behavior with what Linus proposes.
> 
> Thanks. I didn't respond last night when I read Amir's decription
> because I wanted to think it over. Knowing where the unmount event
> requirement certainly helps.
> 
> I am probably missing something important, but it really seems to me
> that the object reference counting model is the back to
> front.  Currently the mark is being attached to the inode and then
> the inode pinned by a reference count to make the mark attached
> to the inode persistent until unmount. This then requires the inodes
> to be swept by unmount because fsnotify has effectively leaked them
> as it isn't tracking such inodes itself.
> 
> [ Keep in mind that I'm not saying this was a bad or wrong thing to
> do because the s_inodes list was there to be able to do this sort of
> lazy cleanup. But now that we want to remove the s_inodes list if at
> all possible, it is a problem we need to solve differently. ]

Yes, agreed.

> AFAICT, inotify does not appear to require the inode to send events
> - it only requires access to the inode mark itself. Hence it does
> not the inode in cache to generate IN_UNMOUNT events, it just
> needs the mark itself to be findable at unmount.  Do any of the
> other backends that require unmount notifications that require
> special access to the inode itself?

No, I don't think unmount notification requires looking at the inode and it
is inotify-specific thing as Amir wrote. We do require inode access when
generating fanotify events (to open fd where event happened) but that gets
handled separately by creating struct path when event happens and using it
for dentry_open() later when reporting to userspace so that carries its own
set on dentry + mnt references while the event is waiting in the queue.

> If not, and the fsnotify sb info is tracking these persistent marks,
> then we don't need to iterate inodes at unmount. This means we don't
> need to pin inodes when they have marks attached, and so the
> dependency on the s_inodes list goes away.
> 
> With this inverted model, we need the first fsnotify event callout
> after the inode is instantiated to look for a persistent mark for
> the inode. We know how to do this efficiently - it's exactly the
> same caching model we use for ACLs. On the first lookup, we check
> the inode for ACL data and set the ACL pointer appropriately to
> indicate that a lookup has been done and there are no ACLs
> associated with the inode.

Yes, I agree such scheme should be possible although a small snag I see is
that we need to keep in fsnotify mark enough info so that it can be
associated with an inode when it is read from the disk. And this info is
filesystem specific with uncertain size for filesystems which use iget5().
So I suspect we'll need some support from individual filesystems which is
always tedious.

> At this point, the fsnotify inode marks can all be removed from the
> inode when it is being evicted and there's no need for fsnotify to
> pin inodes at all.
> 
> > > > > Then at umount time, the dentry shrinking will deal with all live
> > > > > dentries, and at most the fsnotify layer would send the FS_UNMOUNT to
> > > > > just the root dentry inodes?
> > > >
> > > > I don't think even that is necessary, because
> > > > shrink_dcache_for_umount() drops the sb->s_root dentry after
> > > > trimming the dentry tree. Hence the dcache drop would cleanup all
> > > > inode references, roots included.
> > > >
> > > > > Wouldn't that make things much cleaner, and remove at least *one* odd
> > > > > use of the nasty s_inodes list?
> > > >
> > > > Yes, it would, but someone who knows exactly when the fsnotify
> > > > marks can be removed needs to chime in here...
> > 
> > So fsnotify needs a list of inodes for the superblock which have marks
> > attached and for which we hold inode reference. We can keep it inside
> > fsnotify code although it would practically mean another list_head for the
> > inode for this list (probably in our fsnotify_connector structure which
> > connects list of notification marks to the inode).
> 
> I don't think that is necessary. We need to get rid of the inode
> reference, not move where we track inode references. The persistent
> object is the fsnotify mark, not the cached inode. It's the mark
> that needs to be persistent, and that's what the fsnotify code
> should be tracking.

Right, I was not precise here. We don't need a list of tracked inodes. We
are fine with a list of all marks for inodes on a superblock which we could
crawl on umount.

> The fsnotify marks are much smaller than inodes, and there going to
> be fewer cached marks than inodes, especially once inode pinning is
> removed. Hence I think this will result in a net reduction in memory
> footprint for "marked-until-unmount" configurations as we won't pin
> nearly as many inodes in cache...

I agree. If fsnotify marks stop pinning inodes, we'll probably win much
more memory by keeping inodes reclaimable than we loose by extra overhead
of the mark tracking.

> > > > > And I wonder if the quota code (which uses the s_inodes list
> > > > > to enable quotas on already mounted filesystems) could for
> > > > > all the same reasons just walk the dentry tree instead (and
> > > > > remove_dquot_ref similarly could just remove it at
> > > > > dentry_unlink_inode() time)?
> > > >
> > > > I don't think that will work because we have to be able to
> > > > modify quota in evict() processing. This is especially true
> > > > for unlinked inodes being evicted from cache, but also the
> > > > dquots need to stay attached until writeback completes.
> > > >
> > > > Hence I don't think we can remove the quota refs from the
> > > > inode before we call iput_final(), and so I think quotaoff (at
> > > > least) still needs to iterate inodes...
> > 
> > Yeah, I'm not sure how to get rid of the s_inodes use in quota
> > code. One of the things we need s_inodes list for is during
> > quotaoff on a mounted filesystem when we need to iterate all
> > inodes which are referencing quota structures and free them.  In
> > theory we could keep a list of inodes referencing quota structures
> > but that would require adding list_head to inode structure for
> > filesystems that support quotas.
> 
> I don't think that's quite true. Quota is not modular, so we can
> lazily free quota objects even when quota is turned off. All we need
> to ensure is that code checks whether quota is enabled, not for the
> existence of quota objects attached to the inode.
> 
> Hence quota-off simply turns off all the quota operations in memory,
> and normal inode eviction cleans up the stale quota objects
> naturally.

Ho, hum, possibly yes. I need to think a bit more about this.

> My main question is why the quota-on add_dquot_ref() pass is
> required. AFAICT all of the filesystem operations that will modify
> quota call dquot_initialize() directly to attach the required dquots
> to the inode before the operation is started. If that's true, then
> why does quota-on need to do this for all the inodes that are
> already in cache?

This is again for handling quotaon on already mounted filesystem. We
initialize quotas for the inode when opening a file so if some files are
already open when we do quotaon, we want to attach quota structures to
these inodes. I think this was kind of important to limit mismatch between
real usage and accounted usage when old style quotas were used e.g. for
root filesystem but to be fair this code was there when I became quota
maintainer in 1999 and I never dared to remove it :)

> > Now for the sake of
> > full context I'll also say that enabling / disabling quotas on a mounted
> > filesystem is a legacy feature because it is quite easy that quota
> > accounting goes wrong with it. So ext4 and f2fs support for quite a few
> > years a mode where quota tracking is enabled on mount and disabled on
> > unmount (if appropriate fs feature is enabled) and you can only enable /
> > disable enforcement of quota limits during runtime.
> 
> Sure, this is how XFS works, too. But I think this behaviour is
> largely irrelevant because there are still filesystems out there
> that do stuff the old way...
> 
> > So I could see us
> > deprecating this functionality altogether although jfs never adapted to
> > this new way we do quotas so we'd have to deal with that somehow.  But one
> > way or another it would take a significant amount of time before we can
> > completely remove this so it is out of question for this series.
> 
> I'm not sure that matters, though it adds to the reasons why we
> should be removing old, unmaintained filesystems from the tree
> and old, outdated formats from maintained filesystems....

True.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

