Return-Path: <linux-fsdevel+bounces-31313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B399946BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 13:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EDF2869E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016F318CC13;
	Tue,  8 Oct 2024 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v+4e7ZpL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y+KXu5ot";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v+4e7ZpL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y+KXu5ot"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F81D0BAE;
	Tue,  8 Oct 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386629; cv=none; b=I0gp/kugT6YY9wq/jo+9NBMzxyPCiZuUq3x78AdPThLYNHLiIOM8M0qfinQJU+lb/31xWT3DQHTKGgUsDTGxwmfXbqhCZCqimD4fs48Nbo4G3IfKzhC7s6ODINYJoChhpMnKeuqZpFMT72UVdVFhltHbMzb+iwjx1DUUvnm0nrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386629; c=relaxed/simple;
	bh=hYdtROrYP/bEVNFJahX1QKAU4GyQcc9i+//1GTNu+0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eymJbbZpIsC1TKSoY5O2ThSE5Q2ps9iQ3FzQVp/xCc3c9UfSwq8AD+XJeaByWwN1uBUtHSLlEgYKEEXvad/kH0EkjiWuCRv69drqaJAuDQ8YpojJ+YHz5eVoaBx+fY0hUTTmHs5MZbGReT4zQO9c0X794qnqXQCxWXVny/DUA5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v+4e7ZpL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y+KXu5ot; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v+4e7ZpL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y+KXu5ot; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 339B821CE4;
	Tue,  8 Oct 2024 11:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728386625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXgVBUemQdrxxP01R5PokGPlWKDzV/xnrwqUaIFFHT8=;
	b=v+4e7ZpLfn+SyG6XIaZw/19TplVltpzFln/dMVAy3JJpiP0PKqyS5u1SmoIM9cR60jjXr9
	Sh3eqtOTMEJ9f9lgZ4Xxlb1xCOEtW7FNnQmWoS4P8/EOoJ9WUgbqaZAXIdVk3dvOwJWOEh
	Q+QIq1uCchuwMHOWc1ok8knmS+X5gwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728386625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXgVBUemQdrxxP01R5PokGPlWKDzV/xnrwqUaIFFHT8=;
	b=y+KXu5ot5dLsjkWuiEWG/lRb7Pech7RhVHcKhlwdfnNeEEN+PcFzWdRVPuYPIFRVIMQR3Q
	x83ya3j9umg5fyCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728386625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXgVBUemQdrxxP01R5PokGPlWKDzV/xnrwqUaIFFHT8=;
	b=v+4e7ZpLfn+SyG6XIaZw/19TplVltpzFln/dMVAy3JJpiP0PKqyS5u1SmoIM9cR60jjXr9
	Sh3eqtOTMEJ9f9lgZ4Xxlb1xCOEtW7FNnQmWoS4P8/EOoJ9WUgbqaZAXIdVk3dvOwJWOEh
	Q+QIq1uCchuwMHOWc1ok8knmS+X5gwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728386625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXgVBUemQdrxxP01R5PokGPlWKDzV/xnrwqUaIFFHT8=;
	b=y+KXu5ot5dLsjkWuiEWG/lRb7Pech7RhVHcKhlwdfnNeEEN+PcFzWdRVPuYPIFRVIMQR3Q
	x83ya3j9umg5fyCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 242611340C;
	Tue,  8 Oct 2024 11:23:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iW/NCEEWBWcGXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Oct 2024 11:23:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BC177A086F; Tue,  8 Oct 2024 13:23:44 +0200 (CEST)
Date: Tue, 8 Oct 2024 13:23:44 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <20241008112344.mzi2qjpaszrkrsxg@quack3>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
 <ZwRvshM65rxXTwxd@dread.disaster.area>
 <CAOQ4uxgzPM4e=Wc=UVe=rpuug=yaWwu5zEtLJmukJf6d7MUJow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgzPM4e=Wc=UVe=rpuug=yaWwu5zEtLJmukJf6d7MUJow@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 08-10-24 10:57:22, Amir Goldstein wrote:
