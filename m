Return-Path: <linux-fsdevel+bounces-30343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE12C98A0E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A386C1F281C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 11:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB2018CC1E;
	Mon, 30 Sep 2024 11:34:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A613421105;
	Mon, 30 Sep 2024 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727696078; cv=none; b=CFVxYrCAmm6hk1CSBokoEVcQFbKe1NJ1f8U5KrswNtLLRblRsETQv801/72Jw6NbrK7RB7QLT2R58LC/pNAG4MGJWKBVE6JPSpVr+wEC4eCc24EvWYCyygm4ITFfUw4NCIUBVte1GpyKe84W3EW0ujzBgb2GeREr4kORLXzmdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727696078; c=relaxed/simple;
	bh=Xn9o2rWvm8T1dQ0ilcHMlrx7BBuJC4X4KJT0qGs/51I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZPb6k5PaCoxcinw88MlaqPBRZWjTTT28bfrzsod0PTDH/EshDU3wrH7qMmJ7k5OgZ3TSnsQs3uOWClvdG3XIE10tX69xVAmX/dfcjfpUtziN7VKQXl1bvCC7hyyLY6pih2tDIyO0o/LC8Eb6nCkd4DsGikwgFCUDvMmhJMOQUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E582E21A36;
	Mon, 30 Sep 2024 11:34:34 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D732A136CB;
	Mon, 30 Sep 2024 11:34:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zJt8NMqM+mYbVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Sep 2024 11:34:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6FF1CA0845; Mon, 30 Sep 2024 13:34:34 +0200 (CEST)
Date: Mon, 30 Sep 2024 13:34:34 +0200
From: Jan Kara <jack@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it, Ted Tso <tytso@mit.edu>,
	linux-ext4@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: don't set SB_RDONLY after filesystem errors
Message-ID: <20240930113434.hhkro4bofhvapwm7@quack3>
References: <20240805201241.27286-1-jack@suse.cz>
 <Zvp6L+oFnfASaoHl@t14s>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvp6L+oFnfASaoHl@t14s>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: E582E21A36
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Mon 30-09-24 12:15:11, Jan Stancek wrote:
> On Mon, Aug 05, 2024 at 10:12:41PM +0200, Jan Kara wrote:
> > When the filesystem is mounted with errors=remount-ro, we were setting
> > SB_RDONLY flag to stop all filesystem modifications. We knew this misses
> > proper locking (sb->s_umount) and does not go through proper filesystem
> > remount procedure but it has been the way this worked since early ext2
> > days and it was good enough for catastrophic situation damage
> > mitigation. Recently, syzbot has found a way (see link) to trigger
> > warnings in filesystem freezing because the code got confused by
> > SB_RDONLY changing under its hands. Since these days we set
> > EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
> > filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
> > stop doing that.
> > 
> > Link: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@google.com
> > Reported-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> > fs/ext4/super.c | 9 +++++----
> > 1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > Note that this patch introduces fstests failure with generic/459 test because
> > it assumes that either freezing succeeds or 'ro' is among mount options. But
> > we fail the freeze with EFSCORRUPTED. This needs fixing in the test but at this
> > point I'm not sure how exactly.
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index e72145c4ae5a..93c016b186c0 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -735,11 +735,12 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
> > 
> > 	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
> > 	/*
> > -	 * Make sure updated value of ->s_mount_flags will be visible before
> > -	 * ->s_flags update
> > +	 * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
> > +	 * modifications. We don't set SB_RDONLY because that requires
> > +	 * sb->s_umount semaphore and setting it without proper remount
> > +	 * procedure is confusing code such as freeze_super() leading to
> > +	 * deadlocks and other problems.
> > 	 */
> > -	smp_wmb();
> > -	sb->s_flags |= SB_RDONLY;
> 
> Hi,
> 
> shouldn't the SB_RDONLY still be set (in __ext4_remount()) for the case
> when user triggers the abort with mount(.., "abort")? Because now we seem
> to always hit the condition that returns EROFS to user-space.

Thanks for report! I agree returning EROFS from the mount although
'aborting' succeeded is confusing and is mostly an unintended side effect
that after aborting the fs further changes to mount state are forbidden but
the testcase additionally wants to remount the fs read-only.

I don't think forcibly setting SB_RDONLY in this case is good because it
would still bypass all VFS checks for read-only remount and thus possibly
causing undesirable surprises (similar to those d3476f3dad4a ("ext4: don't
set SB_RDONLY after filesystem errors") tried to fix). At this point I'm
undecided whether __ext4_remount() should just return success after
aborting the filesystem, ignoring all other mount options, or whether we
should follow more the old behavior where we still reflect other mount
options (mostly resulting in cleanup of lazy itable initialization thread,
mmpd thread and similar).  I'm more leaning towards option 1) but I could
be convinced otherwise. Ted, what do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