> On Tue, Oct 8, 2024 at 1:33 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Oct 07, 2024 at 01:37:19PM -0700, Linus Torvalds wrote:
> > > On Thu, 3 Oct 2024 at 04:57, Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > Fair enough. If we go with the iterator variant I've suggested to Dave in
> > > > [1], we could combine the evict_inodes(), fsnotify_unmount_inodes() and
> > > > Landlocks hook_sb_delete() into a single iteration relatively easily. But
> > > > I'd wait with that convertion until this series lands.
> > >
> > > Honza, I looked at this a bit more, particularly with an eye of "what
> > > happens if we just end up making the inode lifetimes subject to the
> > > dentry lifetimes" as suggested by Dave elsewhere.
> >
> > ....
> >
> > > which makes the fsnotify_inode_delete() happen when the inode is
> > > removed from the dentry.
> >
> > There may be other inode references being held that make
> > the inode live longer than the dentry cache. When should the
> > fsnotify marks be removed from the inode in that case? Do they need
> > to remain until, e.g, writeback completes?
> >
> 
> fsnotify inode marks remain until explicitly removed or until sb
> is unmounted (*), so other inode references are irrelevant to
> inode mark removal.
> 
> (*) fanotify has "evictable" inode marks, which do not hold inode
> reference and go away on inode evict, but those mark evictions
> do not generate any event (i.e. there is no FAN_UNMOUNT).

Yes. Amir beat me with the response so let me just add that FS_UMOUNT event
is for inotify which guarantees that either you get an event about somebody
unlinking the inode (e.g. IN_DELETE_SELF) or event about filesystem being
unmounted (IN_UMOUNT) if you place mark on some inode. I also don't see how
we would maintain this behavior with what Linus proposes.

> > > Then at umount time, the dentry shrinking will deal with all live
> > > dentries, and at most the fsnotify layer would send the FS_UNMOUNT to
> > > just the root dentry inodes?
> >
> > I don't think even that is necessary, because
> > shrink_dcache_for_umount() drops the sb->s_root dentry after
> > trimming the dentry tree. Hence the dcache drop would cleanup all
> > inode references, roots included.
> >
> > > Wouldn't that make things much cleaner, and remove at least *one* odd
> > > use of the nasty s_inodes list?
> >
> > Yes, it would, but someone who knows exactly when the fsnotify
> > marks can be removed needs to chime in here...

So fsnotify needs a list of inodes for the superblock which have marks
attached and for which we hold inode reference. We can keep it inside
fsnotify code although it would practically mean another list_head for the
inode for this list (probably in our fsnotify_connector structure which
connects list of notification marks to the inode). If we actually get rid
of i_sb_list in struct inode, this will be a win for the overall system,
otherwise it is a net loss IMHO. So if we can figure out how to change
other s_inodes owners we can certainly do this fsnotify change.

> > > And I wonder if the quota code (which uses the s_inodes list to enable
> > > quotas on already mounted filesystems) could for all the same reasons
> > > just walk the dentry tree instead (and remove_dquot_ref similarly
> > > could just remove it at dentry_unlink_inode() time)?
> >
> > I don't think that will work because we have to be able to modify
> > quota in evict() processing. This is especially true for unlinked
> > inodes being evicted from cache, but also the dquots need to stay
> > attached until writeback completes.
> >
> > Hence I don't think we can remove the quota refs from the inode
> > before we call iput_final(), and so I think quotaoff (at least)
> > still needs to iterate inodes...

Yeah, I'm not sure how to get rid of the s_inodes use in quota code. One of
the things we need s_inodes list for is during quotaoff on a mounted
filesystem when we need to iterate all inodes which are referencing quota
structures and free them.  In theory we could keep a list of inodes
referencing quota structures but that would require adding list_head to
inode structure for filesystems that support quotas. Now for the sake of
full context I'll also say that enabling / disabling quotas on a mounted
filesystem is a legacy feature because it is quite easy that quota
accounting goes wrong with it. So ext4 and f2fs support for quite a few
years a mode where quota tracking is enabled on mount and disabled on
unmount (if appropriate fs feature is enabled) and you can only enable /
disable enforcement of quota limits during runtime.  So I could see us
deprecating this functionality altogether although jfs never adapted to
this new way we do quotas so we'd have to deal with that somehow.  But one
way or another it would take a significant amount of time before we can
completely remove this so it is out of question for this series.

I see one problem with the idea "whoever has a need to iterate inodes needs
to keep track of inodes it needs to iterate through". It is fine
conceptually but with s_inodes list we pay the cost only once and multiple
users benefit. With each subsystem tracking inodes we pay the cost for each
user (both in terms of memory and CPU). So if you don't use any of the
subsystems that need iteration, you win, but if you use two or more of
these subsystems, in particular those which need to track significant
portion of all inodes, you are losing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

